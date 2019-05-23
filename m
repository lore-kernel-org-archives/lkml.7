Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D3C46470
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083292168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 12:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KhEJLfvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfEWMvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 08:51:11 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36170 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 08:51:10 -0400
Received: by mail-qt1-f195.google.com with SMTP id a17so6534889qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 05:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tvZhWwgKm7E1dVHVTqcNBhVthbWGembrtq41stBFKS0=;
        b=KhEJLfvDFJtXp5h58h6mCY3ICtla7khqIvU1EU1MAfSiLps4iCFvB4jQWyvVpzEO2f
         kDHOLNfNJoJtYcZle+JQMgusO8VJ4KFzvy86jhgRK/qZRW4abGq39AAYRl3FQdJ/UNzA
         M5QcLE1bbJdc4iPVGj02XZnhDOeJjceFQjyVZqN97/5qQW2ELQIhhZZiXlzNXo0ZOrO4
         x2MKiSVXwBpUPybGs2dNudUGwWX2aeNINzzNp7jw0wLrz/AOoQizziboH86y+0yimv5W
         ELF4p5fSqussufTN5NREXreecjhsB8wYg9XFaxN2Ob/rDYV4t0Fj2ZzQns3sXunBUsf2
         S64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tvZhWwgKm7E1dVHVTqcNBhVthbWGembrtq41stBFKS0=;
        b=pwZ3+z4PFsRsarZi9e6jMuJKd+h1vWJoZN228rykWPh3jkukJkxt3v5GmNTNoEWLUR
         8yGaCxecFTGVwpZ4IxOXfZXpoSpX3T5oDyZ+L7F7GyH1vLYetzHuXPwdGz28zZyj8Rqc
         /qV7IEf7pFZmHRyO/Zp/UJuui3NOHMMgZvoTxbSK9ammfGFq29VQ4VVFjPkif54/XfqC
         zxg4qJnYKnbqCJXFzfoZMzqQXgj6vSYF6CaYD5cEF+F6glKZSIWaT3YoTEJk8TVs83c8
         z5y+fDh2sMqG8hEkCUWhLxl8uPkOfVBH+LHQvTXBwqHPKnf6keZ9+L0jd6qhwo1qNd9p
         2Wxg==
X-Gm-Message-State: APjAAAUR4SYqyISlswnP4xWvetGvs82FYYM4xq45dqynHVmLkkrJa/ZU
        DNZeQhw7j51OiRcMnGil0PiBzg==
X-Google-Smtp-Source: APXvYqx40PgnmEYuxdED9Zel+dm+Tl053xrjfv/+pM76UtiJq0BENAJa3oNhzD0YQ38NlO5XIGfDAA==
X-Received: by 2002:a0c:af06:: with SMTP id i6mr32709230qvc.46.1558615869528;
        Thu, 23 May 2019 05:51:09 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id c30sm17320924qta.25.2019.05.23.05.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 05:51:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hTnBc-0002lt-KI; Thu, 23 May 2019 09:51:08 -0300
