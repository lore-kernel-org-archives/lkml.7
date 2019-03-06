Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9EC20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+U7TSDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfCFN5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:57:39 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42674 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCFN5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RHPTv/EmRp1TyY2mV7FERh6a9cFf4JRjUFOY9JCHF/U=; b=G+U7TSDh0pE4cWzFzYbq029NF
        S3biKJgsOM1mj0LWgdSx+zKwnC+D7lX38L3EkF1TURgj3lcAc6GxEUnAALJnv7rc0LWFxcyJgsO4Q
        o4UqlQFH1QehGr3/zjcd9qcIrOcWjwNGpmdtKmLQvG2qVSxKSjgBGon6y8JqDLPsk+up5ibNimFAJ
        A72r/g51PTnJe44y3pC3Ui2YHaZn8n0Wzifa9SxpHV7XGBueBJRZY6N4rXBua8SFpOT4hgiy3ylaZ
        PZAlBFaLL1XDaFLaTDm8B/5GpelwnmVzICSCB40OYVyXO4fGRC4d/7duP0X1iOZSQWhYxMYRZnOeO
        sQv6p9YIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h1X35-0002X2-Eu; Wed, 06 Mar 2019 13:57:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D909420288BA3; Wed,  6 Mar 2019 14:57:28 +0100 (CET)
Date:   Wed, 6 Mar 2019 14:57:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
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
Subject: Re: [PATCH 1/8] kasan,x86: Frob kasan_report() in an exception
Message-ID: <20190306135728.GV32477@hirez.programming.kicks-ass.net>
References: <20190228145450.289603901@infradead.org>
 <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net>
 <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net>
 <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 02:39:33PM +0100, Dmitry Vyukov wrote:
> On Wed, Mar 6, 2019 at 2:13 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > annotated:
> >
> > 0000 0000000000000150 <__asan_load1>:
> > 0000  150:      48 b8 ff ff ff ff ff    movabs $0xffff7fffffffffff,%rax
> > 0007  157:      7f ff ff
> > 000a  15a:      53                      push   %rbx
> 
> /\/\/\/\/\/\
> 
> This push is unpleasant on hot fast path. I think we need to move
> whole report cold path into a separate noinline function as it is now,
> and that function will do the magic with smap. Then this won't prevent
> tail calling and won't affect fast-path codegen.

It's a bit daft of GCC to do that anyway; since it only uses that rbx
thing in the cold path at __asan_load1+0x30.

But yes, that wants fixing or something. Then again; a kernel with KASAN
on is unbearable slow anyway.

> > 000b  15b:      48 8b 4c 24 08          mov    0x8(%rsp),%rcx
> > 0010  160:      48 39 c7                cmp    %rax,%rdi
> > 0013  163:      76 24                   jbe    189 <__asan_load1+0x39>
> > 0015  165:      48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> > 001c  16c:      fc ff df
> > 001f  16f:      48 89 fa                mov    %rdi,%rdx
> > 0022  172:      48 c1 ea 03             shr    $0x3,%rdx
> > 0026  176:      0f b6 04 02             movzbl (%rdx,%rax,1),%eax
> > 002a  17a:      84 c0                   test   %al,%al
> > 002c  17c:      75 02                   jne    180 <__asan_load1+0x30>
> > 002e  17e:      5b                      pop    %rbx
> > 002f  17f:      c3                      retq

^^^ hot path, vvv cold path

> > 0030  180:      89 fa                   mov    %edi,%edx
> > 0032  182:      83 e2 07                and    $0x7,%edx
> > 0035  185:      38 d0                   cmp    %dl,%al
> > 0037  187:      7f f5                   jg     17e <__asan_load1+0x2e>
> > 0039  189:      9c                      pushfq
> > 003a  18a:      5b                      pop    %rbx
> > 003b  18b:      90                      nop
> > 003c  18c:      90                      nop
> > 003d  18d:      90                      nop
> > 003e  18e:      31 d2                   xor    %edx,%edx
> > 0040  190:      be 01 00 00 00          mov    $0x1,%esi
> > 0045  195:      e8 00 00 00 00          callq  19a <__asan_load1+0x4a>
> > 0046                    196: R_X86_64_PLT32     __kasan_report-0x4
> > 004a  19a:      53                      push   %rbx
> > 004b  19b:      9d                      popfq
> > 004c  19c:      5b                      pop    %rbx
> > 004d  19d:      c3                      retq

> > +static __always_inline
> > +void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > +{
> > +       unsigned long flags;
> > +
> > +       flags = smap_save();
> 
> Previously you said that messing with smap here causes boot errors.
> Shouldn't we do smap_save iff kasan_report_enabled? Otherwise we just
> bail out, so no need to enable/disable smap.
> 
> > +       __kasan_report(addr, size, is_write, ip);
> > +       smap_restore(flags);
> > +
> > +}

Ah, you think I booted this :-) Still, this is only PUSHF;CLAC, which I
think should actually work really early. It was that #UD thing that
didn't work early, simply because we'd not set up the exception vector
yet when first this happens.

> > --- a/mm/kasan/generic_report.c
> > +++ b/mm/kasan/generic_report.c
> > @@ -118,14 +118,14 @@ const char *get_bug_type(struct kasan_ac
> >  #define DEFINE_ASAN_REPORT_LOAD(size)                     \
> >  void __asan_report_load##size##_noabort(unsigned long addr) \
> >  {                                                         \
> > -       kasan_report(addr, size, false, _RET_IP_);        \
> > +       __kasan_report(addr, size, false, _RET_IP_);      \
> 
> Unless I am missing something, this seems to make this patch no-op. We
> fixed kasan_report for smap, but here we now use __kasan_report which
> is not fixed. So this won't work with smap again?..

I've not found callers of __asan_report_load* with AC=1 in the kernel
yet. Under what condtions does GCC emit calls to these functions?
