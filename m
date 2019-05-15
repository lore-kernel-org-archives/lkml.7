Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22932084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="EjKmmzK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfEOSZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:25:55 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34023 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfEOSZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:25:55 -0400
Received: by mail-qk1-f195.google.com with SMTP id j20so637278qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ze14/ZyXsEJTAjqaTo2lTRx3s0ItRZ2g8TsWrPqezoA=;
        b=EjKmmzK4gaGig9/kRlPUp7k1dxcQOfTfpH60q/LrsE/SgieDpD1q0gvpNH6TQ4tFjk
         1kkS929EIWvcDVI/Iw2ykhlxaxBqrx+s4/GGEcQPd6Pya0uZy2IWKniwpSiCizKSh/fg
         DDIA6lUED4xtnPQ+hRekTJ9bcuKmvx2fk1G14CEkPfkHD7NUN1iuolK8YmibOenB3JUS
         KR+DDqXevo4MqhdGQEA1/W3oG/449EBa36KxghqJ46EwDP7jT0znVN/+ULNUP0E6dGQe
         sRTgAwnXUmFRig1ct0llZ8ztKQC6ZDzpk4DGUt49WVfGNEPdwD+c9RPfVFMatHflLcp1
         py/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ze14/ZyXsEJTAjqaTo2lTRx3s0ItRZ2g8TsWrPqezoA=;
        b=nmBLcJq8elDn+k1OGup0A6TeR6HfIk77DjZxwYb5aT6zgfAQvYGTlet2BRBCeEGnrd
         IvWoMYVqOX4KVq3e2JboFrQwFUZXNTnNdVl8oLy/WPREx4AwJMqaQGV4UOZPJWnAwOAt
         Xp/4zS3kWNgNs2ga4fysVfjMTQ+Sz0m8Lv+in6uuXGcvRFnXZqhNuWhzzzznal8Qylmd
         n8ovk360yuV+8IbE20+NY3dHniryE1KznJOhZTiGVUABI3fponzBMME6VlZq9Fnw+JRH
         KrIvxYOdNwL0LEQxisjNt1z9s2VjwHSQdlakLTRQZmU5wQgUE8tgNW5bMUoSaUZPkOfB
         gpCg==
X-Gm-Message-State: APjAAAV50FPbHDBQlzE4bctF936K8Q3xVasLjBlCD/Ce86rZIfj+umat
        dc7ypil8wPRfbRlyZhXJ8AHFhQ==
X-Google-Smtp-Source: APXvYqzE4tU3wB1W/soxDI0IVT0K319tP4nNUGqGgn0iQCnc2JttjgI+YgxYaWAdWbpys/mgpEEGHA==
X-Received: by 2002:ae9:f218:: with SMTP id m24mr25687228qkg.261.1557944754518;
        Wed, 15 May 2019 11:25:54 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id n19sm1253535qkg.58.2019.05.15.11.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:25:54 -0700 (PDT)
Date:   Wed, 15 May 2019 14:25:53 -0400
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] ARM: dts: rockchip: Add unwedge pinctrl entries for
 dw_hdmi on rk3288
Message-ID: <20190515182553.GX17077@art_vandelay>
References: <20190502225336.206885-1-dianders@chromium.org>
 <20190502225336.206885-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502225336.206885-4-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:53:35PM -0700, Douglas Anderson wrote:
> This adds the "unwedge" pinctrl entries introduced by a recent dw_hdmi
> change that can unwedge the dw_hdmi i2c bus in some cases.  It's
> expected that any boards using this would add:
> 
>   pinctrl-names = "default", "unwedge";
>   pinctrl-0 = <&hdmi_ddc>;
>   pinctrl-1 = <&hdmi_ddc_unwedge>;
> 
> Note that this isn't added by default because some boards may choose
> to mux i2c5 for their DDC bus (if that is more tested for them).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
>  arch/arm/boot/dts/rk3288.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 74c9517c4f92..eebc04fa1e4d 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1545,6 +1545,15 @@
>  				rockchip,pins = <7 RK_PC3 2 &pcfg_pull_none>,
>  						<7 RK_PC4 2 &pcfg_pull_none>;
>  			};
> +
> +			hdmi_ddc_unwedge: hdmi-ddc-unwedge {
> +				rockchip,pins = <7 RK_PC3 RK_FUNC_GPIO &pcfg_output_low>,
> +						<7 RK_PC4 2 &pcfg_pull_none>;
> +			};
> +		};
> +
> +		pcfg_output_low: pcfg-output-low {
> +			output-low;
>  		};
>  
>  		pcfg_pull_up: pcfg-pull-up {
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
