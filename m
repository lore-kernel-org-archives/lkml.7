Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243E6C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3DB2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="gDJ/pCAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEUVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:21:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35310 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfFEUVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:21:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id l128so75393qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Oow9DtVx6/e9vc91OkJJ9FrpnBvTPD2Rx2lgdcaFGT8=;
        b=gDJ/pCAVI21mCAOhscYUVpPPbSPZSdohQtVojLJOqXj6LyfNoLVKYA1EdTQBHcRnNV
         gY8GucJcSp74i+ayJHV+sn7wRmTb2V83nd3VxGipHMTNW5oGUZNerkQIOIo6H8ogVrcT
         MtKKHW8Iw1EWQc8olTokbrcD2OIpPNzoaMesSPt8hl1X0nF1osj2k2b2xX5mP2j7GYr8
         9RRw1U5V9bgLGTzeAmVAp6hIoNUhmQdKU4/BWYTtRym5973/zBT314jApMpyX9ipKAxO
         GtfUkDH9BW4veDlaFvbLLIjqemkU+31viOumlbu/QlmXG1RMgP5DQ5JARBVybS9Hzg1E
         AHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Oow9DtVx6/e9vc91OkJJ9FrpnBvTPD2Rx2lgdcaFGT8=;
        b=TVo1vD3syfdUxuWsGcj3hPWLa8b5q5swEGo3YeoU4dCDb626pX2LODIaivfFoMnhRj
         X7/iVVxjWw8vjfDZAcoLpujT+cBweiVuN0xFZMTykpYSS9iYByRM6e9eb6X4PgU2mqrv
         63/42I3USHefxIcGfWfu3CqflH0Ey029EviHzhCyN6xQN89sBFLxkm8VQm29wss9ZHQ6
         HnLZerLK/Dk5qk9TRUBSvNjPyUX5XEKKPKMkNMbYaby2CqlPyTSPJ2xlEZ1JGgpaq9zN
         s5Xf+8Z9gAs402vEtUyfIwesvhlc6+zpQBKTBeirKdccquKZyMVXVuOCzVNSKzRFANqt
         kz2g==
X-Gm-Message-State: APjAAAWZ+7KdHDbQymsvICag0bIDOqsumoWUKZHhuz0/RN3SZjHvsvsX
        AFEvT334/RPvU35vPQ77fh5wrw==
X-Google-Smtp-Source: APXvYqzshz94DAwlN0c6S4f2hde5nvkY5P0IaQSC3xGDSITmSC2T+3xaW8ArBq7rZ6TYEskvjiotBg==
X-Received: by 2002:a37:f50f:: with SMTP id l15mr16279331qkk.343.1559766063140;
        Wed, 05 Jun 2019 13:21:03 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id d5sm9881582qtj.3.2019.06.05.13.21.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 13:21:02 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:21:01 -0400
From:   Sean Paul <sean@poorly.run>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/5] dt-bindings: drm/bridge/synopsys: dw-hdmi: Add
 "unwedge" for ddc bus
Message-ID: <20190605202101.GG17077@art_vandelay>
References: <20190502225336.206885-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502225336.206885-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:53:32PM -0700, Douglas Anderson wrote:
> In certain situations it was seen that we could wedge up the DDC bus
> on the HDMI adapter on rk3288.  The only way to unwedge was to mux one
> of the pins over to GPIO output-driven-low temporarily and then
> quickly mux back.  Full details can be found in the patch
> ("drm/bridge/synopsys: dw-hdmi: Add "unwedge" for ddc bus").
> 
> Since unwedge requires remuxing the pins, we first need to add to the
> bindings so that we can specify what state the pins should be in for
> unwedging.

Pushed to drm-misc-next along with patch 2. I'll let Heiko land the dts patches.

Thanks!

Sean

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../bindings/display/rockchip/dw_hdmi-rockchip.txt         | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> index 39143424a474..8346bac81f1c 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> +++ b/Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
> @@ -38,6 +38,13 @@ Optional properties
>  - phys: from general PHY binding: the phandle for the PHY device.
>  - phy-names: Should be "hdmi" if phys references an external phy.
>  
> +Optional pinctrl entry:
> +- If you have both a "unwedge" and "default" pinctrl entry, dw_hdmi
> +  will switch to the unwedge pinctrl state for 10ms if it ever gets an
> +  i2c timeout.  It's intended that this unwedge pinctrl entry will
> +  cause the SDA line to be driven low to work around a hardware
> +  errata.
> +
>  Example:
>  
>  hdmi: hdmi@ff980000 {
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
