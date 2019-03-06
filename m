Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1306AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B7C206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fmczhx+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbfCFOlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:41:40 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32988 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfCFOlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:41:39 -0500
Received: by mail-io1-f65.google.com with SMTP id e186so10398225ioa.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 06:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2WfZ12UmlecEWrugyx7y8Ud5L7Bf4NFhWfw1yQJtMg=;
        b=Fmczhx+1mVEkvwVBWd64Z2jO5vITtAJw3ya/oju8udASiaj7D8q9x7WI/rcd2YXy8S
         zry82lL7ncHKeGT4QnU4ClqTpsqxywAy1dN5Q/HhPFQllmMydrvj10HAiDGljJxO4tZj
         0OhGdog2DLcjCrF7NDxs9OhbcHg+SJzjIf7Ayu7fFzgT8tmWcUIVOj6YRKTphKfeunLe
         EPFqadA0OT/+UF7XmpAqld2+Vb48gT03uMQAQ8b/kNJWqSImbt0E+GtBkOKr5Sw6wcPf
         yeDPdCvIdKUSY0Yy7Llf56z9KRtd4nE9xaiLiJtRk4zm1gs2nX0wGTfmTvC6oAoBn+8E
         yBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2WfZ12UmlecEWrugyx7y8Ud5L7Bf4NFhWfw1yQJtMg=;
        b=socI/VVFvLBFXD7QQy3x/hmq1qUMuenvH/8FP2UBQbDfmYVdU9/MdOg+j6Rd/FBEJK
         3CVmyQ3WfDLC5YfYAp3MgwF7HNmrr69m9xmdFBZyQvLNCzD4JIzdONXLz25CU4NlvjVw
         MxsBSY3umAlXjB/vwaR1emktdwtr7tV1JRIZcmToXfab8HkvutRynBnffyS90ZYF/j3J
         aoOYoxExsbRq6oQPgyyWc/fBlEdvp4IkeD0C+wIFQEZxPIPXs0FStO82thzOJ7qnabAE
         Ds5/YQ//sc0yqhN0WyJ7kAKm5KijPINtWvl4XQC3l43DJWHySoLZJuyhgFdJbdENkDm6
         yRDg==
X-Gm-Message-State: APjAAAXdiFuZ2rE68N2/vUOtODpvEf7p/0h3D8V8PkSdeZtrcohJGg1r
        CnWfYmUu4amGktFbSbS+LaySLEfUcKZaahHbnE7Twg==
X-Google-Smtp-Source: APXvYqzvy4RTi7BFgskAPvx0x90xmhdiCUKqrDuaKSxvT6bjBZ8vG2uC5IkvGDukAJz4i02im6ClUqTBwb2vP97nnTo=
X-Received: by 2002:a5d:834a:: with SMTP id q10mr3091863ior.271.1551883298492;
 Wed, 06 Mar 2019 06:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20190228150152.078767622@infradead.org> <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net> <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net> <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com>
 <20190306135728.GV32477@hirez.programming.kicks-ass.net> <CACT4Y+YP+Xn3TxVXrza_LBK8m7CCKBUYWpuGS0+MzFCXEE+Akg@mail.gmail.com>
 <20190306141237.GW32477@hirez.programming.kicks-ass.net> <20190306143439.GY32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YmQBc67hU2exY5=tAVG1jWNUeZ7FAm+GGgqDvOH7cu1A@mail.gmail.com>
In-Reply-To: <CACT4Y+YmQBc67hU2exY5=tAVG1jWNUeZ7FAm+GGgqDvOH7cu1A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 Mar 2019 15:41:27 +0100
Message-ID: <CACT4Y+bu5pZDXv+iF4yhjKR22DUNh27Qb287uNViPdwRvQcxuQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:40 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Mar 6, 2019 at 3:34 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Mar 06, 2019 at 03:12:37PM +0100, Peter Zijlstra wrote:
> > > On Wed, Mar 06, 2019 at 03:01:33PM +0100, Dmitry Vyukov wrote:
> > > > On Wed, Mar 6, 2019 at 2:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > > > I've not found callers of __asan_report_load* with AC=1 in the kernel
> > > > > yet. Under what condtions does GCC emit calls to these functions?
> > > >
> > > > CONFIG_KASAN_INLINE=y
> > > > Then compiler inlines fast path into generated code and only calls
> > > > into runtime to report errors (also, faster, this should be a default
> > > > for anything other than tiny ROM controllers).
> > >
> > > *sigh*, clearly I've not build enough kernels yet... Lemme go try that.
> >
> > mm/kasan/generic_report.o: warning: objtool: __asan_report_load1_noabort()+0x0: call to __fentry__() with UACCESS enabled
> >
> > You want to do:
> >
> > CFLAGS_REMOVE_f= -pg
> >
> > like generic.o has?
>
> This should not matter for KASAN itself.
> KASAN will call into function tracer, and function tracer will call
> into KASAN, but unless function tracer is badly broken and causes a
> KASAN report on every invocation, the recursion will end (function
> tracer will get to the _report_ function). So we only disabled -pg for

tracer will _not_ get to the _report_ function

> fast paths.
> But if it makes things simpler for the objtool, then I think we can
> disable function tracer for generic_report.c too.
