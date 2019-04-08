Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F938C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038E920870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDHISk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:18:40 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50539 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfDHISj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:18:39 -0400
X-Originating-IP: 90.88.30.125
Received: from aptenodytes (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 623CC6000C;
        Mon,  8 Apr 2019 08:18:35 +0000 (UTC)
Message-ID: <82e793b898657d65cda55c98b9ffcec475193b5b.camel@bootlin.com>
Subject: Re: [PATCH] media: cedrus: Fix initialization order
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>, maxime.ripard@bootlin.com
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Date:   Mon, 08 Apr 2019 10:18:34 +0200
In-Reply-To: <20190407184728.16620-1-jernej.skrabec@siol.net>
References: <20190407184728.16620-1-jernej.skrabec@siol.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dimanche 07 avril 2019 à 20:47 +0200, Jernej Skrabec a écrit :
> Currently, MEDIA_IOC_G_TOPOLOGY ioctl on cedrus fails due to incorrect
> initialization order. Fix that by moving video_register_device() before
> v4l2_m2m_register_media_controller() and while at it, fix error path.
> 
> Reported-by: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks for the fix, good catch!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 24 ++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index b98add3cdedd..d0429c0e6b6b 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -300,7 +300,7 @@ static int cedrus_probe(struct platform_device *pdev)
>  			 "Failed to initialize V4L2 M2M device\n");
>  		ret = PTR_ERR(dev->m2m_dev);
>  
> -		goto err_video;
> +		goto err_v4l2;
>  	}
>  
>  	dev->mdev.dev = &pdev->dev;
> @@ -310,23 +310,23 @@ static int cedrus_probe(struct platform_device *pdev)
>  	dev->mdev.ops = &cedrus_m2m_media_ops;
>  	dev->v4l2_dev.mdev = &dev->mdev;
>  
> -	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
> -						 MEDIA_ENT_F_PROC_VIDEO_DECODER);
> -	if (ret) {
> -		v4l2_err(&dev->v4l2_dev,
> -			 "Failed to initialize V4L2 M2M media controller\n");
> -		goto err_m2m;
> -	}
> -
>  	ret = video_register_device(vfd, VFL_TYPE_GRABBER, 0);
>  	if (ret) {
>  		v4l2_err(&dev->v4l2_dev, "Failed to register video device\n");
> -		goto err_v4l2;
> +		goto err_m2m;
>  	}
>  
>  	v4l2_info(&dev->v4l2_dev,
>  		  "Device registered as /dev/video%d\n", vfd->num);
>  
> +	ret = v4l2_m2m_register_media_controller(dev->m2m_dev, vfd,
> +						 MEDIA_ENT_F_PROC_VIDEO_DECODER);
> +	if (ret) {
> +		v4l2_err(&dev->v4l2_dev,
> +			 "Failed to initialize V4L2 M2M media controller\n");
> +		goto err_video;
> +	}
> +
>  	ret = media_device_register(&dev->mdev);
>  	if (ret) {
>  		v4l2_err(&dev->v4l2_dev, "Failed to register media device\n");
> @@ -339,10 +339,10 @@ static int cedrus_probe(struct platform_device *pdev)
>  
>  err_m2m_mc:
>  	v4l2_m2m_unregister_media_controller(dev->m2m_dev);
> -err_m2m:
> -	v4l2_m2m_release(dev->m2m_dev);
>  err_video:
>  	video_unregister_device(&dev->vfd);
> +err_m2m:
> +	v4l2_m2m_release(dev->m2m_dev);
>  err_v4l2:
>  	v4l2_device_unregister(&dev->v4l2_dev);
>  
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

