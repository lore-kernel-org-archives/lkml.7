Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81E8C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FC1233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 11:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbfHVLdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 07:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388192AbfHVLdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 07:33:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C765389F38E;
        Thu, 22 Aug 2019 11:33:42 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (unknown [10.36.118.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97F1F1001B32;
        Thu, 22 Aug 2019 11:33:38 +0000 (UTC)
Subject: Re: [PATCH v5] drm/virtio: use virtio_max_dma_size
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190821111210.27165-1-kraxel@redhat.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <2e6eba7b-5f46-e9e8-f6b2-3e80e95754e9@redhat.com>
Date:   Thu, 22 Aug 2019 13:33:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190821111210.27165-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Thu, 22 Aug 2019 11:33:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/19 13:12, Gerd Hoffmann wrote:
> We must make sure our scatterlist segments are not too big, otherwise
> we might see swiotlb failures (happens with sev, also reproducable with
> swiotlb=force).
> 
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index b2da31310d24..09b526518f5a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -204,6 +204,7 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
>  		.interruptible = false,
>  		.no_wait_gpu = false
>  	};
> +	size_t max_segment;
>  
>  	/* wtf swapping */
>  	if (bo->pages)
> @@ -215,8 +216,13 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
>  	if (!bo->pages)
>  		goto out;
>  
> -	ret = sg_alloc_table_from_pages(bo->pages, pages, nr_pages, 0,
> -					nr_pages << PAGE_SHIFT, GFP_KERNEL);
> +	max_segment = virtio_max_dma_size(qdev->vdev);
> +	max_segment &= PAGE_MASK;
> +	if (max_segment > SCATTERLIST_MAX_SEGMENT)
> +		max_segment = SCATTERLIST_MAX_SEGMENT;
> +	ret = __sg_alloc_table_from_pages(bo->pages, pages, nr_pages, 0,
> +					  nr_pages << PAGE_SHIFT,
> +					  max_segment, GFP_KERNEL);
>  	if (ret)
>  		goto out;
>  	return 0;
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
