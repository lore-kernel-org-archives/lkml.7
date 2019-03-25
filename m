Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF72C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A4B2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfCYVXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfCYVXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:23:37 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20AF020848;
        Mon, 25 Mar 2019 21:23:36 +0000 (UTC)
Date:   Mon, 25 Mar 2019 17:23:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>
Subject: Re: [PATCH -tip v3 04/10] x86/kprobes: Prohibit probing on IRQ
 handlers directly
Message-ID: <20190325172334.559f8c5b@gandalf.local.home>
In-Reply-To: <154998796400.31052.8406236614820687840.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
        <154998796400.31052.8406236614820687840.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 01:12:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Prohibit probing on IRQ handlers in irqentry_text because
> if it interrupts user mode, at that point we haven't changed
> to kernel space yet and which eventually leads a double fault.
> E.g.
> 
>  # echo p apic_timer_interrupt > kprobe_events

Hmm, this breaks one of my tests (which I probe on do_IRQ).

It's been working for years.


>  # echo 1 > events/kprobes/enable
>  PANIC: double fault, error_code: 0x0
>  CPU: 1 PID: 814 Comm: less Not tainted 4.20.0-rc3+ #30
>  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>  RIP: 0010:error_entry+0x12/0xf0
>  [snip]
>  Call Trace:
>   <ENTRY_TRAMPOLINE>
>   ? native_iret+0x7/0x7
>   ? async_page_fault+0x8/0x30
>   ? trace_hardirqs_on_thunk+0x1c/0x1c
>   ? error_entry+0x7c/0xf0
>   ? async_page_fault+0x8/0x30
>   ? native_iret+0x7/0x7
>   ? int3+0xa/0x20
>   ? trace_hardirqs_on_thunk+0x1c/0x1c
>   ? error_entry+0x7c/0xf0
>   ? int3+0xa/0x20
>   ? apic_timer_interrupt+0x1/0x20
>   </ENTRY_TRAMPOLINE>
>  Kernel panic - not syncing: Machine halted.
>  Kernel Offset: disabled

I'm not able to reproduce this (by removing this commit). 

I'm thinking something else may have changed, as I've been tracing
interrupt entries for years, and interrupting userspace while doing
this.

I've even added probes where ftrace isn't (where it uses an int3) and
still haven't hit a problem.

I think this patch is swatting a symptom of a bug and not addressing
the bug itself. Can you send me the config that triggers this?

-- Steve


>  ---[ end Kernel panic - not syncing: Machine halted. ]---
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/kprobes/core.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4ba75afba527..a034cb808e7e 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -1028,6 +1028,13 @@ NOKPROBE_SYMBOL(kprobe_fault_handler);
>  
>  int __init arch_populate_kprobe_blacklist(void)
>  {
> +	int ret;
> +
> +	ret = kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
> +					 (unsigned long)__irqentry_text_end);
> +	if (ret)
> +		return ret;
> +
>  	return kprobe_add_area_blacklist((unsigned long)__entry_text_start,
>  					 (unsigned long)__entry_text_end);
>  }

