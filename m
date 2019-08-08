Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E26C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456EE21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE60SjEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbfHHOus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 10:50:48 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46219 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730678AbfHHOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 10:50:48 -0400
Received: by mail-yw1-f66.google.com with SMTP id w10so758412ywa.13;
        Thu, 08 Aug 2019 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pd+si4K6IQLELIBX4tiD+y/43Cjy1FUkTrZU/zYixN4=;
        b=sE60SjEWlcKLwRIco5fwQ4/fxw00fl89OqZsG9TI2xWu87p4mGrVgFyhd7nu2SoZiz
         bkfdbqdHL4Z/3Kotsu/DkJzJP7vh+4FZMQHzqoGqIOELRJlPCIdVtfPF5c292X+NzqxQ
         Bz6v37ex61aD0V+m42+V69lUO2oqBRjAoHxljVvrfJONfWfukSFampgDU73FbUNVxXty
         fF4A44+Qx6AxarVxSB+RW3Spg/kHDyBUXbEzm9VnInPH3EjSsihkImNDPMrWGtis/EZC
         +UuG1YG6X+LHRM6ZcC1esjSGfhIBg8K2+CAjLEJP3yx4FzDalCVY/KBS2o3v6b+//UFz
         viiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pd+si4K6IQLELIBX4tiD+y/43Cjy1FUkTrZU/zYixN4=;
        b=LTFs7GhkoAXUlvfO/AAdDnEN9/BvaPVm/iGEuc86XK0+9cdT9PIkyekStJxKaXU1Ss
         ifZQnDm5U4T7MXLCEs+MeykVrJu8qppjT1QTVsdbbARqu6b9P4TmLYAzKEEHhXxPnnLU
         +J38AVk+XxUCbO0B7dWl2S6iyOFwwCAyGlwq6hEIC56pgu+qJuFmbks3/Rb8GERDywQd
         9b2J+Px7zbtNUbiVquPvcnQNxGSFNUT3On/LWjeojmUMe56Kc+MtGqjOMBW2lzUg6eU2
         uG0ujjhxkpJh1eVvhu2dEs43xF3sO3MQCGAsEVXGwo8cbpfKQkJa/iXWwq4igH5VC5f6
         Lc0g==
X-Gm-Message-State: APjAAAWQdJUYghIQKxeztGzxbbabtGSCg/5meQlwe2mQPazvgLnzji8t
        QtXLbX6f5tKl+Xn4ne6mUqIto6QuWsRmJegZ6VyPsHcPYLA=
X-Google-Smtp-Source: APXvYqy4X33XWy8GcpnfQPLTgDaawdkVKyWHl6kdh6f4Q7tJTdlAfKFkS13q7zReuXDd+Mc6ZLfTdZeLAZL8itk/jo4=
X-Received: by 2002:a81:5957:: with SMTP id n84mr9865139ywb.234.1565275846869;
 Thu, 08 Aug 2019 07:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
In-Reply-To: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Thu, 8 Aug 2019 16:50:35 +0200
Message-ID: <CAJiuCccEQFvKemTodJbuEDzDy9j6-M4SYskxPFJ5DpsbQDnvkA@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH] ARM64: dts: allwinner: Add devicetree for
 pine H64 modelA evaluation board
To:     clabbe.montjoie@gmail.com
Cc:     Mark Rutland <mark.rutland@arm.com>, mripard@kernel.org,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 8 Aug 2019 at 10:42, Corentin Labbe <clabbe.montjoie@gmail.com> wro=
te:
>
> This patch adds the evaluation variant of the model A of the PineH64.
> The model A has the same size of the pine64 and has a PCIE slot.
>
> The only devicetree difference with current pineH64, is the PHY
> regulator.

You also need to add the board in
"Documentation/devicetree/bindings/arm/sunxi.yaml"

Regards,
Cl=C3=A9ment

>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../sun50i-h6-pine-h64-modelA-eval.dts        | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-mode=
lA-eval.dts
>
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts=
/allwinner/Makefile
> index f6db0611cb85..9a02166cbf72 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-3.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-modelA-eval.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval=
.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> new file mode 100644
> index 000000000000..d8ff02747efe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2019 Corentin Labbe <clabbe.montjoie@gmail.com>
> + */
> +
> +#include "sun50i-h6-pine-h64.dts"
> +
> +/ {
> +       model =3D "Pine H64 model A evaluation board";
> +       compatible =3D "pine64,pine-h64-modelA-eval", "allwinner,sun50i-h=
6";
> +
> +       reg_gmac_3v3: gmac-3v3 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc-gmac-3v3";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               startup-delay-us =3D <100000>;
> +               gpio =3D <&pio 2 16 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +};
> +
> +&emac {
> +       phy-supply =3D <&reg_gmac_3v3>;
> +};
> --
> 2.21.0
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20190808084253.10573-1-clabbe.montjoie%40gmail.com.
