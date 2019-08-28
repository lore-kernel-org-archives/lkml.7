Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B92C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1B222CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZb7Xt/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfH1Spf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:45:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40150 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfH1Spe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:45:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so828537wrd.7;
        Wed, 28 Aug 2019 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uzb7erekU8g2iYVyP5gycVR/YMGgpJBA2pn7vNp581E=;
        b=JZb7Xt/l4fzTVyq93q6g8wGivNG1U7RglbzIf1zZBaafcZVV1Sf3O1e+CCrfxZGWAU
         QpMkYRRpANt4ruc23Ey5+H70EYPq2nm7buGcCdMD6vo/K3ZYREdZjfF8dbRc6l8bTWuU
         TjQJiasEYcfyQgmOcqadV0klVf/TtB3ZuMODVSMto3VdhZUdDMkWdYnbPfbHJYSRpXPC
         /CV1p+bC25/oYdeFfaofr7vDRQBrOLl71d8mjWBIuurGQjhA7O3N8cy6yi5n5gUYttbt
         uSX4Wz31KAdqWvF7Zaizgc7l0pkliJPNXocX8H0lwOPwYDpZECU4AD7Sy76br5JIbryk
         rnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uzb7erekU8g2iYVyP5gycVR/YMGgpJBA2pn7vNp581E=;
        b=P9dIHAxhIMgdxILXVwgfRDUb9V9QRqdFghi4TuRqYXp4bg3DCUeY4E43B/05WvmrUv
         2DzjBO1U4Y2JLFXCFxyiot9FqDaiK2S5Z98tDLN61jJpWQGGozlIxe80cLxQ3LQ8OQEM
         BNZ8DfPd5Vs3va1YoOFG3dPq0D8ylN3HjO78s3kKnCDA92qpKBIZ4XvQuCS65MP38G+s
         Hbq5yRmulJZnSsvYrgOmwE2KUWzGPM+exngAJYB36adj8Z0DQjwGLufGqhDi00Ca/weD
         00iCww+LXZDPKxtbG1AGB63Zb55JxWc1yTrkSAyqk1s/wap6Tl77Dwby1woiIYIUOcFC
         +GlQ==
X-Gm-Message-State: APjAAAWA2ybayGf8f3sJ4AOYkicWjnl5QW49YeSbO8IqdTXxg1EuXvHx
        Kbq66gBcSWNVa+du+u5bWpw=
X-Google-Smtp-Source: APXvYqzWvg1GBLeEX4emZimu3Krf58MHoihlarAwr3/DVkXxtPrZhV+yGFdEkV4Rbdn4ezwjfYwxjw==
X-Received: by 2002:a5d:4211:: with SMTP id n17mr5917722wrq.137.1567017932509;
        Wed, 28 Aug 2019 11:45:32 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id g65sm298385wma.21.2019.08.28.11.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:45:31 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:45:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH] powerpc: Avoid clang warnings around setjmp and longjmp
Message-ID: <20190828184529.GC127646@archlinux-threadripper>
References: <20190812023214.107817-1-natechancellor@gmail.com>
 <878srdv206.fsf@mpe.ellerman.id.au>
 <20190828175322.GA121833@archlinux-threadripper>
 <CAKwvOdmXbYrR6n-cxKt3XxkE4Lmj0sSoZBUtHVb0V2LTUFHmug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmXbYrR6n-cxKt3XxkE4Lmj0sSoZBUtHVb0V2LTUFHmug@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 11:01:14AM -0700, Nick Desaulniers wrote:
> On Wed, Aug 28, 2019 at 10:53 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Aug 28, 2019 at 11:43:53PM +1000, Michael Ellerman wrote:
> > > Nathan Chancellor <natechancellor@gmail.com> writes:
> > >
> > > > Commit aea447141c7e ("powerpc: Disable -Wbuiltin-requires-header when
> > > > setjmp is used") disabled -Wbuiltin-requires-header because of a warning
> > > > about the setjmp and longjmp declarations.
> > > >
> > > > r367387 in clang added another diagnostic around this, complaining that
> > > > there is no jmp_buf declaration.
> > > >
> > > > In file included from ../arch/powerpc/xmon/xmon.c:47:
> > > > ../arch/powerpc/include/asm/setjmp.h:10:13: error: declaration of
> > > > built-in function 'setjmp' requires the declaration of the 'jmp_buf'
> > > > type, commonly provided in the header <setjmp.h>.
> > > > [-Werror,-Wincomplete-setjmp-declaration]
> > > > extern long setjmp(long *);
> > > >             ^
> > > > ../arch/powerpc/include/asm/setjmp.h:11:13: error: declaration of
> > > > built-in function 'longjmp' requires the declaration of the 'jmp_buf'
> > > > type, commonly provided in the header <setjmp.h>.
> > > > [-Werror,-Wincomplete-setjmp-declaration]
> > > > extern void longjmp(long *, long);
> > > >             ^
> > > > 2 errors generated.
> > > >
> > > > Take the same approach as the above commit by disabling the warning for
> > > > the same reason, we provide our own longjmp/setjmp function.
> > > >
> > > > Cc: stable@vger.kernel.org # 4.19+
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/625
> > > > Link: https://github.com/llvm/llvm-project/commit/3be25e79477db2d31ac46493d97eca8c20592b07
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >
> > > > It may be worth using -fno-builtin-setjmp and -fno-builtin-longjmp
> > > > instead as it makes it clear to clang that we are not using the builtin
> > > > longjmp and setjmp functions, which I think is why these warnings are
> > > > appearing (at least according to the commit that introduced this waring).
> > > >
> > > > Sample patch:
> > > > https://github.com/ClangBuiltLinux/linux/issues/625#issuecomment-519251372
> > >
> > > Couldn't we just add those flags to CFLAGS for the whole kernel? Rather
> > > than making them per-file.
> >
> > Yes, I don't think this would be unreasonable. Are you referring to the
> > cc-disable-warning flags or the -fno-builtin flags? I personally think
> > the -fno-builtin flags convey to clang what the kernel is intending to
> > do better than disabling the warnings outright.
> 
> The `-f` family of flags have dire implications for codegen, I'd
> really prefer we think long and hard before adding/removing them to
> suppress warnings.  I don't think it's a solution for this particular
> problem.

I am fine with whatever approach gets this warning fixed to the
maintainer's satisfaction...

However, I think that -fno-builtin-* would be appropriate here because
we are providing our own setjmp implementation, meaning clang should not
be trying to do anything with the builtin implementation like building a
declaration for it.

Cheers,
Nathan
