Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD85C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FB62073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfLDOVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:21:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfLDOVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:21:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE58206DF;
        Wed,  4 Dec 2019 14:21:17 +0000 (UTC)
Date:   Wed, 4 Dec 2019 09:21:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Antonio Borneo <antonio.borneo@st.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] tracing: Fix printing ptrs in preempt/irq
 enable/disable events
Message-ID: <20191204092115.30ef75c9@gandalf.local.home>
In-Reply-To: <20191127154428.191095-1-antonio.borneo@st.com>
References: <20191127154428.191095-1-antonio.borneo@st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Joel,

Any comments on this patch?

-- Steve

On Wed, 27 Nov 2019 16:44:28 +0100
Antonio Borneo <antonio.borneo@st.com> wrote:

> This tracing event class is the only instance in kernel that logs
> in the trace buffer the instruction pointer as offset to _stext,
> instead of logging the full pointer.
> This looks like a nice optimization for 64 bits platforms, where a
> 32 bit offset can take less space than a full 64 bits pointer. But
> the symbol _stext is incorrectly resolved as zero in the expansion
> of TP_printk(), which then prints only the hex offset instead of
> the name of the caller function. Plus, on arm arch the kernel
> modules are loaded at address lower than _stext, causing the u32
> offset arithmetics to overflow and wrap at 32 bits.
> I did not identified a 64 bit arch where the modules are loaded at
> offset from _stext that exceed u32 range, but I also did not
> identified any constraint to feel safe with a u32 offset.
> 
> Log directly the instruction pointer instead of the offset to
> _stext.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
> Fixes: d59158162e03 ("tracing: Add support for preempt and irq enable/disable events")
> ---
>  include/trace/events/preemptirq.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/preemptirq.h b/include/trace/events/preemptirq.h
> index 95fba0471e5b..d548a6aafa18 100644
> --- a/include/trace/events/preemptirq.h
> +++ b/include/trace/events/preemptirq.h
> @@ -18,18 +18,18 @@ DECLARE_EVENT_CLASS(preemptirq_template,
>  	TP_ARGS(ip, parent_ip),
>  
>  	TP_STRUCT__entry(
> -		__field(u32, caller_offs)
> -		__field(u32, parent_offs)
> +		__field(unsigned long, caller_ip)
> +		__field(unsigned long, parent_ip)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->caller_offs = (u32)(ip - (unsigned long)_stext);
> -		__entry->parent_offs = (u32)(parent_ip - (unsigned long)_stext);
> +		__entry->caller_ip = ip;
> +		__entry->parent_ip = parent_ip;
>  	),
>  
>  	TP_printk("caller=%pS parent=%pS",
> -		  (void *)((unsigned long)(_stext) + __entry->caller_offs),
> -		  (void *)((unsigned long)(_stext) + __entry->parent_offs))
> +		  (void *)__entry->caller_ip,
> +		  (void *)__entry->parent_ip)
>  );
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS

