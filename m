Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2296DC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E570A2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557249399;
	bh=BZi/Ql+JdvnRdmHDbdy5yrmzkmSMK3dE27glpzAYFcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DDWnUjSMgiopahnHFbYX0eZilwD63uqeqrRVKDckSEq+H207rg1MzOa8736qi+qzD
	 3JrGaevwMIHD/K5V7kOJDArzfq27r0HaSQolLf2h/GzAJxhBSq3JsJe0HB1ylTQCRM
	 7dAe499FdCi1jGlvHHaRz9XBadc5gNkkHtk5+3TQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfEGRQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:16:37 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43105 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfEGRQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:16:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id u27so12160283lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KUGjoGcov4BXfpien7M8qYX6aNwFIJx0EHxkMkElaU=;
        b=Z6iOqWkun3Jd9gm+DDXapbbb/k9j2i/UbgOnfBaxIvdIF4vaABZyWVyhCMkwQcCtGG
         NQgm6OFnvaJSbD3GdDXE3LA3StNA2Owk7D3wKvpNJgS7nbxcRNbrQfL9JRdZ0dVFZyOm
         4T9KbfhkVqyCfzVxsGzk8bboSYGtVl76YPyag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KUGjoGcov4BXfpien7M8qYX6aNwFIJx0EHxkMkElaU=;
        b=GG7jFntPIexh732Io5Fr7+ycvwEkng5ETeqNXh39zaLWhzW/vaAR67dEgSEnKBLQQm
         sNZXFfcnPMsg1Qsn6jp/8p9IUFQCyQp0bmIRdACCmgV+Ui96cATHpeeTRYzM7dgdxqFX
         52W7okgZAID/2Otn9hQ0LZnL2Cja4fN+dCH7C9PKUI88NjO3WHZ8OVZNQGcSd+vYUc72
         SI5kKoLG6iPgGXFTuss8KrsDY7W9A4PWaifEPYl8TQc9MrNzDlGddHieZ1b6ka7553dm
         TbkklvPuOGghYmr7oZ9PpQfgtF4byiRvmSWqewS4fgguAl2SRNSXdFikce7BxSlN0htB
         a0kA==
X-Gm-Message-State: APjAAAVsPv4gwdv5hLiBV9wpKA0VZp5q+jsMkJaIfR6WTgmLoa7vZomY
        rR0uMg0oAu+TTyDo2FcoUpXPBQiK6vE=
X-Google-Smtp-Source: APXvYqyRvfwkRDPHvZNTIYyrMciobq/Up81iP+AkLXI3egDD1bI4GfzVB3r1x0gZWycjany4mIR+Aw==
X-Received: by 2002:ac2:558d:: with SMTP id v13mr11838320lfg.76.1557249394934;
        Tue, 07 May 2019 10:16:34 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id m15sm3754773lfl.54.2019.05.07.10.16.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:16:34 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id s7so9610745ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:16:34 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr2888004ljg.94.1557248948170;
 Tue, 07 May 2019 10:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whZwqzbu-=1r_j_cXfd=ta1q7RFCuneqBZfQQhS_P-BmQ@mail.gmail.com>
 <20190506215353.14a8ef78@oasis.local.home> <CAHk-=wjLXmOn=Cp=uOfO4gE01eN_-UcOUyrMTTw5-f_OfPO48Q@mail.gmail.com>
 <20190506225819.11756974@oasis.local.home> <CAHk-=wh4FCNBLe8OyDZt2Tr+k9JhhTsg3H8R4b55peKcf0b6eQ@mail.gmail.com>
 <20190506232158.13c9123b@oasis.local.home> <CAHk-=wi4vPg4pu6RvxQrUuBL4Vgwd2G2iaEJVVumny+cBOWMZw@mail.gmail.com>
 <CAHk-=wg2_okyU8mpkGCUrudgfg8YmNetSD8=scNbOkN+imqZdQ@mail.gmail.com>
 <20190507111227.1d4268d7@gandalf.local.home> <CAHk-=wjYdj+vvV8uUA8eaUSxOhu=xuQxdo-dtM927j0-3hSkEw@mail.gmail.com>
 <20190507163440.GV2606@hirez.programming.kicks-ass.net>
In-Reply-To: <20190507163440.GV2606@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 10:08:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuue37opWK5QaQ9f6twqDZuSratdP-1bK6kD9-Az5WnA@mail.gmail.com>
Message-ID: <CAHk-=wiuue37opWK5QaQ9f6twqDZuSratdP-1bK6kD9-Az5WnA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] x86: Allow breakpoints to emulate call functions
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        Joerg Roedel <jroedel@suse.de>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 9:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Would you consider my approach later on, under the guise of unification?

WHY?

The *only* advantage of your patch is that trivial "look up kernel stack" macro.

Seriously. There's absolutely nothing else.

Is that macro ugly? Yes. But it's directly explainable by just
pointing to the architecture documentation.

It's a one-liner hack.

And for that, you want to complicate the x86-32 entry and exit code?

Do we have different emulation for "push" on 32-bit and 64-bit? Yes.
But again, that's just how the hardware works. This is not some
"generic hw-independent code". This is literally emulating
instructions that care about instruction encoding and bit size
details, where there are certainly _similarities_ (and in the case of
'call', they look bit-identical), but it's also not like "same code"
is a big argument. That's why we have a helper function, to hide the
details.

I point to my diffstat once again. It's smaller, and I argue that it
is actually conceptually *simpler* to simply say "this is how the
architecture works".

And yes, I realize that I may be biased by the fact that I simply know
i386 so well, so to me it simply makes more sense to just work with
what the hardware gives us. The i386 exception model with the kernel
stack nesting is a *hell* of a lot simpler than the x86-64 one. The
fact is, x86-64 messed things up, and swapgs and friends are an
abomination against God.

So the whole "let's clean up x86-32 to look like x86-64, which got
things right" is to me a completely bogus argument. x86-64 got the
"yes, push ss/sp unconditionally" part right, but got a lot of other
things horribly wrong. So this is all just one small detail that
differs, across two architectures that are similar but have very
different warts.

But that diffstat is still hard, cold, unbiased data.

                    Linus
