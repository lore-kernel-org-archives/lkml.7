Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42ACC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CEC2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554336079;
	bh=ZPX475rPsm+JcsUyCA+9ooqeKYzOEmOziLymNX1DeUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lwBjuZRTulW76xpmjTwL6SgN2KuiJ5/KqacU5EEuVtCz69kB3o5yZm1yTf1AGQ7/g
	 PzggexsH9+SC9LJMOQEvjiGbEaJtO5HUjhZe476xRtpIOQv6cd82HSA8g52FRbvtlJ
	 cl5h3yG9R7ukPCX5tHpcbOYdVqEVr/Cb7JMGi/ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDDABS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:01:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDDABR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:01:17 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 261B4217D7
        for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2019 00:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554336076;
        bh=ZPX475rPsm+JcsUyCA+9ooqeKYzOEmOziLymNX1DeUY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xHIxqd2gVYkBgGYcWilTWX4CLXHkENLc0Kx3g5CMt0pjeINfBB4/DHHCH/naeBGvX
         e++4o8xEsYUO5Q7UfsWRBIQE/YtGtTNgD7W2WBqixbRwK8m9fDN0ydTLBYg0fYDWKN
         0AtTH/ONyO/mOyc7QJrU3pUnDBCxPSTs+Ad947+g=
Received: by mail-wr1-f54.google.com with SMTP id q1so1157408wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:01:16 -0700 (PDT)
X-Gm-Message-State: APjAAAVGne98nleiqWwcSAe0VXhBFekuF2iGVYIMsUqONvfrK2zPrd9A
        JjUCMgdPsjR5V0+5QIiBVg7qVsBvQEExAmrqpXjlHQ==
X-Google-Smtp-Source: APXvYqxdLiqNtNmd5aMosiU+evC+jauccAjaFlB71Eq0MsLYq9beXZPg/BYtNbmmma+SUTaDWQ6W+RNt1Att2LJ0Wxc=
X-Received: by 2002:adf:fd46:: with SMTP id h6mr1598988wrs.139.1554336074602;
 Wed, 03 Apr 2019 17:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1554234787.git.bristot@redhat.com>
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 3 Apr 2019 17:01:02 -0700
X-Gmail-Original-Message-ID: <CALCETrXUx7ExeqERxwu7nfps9vhZhQbfNEFG5fD_Kp7RexCEcA@mail.gmail.com>
Message-ID: <CALCETrXUx7ExeqERxwu7nfps9vhZhQbfNEFG5fD_Kp7RexCEcA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Early task context tracking
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        Clark Williams <williams@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 2, 2019, at 2:03 PM, Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
>
> Note: do not take it too seriously, it is just a proof of concept.
>
> Some time ago, while using perf to check the automaton model, I noticed
> that perf was losing events. The same was reproducible with ftrace.
>
> See: https://www.spinics.net/lists/linux-rt-users/msg19781.html
>
> Steve pointed to a problem in the identification of the context
> execution used by the recursion control.
>
> Currently, recursion control uses the preempt_counter to
> identify the current context. The NMI/HARD/SOFT IRQ counters
> are set in the preempt_counter in the irq_enter/exit functions.
>
> In a trace, they are set like this:
> -------------- %< --------------------
> 0)   ==========> |
> 0)               |  do_IRQ() {        /* First C function */
> 0)               |    irq_enter() {
> 0)               |              /* set the IRQ context. */
> 0)   1.081 us    |    }
> 0)               |    handle_irq() {
> 0)               |             /* IRQ handling code */
> 0) + 10.290 us   |    }
> 0)               |    irq_exit() {
> 0)               |              /* unset the IRQ context. */
> 0)   6.657 us    |    }
> 0) + 18.995 us   |  }
> 0)   <========== |
> -------------- >% --------------------
>
> As one can see, functions (and events) that take place before the set
> and after unset the preempt_counter are identified in the wrong context,
> causing the miss interpretation that a recursion is taking place.
> When this happens, events are dropped.
>
> To resolve this problem, the set/unset of the IRQ/NMI context needs to
> be done before the execution of the first C execution, and after its
> return. By doing so, and using this method to identify the context in the
> trace recursion protection, no more events are lost.

I would much rather do the opposite: completely remove context
tracking from the asm and, instead, stick it into the C code.  We'd
need to make sure that the C code is totally immune from tracing,
kprobes, etc, but it would be a nice cleanup.  And then you could fix
this bug in C!


>
> A possible solution is to use a per-cpu variable set and unset in the
> entry point of NMI/IRQs, before calling the C handler. This possible
> solution is presented in the next patches as a proof of concept, for
> x86_64. However, other ideas might be better than mine... so...
>
> Daniel Bristot de Oliveira (7):
>  x86/entry: Add support for early task context tracking
>  trace: Move the trace recursion context enum to trace.h and reuse it
>  trace: Optimize trace_get_context_bit()
>  trace/ring_buffer: Use trace_get_context_bit()
>  trace: Use early task context tracking if available
>  events: Create an trace_get_context_bit()
>  events: Use early task context tracking if available
>
> arch/x86/entry/entry_64.S       |  9 ++++++
> arch/x86/include/asm/irqflags.h | 30 ++++++++++++++++++++
> arch/x86/kernel/cpu/common.c    |  4 +++
> include/linux/irqflags.h        |  4 +++
> kernel/events/internal.h        | 50 +++++++++++++++++++++++++++------
> kernel/softirq.c                |  5 +++-
> kernel/trace/ring_buffer.c      | 28 ++----------------
> kernel/trace/trace.h            | 46 ++++++++++++++++++++++--------
> 8 files changed, 129 insertions(+), 47 deletions(-)
>
> --
> 2.20.1
>
