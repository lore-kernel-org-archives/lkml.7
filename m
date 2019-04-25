Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADAF206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aiUXQs6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfDYVLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:11:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43151 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387410AbfDYVLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:11:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id z9so447746pgu.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=KGZ5kOPc5+k/ehea2lSIv6K03K5m5afzo7l7QVKnGRg=;
        b=aiUXQs6FaHXx1SXTsEwt1Q8MZ+wuJcBubSe9OO8zBlQhfW8HTVSWGk5t4W7PwTi5/w
         wBNiUsbn4ifanTZR9Cs0CSgGt67XquD15bFzWWjHN1tdtqWY85f4jemd0aa/eva8y11C
         SwUija6oM4A9Md3PnOV7lPJ5jS2n5ccTWq5lrpJJssKj6GJS+7xZ9Boz1a0emzClwmzu
         V6/OHjUqPQlPqwwqKlBtj0kNJJkb+bkFyyd/FYKQXcRPx71jEuJKXn1pCNhCw1QJE5wg
         pbvM2yvLrth3wH24YXyVhh+RnirMtYaQGSGljQHB+DdZJxuSzJmBCEg9Maa5xiV7MTC8
         B1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=KGZ5kOPc5+k/ehea2lSIv6K03K5m5afzo7l7QVKnGRg=;
        b=glwb0HfwTWs3vU76iu4TSeQi1/2OQy7hAspZeLSeKaURUJaxKAtIq2XBRkRS3FIJQg
         1dKlPOv/go2ySeB34Y2p8tniU2GifJzkUiCZ/hryGsOrblB9DmwFzZVp79CQXscPXpzB
         9EffQgVutlcHZnUK/QgPBGDYwKSE7lSfrPXt4wPj7E/7L93/ALWWOW4Z98jD7dLYN2xD
         23hiAB6u8O1iNVnPIo68gtH9oep1QYMAcf0GUaN+Nf26gI46dvhMqZzRiU7iRvzSF9B1
         FHDgY/unQH9OfY6wuxfNZCx2uG/BNTbbYt4BTD+/B6zD1V6e27SytZSc25w/g6s2qaYZ
         qrcg==
X-Gm-Message-State: APjAAAUADthU4QG35u6PewfP948f0gGnk28Vquc9uz3rQRfZQ8l4VfDJ
        7krrcXwTaqwFPsiBfMuOkBOIpPlUZPo=
X-Google-Smtp-Source: APXvYqwdmuXd+Vzj/MIplmIpITDY4+4rxiyb09JjmqwBbkFRURZwR5WeNgQh803a+ub/Ei5nOLfaZw==
X-Received: by 2002:aa7:814e:: with SMTP id d14mr42972887pfn.101.1556226661535;
        Thu, 25 Apr 2019 14:11:01 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id u7sm24276173pgp.26.2019.04.25.14.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 14:11:00 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:11:00 -0700 (PDT)
