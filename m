Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210FFC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F2223BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Uq/T2YCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfE2PsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:48:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40891 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2PsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:48:23 -0400
Received: by mail-it1-f195.google.com with SMTP id h11so4325822itf.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1v6CstyBUQQ32046WYaNZBkWpGqm4E3DdO+JI4/z6k=;
        b=Uq/T2YCZuyTQNQeIkxqsiz8hdWSnJDkKyyQY+hq8u6HlNCKLgz1UGBqkS+VFr95R4i
         x2rvmMoYddoQ+vV1xQYU2/hjtdTahw7iot+Iv/1ED+/r8NGBwKhwtxZU5JM87G4ru++z
         tls4WJ/aEKHR7SRCs7paDG7xfBirKUr1LqMqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1v6CstyBUQQ32046WYaNZBkWpGqm4E3DdO+JI4/z6k=;
        b=XcgpKb1Ioq9reiLBFbh6iaKpAjNgGXpXrFLSsh8C4ZDEseQGVD9riuMO3MJjpnS58L
         f8ejFiEfjUtHcc7s6fldobce11cDAeARd+gONeMYtoWvaXE7hT/dySqlRzLRnDpxzWiX
         vLiW3RGo7veIKlWKevMpS66yUFSztH1aKuA6wqJQ5FT5WxQvrVRWyVtEwD+Y7ROL5o0D
         IV+zvI+n+5eKaacD4z6xYvOoXcu+Lptf1cVdJUK2hew4QtS8Y5BRl+mbdRvBOJO6PtDq
         zjfjbB3BRPj0drl6WsbD1WdvojDWTb6VsTqyJnNeMOvmsSsSx+gIuKrH74rgf+jMoOjB
         6xZw==
X-Gm-Message-State: APjAAAViA+OrnTenfvW5Z1AjREzk6/NGQCE5zEYzgYAAKQSzsr2DyX/x
        Z0zDEU3Gyev//q7pE2s2QpE4xmG9D6A=
X-Google-Smtp-Source: APXvYqzDkq71PqfvFgI6MxmoP2/kHQWG0Gb0PenDyA3kfp13H8JlKakC1S2EGHJJ3XXlsV+BYR3GAQ==
X-Received: by 2002:a24:2943:: with SMTP id p64mr7450856itp.41.1559144901764;
        Wed, 29 May 2019 08:48:21 -0700 (PDT)
Received: from mail-it1-f175.google.com (mail-it1-f175.google.com. [209.85.166.175])
        by smtp.gmail.com with ESMTPSA id r6sm5456555iog.38.2019.05.29.08.48.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:48:20 -0700 (PDT)
Received: by mail-it1-f175.google.com with SMTP id u186so4376793ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:48:20 -0700 (PDT)
X-Received: by 2002:a02:b895:: with SMTP id p21mr89782634jam.80.1559144899977;
 Wed, 29 May 2019 08:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190520231948.49693-1-thgarnie@chromium.org> <20190520231948.49693-2-thgarnie@chromium.org>
 <20190521040634.GA32379@sol.localdomain> <CAJcbSZGekB9Uc8PUoSCND+ZaAN9V60uyVv1bBeBGDQ_pHxzVnw@mail.gmail.com>
 <20190522205524.GA183718@gmail.com>
