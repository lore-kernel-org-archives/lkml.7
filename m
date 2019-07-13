Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86C1C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 19:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB3F2064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 19:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n0KFTozv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfGMTjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 15:39:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41091 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbfGMTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 15:39:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so5708333pff.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4rwRS7GM+nAGTGCY3bn6psvJVMqQf5Gz5RaBpQRnLL8=;
        b=n0KFTozv9CtnAVuGyX9D6NNG61GDCR6T64sYf9upTmnmAdBFsnDEUe1t04Bu/LT2D+
         bqBxtGoXwlL1gRCO7WG9Ry/284/rMlUsnYIrhM2DGa+J+n8e/x6f6zHA4id9QtkHa0lh
         yUECAj3rN/6p1EB2mV2pFisblC3mqlEQjqMnDIujn/DWYMn1r1/cFrH44limBhWtA471
         7Ivil9qXvMi9HM/BXy38rCzLWP4HvU3WnGlPrgV9sfbyNU5xKXnzdknElbXLdolGGYg7
         PDlDb+DUR0wgpZ8zpQE63IgFYMKyfyV09ZDJLsq+hVRQu169Lp9V4242fwagSZfrMEY1
         Paow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4rwRS7GM+nAGTGCY3bn6psvJVMqQf5Gz5RaBpQRnLL8=;
        b=E/WCpmnqUGYMw7m+CfHkPXVmu5egQj5G5HH8bCQHVVfVU7yO+PfCf60PDsYhdGxXwE
         4n4RMEVFk/qakvE3MPkjsxCmi2gfqT8iVVB2Rv4n47NDwXNBBI2LRw1WUuxQDB2xx7cQ
         kOpXVHXp9QAGxiVm2GMujp8e1KyO7oIiJkJrUqcdPBgrAyzEgO9I0k1l9onO/dzuGLZM
         LzDeDF2gTl4dD0z6V0l8+8XeV3+mCmC0xYqM2fawqsSII3nw9dK54KFQtbnNYMUn9wiD
         7EwNgAI6k98cL1bAQKZEjbAXVr6cxSmnNs2r49lkS10YsxD/2h+SDvx7FORdmYyQGM+D
         g+jw==
X-Gm-Message-State: APjAAAXKjhth2nv4fMJNfUywrGIO5HZ1LQHrNo1oXoQFPgpMIL3sxvBz
        KY/p5SPITn3azwbTdmVDlM+8TA==
X-Google-Smtp-Source: APXvYqxOrGaeCkdz67qh5Pd8o/OBYvz4gK7V7SeQ+uf99qRLAi4vYDlYPDSLlTDG/ZmBLF3HPE9yUQ==
X-Received: by 2002:a63:6686:: with SMTP id a128mr11260150pgc.361.1563046758563;
        Sat, 13 Jul 2019 12:39:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id k6sm11697073pfi.12.2019.07.13.12.39.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 12:39:17 -0700 (PDT)
Date:   Sat, 13 Jul 2019 12:39:16 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <yang.shi@linux.alibaba.com>
cc:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
In-Reply-To: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
Message-ID: <alpine.DEB.2.21.1907131230280.246128@chino.kir.corp.google.com>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2019, Yang Shi wrote:

> When running ltp's oom test with kmemleak enabled, the below warning was
> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> passed in:
> 
> WARNING: CPU: 105 PID: 2138 at mm/page_alloc.c:4608 __alloc_pages_nodemask+0x1c31/0x1d50
> Modules linked in: loop dax_pmem dax_pmem_core
> ip_tables x_tables xfs virtio_net net_failover virtio_blk failover
> ata_generic virtio_pci virtio_ring virtio libata
> CPU: 105 PID: 2138 Comm: oom01 Not tainted 5.2.0-next-20190710+ #7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> RIP: 0010:__alloc_pages_nodemask+0x1c31/0x1d50
> ...
>  kmemleak_alloc+0x4e/0xb0
>  kmem_cache_alloc+0x2a7/0x3e0
>  ? __kmalloc+0x1d6/0x470
>  ? ___might_sleep+0x9c/0x170
>  ? mempool_alloc+0x2b0/0x2b0
>  mempool_alloc_slab+0x2d/0x40
>  mempool_alloc+0x118/0x2b0
>  ? __kasan_check_read+0x11/0x20
>  ? mempool_resize+0x390/0x390
>  ? lock_downgrade+0x3c0/0x3c0
>  bio_alloc_bioset+0x19d/0x350
>  ? __swap_duplicate+0x161/0x240
>  ? bvec_alloc+0x1b0/0x1b0
>  ? do_raw_spin_unlock+0xa8/0x140
>  ? _raw_spin_unlock+0x27/0x40
>  get_swap_bio+0x80/0x230
>  ? __x64_sys_madvise+0x50/0x50
>  ? end_swap_bio_read+0x310/0x310
>  ? __kasan_check_read+0x11/0x20
>  ? check_chain_key+0x24e/0x300
>  ? bdev_write_page+0x55/0x130
>  __swap_writepage+0x5ff/0xb20
> 
> The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, kmemleak has
> __GFP_NOFAIL set all the time due to commit
> d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
> with fault injection").
> 

It only clears __GFP_DIRECT_RECLAIM provisionally to see if the allocation 
would immediately succeed before falling back to the elements in the 
mempool.  If that fails, and the mempool is empty, mempool_alloc() 
attempts the allocation with __GFP_DIRECT_RECLAIM.  So for the problem 
described here, I think what we really want is this:

diff --git a/mm/mempool.c b/mm/mempool.c
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -386,7 +386,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 	gfp_mask |= __GFP_NORETRY;	/* don't loop in __alloc_pages */
 	gfp_mask |= __GFP_NOWARN;	/* failures are OK */
 
-	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
+	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO|__GFP_NOFAIL);
 
 repeat_alloc:
 
But bio_alloc_bioset() plays with gfp_mask itself: are we sure that it 
isn't the one clearing __GFP_DIRECT_RECLAIM itself before falling back to 
saved_gfp?

In other words do we also want this?

diff --git a/block/bio.c b/block/bio.c
--- a/block/bio.c
+++ b/block/bio.c
@@ -462,16 +462,16 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 		 * We solve this, and guarantee forward progress, with a rescuer
 		 * workqueue per bio_set. If we go to allocate and there are
 		 * bios on current->bio_list, we first try the allocation
-		 * without __GFP_DIRECT_RECLAIM; if that fails, we punt those
-		 * bios we would be blocking to the rescuer workqueue before
-		 * we retry with the original gfp_flags.
+		 * without __GFP_DIRECT_RECLAIM or __GFP_NOFAIL; if that fails,
+		 * we punt those bios we would be blocking to the rescuer
+		 * workqueue before we retry with the original gfp_flags.
 		 */
-
 		if (current->bio_list &&
 		    (!bio_list_empty(&current->bio_list[0]) ||
 		     !bio_list_empty(&current->bio_list[1])) &&
 		    bs->rescue_workqueue)
-			gfp_mask &= ~__GFP_DIRECT_RECLAIM;
+			gfp_mask &= ~(__GFP_DIRECT_RECLAIM |
+				      __GFP_NOFAIL);
 
 		p = mempool_alloc(&bs->bio_pool, gfp_mask);
 		if (!p && gfp_mask != saved_gfp) {
