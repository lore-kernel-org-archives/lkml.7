Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F94FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C032184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553085913;
	bh=8BTQVR7Tz8x3i0wDw3ag6xnAdHY300MYXCdWvjQ+5uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rk2prsME2tiV6uK6JDAf2aMqoJzYz+ds1AmQOtMPcxCtCuz++mQEfrFwACOK4JXkF
	 +QuKEEarWokLGngdQnKBeO19xZRxck3lkVUytmKDezWfW1BLqn1hsOG08Zr2EJYoei
	 w0r7VLQMIGWsujDe/ewuwajNQV2KMvaB/Lu7lDX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfCTMpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfCTMpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:45:11 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3414D213F2;
        Wed, 20 Mar 2019 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553085911;
        bh=8BTQVR7Tz8x3i0wDw3ag6xnAdHY300MYXCdWvjQ+5uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=azlQSspJF3wYSMGUEfsmi9XhUVjkRLE8JPoRJzdkaZx0QRbc3mD+Fl+TDfXjv5VJW
         Es3NuQdmLXE71tuz69KohHEOqLRSWTGShmtpXwp3O5xI5JxVrx71ofSCSueAPva9ot
         8ET70UwfuhEau5wwtpMwZt/ufjdA1JMckzJVGEo4=
Date:   Wed, 20 Mar 2019 20:44:48 +0800
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
Subject: Re: [PATCH 2/3] ARM: DTS: imx6q-logicpd: Reduce inrush current on
 start
Message-ID: <20190320124446.GO4980@dragon>
References: <20190306140402.17122-1-aford173@gmail.com>
 <20190306140402.17122-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306140402.17122-2-aford173@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:04:00AM -0600, Adam Ford wrote:
> The main 3.3V regulator sources a series of additional regulators.
> This patch adds a small delay, so when the 3.3V regulator comes
> on it delays a bit before the subsequent regulators can come on.
> This reduces the inrush current a bit on the external DC power
> supply.
> 
> Fixes: 1c207f911fe9 ("ARM: dts: imx: Add support for Logic PD
> i.MX6QD EVM")

Same comment as patch #1.

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

To match the convention, the 'DTS' in subject prefix should be
lowercase.

Shawn

> 
> diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> index fb01fa6e4224..e31b6923cb72 100644
> --- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> +++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
> @@ -99,6 +99,7 @@
>  		regulator-min-microvolt = <3300000>;
>  		regulator-max-microvolt = <3300000>;
>  		gpio = <&gpio1 26 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <70000>;
>  		enable-active-high;
>  		regulator-always-on;
>  	};
> -- 
> 2.17.1
> 
