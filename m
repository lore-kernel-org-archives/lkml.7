Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93518C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691C3227BF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 09:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388922AbfGWJRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 05:17:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33641 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbfGWJRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 05:17:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id r6so36983772qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 02:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h3zIJ0ur5GAZZrotsV7XoPvlwXrYwk1PNIbGMg1g2l8=;
        b=PMvcuZmDckzrDRAZYeWNiJ+ywqRYZMINdgQSJC5GvU27lGKZJhlMsRRnKBG+RBZ9N+
         rUHKKBjKWO1uGqrc1J6QFWSE2OUeePy7r0iiOyF2ddu+Ds+YPp66kHX0m4NJLjaEQgwG
         z0pbKcs8iuHlERDxcLIQWlKbMKC+9Vg64kFR/dyglD9622oxnTroipUs0hjjOIhyJ0++
         VE7BlPSwlcz+jwXTMeaXsf5BDKUoVxhLYj1Q08O8RQ26SdLp4TCqJV1q2n/TWTGzilND
         hIfNzxdK/7nov1tbZSLUCi/5d6PFr2MLMmpSdmlBrcJpXy8VmenaLVNR+0zD+yZHP8c0
         tv5w==
X-Gm-Message-State: APjAAAX00JJilKPIiYwMfLV3JdlYaLGzgyMUQeO8WneKeIQd9s0Xgrm9
        W7FYXJvKX0tjwAdLF7t5XlFl6osFkOrGqg==
X-Google-Smtp-Source: APXvYqxqDdyi/5f/Mq5iXeKI3cXWz3/L5aeuMAmOkwcJvye1XplCRbmF7QAI4/d2iz8KsKqyIf1pvQ==
X-Received: by 2002:ac8:7510:: with SMTP id u16mr50609787qtq.60.1563873470240;
        Tue, 23 Jul 2019 02:17:50 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
        by smtp.gmail.com with ESMTPSA id p59sm20299552qtd.75.2019.07.23.02.17.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 02:17:49 -0700 (PDT)
Date:   Tue, 23 Jul 2019 05:17:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] vhost: validate MMU notifier registration
Message-ID: <20190723042428-mutt-send-email-mst@kernel.org>
References: <20190723075718.6275-1-jasowang@redhat.com>
 <20190723075718.6275-3-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723075718.6275-3-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 03:57:14AM -0400, Jason Wang wrote:
> The return value of mmu_notifier_register() is not checked in
> vhost_vring_set_num_addr(). This will cause an out of sync between mm
> and MMU notifier thus a double free. To solve this, introduce a
> boolean flag to track whether MMU notifier is registered and only do
> unregistering when it was true.
> 
> Reported-and-tested-by:
> syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Right. This fixes the bug.
But it's not great that simple things like
setting vq address put pressure on memory allocator.
Also, if we get a single during processing
notifier register will fail, disabling optimization permanently.

In fact, see below:


> ---
>  drivers/vhost/vhost.c | 19 +++++++++++++++----
>  drivers/vhost/vhost.h |  1 +
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 34c0d970bcbc..058191d5efad 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -630,6 +630,7 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	dev->iov_limit = iov_limit;
>  	dev->weight = weight;
>  	dev->byte_weight = byte_weight;
> +	dev->has_notifier = false;
>  	init_llist_head(&dev->work_list);
>  	init_waitqueue_head(&dev->wait);
>  	INIT_LIST_HEAD(&dev->read_list);
> @@ -731,6 +732,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  	if (err)
>  		goto err_mmu_notifier;
>  #endif
> +	dev->has_notifier = true;
>  
>  	return 0;
>  

I just noticed that set owner now fails if we get a signal.
Userspace could retry in theory but it does not:
this is userspace abi breakage since it used to only
fail on invalid input.

> @@ -960,7 +962,11 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	}
>  	if (dev->mm) {
>  #if VHOST_ARCH_CAN_ACCEL_UACCESS
> -		mmu_notifier_unregister(&dev->mmu_notifier, dev->mm);
> +		if (dev->has_notifier) {
> +			mmu_notifier_unregister(&dev->mmu_notifier,
> +						dev->mm);
> +			dev->has_notifier = false;
> +		}
>  #endif
>  		mmput(dev->mm);
>  	}
> @@ -2065,8 +2071,10 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  	/* Unregister MMU notifer to allow invalidation callback
>  	 * can access vq->uaddrs[] without holding a lock.
>  	 */
> -	if (d->mm)
> +	if (d->has_notifier) {
>  		mmu_notifier_unregister(&d->mmu_notifier, d->mm);
> +		d->has_notifier = false;
> +	}
>  
>  	vhost_uninit_vq_maps(vq);
>  #endif
> @@ -2086,8 +2094,11 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  	if (r == 0)
>  		vhost_setup_vq_uaddr(vq);
>  
> -	if (d->mm)
> -		mmu_notifier_register(&d->mmu_notifier, d->mm);
> +	if (d->mm) {
> +		r = mmu_notifier_register(&d->mmu_notifier, d->mm);
> +		if (!r)
> +			d->has_notifier = true;
> +	}
>  #endif
>  
>  	mutex_unlock(&vq->mutex);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 819296332913..a62f56a4cf72 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -214,6 +214,7 @@ struct vhost_dev {
>  	int iov_limit;
>  	int weight;
>  	int byte_weight;
> +	bool has_notifier;
>  };
>  
>  bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
> -- 
> 2.18.1
