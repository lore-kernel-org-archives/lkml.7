Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB4FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2451620850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfCRMlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:41:37 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:58253 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbfCRMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:41:36 -0400
X-Originating-IP: 90.88.22.102
Received: from aptenodytes (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A971A4000B;
        Mon, 18 Mar 2019 12:41:32 +0000 (UTC)
Message-ID: <ea4f86798466bd9680f064f663a50450452509bc.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 11/14] ARM: sunxi: dts: s3/s3l/v3: add
 DTSI files for S3/S3L/V3 SoCs
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     icenowy@aosc.io, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Date:   Mon, 18 Mar 2019 13:41:32 +0100
In-Reply-To: <20190312152256.35574-12-icenowy@aosc.io>
References: <20190312152256.35574-1-icenowy@aosc.io>
         <20190312152256.35574-12-icenowy@aosc.io>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mardi 12 mars 2019 à 23:22 +0800, Icenowy Zheng a écrit :
> The Allwinner S3/S3L/V3 SoCs all share the same die with the V3s SoC,
> but with more GPIO wired out of the package.
> 
> Add DTSI files for these SoCs. The DTSI file for V3 just replaces the
> pinctrl compatible string, and the S3/S3L DTSI files just include the V3
> DTSI file.

Note that the V3 has a NMI controller at 1c000d0, that is required for
handling the AXP209 interrupts IIRQ. I have no idea whether it's also
the case on the V3s/S3/S3L though but it would be good to know.

Note that I can totally add support for it when adding support for my
V3 device that uses the AXP209 this way.

Also, could we get proper compatibles and config options for these new
SoCs, since they are distinct from the V3S?

Cheers,

Paul

> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm/boot/dts/sun8i-s3.dtsi  |  6 ++++++
>  arch/arm/boot/dts/sun8i-s3l.dtsi |  6 ++++++
>  arch/arm/boot/dts/sun8i-v3.dtsi  | 14 ++++++++++++++
>  3 files changed, 26 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun8i-s3.dtsi
>  create mode 100644 arch/arm/boot/dts/sun8i-s3l.dtsi
>  create mode 100644 arch/arm/boot/dts/sun8i-v3.dtsi
> 
> diff --git a/arch/arm/boot/dts/sun8i-s3.dtsi b/arch/arm/boot/dts/sun8i-s3.dtsi
> new file mode 100644
> index 000000000000..0f41a25ecb30
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-s3.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include "sun8i-v3.dtsi"
> diff --git a/arch/arm/boot/dts/sun8i-s3l.dtsi b/arch/arm/boot/dts/sun8i-s3l.dtsi
> new file mode 100644
> index 000000000000..0f41a25ecb30
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-s3l.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include "sun8i-v3.dtsi"
> diff --git a/arch/arm/boot/dts/sun8i-v3.dtsi b/arch/arm/boot/dts/sun8i-v3.dtsi
> new file mode 100644
> index 000000000000..6ae8645ade50
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun8i-v3.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2019 Icenowy Zheng <icenowy@aosc.io>
> + */
> +
> +#include "sun8i-v3s.dtsi"
> +
> +&ccu {
> +	compatible = "allwinner,sun8i-v3-ccu";
> +};
> +
> +&pio {
> +	compatible = "allwinner,sun8i-v3-pinctrl";
> +};
> -- 
> 2.18.1
> 
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

