Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0051B214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gu8Vs9E+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfLMJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:33:39 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33006 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMJdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:33:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id c13so1018254pls.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 01:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KY94rQv5/loJQD4i0BZGc7jhqbYj6PtDGEFoVjzh9zM=;
        b=Gu8Vs9E+vFF8vFlZQHcm1Yilp0uo8ZYeY6s7APVwLAVv5v7A2KXo3Kxip03kVC8Qkj
         O6PwgC2GHF+SKubgVvhFvfGrBl+qy6z0udspUM2ac4H/mev6Y16cSo19BM5izD2spoip
         CTi0RjECdgrDGROEss9lxv5N0Z4RQgv8fnpmnHedCtGzypL7egdRd5P8NPkY7cvwB6eC
         iV71N7KxJhG81qEhh9VYzoVv1gEo9U6MXwLuKDzocT6jKASm+eULMERULn8xU390DPZ/
         GYR6LXfSyJLJ1IWjHcKALyk/0phkNfS6aLbfPIehzQEPOZvIXPv/pQ7oUfRTqc0zYEmk
         2b3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KY94rQv5/loJQD4i0BZGc7jhqbYj6PtDGEFoVjzh9zM=;
        b=otU4AP6b396ZotweoJoGnPV+0PK607dX2UwGDxA+3asAU6XcAYGdlf+7y9PyE4h5TP
         tqP6eu6bHzJ+WoHASDD6+LsrIJ+pHw8xVYnLHFnvKqgguiYJOrnd8rHG+ORD8dvIY3nE
         J+byC6LQeCXvUx8NNbsOaRQxAT91LwqTpda/VQOVu7V39Uo4Qvg9SlWOXsiKalkzgIXq
         V9rDRe92oxR2XE4Mq9FwM/ZhcJ4pbDoyXGgaLka8/mdm7VUWOrvocRLAlg00yC0IAGd5
         fD7jZJGdmjxnVb1N/1ICxTt/GvP1QpyY05L/sjWGgiIM4r6Wdb7vGuznNMmG7w2kLKUv
         WIYQ==
X-Gm-Message-State: APjAAAVWuA+/B3g+rpJk52lYf5Bck/GkFYRRZnBjpG5Rd5XPjhSaFuVm
        npeFNR7hxTvUA9lZwGLDykN7ng==
X-Google-Smtp-Source: APXvYqzb/2sdxXklFn5oYYxrkweQPjFaA8rYmyPMWm55R8sUbiLqH6XoQbqXDLTUeCKbBETB0Sy8Ow==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr14893672pjx.13.1576229617625;
        Fri, 13 Dec 2019 01:33:37 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id w12sm10425259pfd.58.2019.12.13.01.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 01:33:36 -0800 (PST)
Date:   Fri, 13 Dec 2019 01:33:35 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        Ming Lei <ming.lei@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Jianxiong Gao <jxgao@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <alpine.DEB.2.21.1912121550230.148507@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1912130121500.215313@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com> <20190905060627.GA1753@lst.de> <alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com> <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
 <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com> <1d74607e-37f7-56ca-aba3-5a3bd7a68561@amd.com> <20190918132242.GA16133@lst.de> <alpine.DEB.2.21.1911271359000.135363@chino.kir.corp.google.com> <20191128064056.GA19822@lst.de>
 <alpine.DEB.2.21.1912121550230.148507@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Dec 2019, David Rientjes wrote:

> Since all DMA must be unencrypted in this case, what happens if all 
> dma_direct_alloc_pages() calls go through the DMA pool in 
> kernel/dma/remap.c when force_dma_unencrypted(dev) == true since 
> __PAGE_ENC is cleared for these ptes?  (Ignoring for a moment that this 
> special pool should likely be a separate dma pool.)
> 
> I assume a general depletion of that atomic pool so 
> DEFAULT_DMA_COHERENT_POOL_SIZE becomes insufficient.  I'm not sure what 
> size any DMA pool wired up for this specific purpose would need to be 
> sized at, so I assume dynamic resizing is required.
> 
> It shouldn't be *that* difficult to supplement kernel/dma/remap.c with the 
> ability to do background expansion of the atomic pool when nearing its 
> capacity for this purpose?  I imagine that if we just can't allocate pages 
> within the DMA mask that it's the only blocker to dynamic expansion and we 
> don't oom kill for lowmem.  But perhaps vm.lowmem_reserve_ratio is good 
> enough protection?
> 
> Beyond that, I'm not sure what sizing would be appropriate if this is to 
> be a generic solution in the DMA API for all devices that may require 
> unecrypted memory.
> 

Secondly, I'm wondering about how the DMA pool for atomic allocations 
compares with lowmem reserve for both ZONE_DMA and ZONE_DMA32.  For 
allocations where the classzone index is one of these zones, the lowmem 
reserve is static, we don't account the amount of lowmem allocated and 
adjust this for future watermark checks in the page allocator.  We always 
guarantee that reserve is free (absent the depletion of the zone due to 
GFP_ATOMIC allocations where we fall below the min watermarks).

If all DMA memory needs to have _PAGE_ENC cleared when the guest is SEV 
encrypted, I'm wondering if the entire lowmem reserve could be designed as 
a pool of lowmem pages rather than a watermark check.  If implemented as a 
pool of pages in the page allocator itself, and today's reserve is static, 
maybe we could get away with a dynamic resizing based on that static 
amount?  We could offload the handling of this reserve to kswapd such that 
when the pool falls below today's reserve amount, we dynamically expand, 
do the necessary unencryption in blockable context, and add to the pool.  
Bonus is that this provides high-order lowmem reserve if implemented as 
per-order freelists rather than the current watermark check that provides 
no guarantees for any high-order lowmem.

I don't want to distract from the first set of questions in my previous 
email because I need an understanding of that anyway, but I'm hoping 
Christoph can guide me on why the above wouldn't be an improvement even 
for non encrypted guests.
