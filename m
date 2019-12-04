Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFFCC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AE62084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfLDHyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56123 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfLDHyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:05 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTx-0004UW-NE; Wed, 04 Dec 2019 08:53:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 286CC1C264A;
        Wed,  4 Dec 2019 08:53:54 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:54 -0000
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf stat: Use affinity for enabling/disabling events
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121001522.180827-13-andi@firstfloor.org>
References: <20191121001522.180827-13-andi@firstfloor.org>
MIME-Version: 1.0
Message-ID: <157544603406.21853.4873090291378641316.tip-bot2@tip-bot2>
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

Commit-ID:     704e2f5b700da4c912635cf161c3e982737eb89e
Gitweb:        https://git.kernel.org/tip/704e2f5b700da4c912635cf161c3e982737eb89e
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Wed, 20 Nov 2019 16:15:22 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 29 Nov 2019 12:20:45 -03:00

perf stat: Use affinity for enabling/disabling events

Restructure event enabling/disabling to use affinity, which
minimizes the number of IPIs needed.

Before on a large test case with 94 CPUs:

  % time     seconds  usecs/call     calls    errors syscall
  ------ ----------- ----------- --------- --------- ----------------
   54.65    1.899986          22     84812       660 ioctl

after:

   39.21    0.930451          10     84796       644 ioctl

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-13-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 40 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 096a4ea..1548237 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -378,11 +378,28 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
 void evlist__disable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
+
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	evlist__for_each_cpu(evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
 
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__cpu_iter_skip(pos, cpu))
+				continue;
+			if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__disable_cpu(pos, pos->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
-		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->core.fd)
+		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__disable(pos);
+		pos->disabled = true;
 	}
 
 	evlist->enabled = false;
@@ -391,11 +408,28 @@ void evlist__disable(struct evlist *evlist)
 void evlist__enable(struct evlist *evlist)
 {
 	struct evsel *pos;
+	struct affinity affinity;
+	int cpu, i;
 
+	if (affinity__setup(&affinity) < 0)
+		return;
+
+	evlist__for_each_cpu(evlist, i, cpu) {
+		affinity__set(&affinity, cpu);
+
+		evlist__for_each_entry(evlist, pos) {
+			if (evsel__cpu_iter_skip(pos, cpu))
+				continue;
+			if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
+				continue;
+			evsel__enable_cpu(pos, pos->cpu_iter - 1);
+		}
+	}
+	affinity__cleanup(&affinity);
 	evlist__for_each_entry(evlist, pos) {
 		if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
 			continue;
-		evsel__enable(pos);
+		pos->disabled = false;
 	}
 
 	evlist->enabled = true;
