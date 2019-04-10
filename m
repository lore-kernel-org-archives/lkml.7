Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DE6C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6984720850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 14:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbfDJOTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:19:11 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:53674 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728160AbfDJOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 10:19:10 -0400
Received: from [IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f] ([IPv6:2001:983:e9a7:1:5c18:3544:e4bb:f52f])
        by smtp-cloud7.xs4all.net with ESMTPA
        id EE4AhlMYwNG8zEE4Bh1WYS; Wed, 10 Apr 2019 16:19:08 +0200
Subject: Re: [PATCH 1/7] media: atmel: atmel-isc: add safe checks and fixed
 wrong ISC state in error case
To:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        Nicolas.Ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
Cc:     ksloat@aampglobal.com
References: <1554807715-2353-1-git-send-email-eugen.hristev@microchip.com>
 <1554807715-2353-2-git-send-email-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a7105475-a693-6cf0-8e58-909c07986375@xs4all.nl>
Date:   Wed, 10 Apr 2019 16:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554807715-2353-2-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfB+WCajus2jpgqspZjzIoAvhSO2buP9vwLyOpYoWB1rZTTkXM1jPJLjRXmx4kD0eyZE11CURsVRHWOaO/+2a09+jTSooi7B0gslPdI/9TaIkRWitXFNj
 DLM++yfUBwSg2oQWOKFkaiND0KYp44SW9Mux+dMdfdX4cydOjsWdJ6M+3Y0UJpw6GYUWC91OZX/IrtR7rRGeUmiqsBZjo4okbIicHeAfkwaghh5c+t0VUdIh
 WegXz3vu0DCVkNeW5Posaaq8dVFEDmzHFV55bfzNYukV3W5JJ1yFO8fTuHfQyERuclZIPeLGmhqpucCK++UvQIHxvnlSmSoE/H/A88+hg6f8gplK9qPzz5hy
 mpwU0ZQ6GWLHpl7wIzy9qdPuf6iJRZy2yfv9y193a2sYte7AmnrPDijEeG1hPHTqfArhTUSRvwMsACk67esARz5Yibboq2wyEcZI8GX83ohFUoYYRgO1KlxA
 7iuqd4P+QvayzeNnoWfk46RhJGnUFEAr2OSgGlxM0XayNT9AKxsioArhc5w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 1:07 PM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> This adds safety checks on some scenarios:
> - start streaming but streaming is already started

Can't happen. vb2 checks for that.

> - start streaming but no buffer in the dma queue

Can't happen since min_buffers_needed is > 0. So start_streaming will
never be called unless at least one buffer is queued.

> - spin lock is not released in error scenario
> - no frame is configured but dma is requested to start

Can this ever happen? It's set by start_streaming when you know there is
at least one buffer, so this seems overkill.

Regards,

	Hans

> - configure ISC may have been called without need, before checking if buffer is
> ok.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/media/platform/atmel/atmel-isc.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
> index a10db16..3c19761 100644
> --- a/drivers/media/platform/atmel/atmel-isc.c
> +++ b/drivers/media/platform/atmel/atmel-isc.c
> @@ -722,6 +722,11 @@ static void isc_start_dma(struct isc_device *isc)
>  	u32 dctrl_dview;
>  	dma_addr_t addr0;
>  
> +	if (!isc->cur_frm) {
> +		v4l2_err(&isc->v4l2_dev, "Video buffer not available\n");
> +		return;
> +	}
> +
>  	addr0 = vb2_dma_contig_plane_dma_addr(&isc->cur_frm->vb.vb2_buf, 0);
>  	regmap_write(regmap, ISC_DAD0, addr0);
>  
> @@ -886,6 +891,9 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	unsigned long flags;
>  	int ret;
>  
> +	if (vb2_is_streaming(&isc->vb2_vidq))
> +		return -EBUSY;
> +
>  	/* Enable stream on the sub device */
>  	ret = v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 1);
>  	if (ret && ret != -ENOIOCTLCMD) {
> @@ -896,6 +904,20 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>  
>  	pm_runtime_get_sync(isc->dev);
>  
> +	spin_lock_irqsave(&isc->dma_queue_lock, flags);
> +
> +	isc->sequence = 0;
> +	isc->stop = false;
> +	reinit_completion(&isc->comp);
> +
> +	if (list_empty(&isc->dma_queue)) {
> +		v4l2_err(&isc->v4l2_dev, "dma queue empty\n");
> +		ret = -EINVAL;
> +		goto err_configure_unlock;
> +	}
> +
> +	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
> +
>  	ret = isc_configure(isc);
>  	if (unlikely(ret))
>  		goto err_configure;
> @@ -905,10 +927,6 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>  
>  	spin_lock_irqsave(&isc->dma_queue_lock, flags);
>  
> -	isc->sequence = 0;
> -	isc->stop = false;
> -	reinit_completion(&isc->comp);
> -
>  	isc->cur_frm = list_first_entry(&isc->dma_queue,
>  					struct isc_buffer, list);
>  	list_del(&isc->cur_frm->list);
> @@ -919,8 +937,11 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>  
>  	return 0;
>  
> +err_configure_unlock:
> +	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
> +
>  err_configure:
> -	pm_runtime_put_sync(isc->dev);
> +	isc->stop = true;
>  
>  	v4l2_subdev_call(isc->current_subdev->sd, video, s_stream, 0);
>  
> @@ -931,6 +952,7 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
>  	INIT_LIST_HEAD(&isc->dma_queue);
>  	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
>  
> +	pm_runtime_put_sync(isc->dev);
>  	return ret;
>  }
>  
> 

