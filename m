Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5A1C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2290E206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOtj7avi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfH1SB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:01:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39290 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1SB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:01:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id y200so287239pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9cEynbX19AvJzoEgiHwKGteceFTE1ys9oyagJjkZAw=;
        b=rOtj7aviFrxSPtDu5RCopbB3+BGnL8mph6ucHa2CIA7ygi0sOSsEibJuEbbJj94fpQ
         x66iT79k3dbCO/mCbxrmkq9BxvyshcXfzaUejmsf0qfi0qYGAbJCU8dC6nkMp133T8kN
         eGMqnQ6ai9vsiu2yIbbfsiXK4AD5JOIThmRseYbjF6Ocr6f/D3XA5QqyRqTDjmdB+KIW
         bP8eQgpGqZMAzoub5+TCB1FsSsrKQjgf6aCd00I60WHxUq2KP0UoLSTRveezMmwkQFkY
         WkNHgVFaRt5C/18B4Q9hr18vzFE9nwUhW55/xNAUM2v1DnTrw3y74yGKFtwRnA4avGBl
         kBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9cEynbX19AvJzoEgiHwKGteceFTE1ys9oyagJjkZAw=;
        b=r50wkuQAI9rmm2lyPjQtU/kZ5JHTiasra9BToIlT8AsiGqQ1mEPUBdVvMsyiLKxdCp
         Y/cU5HIYgyanBZDpUVMS9ZYQpHZyvQfvmefIpmqu793WgeWQ+2KYADV4KCYk97C0DQSE
         UP1LLoCq9FyAfaviT9GZdSOrRozxE7gCtJ98rKqjYqECnMrOmUT6ZKwHpp1v7Qc3ZDmS
         u6ga5qqGjxyxyZBlf/DtGq32fWjPMqjqVg1BsK5EEdvvfKyz2S2PHkMyLIFhVCJK9GWa
         oi+P2e3kM7Ax3x1ZnYe/p+kWYeXTbHlQxx2Q9c2smAFh6WoT1mi6QigRUQ5rCnFuGv6F
         XmMg==
X-Gm-Message-State: APjAAAXORQ7wrRbbBWwwIeqg6A6MjMAvlt0WSICNuurVMFOgWS+Yr283
        HApI0eYyZEt3TbT91p1oefpRtBDzX+bqcvUBcdcWsg==
X-Google-Smtp-Source: APXvYqwLIJGTP7b3E1+6DKIHKO+TMUth/mMe1NLek/YikeEOUIvfeSOCsus777R/aF0jN7WKBM1D3IrXGdGNjXlUYYo=
X-Received: by 2002:a63:61cd:: with SMTP id v196mr4621079pgb.263.1567015286046;
 Wed, 28 Aug 2019 11:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190812023214.107817-1-natechancellor@gmail.com>
 <878srdv206.fsf@mpe.ellerman.id.au> <20190828175322.GA121833@archlinux-threadripper>
In-Reply-To: <20190828175322.GA121833@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 28 Aug 2019 11:01:14 -0700
Message-ID: <CAKwvOdmXbYrR6n-cxKt3XxkE4Lmj0sSoZBUtHVb0V2LTUFHmug@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Avoid clang warnings around setjmp and longjmp
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:53 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Aug 28, 2019 at 11:43:53PM +1000, Michael Ellerman wrote:
> > Nathan Chancellor <natechancellor@gmail.com> writes:
> >
> > > Commit aea447141c7e ("powerpc: Disable -Wbuiltin-requires-header when
> > > setjmp is used") disabled -Wbuiltin-requires-header because of a warning
> > > about the setjmp and longjmp declarations.
> > >
> > > r367387 in clang added another diagnostic around this, complaining that
> > > there is no jmp_buf declaration.
> > >
> > > In file included from ../arch/powerpc/xmon/xmon.c:47:
> > > ../arch/powerpc/include/asm/setjmp.h:10:13: error: declaration of
> > > built-in function 'setjmp' requires the declaration of the 'jmp_buf'
> > > type, commonly provided in the header <setjmp.h>.
> > > [-Werror,-Wincomplete-setjmp-declaration]
> > > extern long setjmp(long *);
> > >             ^
> > > ../arch/powerpc/include/asm/setjmp.h:11:13: error: declaration of
> > > built-in function 'longjmp' requires the declaration of the 'jmp_buf'
> > > type, commonly provided in the header <setjmp.h>.
> > > [-Werror,-Wincomplete-setjmp-declaration]
> > > extern void longjmp(long *, long);
> > >             ^
> > > 2 errors generated.
> > >
> > > Take the same approach as the above commit by disabling the warning for
> > > the same reason, we provide our own longjmp/setjmp function.
> > >
> > > Cc: stable@vger.kernel.org # 4.19+
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/625
> > > Link: https://github.com/llvm/llvm-project/commit/3be25e79477db2d31ac46493d97eca8c20592b07
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >
> > > It may be worth using -fno-builtin-setjmp and -fno-builtin-longjmp
> > > instead as it makes it clear to clang that we are not using the builtin
> > > longjmp and setjmp functions, which I think is why these warnings are
> > > appearing (at least according to the commit that introduced this waring).
> > >
> > > Sample patch:
> > > https://github.com/ClangBuiltLinux/linux/issues/625#issuecomment-519251372
> >
> > Couldn't we just add those flags to CFLAGS for the whole kernel? Rather
> > than making them per-file.
>
> Yes, I don't think this would be unreasonable. Are you referring to the
> cc-disable-warning flags or the -fno-builtin flags? I personally think
> the -fno-builtin flags convey to clang what the kernel is intending to
> do better than disabling the warnings outright.

The `-f` family of flags have dire implications for codegen, I'd
really prefer we think long and hard before adding/removing them to
suppress warnings.  I don't think it's a solution for this particular
problem.

>
> > I mean there's no kernel code that wants to use clang's builtin
> > setjmp/longjmp implementation at all right?
> >
> > cheers
>
> I did a quick search of the tree and it looks like powerpc and x86/um
> are the only architectures that do anything with setjmp/longjmp. x86/um
> avoids this by using a define flag to change setjmp to kernel_setjmp:
>
> arch/um/Makefile: -Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
>
> Seems like adding those flags should be safe.
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers
