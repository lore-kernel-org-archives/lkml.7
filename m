Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C852C7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C70320644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbfGODyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:54:03 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:15776 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfGODyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:54:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TWuGjYt_1563162210;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TWuGjYt_1563162210)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Jul 2019 11:43:38 +0800
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
To:     David Rientjes <rientjes@google.com>
Cc:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1907131230280.246128@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <95f03095-3284-996c-83f9-c049aebc49c3@linux.alibaba.com>
Date:   Sun, 14 Jul 2019 20:43:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1907131230280.246128@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/19 12:39 PM, David Rientjes wrote:
> On Sat, 13 Jul 2019, Yang Shi wrote:
>
>> When running ltp's oom test with kmemleak enabled, the below warning was
>> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
>> passed in:
>>
>> WARNING: CPU: 105 PID: 2138 at mm/page_alloc.c:4608 __alloc_pages_nodemask+0x1c31/0x1d50
>> Modules linked in: loop dax_pmem dax_pmem_core
>> ip_tables x_tables xfs virtio_net net_failover virtio_blk failover
>> ata_generic virtio_pci virtio_ring virtio libata
>> CPU: 105 PID: 2138 Comm: oom01 Not tainted 5.2.0-next-20190710+ #7
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
>> RIP: 0010:__alloc_pages_nodemask+0x1c31/0x1d50
>> ...
>>   kmemleak_alloc+0x4e/0xb0
>>   kmem_cache_alloc+0x2a7/0x3e0
>>   ? __kmalloc+0x1d6/0x470
>>   ? ___might_sleep+0x9c/0x170
>>   ? mempool_alloc+0x2b0/0x2b0
>>   mempool_alloc_slab+0x2d/0x40
>>   mempool_alloc+0x118/0x2b0
>>   ? __kasan_check_read+0x11/0x20
>>   ? mempool_resize+0x390/0x390
>>   ? lock_downgrade+0x3c0/0x3c0
>>   bio_alloc_bioset+0x19d/0x350
>>   ? __swap_duplicate+0x161/0x240
>>   ? bvec_alloc+0x1b0/0x1b0
>>   ? do_raw_spin_unlock+0xa8/0x140
>>   ? _raw_spin_unlock+0x27/0x40
>>   get_swap_bio+0x80/0x230
>>   ? __x64_sys_madvise+0x50/0x50
>>   ? end_swap_bio_read+0x310/0x310
>>   ? __kasan_check_read+0x11/0x20
>>   ? check_chain_key+0x24e/0x300
>>   ? bdev_write_page+0x55/0x130
>>   __swap_writepage+0x5ff/0xb20
>>
>> The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, kmemleak has
>> __GFP_NOFAIL set all the time due to commit
>> d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
>> with fault injection").
>>
> It only clears __GFP_DIRECT_RECLAIM provisionally to see if the allocation
> would immediately succeed before falling back to the elements in the
> mempool.  If that fails, and the mempool is empty, mempool_alloc()
> attempts the allocation with __GFP_DIRECT_RECLAIM.  So for the problem
> described here, I think what we really want is this:
>
> diff --git a/mm/mempool.c b/mm/mempool.c
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -386,7 +386,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
>   	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */
>   	gfp_mask |= __GFP_NOWARN;	/* failures are OK */
>   
> -	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
> +	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO|__GFP_NOFAIL);
>   
>   repeat_alloc:
>   
> But bio_alloc_bioset() plays with gfp_mask itself: are we sure that it
> isn't the one clearing __GFP_DIRECT_RECLAIM itself before falling back to
> saved_gfp?
>
> In other words do we also want this?
>
> diff --git a/block/bio.c b/block/bio.c
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -462,16 +462,16 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
>   		 * We solve this, and guarantee forward progress, with a rescuer
>   		 * workqueue per bio_set. If we go to allocate and there are
>   		 * bios on current->bio_list, we first try the allocation
> -		 * without __GFP_DIRECT_RECLAIM; if that fails, we punt those
> -		 * bios we would be blocking to the rescuer workqueue before
> -		 * we retry with the original gfp_flags.
> +		 * without __GFP_DIRECT_RECLAIM or __GFP_NOFAIL; if that fails,
> +		 * we punt those bios we would be blocking to the rescuer
> +		 * workqueue before we retry with the original gfp_flags.
>   		 */
> -
>   		if (current->bio_list &&
>   		    (!bio_list_empty(&current->bio_list[0]) ||
>   		     !bio_list_empty(&current->bio_list[1])) &&
>   		    bs->rescue_workqueue)
> -			gfp_mask &= ~__GFP_DIRECT_RECLAIM;
> +			gfp_mask &= ~(__GFP_DIRECT_RECLAIM |
> +				      __GFP_NOFAIL);
>   
>   		p = mempool_alloc(&bs->bio_pool, gfp_mask);
>   		if (!p && gfp_mask != saved_gfp) {

I don't think it will make any difference by removing __GFP_NOFAIL 
outside kmemleak. The problem is the commit 
d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist 
with fault injection") makes __GFP_NOFAIL is set for kmemleak always in 
order to turn off fault-injection for kmemleak.

As long as kmemleak is called in ~__GFP_DIRECT_RECLAIM path, the warning 
might be hit.

And since kmemleak is just a debugging tool, so IMHO I don't think this 
is worth fixing, so I came up with the patch to document it.


