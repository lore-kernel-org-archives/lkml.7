Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA2EC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A982073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575384247;
	bh=Vb5aXB2aX+gF6f+cuazczJG4nAEA8YenYXVOkT2E0yI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IDPlCq0918yGSSNffPWGkQxKCpIqEXPHtKq7UNqaPVF1mQQGQoWqVzul+7HnLIF3X
	 0GBYBj2auC92Wqe2ZjbiNQMJeIBeyBPn3/KltUzC2f9c5j+4xqNNVt8vHXipFCJrbZ
	 ZAcrc76VclOCKJISfihlyRnW1YKjl3x2+NiUb5tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfLCOoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:44:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:56170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCOoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:44:06 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA0520848;
        Tue,  3 Dec 2019 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575384244;
        bh=Vb5aXB2aX+gF6f+cuazczJG4nAEA8YenYXVOkT2E0yI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i4SZp7OR5A3xUaJTwT2SQ34ZFbE8HZJAylsqj+shAJpk7PBjc0zmRBE2W2r4mttpF
         leE4RRIEGsoLvHNT51Cg9ew4RBq0WZGHbQK/o/CrxP++AGOuXC4oknzMoHXJuq8/Ej
         /yT1BIpgmwEjvZR0ytVgAtBRo5IvSqouapJkMqY4=
Received: by mail-qt1-f175.google.com with SMTP id s8so768560qte.2;
        Tue, 03 Dec 2019 06:44:04 -0800 (PST)
X-Gm-Message-State: APjAAAVKf7zHD2RxqkQCf/T/6nGoOEuU+NwhjOlY5YZzj3qXVdmBJ6Fl
        vgzOCp/IKxFBqchVhq60G66PY8/r3IMZgpy4zQ==
X-Google-Smtp-Source: APXvYqwtexQ5zo9ZimQeqDp9BS65TDnucMrw2I96L1AtL1jBY6DHB8RwSL6Mo2Z5PWeDgBxoOukGgcq4zG7e9CQKVtY=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr5304524qtp.224.1575384243826;
 Tue, 03 Dec 2019 06:44:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
 <141f068d10b94413a6d0ca73fe07f8e961380e7b.1575369656.git-series.andrew@aj.id.au>
In-Reply-To: <141f068d10b94413a6d0ca73fe07f8e961380e7b.1575369656.git-series.andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Dec 2019 08:43:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ8p-zs2F-mXkO_egoBtZ8WymM4O-2AaDJMZYeCFS3sLg@mail.gmail.com>
Message-ID: <CAL_JsqJ8p-zs2F-mXkO_egoBtZ8WymM4O-2AaDJMZYeCFS3sLg@mail.gmail.com>
Subject: Re: [PATCH 05/14] ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adriana Kobylak <anoo@us.ibm.com>,
        Brian Yang <yang.brianc.w@inventec.com>,
        John Wang <wangzqbj@inspur.com>,
        Ken Chen <chen.kenyy@inventec.com>, Tao Ren <taoren@fb.com>,
        Xo Wang <xow@google.com>, Yuan Yao <yao.yuan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 6:03 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> The existing approach lead to an error from the dtbs_check:
>
>     pinctrl: aspeed,external-nodes: [[8, 9]] is too short

This one where we have list of phandles is fixed in dtc. I need to
update the kernel's copy.

> Cc: Adriana Kobylak <anoo@us.ibm.com>
> Cc: Brian Yang <yang.brianc.w@inventec.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: John Wang <wangzqbj@inspur.com>
> Cc: Ken Chen <chen.kenyy@inventec.com>
> Cc: Tao Ren <taoren@fb.com>
> Cc: Xo Wang <xow@google.com>
> Cc: Yuan Yao <yao.yuan@linaro.org>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts     |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts         |  9 +++++++--
>  arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts           |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts             |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts             |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts               |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts         |  4 +----
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts               |  2 +--
>  arch/arm/boot/dts/aspeed-g5.dtsi                         |  3 +--
>  10 files changed, 8 insertions(+), 34 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> index c2ece0b91885..de9612e49c69 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts
> @@ -211,10 +211,6 @@
>         status = "okay";
>  };
>
> -&pinctrl {
> -       aspeed,external-nodes = <&gfx &lhc>;
> -};
> -
>  &gpio {
>         pin_gpio_c7 {
>                 gpio-hog;
> diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> index 2c29ac037d32..022d0744d786 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
> @@ -200,10 +200,6 @@
>         status = "okay";
>  };
>
> -&pinctrl {
> -       aspeed,external-nodes = <&gfx &lhc>;
> -};
> -
>  &gpio {
>         pin_gpio_c7 {
>                 gpio-hog;
> diff --git a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> index c17bb7fce7ff..d69da58476fe 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts
> @@ -782,8 +782,13 @@
>         memory-region = <&gfx_memory>;
>  };
>
> -&pinctrl {
> -       aspeed,external-nodes = <&gfx &lhc>;
> +&gpio {
> +       pin_gpio_b7 {
> +               gpio-hog;
> +               gpios = <ASPEED_GPIO(B,7) GPIO_ACTIVE_LOW>;
> +               output-high;
> +               line-name = "BMC_INIT_OK";
> +       };

Seems like an unrelated change?

Rob
