Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C19EC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6FE20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="p4lYenqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbfDILgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:36:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43974 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDILgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:36:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id k17so20411970wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 04:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=J2G8itL6On7XrTj4IGeUKtu8uuc7mhO20zhj78qvweE=;
        b=p4lYenqK99tT+pYGYZhJ48Jb6j33SCV5epzBTrTaL92xw/td44gqLpZWDn3bXbNLxE
         6ACZfZLFKbgBS5kFzhMh2QXD1AQTB2rtmKUA2ssvRtCi1B8mbG9ynGJlnevKOTLJrjLn
         0bkoT5/KQaw8FyPtE6ggqd16+dgP00nFw3u2mehvdRzIlrhRNg49PsDNZqOTuhtSt4ww
         dP13KdATPJjncf1amoVEfq0ZEbHE7z9xBSiOKRcKQb2L/3tfJVLH8De6la7K7tAu/d6W
         Am/zWf3x1oZntTTzgRHocNwAuMFMkwyUiGFWn7mgsPs+as0Oct0m7rdhRYnEJLI/kSEO
         Gwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=J2G8itL6On7XrTj4IGeUKtu8uuc7mhO20zhj78qvweE=;
        b=jGeOXC84LMS0nCSAY9v/swro8f8x23oomZ1z4TdSoXCiblA9U+kDC/mh/SDEL5JNt0
         YTsfX9V0ggrgtboNBFMtkcIwpmbRzp6Jq1hk3eaVak0hL8cjgyHS3dB8ZTNSCouoZEVN
         4YzAeGFjrF/EaUpZ4hYss3otnpOEkcH1hhDQ0zmX93JWwx4z+vP/iY5QAge46zA4CK39
         TPEtvL7HWQZYX3vl9rU6wsnPs1E9wRZkLHW7yDAwb1OIYgATj0ilUvpVZuU16vd0NMMw
         eYjlxIm2U5mumPPu38s+6VUxVb/kP8g4lnHhRP6EzwHR9IuHKuPvFtCtWzbbuDJRu9Ba
         SARA==
X-Gm-Message-State: APjAAAWM97FFpHGjAClAc88NRE/6FBQCFIiDxnSQij6kV/20TfFy3y87
        MK31WcaJ2vvFT3JbVZomrCmNsg==
X-Google-Smtp-Source: APXvYqyOav8eVbZIzeuuDcu8S0m5tQQjnYPEId2xZ7DfLy40syxbR1wafBmcXOSR096S1UU2+tghZw==
X-Received: by 2002:a5d:6b02:: with SMTP id v2mr12450408wrw.84.1554809776032;
        Tue, 09 Apr 2019 04:36:16 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id w11sm96427814wre.15.2019.04.09.04.36.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 04:36:15 -0700 (PDT)
Message-ID: <c79c89b5a0cb1b132543aea70ff1c16872b6f6e7.camel@baylibre.com>
Subject: Re: stable/linux-5.0.y boot bisection: v5.0.7 on
 meson-gxl-s805x-p241
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        Sasha Levin <sashal@kernel.org>,
        guillaume.tucker@collabora.com, mgalka@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org,
        matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 09 Apr 2019 13:36:12 +0200
In-Reply-To: <5ca84614.1c69fb81.e2ab3.2e61@mx.google.com>
References: <5ca84614.1c69fb81.e2ab3.2e61@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-05 at 23:24 -0700, kernelci.org bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> stable/linux-5.0.y boot bisection: v5.0.7 on meson-gxl-s805x-p241
> 
> Summary:
>   Start:      8b298d3a0bd5 Linux 5.0.7
>   Details:    https://kernelci.org/boot/id/5ca7df3959b5141abafe6036
>   Plain log:  https://storage.kernelci.org//stable/linux-5.0.y/v5.0.7/arm64/defconfig/gcc-7/lab-baylibre/boot-meson-gxl-s805x-p241.txt
>   HTML log:   https://storage.kernelci.org//stable/linux-5.0.y/v5.0.7/arm64/defconfig/gcc-7/lab-baylibre/boot-meson-gxl-s805x-p241.html
>   Result:     9b0f430450cf clk: meson: clean-up clock registration
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       stable
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>   Branch:     linux-5.0.y
>   Target:     meson-gxl-s805x-p241
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Compiler:   gcc-7
>   Config:     defconfig
>   Test suite: boot
> 
> Breaking commit found:

The problem is that one of the clock (the cec clock) is registered twice.

> gxbb-aoclkc c8100000.sys-ctrl:clock-controller: Clock registration failed
> gxbb-aoclkc: probe of c8100000.sys-ctrl:clock-controller failed with error
-17

