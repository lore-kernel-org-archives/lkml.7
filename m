Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33432C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0573D2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tRMjHAy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfCNNLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:11:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59852 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfCNNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BN4kwSkadNvN9UU38Ue6u/l6aAsV4JY0CbwCqMAflF8=; b=tRMjHAy0U1NXEYfRex8RcYM0u/
        ezeyD4prP2lKp0y7rISnhorq/feWLs0WpGGviYJVsWMIpt1WwUu4B3VtTIIDChreuuNKvedJfD4vw
        /iOExxuPoGgookUa+HgqKQ4MG2yuIz3ucuSssbcLQZ7VHEMPVH2FA55tFIniLeKSUxOT5kvEfWsFJ
        ujl5o1FR274HyADXkGx47ZnD5s87o49p4XMPDPtZc2EM0M+ErTA+zWGyEoI/oroxYS3IEy2p7b6zj
        /QNj9/ahmccpfW5S1tICzns0XNRlxcOkt9WgKPMrrYzk2jHu7aUJUpXLskGSu4UKhw/VHFobBi4t5
        7RBFlZ/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8w-0005RZ-79; Thu, 14 Mar 2019 13:11:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 66C52203E5149; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130706.061994422@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 7/8] perf/x86: Optimize x86_schedule_events()
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that cpuc->event_constraint[] is retained, we can avoid calling
get_event_constraints() over and over again.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c       |   25 +++++++++++++++++++++----
 arch/x86/events/intel/core.c |    3 ++-
 2 files changed, 23 insertions(+), 5 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -844,6 +844,12 @@ int perf_assign_events(struct event_cons
 }
 EXPORT_SYMBOL_GPL(perf_assign_events);
 
+static inline bool is_ht_workaround_active(struct cpu_hw_events *cpuc)
+{
+	return is_ht_workaround_enabled() && !cpuc->is_fake &&
+	       READ_ONCE(cpuc->excl_cntrs->exclusive_present);
+}
+
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 {
 	struct event_constraint *c;
@@ -858,8 +864,20 @@ int x86_schedule_events(struct cpu_hw_ev
 		x86_pmu.start_scheduling(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
-		c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
-		cpuc->event_constraint[i] = c;
+		c = cpuc->event_constraint[i];
+
+		/*
+		 * Request constraints for new events; or for those events that
+		 * have a dynamic constraint due to the HT workaround -- for
+		 * those the constraint can change due to scheduling activity
+		 * on the other sibling.
+		 */
+		if (!c || ((c->flags & PERF_X86_EVENT_DYNAMIC) &&
+			   is_ht_workaround_active(cpuc))) {
+
+			c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
+			cpuc->event_constraint[i] = c;
+		}
 
 		wmin = min(wmin, c->weight);
 		wmax = max(wmax, c->weight);
@@ -903,8 +921,7 @@ int x86_schedule_events(struct cpu_hw_ev
 		 * N/2 counters can be used. This helps with events with
 		 * specific counter constraints.
 		 */
-		if (is_ht_workaround_enabled() && !cpuc->is_fake &&
-		    READ_ONCE(cpuc->excl_cntrs->exclusive_present))
+		if (is_ht_workaround_active(cpuc))
 			gpmax /= 2;
 
 		unsched = perf_assign_events(cpuc->event_constraint, n, wmin,
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2945,7 +2945,8 @@ intel_get_event_constraints(struct cpu_h
 	 * - dynamic constraint: handled by intel_get_excl_constraints()
 	 */
 	c2 = __intel_get_event_constraints(cpuc, idx, event);
-	if (c1 && (c1->flags & PERF_X86_EVENT_DYNAMIC)) {
+	if (c1) {
+	        WARN_ON_ONCE(!(c1->flags & PERF_X86_EVENT_DYNAMIC));
 		bitmap_copy(c1->idxmsk, c2->idxmsk, X86_PMC_IDX_MAX);
 		c1->weight = c2->weight;
 		c2 = c1;


