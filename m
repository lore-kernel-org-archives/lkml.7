Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD23C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF2620873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="BmVVmLPD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfEOS0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:26:05 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41438 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfEOS0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:26:04 -0400
Received: by mail-qk1-f194.google.com with SMTP id g190so608786qkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jFj8dh23g2idvSds2JYPP7kaIEok3DfVq0OP/6qEkjo=;
        b=BmVVmLPDeF0Gh1VuUSf55t4gi1/UnkJVNXU6pn3dvbTIbUr3GxfpIKRwrHu4flb3CG
         HTKZuXRN+BVDiyYtSqmjpKwFx3Bh00cbTfGG6bOcV9qX9VXnAILuUU7Y1v/0ih30no4w
         8gkbCH9MFy4Y544krG1rk/QqQmJeKFeOLst+j5q9VQIiRN27xsFJ3otCgPv3RlMQEUIZ
         tR1VE2Wrv4wzsnARmTsh7skwOd7YDlTtR5DagCMfo4NlY4yXpzS/Dz30DtgVtj6H4Oec
         JHh86xeV6tAR1Pj/JSY/zUj4zCxOeWJdikDAe/3NxIhDClKJf0UhbFttr3IzSE4bHCBi
         kSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jFj8dh23g2idvSds2JYPP7kaIEok3DfVq0OP/6qEkjo=;
        b=MWH2q2fNdsJ9ZW/4XGyNMTuSlgNFsRrQoAYk5PhT8ohIjpKibRF98fJUBcB+19OjFo
         h+4XW/AgsPR+vf7z2t/MvYmnktBYJWkfpGinIPMCuiYfGt0TzHz1JsGQOTnlBizV+hlF
         p+cIVVe9fVzRu203J0ciVMQf22GW8i3UcrS8cXmW9nID8+e2cIgoyP9RMpKjzEKxoBeM
         2tkJV1Gmu0EZQFhrfwxZ9MmxqbzjwZ/FO4Hf3+ECXzrIV454AbEJsbQFuR5pAIFp8Hyi
         C+KX8Do+RMOoBAdCJGGV3GWTdd7Y4dIuWzaOyInR7AwCV2mYYc2rpC0v6KwV+2T7qESm
         cLVg==
X-Gm-Message-State: APjAAAXVN82c7/Yol9OFkH/UIbXn3R7WVEPFgpcPwaiYS5lLMX57uLfr
        Od9w24Sfv8QoY65okJYy3FzJZA==
X-Google-Smtp-Source: APXvYqx5lu/OaoclV0DLdEX2WJ5Nw8BWbL4Pl6MEnRYhtodr67RdCqsBRDyDKxOX/wdl9ukhI9O9Wg==
X-Received: by 2002:a05:620a:3:: with SMTP id j3mr17330454qki.95.1557944763567;
        Wed, 15 May 2019 11:26:03 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id h17sm1372773qkk.13.2019.05.15.11.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:26:03 -0700 (PDT)
Date:   Wed, 15 May 2019 14:26:02 -0400
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
Subject: Re: [PATCH 5/5] ARM: dts: rockchip: Add HDMI i2c unwedging for
 rk3288-veyron
Message-ID: <20190515182602.GY17077@art_vandelay>
References: <20190502225336.206885-1-dianders@chromium.org>
 <20190502225336.206885-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502225336.206885-5-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:53:36PM -0700, Douglas Anderson wrote:
> Veyron uses the builtin i2c controller that's part of dw-hdmi.  Hook
> up the unwedging feature.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
> 
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index e1bee663d2c5..340b276b6333 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -163,8 +163,9 @@
>  };
>  
>  &hdmi {
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "unwedge";
>  	pinctrl-0 = <&hdmi_ddc>;
> +	pinctrl-1 = <&hdmi_ddc_unwedge>;
>  	status = "okay";
>  };
>  
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
