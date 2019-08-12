Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D287EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A495D208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdI/+tQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfHLK5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:57:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45110 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfHLK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:57:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so13896099wrj.12;
        Mon, 12 Aug 2019 03:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K78hhqilCXirWAVkuhMYsumaEi1zxudUZQ7iEz3kX74=;
        b=PdI/+tQ4letAYBv2LKdyiQh79k8OXmFVdA1aPMzyFY6KxCZy8EyOOdBqoVf9JVMfVO
         30m3LjeMpdM0OZFZZTRtCKqs2nyVfFAIaEWbx3Jk51IPkPPtDLndfj71VGWrn8fzM8xY
         U3sY85j6CJkurFsMuJDvx6AXb4BZoWQ3TQgHguNVzPnpBhfLicn//ZIWc1h/Cvn1oHZc
         8Q33Y8rxq3+Xgt2uo2oj/4TpPz8X7vfH2CxNf27UpaHgUG3X7fxmCdiMl8x/jBItfRLz
         NcKuELcTui9SWipQsllbPTSVxldRd2NmBhVvztGPtdoZv89YJ/80d2yl3HCw6rarNtZm
         MwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K78hhqilCXirWAVkuhMYsumaEi1zxudUZQ7iEz3kX74=;
        b=k6oneRRghoxez0/VXZwLDx4s3lnZmq/+kyJbiybbJ4IcmpZ1g/yqPTBBylccdNhZ8B
         oKOyEp0d/2oB4O4n12t0x6jU+q88NRTLPqjI5uOz5XzkyaBYso8pCee7nNdIuZjNxnPv
         tK0qJbKNKNruR8q0sNMKKL0guGeVH/Vx2p7D7O3PppdFpTH9lCPNnQZqRVJgNh2TlZAH
         vnxn4LBjL1LzF6DrYCADNB6uTSe2YPreWskUt89q26T0KfmiemSyV3XZKuzZWMTqJojV
         ECB/efwpbA5NMCUtS37XIGgL/jBTM2Ckz9xtM+2hH9dq33VhaOtQqGwVXZLS7u3DSR7f
         DqZg==
X-Gm-Message-State: APjAAAUvFzBb+jSayQk7waA5mQmTgrE1iFr8bajzUkstQqOBN2JsWSUW
        9Y8AVdpz+JqzrP285/yUvTc=
X-Google-Smtp-Source: APXvYqzz1/k5WxBr/pJpNEMxkuMePNDA75QA3mkP0fkCS8qkAfo5N9m+7vaBmpiUqwP5ZR0e9K9n/A==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr38755203wrj.272.1565607419384;
        Mon, 12 Aug 2019 03:56:59 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id c65sm13285562wma.44.2019.08.12.03.56.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:56:58 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com, clabbe.montjoie@gmail.com
Cc:     mark.rutland@arm.com, mripard@kernel.org, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-sunxi] [PATCH] ARM64: dts: allwinner: Add devicetree for pine H64 modelA evaluation board
Date:   Mon, 12 Aug 2019 12:56:56 +0200
Message-ID: <1648748.TWHgARQioU@jernej-laptop>
In-Reply-To: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
References: <20190808084253.10573-1-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 08. avgust 2019 ob 10:42:53 CEST je Corentin Labbe napisa=
l(a):
> This patch adds the evaluation variant of the model A of the PineH64.
> The model A has the same size of the pine64 and has a PCIE slot.
>=20
> The only devicetree difference with current pineH64, is the PHY
> regulator.

I have Model A board which also needs ddc-en-gpios property for HDMI connec=
tor=20
in order for HDMI to work correctly. Otherwise it will just use 1024x768=20
resolution. Can you confirm that?

Best regards,
Jernej

>=20
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>  .../sun50i-h6-pine-h64-modelA-eval.dts        | 26 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
>  create mode 100644
> arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
> b/arch/arm64/boot/dts/allwinner/Makefile index f6db0611cb85..9a02166cbf72
> 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -25,3 +25,4 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-3.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-lite2.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-orangepi-one-plus.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-h6-pine-h64-modelA-eval.dtb
> diff --git
> a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts
> b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-modelA-eval.dts new fi=
le
> mode 100644
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
> +	model =3D "Pine H64 model A evaluation board";
> +	compatible =3D "pine64,pine-h64-modelA-eval", "allwinner,sun50i-h6";
> +
> +	reg_gmac_3v3: gmac-3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vcc-gmac-3v3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		startup-delay-us =3D <100000>;
> +		gpio =3D <&pio 2 16 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +};
> +
> +&emac {
> +	phy-supply =3D <&reg_gmac_3v3>;
> +};




