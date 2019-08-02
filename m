Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68B0C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D1020657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EK6uwC16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388938AbfHBGsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:48:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39343 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfHBGsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:48:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so22814042wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 23:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ie25Aco59RAcbLsPsgaVJSlOnwnSodpgokjBm4b1WRc=;
        b=EK6uwC16+FJTCVcCfE027a0FgSGvcrFAJVj+PXAcZwTYDO6/S7dWMn1Hz6uG469T6C
         fuGAhRjmnjHfT3XCoS2jeCPrHyOkX7FIlF7A8YiF/KNKE0Mvor4RGo2Y5Jqru0qdXDMY
         MjjRKlCU1kaC+yP/wI1QDZMU+YP4tFyEQrgcloz3hWnO7kpIhcfhBLNLaOsQx3Z4Jr/5
         TSb392J0X+5KTwhnDOpD8Y2cR6Ie6t3kQeBLDIjZOE95Al1TBn6qYW81T8ITKz78C7UY
         Mypox5XTKOHl/HUADQWHFJrIrJu4FqRO6TPRfAhEiIY1u58qSBxExLibEWtk6lwVC8c4
         ZmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ie25Aco59RAcbLsPsgaVJSlOnwnSodpgokjBm4b1WRc=;
        b=CVh0p5Q706pAnhmAhAzYynUor7QwUHxTIIaU4rm/36FIeW5aY2jq31fSsWXU7C+vZ4
         tMhO3ElLgKjtFWVLX1SscegrnR+MZO8CEitIzKFGw95EUO4hzOwBMePGS30wJt7HIjMS
         WiQPnItOjginInIoxYMEFAMu5F+bmKNa8qpHJYSxWXEZmn+zTIhUtarKoJ3kQOGkefhx
         WH3Xk3sMqLJwdDW92uRUs4oo6uPReoKBYfn2up/vSSrYO/e/MfdI0tD2xEfHYqVMyOdv
         UloSABc6RNJCjGa12cFFrdiVQ6CO2Ny0Kkh/prKoykOMmJaXqr+s1Iv9dRg9Gb4AMLMm
         uG+A==
X-Gm-Message-State: APjAAAXSuzlC3kzit6l1IGxGbfBC+CzirRAsM7Wd0jqB1L6MfQM9kuo9
        HnaxB2kxwijUs8MA/wGYtMY5U+0LmRq6jmbvMYCSvI9u3Io=
X-Google-Smtp-Source: APXvYqwIgfgWAs7cMuANCq9jUGsqMY8at2of2TpDvrk8i9NVPyY7XkCOPJWvg8zz8NiKtxiwYkTSvhTMeUqFR7KVnUs=
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr3286056wre.241.1564728483656;
 Thu, 01 Aug 2019 23:48:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190731163915.3fdfcb14@canb.auug.org.au> <20190731085819.GA3488@osiris>
 <20190731110816.GA20753@gondor.apana.org.au> <20190731111520.GC3488@osiris>
 <20190731113216.GA21068@gondor.apana.org.au> <20190731114453.GD3488@osiris>
 <20190801122849.GB4163@osiris> <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
 <20190802102019.6a789c51@canb.auug.org.au>
In-Reply-To: <20190802102019.6a789c51@canb.auug.org.au>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 2 Aug 2019 09:47:52 +0300
Message-ID: <CAKv+Gu-Tui6+HEOK0Axgn9kWTxOPpenCSefTuxSek0PpNh9HzQ@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 at 03:20, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Herbert,
>
> On Thu, 1 Aug 2019 20:28:56 +0300 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >
> > On Thu, 1 Aug 2019 at 15:28, Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> > >
> > > On Wed, Jul 31, 2019 at 01:44:54PM +0200, Heiko Carstens wrote:
> > > > On Wed, Jul 31, 2019 at 09:32:16PM +1000, Herbert Xu wrote:
> > > > > On Wed, Jul 31, 2019 at 01:15:20PM +0200, Heiko Carstens wrote:
> > > > > >
> > > > > > However that doesn't fix the simd.h header file breakage with the
> > > > > > second patch :)
> > > > >
> > > > > That fix should be there now too.
> > > >
> > > > Yes, works now. Thank you!
> > >
> > > Still not... with linux-next as of today I get this (s390 defconfig):
> > >
> > > ERROR: "crypto_aegis128_decrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> > > ERROR: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!
> > > ERROR: "crypto_aegis128_encrypt_chunk_simd" [crypto/aegis128.ko] undefined!
> > > scripts/Makefile.modpost:105: recipe for target 'modules-modpost' failed
> > >
> >
> > Hello Heiko,
> >
> > Apologies for the breakage. The first two fixes addressed obvious
> > shortcomings in my code, but with this issue, I'm a bit puzzled tbh.
> > The calls to these missing functions should be optimized away, since
> > have_simd never gets assigned if CONFIG_CRYPTO_AEGIS128_SIMD is not
> > defined, but for some reason, this isn't working. Which version of GCC
> > are you using?
> >
> > Also, could you please try whether the patch below fixes the problem? Thanks
> >
> > https://lore.kernel.org/linux-crypto/20190729074434.21064-1-ard.biesheuvel@linaro.org/
>
> It might be time to revert all this series and try again.  The
> implementation seems to have not been well thought through from a kernel
> building point of view.  For a start the two commits
>
>   7cdc0ddbf74a ("crypto: aegis128 - add support for SIMD acceleration")
>   ecc8bc81f2fb ("crypto: aegis128 - provide a SIMD implementation based on NEON intrinsics")
>
> seem to be in the wrong order (function used in the first before being
> defined in the second).  There are a series of declarations of external
> functions in crypto/aegis128-core.c that should be in a header file.
> And there was the assumption that asm/simd.h was available everywhere.
>
> Also crypto_aegis128_decrypt_chunk_simd() is referenced in a structure
> initialisation (unprotected by any CONFIG_ variable - and so will be
> referenced even if it does not exist).  The compiler will have a hard
> time knowing that "have_simd" is effectively a constant zero (and
> crypto_simd_usable() is not constant).

The only assignment to have_simd is guarded by a if
(IS_ENABLED(CONFIG_xxx)) conditional, which is optimized away if the
Kconfig symbol is not set. Usually, the compiler uses this information
to infer that have_simd is a compile time constant '0', and optimizes
away all the code that depends on have_simd being true. I haven't
figured out yet why this doesn't work as expected on some versions of
GCC, since it is a very common pattern throughout the kernel.
