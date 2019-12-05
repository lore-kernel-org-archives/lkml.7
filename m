Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A59BC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27AE72464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MMlHVQzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfLEJXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:23:06 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46212 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfLEJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:23:05 -0500
Received: by mail-oi1-f193.google.com with SMTP id a124so2053419oii.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2+ymVaiKpxCGbb6mLFBeFKK14AzTNra8/JGSC81CVMs=;
        b=MMlHVQzjz8BNYnpFpiDs0UZPUGaTU2TrVR0oiTh126oHkRd3AnBTqVTxB0eqFevSHE
         uvkikS9S3YhLrdQrYkkl/bCSUrtcejYVB3JJO2XbcQ7MYu8m4AZYS0lSmxxNiTPbLzMn
         nXUU7sP4YagfcJmxGE4f0bEubpdanZ3jz3gV3eEQ4PcyE5jQqaG75Ey955ZOAMymako3
         9ONlwtVwrX9v02HlpHDiU8pdZQmbEK9nRiAFFVkR4ZHNB9/8UccCXy9m56Mjfc0jRXD/
         b6kgwNvw5Mmif95Df/GoIY23DCIg3D8iLnKaQUL6k2xqJhZDk5BgkfBggDGe2BBVH+KB
         Ez3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2+ymVaiKpxCGbb6mLFBeFKK14AzTNra8/JGSC81CVMs=;
        b=kXwqMWFqj+manyzyU5gn37PjFOS8kWtmgWEvbPVI1EUy6f2RpWwwYDDKsZAJ1O7gEL
         a/tg03CQvm+VOpvDfCKryvO6aAAPyKtbESdsBZyz2zMLnwlzKuuxishA2MMb2b/EulGZ
         nEqINstntuheuj8CGdPOuBT2o9zFomiM0HiOuz26b0fAYdgeyoGBYYeKCO5kgbjWc0n3
         q1EZP9DaarZTERpjVQDP3lVZqBNIelsJYwoiHRFAm2VpWSzUpR19LHMYEIZetfA7qB6e
         ZQOkheyQPvuC3OD7WErnGXwxzEOzVGmTLKqpxBEw84tGzYt/CKkkQOPA8DxHLYSt4rmZ
         rfwg==
X-Gm-Message-State: APjAAAX6x+k7Lyl+J1VBdMH74mV+OLwHQbbOvmYaF87sm9YsWBdeCHFU
        DEr/3QtWfliJAqVpvLW8DEzvVRH8U+sfqaOFaQG3Gg==
X-Google-Smtp-Source: APXvYqzluMSEyFEWEKRhdKW5xwVBPzAcJZFuTB7zoWh9ETQZ9ypQXyOujHC2HKRdnKfUdK5vQuhu+X0cBR17KlbGyAQ=
X-Received: by 2002:aca:4e90:: with SMTP id c138mr6418889oib.147.1575537784750;
 Thu, 05 Dec 2019 01:23:04 -0800 (PST)
MIME-Version: 1.0
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
 <20191204072422.vfo3mrrcaav75jv4@pengutronix.de> <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
 <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
In-Reply-To: <20191204184754.5oj2xoem2v3544rx@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 5 Dec 2019 10:22:53 +0100
Message-ID: <CAMpxmJU-WK1aXK3M_q12E_u8+wwEimuonmjFa7Hm3Z6Dp7DP_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 4 gru 2019 o 19:47 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 04, 2019 at 05:33:04PM +0100, Bartosz Golaszewski wrote:
> > =C5=9Br., 4 gru 2019 o 08:24 Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
> > >
> > > On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > platform_irq_count() is the more generic way (independent of
> > > > device trees) to determine the count of available interrupts. So
> > > > use this instead.
> > > >
> > > > As platform_irq_count() might return an error code (which
> > > > of_irq_count doesn't) some additional handling is necessary.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-K=C3=B6nig <u.kleine-=
koenig@pengutronix.de>
> >
> > This is not a valid tag, but I take it as Suggested-by and Reviewed-by.=
 :)
>
> If you care about the validity of such tags, I suggest you take a look
> at the output of
>
>         $ git rev-list v4.0..v5.4 | while read rev; do git cat-file commi=
t $rev; done | sed -n 's/ *\(.*-by\):.*/\1/p' | sort | uniq -c | sort -n
>
> (which finds all tags used between 4.0 and 5.4 with its usage count).
>
> A few of the tags (admittedly with low usage count :-) included there are=
:
>
>   Badly-reviewed-by
>   Bonus-points-awarded-by
>   Compile-tested and Reviewed-by
>   Enthusiastically-Acked-by
>   Mea-culpa-by
>   \o/-by
>   Brown-paper-bag-by
>
> Best regards
> Uwe

I am well aware of this and there has been a discussion on LKML some
time ago (I can no longer find it though) about introducing stricter
rules for tags. I don't remember the outcome either though.

Bart
