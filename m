Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115C0C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D606520B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557156131;
	bh=p9cfo3m1Ts3w8J07gmYD2ePngvwF7KVRPiDF2H+3Un4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NS0UqoIGOzBf3MIspice8vWp0tebgjYi4np3KAdeG3qr/MQAjaQ1bnFTYkHV2kLkD
	 6yxjZATowOIupRCB+im3jFebOTldOPRVnu1+T3zCzCglwSZJSXBmkW1w7Fy+70S953
	 nsy7FnEsXaHdPCOc2qOWJbvV1yi6cjMcB/CBK+eA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfEFPWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 11:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfEFPWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 11:22:10 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADE602087F;
        Mon,  6 May 2019 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557156129;
        bh=p9cfo3m1Ts3w8J07gmYD2ePngvwF7KVRPiDF2H+3Un4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPpnYiKPpUqLt5Vbktm/iG4hyQVfkY6P+CYTuLitYMNkINkGE9NEFan0ZDtJo4R5A
         dVQX6NVq0ajEDHy2RNDDkVn2kTfgbGd83HW2x/9gWVx0kFmBrg3cmgf/7c38EC2CX6
         LCaWcHSjCKa2ILDi5F7Qi+2LmUZpPEISa4aOb8l0=
Date:   Tue, 7 May 2019 00:22:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [RFC PATCH v6 1/6] x86/uaccess: Allow access_ok() in irq
 context if pagefault_disabled
Message-Id: <20190507002203.1db020838c07a12bec87ca73@kernel.org>
In-Reply-To: <20190321224602.1e31aded@oasis.local.home>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
        <155289139725.7218.17265500814527931961.stgit@devnote2>
        <20190321224602.1e31aded@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

It seems I missed this message...

On Thu, 21 Mar 2019 22:46:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 18 Mar 2019 15:43:17 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > WARN_ON_IN_IRQ() assumes that the access_ok() and following
> > user memory access can sleep. But this assumption is not
> > always correct; when the pagefault is disabled, following
> > memory access will just returns -EFAULT and never sleep.
> > 
> > Add pagefault_disabled() check in WARN_ON_ONCE() so that
> > it can ignore the case we call it with disabling pagefault.
> > For this purpose, this modified pagefault_disabled() as
> > an inline function.
> > 
> 
> Actually, accessing user space from an interrupt doesn't really make
> sense. Now I'm differentiating a true interrupt (like a device handler)
> from an exception. The difference is that an exception is synchronous
> with the execution of the code, but an interrupt is something where you
> don't know what task is running. A uaccess in this type of interrupt
> will randomly grab some user space memory but have no idea what task is
> running.

I see. Would you mean the title is incorrect?

> 
> The one time this makes sense is if you are doing some kind of
> profiling, where the randomness is fine.

Agreed.

> 
> I'm curious, what interrupt handler are kprobes executing in that needs
> random user space addresses?

Sorry for confusion. Kprobes is using an exception (of course!). So the
title can mislead, it should be "in exception" instead of "in irq context",
However, current code checks it by "!in_task()", which includes both of
IRQ and exception. A better solution might change it to "in_irq()".

However, I could not find a way to distinguish the "exception" and
"external IRQ" by the execution context (based on the preempt count)
because exception is treated as a kind of IRQ.
Thus, in this patch, I changed it as not only checking what the context
is, but also whether it is appropriately called.


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
