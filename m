Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DAC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB125217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfC1Or3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:47:29 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:59439 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfC1Or0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:47:26 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9WJLh74SbNG8z9WJOhpa4p; Thu, 28 Mar 2019 15:47:24 +0100
Subject: Re: [PATCH v3] media: rga: fix NULL pointer dereferences,
 use-after-free, memory leak
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jacob chen <jacob2.chen@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ff11d704-489f-836e-6c9d-1b2fb5e963b6@arm.com>
 <20190314050344.29790-1-kjlu@umn.edu>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <47c6d19c-96bd-49e1-7a3e-702fc50df670@xs4all.nl>
Date:   Thu, 28 Mar 2019 15:47:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314050344.29790-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNKB8mX0zNKOSmLuh2wPAFBgG9qwwTJvESUFS/oo7j6OPXgIwIXJZSIOmmtiOxXrugEJQZeEpgHiA/HT/5PtgcnD5YKXY32Xhte+mpjZdFTGrVvFGEle
 V0SXHmuaq1nEMMWZlcmjQUe/6Ka/AiFnJqwctplvQoE/vqdnmCgHcRWCtGRlanOoO4BdUo8rd8oKvv7SS5dnsALgSTxMGh3z/YudiZMO6mDFQx+nZpY23jSJ
 hlqg88wriaUFUDpc6uL4dcKL2+d2a5c1N8obrnDgZCcs7qB/rSJe6hlFPOHuJDfL8l0CQ4EIpNaNej4xfrdneKOs7g/H3KBVUy+ZNB6HCgJzlu9xJ0WNPaJa
 +lxhTsTCrG+4iGJSgsKSGv3/nDzJ4CMNba93JZKS0dRd7Uolb3NNCPqS9BUMiIO5ZHXtYsqHVcvKR89FM1gWqqSW1HTUoaZgqPDwvCveUcaU/CmQQRWJvJ1X
 +wdGB0DQARI66KwbOXKZGk5GHXlILq4BrhM0+xI+z9aMNguwh6RHA4jx33EGuDm47sRsk/AIKoCxf79qLz3satpiidl/IHTX96Ewgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kangjie,

Unfortunately there are more issues with the cleanup sequence in
this probe function:

On 3/14/19 6:03 AM, Kangjie Lu wrote:
> 1. dma_alloc_attrs, __get_free_pages can fail and return NULL.
> Further uses of their return values lead to NULL pointer
> dereferences
> 
> 2. In the error-handling path, video_unregister_device uses
> "rga->vfd" which has been freed by video_device_release
> 
> 3. The error handling for v4l2_m2m_init and video_register_device
> has memory-leak issues
> 
> The patch fixes the above issues.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/media/platform/rockchip/rga/rga.c | 26 ++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
> index 5c653287185f..468365ceb99d 100644
> --- a/drivers/media/platform/rockchip/rga/rga.c
> +++ b/drivers/media/platform/rockchip/rga/rga.c
> @@ -889,11 +889,24 @@ static int rga_probe(struct platform_device *pdev)
>  	rga->cmdbuf_virt = dma_alloc_attrs(rga->dev, RGA_CMDBUF_SIZE,
>  					   &rga->cmdbuf_phy, GFP_KERNEL,
>  					   DMA_ATTR_WRITE_COMBINE);
> +	if (!rga->cmdbuf_virt) {
> +		ret = -ENOMEM;
> +		goto unreg_video_dev;

Actually, the unreg_video_dev label makes no sense: if the video device
is successfully registered, then probe() returns 0. So you never need to
unregister the video device again. You *do* need to release it with
video_device_release().

So this should be a goto rel_vdev.

And the cleanup sequence at the end also fails to call v4l2_m2m_release().

Can you make v4?

Thanks!

	Hans

> +	}
>  
>  	rga->src_mmu_pages =
>  		(unsigned int *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 3);
> +	if (!rga->src_mmu_pages) {
> +		ret = -ENOMEM;
> +		goto free_dma_attrs;
> +	}
> +
>  	rga->dst_mmu_pages =
>  		(unsigned int *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 3);
> +	if (!rga->dst_mmu_pages) {
> +		ret = -ENOMEM;
> +		goto free_dst_pages;
> +	}
>  
>  	def_frame.stride = (def_frame.width * def_frame.fmt->depth) >> 3;
>  	def_frame.size = def_frame.stride * def_frame.height;
> @@ -901,7 +914,7 @@ static int rga_probe(struct platform_device *pdev)
>  	ret = video_register_device(vfd, VFL_TYPE_GRABBER, -1);
>  	if (ret) {
>  		v4l2_err(&rga->v4l2_dev, "Failed to register video device\n");
> -		goto rel_vdev;
> +		goto free_pages;
>  	}
>  
>  	v4l2_info(&rga->v4l2_dev, "Registered %s as /dev/%s\n",
> @@ -909,10 +922,17 @@ static int rga_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -rel_vdev:
> -	video_device_release(vfd);
> +free_pages:
> +	free_pages((unsigned long)rga->src_mmu_pages, 3);
> +free_dst_pages:
> +	free_pages((unsigned long)rga->dst_mmu_pages, 3);
> +free_dma_attrs:
> +	dma_free_attrs(rga->dev, RGA_CMDBUF_SIZE, rga->cmdbuf_virt,
> +		       rga->cmdbuf_phy,
> +		       DMA_ATTR_WRITE_COMBINE);
>  unreg_video_dev:
>  	video_unregister_device(rga->vfd);
> +	video_device_release(vfd);
>  unreg_v4l2_dev:
>  	v4l2_device_unregister(&rga->v4l2_dev);
>  err_put_clk:
> 

