Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B9F2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EAdXQNZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfCNNLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:11:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=W3f8VEDuJT2Wi3frobQjhAtHTusNd+EzUN5waR2V9Ig=; b=EAdXQNZ7veFQwNBtz4Xxv6De3W
        E3mb0/a7XT0BNLarTU1R5ubQt82UkBVl4XhwLE48BFOPbb0RgJDtiVw+6Cvbwgi8pvD6IkkKPQ1Nz
        +xDGm7S5VzLK6bEPIx81FbhiHPwOf5vNq9gUha06HBqmyYTB4yDqjdbMIQcqFRe5sEEdmvl6ag38W
        7IY89OQ0mq83xiCIpnb9GPojC9JzVYvG1MmLqSJXpZmNXzQF/I1ReQCctVZkpxSdi0BgHuQpyQ2gJ
        y8YLg/bVYS5LEozDac7afNg5UfDt7J7cpLsXIyMRSwnX1fnmR4i1eeSaDx1pDGMaeKSSAjbXTrZ2z
        HA8nP68w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8w-0006XS-G1; Thu, 14 Mar 2019 13:11:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6C70620138B9C; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130706.164351344@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:21 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 8/8] perf/x86: Add sanity checks to x86_schedule_events()
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -855,17 +855,30 @@ int x86_schedule_events(struct cpu_hw_ev
 	struct event_constraint *c;
 	unsigned long used_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	struct perf_event *e;
-	int i, wmin, wmax, unsched = 0;
+	int n0, i, wmin, wmax, unsched = 0;
 	struct hw_perf_event *hwc;
 
 	bitmap_zero(used_mask, X86_PMC_IDX_MAX);
 
+	/*
+	 * Compute the number of events already present; see x86_pmu_add(),
+	 * validate_group() and x86_pmu_commit_txn(). For the former two
+	 * cpuc->n_events hasn't been updated yet, while for the latter
+	 * cpuc->n_txn contains the number of events added in the current
+	 * transaction.
+	 */
+	n0 = cpuc->n_events;
+	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
+		n0 -= cpuc->n_txn;
+
 	if (x86_pmu.start_scheduling)
 		x86_pmu.start_scheduling(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
 		c = cpuc->event_constraint[i];
 
+		WARN_ON_ONCE((c && i >= n0) || (!c && i < n0));
+
 		/*
 		 * Request constraints for new events; or for those events that
 		 * have a dynamic constraint due to the HT workaround -- for
@@ -945,11 +958,7 @@ int x86_schedule_events(struct cpu_hw_ev
 				x86_pmu.commit_scheduling(cpuc, i, assign[i]);
 		}
 	} else {
-		i = cpuc->n_events;
-		if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
-			i -= cpuc->n_txn;
-
-		for (; i < n; i++) {
+		for (i = n0; i < n; i++) {
 			e = cpuc->event_list[i];
 
 			/*


