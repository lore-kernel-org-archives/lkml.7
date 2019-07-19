Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A1FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F47A21871
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 15:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfGSPRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 11:17:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfGSPRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 11:17:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E743D307154A;
        Fri, 19 Jul 2019 15:17:03 +0000 (UTC)
Received: from redhat.com (ovpn-124-174.rdu2.redhat.com [10.10.124.174])
        by smtp.corp.redhat.com (Postfix) with SMTP id D7C3262660;
        Fri, 19 Jul 2019 15:17:01 +0000 (UTC)
Date:   Fri, 19 Jul 2019 11:17:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Fei Li <lifei.shirley@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>
Subject: Re: [PATCH 1/2] virtio-mmio: Process vrings more proactively
Message-ID: <20190719111440-mutt-send-email-mst@kernel.org>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
 <20190719133135.32418-2-lifei.shirley@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719133135.32418-2-lifei.shirley@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 19 Jul 2019 15:17:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:31:34PM +0800, Fei Li wrote:
> From: Fam Zheng <zhengfeiran@bytedance.com>
> 
> This allows the backend to _not_ trap mmio read of the status register
> after injecting IRQ in the data path, which can improve the performance
> significantly by avoiding a vmexit for each interrupt.
> 
> More importantly it also makes it possible for Firecracker to hook up
> virtio-mmio with vhost-net, in which case there isn't a way to implement
> proper status register handling.
> 
> For a complete backend that does set either INT_CONFIG bit or INT_VRING
> bit upon generating irq, what happens hasn't changed.
> 
> Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>

This has a side effect of skipping vring callbacks
if they trigger at the same time with a config
interrupt.
I don't see why this is safe.


> ---
>  drivers/virtio/virtio_mmio.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index e09edb5c5e06..9b42502b2204 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -295,9 +295,7 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
>  	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
>  		virtio_config_changed(&vm_dev->vdev);
>  		ret = IRQ_HANDLED;
> -	}
> -
> -	if (likely(status & VIRTIO_MMIO_INT_VRING)) {
> +	} else {
>  		spin_lock_irqsave(&vm_dev->lock, flags);
>  		list_for_each_entry(info, &vm_dev->virtqueues, node)
>  			ret |= vring_interrupt(irq, info->vq);
> -- 
> 2.11.0
