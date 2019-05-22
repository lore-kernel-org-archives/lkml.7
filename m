Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC67C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D572220881
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbfEVWuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:50:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfEVWuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:50:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAD1D307D84B;
        Wed, 22 May 2019 22:50:12 +0000 (UTC)
Received: from krava (ovpn-204-104.brq.redhat.com [10.40.204.104])
        by smtp.corp.redhat.com (Postfix) with SMTP id F01DA100200D;
        Wed, 22 May 2019 22:50:06 +0000 (UTC)
Date:   Thu, 23 May 2019 00:50:06 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: perf: fuzzer causes crash in new XMM code
Message-ID: <20190522225006.GD11325@krava>
References: <alpine.DEB.2.21.1905221154300.22830@macbook-air>
 <a7cde307-8c53-14b5-2272-03dd3a8985c6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7cde307-8c53-14b5-2272-03dd3a8985c6@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 22 May 2019 22:50:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 05:54:58PM -0400, Liang, Kan wrote:

SNIP

> > [ 9680.197779] RSP: 002b:00007fff595603a8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
> > [ 9680.205489] RAX: 0000000000004985 RBX: 000000000000000c RCX: 00000000000365ca
> > [ 9680.212748] RDX: 00001e15d36cec84 RSI: 0000000000000000 RDI: 0000000000000001
> > [ 9680.220059] RBP: 00007fff595603c0 R08: 0000000000000000 R09: 00007fccbb62e540
> > [ 9680.227362] R10: fffffffffffffd4e R11: 0000000000000246 R12: 000055dad779a4c0
> > [ 9680.234630] R13: 00007fff595627b0 R14: 0000000000000000 R15: 0000000000000000
> > [ 9680.310017] ---[ end trace 511b9368cf14c65a ]---
> > 
> 
> Hi Vince,
> 
> Thanks for the test.
> 
> XMM registers can only collected by hardware PEBS events. We should disable
> it for all software/probe events.

I think you should also include HW non-PEBS events
in those checks below

jirka

