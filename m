Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37722C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC5C2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfC2I2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:28:04 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:43742 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728972AbfC2I2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:28:04 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 9mrmhMxCzUjKf9mrqhusuX; Fri, 29 Mar 2019 09:28:02 +0100
Subject: Re: [PATCH v13 2/6] media: change au0828 to use Media Device
 Allocator API
To:     Shuah Khan <shuah@kernel.org>, mchehab@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <cover.1553814518.git.shuah@kernel.org>
 <05ec250a56d9eaa868e7c8cf6376d6f8e29bb102.1553814518.git.shuah@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <693a4487-b4dd-b3e0-953e-22c342708f1f@xs4all.nl>
Date:   Fri, 29 Mar 2019 09:27:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <05ec250a56d9eaa868e7c8cf6376d6f8e29bb102.1553814518.git.shuah@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBB1tcUrLvtf/Wu+y4jrUfRwWLU7hrNXm31naaf9EM7dbx+fpNO2UBKB504L0bCt8N2ALCcq5IYDg2SPT++e8d1RW18bPnQW0jaKTMGNOa+hfDDnzBfm
 z7JxyrkDB7gdMa5yzItJtJYiir8RGSKAqWBiPcIUPaC/xX+ad/OkSKxhmPXjx1ZkEaURn9l6nqa5NuotHJt66QsPPCs81t5DWZRzmVB35QF00vupR0JeHNWw
 QXEC5se1r41CzPkO3wAd9PhfCQmx2WiWhsGz8YClgIK0O8UHNKcRBusEsFEXyEL4tUfC2+/usAfsgFibs5FVZh37IF0m8w3SS940dr8tJnSAijw3HE2vKHxU
 RRjpLnCRrj3yKVrJxf0Rie67qEbnHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 1:04 AM, Shuah Khan wrote:
> Media Device Allocator API to allows multiple drivers share a media device.
> This API solves a very common use-case for media devices where one physical
> device (an USB stick) provides both audio and video. When such media device
> exposes a standard USB Audio class, a proprietary Video class, two or more
> independent drivers will share a single physical USB bridge. In such cases,
> it is necessary to coordinate access to the shared resource.
> 
> Using this API, drivers can allocate a media device with the shared struct
> device as the key. Once the media device is allocated by a driver, other
> drivers can get a reference to it. The media device is released when all
> the references are released.
> 
> Change au0828 to use Media Device Allocator API to allocate media device
> with the parent usb struct device as the key, so it can be shared with the
> snd_usb_audio driver.
> 
> Signed-off-by: Shuah Khan <shuah@kernel.org>
> ---
>  drivers/media/usb/au0828/Kconfig       |  2 ++
>  drivers/media/usb/au0828/au0828-core.c | 13 +++++--------
>  drivers/media/usb/au0828/au0828.h      |  1 +
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/usb/au0828/Kconfig b/drivers/media/usb/au0828/Kconfig
> index 65fc067eb864..98de6e24329e 100644
> --- a/drivers/media/usb/au0828/Kconfig
> +++ b/drivers/media/usb/au0828/Kconfig
> @@ -2,6 +2,8 @@
>  config VIDEO_AU0828
>  	tristate "Auvitek AU0828 support"
>  	depends on I2C && INPUT && DVB_CORE && USB && VIDEO_V4L2
> +	select MEDIA_CONTROLLER
> +	select MEDIA_CONTROLLER_DVB

Is it required to select MEDIA_CONTROLLER_DVB? Does something fail to work
if this is unset?

Regards,

	Hans

>  	select I2C_ALGOBIT
>  	select VIDEO_TVEEPROM
>  	select VIDEOBUF2_VMALLOC if VIDEO_V4L2
> diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
> index 3f8c92a70116..4f8ba6f64d3c 100644
> --- a/drivers/media/usb/au0828/au0828-core.c
> +++ b/drivers/media/usb/au0828/au0828-core.c
> @@ -155,9 +155,7 @@ static void au0828_unregister_media_device(struct au0828_dev *dev)
>  	dev->media_dev->disable_source = NULL;
>  	mutex_unlock(&mdev->graph_mutex);
>  
> -	media_device_unregister(dev->media_dev);
> -	media_device_cleanup(dev->media_dev);
> -	kfree(dev->media_dev);
> +	media_device_delete(dev->media_dev, KBUILD_MODNAME, THIS_MODULE);
>  	dev->media_dev = NULL;
>  #endif
>  }
> @@ -210,14 +208,10 @@ static int au0828_media_device_init(struct au0828_dev *dev,
>  #ifdef CONFIG_MEDIA_CONTROLLER
>  	struct media_device *mdev;
>  
> -	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
> +	mdev = media_device_usb_allocate(udev, KBUILD_MODNAME, THIS_MODULE);
>  	if (!mdev)
>  		return -ENOMEM;
>  
> -	/* check if media device is already initialized */
> -	if (!mdev->dev)
> -		media_device_usb_init(mdev, udev, udev->product);
> -
>  	dev->media_dev = mdev;
>  #endif
>  	return 0;
> @@ -480,6 +474,9 @@ static int au0828_media_device_register(struct au0828_dev *dev,
>  		/* register media device */
>  		ret = media_device_register(dev->media_dev);
>  		if (ret) {
> +			media_device_delete(dev->media_dev, KBUILD_MODNAME,
> +					    THIS_MODULE);
> +			dev->media_dev = NULL;
>  			dev_err(&udev->dev,
>  				"Media Device Register Error: %d\n", ret);
>  			return ret;
> diff --git a/drivers/media/usb/au0828/au0828.h b/drivers/media/usb/au0828/au0828.h
> index 425c35d16057..57b00de8d3f2 100644
> --- a/drivers/media/usb/au0828/au0828.h
> +++ b/drivers/media/usb/au0828/au0828.h
> @@ -31,6 +31,7 @@
>  #include <media/v4l2-ctrls.h>
>  #include <media/v4l2-fh.h>
>  #include <media/media-device.h>
> +#include <media/media-dev-allocator.h>
>  
>  /* DVB */
>  #include <media/demux.h>
> 

