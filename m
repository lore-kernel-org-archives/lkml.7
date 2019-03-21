Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5EFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3F621916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPRncQ4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCUVGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:06:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40656 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfCUVGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:06:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so5025680pgo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lnzpYj6op8TCB01LWvrXmRdNLxgYCejYaQZdphrOr8c=;
        b=IPRncQ4Xfkimy2cWKXIvw4HI9F9r2KvYluiKMgjSqwatlmxcOBK5IybpEdgTS8jLTL
         9tLcY7Pt5dSVM/o5AE1zpYGQ58HG0TenG783vqzd2xgamV5m8cyqniPwsUtSsOZU3i+F
         DfOOnwBnrscDerx9L1cIAc1yrw0AArE+uGeV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lnzpYj6op8TCB01LWvrXmRdNLxgYCejYaQZdphrOr8c=;
        b=J5vVv4BNmnYFGtJL8ge5d2X58vT7pfDG3Gt/xjezdgfBYZleAFlv7YTWVf5aBMbRdF
         TreJaFLiwh6mdFXaZZf3Ee9XsAFhOnh54JQBvNsLJ8BxsvzT4MeVngI6DuRtPLY4L7px
         RKCAweqUR5n6AsfMj3+TmRRvEbxfyNMdW0ByRqMJnDQb++p3A2Qn4lW0uEQS4Efrzcq4
         wGKwLJ2ZPncvV0xJ6E5ifE4lO9Tx4gfE8lLHWoq7Hc9JBlXGntYsQDQWYMPDEY7AuHXA
         naixacNRoNZf3ODlpyiUpBa0+F4PISakag9BLh5PvFXslcG1IDHhBkZqoeMmme+TYRoF
         v/3g==
X-Gm-Message-State: APjAAAXfo0AB9KC5Jp3mx20I2iN3ro+oYt9tbWbDk1AiCnE4vNPms9PK
        94MvdKj4vbOFC4vhZEsv19XMXgoSFCg=
X-Google-Smtp-Source: APXvYqxOePi3xxITHxn/SJ9Gn3pETkM0dLRmpRtejX+4QaDWIjSkLQ8HbOWyQ5Afl+z1UX+gBLQb3w==
X-Received: by 2002:a63:cf11:: with SMTP id j17mr4569161pgg.252.1553202374639;
        Thu, 21 Mar 2019 14:06:14 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s184sm7971089pfb.1.2019.03.21.14.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 14:06:13 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:06:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] ARM: dts: rockchip: Fix gic/efuse sort ordering for
 rk3288
Message-ID: <20190321210613.GQ112750@google.com>
References: <20190320201402.114309-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320201402.114309-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:13:59PM -0700, Douglas Anderson wrote:
> It can be seen that 0xffb40000 < 0xffc01000, thus efuse comes first.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/boot/dts/rk3288.dtsi | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 09868dcee34b..e9f454248398 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1378,19 +1378,6 @@
>  		reg = <0x0 0xffaf0080 0x0 0x20>;
>  	};
>  
> -	gic: interrupt-controller@ffc01000 {
> -		compatible = "arm,gic-400";
> -		interrupt-controller;
> -		#interrupt-cells = <3>;
> -		#address-cells = <0>;
> -
> -		reg = <0x0 0xffc01000 0x0 0x1000>,
> -		      <0x0 0xffc02000 0x0 0x2000>,
> -		      <0x0 0xffc04000 0x0 0x2000>,
> -		      <0x0 0xffc06000 0x0 0x2000>;
> -		interrupts = <GIC_PPI 9 0xf04>;
> -	};
> -
>  	efuse: efuse@ffb40000 {
>  		compatible = "rockchip,rk3288-efuse";
>  		reg = <0x0 0xffb40000 0x0 0x20>;
> @@ -1404,6 +1391,19 @@
>  		};
>  	};
>  
> +	gic: interrupt-controller@ffc01000 {
> +		compatible = "arm,gic-400";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +
> +		reg = <0x0 0xffc01000 0x0 0x1000>,
> +		      <0x0 0xffc02000 0x0 0x2000>,
> +		      <0x0 0xffc04000 0x0 0x2000>,
> +		      <0x0 0xffc06000 0x0 0x2000>;
> +		interrupts = <GIC_PPI 9 0xf04>;
> +	};
> +
>  	pinctrl: pinctrl {
>  		compatible = "rockchip,rk3288-pinctrl";
>  		rockchip,grf = <&grf>;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
