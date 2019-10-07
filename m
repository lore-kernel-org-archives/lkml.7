Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC61C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C244C20679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckvqu/Vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfJGPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:54:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40721 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:54:55 -0400
Received: by mail-io1-f67.google.com with SMTP id h144so29637755iof.7;
        Mon, 07 Oct 2019 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvpOYPT25Dz/vPtn4WUNNAsTQj8w9iYHYk37s9wmbRA=;
        b=Ckvqu/VoFwKFHldPlCQQ7rGN0El4oSw62jZdcCzu59LwyF2msfcDQM63j0TmFd2YxT
         WAe3o/ieROixTeOWj5cRNIdhGzfdb3SSQ3c2/0hAmI4vacwT/AjZ4HdH47oBJz13v1Xr
         Zu8ism2Y1fiki6FPQl3fWyevesoLjP1eV251spvajxesKUS2hbYoN6+cWKrr9CAo71KK
         tRL3LBH1bAqTsv2FhLoatmnhFgfI8Mfg4LHc7RACVt965MBiLo30hVr5jrP8l7NJI/kw
         p3e7Ti728xG16cOQ5s+unqsH4DBrAZ3fE9TTt05hfU0+FOECcfP4b/OA8wKIHm+CJuwV
         9tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvpOYPT25Dz/vPtn4WUNNAsTQj8w9iYHYk37s9wmbRA=;
        b=qQfAArNGw6AthJ17XW5NBm+ukmdz5/Jg4fDDqAkm1e9uANIDk/MDTl+oi0ctxeUWb9
         dRMJER4P0kTgVEGK4vc1oL0a4t4DzKT9Ysm5LyiQyoMUcC+2hNuK/MFyN9Vso2kzu0WE
         zzVe2S9XlBlhAEOmPsnNbjfvyx4aHvkuM/zpWdd9ada6EGO4iPqrtfNE3l7vUk3Z9iZ9
         IFBXbHNfLvBozSMPsotMKa0DAZhXZ+qiQX8e57wGtKeB0IxvConh6ah3oMqNcOIWNYwX
         4ix6ciNxSdvNKooX/x/wVUxBzxIC65pLM6+5yXWSODIPNgo+yBRe6pvhzasPWreLS57P
         o0Kw==
X-Gm-Message-State: APjAAAWCCjHPIDrvrE5RPfPFdJnjdd0fxtEy9v2lykXqSZaSX1rHYdlQ
        an4QNaNM0y4xHQwH2TIWWU4QP2KenrLY88CRT84=
X-Google-Smtp-Source: APXvYqxi4nNcdgpdM7NsVyNP5M/JKLLRb6BMM4Kll8kUSaYi7x+Qj5bGG21aaEgdWhPttIekzf3iOaMHq7JDv5ThOfI=
X-Received: by 2002:a02:2b2e:: with SMTP id h46mr27703157jaa.141.1570463693043;
 Mon, 07 Oct 2019 08:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191007131649.1768-1-linux.amoon@gmail.com> <20191007131649.1768-5-linux.amoon@gmail.com>
 <a6daf5e5-fadf-ca72-fc7b-1789abaab605@baylibre.com>
In-Reply-To: <a6daf5e5-fadf-ca72-fc7b-1789abaab605@baylibre.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 7 Oct 2019 21:24:41 +0530
Message-ID: <CANAwSgQBMzkdnuHc8_hFx0+Es2PWmCwgeqykCTieZ3BtTK1W7A@mail.gmail.com>
Subject: Re: [RFCv1 4/5] arm64: dts: meson: Add missing regulator linked to
 VCCV5 regulator to VDDIO_C/TF_IO
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, 7 Oct 2019 at 19:51, Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 07/10/2019 15:16, Anand Moon wrote:
> > As per schematics add missing VCCV5 power supply to VDDIO_C/TF_IO
> > regulator. Also add TF_3V3N_1V8_EN signal name to gpio pin.
> >
> > Fixes: c35f6dc5c377 (arm64: dts: meson: Add minimal support for Odroid-N2)
> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > index 6bd23a1e7e1d..5daf176452f7 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> > @@ -66,11 +66,14 @@
> >               regulator-min-microvolt = <1800000>;
> >               regulator-max-microvolt = <3300000>;
> >
> > +             /* TF_3V3N_1V8_EN */
> >               gpios = <&gpio_ao GPIOAO_9 GPIO_ACTIVE_HIGH>;
> >               gpios-states = <0>;
> >
> >               states = <3300000 0>,
> >                        <1800000 1>;
> > +             /* U16 RT9179GB */
> > +             vin-supply = <&vcc_5v>;
> >       };
> >
> >       flash_1v8: regulator-flash_1v8 {
> >
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,

Best Regards
-Anand
