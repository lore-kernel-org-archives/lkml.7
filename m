Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698AC43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E5020675
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfD1VW7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 17:22:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:46358 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbfD1VW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 17:22:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2C0EADF7;
        Sun, 28 Apr 2019 21:22:56 +0000 (UTC)
From:   Nicolai Stange <nstange@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/thread_info: introduce ->ftrace_int3_stack member
References: <20190427100639.15074-1-nstange@suse.de>
        <20190427100639.15074-2-nstange@suse.de>
        <F6268634-96D3-4267-B739-6D375FAB26A8@amacapital.net>
        <20190428135143.09d35bb6@oasis.local.home>
Date:   Sun, 28 Apr 2019 23:22:54 +0200
In-Reply-To: <20190428135143.09d35bb6@oasis.local.home> (Steven Rostedt's
        message of "Sun, 28 Apr 2019 13:51:43 -0400")
Message-ID: <87k1fdygcx.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Sun, 28 Apr 2019 10:41:10 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>
>> > Note that at any given point
>> > in time, there can be at most four such call insn emulations pending:
>> > namely at most one per "process", "irq", "softirq" and "nmi" context.
>> >   
>> 
>> That’s quite an assumption. I think your list should also contain
>> exception, exceptions nested inside that exception, and machine
>> check, at the very least.  I’m also wondering why irq and softirq are
>> treated separately.

You're right, I missed the machine check case.


> 4 has usually been the context count we choose. But I guess in theory,
> if we get exceptions then I could potentially be more.

After having seen the static_call discussion, I'm in no way defending
this limited approach here, but out of curiosity: can the code between
the push onto the stack from ftrace_int3_handler() and the subsequent
pop from the stub actually trigger an (non-#MC) exception? There's an
iret inbetween, but that can fault only when returning to user space,
correct?


> As for irq vs softirq, an interrupt can preempt a softirq. Interrupts
> are enabled while softirqs are running. When sofirqs run, softirqs are
> disabled to prevent nested softirqs. But interrupts are enabled again,
> and another interrupt may come in while a softirq is executing.
>

Thanks,

Nicolai


-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
