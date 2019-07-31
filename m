Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A1FC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DA8206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbfGaJ75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:59:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53688 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbfGaJ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:59:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so60147114wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KfQ1GOxa2gwawYjZESEw8m6ZN1EOeLyab9IzRAQRkB8=;
        b=MjHsOlO34WN9SnQsTGDF3ZzmICYaqoJwkEmfiJoQ//OiJ4K6ny83kZX3kFw6OKKghw
         YsvBA/jJja68RD1e1hIl0JO3uf95H5P8SbhuWwilD2QHLvkK5F7ABys04KPBPiUoj8e8
         Eq6Xp1WQStPbfYcHm+FMknkeq2r7ua9C6PrkGxtEpTgiP+jYByx20RGMFGPov9nSEFe9
         On4+BmpXKWNLynpTtSGeOw+jG8AdEfss1ddwkigmWsfGqDCCyR90r6mfPdcu8KA2Btdn
         3qFTeQMxvD/yfJ4b4ZpTSt7BpLah2vDhkx/RSykhulAkEftn8AXjLmOUAiN2Pdi6Pfiw
         TWKg==
X-Gm-Message-State: APjAAAUvhIuEM8/w7qAl+XmPiWmKfMKcLk78yeTLy0L4pTpyOkcy9l6W
        JCj7OkJbM8wNPVvfX/kjWGJjZQ==
X-Google-Smtp-Source: APXvYqy7/iEU1UrL2it0Ep7+ooQdkQ6xuUDFbcpqjrWR2xbr/ulDYf5qm8/eQpzBooD00tKHJ19RcQ==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr12821673wmo.151.1564567193839;
        Wed, 31 Jul 2019 02:59:53 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id d10sm79226236wro.18.2019.07.31.02.59.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 02:59:53 -0700 (PDT)
Date:   Wed, 31 Jul 2019 11:59:50 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jgg@ziepe.ca
Subject: Re: [PATCH V2 9/9] vhost: do not return -EAGIAN for non blocking
 invalidation too early
Message-ID: <20190731095950.d6zr472megt7rgkt@steredhat>
References: <20190731084655.7024-1-jasowang@redhat.com>
 <20190731084655.7024-10-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731084655.7024-10-jasowang@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A little typo in the title: s/EAGIAN/EAGAIN

Thanks,
Stefano

On Wed, Jul 31, 2019 at 04:46:55AM -0400, Jason Wang wrote:
> Instead of returning -EAGAIN unconditionally, we'd better do that only
> we're sure the range is overlapped with the metadata area.
> 
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vhost/vhost.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index fc2da8a0c671..96c6aeb1871f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -399,16 +399,19 @@ static void inline vhost_vq_sync_access(struct vhost_virtqueue *vq)
>  	smp_mb();
>  }
>  
> -static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
> -				      int index,
> -				      unsigned long start,
> -				      unsigned long end)
> +static int vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
> +				     int index,
> +				     unsigned long start,
> +				     unsigned long end,
> +				     bool blockable)
>  {
>  	struct vhost_uaddr *uaddr = &vq->uaddrs[index];
>  	struct vhost_map *map;
>  
>  	if (!vhost_map_range_overlap(uaddr, start, end))
> -		return;
> +		return 0;
> +	else if (!blockable)
> +		return -EAGAIN;
>  
>  	spin_lock(&vq->mmu_lock);
>  	++vq->invalidate_count;
> @@ -423,6 +426,8 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
>  		vhost_set_map_dirty(vq, map, index);
>  		vhost_map_unprefetch(map);
>  	}
> +
> +	return 0;
>  }
>  
>  static void vhost_invalidate_vq_end(struct vhost_virtqueue *vq,
> @@ -443,18 +448,19 @@ static int vhost_invalidate_range_start(struct mmu_notifier *mn,
>  {
>  	struct vhost_dev *dev = container_of(mn, struct vhost_dev,
>  					     mmu_notifier);
> -	int i, j;
> -
> -	if (!mmu_notifier_range_blockable(range))
> -		return -EAGAIN;
> +	bool blockable = mmu_notifier_range_blockable(range);
> +	int i, j, ret;
>  
>  	for (i = 0; i < dev->nvqs; i++) {
>  		struct vhost_virtqueue *vq = dev->vqs[i];
>  
> -		for (j = 0; j < VHOST_NUM_ADDRS; j++)
> -			vhost_invalidate_vq_start(vq, j,
> -						  range->start,
> -						  range->end);
> +		for (j = 0; j < VHOST_NUM_ADDRS; j++) {
> +			ret = vhost_invalidate_vq_start(vq, j,
> +							range->start,
> +							range->end, blockable);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.18.1
> 

-- 