> 
> Could you please try the patch as below?
> 
> Thanks,
> Kan
> 
> From 0136d8374c2db65b125c8d92b661c96e8d21adb0 Mon Sep 17 00:00:00 2001
> From: Kan Liang <kan.liang@linux.intel.com>
> Date: Wed, 22 May 2019 12:14:16 -0700
> Subject: [PATCH] perf/x86: Disable non generic regs for software/probe
> events
> 
> The perf fuzzer caused skylake machine to crash.
> 
> [ 9680.085831] Call Trace:
> [ 9680.088301]  <IRQ>
> [ 9680.090363]  perf_output_sample_regs+0x43/0xa0
> [ 9680.094928]  perf_output_sample+0x3aa/0x7a0
> [ 9680.099181]  perf_event_output_forward+0x53/0x80
> [ 9680.103917]  __perf_event_overflow+0x52/0xf0
> [ 9680.108266]  ? perf_trace_run_bpf_submit+0xc0/0xc0
> [ 9680.113108]  perf_swevent_hrtimer+0xe2/0x150
> [ 9680.117475]  ? check_preempt_wakeup+0x181/0x230
> [ 9680.122091]  ? check_preempt_curr+0x62/0x90
> [ 9680.126361]  ? ttwu_do_wakeup+0x19/0x140
> [ 9680.130355]  ? try_to_wake_up+0x54/0x460
> [ 9680.134366]  ? reweight_entity+0x15b/0x1a0
> [ 9680.138559]  ? __queue_work+0x103/0x3f0
> [ 9680.142472]  ? update_dl_rq_load_avg+0x1cd/0x270
> [ 9680.147194]  ? timerqueue_del+0x1e/0x40
> [ 9680.151092]  ? __remove_hrtimer+0x35/0x70
> [ 9680.155191]  __hrtimer_run_queues+0x100/0x280
> [ 9680.159658]  hrtimer_interrupt+0x100/0x220
> [ 9680.163835]  smp_apic_timer_interrupt+0x6a/0x140
> [ 9680.168555]  apic_timer_interrupt+0xf/0x20
> [ 9680.172756]  </IRQ>
> 
> The XMM registers can only be collected by hardware PEBS events, not
> software/probe events.
> 
> Add has_non_generic_regs() to check if non-generic regs, e.g. XMM on
> X86, are applied for software/probe events. If yes, return -EOPNOTSUPP.
> 
> Add __weak function non_generic_regs_mask() to return the mask of
> non-generic regs. For X86, the mask of non-generic regs equals to the
> mask of XMM registers.
> 
> Fixes: 878068ea270e ("perf/x86: Support outputting XMM registers")
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  arch/x86/kernel/perf_regs.c |  5 +++++
>  include/linux/perf_regs.h   |  2 ++
>  kernel/events/core.c        | 37 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 07c30ee..86ffe5a 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -57,6 +57,11 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
>  #endif
>  };
> 
> +u64 non_generic_regs_mask(void)
> +{
> +	return (~((1ULL << PERF_REG_X86_XMM0) - 1));
> +}
> +
>  u64 perf_reg_value(struct pt_regs *regs, int idx)
>  {
>  	struct x86_perf_regs *perf_regs;
> diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
> index 4767474..c1c3454 100644
> --- a/include/linux/perf_regs.h
> +++ b/include/linux/perf_regs.h
> @@ -9,6 +9,8 @@ struct perf_regs {
>  	struct pt_regs	*regs;
>  };
> 
> +u64 non_generic_regs_mask(void);
> +
>  #ifdef CONFIG_HAVE_PERF_REGS
>  #include <asm/perf_regs.h>
>  u64 perf_reg_value(struct pt_regs *regs, int idx);
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index abbd4b3..14da1d9 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8457,6 +8457,19 @@ static void sw_perf_event_destroy(struct perf_event
> *event)
>  	swevent_hlist_put();
>  }
> 
> +u64 __weak non_generic_regs_mask(void)
> +{
> +	return 0;
> +}
> +
> +static inline bool has_non_generic_regs(struct perf_event *event)
> +{
> +	u64 mask = non_generic_regs_mask();
> +
> +	return ((event->attr.sample_regs_user & mask) ||
> +		(event->attr.sample_regs_intr & mask));
> +}
> +
>  static int perf_swevent_init(struct perf_event *event)
>  {
>  	u64 event_id = event->attr.config;
> @@ -8470,6 +8483,10 @@ static int perf_swevent_init(struct perf_event
> *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> 
> +	/* only support generic regs */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	switch (event_id) {
>  	case PERF_COUNT_SW_CPU_CLOCK:
>  	case PERF_COUNT_SW_TASK_CLOCK:
> @@ -8633,6 +8650,10 @@ static int perf_tp_event_init(struct perf_event
> *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> 
> +	/* only support generic regs */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	err = perf_trace_init(event);
>  	if (err)
>  		return err;
> @@ -8722,6 +8743,10 @@ static int perf_kprobe_event_init(struct perf_event
> *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> 
> +	/* only support generic regs */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
>  	err = perf_kprobe_init(event, is_retprobe);
>  	if (err)
> @@ -8782,6 +8807,10 @@ static int perf_uprobe_event_init(struct perf_event
> *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> 
> +	/* only support generic regs */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	is_retprobe = event->attr.config & PERF_PROBE_CONFIG_IS_RETPROBE;
>  	ref_ctr_offset = event->attr.config >> PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
>  	err = perf_uprobe_init(event, ref_ctr_offset, is_retprobe);
> @@ -9562,6 +9591,10 @@ static int cpu_clock_event_init(struct perf_event
> *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> 
> +	/* only support generic regs */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	perf_swevent_init_hrtimer(event);
> 
>  	return 0;
> @@ -9643,6 +9676,10 @@ static int task_clock_event_init(struct perf_event
> *event)
>  	if (has_branch_stack(event))
>  		return -EOPNOTSUPP;
> 
> +	/* only support generic regs */
> +	if (has_non_generic_regs(event))
> +		return -EOPNOTSUPP;
> +
>  	perf_swevent_init_hrtimer(event);
> 
>  	return 0;
> -- 
> 2.7.4
> 
> 
> 
