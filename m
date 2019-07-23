Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA63FC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBC4223BB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563870347;
	bh=w3B1ItU9af+2ThyYfj4Etfner4HloKJVaabGxBGnsmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e2FsvzfpR2vBiJmbH9miaNSUCmkVNFSjRebKdr2Isxw9Zm5/MjwFQtAbVL2hVOhNp
	 rW159iylq4rz5NA1TliiL9+BTLneohRzDemNYw0pbGus/ecpTcalNZ5IEK/9x8cFRY
	 44nkXYDgwwprBtfD5gZDsw3vq2SPzPfsEzkqXq+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733244AbfGWIZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729099AbfGWIZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:25:46 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6A421BF6;
        Tue, 23 Jul 2019 08:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563870345;
        bh=w3B1ItU9af+2ThyYfj4Etfner4HloKJVaabGxBGnsmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2s4gp6NpnNdE5rAbKTw9d+dy87bdiUMkX4lNqd+x30p3dZSTe0Vl8l1V1OuNVgPM
         3U0rO05l9Bwc5XZSH9mlo/4JVtine1tevzdsA1d5mH+EbIaLVFGGO7AC07K1eZTX1S
         RC35YUpUs76VokNk1DobN/Lx2Z/61BDjwftw8bJ0=
Date:   Tue, 23 Jul 2019 16:25:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     andradanciu1997 <andradanciu1997@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        Michal.Vokac@ysoft.com, ping.bai@nxp.com,
        u.kleine-koenig@pengutronix.de, leoyang.li@nxp.com,
        aisheng.dong@nxp.com, l.stach@pengutronix.de,
        pankaj.bansal@nxp.com, angus@akkea.ca, pramod.kumar_1@nxp.com,
        bhaskar.upadhaya@nxp.com, vabhav.sharma@nxp.com,
        richard.hu@technexion.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 0/2] Add basic support for pico-pi-imx8m
Message-ID: <20190723082509.GS15632@dragon>
References: <20190722102730.15763-1-andradanciu1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722102730.15763-1-andradanciu1997@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:27:28PM +0300, andradanciu1997 wrote:
> Add support for TechNexion PICO-PI-IMX8M based on patches from Richard Hu
> Datasheet is at: https://s3.us-east-2.amazonaws.com/technexion/datasheets/picopiimx8m.pdf
> 
> Changes since v5:
>  - removed comment /* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
>  - added "Reviewed-by" tags
> 
> Changes since v4:
>  - removed #address-cells and  #size-cells from regulators node
> 
> Changes since v3:
>  - renamed pico-pi-8m.dts to imx8mq-pico-pi.dts
>  - moved iomuxc node as the last one
>  - removed pinctrl-assert-gpios property from fec1 node
>  - removed at803x,led-act-blind-workaround, at803x,eee-disabled
>    properties from mdio node
>  - added pinctrl-names = "default" to i2c1 node
>  - changed bd71837 pmic support properties according to
>    Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
>  - removed A53_0 node
> 
> Changes since v2:
>  - changed PICO-PI-8M bord compatible from wand,imx8mq-pico-pi to
>    technexion,pico-pi-imx8m
>  - removed bootargs property
>  - removed regulators node and put fixed regulator directly under root node
>  - changed node name from usb_otg_vbus to regulator-usb-otg-vbus
>  - removed pinctrl-names property from iomuxc node
>  - removed wand-pi-8m container node
>  - sorted pinctrl nodes alphabetically
>  - removed tusb320_irqgrp, tusb320_irqgrp nodes because there is no upstream
>    driver
>  - changed properties' order in usb_dwc3_1 node
> 
> Changes since v1:
>  - renamed wandboard-pi-8m.dts to pico-pi-8m.dts
>  - removed pinctrl_csi1, pinctrl_wifi_ctrl
>  - used generic name for pmic
>  - removed gpo node
>  - delete regulator-virtuals node
>  - remove always-on property from buck1-8 and ldo3-7
>  - remove pmic-buck-uses-i2c-dvs property for buck1-4
> 
> Andra Danciu (1):
>   dt-bindings: arm: fsl: Add the pico-pi-imx8m board
> 
> Richard Hu (1):
>   arm64: dts: fsl: pico-pi: Add a device tree for the PICO-PI-IMX8M

Applied both, thanks.
