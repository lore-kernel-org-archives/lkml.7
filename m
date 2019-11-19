Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DC0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B832230F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfKSMSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:18:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:64330 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKSMSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:18:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 04:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="209179842"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2019 04:18:06 -0800
Message-ID: <5DD3DF17.9050504@intel.com>
Date:   Tue, 19 Nov 2019 20:24:55 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
CC:     Khazhismel Kumykov <khazhy@google.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] virtio_balloon: divide/multiply instead of shifts
References: <20191119102838.39380-1-mst@redhat.com> <20191119102838.39380-2-mst@redhat.com>
In-Reply-To: <20191119102838.39380-2-mst@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/2019 06:29 PM, Michael S. Tsirkin wrote:
> We managed to get confused about the shift direction at least once.
> Let's switch to division/multiplcation instead. Add a number of pages
> macro for this purpose.  We still keep the order macro around too since
> this is what alloc/free pages want.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   drivers/virtio/virtio_balloon.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index b6a95cd28d9f..dc1ebd638e9b 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -36,6 +36,7 @@
>   /* The size of a free page block in bytes */
>   #define VIRTIO_BALLOON_HINT_BLOCK_BYTES \
>   	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
> +#define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
>   
>   #ifdef CONFIG_BALLOON_COMPACTION
>   static struct vfsmount *balloon_mnt;
> @@ -765,11 +766,11 @@ static unsigned long shrink_free_pages(struct virtio_balloon *vb,
>   	unsigned long blocks_to_free, blocks_freed;
>   
>   	pages_to_free = round_up(pages_to_free,
> -				 1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER);
> -	blocks_to_free = pages_to_free >> VIRTIO_BALLOON_HINT_BLOCK_ORDER;
> +				 VIRTIO_BALLOON_HINT_BLOCK_PAGES);
> +	blocks_to_free = pages_to_free / VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>   	blocks_freed = return_free_pages_to_mm(vb, blocks_to_free);
>   
> -	return blocks_freed << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
> +	return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>   }
>   
>   static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> @@ -825,7 +826,7 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>   	unsigned long count;
>   
>   	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> -	count += vb->num_free_page_blocks << VIRTIO_BALLOON_HINT_BLOCK_ORDER;
> +	count += vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>   
>   	return count;
>   }

Reviewed-by: Wei Wang <wei.w.wang@intel.com>

Best,
Wei
