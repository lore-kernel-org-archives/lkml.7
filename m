Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42892C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA612175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oh+U9TzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfCTMXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:23:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52812 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfCTMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W82fy8KoUHr4dndbn9kYy5T4gB/YgZQsmivULDCU6eA=; b=Oh+U9TzXXCMXMCD0s14YCM7Cj
        QhOXcDtqcjL90I74mEO+sWHBLUFPozFwWKK8WfYLOFXkGJlj290MgmjIJ7qKxFvjpQxP3x6l0Kgs7
        /YWH9qo81zT83lQmqMlWOf0tctRwLkhxKLfEpoR6yijr47mDUtDZj0V2uZyPkHsTUj1gVNWRJqrFJ
        TmpzzHXBfyjOBfkYivCNn8rUhMI9NJnZCIpQQHOp4iTB72ZRc4x1sp0sVMoxU4TBo42t9rHLX/0IP
        cgu7FKtYWxv00aGrOVAH5NNSGdSwwd002c/7oS+9K3n0lDDtx7pw7g/qsrrlciFrB0rEk6G2KVWxy
        pI8XSHG5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6aG3-0005pY-Ni; Wed, 20 Mar 2019 12:23:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 144D423EA30BA; Wed, 20 Mar 2019 13:23:46 +0100 (CET)
Date:   Wed, 20 Mar 2019 13:23:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, tonyj@suse.com,
        nelson.dsouza@intel.com
Subject: Re: [RFC][PATCH 4/8] perf/x86: Remove PERF_X86_EVENT_COMMITTED
Message-ID: <20190320122346.GE6058@hirez.programming.kicks-ass.net>
References: <20190314130113.919278615@infradead.org>
 <20190314130705.750219024@infradead.org>
 <CABPqkBQr4VbNQG9R9j8Di=6fSziUw1s_QLyE9L7nsMTdWd8GtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBQr4VbNQG9R9j8Di=6fSziUw1s_QLyE9L7nsMTdWd8GtQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: perf/x86: Remove PERF_X86_EVENT_COMMITTED
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Mar 14 12:58:52 CET 2019

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

Reviewed-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c       |   28 +++++++++++++---------------
 arch/x86/events/perf_event.h |   19 +++++++++----------
 2 files changed, 22 insertions(+), 25 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -925,19 +925,23 @@ int x86_schedule_events(struct cpu_hw_ev
 	if (!unsched && assign) {
 		for (i = 0; i < n; i++) {
 			e = cpuc->event_list[i];
-			e->hw.flags |= PERF_X86_EVENT_COMMITTED;
 			if (x86_pmu.commit_scheduling)
 				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
 		}
 	} else {
-		for (i = 0; i < n; i++) {
+		/*
+		 * In a transaction cpuc->n_events is already updated, but we
+		 * can use cpuc->n_txn know how many new events there are.
+		 *
+		 * Outside of a transaction, cpuc->n_events is not yet updated,
+		 * and indicates how many events how many events are scheduled.
+		 */
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
@@ -1372,11 +1376,6 @@ static void x86_pmu_del(struct perf_even
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
@@ -2079,8 +2078,7 @@ static int validate_group(struct perf_ev
 	if (n < 0)
 		goto out;
 
-	fake_cpuc->n_events = n;
-
+	fake_cpuc->n_events = 0;
 	ret = x86_pmu.schedule_events(fake_cpuc, n, NULL);
 
 out:
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -55,22 +55,21 @@ struct event_constraint {
 	int	overlap;
 	int	flags;
 };
+
 /*
  * struct hw_perf_event.flags flags
  */
 #define PERF_X86_EVENT_PEBS_LDLAT	0x0001 /* ld+ldlat data address sampling */
 #define PERF_X86_EVENT_PEBS_ST		0x0002 /* st data address sampling */
 #define PERF_X86_EVENT_PEBS_ST_HSW	0x0004 /* haswell style datala, store */
-#define PERF_X86_EVENT_COMMITTED	0x0008 /* event passed commit_txn */
-#define PERF_X86_EVENT_PEBS_LD_HSW	0x0010 /* haswell style datala, load */
-#define PERF_X86_EVENT_PEBS_NA_HSW	0x0020 /* haswell style datala, unknown */
-#define PERF_X86_EVENT_EXCL		0x0040 /* HT exclusivity on counter */
-#define PERF_X86_EVENT_DYNAMIC		0x0080 /* dynamic alloc'd constraint */
-#define PERF_X86_EVENT_RDPMC_ALLOWED	0x0100 /* grant rdpmc permission */
-#define PERF_X86_EVENT_EXCL_ACCT	0x0200 /* accounted EXCL event */
-#define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
-#define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
-
+#define PERF_X86_EVENT_PEBS_LD_HSW	0x0008 /* haswell style datala, load */
+#define PERF_X86_EVENT_PEBS_NA_HSW	0x0010 /* haswell style datala, unknown */
+#define PERF_X86_EVENT_EXCL		0x0020 /* HT exclusivity on counter */
+#define PERF_X86_EVENT_DYNAMIC		0x0040 /* dynamic alloc'd constraint */
+#define PERF_X86_EVENT_RDPMC_ALLOWED	0x0080 /* grant rdpmc permission */
+#define PERF_X86_EVENT_EXCL_ACCT	0x0100 /* accounted EXCL event */
+#define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
+#define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
