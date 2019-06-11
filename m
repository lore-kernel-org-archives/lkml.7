Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54379C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABAF21744
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Vo19II7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406853AbfFKSH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:07:28 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:36296 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406739AbfFKSH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:07:28 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5AD0EFA6;
        Tue, 11 Jun 2019 20:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1560276445;
        bh=U6cKsDlIYIUfJDEzJan9NNjl5MrieaoyWtyhjTAgz4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vo19II7zbYRl4pohD//ZsjLDurh4XnSv5I1Hy7ArCKvKqru7lg3u0uay0D89nhrMj
         8YQJj5RCRoL+L2ITwNGolf5osznyh/2qk17MiL1clDQktwm+OcaLxdORHCHfeUrivV
         e2rYFRwV3bT0NWBNdQ92AdePHJKImJuihtwF5Zdw=
Date:   Tue, 11 Jun 2019 21:07:10 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michael Drake <michael.drake@codethink.co.uk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@lists.codethink.co.uk,
        Patrick Glaser <pglaser@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v1 03/11] dt-bindings: display/bridge: Add config
 property for ti948
Message-ID: <20190611180710.GT5016@pendragon.ideasonboard.com>
References: <20190611140412.32151-1-michael.drake@codethink.co.uk>
 <20190611140412.32151-4-michael.drake@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190611140412.32151-4-michael.drake@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch.

On Tue, Jun 11, 2019 at 03:04:04PM +0100, Michael Drake wrote:
> The config property can be used to provide an array of
> register addresses and values to be written to configure
> the device for the board.

Please don't. DT describes the hardware (or more accurately the system),
it's not meant to store arbitrary configuration data. All the registers
specified below should instead be set by the driver based on a
combination of hardware description and information obtained at runtime.

> Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  .../bindings/display/bridge/ti,ds90ub948.txt  | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
> index f9e86cb22900..1e7033b0f3b7 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,ds90ub948.txt
> @@ -12,6 +12,8 @@ Required properties:
>  Optional properties:
>  
>  - regulators: List of regulator name strings to enable for operation of device.
> +- config: List of <register address>,<value> pairs to be set to configure
> +  device on powerup.  The register addresses and values are 8bit.
>  
>  Example
>  -------
> @@ -21,4 +23,23 @@ ti948: ds90ub948@0 {
>  
>  	regulators: "vcc",
>  	            "vcc_disp";
> +	config:
> +	        /* set error count to max */
> +	        <0x41>, <0x1f>,
> +	        /* sets output mode, no change noticed */
> +	        <0x49>, <0xe0>,
> +	        /* speed up I2C, 0xE is around 480KHz */
> +	        <0x26>, <0x0e>,
> +	        /* speed up I2C, 0xE is around 480KHz */
> +	        <0x27>, <0x0e>,
> +	        /* sets GPIO0 as an input */
> +	        <0x1D>, <0x13>,
> +	        /* set GPIO2 high, backlight PWM (set to 0x50 for normal use) */
> +	        <0x1E>, <0x50>,
> +	        /* sets GPIO3 as an output with remote control for touch XRES */
> +	        <0x1F>, <0x05>,
> +	        /* set GPIO5 high, backlight enable on new display */
> +	        <0x20>, <0x09>,
> +	        /* set GPIO7 and GPIO8 high to enable touch power and prox sense */
> +	        <0x21>, <0x91>;
>  };

-- 
Regards,

Laurent Pinchart
