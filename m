Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F265AC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84CC2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RSvPQjSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfGQG26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:28:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQG25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9sLFqm6EWS2DIiGZAHNJ+/pU7r3k2LOQS5hHJSocQUk=; b=RSvPQjSpGEK8mDDZsLOQ3MgJx
        Ooj90M7o4gvCf/4/Gh4dFJ3QZr1eT/LiJZHPVztRwImmqFyObu37DTJ2lCKdQN2MvT+anttLzL/yR
        cTF8g9chJP6JLkx/hJQTO1/Ma5fwosGgqD1+iKUrdqP8VsibzIBiSXNzr7rqqbnf+Pb9y0UPaN8Bz
        t1O4j/RAUpTUahDXI4KIydVqTs/dTawjFRY8HyAL/Ozi2OjeqZP0BYfi+UCtHKiIEzUxY0dP9COGa
        Lx6EGEPHiqjH4l7jaVgiOOy5koCstgInlg+khvK/WRUd7zy0uHGQcdBXNguAgyKkAsACqCFwv/AsH
        ITxWM/6lw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hndQv-00043w-6R; Wed, 17 Jul 2019 06:28:57 +0000
Subject: Re: Correct use of DMA api (Some newbie questions)
To:     Nikolai Zhubr <n-a-zhubr@yandex.ru>, linux-kernel@vger.kernel.org
References: <5D2B6126.7080700@yandex.ru>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e3d16703-3d16-30f0-32cc-9511664224c5@infradead.org>
Date:   Tue, 16 Jul 2019 23:28:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <5D2B6126.7080700@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/19 10:06 AM, Nikolai Zhubr wrote:
> Hi all,
> 
> After reading some (apparently contradictory) revisions of DMA api references in Documentation/DMA-*.txt, some (contradictory) discussions thereof, and even digging through the in-tree drivers in search for a good enlightening example, still I have to ask for advice.
> 
> I'm crafting a tiny driver (or rather, a kernel-mode helper) for a very special PCIe device. And actually it does work already, but performs differenly on different kernels. I'm targeting x86 (i686) only (although preferrably the driver should stay platform-neutral) and I need to support kernels 4.9+. Due to how the device is designed and used, very little has to be done in kernel space. The device has large internal memory, which accumulates some measurement data, and it is capable of transferring it to the host using DMA (with at least 32-bit address space available). Arranging memory for DMA is pretty much the only thing that userspace can not reasonably do, so this needs to be in the driver. So my currenly attempted layout is as follows:
> 
> 1. In the (kernel-mode) driver, allocate large contiguous block of physical memory to do DMA into. It will be later reused several times. This block does not need to have a kernel-mode virtual address because it will never be accessed from the driver directly. The block size is typically 128M and I use CMA=256M. Currently I use dma_alloc_coherent(), but I'm not convinced it really needs to be a strictly coherent memory, for performance reasons, see below. Also, AFAICS on x86 dma_alloc_coherent() always creates a kernel address mapping anyway, so maybe I'd better simply kalloc() with subsequent dma_map_single()?
> 
> 2. Upon DMA completion (from device to host), some sort of barrier/synchronization might be necessary (to be safe WRT speculative loads, cache, etc), like dma_cache_sync() or dma_sync_single_for_cpu(), however the latter looks like a nop for x86 AFAICS, and the former is apparently flush_write_buffers() which is not very involved either (asm lock; nop) and does not look usefull for my case. Currentlly, I do not use any, and it seems like OK, maybe by pure luck. So, is it so trivially simple on x86 or am I just missing something horribly big here?
> 
> 3. mmap this buffer for userspace. Reading from it should be as fast as possible, therefore this block AFAICS should be cacheble (and prefetchable and whatever else for better performance), at least from userspace context. It is not quite clear if such properties would depend on block allocation method (in step 1 above) or just on remapping attributes only. Currently, for mmap I employ dma_mmap_coherent(), but it seems also possible to use remap_pfn_range(), and also change vm_page_prot somewhat. I've already found that e.g. pgprot_noncached hurts performance quite a lot, but supposedly without it some DMA barrier (step 2 above) seems still necessary?
> 
> Any hints greatly appreciated,
> 
> Regards,
> Nikolai

Hi,

I suggest that you try some mailing list(s) besides linux-kernel.
The MAINTAINERS file has these possibilities:

dmaengine@vger.kernel.org
iommu@lists.linux-foundation.org

or just try linux-mm@vger.kernel.org

-- 
~Randy
