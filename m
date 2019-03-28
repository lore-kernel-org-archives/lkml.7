Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFCCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCAB217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfC1U1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:27:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54628 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfC1U1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:27:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 554332820F7
Message-ID: <f2f82f439f2b7586cb4c83f15122d8d19952d596.camel@collabora.com>
Subject: Re: [PATCH v4 1/7] dt-bindings: Add panel-timing subnode to
 simple-panel
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>
Cc:     linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        Eric Anholt <eric@anholt.net>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 28 Mar 2019 17:26:49 -0300
In-Reply-To: <20190328171710.31949-2-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org>
         <20190328171710.31949-2-dianders@chromium.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-28 at 10:17 -0700, Douglas Anderson wrote:
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
>  .../bindings/display/panel/simple-panel.txt   | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/simple-panel.txt b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> index b2b872c710f2..6157f86ddce4 100644
> --- a/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/simple-panel.txt
> @@ -15,6 +15,18 @@ Optional properties:
>    (hot plug detect) signal, but the signal isn't hooked up so we should
>    hardcode the max delay from the panel spec when powering up the panel.
>  
> +panel-timing subnode
> +--------------------
> +
> +This optional subnode is for devices which require a mode differing
> +from the panel's "typical" display timing.  The panel timings provided
> +here will be ignored if they are found to be outside of allowable
> +ranges for the given panel.
> +

Is it OK to put this comment about how the implementation
will behave when values are out of range, given this is just a binding
spec?

Perhaps -if needed- this sentence can be rephrased to state that,
e.g. the OS may not be able to apply these values, if the controller
or device is unable to?

> +Format information on the panel-timing subnode can be found in
> +display-timing.txt.
> +
> +
>  Example:
>  
>  	panel: panel {
> @@ -25,4 +37,16 @@ Example:
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


