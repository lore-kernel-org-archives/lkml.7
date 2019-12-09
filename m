Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9250AC04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57737207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KLmhXjwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfLIO4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:56:02 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:36732 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfLIO4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:56:02 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id F1DB1B2C;
        Mon,  9 Dec 2019 15:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1575903359;
        bh=vhHx1PjaeLJMGX9Xm/0FmdneX5UOPsaDKk1edME3V0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KLmhXjwxkqST47lNHsRUzGQqrDVHkl3c+KEPg1zP3Ttm5HKzRD51bsx7fPcEoof5N
         JkRhxfzbfdZyjwrPFyime4fUdMN//fdWye6bRsV+F6FR9CxaH6Yjbms1M9L5ujuLuG
         xFBjXkFEh0fGG39k1yujz9Qv7wmaOuWNTRh9wa3Q=
Date:   Mon, 9 Dec 2019 16:55:52 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Archit Taneja <architt@codeaurora.org>, p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH RESEND 3/4] dt-bindings: drm/bridge: analogix-anx78xx:
 support bypass GPIO
Message-ID: <20191209145552.GD12841@pendragon.ideasonboard.com>
References: <20191209145016.227784-1-hsinyi@chromium.org>
 <20191209145016.227784-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191209145016.227784-4-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Thank you for the patch.

On Mon, Dec 09, 2019 at 10:50:15PM +0800, Hsin-Yi Wang wrote:
> Support optional feature: bypass GPIO.
> 
> Some SoC (eg. mt8173) have a hardware mux that connects to 2 ports:
> anx7688 and hdmi. When the GPIO is active, the bridge is bypassed.

This doesn't look like the right place to fix this, as the mux is
unrelated to the bridge. You would have to duplicate this logic in every
bridge driver otherwise.

Could you describe the hardware topology in a bit more details ? I can
then try to advise on how to best support it.

> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../bindings/display/bridge/anx7688.txt       | 40 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.txt b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
> index 78b55bdb18f7..44185dcac839 100644
> --- a/Documentation/devicetree/bindings/display/bridge/anx7688.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7688.txt
> @@ -15,10 +15,13 @@ Required properties:
>  Optional properties:
>  
>   - Video port for HDMI input, using the DT bindings defined in [1].
> + - bypass-gpios        : External GPIO. If this GPIO is active, we assume
> + the bridge is bypassed (e.g. by a mux).
> + - pinctrl-0, pinctrl-names: the pincontrol settings to configure bypass GPIO.
>  
>  [1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>  
> -Example:
> +Example 1:
>  
>  	anx7688: anx7688@2c {
>  		compatible = "analogix,anx7688";
> @@ -30,3 +33,38 @@ Example:
>  			};
>  		};
>  	};
> +
> +Example 2:
> +
> +       anx7688: anx7688@2c {
> +               compatible = "analogix,anx7688";
> +               status = "okay";
> +               reg = <0x2c>;
> +               ddc-i2c-bus = <&hdmiddc0>;
> +
> +               bypass-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hdmi_mux_pins>;
> +
> +               ports {
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       port@0 { /* input */
> +                               reg = <0>;
> +
> +                               anx7688_in: endpoint {
> +                                       remote-endpoint = <&hdmi_out_anx>;
> +                               };
> +                       };
> +
> +                       port@1 { /* output */
> +                               reg = <1>;
> +
> +                               anx7688_out: endpoint {
> +                                       remote-endpoint = <&hdmi_connector_in>;
> +                               };
> +                       };
> +               };
> +       };
> +

-- 
Regards,

Laurent Pinchart
