Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74DBC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74C4206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553734287;
	bh=epK8h7HLXNUXFuG+q8AFXcueNSWV8oi3N3xggwXV9UI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kxX09IwN/WG9JrAl9UynoPIMKkNwHwVYu4oeOMOSW4Omo4Oejg7lCeZiG/a4hw3fz
	 wJWW8G6JERKozXDslWajHevcsnLBaN1JGDiSV6BnKopma22/xv4WH5QlQkxGONbjIn
	 gyFLjogvVx2rZhMY2d5uMXBBfxto2Rg1DECszR70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfC1Av0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727442AbfC1Av0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:51:26 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AB8C20645;
        Thu, 28 Mar 2019 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553734285;
        bh=epK8h7HLXNUXFuG+q8AFXcueNSWV8oi3N3xggwXV9UI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QIRXX+7HiYuj5edkV1h3Clh9oar7ZhboP+2Uzp9rZqq0VKffTVS9o7TGeornO1oc6
         WDHF9aNCUYGiXgkcDPrW7ix79I3oE62L8MokeGB/mqiMADOJ88gAN4YX1Ol9c6AL+7
         sDOdMg+aguKD9txWE1fx6nyuPL16vvcCcDVtG0x8=
Date:   Thu, 28 Mar 2019 09:51:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.0 152/262] x86/kprobes: Prohibit probing on
 IRQ handlers directly
Message-Id: <20190328095119.e78ffbf9db138a24fbe18c69@kernel.org>
In-Reply-To: <20190327180158.10245-152-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
        <20190327180158.10245-152-sashal@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

Could you drop this?
This prevents probing too much functions, and we will drop it
from upstream. Anyway, commit a50480cb6d61 ("kprobes/x86: 
Blacklist non-attachable interrupt functions") fixes same issue.
So please pick it instead of this.

Thank you,

On Wed, 27 Mar 2019 14:00:07 -0400
Sasha Levin <sashal@kernel.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> [ Upstream commit 0eae81dc9f026d899c70f3931bf3bca6d7aa6938 ]
> 
> Prohibit probing on IRQ handlers in irqentry_text because
> if it interrupts user mode, at that point we haven't changed
> to kernel space yet and which eventually leads a double fault.
> E.g.
> 
>  # echo p apic_timer_interrupt > kprobe_events
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
>  ---[ end Kernel panic - not syncing: Machine halted. ]---
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andrea Righi <righi.andrea@gmail.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Link: http://lkml.kernel.org/r/154998796400.31052.8406236614820687840.stgit@devbox
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kernel/kprobes/core.c | 7 +++++++
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
> -- 
> 2.19.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
