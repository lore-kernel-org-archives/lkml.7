Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41207C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 02:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D0320828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 02:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577329034;
	bh=rbkElJWAXkNtRfh891s+ZThXz0VfuU0P2LJA4L64enU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MlUZJ1rktuhsNlDM3l1I3nFn6wqYgf25R664sGM0XtPmvhsGRWJWKlTp1e3E1kgOB
	 U9BC/uVfsPOl2kTUVPf1cEYG5UOOpjGrwdGKBdAiAKQW7eJERqvFjDqOppj4LeVQip
	 cljFKh4CAjjurp38ml+f2+tLXVJoNtVLAMdnn4mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfLZC5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 21:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbfLZC5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 21:57:13 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B667207FF;
        Thu, 26 Dec 2019 02:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577329031;
        bh=rbkElJWAXkNtRfh891s+ZThXz0VfuU0P2LJA4L64enU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kKgMG+jnL7SaYdWm7+P1acCEiRvKB+Xlg11reRfkuRWid8dPLiItX6YxmNwHTlyE+
         JK/ObqfLtSonTmDp5/u2lAezNrOYEMJkIMVdREES6Hm5ymm67TYMsjFBMZqrjIOG2q
         FTWgUkD3KlGOo5Jo4KnkGs4Ox7BMmhRvhtmfLpB0=
Date:   Thu, 26 Dec 2019 11:57:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 3/3] arm64: implement KPROBES_ON_FTRACE
Message-Id: <20191226115707.902545688aa90b34e2e550b3@kernel.org>
In-Reply-To: <20191225173001.6c0e3fb2@xhacker.debian>
References: <20191225172625.69811b3e@xhacker.debian>
        <20191225173001.6c0e3fb2@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Wed, 25 Dec 2019 09:44:21 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
> eliminates the need for a trap, as well as the need to emulate or
> single-step instructions.
> 
> Tested on berlin arm64 platform.
> 
> ~ # mount -t debugfs debugfs /sys/kernel/debug/
> ~ # cd /sys/kernel/debug/
> /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> 
> before the patch:
> 
> /sys/kernel/debug # cat kprobes/list
> ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
> 
> after the patch:
> 
> /sys/kernel/debug # cat kprobes/list
> ffffff801009ff54  k  _do_fork+0x0    [DISABLED][FTRACE]

What happens if user puts a probe on _do_fork+4?
Is that return -EILSEQ correctly?

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
>  arch/arm64/Kconfig                            |  1 +
>  arch/arm64/include/asm/ftrace.h               |  1 +
>  arch/arm64/kernel/probes/Makefile             |  1 +
>  arch/arm64/kernel/probes/ftrace.c             | 78 +++++++++++++++++++
>  5 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/probes/ftrace.c
> 
> diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> index 4fae0464ddff..f9dd9dd91e0c 100644
> --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> @@ -9,7 +9,7 @@
>      |       alpha: | TODO |
>      |         arc: | TODO |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: |  ok  |
>      |         c6x: | TODO |
>      |        csky: | TODO |
>      |       h8300: | TODO |
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1b4476ddb83..92b9882889ac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -166,6 +166,7 @@ config ARM64
>  	select HAVE_STACKPROTECTOR
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_KPROBES
> +	select HAVE_KPROBES_ON_FTRACE
>  	select HAVE_KRETPROBES
>  	select HAVE_GENERIC_VDSO
>  	select IOMMU_DMA if IOMMU_SUPPORT
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index 91fa4baa1a93..875aeb839654 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -20,6 +20,7 @@
>  
>  /* The BL at the callsite's adjusted rec->ip */
>  #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
> +#define FTRACE_IP_EXTENSION	MCOUNT_INSN_SIZE
>  
>  #define FTRACE_PLT_IDX		0
>  #define FTRACE_REGS_PLT_IDX	1
> diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
> index 8e4be92e25b1..4020cfc66564 100644
> --- a/arch/arm64/kernel/probes/Makefile
> +++ b/arch/arm64/kernel/probes/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
>  				   simulate-insn.o
>  obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
>  				   simulate-insn.o
> +obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
> diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/ftrace.c
> new file mode 100644
> index 000000000000..0643aa2dacdb
> --- /dev/null
> +++ b/arch/arm64/kernel/probes/ftrace.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Dynamic Ftrace based Kprobes Optimization
> + *
> + * Copyright (C) Hitachi Ltd., 2012
> + * Copyright (C) 2019 Jisheng Zhang <jszhang@kernel.org>
> + *		      Synaptics Incorporated
> + */
> +
> +#include <linux/kprobes.h>
> +
> +/*
> + * In arm64 FTRACE_WITH_REGS implementation, we patch two nop instructions:
> + * the lr saver and bl ftrace-entry. Both these instructions are claimed
> + * by ftrace and we should allow probing on either instruction.

No, the 2nd bl ftrace-entry must not be probed.
The pair of lr-saver and bl ftrace-entry is tightly coupled. You can not
decouple it.

> + */
> +int arch_check_ftrace_location(struct kprobe *p)
> +{
> +	if (ftrace_location((unsigned long)p->addr))
> +		p->flags |= KPROBE_FLAG_FTRACE;
> +	return 0;
> +}

Thus, this must return -EILSEQ if user puts a probe on the bl.

> +
> +/* Ftrace callback handler for kprobes -- called under preepmt disabed */
> +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> +			   struct ftrace_ops *ops, struct pt_regs *regs)
> +{
> +	bool lr_saver = false;
> +	struct kprobe *p;
> +	struct kprobe_ctlblk *kcb;
> +
> +	/* Preempt is disabled by ftrace */
> +	p = get_kprobe((kprobe_opcode_t *)ip);
> +	if (!p) {
> +		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
> +		if (unlikely(!p) || kprobe_disabled(p))
> +			return;
> +		lr_saver = true;

Then, this can be removed.

> +	}
> +
> +	kcb = get_kprobe_ctlblk();
> +	if (kprobe_running()) {
> +		kprobes_inc_nmissed_count(p);
> +	} else {
> +		unsigned long orig_ip = instruction_pointer(regs);
> +
> +		if (lr_saver)
> +			ip -= MCOUNT_INSN_SIZE;

Ditto.

Thank you,

> +		instruction_pointer_set(regs, ip);
> +		__this_cpu_write(current_kprobe, p);
> +		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> +		if (!p->pre_handler || !p->pre_handler(p, regs)) {
> +			/*
> +			 * Emulate singlestep (and also recover regs->pc)
> +			 * as if there is a nop
> +			 */
> +			instruction_pointer_set(regs,
> +				(unsigned long)p->addr + MCOUNT_INSN_SIZE);
> +			if (unlikely(p->post_handler)) {
> +				kcb->kprobe_status = KPROBE_HIT_SSDONE;
> +				p->post_handler(p, regs, 0);
> +			}
> +			instruction_pointer_set(regs, orig_ip);
> +		}
> +		/*
> +		 * If pre_handler returns !0, it changes regs->pc. We have to
> +		 * skip emulating post_handler.
> +		 */
> +		__this_cpu_write(current_kprobe, NULL);
> +	}
> +}
> +NOKPROBE_SYMBOL(kprobe_ftrace_handler);
> +
> +int arch_prepare_kprobe_ftrace(struct kprobe *p)
> +{
> +	p->ainsn.api.insn = NULL;
> +	return 0;
> +}
> -- 
> 2.24.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
