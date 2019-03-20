Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948E32184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553086020;
	bh=wSDQahDNWPxO8uz9bAcJz8KNpTFPd4rWBNlQU6SNS/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LWm4q0YbTPtAZ4rqn6783zJLb+O6suhDi5vhZpAeTPkyxDfC7M2qvZ73CXj+jr+XO
	 4AyUsv3O3HO6GekffPnUq4+Mi6ALqIDTB7AnQF/lnBVyeYJPx3+sIBqtFdP0N1ag18
	 HrHA5pVFHC9JsqruwojpvYZN0ztY5I7yb1jC8+6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfCTMq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfCTMq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:46:59 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7AB1213F2;
        Wed, 20 Mar 2019 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553086018;
        bh=wSDQahDNWPxO8uz9bAcJz8KNpTFPd4rWBNlQU6SNS/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2fo0FgnEkpFld8yEZePyxJxfzatmn31WTJ14oW63KIF1Bg2VKn911X/z9xfHkXv6I
         cEfWMerRatoQdyminABk+q+2u8a2K4TusN2DsFowjtB+YPiUyLAWPvpoVf3KOHXbg3
         VyqeDhNf6rTlrcmGiMKM07ooW9JcXTnZPFLYtB2I=
Date:   Wed, 20 Mar 2019 20:46:35 +0800
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
Subject: Re: [PATCH 3/3] ARM: DTS: imx6q-logicpd: Fix Analog audio capture
Message-ID: <20190320124634.GP4980@dragon>
References: <20190306140402.17122-1-aford173@gmail.com>
 <20190306140402.17122-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306140402.17122-3-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:04:01AM -0600, Adam Ford wrote:
> The original submission had functional audio out and was based
> on reviewing other boards using the same wm8962 codec. However,
> the Logic PD board uses an analog microphone which was being
> disabled for a digital mic.  This patch corrects that and
> explicitly sets the gpio-cfg pins all to 0x0000 which allows the
> analog microphone to capture audio.
> 
> Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
> i.MX6QD EVM")

If audio capture has never worked, the change is more like a "new feature"
than critical fix.

Shawn

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> index e31b6923cb72..db6b5b900826 100644
> --- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> +++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> @@ -248,9 +248,9 @@
>  		gpio-cfg = <
>  			0x0000 /* 0:Default */
>  			0x0000 /* 1:Default */
> -			0x0013 /* 2:FN_DMICCLK */
> +			0x0000 /* 2:FN_DMICCLK */
>  			0x0000 /* 3:Default */
> -			0x8014 /* 4:FN_DMICCDAT */
> +			0x0000 /* 4:FN_DMICCDAT */
>  			0x0000 /* 5:Default */
>  		>;
>  	};
> -- 
> 2.17.1
> 
