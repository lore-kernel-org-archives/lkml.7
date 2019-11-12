Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26857C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5D8206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MKkc4UyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfKLKQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:16:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40875 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfKLKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:16:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so13815080otq.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 02:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AKZO0OAzyyYGtpbwsEj0QOcTH8vqhFRIVBhgV2yDI1g=;
        b=MKkc4UyNjo46K6JpSwpbGmcYcHb694jLXJxKceHuu01hTDC6t0f3f7w4XAQlrwJdLI
         +0dpUVgiYRfD4m4UTM61GbEUvKzH+cV+RCj5NHe8Ym6pLVsHUgofeIn6/UVh62vDPLdW
         geQPN19YcJozX+8NZpNEJ64YZU94tHhcp/ZvYALtrAMHUIKgbjcPvWpoGlKS9By3QvV2
         PaUsCD112vgto4G5Y3Hhh1JqsctWluEZv3TN5zcfcd4b03LIPzifxELba/ah9UlNNXnO
         BXVWVzzx6j9S7294+QI3B6uAjGfFuOu0yHiZAvweTQKDOBjSX4c/1R1uAIrvt0MQCDFk
         sHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AKZO0OAzyyYGtpbwsEj0QOcTH8vqhFRIVBhgV2yDI1g=;
        b=GBa546LT5tchkylNnf3X9MjPWbdYDaBd51yE0I1V0hoBRXWxILjXKZ6rWdqDojM/Y7
         QcV7nVAMhBIEejHHonVIFPrSVRT9lCQ5fx6YyvhiEWTuf5N+f38+vjdp9Z19jzea1GKh
         zjLEqeU4vy2NiY7U35vy5CfpKBXboWwVQg9djlYkSq2Ra6Gs8YQIg1BMfQ0VJSPtVUlT
         QrrqjncyWtdXHfOzbMsYLdw0AN5prlXOB1apEZ8Om2s9NO3DmgoBY8gYDe7yGEH7+6Ld
         k/8MYzILvoApWnBvaqEnQ+m3eu6+7gww1xisZOzqvUaJN7WsZXSq5NkVcHHk7DYpB2Tq
         up8A==
X-Gm-Message-State: APjAAAUjWKVGSapcgr8f9bsT21fBXUAY7D6jTX4CVAFoJFu8uxgVQPZB
        3j9eZel2g7VkzDGfAZlwZahi6M5+dq9QAJnWNs3s6tWJ
X-Google-Smtp-Source: APXvYqxsF1/3YJCj6U1j3gN+WttI0zCinM36IFtdfM94pQ8mxyn5ROGK+eMn6Ut7Z3q6li9ZlTIynntWVR/yXJZMrio=
X-Received: by 2002:a9d:344a:: with SMTP id v68mr25496129otb.85.1573553780649;
 Tue, 12 Nov 2019 02:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20191108160747.3274377-1-thierry.reding@gmail.com> <20191108205407.GE23750@amd>
In-Reply-To: <20191108205407.GE23750@amd>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 Nov 2019 11:16:10 +0100
Message-ID: <CAMpxmJX0oM3cUQULr8UmKtJ5mGuzSvGeR5jCmo88Q_9+gDXqjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: max77620: Fixup debounce delays
To:     Pavel Machek <pavel@denx.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 lis 2019 o 21:54 Pavel Machek <pavel@denx.de> napisa=C5=82(a):
>
> On Fri 2019-11-08 17:07:46, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > When converting milliseconds to microseconds in commit fffa6af94894
> > ("gpio: max77620: Use correct unit for debounce times") some ~1 ms gaps
> > were introduced between the various ranges supported by the controller.
> > Fix this by changing the start of each range to the value immediately
> > following the end of the previous range. This way a debounce time of,
> > say 8250 us will translate into 16 ms instead of returning an -EINVAL
> > error.
> >
> > Typically the debounce delay is only ever set through device tree and
> > specified in milliseconds, so we can never really hit this issue becaus=
e
> > debounce times are always a multiple of 1000 us.
> >
> > The only notable exception for this is drivers/mmc/host/mmc-spi.c where
> > the CD GPIO is requested, which passes a 1 us debounce time. According
> > to a comment preceeding that code this should actually be 1 ms (i.e.
> > 1000 us).
> >
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>
> Thanks for doing this!
>
> Acked-by: Pavel Machek <pavel@denx.de>
>
> And I guess this should be cc: stable, as the commit this fixes was
> making its way there.
>
> Best regards,
>                                                                 Pavel
>
>
> > @@ -198,13 +198,13 @@ static int max77620_gpio_set_debounce(struct max7=
7620_gpio *mgpio,
> >       case 0:
> >               val =3D MAX77620_CNFG_GPIO_DBNC_None;
> >               break;
> > -     case 1000 ... 8000:
> > +     case 1 ... 8000:
> >               val =3D MAX77620_CNFG_GPIO_DBNC_8ms;
> >               break;
> > -     case 9000 ... 16000:
> > +     case 8001 ... 16000:
> >               val =3D MAX77620_CNFG_GPIO_DBNC_16ms;
> >               break;
> > -     case 17000 ... 32000:
> > +     case 16001 ... 32000:
> >               val =3D MAX77620_CNFG_GPIO_DBNC_32ms;
> >               break;
> >       default:
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

Applied for fixes and marked for stable.

Thanks
