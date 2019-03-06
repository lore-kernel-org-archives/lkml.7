Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8F420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 14:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OX75kOCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfCFOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 09:01:47 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37984 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfCFOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 09:01:45 -0500
Received: by mail-it1-f196.google.com with SMTP id l66so10249458itg.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 06:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tsNIDto6QQew93aSnqY6koG0mkudkrBGQthZCJmDnSY=;
        b=OX75kOCkdNvnwqodrYRNKIrvbSDgZyLNM9uaFCOcaGuq7DC4CF+m5EVfGJtATblWBB
         jdAw4CZbHbTdtQQNuivvxY0BB/+M96WuQpTklcyOdOxyhDZet5dMPvgHfVjFodw2uXRU
         ifyLrHzh9qpgYgLCUEqHoM+x/1D+81K6XnujissCpM0jHvEcddo5mKH2cCwo+NP3n+F2
         4tkn4MLu7pIjRt5480AuavDB3yRVLQxaxGflCIqpPizNVjtHl/L3/4XhQc7e68/KP0hA
         OQcPrprTiJTK690rqOjWf6hSLamHg5nm92TcEmi/qMmtBwztogaTbmwqpd2PKFsoYaRq
         bAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tsNIDto6QQew93aSnqY6koG0mkudkrBGQthZCJmDnSY=;
        b=VWWBBIm4ioQ/CiHkB5//TmEVIxw3wqlCYqwX1tc2zbNn1B9l0eWySwH0dialn6lutf
         3ssOEQHiLitrsDPQwZG4GewGrwA2uzgLFnHNtMydxyP6T84xa7HwXLxCJC3UUpAMLghk
         PuczaeP+pFqzipe2h9MTHF4yz9nFlkgKf0mH0HnF5el6RrIQ6HlkMpq+PgEz4DpeDW2A
         SxCqUjREQju/WLLoU9W8mrKPWW2FykvGg9+B7Z3mYR7z0EwvK3KQdHN0AK7HylWceBoA
         xIGgAV/sJg9us8CSc2WoaR+oZ8RZ7fRoP+UriUqVoxK9X94MFcXh/HQVl/5NSiTIJJNS
         sA4Q==
X-Gm-Message-State: APjAAAUdVzdQUoo28u11MBrT9UG/Pb7q9NzLTXOCHYgGtPOMKRlqy1nQ
        MZ0nhCEa4KH1Hd+QFipvjF05t846kezi8TXlpMR07Q==
X-Google-Smtp-Source: APXvYqwDM+wvMfR4PSK4hpNnlSrzv4TcazkAqt37EpLKfi67+AFaVll/N9BBUOAiJqhttWCAWUiK0SX/p2X9PbReoIM=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr1807876ita.144.1551880904512;
 Wed, 06 Mar 2019 06:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20190228145450.289603901@infradead.org> <20190228150152.078767622@infradead.org>
 <CACT4Y+b0WyE5En7BVipZiCMmMaj30kaEu3T68H7+-kVP8gqADA@mail.gmail.com>
 <20190301144556.GY32477@hirez.programming.kicks-ass.net> <CACT4Y+ZyXAJiKtzoWxY-u7e9HaL7iM9tnFXnFZd7Hdy4uHEOyA@mail.gmail.com>
 <20190301152305.GJ32494@hirez.programming.kicks-ass.net> <20190306131347.GX32534@hirez.programming.kicks-ass.net>
 <CACT4Y+YFkDRwTN1MKqLDePfuRis3Qas1kgEF7g5eVR0ijodtkw@mail.gmail.com> <20190306135728.GV32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190306135728.GV32477@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 6 Mar 2019 15:01:33 +0100
Message-ID: <CACT4Y+YP+Xn3TxVXrza_LBK8m7CCKBUYWpuGS0+MzFCXEE+Akg@mail.gmail.com>
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

