Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12EBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49AD206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HboxFfq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfJHHfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:35:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54918 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730377AbfJHHfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:35:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so1949753wmp.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoFx3/6A4yO+IReqryKaNMuwmzT55frTUrYQ03qxezI=;
        b=HboxFfq7LYtqi3nsrP97Fedoce5oWji+ZY2wwnvrEdkMeoO9l5kUmBBDwQGDAbC194
         O50By+WuiH1nHI04fMtiv/6hREs7fti8v0MmSFifbV1fXvq3o7pqxr09TxHTeLkiApPQ
         1+6byFmxDOAvpm6PMlK4Yi+0/ngaAjiBjL+1zrU3YW5Lb3fXBrJKqymo9GA2jGWDvIz+
         zuK7yTDl9ecJow8B65r0OXKtmRByezWXqBRD1v13KRDXwUrybSF0ioCL0SYrxJxkiQna
         pysXVqLps0emwdFU3bw2LAraqqMWaJvHjvfo9o0Ksr8UTvQpL2F2IbouRMJ9AZuLru+1
         /EPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoFx3/6A4yO+IReqryKaNMuwmzT55frTUrYQ03qxezI=;
        b=GhnQIxuo1STc95FbRn6Ld4tSb7/yfVGxxIpdMRoIa+PTOCDPPgo89PL44eUvsQtWql
         JItiSsCbLyJN56RMNL68kTprFC7aSTp40TOGj6ldoUbHgGlKZhzmKNRgnBwRPx/lZ2KG
         0XakNIBmKN0smXb6jK0gGSrP028wMYf6dA607LLunC1JYhPrgf2ayPrdhCboFRh5cEpa
         euitPhIOB8+fGv6F46M885sHzDB2evaHv5MnHrENeZ3aPLRR9rQgYblaIW8jxAkdyJ+9
         lydP4Gcq0s9fFYHLQyfqzcx3Ym+XrbbRfZWVV6Slsb49gjDrzhL6zCDJU/b4u2F6LtUQ
         ABIQ==
X-Gm-Message-State: APjAAAUbMcFiY6VOqIVK2MB6AUtHyMlbc/gjzEdBX6fAyG59dLbtj7zn
        r/kYgqA1JqIMXW/fajdW3Ln5C3lYWTsqzm797MKh8AFzVVU=
X-Google-Smtp-Source: APXvYqx9fWBRxxov6rnEMnCW+BtKSVgzKgyxGjkXT0Zg9LrvvyweUHzB5qByrO2kI99o6y6n1Jat5Yi142jkAztn4nk=
X-Received: by 2002:a1c:2546:: with SMTP id l67mr2707920wml.10.1570520135559;
 Tue, 08 Oct 2019 00:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191008071503.55772-1-yuehaibing@huawei.com> <MN2PR20MB297342D98080781DB5DC7BABCA9A0@MN2PR20MB2973.namprd20.prod.outlook.com>
In-Reply-To: <MN2PR20MB297342D98080781DB5DC7BABCA9A0@MN2PR20MB2973.namprd20.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 8 Oct 2019 09:35:23 +0200
Message-ID: <CAKv+Gu__LnHTAbs5TtczT7eWA=4drh5_zOMCyowz3ohFTAtqEw@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: inside-secure - Fix randbuild error
To:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pascalvanl@gmail.com" <pascalvanl@gmail.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2019 at 09:32, Pascal Van Leeuwen
<pvanleeuwen@verimatrix.com> wrote:
>
> > -----Original Message-----
> > From: linux-crypto-owner@vger.kernel.org <linux-crypto-owner@vger.kernel.org> On Behalf Of
> > YueHaibing
> > Sent: Tuesday, October 8, 2019 9:15 AM
> > To: herbert@gondor.apana.org.au; davem@davemloft.net; pascalvanl@gmail.com;
> > antoine.tenart@bootlin.com
> > Cc: linux-crypto@vger.kernel.org; linux-kernel@vger.kernel.org; YueHaibing
> > <yuehaibing@huawei.com>
> > Subject: [PATCH -next] crypto: inside-secure - Fix randbuild error
> >
> > If CRYPTO_DEV_SAFEXCEL is y but CRYPTO_SM3 is m,
> > building fails:
> >
> > drivers/crypto/inside-secure/safexcel_hash.o: In function `safexcel_ahash_final':
> > safexcel_hash.c:(.text+0xbc0): undefined reference to `sm3_zero_message_hash'
> >
> > Select CRYPTO_SM3 to fix this.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 0f2bc13181ce ("crypto: inside-secure - Added support for basic SM3 ahash")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  drivers/crypto/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
> > index 3e51bae..5af17db 100644
> > --- a/drivers/crypto/Kconfig
> > +++ b/drivers/crypto/Kconfig
> > @@ -751,6 +751,7 @@ config CRYPTO_DEV_SAFEXCEL
> >       select CRYPTO_SHA512
> >       select CRYPTO_CHACHA20POLY1305
> >       select CRYPTO_SHA3
> > +     select CRYPTO_SM3
> >       help
> >         This driver interfaces with the SafeXcel EIP-97 and EIP-197 cryptographic
> >         engines designed by Inside Secure. It currently accelerates DES, 3DES and
> > --
> > 2.7.4
> >
> But ... I don't really want to build SM3 into the kernel for all Inside
> Secure drivers, since in the majority of cases, the HW will not actually
> support SM3 and I don't want to bloat the kernel image in that case.
>
> So maybe it's better to #ifdef out the failing part of the driver if
> CONFIG_SM3 is not set?
>

Since you are only using the zero length message hash, can we just
copy that into your driver instead?