X-Google-Original-Date: Thu, 25 Apr 2019 14:02:53 PDT (-0700)
Subject:     Re: [PATCH 1/3] riscv: Add perf callchain support
In-Reply-To: <195185ea63240ed396026505d96d1f6449963482.1554961908.git.han_mao@c-sky.com>
CC:     linux-kernel@vger.kernel.org, han_mao@c-sky.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     han_mao@c-sky.com
Message-ID: <mhng-dd1d2b4c-122f-48d8-ac56-1c6bff93f236@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 00:53:48 PDT (-0700), han_mao@c-sky.com wrote:
> This patch add support for perf callchain sampling on riscv platform.
> The return address of leaf function is retrieved from pt_regs as
> it is not saved in the outmost frame.
>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
>
> CC: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/kernel/Makefile         |   3 +-
>  arch/riscv/kernel/perf_callchain.c | 122 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/perf_callchain.c
>
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 5985681..dd2ba44 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>
> -obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
> +obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
> +obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
>
>  clean:
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_callchain.c
> new file mode 100644
> index 0000000..eb3ddbb
> --- /dev/null
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
> +
> +#include <linux/perf_event.h>
> +#include <linux/uaccess.h>
> +
> +/* Kernel callchain */
> +struct stackframe {
> +	unsigned long fp;
> +	unsigned long ra;
> +};
> +
> +static int unwind_frame_kernel(struct stackframe *frame)
> +{
> +	int graph = 0;
> +
> +	/* 0x3 means misalignment */
> +	if (!kstack_end((void *)frame->fp) &&
> +	    !((unsigned long)frame->fp & 0x3) &&
> +	    ((unsigned long)frame->fp >= TASK_SIZE)) {
> +		frame->ra = ((struct stackframe *)frame->fp - 1)->ra;
> +		frame->fp = ((struct stackframe *)frame->fp - 1)->fp;

It looks like this depends on having a frame pointer?  In that case, shouldn't
we add some Kconfig logic to make CONFIG_PERF_EVENTS select
-fno-omit-frame-pointer?  Frame pointers aren't enabled by default on RISC-V
and therefor are unlikely to exist at all.

> +		/* make sure CONFIG_FUNCTION_GRAPH_TRACER is turned on */

Should that also be mandated by a Kconfig?

> +		if (__kernel_text_address(frame->ra))
> +			frame->ra = ftrace_graph_ret_addr(NULL, &graph,
> +							frame->ra, NULL);
> +		return 0;
> +	} else {
> +		return -EPERM;
> +	}
> +}
> +
> +static void notrace walk_stackframe(struct stackframe *fr,
> +			struct perf_callchain_entry_ctx *entry)
> +{
> +	while (1) {
> +		int ret;
> +
> +		perf_callchain_store(entry, fr->ra);
> +
> +		ret = unwind_frame_kernel(fr);
> +		if (ret < 0)
> +			break;
> +	}
> +}
> +
> +/*
> + * Get the return address for a single stackframe and return a pointer to the
> + * next frame tail.
> + */
> +static unsigned long user_backtrace(struct perf_callchain_entry_ctx *entry,
> +			unsigned long fp, unsigned long reg_ra)
> +{
> +	struct stackframe buftail;
> +	unsigned long ra = 0;
> +	unsigned long *user_frame_tail = (unsigned long *)(fp - sizeof(struct stackframe));
> +
> +	/* Check accessibility of one struct frame_tail beyond */
> +	if (!access_ok(user_frame_tail, sizeof(buftail)))
> +		return 0;
> +	if (__copy_from_user_inatomic(&buftail, user_frame_tail,
> +				      sizeof(buftail)))
> +		return 0;
> +
> +	if (reg_ra != 0)
> +		ra = reg_ra;
> +	else
> +		ra = buftail.ra;
> +
> +	fp = buftail.fp;
> +	perf_callchain_store(entry, ra);
> +
> +	return fp;
> +}
> +
> +/*
> + * This will be called when the target is in user mode
> + * This function will only be called when we use
> + * "PERF_SAMPLE_CALLCHAIN" in
> + * kernel/events/core.c:perf_prepare_sample()
> + *
> + * How to trigger perf_callchain_[user/kernel] :
> + * $ perf record -e cpu-clock --call-graph fp ./program
> + * $ perf report --call-graph
> + *
> + * On RISC-V platform, the program being sampled and the C library
> + * need to be compiled with * -mbacktrace, otherwise the user

What is "-mbacktrace"?  I don't remember that ever being a RISC-V GCC option,
and my compiler doesn't undersand it.  It understands "-fbacktrace" but that
doesn't produce a frame pointer.

> + * stack will not contain function frame.
> + */
> +void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> +			 struct pt_regs *regs)
> +{
> +	unsigned long fp = 0;
> +
> +	/* RISC-V does not support virtualization. */
> +	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
> +		return;
> +
> +	fp = regs->s0;
> +	perf_callchain_store(entry, regs->sepc);
> +
> +	fp = user_backtrace(entry, fp, regs->ra);
> +	while ((entry->nr < entry->max_stack) &&
> +		fp && !((unsigned long)fp & 0x3))
> +		fp = user_backtrace(entry, fp, 0);
> +}
> +
> +void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
> +			   struct pt_regs *regs)
> +{
> +	struct stackframe fr;
> +
> +	/* RISC-V does not support virtualization. */
> +	if (perf_guest_cbs && perf_guest_cbs->is_in_guest()) {
> +		pr_warn("RISC-V does not support perf in guest mode!");
> +		return;
> +	}
> +
> +	fr.fp = regs->s0;
> +	fr.ra = regs->ra;
> +	walk_stackframe(&fr, entry);
> +}
