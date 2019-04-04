Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34985C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0529C2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WNMOlkhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDDPfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:35:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37740 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:35:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x34FZ0em078687;
        Thu, 4 Apr 2019 10:35:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554392100;
        bh=w0Cz1srKPgpcYauwStaJmmGNJb40SBPlFtN5GjjVJCI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=WNMOlkhx0Mtsi1wHFbmp1AEeh2Ak5jpNH8/35Wo0K4i8T8NgqaB+pr3tTwkGfUDx3
         XfhocrtaQh0q63D1e7+pZuLiAbnH1m1jTsXoWYxzdP5n83ZRfci5p4+rrsFHK1zqEQ
         A50o7FtbEiJa1Crr+eb0lMs8IU4U9bHdGx7iLZS4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x34FZ05A019370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Apr 2019 10:35:00 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 4 Apr
 2019 10:34:59 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 4 Apr 2019 10:34:59 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x34FYx9o044439;
        Thu, 4 Apr 2019 10:34:59 -0500
Date:   Thu, 4 Apr 2019 10:34:59 -0500
From:   Bin Liu <b-liu@ti.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-sunxi@googlegroups.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] soc: sunxi: Fix missing dependency on REGMAP_MMIO
Message-ID: <20190404153459.GT25852@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-sunxi@googlegroups.com,
        stable@vger.kernel.org
References: <20190401220331.44720-1-samuel@sholland.org>
 <20190402060901.rowpoenurzbolyby@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190402060901.rowpoenurzbolyby@flea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:09:01AM +0200, Maxime Ripard wrote:
> On Mon, Apr 01, 2019 at 05:03:31PM -0500, Samuel Holland wrote:
> > When enabling ARCH_SUNXI from allnoconfig, SUNXI_SRAM is enabled, but
> > not REGMAP_MMIO, so the kernel fails to link with an undefined reference
> > to __devm_regmap_init_mmio_clk. Select REGMAP_MMIO, as suggested in
> > drivers/base/regmap/Kconfig.
> >
> > This creates the following dependency loop:
> >
> >   drivers/of/Kconfig:68:                symbol OF_IRQ depends on IRQ_DOMAIN
> >   kernel/irq/Kconfig:63:                symbol IRQ_DOMAIN is selected by REGMAP
> >   drivers/base/regmap/Kconfig:7:        symbol REGMAP default is visible depending on REGMAP_MMIO
> >   drivers/base/regmap/Kconfig:39:       symbol REGMAP_MMIO is selected by SUNXI_SRAM
> >   drivers/soc/sunxi/Kconfig:4:          symbol SUNXI_SRAM is selected by USB_MUSB_SUNXI
> >   drivers/usb/musb/Kconfig:63:          symbol USB_MUSB_SUNXI depends on GENERIC_PHY
> >   drivers/phy/Kconfig:7:                symbol GENERIC_PHY is selected by PHY_BCM_NS_USB3
> >   drivers/phy/broadcom/Kconfig:29:      symbol PHY_BCM_NS_USB3 depends on MDIO_BUS
> >   drivers/net/phy/Kconfig:12:           symbol MDIO_BUS default is visible depending on PHYLIB
> >   drivers/net/phy/Kconfig:181:          symbol PHYLIB is selected by ARC_EMAC_CORE
> >   drivers/net/ethernet/arc/Kconfig:18:  symbol ARC_EMAC_CORE is selected by ARC_EMAC
> >   drivers/net/ethernet/arc/Kconfig:24:  symbol ARC_EMAC depends on OF_IRQ
> >
> > To fix the circular dependency, make USB_MUSB_SUNXI select GENERIC_PHY
> > instead of depending on it. This matches the use of GENERIC_PHY by all
> > but two other drivers.
> >
> > Cc: <stable@vger.kernel.org> # 4.19
> > Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

The patch is applied.

Thanks,
-Bin.