Date:   Thu, 23 May 2019 09:51:08 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     rcampbell@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/5] mm/hmm: Use mm_get_hmm() in hmm_range_register()
Message-ID: <20190523125108.GA14013@ziepe.ca>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-4-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506232942.12623-4-rcampbell@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2019 at 04:29:40PM -0700, rcampbell@nvidia.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> In hmm_range_register(), the call to hmm_get_or_create() implies that
> hmm_range_register() could be called before hmm_mirror_register() when
> in fact, that would violate the HMM API.
> 
> Use mm_get_hmm() instead of hmm_get_or_create() to get the HMM structure.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
>  mm/hmm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hmm.c b/mm/hmm.c
> index f6c4c8633db9..2aa75dbed04a 100644
> +++ b/mm/hmm.c
> @@ -936,7 +936,7 @@ int hmm_range_register(struct hmm_range *range,
>  	range->start = start;
>  	range->end = end;
>  
> -	range->hmm = hmm_get_or_create(mm);
> +	range->hmm = mm_get_hmm(mm);
>  	if (!range->hmm)
>  		return -EFAULT;

I looked for documentation saying that hmm_range_register should only
be done inside a hmm_mirror_register and didn't see it. Did I miss it?
Can you add a comment? 

It is really good to fix this because it means we can rely on mmap sem
to manage mm->hmm!

If this is true then I also think we should change the signature of
the function to make this dependency relationship clear, and remove
some possible confusing edge cases.

What do you think about something like this? (unfinished)

commit 29098bd59cf481ad1915db40aefc8435dabb8b28
Author: Jason Gunthorpe <jgg@mellanox.com>
Date:   Thu May 23 09:41:19 2019 -0300

    mm/hmm: Use hmm_mirror not mm as an argument for hmm_register_range
    
    Ralf observes that hmm_register_range() can only be called by a driver
    while a mirror is registered. Make this clear in the API by passing
    in the mirror structure as a parameter.
    
    This also simplifies understanding the lifetime model for struct hmm,
    as the hmm pointer must be valid as part of a registered mirror
    so all we need in hmm_register_range() is a simple kref_get.
    
    Suggested-by: Ralph Campbell <rcampbell@nvidia.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 8b91c90d3b88cb..87d29e085a69f7 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -503,7 +503,7 @@ static inline bool hmm_mirror_mm_is_alive(struct hmm_mirror *mirror)
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
 int hmm_range_register(struct hmm_range *range,
-		       struct mm_struct *mm,
+		       struct hmm_mirror *mirror,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift);
@@ -539,7 +539,8 @@ static inline bool hmm_vma_range_done(struct hmm_range *range)
 }
 
 /* This is a temporary helper to avoid merge conflict between trees. */
-static inline int hmm_vma_fault(struct hmm_range *range, bool block)
+static inline int hmm_vma_fault(struct hmm_mirror *mirror,
+				struct hmm_range *range, bool block)
 {
 	long ret;
 
@@ -552,7 +553,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 	range->default_flags = 0;
 	range->pfn_flags_mask = -1UL;
 
-	ret = hmm_range_register(range, range->vma->vm_mm,
+	ret = hmm_range_register(range, mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
 	if (ret)
diff --git a/mm/hmm.c b/mm/hmm.c
index 824e7e160d8167..fa1b04fcfc2549 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -927,7 +927,7 @@ static void hmm_pfns_clear(struct hmm_range *range,
  * Track updates to the CPU page table see include/linux/hmm.h
  */
 int hmm_range_register(struct hmm_range *range,
-		       struct mm_struct *mm,
+		       struct hmm_mirror *mirror,
 		       unsigned long start,
 		       unsigned long end,
 		       unsigned page_shift)
@@ -935,7 +935,6 @@ int hmm_range_register(struct hmm_range *range,
 	unsigned long mask = ((1UL << page_shift) - 1UL);
 
 	range->valid = false;
-	range->hmm = NULL;
 
 	if ((start & mask) || (end & mask))
 		return -EINVAL;
@@ -946,15 +945,12 @@ int hmm_range_register(struct hmm_range *range,
 	range->start = start;
 	range->end = end;
 
-	range->hmm = hmm_get_or_create(mm);
-	if (!range->hmm)
-		return -EFAULT;
-
 	/* Check if hmm_mm_destroy() was call. */
-	if (range->hmm->mm == NULL || range->hmm->dead) {
-		hmm_put(range->hmm);
+	if (mirror->hmm->mm == NULL || mirror->hmm->dead)
 		return -EFAULT;
-	}
+
+	range->hmm = mirror->hmm;
+	kref_get(&range->hmm->kref);
 
 	/* Initialize range to track CPU page table update */
 	mutex_lock(&range->hmm->lock);

