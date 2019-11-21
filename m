Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81B4C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE7E2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfKUAPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:15:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:58451 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfKUAPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:15:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 16:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="381553876"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga005.jf.intel.com with ESMTP; 20 Nov 2019 16:15:34 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A42E8300D85; Wed, 20 Nov 2019 16:15:34 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 07/12] perf stat: Use affinity for closing file descriptors
Date:   Wed, 20 Nov 2019 16:15:17 -0800
Message-Id: <20191121001522.180827-8-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121001522.180827-1-andi@firstfloor.org>
References: <20191121001522.180827-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Closing a perf fd can also trigger an IPI to the target CPU.
Use the same affinity technique as we use for reading/enabling events
to closing to optimize the CPU transitions.

Before on a large test case with 94 CPUs:

% time     seconds  usecs/call     calls    errors syscall
------ ----------- ----------- --------- --------- ----------------
 32.56    3.085463          50     61483           close

After:

 10.54    0.735704          11     61485           close

Signed-off-by: Andi Kleen <ak@linux.intel.com>

---

v2: Use new iterator macros
v3: Use new iterator macros
Add missing affinity__cleanup
v4:
Update iterators again
v5:
Add comments
---
 tools/perf/util/evlist.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dae6e846b2f8..7db49a0a0350 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -18,6 +18,7 @@
 #include "debug.h"
 #include "units.h"
 #include <internal/lib.h> // page_size
+#include "affinity.h"
 #include "../perf.h"
 #include "asm/bug.h"
 #include "bpf-event.h"
@@ -1169,9 +1170,35 @@ void perf_evlist__set_selected(struct evlist *evlist,
 void evlist__close(struct evlist *evlist)
 {
 	struct evsel *evsel;
+	struct affinity affinity;
+	int cpu, i;
 
-	evlist__for_each_entry_reverse(evlist, evsel)
-		evsel__close(evsel);
+	/*
+	 * With perf record core.cpus is usually NULL.
+	 * Use the old method to handle this for now.
+	 */
+	if (!evlist->core.cpus) {
+		evlist__for_each_entry_reverse(evlist, evsel)
+			evsel__close(evsel);
+		return;
+	}
+
+	if (affinity__setup(&affinity) < 0)
+		return;
+	evlist__for_each_cpu (evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry_reverse(evlist, evsel) {
+			if (evsel__cpu_iter_skip(evsel, cpu))
+			    continue;
+			perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
+	evlist__for_each_entry_reverse(evlist, evsel) {
+		perf_evsel__free_fd(&evsel->core);
+		perf_evsel__free_id(&evsel->core);
+	}
 }
 
 static int perf_evlist__create_syswide_maps(struct evlist *evlist)
-- 
2.23.0