It is not a problem on mainline because there has been some rework on AO clock
controller before this particular patch.

It is safe to drop this patch from the stable branch, it does fix anything. It
is a clean up.

If you prefer, I can try to submit a fixup to keep the patch in stable.

Status is the same for the stable/linux-4.19.y.

> 
> -------------------------------------------------------------------------------
> commit 9b0f430450cf230e736bc40f95bf34fbdb99cead
> Author: Jerome Brunet <jbrunet@baylibre.com>
> Date:   Fri Dec 21 17:02:36 2018 +0100
> 
>     clk: meson: clean-up clock registration
>     
>     [ Upstream commit 8d9981efbcab066d17af4d3c85c169200f6f78df ]
>     
>     Order, ids and size  between the table of regmap clocks and the onecell
>     data table could be different.
>     
>     Set regmap pointer in all the regmap clocks before starting the
>     registration using the onecell data, to make sure we don't
>     get into an incoherent situation.
>     
>     Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>     Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>     Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>     Link: https://lkml.kernel.org/r/20181221160239.26265-3-jbrunet@baylibre.com
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/clk/meson/meson-aoclk.c b/drivers/clk/meson/meson-aoclk.c
> index f965845917e3..258c8d259ea1 100644
> --- a/drivers/clk/meson/meson-aoclk.c
> +++ b/drivers/clk/meson/meson-aoclk.c
> @@ -65,15 +65,20 @@ int meson_aoclkc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/*
> -	 * Populate regmap and register all clks
> -	 */
> -	for (clkid = 0; clkid < data->num_clks; clkid++) {
> +	/* Populate regmap */
> +	for (clkid = 0; clkid < data->num_clks; clkid++)
>  		data->clks[clkid]->map = regmap;
>  
> +	/* Register all clks */
> +	for (clkid = 0; clkid < data->hw_data->num; clkid++) {
> +		if (!data->hw_data->hws[clkid])
> +			continue;
> +
>  		ret = devm_clk_hw_register(dev, data->hw_data->hws[clkid]);
> -		if (ret)
> +		if (ret) {
> +			dev_err(dev, "Clock registration failed\n");
>  			return ret;
> +		}
>  	}
>  
>  	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [820c1fa515010d280551075da59fc2668ba8b3ae] Linux 5.0.6
> git bisect good 820c1fa515010d280551075da59fc2668ba8b3ae
> # bad: [8b298d3a0bd5feeb47129c4889356b38b78ab231] Linux 5.0.7
> git bisect bad 8b298d3a0bd5feeb47129c4889356b38b78ab231
> # good: [55d7152d37dccfa9add45df82fd45c373e032f46] cgroup, rstat: Don't flush subtree root unless necessary
> git bisect good 55d7152d37dccfa9add45df82fd45c373e032f46
> # good: [8b3b22aa7c558e713a179710a6f1e2fdbef44b20] block, bfq: fix queue removal from weights tree
> git bisect good 8b3b22aa7c558e713a179710a6f1e2fdbef44b20
> # good: [ebd0f3066c35bd27d3a4b224135e638eeaf70b8d] netfilter: physdev: relax br_netfilter dependency
> git bisect good ebd0f3066c35bd27d3a4b224135e638eeaf70b8d
> # bad: [9b0f430450cf230e736bc40f95bf34fbdb99cead] clk: meson: clean-up clock registration
> git bisect bad 9b0f430450cf230e736bc40f95bf34fbdb99cead
> # good: [bfb59eabe2c940c6869f128200f2047d46215845] drm: Auto-set allow_fb_modifiers when given modifiers at plane init
> git bisect good bfb59eabe2c940c6869f128200f2047d46215845
> # good: [ab79dc3ef0244c9b3d712d0cef17b74c363d6069] brcmfmac: Use firmware_request_nowarn for the clm_blob
> git bisect good ab79dc3ef0244c9b3d712d0cef17b74c363d6069
> # good: [c8a8dd1d85ca715ec65169feac54a7a06b8d2a29] x86/build: Mark per-CPU symbols as absolute explicitly for LLD
> git bisect good c8a8dd1d85ca715ec65169feac54a7a06b8d2a29
> # good: [a644d2d28baf8472368903b28823cf85c9a13a1d] drm/fb-helper: fix leaks in error path of drm_fb_helper_fbdev_setup
> git bisect good a644d2d28baf8472368903b28823cf85c9a13a1d
> # first bad commit: [9b0f430450cf230e736bc40f95bf34fbdb99cead] clk: meson: clean-up clock registration
> -------------------------------------------------------------------------------


