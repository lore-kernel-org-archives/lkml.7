Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4BCC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72ED8214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732168AbfKFQSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:18:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50627 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbfKFQSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:18:21 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iSO0f-0000VI-4J; Wed, 06 Nov 2019 17:18:17 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iSO0d-0003OC-GA; Wed, 06 Nov 2019 17:18:15 +0100
Date:   Wed, 6 Nov 2019 17:18:15 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH V2] ARM: dts: imx6q-logicpd: Enable ili2117a Touchscreen
Message-ID: <20191106161815.uwcoe7spn3seupaq@pengutronix.de>
References: <20191106142308.10511-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106142308.10511-1-aford173@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 17:17:26 up 172 days, 22:35, 120 users,  load average: 0.16, 0.11,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 19-11-06 08:23, Adam Ford wrote:
> The LCD used with the imx6q-logicpd board has an integrated
> ili2117a touch controller connected to i2c1.
> 
> This patch adds the node to enable this feature.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> ili2117 support is scheduled to be introduced for Kernel v5.5.
> 
> V2:  Change node to touchscreen@26 and move comment about 5.5 to under the dashes
> 
> diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
> index d96ae54be338..7a3d1d3e54a9 100644
> --- a/arch/arm/boot/dts/imx6q-logicpd.dts
> +++ b/arch/arm/boot/dts/imx6q-logicpd.dts
> @@ -73,6 +73,16 @@
>  	status = "okay";
>  };
>  
> +&i2c1 {
> +	touchscreen@26 {
> +		compatible = "ilitek,ili2117";
> +		reg = <0x26>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_touchscreen>;

This phandle already exists?

Regards,
  Marco

> +		interrupts-extended = <&gpio1 6 IRQ_TYPE_EDGE_RISING>;
> +	};
> +};
> +
>  &ldb {
>  	status = "okay";
>  
> -- 
> 2.20.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
