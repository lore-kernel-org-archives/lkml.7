Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDD4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B85A205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSHSNKKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfDSS6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:58:23 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46139 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfDSS6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:58:22 -0400
Received: by mail-yw1-f66.google.com with SMTP id u3so1707496ywa.13;
        Fri, 19 Apr 2019 11:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4khKcbPHbyYmHxfaGSQOC6E3MogU3rXvT1zdzGYqzyQ=;
        b=GSHSNKKLkKCvhgOu+BiCf5EWjajcbAZACGOUVS7wVUI3xuW/zap6QkBSpO62OJXgmc
         xmj8u/L6zLZ51n3S+HCOxXSXB3M/lgVyR9puo5iaAP39xoQSkQc5nXj/05fp0viQxMQa
         0Z/JBcVPJLihLBY6O1Eee5o1iIJLZNTe4Fft+FxUoWSxgkfcR9lCxZ16HqS9NSBytOCl
         zjoNMY7xn1muS3HTGdnF/bH9b3Bq/QCuXBMuigH00bXIvPBKpOYzb9x8INmKPKM3sKBl
         vUoqFzBKAM+RkE1mrGbreoKLJVf51iPoWrl4uQacKrflTSxArr4XK/X6dXUQrqr+9mz9
         Kjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4khKcbPHbyYmHxfaGSQOC6E3MogU3rXvT1zdzGYqzyQ=;
        b=EoFakf3s0RUP9kuNNXlYruS2U/+mjDKY/eoGhydKNaG7sKSTPt8HuwT/73LQUTWspN
         krfm83Cv3QpeEwhD/yLW4omPxbAAgLmdyX323qSLhCcZVmUrt/071XZs2TnB91AB8Evl
         jZnUJWuOFMzowM5pHtnj3gKUnMmf+15DEfWJSFP4rV4wUPVN6FvbAj4F5aQUjJokEHYz
         ynclXULtDa5LGox38RUbQGRvsZqnPVfnM1vdJN2e+NcGA9F4+P96AErzzf2es+EJq666
         Z/YiEWh9157FYv1xmQdQwyjZG5cvvsG/A1jnAH4vuHjcZsd9eCdt3sPsv+uzZJy1BBsm
         dc+g==
X-Gm-Message-State: APjAAAW9rRQibYnxyc7K4KsTOm3+Npv4aM+tJCwFLRHzUG8cHF9MVdlG
        ic1ZklsVi7C2RgwOKerk76qikfnta0QHKk29TA0=
X-Google-Smtp-Source: APXvYqzVfO+vGXk3ZRougbn36Kj+DVAb/BCfsdmd3SiG88iGBrpQXJxiytkAYc2BBwgmGU1v+2E0Otd0ba0NR0+UWdI=
X-Received: by 2002:a81:a6c5:: with SMTP id d188mr4406292ywh.46.1555700301010;
 Fri, 19 Apr 2019 11:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190411154534.25563-1-peron.clem@gmail.com> <20190411154534.25563-3-peron.clem@gmail.com>
In-Reply-To: <20190411154534.25563-3-peron.clem@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Fri, 19 Apr 2019 21:00:42 +0200
Message-ID: <CAJiuCcc2CrEBQEoon9p=pitrjqoy6tzOSjhjBY3=oXNCHdiZ5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm64: dts: allwinner: h6: add r_watchog node
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Apr 2019 at 17:34, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Allwinner H6 has a r_watchdog similar to A64.
>
> Declare it in the device-tree.
>
> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 5c2f5451227b..66dc684a378e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -622,6 +622,13 @@
>                         #reset-cells =3D <1>;
>                 };
>
> +               r_watchdog: watchdog@7020400 {
> +                       compatible =3D "allwinner,sun50i-a64-wdt",
> +                                    "allwinner,sun6i-a31-wdt";
> +                       reg =3D <0x07020400 0x20>;
> +                       interrupts =3D <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +               };

I have set the same compatible as A64 because regarding the User
Manual they have exactly the same memory mapping.
However we don't know really if it's the same IP version, maybe there
will be an errata one day.
So I would like to know if it's better to define the h6-wdt also
  compatible =3D  "allwinner,sun50i-h6-wdt", "allwinner,sun50i-a64-wdt",
                                 "allwinner,sun6i-a31-wdt";

I would say Yes, but with this logic we would have to had a new
compatible each time there is a  new SoC.

Thanks,
Clement

> +
>                 r_intc: interrupt-controller@7021000 {
>                         compatible =3D "allwinner,sun50i-h6-r-intc",
>                                      "allwinner,sun6i-a31-r-intc";
> --
> 2.17.1
>
