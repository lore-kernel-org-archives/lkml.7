Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCBC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8920803
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381396;
	bh=pLgOWVZBZgZugcj+aiRpf+WnBp/1XUSfPXe88YCTmns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x8ZFH0BWsfvqMSgQ3a/CeNAd6lXe+0LihluzhW2z8w6LHHsCD4kxL4Lz3qGl+fNCP
	 gTC4bNjIZUXPyJHr7usABhYQgDHTOzGat7b23WAnjUyc4a9fduXootBkYntKfcmK1x
	 nnOPfrzp9rSPvcjxxIl4Mx5ptbxn1mmtXBgYTtlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfLCN4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfLCN43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:56:29 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57A5520848;
        Tue,  3 Dec 2019 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381388;
        bh=pLgOWVZBZgZugcj+aiRpf+WnBp/1XUSfPXe88YCTmns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aYIDLa2xc8kShYNslxg6XJa8JZ48lobLS8QjYxgGGDwHd9tr6i8txKDdY8PGNZdbO
         eS4Xv2c+M3n92bAhT2iO9Uor2Wm2+n45/104bE1mnmqQDXM+x+QyEv4iH7q5mhZiQM
         Sy78WX6QHIUwde2H6jYHdjFwZcP3gf40eGeKg3RM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/23] perf stat: Use affinity for closing file descriptors
Date:   Tue,  3 Dec 2019 10:55:48 -0300
Message-Id: <20191203135606.24902-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Closing a perf fd can also trigger an IPI to the target CPU.

Use the same affinity technique as we use for reading/enabling events to
closing to optimize the CPU transitions.

Before on a large test case with 94 CPUs:

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
   32.56    3.085463          50     61483           close

  After:

   10.54    0.735704          11     61485           close

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-8-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index dae6e846b2f8..2e8d38a324be 100644
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
+	evlist__for_each_cpu(evlist, i, cpu) {
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
2.21.0

