Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7F4C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928152075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/Gk0mBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfE1I4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:56:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47338 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfE1I4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ErGdicB+w9Y3BzUXB1wjL/BN0mlHZyHPJdb8JJGWqo=; b=i/Gk0mBOYMGn76jX1pbR8imiF
        ChvOgexW5irG9RifGeReWzRTYJe7O0jaOesXLYOeya5Z9zcFdzNz0Xg9Dfoagek002mVmRxlKGu49
        X+/9vuO6Fzzbew0L3gVzrd4PnBUwBtFIrj0a3ws+FL5f/N/k/M12NxUPhmKZ7klY3n1+hVZA5RQXC
        AhrXTXKDClnUqFoQ8/ohCAX+tgnEFF/PySj1DPz07ozYFAKjQ7C/CxIurUdKdc40HgHyLmWeky69u
        BteG7+lTigBI+Rg1EbsqwAneXetBKsGvCQIONql7yCXpy9CRrHeLQ3OvUEJYp6JghZBEFGncdCtMl
        G9ueEolAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVXtr-00024t-64; Tue, 28 May 2019 08:56:03 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 251EA2072908D; Tue, 28 May 2019 10:56:01 +0200 (CEST)
Date:   Tue, 28 May 2019 10:56:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, acme@redhat.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        ak@linux.intel.com, jolsa@redhat.com, eranian@google.com
Subject: Re: [PATCH V2 1/3] perf/x86: Disable non generic regs for
 software/probe events
Message-ID: <20190528085601.GL2623@hirez.programming.kicks-ass.net>
References: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558984077-7773-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:07:55PM -0700, kan.liang@linux.intel.com wrote:
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index ac67bbe..3a96971 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -52,4 +52,7 @@ enum perf_event_x86_regs {
>  	/* These include both GPRs and XMMX registers */
>  	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
>  };
> +
> +#define PERF_REG_NON_GENERIC_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
> +
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
> index 4767474..1d794355 100644
> --- a/include/linux/perf_regs.h
> +++ b/include/linux/perf_regs.h
> @@ -11,6 +11,11 @@ struct perf_regs {
>  
>  #ifdef CONFIG_HAVE_PERF_REGS
>  #include <asm/perf_regs.h>
> +
> +#ifndef PERF_REG_NON_GENERIC_MASK
> +#define PERF_REG_NON_GENERIC_MASK	0
> +#endif
> +
>  u64 perf_reg_value(struct pt_regs *regs, int idx);
>  int perf_reg_validate(u64 mask);
>  u64 perf_reg_abi(struct task_struct *task);
> @@ -18,6 +23,9 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>  			struct pt_regs *regs,
>  			struct pt_regs *regs_user_copy);
>  #else
> +
> +#define PERF_REG_NON_GENERIC_MASK	0
> +
>  static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
>  {
>  	return 0;

Much better than the last version; however..

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3..4865bdf 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8457,6 +8457,12 @@ static void sw_perf_event_destroy(struct perf_event *event)
>  	swevent_hlist_put();
>  }
>  
> +static inline bool has_non_generic_regs(struct perf_event *event)
> +{
> +	return (event->attr.sample_regs_user & PERF_REG_NON_GENERIC_MASK) ||
> +	       (event->attr.sample_regs_intr & PERF_REG_NON_GENERIC_MASK);
> +}
> +
>  static int perf_swevent_init(struct perf_event *event)
>  {
>  	u64 event_id = event->attr.config;
> @@ -8470,6 +8476,10 @@ static int perf_swevent_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* Only support generic registers */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	switch (event_id) {
>  	case PERF_COUNT_SW_CPU_CLOCK:
>  	case PERF_COUNT_SW_TASK_CLOCK:
> @@ -8633,6 +8643,10 @@ static int perf_tp_event_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* Only support generic registers */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	err = perf_trace_init(event);
>  	if (err)
>  		return err;
> @@ -8722,6 +8736,10 @@ static int perf_kprobe_event_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* Only support generic registers */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
>  	err = perf_kprobe_init(event, is_retprobe);
>  	if (err)
> @@ -8782,6 +8800,10 @@ static int perf_uprobe_event_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* Only support generic registers */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
>  	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
>  	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
> @@ -9562,6 +9584,10 @@ static int cpu_clock_event_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* Only support generic registers */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	perf_swevent_init_hrtimer(event);
>  
>  	return 0;
> @@ -9643,6 +9669,10 @@ static int task_clock_event_init(struct perf_event *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
>  
> +	/* Only support generic registers */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	perf_swevent_init_hrtimer(event);
>  
>  	return 0;

I don't think this is anywhere near sufficient. What happens if we
request XMM regs for an uncore PMU ?

I'm thinking you want something along these lines...

---
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a5436cee20b1..3ef1c2e0b177 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3281,7 +3281,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
 			event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
-	}
+
+		/* we only support extended (XMM) registers for sample_regs_intr */
+		if (event->attr.sample_regs_user & PERF_REGS_EXTENDED_MASK)
+			return -EOPNOTSUPP;
+
+	} else if (has_extended_regs(event))
+		return -EOPNOTSUPP;
 
 	if (needs_branch_stack(event)) {
 		ret = intel_pmu_setup_lbr_filter(event);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5e9bb246b3a6..4fae37f8c7c2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2020,6 +2020,7 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				pebs_qual = "-baseline";
+				x86_get_pmu()->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
 				x86_pmu.pebs_no_xmm_regs = 1;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0ab99c7b652d..2bca72f3028b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -241,6 +241,7 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_INTERRUPT		0x01
 #define PERF_PMU_CAP_NO_NMI			0x02
 #define PERF_PMU_CAP_AUX_NO_SG			0x04
+#define PERF_PMU_CAP_EXTENDED_REGS		0x08
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..0c4872426b70 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10064,12 +10064,16 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
 	if (!ret) {
+		if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
+		    has_extended_regs(event))
+			ret = -EOPNOTSUPP;
+
 		if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
-				event_has_any_exclude_flag(event)) {
-			if (event->destroy)
-				event->destroy(event);
+				event_has_any_exclude_flag(event))
 			ret = -EINVAL;
-		}
+
+		if (ret && event->destroy)
+			event->destroy(event);
 	}
 
 	if (ret)
