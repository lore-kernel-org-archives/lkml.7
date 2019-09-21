Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B66C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C602A2073F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 19:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbfIUTJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 15:09:46 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:60638 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfIUTJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 15:09:46 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 887AA2002D;
        Sat, 21 Sep 2019 21:09:42 +0200 (CEST)
Date:   Sat, 21 Sep 2019 21:09:41 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        adam.ford@logicpd.com, Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: logicpd-torpedo-37xx-devkit-28: Reference new
 DRM panel
Message-ID: <20190921190941.GD32133@ravnborg.org>
References: <20190917161214.2913-1-aford173@gmail.com>
 <20190917161214.2913-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917161214.2913-3-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=7gkXJVJtAAAA:8 a=4bu5KDIevAQmuqN_AgEA:9 a=CjuIK1q_8ugA:10
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam.

On Tue, Sep 17, 2019 at 11:12:13AM -0500, Adam Ford wrote:
> With the removal of the panel-dpi from the omap drivers, the
> LCD no longer works.  This patch points the device tree to
> a newly created panel named "logicpd,type28"
> 
> Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
Looks good.
One nit below.

With this addressed:

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
> 
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
> index 07ac99b9cda6..00c426bd51a0 100644
> --- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
> +++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
> @@ -11,22 +11,8 @@
>  #include "logicpd-torpedo-37xx-devkit.dts"
>  
>  &lcd0 {
> -
> +	/* This isn't the exact LCD, but the timings meet spec */
> +	/* To make it work, set CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 */
> +	compatible = "logicpd,type28";
>  	label = "28";
You left this property - but us it documented and what use has it?

> -
> -	panel-timing {
> -		clock-frequency = <9000000>;
> -		hactive = <480>;
> -		vactive = <272>;
> -		hfront-porch = <3>;
> -		hback-porch = <2>;
> -		hsync-len = <42>;
> -		vback-porch = <3>;
> -		vfront-porch = <2>;
> -		vsync-len = <11>;
> -		hsync-active = <1>;
> -		vsync-active = <1>;
> -		de-active = <1>;
> -		pixelclk-active = <0>;
> -	};
>  };
> -- 
> 2.17.1
