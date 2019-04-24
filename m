Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E9DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5146206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbfDXGUP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:20:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:42306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbfDXGUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:20:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ECBD4AF8F;
        Wed, 24 Apr 2019 06:20:13 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Nicolai Stange <nstange@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 1/1] x86/ftrace: make ftrace_int3_handler() not to skip fops invocation
References: <20180726104029.7736-1-nstange@suse.de>
        <20180726104029.7736-2-nstange@suse.de>
        <20190419160513.1faa01d2@gandalf.local.home> <87ef5sfuzu.fsf@suse.de>
        <20190423195023.425902dc@gandalf.local.home>
Date:   Wed, 24 Apr 2019 08:20:12 +0200
In-Reply-To: <20190423195023.425902dc@gandalf.local.home> (Steven Rostedt's
        message of "Tue, 23 Apr 2019 19:50:23 -0400")
Message-ID: <87bm0vexgj.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:
> On Tue, 23 Apr 2019 20:15:49 +0200
> Nicolai Stange <nstange@suse.de> wrote:
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> > For 32 bit, we could add 4 variables on the thread_info and make 4
>> > trampolines, one for each context (normal, softirq, irq and NMI), and
>> > have them use the variable stored in the thread_info for that location:
>> >
>> > ftrace_int3_tramp_normal
>> > 	push %eax # just for space
>> > 	push %eax
>> > 	mov whatever_to_get_thread_info, %eax
>> > 	mov normal(%eax), %eax
>> > 	mov %eax, 4(%esp)
>> > 	pop %eax
>> > 	jmp ftrace_caller
>> >
>> > ftrace_int3_tramp_softiqr
>> > 	push %eax # just for space
>> > 	push %eax
>> > 	mov whatever_to_get_thread_info, %eax
>> > 	mov softirq(%eax), %eax
>> > 	mov %eax, 4(%esp)
>> > 	pop %eax
>> > 	jmp ftrace_caller
>> >
>> > etc..
>> >
>> >
>> > A bit crazier for 32 bit but it can still be done. ;-)  
>> 
>> Ok, but currently CONFIG_HAVE_LIVEPATCH=n for x86 && !x86_64,
>> so I'd rather not invest too much energy into screwing 32 bit up ;)
>>
>
> Probably not something you care about, but something that I do. Which
> means it will have to go on my TODO list. I care about missed functions
> being called. This means, if you have something tracing a function, and
> then enable something else to trace that same function, you might miss
> the first one.

Alright, if there's a use case beyond live patching, I can try to handle
32 bits alongside, of course.

However, some care will be needed when determining the actual context
from ftrace_int3_handler(): tracing anything before the addition or
after the subtraction of HARDIRQ_OFFSET to/from preempt_count in
irq_enter() resp. irq_exit() could otherwise clobber the "normal" state
in thread_info, correct?

How about having a fixed size stack with three entries shared between
"normal", "irq" and "softirq" in thread_info, as well as a dedicated
slot for nmi context? (The stack would be modified/consumed only with
irqs disabled).

Which makes me wonder:
- if we disabled preemption from ftrace_int3_handler() and reenabled it
  again from the *_int3_tramp*s, these stacks could be made per-CPU,
  AFAICS,
- and why not use this strategy on x86_64, too? The advantages would be
  a common implemention between 32 and 64 bit and more importantly, not
  relying on that %r11 hack. When doing the initial RFC patch, it
  wasn't clear to me that at most one stack slot per context would be
  needed, i.e. only four in total...

What do you think?

Nicolai

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
