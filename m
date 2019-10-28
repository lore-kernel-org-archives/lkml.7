Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE652CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B660E21734
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389541AbfJ1MoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:44:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44662 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbfJ1Mnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:43:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iP4Mg-0002Lk-Qe; Mon, 28 Oct 2019 13:43:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6BFAC1C047C;
        Mon, 28 Oct 2019 13:43:18 +0100 (CET)
Date:   Mon, 28 Oct 2019 12:43:18 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Optimize perf_init_event()
Cc:     Andi Kleen <andi@firstfloor.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Kan <kan.liang@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157226659819.29376.10779332665046803611.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     66d258c5b048840991de49697264af75f5b09def
Gitweb:        https://git.kernel.org/tip/66d258c5b048840991de49697264af75f5b09def
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 17 Oct 2019 20:31:03 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 28 Oct 2019 12:51:02 +01:00

perf/core: Optimize perf_init_event()

Andi reported that he was hitting the linear search in
perf_init_event() a lot. Make more agressive use of the IDR lookup to
avoid hitting the linear search.

With exception of PERF_TYPE_SOFTWARE (which relies on a hideous hack),
we can put everything in the IDR. On top of that, we can alias
TYPE_HARDWARE and TYPE_HW_CACHE to TYPE_RAW on the lookup side.

This greatly reduces the chances of hitting the linear search.

Reported-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan <kan.liang@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ea70ca6..4d67c5d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10080,7 +10080,7 @@ static struct lock_class_key cpuctx_lock;
 
 int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 {
-	int cpu, ret;
+	int cpu, ret, max = PERF_TYPE_MAX;
 
 	mutex_lock(&pmus_lock);
 	ret = -ENOMEM;
@@ -10093,12 +10093,17 @@ int perf_pmu_register(struct pmu *pmu, const char *name, int type)
 		goto skip_type;
 	pmu->name = name;
 
-	if (type < 0) {
-		type = idr_alloc(&pmu_idr, pmu, PERF_TYPE_MAX, 0, GFP_KERNEL);
-		if (type < 0) {
-			ret = type;
+	if (type != PERF_TYPE_SOFTWARE) {
+		if (type >= 0)
+			max = type;
+
+		ret = idr_alloc(&pmu_idr, pmu, max, 0, GFP_KERNEL);
+		if (ret < 0)
 			goto free_pdc;
-		}
+
+		WARN_ON(type >= 0 && ret != type);
+
+		type = ret;
 	}
 	pmu->type = type;
 
@@ -10188,7 +10193,7 @@ free_dev:
 	put_device(pmu->dev);
 
 free_idr:
-	if (pmu->type >= PERF_TYPE_MAX)
+	if (pmu->type != PERF_TYPE_SOFTWARE)
 		idr_remove(&pmu_idr, pmu->type);
 
 free_pdc:
@@ -10210,7 +10215,7 @@ void perf_pmu_unregister(struct pmu *pmu)
 	synchronize_rcu();
 
 	free_percpu(pmu->pmu_disable_count);
-	if (pmu->type >= PERF_TYPE_MAX)
+	if (pmu->type != PERF_TYPE_SOFTWARE)
 		idr_remove(&pmu_idr, pmu->type);
 	if (pmu_bus_running) {
 		if (pmu->nr_addr_filters)
@@ -10280,9 +10285,8 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 
 static struct pmu *perf_init_event(struct perf_event *event)
 {
+	int idx, type, ret;
 	struct pmu *pmu;
-	int idx;
-	int ret;
 
 	idx = srcu_read_lock(&pmus_srcu);
 
@@ -10295,12 +10299,27 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	}
 
 	rcu_read_lock();
-	pmu = idr_find(&pmu_idr, event->attr.type);
+	/*
+	 * PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+	 * are often aliases for PERF_TYPE_RAW.
+	 */
+	type = event->attr.type;
+	if (type == PERF_TYPE_HARDWARE || type == PERF_TYPE_HW_CACHE)
+		type = PERF_TYPE_RAW;
+
+again:
+	pmu = idr_find(&pmu_idr, type);
 	rcu_read_unlock();
 	if (pmu) {
 		ret = perf_try_init_event(pmu, event);
+		if (ret == -ENOENT && event->attr.type != type) {
+			type = event->attr.type;
+			goto again;
+		}
+
 		if (ret)
 			pmu = ERR_PTR(ret);
+
 		goto unlock;
 	}
 
