Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D2C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521A9206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WKTKCDS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfDDRkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:40:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38159 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:40:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id g37so1509162plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 10:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1oo6K12iJYAWaTym8dlxd2e2ywtWhKNEEV0QcIZh3TY=;
        b=WKTKCDS5SX0KqUQcE0D0N7nM4M/aSEQe9OsFRBtyRRVbxr0uyRX7IL7idTSRU1pkf1
         Gbg758em8Gx5KnbCiTBgfxcSuJOMRYuEyQoMUr6KjOtGbexysOF0K/wDHv1fllNHg04J
         /0USIhszR+3p0EGOXXMUmAwc35MQSFHjQzH9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1oo6K12iJYAWaTym8dlxd2e2ywtWhKNEEV0QcIZh3TY=;
        b=NX5D8bzydgut1VIdNME2M4A2h+xsA9mBFgQqjOdCQHj1DAVzEUT+hX3G4L2w+8SEGO
         9JLol9soE4lRG1cVoOJo6qVduW8q/YUj3p2gEet6c0ATUY2iCWK9V2+4VIDdJ3VnZj9i
         32okLkFywqqC5C7KE6ndBON4wZfD3ZRYhC43QHdi8QCQHAnSm5d9yW1BlrWoLSiG+4YS
         kMwBUBqFr2mQG64aeS2YFgVjJIaO+8wnmRyH1PGYViMPmYF9Xy/AR3fbQZVfdacVF/bI
         OOE6XKlyQGJVcurg4gMwMSXPvd1mO8KBp9QKRPD/8Is3/CwNPYpJrDW+XWxK2HvnOE5a
         ymkw==
X-Gm-Message-State: APjAAAUAZFQPd9Q+OYGe0P+Dfm/DS14Uiime6Uy2RbVsQci9Hr4+J4NS
        6QATFPnHgbIoCWV0jM7kuehskw==
X-Google-Smtp-Source: APXvYqy71JxwZOgC3nc+46J2y+B4DQ0ykfsoVBsr2L61TMkpA+xJ9oqshXGGuWvaaytFg0ra+ZtC1Q==
X-Received: by 2002:a17:902:28a7:: with SMTP id f36mr7366751plb.169.1554399639526;
        Thu, 04 Apr 2019 10:40:39 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j22sm25630655pfn.129.2019.04.04.10.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 10:40:38 -0700 (PDT)
Date:   Thu, 4 Apr 2019 13:40:37 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Romulo Silva de Oliveira <romulo.deoliveira@ufsc.br>,
        paulmck@linux.vnet.ibm.com, Clark Williams <williams@redhat.com>,
        x86@kernel.org
Subject: Re: [RFC PATCH 0/7] Early task context tracking
Message-ID: <20190404174037.GA183378@google.com>
References: <cover.1554234787.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554234787.git.bristot@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:03:52PM +0200, Daniel Bristot de Oliveira wrote:
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

Just started looking.

Thinking out loud... can we not just update the preempt_count as early on
entry and as late on exit, as possible, and fix it that way? (Haven't fully
yet looked into what could break if we did that.)

I also feel the context tracking should be unified, right now we already have
two methods AFAIK - preempt_count and lockdep. Now this is yet another third.
Granted lockdep cannot be enabled in production, but still. It will be nice
to unify these tracking methods and if there is a single point of all such
context tracking that works well, and even better if we can just fix
preempt_count and use that for non-debugging usecases.

Also I feel in_interrupt() etc should be updated to rely on such tracking
methods if something other than preempt_count is used..

thanks,

 - Joel


> In a trace, they are set like this:
> -------------- %< --------------------
>  0)   ==========> |
>  0)               |  do_IRQ() {		/* First C function */
>  0)               |    irq_enter() {
>  0)               |      		/* set the IRQ context. */
>  0)   1.081 us    |    }
>  0)               |    handle_irq() {
>  0)               |     		/* IRQ handling code */
>  0) + 10.290 us   |    }
>  0)               |    irq_exit() {
>  0)               |      		/* unset the IRQ context. */
>  0)   6.657 us    |    }
>  0) + 18.995 us   |  }
>  0)   <========== |
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
> 
> A possible solution is to use a per-cpu variable set and unset in the
> entry point of NMI/IRQs, before calling the C handler. This possible
> solution is presented in the next patches as a proof of concept, for
> x86_64. However, other ideas might be better than mine... so...
> 
> Daniel Bristot de Oliveira (7):
>   x86/entry: Add support for early task context tracking
>   trace: Move the trace recursion context enum to trace.h and reuse it
>   trace: Optimize trace_get_context_bit()
>   trace/ring_buffer: Use trace_get_context_bit()
>   trace: Use early task context tracking if available
>   events: Create an trace_get_context_bit()
>   events: Use early task context tracking if available
> 
>  arch/x86/entry/entry_64.S       |  9 ++++++
>  arch/x86/include/asm/irqflags.h | 30 ++++++++++++++++++++
>  arch/x86/kernel/cpu/common.c    |  4 +++
>  include/linux/irqflags.h        |  4 +++
>  kernel/events/internal.h        | 50 +++++++++++++++++++++++++++------
>  kernel/softirq.c                |  5 +++-
>  kernel/trace/ring_buffer.c      | 28 ++----------------
>  kernel/trace/trace.h            | 46 ++++++++++++++++++++++--------
>  8 files changed, 129 insertions(+), 47 deletions(-)
> 
> -- 
> 2.20.1
> 
