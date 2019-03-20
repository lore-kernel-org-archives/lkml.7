Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D37EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5B0213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553085767;
	bh=Mb8MDZe/dnoG/NeNKp2b9QF5AQ3pzP/m9Q2AQopQThc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=taHRk6LmYnMUJ6YDrtDnyVPi9Dtw0vGA/5pXDs4coOdbiEKPz5ZudCEIx9Or4L0hm
	 KWXG+Z2xmsT5J9Y5ZQX0/Oq7tPVcWh0YBXLIt/v2l1Shn0YvEX5+DL0TFUOMln0B04
	 GT8B5LPM9UUZTcIBrSSIF5fWpImRf9Rfg31EbLNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCTMmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:42:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfCTMmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:42:45 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80856213F2;
        Wed, 20 Mar 2019 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553085764;
        bh=Mb8MDZe/dnoG/NeNKp2b9QF5AQ3pzP/m9Q2AQopQThc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0nSEC2/dK6Oo3uBAmv9YuuRV2vvTrRSgAXQqTRYSEOsOhfAy5gB/spxhiD28GBtYg
         6pGaSnbgDhnqr+mlb48SU7bRQ+AhgpRCIxDM9c4L9YbZPuIby7oupkHayGCcnbO5xJ
         eMaUjY9KvAzdiONinQ3qObVJUfB9MIFhzD0dQeOQ=
Date:   Wed, 20 Mar 2019 20:42:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: imx6q-logicpd: Shutdown LCD regulator
 during suspend
Message-ID: <20190320124221.GN4980@dragon>
References: <20190306140402.17122-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306140402.17122-1-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:03:59AM -0600, Adam Ford wrote:
> The LCD power sequencer is very finicky.  The backlight cannot
> be driven until after the sequencer is done.  Until now, the
> regulators were marked with 'regulator-always-on' to make sure
> it came up before the backlight.  This patch allows the LCD
> regulators to power down and prevent the backlight from being
> used again until the sequencer is ready.  This reduces
> standby power consumption by ~100mW.
> 
> Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic
> PD i.MX6QD EVM")

Fixes tag is more for regressions or serious bugs.  It looks the patch
is more like an improvement though.

Shawn

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
> index 45eb0b7f75f8..d96ae54be338 100644
> --- a/arch/arm/boot/dts/imx6q-logicpd.dts
> +++ b/arch/arm/boot/dts/imx6q-logicpd.dts
> @@ -21,6 +21,8 @@
>  
>  	panel-lvds0 {
>  		compatible = "okaya,rs800480t-7x0gp";
> +		power-supply = <&reg_lcd_reset>;
> +		backlight = <&backlight>;
>  
>  		port {
>  			panel_in_lvds0: endpoint {
> @@ -38,7 +40,6 @@
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio4 17 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
> -		regulator-always-on;
>  		vin-supply = <&reg_3v3>;
>  		startup-delay-us = <500000>;
>  	};
> @@ -52,7 +53,6 @@
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
> -		regulator-always-on;
>  		vin-supply = <&reg_lcd>;
>  	};
>  };
> -- 
> 2.17.1
> 
