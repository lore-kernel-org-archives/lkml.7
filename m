Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF672183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efS0otfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCUVMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:12:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34039 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCUVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:12:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so5063188pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JaSfjeC+lkY5s4/k3RvSz0OALUNMfJX+t20AO+2lQPE=;
        b=efS0otfCxclI4QRPdbkYmbaBtwrZdLNfkgCIQ3Jj6R3fwmDXOSE5BqkCmL6UhTafHo
         2FSq24nOZaVrLNrP3Vl7yRG13mXKEFUTpc3HogDQs4awvJSej/l8YdrwrBgsrbQCFPmk
         mcADO7vTSt6+fBmjSnF3QRjmN9tDbnGjW4pxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JaSfjeC+lkY5s4/k3RvSz0OALUNMfJX+t20AO+2lQPE=;
        b=FFXXbKNv1hA8jaDa8fgmhJMOLVXk8MXW9ti+tf2r9x6tkHLgFTTOk2fQofC3RPi3Q7
         Jb5CSW0YM6KwYdtC/pn2k89ciisHPddOcEk8gl3VDZHKHdZ0W6RlyJQzvma98NX0giJl
         ZYWwcvuVXKuQoCfkjW2IQnUU8AQILG/izF3POT/0R8bUhaT6WeHhBoCUpbvtROojtE7Z
         Y3rD1BPgCFoYDqS6L8WpZwk0uCT5vimSo5GuYz16am3R9H71SNLLN/TNzrxWN74/YM1I
         +LHxWaPp7eWyHlPwUg3UOwZTpUu8kUrDqaD5PVt1voVzY04CATs/w5U1eyDO1JCKNReE
         Igog==
X-Gm-Message-State: APjAAAVxWsC2zoEi8ksYuZTAZOYmEYSgT40RlaiJGq1YuYF0Umc189dH
        oeacQaXS9jLfZzC+tIaTrD+M3A==
X-Google-Smtp-Source: APXvYqx+13ROSLXMWtN/hHKRUAsj2ISQcZnb+XXGKGo7n9ky+rZetVgpQpJH3KD+e5xSot1OCmewOg==
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr5753107plb.155.1553202754563;
        Thu, 21 Mar 2019 14:12:34 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h126sm12785232pfc.135.2019.03.21.14.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 14:12:34 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:12:33 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] ARM: dts: rockchip: Remove #address/#size-cells from
 rk3288 mipi_dsi
Message-ID: <20190321211233.GS112750@google.com>
References: <20190320201402.114309-1-dianders@chromium.org>
 <20190320201402.114309-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320201402.114309-3-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:14:01PM -0700, Douglas Anderson wrote:
> They are pointless.  As dtc points out:
>   Warning (avoid_unnecessary_addr_size):
>   /mipi@ff960000:
>   unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
> 
> Let's remove them.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/boot/dts/rk3288.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 79cd3c53e737..99a7620bddac 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1119,8 +1119,6 @@
>  		clock-names = "ref", "pclk";
>  		power-domains = <&power RK3288_PD_VIO>;
>  		rockchip,grf = <&grf>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		status = "disabled";
>  
>  		ports {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
