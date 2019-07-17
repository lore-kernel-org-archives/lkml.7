Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889EDC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F472173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tac1E3p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfGQO7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:59:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37570 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfGQO7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=riU1swK8oczZqL2K/LPDMNTuoGFRPt/jPKWzSe1b1bc=; b=Tac1E3p9345fUIaRAu+KSXJjh
        WH0ubxua80Pf9WAyF+53kbh26N3sYEsJVovt+WK018/5x1BJY8qfj1u9XZ+mjXTe3lZOM8qZgpCBl
        ehyh77Hv9DWte9DUDigU0HvhYbGH5J9exLSz9vmCL0CEzTPjZS1iSgJP/UcB3T8Ic5g2a8qZsFSLx
        i+Djcq8ZaOl6URTIlF6Ofww+dkuIgbVIifSstPCLZvgE7zUul0s35skVAo01YGOs9UXkdlZeWFKEy
        eKHdkZT7fss2jdmdSPcK0NLiC2BWlJwQ2N2q9t0iLEUSM9EFLyycUp5liH1mXJj3thsTEg1dcvIY7
        tcTBMIkKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hnlPA-0002s6-QC; Wed, 17 Jul 2019 14:59:41 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A61820B838ED; Wed, 17 Jul 2019 16:59:37 +0200 (CEST)
Date:   Wed, 17 Jul 2019 16:59:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Introduce fits_capacity()
Message-ID: <20190717145937.GX3419@hirez.programming.kicks-ass.net>
References: <b477ac75a2b163048bdaeb37f57b4c3f04f75a31.1559631700.git.viresh.kumar@linaro.org>
 <20190717103356.gb2guwxy5joko53e@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717103356.gb2guwxy5joko53e@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 04:03:56PM +0530, Viresh Kumar wrote:
> On 04-06-19, 12:31, Viresh Kumar wrote:
> > The same formula to check utilization against capacity (after
> > considering capacity_margin) is already used at 5 different locations.
> > 
> > This patch creates a new macro, fits_capacity(), which can be used from
> > all these locations without exposing the details of it and hence
> > simplify code.
> > 
> > All the 5 code locations are updated as well to use it..
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  kernel/sched/fair.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> @Peter: Do you suggest any modifications to this patch? Do I need to
> resend it ?

Ah, I've picked it up with a few (small) edits.

Thanks!

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -96,12 +96,12 @@ int __weak arch_asym_cpu_priority(int cp
 }
 
 /*
- * The margin used when comparing utilization with CPU capacity:
- * util * margin < capacity * 1024
+ * The margin used when comparing utilization with CPU capacity.
  *
  * (default: ~20%)
  */
-static unsigned int capacity_margin			= 1280;
+#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
+
 #endif
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -3754,7 +3754,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq,
 
 static inline int task_fits_capacity(struct task_struct *p, long capacity)
 {
-	return capacity * 1024 > task_util_est(p) * capacity_margin;
+	return fits_capacity(task_util_est(p), capacity);
 }
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
@@ -5181,7 +5181,7 @@ static inline unsigned long cpu_util(int
 
 static inline bool cpu_overutilized(int cpu)
 {
-	return (capacity_of(cpu) * 1024) < (cpu_util(cpu) * capacity_margin);
+	return !fits_capacity(cpu_util(cpu), capacity_of(cpu));
 }
 
 static inline void update_overutilized_status(struct rq *rq)
@@ -6402,7 +6402,7 @@ static int find_energy_efficient_cpu(str
 			/* Skip CPUs that will be overutilized. */
 			util = cpu_util_next(cpu, p, cpu);
 			cpu_cap = capacity_of(cpu);
-			if (cpu_cap * 1024 < util * capacity_margin)
+			if (!fits_capacity(util, cpu_cap))
 				continue;
 
 			/* Always use prev_cpu as a candidate. */
@@ -7957,8 +7957,7 @@ group_is_overloaded(struct lb_env *env,
 static inline bool
 group_smaller_min_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return sg->sgc->min_capacity * capacity_margin <
-						ref->sgc->min_capacity * 1024;
+	return fits_capacity(sg->sgc->min_capacity, ref->sgc->min_capacity);
 }
 
 /*
@@ -7968,8 +7967,7 @@ group_smaller_min_cpu_capacity(struct sc
 static inline bool
 group_smaller_max_cpu_capacity(struct sched_group *sg, struct sched_group *ref)
 {
-	return sg->sgc->max_capacity * capacity_margin <
-						ref->sgc->max_capacity * 1024;
+	return fits_capacity(sg->sgc->max_capacity, ref->sgc->max_capacity);
 }
 
 static inline enum
