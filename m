Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FD6C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00BE2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KeUBh5m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfECX6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:58:11 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44830 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfECX6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:58:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id l2so3424936plt.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v7+8a0jOi82vA98ZW8MLz4Zxp+tPvn5pEZ3hYsxU2i4=;
        b=KeUBh5m7XrqqJoGtrD6Ib6knt5i2ib8XP24NKJEJyGpAwUOaLX/x7UY2/uecLPiyDe
         9yyqjXnlM7Sdn7qZVIKCfp4lijNioihmlVmSLfE2FTzxpqPXWb817IqTmUzMWrglz7sL
         SQh/iyPbwkDdI8Zm3zUAt91zibej3pbV7DGpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v7+8a0jOi82vA98ZW8MLz4Zxp+tPvn5pEZ3hYsxU2i4=;
        b=WmG8s5kI2TB2ALbk8MwtcrflpfDbM/tUDgb3U9RhTn5WYL8F4QNc1AE0GIgBeu3cS8
         iaUEm3Cq7WEpkg9Qfxixd5FUDbOQnxFyyBK0uI4b8aQTVuom+IL50HdQ9MbRWekmZQFZ
         g6RLBrfh1HLBnUnDNqb5eCNbB3Dyz0cGc3L/9Ak9DRHraPoHzEeVvXvczq6o3z5wSd20
         ndGy6HmL9rqrkTxbzTfNQboU3NDbwqhDzWyu2I8nQEBlcXWhnvntxrFvz1lQFR9DXXcT
         pUP0hjLgywfjLMEFoHvUe/wqqRH4Zku0KnCKCotCp+RyBXY/q64+sZr/akS2VZ/m5zqb
         o0AQ==
X-Gm-Message-State: APjAAAU3tC/cryZtzr158VEbisqdPB1vM+9NoHUO3DSRNAkKgWDYOf/C
        LCE7VKumrZBgyEABF1eqRDftpWJgdAYrWA==
X-Google-Smtp-Source: APXvYqwCj3vkQhdXIGJu9EpWV0sc4q41te3mEjK0JRvTex2+xk1qSEGE3uWqGCe5EwjRzmV9owoA+A==
X-Received: by 2002:a17:902:7207:: with SMTP id ba7mr13779305plb.329.1556927890867;
        Fri, 03 May 2019 16:58:10 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id h127sm4092709pgc.31.2019.05.03.16.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 16:58:10 -0700 (PDT)
Date:   Fri, 3 May 2019 16:58:09 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, briannorris@chromium.org,
        amstan@chromium.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Remove bogus 'i2s_clk_out' from
 rk3288-veyron-mickey
Message-ID: <20190503235809.GD40515@google.com>
References: <20190503234814.230901-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190503234814.230901-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 04:48:14PM -0700, Douglas Anderson wrote:
> The rk3288-veyron-mickey device tree overrides the default "i2s" clock
> settings to add the clock for "i2s_clk_out".
> 
> That clock is only present in the bindings downstream Chrome OS 3.14
> tree.  Upstream the i2s port bindings doesn't specify that as a
> possible clock.
> 
> Let's remove it.
> 
> NOTE: for other rk3288-veyron devices this clock is consumed by
> 'maxim,max98090'.  Presumably if this clock is needed for mickey it'll
> need to be consumed by something similar.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/boot/dts/rk3288-veyron-mickey.dts | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> index e852594417b5..f9c4ece3c0d3 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
> @@ -142,8 +142,6 @@
>  
>  &i2s {
>  	status = "okay";
> -	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
> -	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_OUT>;
>  };
>  
>  &rk808 {

effectively, 'i2s_clk_out' is not use in the upstream kernel.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
