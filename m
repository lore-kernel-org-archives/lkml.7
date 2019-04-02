Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD96BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40932082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 06:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDBGJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 02:09:07 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:44843 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfDBGJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 02:09:06 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id DC82B4000C;
        Tue,  2 Apr 2019 06:09:02 +0000 (UTC)
Date:   Tue, 2 Apr 2019 08:09:01 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] soc: sunxi: Fix missing dependency on REGMAP_MMIO
Message-ID: <20190402060901.rowpoenurzbolyby@flea>
References: <20190401220331.44720-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401220331.44720-1-samuel@sholland.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 05:03:31PM -0500, Samuel Holland wrote:
> When enabling ARCH_SUNXI from allnoconfig, SUNXI_SRAM is enabled, but
> not REGMAP_MMIO, so the kernel fails to link with an undefined reference
> to __devm_regmap_init_mmio_clk. Select REGMAP_MMIO, as suggested in
> drivers/base/regmap/Kconfig.
>
> This creates the following dependency loop:
>
>   drivers/of/Kconfig:68:                symbol OF_IRQ depends on IRQ_DOMAIN
>   kernel/irq/Kconfig:63:                symbol IRQ_DOMAIN is selected by REGMAP
>   drivers/base/regmap/Kconfig:7:        symbol REGMAP default is visible depending on REGMAP_MMIO
>   drivers/base/regmap/Kconfig:39:       symbol REGMAP_MMIO is selected by SUNXI_SRAM
>   drivers/soc/sunxi/Kconfig:4:          symbol SUNXI_SRAM is selected by USB_MUSB_SUNXI
>   drivers/usb/musb/Kconfig:63:          symbol USB_MUSB_SUNXI depends on GENERIC_PHY
>   drivers/phy/Kconfig:7:                symbol GENERIC_PHY is selected by PHY_BCM_NS_USB3
>   drivers/phy/broadcom/Kconfig:29:      symbol PHY_BCM_NS_USB3 depends on MDIO_BUS
>   drivers/net/phy/Kconfig:12:           symbol MDIO_BUS default is visible depending on PHYLIB
>   drivers/net/phy/Kconfig:181:          symbol PHYLIB is selected by ARC_EMAC_CORE
>   drivers/net/ethernet/arc/Kconfig:18:  symbol ARC_EMAC_CORE is selected by ARC_EMAC
>   drivers/net/ethernet/arc/Kconfig:24:  symbol ARC_EMAC depends on OF_IRQ
>
> To fix the circular dependency, make USB_MUSB_SUNXI select GENERIC_PHY
> instead of depending on it. This matches the use of GENERIC_PHY by all
> but two other drivers.
>
> Cc: <stable@vger.kernel.org> # 4.19
> Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
