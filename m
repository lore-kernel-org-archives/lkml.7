Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0550AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F43222D1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfKSMLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:11:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:55483 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSMLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:11:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 04:11:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="357091891"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2019 04:11:15 -0800
Message-ID: <5DD3DD7B.8000503@intel.com>
Date:   Tue, 19 Nov 2019 20:18:03 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
CC:     Khazhismel Kumykov <khazhy@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_balloon: name cleanups
References: <20191119102838.39380-1-mst@redhat.com>
In-Reply-To: <20191119102838.39380-1-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2019 06:29 PM, Michael S. Tsirkin wrote:
> free_page_order is a confusing name. It's not a page order
> actually, it's the order of the block of memory we are hinting.
> Rename to hint_block_order. Also, rename SIZE to BYTES
> to make it clear it's the block size in bytes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 65df40f261ab..b6a95cd28d9f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -32,10 +32,10 @@
>   #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN | \
>   					     __GFP_NOMEMALLOC)
>   /* The order of free page blocks to report to host */
> -#define VIRTIO_BALLOON_FREE_PAGE_ORDER (MAX_ORDER - 1)
> +#define VIRTIO_BALLOON_HINT_BLOCK_ORDER (MAX_ORDER - 1)
>   /* The size of a free page block in bytes */
> -#define VIRTIO_BALLOON_FREE_PAGE_SIZE \
> -	(1 << (VIRTIO_BALLOON_FREE_PAGE_ORDER + PAGE_SHIFT))
> +#define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
> +	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
>   static struct vfsmount *balloon_mnt;
> @@ -380,7 +380,7 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
>   		if (!page)
>   			break;
>   		free_pages((unsigned long)page_address(page),
> -			   VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   	}
>   	vb->num_free_page_blocks -= num_returned;
>   	spin_unlock_irq(&vb->free_page_list_lock);
> @@ -582,7 +582,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>   		;
>   
>   	page = alloc_pages(VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG,
> -			   VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +			   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   	/*
>   	 * When the allocation returns NULL, it indicates that we have got all
>   	 * the possible free pages, so return -EINTR to stop.
> @@ -591,13 +591,13 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>   		return -EINTR;
>   
>   	p = page_address(page);
> -	sg_init_one(&sg, p, VIRTIO_BALLOON_FREE_PAGE_SIZE);
> +	sg_init_one(&sg, p, VIRTIO_BALLOON_HINT_BLOCK_BYTES);
>   	/* There is always 1 entry reserved for the cmd id to use. */
>   	if (vq->num_free > 1) {
>   		err = virtqueue_add_inbuf(vq, &sg, 1, p, GFP_KERNEL);
>   		if (unlikely(err)) {
>   			free_pages((unsigned long)p,
> -				   VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +				   VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   			return err;
>   		}
>   		virtqueue_kick(vq);
> @@ -610,7 +610,7 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
>   		 * The vq has no available entry to add this page block, so
>   		 * just free it.
>   		 */
> -		free_pages((unsigned long)p, VIRTIO_BALLOON_FREE_PAGE_ORDER);
> +		free_pages((unsigned long)p, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
>   	}
>   
>   	return 0;
> @@ -765,11 +765,11 @@ static unsigned long shrink_free_pages(struct virtio_balloon *vb,
>   	unsigned long blocks_to_free, blocks_freed;
>   
>   	pages_to_free = round_up(pages_to_free,
> -				 1 << VIRTIO_BALLOON_FREE_PAGE_ORDER);
> -	blocks_to_free = pages_to_free >> VIRTIO_BALLOON_FREE_PAGE_ORDER;
> +				 1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> +	blocks_to_free = pages_to_free >> VIRTIO_BALLOON_HINT_BLOCK_ORDER;
>   	blocks_freed = return_free_pages_to_mm(vb, blocks_to_free);
>   
> -	return blocks_freed << VIRTIO_BALLOON_FREE_PAGE_ORDER;
> +	return blocks_freed << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
>   }
>   
>   static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> @@ -825,7 +825,7 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>   	unsigned long count;
>   
>   	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> -	count += vb->num_free_page_blocks << VIRTIO_BALLOON_FREE_PAGE_ORDER;
> +	count += vb->num_free_page_blocks << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
>   
>   	return count;
>   }


Reviewed-by: Wei Wang <wei.w.wang@intel.com>

Best,
Wei

