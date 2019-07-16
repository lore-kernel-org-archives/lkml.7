Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914CC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99FEE2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IhLxXmaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbfGPSXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:23:36 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33219 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPSXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:23:36 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so16411330qtt.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PXyjImG+E2TkTA05zWl+KvbpavQKqjXD6/g7c5TTGc=;
        b=IhLxXmaA7lR5yGh01DUyd6sYT6E6n/2RktpucRSVoywo/da4UJzZVb+36q4q9LQiBA
         nQl1A096NEc6LX/dIxZIyjWD/viMWA9keetJjhAfeSgudlVR3654CZqnAMrI3Ak53cti
         1la2hb6mTk05I+FnisbYcZ0W9myAguoW3dCElTpW0rDs84LUZAE13bz0LdigEwOCKHvu
         RyHcXhqu67ObXKD+rH6ivxLHutxFVFcv3S5V5poRAtqA0ye+SSH1DkNGj/wWAY7Z53cg
         r1ogSUE4y7itkqz3hpwRgZaCjLxac5lr0NVU1//eO1X9i3NZ2RYQAOQgeFCLFNgcsv3y
         XjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PXyjImG+E2TkTA05zWl+KvbpavQKqjXD6/g7c5TTGc=;
        b=p381zEtmAZ1lE4neImxkPxn77p6fJo00NjhQQfif/WylmZYADYYa9uzw9Tu5f22WSX
         9jO3VzwMAkiyardR7Kiuwnxtuq6haqErQ1o5rxrMDwIQeeFNcUtYGgTE9I7reqfdM7f+
         9BbsBsiKSPAxT41EPuNo5Atj51RJ6pb1IP7cuGQNPlwreK0ruAJPy7hIkyyg+w6jR37K
         l05908O89Yhhk5VP6Egcnu/lbcTuWEdlouUEHSqa/YQHP5bqRljs6DDl/jOOzXRj9bv3
         pWO06zzL/zarTVpKTdfDTt2AD/pMGj8eFiQJDYEOe1z3eK9Hp/NAzGiYknxtYnBtu+gR
         yL4w==
X-Gm-Message-State: APjAAAVzLURXqeLdqmz1DGVSGh04kCcIsnvFn6kWAOnnPCaOXZsx2Hpk
        NKr/4MmO25cp6EMAQgtdN+Aai6NU2NiLow==
X-Google-Smtp-Source: APXvYqwDiPkO01x0v4gYkA8ROVKOZtnYbXXoSXCZbHBDGqMxSo60v4pBhZjuyNrG/7jica7ztAWnyg==
X-Received: by 2002:ac8:877:: with SMTP id x52mr24045228qth.328.1563301414529;
        Tue, 16 Jul 2019 11:23:34 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r40sm11907517qtr.57.2019.07.16.11.23.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 11:23:33 -0700 (PDT)
Message-ID: <1563301410.4610.8.camel@lca.pw>
Subject: Re: [PATCH] Revert "kmemleak: allow to coexist with fault injection"
From:   Qian Cai <cai@lca.pw>
To:     Yang Shi <yang.shi@linux.alibaba.com>, catalin.marinas@arm.com,
        mhocko@suse.com, dvyukov@google.com, rientjes@google.com,
        willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 16 Jul 2019 14:23:30 -0400
In-Reply-To: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1563299431-111710-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-17 at 01:50 +0800, Yang Shi wrote:
> When running ltp's oom test with kmemleak enabled, the below warning was
> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> passed in:
> 
> WARNING: CPU: 105 PID: 2138 at mm/page_alloc.c:4608
> __alloc_pages_nodemask+0x1c31/0x1d50
> Modules linked in: loop dax_pmem dax_pmem_core ip_tables x_tables xfs
> virtio_net net_failover virtio_blk failover ata_generic virtio_pci virtio_ring
> virtio libata
> CPU: 105 PID: 2138 Comm: oom01 Not tainted 5.2.0-next-20190710+ #7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-
> g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> RIP: 0010:__alloc_pages_nodemask+0x1c31/0x1d50
> ...
>  kmemleak_alloc+0x4e/0xb0
>  kmem_cache_alloc+0x2a7/0x3e0
>  ? __kmalloc+0x1d6/0x470
>  ? ___might_sleep+0x9c/0x170
>  ? mempool_alloc+0x2b0/0x2b0
>  mempool_alloc_slab+0x2d/0x40
>  mempool_alloc+0x118/0x2b0
>  ? __kasan_check_read+0x11/0x20
>  ? mempool_resize+0x390/0x390
>  ? lock_downgrade+0x3c0/0x3c0
>  bio_alloc_bioset+0x19d/0x350
>  ? __swap_duplicate+0x161/0x240
>  ? bvec_alloc+0x1b0/0x1b0
>  ? do_raw_spin_unlock+0xa8/0x140
>  ? _raw_spin_unlock+0x27/0x40
>  get_swap_bio+0x80/0x230
>  ? __x64_sys_madvise+0x50/0x50
>  ? end_swap_bio_read+0x310/0x310
>  ? __kasan_check_read+0x11/0x20
>  ? check_chain_key+0x24e/0x300
>  ? bdev_write_page+0x55/0x130
>  __swap_writepage+0x5ff/0xb20
> 
> The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, however kmemleak has
> __GFP_NOFAIL set all the time due to commit
> d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
> with fault injection").  But, it doesn't make any sense to have
> __GFP_NOFAIL and ~__GFP_DIRECT_RECLAIM specified at the same time.
> 
> According to the discussion on the mailing list, the commit should be
> reverted for short term solution.  Catalin Marinas would follow up with a
> better
> solution for longer term.
> 
> The failure rate of kmemleak metadata allocation may increase in some
> circumstances, but this should be expected side effect.

As mentioned in anther thread, the situation for kmemleak under memory pressure
has already been unhealthy. I don't feel comfortable to make it even worse by
reverting this commit alone. This could potentially make kmemleak kill itself
easier and miss some more real memory leak later.

To make it really a short-term solution before the reverting, I think someone
needs to follow up with the mempool solution with tunable pool size mentioned
in,

https://lore.kernel.org/linux-mm/20190328145917.GC10283@arrakis.emea.arm.com/

I personally not very confident that Catalin will find some time soon to
implement embedding kmemleak metadata into the slab. Even he or someone does
eventually, it probably need quite some time to test and edge out many of corner
cases that kmemleak could have by its natural.

> 
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Qian Cai <cai@lca.pw>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/kmemleak.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 9dd581d..884a5e3 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -114,7 +114,7 @@
>  /* GFP bitmask for kmemleak internal allocations */
>  #define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL | GFP_ATOMIC)) |
> \
>  				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
> -				 __GFP_NOWARN | __GFP_NOFAIL)
> +				 __GFP_NOWARN)
>  
>  /* scanning area inside a memory block */
>  struct kmemleak_scan_area {
