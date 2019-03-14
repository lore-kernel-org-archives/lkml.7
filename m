Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FEBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 473022184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GhZp5yCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCNNLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:11:47 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfCNNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fOAFlNMlz77NK8JPXrRkAsVXU6suD8J7n73rfwh8DRA=; b=GhZp5yCvQDi9QtRQMhqEO9axAF
        ltoR5QwCLHtQsd0gtQMlnmV9TVc+Oyc+jAbOKIQ5tZne1/Q6RJpuviiogTA7iS9HDzwnFr6idwFCx
        BLAgSBxe/hTFq0OFEciIoPSffkirrAd8uzoHtZY+ydwRty3sTJ6bhusXn+4SDOkz5P8tbGu2PY+yO
        QPa/Bx0swrKMdjsOuANZhZ98OSRjL3VkHKmVo81OzzJN5Ue1j1zUwu1XVF8wK8utEOyTW/1VY8C8X
        vSN/QMUYy06mkL57cDr0VbjVGUQI7sYsPPQxgUnlm3b5kzsocKNMkoFFxwYY2tjsNzo9UJYCcbw9m
        1HMk9nTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8u-0005RH-KQ; Thu, 14 Mar 2019 13:11:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 55027203C08C4; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130705.750219024@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 4/8] perf/x86: Remove PERF_X86_EVENT_COMMITTED
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flag PERF_X86_EVENT_COMMITTED is used to find uncommitted events
for which to call put_event_constraint() when scheduling fails.

These are the newly added events to the list, and must form, per
definition, the tail of cpuc->event_list[]. By computing the list
index of the last successfull schedule, then iteration can start there
and the flag is redundant.

There are only 3 callers of x86_schedule_events(), notably:

 - x86_pmu_add()
 - x86_pmu_commit_txn()
 - validate_group()

For x86_pmu_add(), cpuc->n_events isn't updated until after
schedule_events() succeeds, therefore cpuc->n_events points to the
desired index.

For x86_pmu_commit_txn(), cpuc->n_events is updated, but we can
trivially compute the desired value with cpuc->n_txn -- the number of
events added in this transaction.

For validate_group(), we can make the rule for x86_pmu_add() work by
simply setting cpuc->n_events to 0 before calling schedule_events().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c       |   21 ++++++---------------
 arch/x86/events/perf_event.h |    1 -
 2 files changed, 6 insertions(+), 16 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -925,19 +925,16 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++) {
 			e = cpuc->event_list[i];
-			e->hw.flags |= PERF_X86_EVENT_COMMITTED;
 			if (x86_pmu.commit_scheduling)
 				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
 		}
 	} else {
-		for (i = 0; i < n; i++) {
+		i = cpuc->n_events;
+		if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
+			i -= cpuc->n_txn;
+
+		for (; i < n; i++) {
 			e = cpuc->event_list[i];
-			/*
-			 * do not put_constraint() on comitted events,
-			 * because they are good to go
-			 */
-			if ((e->hw.flags & PERF_X86_EVENT_COMMITTED))
-				continue;
 
 			/*
 			 * release events that failed scheduling
@@ -1372,11 +1369,6 @@ static void x86_pmu_del(struct perf_even
 	int i;
 
 	/*
-	 * event is descheduled
-	 */
-	event->hw.flags &= ~PERF_X86_EVENT_COMMITTED;
-
-	/*
 	 * If we're called during a txn, we only need to undo x86_pmu.add.
 	 * The events never got scheduled and ->cancel_txn will truncate
 	 * the event_list.
@@ -2079,8 +2071,7 @@ static int validate_group(struct perf_ev
 	if (n < 0)
 		goto out;
 
-	fake_cpuc->n_events = n;
-
+	fake_cpuc->n_events = 0;
 	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
 
 out:
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -61,7 +61,6 @@ struct event_constraint {
 #define PERF_X86_EVENT_PEBS_LDLAT	0x0001 /* ld+ldlat data address sampling */
 #define PERF_X86_EVENT_PEBS_ST		0x0002 /* st data address sampling */
 #define PERF_X86_EVENT_PEBS_ST_HSW	0x0004 /* haswell style datala, store */
-#define PERF_X86_EVENT_COMMITTED	0x0008 /* event passed commit_txn */
 #define PERF_X86_EVENT_PEBS_LD_HSW	0x0010 /* haswell style datala, load */
 #define PERF_X86_EVENT_PEBS_NA_HSW	0x0020 /* haswell style datala, unknown */
 #define PERF_X86_EVENT_EXCL		0x0040 /* HT exclusivity on counter */


