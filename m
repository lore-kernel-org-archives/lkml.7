Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B9CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A329B2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="QeaydcZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733227AbfJ2MTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:19:24 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:52805 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ2MTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201810; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=czvZRHgSb18GWkRiGLBe0qR2LanKlORlrSIu5TSo2LM=; b=QeaydcZ8J1y49IEo2JeOU7uLs3
        HK5zeQjFjHAPAe9UECT0lHwszfoOA+qqBKNpp5nHJblYKle+HYSJwE+4LOSJ2qDqb2irb1351oimI
        c02a7UBNfuRIaSdNKjDgTxDe4UPIJXS9b2JgeP8QYf1Cd6YWgoTQZr5W68qjrmxXrOs4jyUXBy6XU
        iwE9jQkiNmJRLQSjeSE5TIekOGxCjZMwnRUegUIjV0bcRY1Hld7711irLipee8YRgZZEADPbl0FyU
        nRrcH+zWsPZm/BBEWfw5dh+vhHIfyBC66Mb1ch57UUackMxYv+25HBWemXTWxSCWg1m52ByQzT2k5
        pYLHMRJw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:50959 helo=[192.168.10.177])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1iPQT3-0001EA-F9; Tue, 29 Oct 2019 13:19:21 +0100
Subject: Re: [PATCH] drm/tinydrm: Fix memroy leak in hx8357d_probe
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        emamd001@umn.edu, smccaman@umn.edu
References: <20191027173234.6449-1-navid.emamdoost@gmail.com>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <8c297837-9270-0282-b8e7-d931e859adec@tronnes.org>
Date:   Tue, 29 Oct 2019 13:19:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191027173234.6449-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid,

Den 27.10.2019 18.32, skrev Navid Emamdoost:
> In the implementation of hx8357d_probe() the allocated memory for dbidev
> is leaked when an error happens. Release dbidev if any of the  following
> calls fail: devm_gpiod_get(), devm_of_find_backlight(),
> mipi_dbi_spi_init(), mipi_dbi_init(), drm_dev_register().
> 
> Fixes: f300c86e33a6 ("drm: Add an hx8367d tinydrm driver.")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/tiny/hx8357d.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
> index 9af8ff84974f..da5ec944f47e 100644
> --- a/drivers/gpu/drm/tiny/hx8357d.c
> +++ b/drivers/gpu/drm/tiny/hx8357d.c
> @@ -232,44 +232,49 @@ static int hx8357d_probe(struct spi_device *spi)
>  
>  	drm = &dbidev->drm;
>  	ret = devm_drm_dev_init(dev, drm, &hx8357d_driver);

This is a device managed function that releases its resource(s) on
device:driver unbind like the other devm_ functions (it can't free
dbidev if it fails hence the kfree in the error path here).

This is the release call path:

devm_drm_dev_init_release -> drm_dev_put -> drm_dev_release ->
dev->driver->release : mipi_dbi_release.

Noralf.

> -	if (ret) {
> -		kfree(dbidev);
> -		return ret;
> -	}
> +	if (ret)
> +		goto free_dbidev;
>  
>  	drm_mode_config_init(drm);
>  
>  	dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
>  	if (IS_ERR(dc)) {
>  		DRM_DEV_ERROR(dev, "Failed to get gpio 'dc'\n");
> -		return PTR_ERR(dc);
> +		ret = PTR_ERR(dc);
> +		goto free_dbidev;
>  	}
>  
>  	dbidev->backlight = devm_of_find_backlight(dev);
> -	if (IS_ERR(dbidev->backlight))
> -		return PTR_ERR(dbidev->backlight);
> +	if (IS_ERR(dbidev->backlight)) {
> +		ret = PTR_ERR(dbidev->backlight);
> +		goto free_dbidev;
> +	}
>  
>  	device_property_read_u32(dev, "rotation", &rotation);
>  
>  	ret = mipi_dbi_spi_init(spi, &dbidev->dbi, dc);
>  	if (ret)
> -		return ret;
> +		goto free_dbidev;
>  
>  	ret = mipi_dbi_dev_init(dbidev, &hx8357d_pipe_funcs, &yx350hv15_mode, rotation);
>  	if (ret)
> -		return ret;
> +		goto free_dbidev;
>  
>  	drm_mode_config_reset(drm);
>  
>  	ret = drm_dev_register(drm, 0);
>  	if (ret)
> -		return ret;
> +		goto free_dbidev;
>  
>  	spi_set_drvdata(spi, drm);
>  
>  	drm_fbdev_generic_setup(drm, 0);
>  
>  	return 0;
> +
> +free_dbidev:
> +	kfree(dbidev);
> +	return ret;
>  }
>  
>  static int hx8357d_remove(struct spi_device *spi)
> 
