Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFAAC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE772084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="TqUjzDnC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfEOSZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:25:46 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44981 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfEOSZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:25:46 -0400
Received: by mail-qt1-f195.google.com with SMTP id f24so785754qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uevvlYfgOpXcBdOPgi1PLyx6eXxlSuyhw6lRRCuesfo=;
        b=TqUjzDnCZmv6DWpuf0cnlhe53qd6a/4tumMZ0fZw9U0qgMuucJ5FWPcQ5yJxnopnKT
         geiPTrEINDWv1Mg13o5dluWxczAZ0EqqzbBXIm7bdy7586rxyBgwBz+B86+nBt9p1Rac
         wzURb9WAoKStN4ih/1eDy3TDPBr4lJp5mnGxzs491XF91MShcz1ODdMXi/viD0CJUTH0
         bLLBPYk/lr/wwmP6ubJmA6AoFVkQi6fxI3T9MYR4kt8ZTPR8gyLAzInU8OJUtyssAsVZ
         jDU21ExK/qtRKXpFZxpNsvRowe+xQeZgmWY8sN9sYBYUfvoTWwX2n7mqIGQxnDgr6FTK
         DmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uevvlYfgOpXcBdOPgi1PLyx6eXxlSuyhw6lRRCuesfo=;
        b=tBUayqK8mRxDevtka4a2KTu6XnIgEehxLZxGUu4wpvJp1mnmwHVfER85Ife/qTSSrp
         Dk+mVibCZre0/MlXpwyeGr6cF/8sd61r9GISKy/qKGw10pU2OVI6yFu9aQGY2qgtJmKz
         CF0w1o6ARwYDS5qeQXuTg3dunWota2YFvvwRcHN8GIOzUvLtyg7P78NYCxYq6qEqOkBD
         MwJkxyS/IpUWl64LvtWJRtDclEx+WxP4d1xZLPKgoErl+yCw2IoEbooos8e9KKL1ql9J
         ir32hR+Ho8JOaRbzhvNfV1wnKIfTI8S13Lx/kjyyGIXr/k6nT5Dbl+eNj5PgP9bSn3fT
         9cOQ==
X-Gm-Message-State: APjAAAXQNLhXvL/W06MlnqIDYIXLXAn7fytbiRzNdLfDiZfpP0cgTpIY
        EZ3zaqDOLGkpWsH5SMfNudTWzw==
X-Google-Smtp-Source: APXvYqyjVVjWkzvrQizl0QTykiPZBiDOEfoq0Ogb2zru/TMF45dYDtbCR70ikjwUT1A+sxFVf0ucJw==
X-Received: by 2002:ac8:4a84:: with SMTP id l4mr37683309qtq.374.1557944745132;
        Wed, 15 May 2019 11:25:45 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id n2sm1272422qkk.43.2019.05.15.11.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:25:44 -0700 (PDT)
Date:   Wed, 15 May 2019 14:25:44 -0400
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
Subject: Re: [PATCH 3/5] ARM: dts: rockchip: Switch to builtin HDMI DDC bus
 on rk3288-veyron
Message-ID: <20190515182544.GW17077@art_vandelay>
References: <20190502225336.206885-1-dianders@chromium.org>
 <20190502225336.206885-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502225336.206885-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:53:34PM -0700, Douglas Anderson wrote:
> Downstream Chrome OS kernels use the builtin DDC bus from dw_hdmi on
> veyron.  This is the only way to get them to negotiate HDCP.
> 
> Although HDCP isn't currently all supported upstream, it still seems
> like it makes sense to use dw_hdmi's builtin I2C.  Maybe eventually we
> can get HDCP negotiation working.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 1252522392c7..e1bee663d2c5 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -163,7 +163,8 @@
>  };
>  
>  &hdmi {
> -	ddc-i2c-bus = <&i2c5>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&hdmi_ddc>;
>  	status = "okay";
>  };
>  
> @@ -334,14 +335,6 @@
>  	i2c-scl-rising-time-ns = <300>;		/* 225ns measured */
>  };
>  
> -&i2c5 {
> -	status = "okay";
> -
> -	clock-frequency = <100000>;
> -	i2c-scl-falling-time-ns = <300>;
> -	i2c-scl-rising-time-ns = <1000>;
> -};
> -
>  &io_domains {
>  	status = "okay";
>  
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
