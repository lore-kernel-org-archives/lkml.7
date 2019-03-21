Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA79C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B04D21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KxGr1hoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCUVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:14:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35199 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfCUVO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:14:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so4362659pfe.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JHaZSzBG+K+5icNtlx+uJjLDPuwvOKd7SsMj3Ny9WSU=;
        b=KxGr1hoOzPXwyS3bHprjr4+lQTVW/U13zB4XwjjBzy/9QUSTBXEP2XmKySuaKP0C2Q
         B35XeTHSK/BNpoli3+lCqecPOReuuzauLug/UItMXlWe90iaTV3JlV0vK9CTLiQSZjdq
         Bgqe5tJO4ZdhTLd4NqAvUqqBh5ogcOb2qD6+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JHaZSzBG+K+5icNtlx+uJjLDPuwvOKd7SsMj3Ny9WSU=;
        b=Edrf8qGXkJLhkD+2069u7kspGk3bomSPVzUuxJlPQ0tGLEi26G5hY58G7rDtVV3mF5
         0UpmahCoANvNKp7oP5hnkBHqNIqz1IlqVp/zTthprMo/JO4JwDFOvNFbTbrKt7+W/VxQ
         SkJvJlOHZs61sIlVs124Ah/eukMBYINKNSNVwUMEKk/GsCOnM+by+A7CDD6aNXJm3ZTn
         YjHX5xXgbXeH0guxIEfavIbnF0mxieVpCVJDaCulPMbyV2MGYQ9Wdqj83CUW8EfBykIw
         EGHheJ57TbCWPRmx9mLJJuksyGzeoCmGysWbxMyfxu3kRxxW6eZzzx4fFlQZJPopGVHT
         Tabg==
X-Gm-Message-State: APjAAAVpl/7QuVTzCVeWPTVuoZE1TaS7UnvzyHJW9chfQ+TBd0Wdn5DO
        lgEgCL+8ARWDOOkEMYVzZfubHQ==
X-Google-Smtp-Source: APXvYqxwmQmNpNyqvh11DspxIWHGtMyQJXafR4PBGig9+ThxdbtHD4Ikky74kKihOaU/CjssEP9pTg==
X-Received: by 2002:a17:902:1121:: with SMTP id d30mr5810986pla.104.1553202866973;
        Thu, 21 Mar 2019 14:14:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id x23sm6575926pgf.10.2019.03.21.14.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 14:14:26 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:14:26 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] ARM: dts: rockchip: Remove #address/#size-cells from
 rk3288-veyron gpio-keys
Message-ID: <20190321211426.GT112750@google.com>
References: <20190320201402.114309-1-dianders@chromium.org>
 <20190320201402.114309-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320201402.114309-4-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:14:02PM -0700, Douglas Anderson wrote:
> They are pointless.  As dtc points out:
>   Warning (avoid_unnecessary_addr_size):
>   /gpio-keys:
>   unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Let's remove them.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 0bc2409f6903..192dbc089ade 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
> @@ -25,8 +25,6 @@
>  
>  	gpio_keys: gpio-keys {
>  		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pwr_key_l>;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