On Wed, Mar 6, 2019 at 2:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 06, 2019 at 02:39:33PM +0100, Dmitry Vyukov wrote:
> > On Wed, Mar 6, 2019 at 2:13 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > > annotated:
> > >
> > > 0000 0000000000000150 <__asan_load1>:
> > > 0000  150:      48 b8 ff ff ff ff ff    movabs $0xffff7fffffffffff,%rax
> > > 0007  157:      7f ff ff
> > > 000a  15a:      53                      push   %rbx
> >
> > /\/\/\/\/\/\
> >
> > This push is unpleasant on hot fast path. I think we need to move
> > whole report cold path into a separate noinline function as it is now,
> > and that function will do the magic with smap. Then this won't prevent
> > tail calling and won't affect fast-path codegen.
>
> It's a bit daft of GCC to do that anyway; since it only uses that rbx
> thing in the cold path at __asan_load1+0x30.
>
> But yes, that wants fixing or something. Then again; a kernel with KASAN
> on is unbearable slow anyway.
>
> > > 000b  15b:      48 8b 4c 24 08          mov    0x8(%rsp),%rcx
> > > 0010  160:      48 39 c7                cmp    %rax,%rdi
> > > 0013  163:      76 24                   jbe    189 <__asan_load1+0x39>
> > > 0015  165:      48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
> > > 001c  16c:      fc ff df
> > > 001f  16f:      48 89 fa                mov    %rdi,%rdx
> > > 0022  172:      48 c1 ea 03             shr    $0x3,%rdx
> > > 0026  176:      0f b6 04 02             movzbl (%rdx,%rax,1),%eax
> > > 002a  17a:      84 c0                   test   %al,%al
> > > 002c  17c:      75 02                   jne    180 <__asan_load1+0x30>
> > > 002e  17e:      5b                      pop    %rbx
> > > 002f  17f:      c3                      retq
>
> ^^^ hot path, vvv cold path
>
> > > 0030  180:      89 fa                   mov    %edi,%edx
> > > 0032  182:      83 e2 07                and    $0x7,%edx
> > > 0035  185:      38 d0                   cmp    %dl,%al
> > > 0037  187:      7f f5                   jg     17e <__asan_load1+0x2e>
> > > 0039  189:      9c                      pushfq
> > > 003a  18a:      5b                      pop    %rbx
> > > 003b  18b:      90                      nop
> > > 003c  18c:      90                      nop
> > > 003d  18d:      90                      nop
> > > 003e  18e:      31 d2                   xor    %edx,%edx
> > > 0040  190:      be 01 00 00 00          mov    $0x1,%esi
> > > 0045  195:      e8 00 00 00 00          callq  19a <__asan_load1+0x4a>
> > > 0046                    196: R_X86_64_PLT32     __kasan_report-0x4
> > > 004a  19a:      53                      push   %rbx
> > > 004b  19b:      9d                      popfq
> > > 004c  19c:      5b                      pop    %rbx
> > > 004d  19d:      c3                      retq
>
> > > +static __always_inline
> > > +void kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> > > +{
> > > +       unsigned long flags;
> > > +
> > > +       flags = smap_save();
> >
> > Previously you said that messing with smap here causes boot errors.
> > Shouldn't we do smap_save iff kasan_report_enabled? Otherwise we just
> > bail out, so no need to enable/disable smap.
> >
> > > +       __kasan_report(addr, size, is_write, ip);
> > > +       smap_restore(flags);
> > > +
> > > +}
>
> Ah, you think I booted this :-) Still, this is only PUSHF;CLAC, which I
> think should actually work really early. It was that #UD thing that
> didn't work early, simply because we'd not set up the exception vector
> yet when first this happens.
>
> > > --- a/mm/kasan/generic_report.c
> > > +++ b/mm/kasan/generic_report.c
> > > @@ -118,14 +118,14 @@ const char *get_bug_type(struct kasan_ac
> > >  #define DEFINE_ASAN_REPORT_LOAD(size)                     \
> > >  void __asan_report_load##size##_noabort(unsigned long addr) \
> > >  {                                                         \
> > > -       kasan_report(addr, size, false, _RET_IP_);        \
> > > +       __kasan_report(addr, size, false, _RET_IP_);      \
> >
> > Unless I am missing something, this seems to make this patch no-op. We
> > fixed kasan_report for smap, but here we now use __kasan_report which
> > is not fixed. So this won't work with smap again?..
>
> I've not found callers of __asan_report_load* with AC=1 in the kernel
> yet. Under what condtions does GCC emit calls to these functions?

CONFIG_KASAN_INLINE=y
Then compiler inlines fast path into generated code and only calls
into runtime to report errors (also, faster, this should be a default
for anything other than tiny ROM controllers).