In-Reply-To: <20190522205524.GA183718@gmail.com>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Wed, 29 May 2019 08:48:08 -0700
X-Gmail-Original-Message-ID: <CAJcbSZFnHk1uh3kz4+mcyExwjR+p445p4FSnZbskFKKhgy0qVw@mail.gmail.com>
Message-ID: <CAJcbSZFnHk1uh3kz4+mcyExwjR+p445p4FSnZbskFKKhgy0qVw@mail.gmail.com>
Subject: Re: [PATCH v7 01/12] x86/crypto: Adapt assembly for PIE support
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 1:55 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, May 22, 2019 at 01:47:07PM -0700, Thomas Garnier wrote:
> > On Mon, May 20, 2019 at 9:06 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Mon, May 20, 2019 at 04:19:26PM -0700, Thomas Garnier wrote:
> > > > diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
> > > > index 1420db15dcdd..2ced4b2f6c76 100644
> > > > --- a/arch/x86/crypto/sha256-avx2-asm.S
> > > > +++ b/arch/x86/crypto/sha256-avx2-asm.S
> > > > @@ -588,37 +588,42 @@ last_block_enter:
> > > >       mov     INP, _INP(%rsp)
> > > >
> > > >       ## schedule 48 input dwords, by doing 3 rounds of 12 each
> > > > -     xor     SRND, SRND
> > > > +     leaq    K256(%rip), SRND
> > > > +     ## loop1 upper bound
> > > > +     leaq    K256+3*4*32(%rip), INP
> > > >
> > > >  .align 16
> > > >  loop1:
> > > > -     vpaddd  K256+0*32(SRND), X0, XFER
> > > > +     vpaddd  0*32(SRND), X0, XFER
> > > >       vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
> > > >       FOUR_ROUNDS_AND_SCHED   _XFER + 0*32
> > > >
> > > > -     vpaddd  K256+1*32(SRND), X0, XFER
> > > > +     vpaddd  1*32(SRND), X0, XFER
> > > >       vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
> > > >       FOUR_ROUNDS_AND_SCHED   _XFER + 1*32
> > > >
> > > > -     vpaddd  K256+2*32(SRND), X0, XFER
> > > > +     vpaddd  2*32(SRND), X0, XFER
> > > >       vmovdqa XFER, 2*32+_XFER(%rsp, SRND)
> > > >       FOUR_ROUNDS_AND_SCHED   _XFER + 2*32
> > > >
> > > > -     vpaddd  K256+3*32(SRND), X0, XFER
> > > > +     vpaddd  3*32(SRND), X0, XFER
> > > >       vmovdqa XFER, 3*32+_XFER(%rsp, SRND)
> > > >       FOUR_ROUNDS_AND_SCHED   _XFER + 3*32
> > > >
> > > >       add     $4*32, SRND
> > > > -     cmp     $3*4*32, SRND
> > > > +     cmp     INP, SRND
> > > >       jb      loop1
> > > >
> > > > +     ## loop2 upper bound
> > > > +     leaq    K256+4*4*32(%rip), INP
> > > > +
> > > >  loop2:
> > > >       ## Do last 16 rounds with no scheduling
> > > > -     vpaddd  K256+0*32(SRND), X0, XFER
> > > > +     vpaddd  0*32(SRND), X0, XFER
> > > >       vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
> > > >       DO_4ROUNDS      _XFER + 0*32
> > > >
> > > > -     vpaddd  K256+1*32(SRND), X1, XFER
> > > > +     vpaddd  1*32(SRND), X1, XFER
> > > >       vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
> > > >       DO_4ROUNDS      _XFER + 1*32
> > > >       add     $2*32, SRND
> > > > @@ -626,7 +631,7 @@ loop2:
> > > >       vmovdqa X2, X0
> > > >       vmovdqa X3, X1
> > > >
> > > > -     cmp     $4*4*32, SRND
> > > > +     cmp     INP, SRND
> > > >       jb      loop2
> > > >
> > > >       mov     _CTX(%rsp), CTX
> > >
> > > There is a crash in sha256-avx2-asm.S with this patch applied.  Looks like the
> > > %rsi register is being used for two different things at the same time: 'INP' and
> > > 'y3'?  You should be able to reproduce by booting a kernel configured with:
> > >
> > >         CONFIG_CRYPTO_SHA256_SSSE3=y
> > >         # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
> >
> > Thanks for testing the patch. I couldn't reproduce this crash, can you
> > share the whole .config or share any other specifics of your testing
> > setup?
> >
>
> I attached the .config I used.  It reproduces on v5.2-rc1 with just this patch
> applied.  The machine you're using does have AVX2 support, right?  If you're
> using QEMU, did you make sure to pass '-cpu host'?

Thanks for your help offline on this Eric. I was able to repro the
issue and fix it, it will be part of the next iteration. You were
right that esi was used later on, I simplified the code in this
context and ran more testing on all CONFIG_CRYPTO_* options.

>
> - Eric
