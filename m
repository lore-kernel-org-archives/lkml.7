Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D51C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642CC20725
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 01:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573781702;
	bh=FM7mYg/6+NiEj2ej8cWPQVFxq0x2k6N9T/icEBkFu64=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xmkw/2SOKh3XiKDTmQfiNu8UVzNiHmpBsclT09TfzWnO+UzN0sy6OiJQ+Bfj2XFQE
	 6SDSHkgg5YHDKklaDbdZ+5/Y9v+78fOwD/LsV1JjZOGMTaWf0pJv5XKV5OSX9t4JTb
	 p6aZbkJozSpSHdB2TYmECq25YJC8EaXXOgY4mmn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKOBfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 20:35:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfKOBfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 20:35:00 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367FB20723;
        Fri, 15 Nov 2019 01:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573781699;
        bh=FM7mYg/6+NiEj2ej8cWPQVFxq0x2k6N9T/icEBkFu64=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UB35JLpwUaKnERFQx86p21dIIYJB+YknS2gzLIPiUbT/8zQRoZU5VhpBNGJvmnUUA
         FjwYM60dyXKAniIivnhD5Wclp17WYbrNzimtZtYI5N6MXXeU44g2+fzdDt4zNCQH81
         a6PiJZkQKQsplLdttcQYe5Eyv7zbWKKX1HTYpios=
Received: by mail-qk1-f169.google.com with SMTP id d13so6856155qko.3;
        Thu, 14 Nov 2019 17:34:59 -0800 (PST)
X-Gm-Message-State: APjAAAWBcbcRvkwriI/b2A1bQxfp4vljle1On6m1UyoMAdNJjaFhOMPw
        KtiVZqd/Tb6zGkqwBTrWR8bYCffBSPP+7EoUvw==
X-Google-Smtp-Source: APXvYqxz9j05GwmaTCc16w66GIq0s+n5kpdf5ngLzlrlw5UuuM6/wKEBRGfv34b1gB5ITk95f4T0wiJFCdroySKtY6k=
X-Received: by 2002:a37:30b:: with SMTP id 11mr10622838qkd.254.1573781698329;
 Thu, 14 Nov 2019 17:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20191111030434.29977-1-afaerber@suse.de> <20191111030434.29977-6-afaerber@suse.de>
In-Reply-To: <20191111030434.29977-6-afaerber@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Nov 2019 19:34:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+fdksCHQ1_NaizkM6dVWT1h2wocJpD4NB8K2dOO-yZ4Q@mail.gmail.com>
Message-ID: <CAL_Jsq+fdksCHQ1_NaizkM6dVWT1h2wocJpD4NB8K2dOO-yZ4Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 9:04 PM Andreas F=C3=A4rber <afaerber@suse.de> wrot=
e:
>
> Model Realtek's register bus in DT.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>
> ---
>  This could be squashed into the original RTD1195 patch.
>
>  arch/arm/boot/dts/rtd1195.dtsi | 52 ++++++++++++++++++++++++------------=
------
>  1 file changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.d=
tsi
> index a8cc2d23e7ef..3439647ecf97 100644
> --- a/arch/arm/boot/dts/rtd1195.dtsi
> +++ b/arch/arm/boot/dts/rtd1195.dtsi
> @@ -92,28 +92,36 @@
>                          <0x18100000 0x18100000 0x01000000>,
>                          <0x40000000 0x40000000 0xc0000000>;
>
> -               wdt: watchdog@18007680 {
> -                       compatible =3D "realtek,rtd1295-watchdog";
> -                       reg =3D <0x18007680 0x100>;
> -                       clocks =3D <&osc27M>;
> -               };
> -
> -               uart0: serial@18007800 {
> -                       compatible =3D "snps,dw-apb-uart";
> -                       reg =3D <0x18007800 0x400>;
> -                       reg-shift =3D <2>;
> -                       reg-io-width =3D <4>;
> -                       clock-frequency =3D <27000000>;
> -                       status =3D "disabled";
> -               };
> -
> -               uart1: serial@1801b200 {
> -                       compatible =3D "snps,dw-apb-uart";
> -                       reg =3D <0x1801b200 0x100>;
> -                       reg-shift =3D <2>;
> -                       reg-io-width =3D <4>;
> -                       clock-frequency =3D <27000000>;
> -                       status =3D "disabled";
> +               rbus: r-bus@18000000 {

Following node names should be generic: bus@...

> +                       compatible =3D "simple-bus";
> +                       reg =3D <0x18000000 0x100000>;
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <1>;
> +                       ranges =3D <0x0 0x18000000 0x100000>;
> +
> +                       wdt: watchdog@7680 {
> +                               compatible =3D "realtek,rtd1295-watchdog"=
;
> +                               reg =3D <0x7680 0x100>;
> +                               clocks =3D <&osc27M>;
> +                       };
> +
> +                       uart0: serial@7800 {
> +                               compatible =3D "snps,dw-apb-uart";
> +                               reg =3D <0x7800 0x400>;
> +                               reg-shift =3D <2>;
> +                               reg-io-width =3D <4>;
> +                               clock-frequency =3D <27000000>;
> +                               status =3D "disabled";
> +                       };
> +
> +                       uart1: serial@1b200 {
> +                               compatible =3D "snps,dw-apb-uart";
> +                               reg =3D <0x1b200 0x100>;
> +                               reg-shift =3D <2>;
> +                               reg-io-width =3D <4>;
> +                               clock-frequency =3D <27000000>;
> +                               status =3D "disabled";
> +                       };
>                 };
>
>                 gic: interrupt-controller@ff011000 {
> --
> 2.16.4
>
