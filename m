Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3969EC47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C7D208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 06:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572243001;
	bh=T8EqyovEiIZHr2MwOzu+mAUM1YvBcgYwUFn7W1qhsKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cR7POW9FNS+IvgfL9D8g4X38W8BdbIp0tMnoF4LNCVHDfpo3miapZuW+ZIYkf2D54
	 211cLBP6WFmPIJ2zXQqrQ9IjkltcYn871sjDQ7/IIwcuOjRDzZIEfnaFPMefjlXuz4
	 9bnQFKm/+KzOMeCuXKAa8FrR6nhHrRi/YWyr/S8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbfJ1GJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 02:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727559AbfJ1GJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 02:09:59 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DA4220873;
        Mon, 28 Oct 2019 06:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572242998;
        bh=T8EqyovEiIZHr2MwOzu+mAUM1YvBcgYwUFn7W1qhsKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDHgLhOT45zthwB/Wz8w2XgXHgkmFEakpbyYErk9CC6XetrSbeDwAYVXvNQAPO1Rl
         h2hYQqAwcn24HTSCvkZufbBBi74prcHczFm86+vaIn1mVmKrTJvM5EBWg1Gft4up84
         UI+tWDa1QngP7YshW09BIGqpczC3Hr1E8fdUZ+xI=
Date:   Mon, 28 Oct 2019 14:09:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-usb@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] ARM: dts: colibri-imx6ull: add extcon for usbotg1
Message-ID: <20191028060930.GL16985@dragon>
References: <20191021161654.14353-1-igor.opaniuk@gmail.com>
 <20191021161654.14353-2-igor.opaniuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021161654.14353-2-igor.opaniuk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 07:16:54PM +0300, Igor Opaniuk wrote:
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
> 
> Add extcon usb gpio configuration for support dual roles for usbotg1.
> 
> USB host/gadget switching test (1. USB NIC emulation; 2. USB storage):
> 
> [   52.491957] ci_hdrc ci_hdrc.1: switching to gadget role
> [   52.502911] mxs_phy 20c9000.usbphy: vbus is not valid
> [   56.749160] using random self ethernet address
> [   56.758637] using random host ethernet address
> [   65.768968] usb0: HOST MAC 00:14:2d:ff:ff:fe
> [   65.887980] usb0: MAC 00:14:2d:ff:ff:ff
> [   66.294961] configfs-gadget gadget: high-speed config #1: c
> [   78.741971] ci_hdrc ci_hdrc.1: switching to host role
> [   78.747522] ci_hdrc ci_hdrc.1: EHCI Host Controller
> [   78.790174] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus
> number 2
> [   78.868498] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>
> ---
> 
>  arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> index a78849fd2afa..988f1a800d5a 100644
> --- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
> @@ -29,6 +29,14 @@
>  		clock-frequency = <16000000>;
>  	};
>  
> +	extcon_usbc_det: usbc_det {

Can we find a more generic name for the node?  Also hyphen is preferred
over underscore in node name.

Shawn

> +		compatible = "linux,extcon-usb-gpio";
> +		debounce = <25>;
> +		id-gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_snvs_usbc_det>;
> +	};
> +
>  	panel: panel {
>  		compatible = "edt,et057090dhu";
>  		backlight = <&bl>;
> @@ -150,6 +158,7 @@
>  };
>  
>  &usbotg1 {
> +	extcon = <&extcon_usbc_det &extcon_usbc_det>;
>  	status = "okay";
>  };
>  
> -- 
> 2.17.1
> 
