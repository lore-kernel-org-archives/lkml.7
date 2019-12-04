Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA0DC0044D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABB02084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfLDHyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56164 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLDHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPU4-0004Wj-9y; Wed, 04 Dec 2019 08:54:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0F4A61C264E;
        Wed,  4 Dec 2019 08:53:55 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:54 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf stat: Use affinity for closing file descriptors
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121001522.180827-8-andi@firstfloor.org>
References: <20191121001522.180827-8-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157544603496.21853.11719709502886116989.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     7736627b865defff2430e95df235b4aa2450bc37
Gitweb:        https://git.kernel.org/tip/7736627b865defff2430e95df235b4aa2450bc37
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Wed, 20 Nov 2019 16:15:17 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 29 Nov 2019 12:20:45 -03:00

perf stat: Use affinity for closing file descriptors

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
index dae6e84..2e8d38a 100644
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
