Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE30C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2D20820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VEq8SZAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbfGNRBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:01:33 -0400
Received: from forward101p.mail.yandex.net ([77.88.28.101]:50246 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728125AbfGNRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:01:32 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jul 2019 13:01:30 EDT
Received: from mxback5o.mail.yandex.net (mxback5o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1f])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 2F82A3280D8B
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 19:54:16 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback5o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 4BRNafBjMb-sGgm69dn;
        Sun, 14 Jul 2019 19:54:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1563123256;
        bh=e3qMdJIOrOmT55OEcJgtiuTqksffCaD+4hyyfkqsY38=;
        h=Subject:To:From:Date:Message-ID;
        b=VEq8SZAa0rmRhrFZewjwa/96nHx8t0l78gyG69RDafwAi+OJtFt2bpEDFp7cJ98ZX
         lzZxzims06Y++U6F8roIKwL5VgxwzNUfMFYCHyb+VBc5zSxhNiNZRVwtv0JW4yHFXK
         QM8QZWUgicUkYYXVL7k08fuKlieQ1V95w1UpG8i4=
Authentication-Results: mxback5o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QY7EPq4G19-sF6KsX9Y;
        Sun, 14 Jul 2019 19:54:15 +0300
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (Client certificate not present)
Message-ID: <5D2B6126.7080700@yandex.ru>
Date:   Sun, 14 Jul 2019 20:06:46 +0300
From:   Nikolai Zhubr <n-a-zhubr@yandex.ru>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
MIME-Version: 1.0
To:     linux-kernel@vger.kernel.org
Subject: Correct use of DMA api (Some newbie questions)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After reading some (apparently contradictory) revisions of DMA api 
references in Documentation/DMA-*.txt, some (contradictory) discussions 
thereof, and even digging through the in-tree drivers in search for a 
good enlightening example, still I have to ask for advice.

I'm crafting a tiny driver (or rather, a kernel-mode helper) for a very 
special PCIe device. And actually it does work already, but performs 
differenly on different kernels. I'm targeting x86 (i686) only (although 
preferrably the driver should stay platform-neutral) and I need to 
support kernels 4.9+. Due to how the device is designed and used, very 
little has to be done in kernel space. The device has large internal 
memory, which accumulates some measurement data, and it is capable of 
transferring it to the host using DMA (with at least 32-bit address 
space available). Arranging memory for DMA is pretty much the only thing 
that userspace can not reasonably do, so this needs to be in the driver. 
So my currenly attempted layout is as follows:

1. In the (kernel-mode) driver, allocate large contiguous block of 
physical memory to do DMA into. It will be later reused several times. 
This block does not need to have a kernel-mode virtual address because 
it will never be accessed from the driver directly. The block size is 
typically 128M and I use CMA=256M. Currently I use dma_alloc_coherent(), 
but I'm not convinced it really needs to be a strictly coherent memory, 
for performance reasons, see below. Also, AFAICS on x86 
dma_alloc_coherent() always creates a kernel address mapping anyway, so 
maybe I'd better simply kalloc() with subsequent dma_map_single()?

2. Upon DMA completion (from device to host), some sort of 
barrier/synchronization might be necessary (to be safe WRT speculative 
loads, cache, etc), like dma_cache_sync() or dma_sync_single_for_cpu(), 
however the latter looks like a nop for x86 AFAICS, and the former is 
apparently flush_write_buffers() which is not very involved either (asm 
lock; nop) and does not look usefull for my case. Currentlly, I do not 
use any, and it seems like OK, maybe by pure luck. So, is it so 
trivially simple on x86 or am I just missing something horribly big here?

3. mmap this buffer for userspace. Reading from it should be as fast as 
possible, therefore this block AFAICS should be cacheble (and 
prefetchable and whatever else for better performance), at least from 
userspace context. It is not quite clear if such properties would depend 
on block allocation method (in step 1 above) or just on remapping 
attributes only. Currently, for mmap I employ dma_mmap_coherent(), but 
it seems also possible to use remap_pfn_range(), and also change 
vm_page_prot somewhat. I've already found that e.g. pgprot_noncached 
hurts performance quite a lot, but supposedly without it some DMA 
barrier (step 2 above) seems still necessary?

Any hints greatly appreciated,

Regards,
Nikolai
