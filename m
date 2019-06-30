Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DD5C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5689F2086D
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 20:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF3UDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 16:03:09 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:33738 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF3UDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 16:03:08 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CCB2680426;
        Sun, 30 Jun 2019 22:03:01 +0200 (CEST)
Date:   Sun, 30 Jun 2019 22:02:59 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric =?iso-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>, mka@chromium.org
Subject: Re: [PATCH v5 1/7] dt-bindings: Add panel-timing subnode to
 simple-panel
Message-ID: <20190630200259.GA15102@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401171724.215780-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=8nJEP1OIZ-IA:10 a=cm27Pg_UAAAA:8
        a=-VAfIpHNAAAA:8 a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=JfrnYn6hAAAA:8 a=rQ-KyBzUA4MiSMEBMPUA:9
        a=wPNLvfGTeEIA:10 a=xmb-EsYY8bH0VWELuYED:22 a=srlwD-8ojaedGGhPAyx8:22
        a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
        a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas.

Some long overdue review feedback.

On Mon, Apr 01, 2019 at 10:17:18AM -0700, Douglas Anderson wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> This patch adds a new subnode to simple-panel allowing us to override
> the typical timing expressed in the panel's display_timing.
> 
> Changes in v2:
>  - Split out the binding into a new patch (Rob)
>  - display-timings is a new section (Rob)
>  - Use the full display-timings subnode instead of picking the timing
>    out (Rob/Thierry)
> Changes in v3:
>  - Go back to using the timing subnode directly, but rename to
>    panel-timing (Rob)
> Changes in v4:
>  - Simplify desc. for when override should be used (Thierry/Laurent)
>  - Removed Rob H review since it's been a year and wording changed
> Changes in v5:
>  - Removed bit about OS may ignore (Rob/Ezequiel)
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jeffy Chen <jeffy.chen@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../bindings/display/panel/simple-panel.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> index b2b872c710f2..93882268c0b9 100644
> --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> @@ -15,6 +15,16 @@ Optional properties:
>    (hot plug detect) signal, but the signal isn't hooked up so we should
>    hardcode the max delay from the panel spec when powering up the panel.
>  
> +panel-timing subnode
> +--------------------
> +
> +This optional subnode is for devices which require a mode differing
> +from the panel's "typical" display timing.
Meybe add here that it is expected that the panel has included timing
in the driver itself, and not as part of DT.
So what is specified here is a more precise variant, within the limits
of what is specified for the panel.

> +
> +Format information on the panel-timing subnode can be found in
> +display-timing.txt.
display-timing defines otional properties:
hsync-active, pixelclk-active, doublescan etc.
It is not from the above obvious which properties from display-timings
that can be specified for a panel-timing sub-node.
Maybe because they can all be specified?

Display-timing allows timings to be specified as a range.
If it is also OK to specify a range for panle-timing then everythign is
fine. But if the panel-timign subnode do not allow ranges this needs to
be specified.

> +
> +
>  Example:
>  
>  	panel: panel {
> @@ -25,4 +35,16 @@ Example:
>  		enable-gpios = <&gpio 90 0>;
>  
>  		backlight = <&backlight>;
> +
> +		panel-timing {
> +			clock-frequency = <266604720>;
> +			hactive = <2400>;
> +			hfront-porch = <48>;
> +			hback-porch = <84>;
> +			hsync-len = <32>;
> +			vactive = <1600>;
> +			vfront-porch = <3>;
> +			vback-porch = <120>;
> +			vsync-len = <10>;
> +		};
>  	};
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
