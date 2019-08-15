Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99BAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC802064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="t7BLZTw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfHOHgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:36:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35367 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729907AbfHOHgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:36:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 468JD30rcTz9tyg8;
        Thu, 15 Aug 2019 09:36:19 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=t7BLZTw6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HIJrNzoNiyNv; Thu, 15 Aug 2019 09:36:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 468JD26cH8z9tyg7;
        Thu, 15 Aug 2019 09:36:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1565854578; bh=mmIOgbK+JKM5jqW9/BcwHJtcKEwnCjuq52vwowq/M/k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=t7BLZTw6TKXeDRRYgbMR6vS0jqTejMQ0wIwScx/uyvfr8pfdY6az2/5oTQi+z4+ZE
         CpSYrQoZQBUgOU/dnXo/sdKOxHQSLtzmXCitW+lv81+sK/RC80tDwgXcaHPxmb8iLJ
         g3MRjTITtwC/83OVnsCL+nos7wM2M0at4qyt6Ssw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 09DCF8B782;
        Thu, 15 Aug 2019 09:36:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0xetyh4uG_O4; Thu, 15 Aug 2019 09:36:19 +0200 (CEST)
Received: from [192.168.232.53] (unknown [192.168.232.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 359E18B755;
        Thu, 15 Aug 2019 09:36:19 +0200 (CEST)
Subject: Re: [PATCH 4/6] powerpc: Chunk calls to flush_dcache_range in
 arch_*_memory
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190815041057.13627-1-alastair@au1.ibm.com>
 <20190815041057.13627-5-alastair@au1.ibm.com>
From:   christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <366f94bd-c61b-d454-b202-d3feb81a14c3@c-s.fr>
Date:   Thu, 15 Aug 2019 09:36:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190815041057.13627-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190814-8, 14/08/2019), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/08/2019 à 06:10, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> When presented with large amounts of memory being hotplugged
> (in my test case, ~890GB), the call to flush_dcache_range takes
> a while (~50 seconds), triggering RCU stalls.
> 
> This patch breaks up the call into 16GB chunks, calling
> cond_resched() inbetween to allow the scheduler to run.

Is 16GB small enough ? If 890GB takes 50s, 16GB still takes about 1s.
I'd use 1GB chuncks to remain below 100ms.

> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/mm/mem.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 5400da87a804..fb0d5e9aa11b 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -104,11 +104,14 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
>   	return -ENODEV;
>   }
>   
> +#define FLUSH_CHUNK_SIZE (16ull * 1024ull * 1024ull * 1024ull)

Can we use SZ_16GB ?

> +
>   int __ref arch_add_memory(int nid, u64 start, u64 size,
>   			struct mhp_restrictions *restrictions)
>   {
>   	unsigned long start_pfn = start >> PAGE_SHIFT;
>   	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	unsigned long i;
>   	int rc;
>   
>   	resize_hpt_for_hotplug(memblock_phys_mem_size());
> @@ -120,7 +123,11 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>   			start, start + size, rc);
>   		return -EFAULT;
>   	}
> -	flush_dcache_range(start, start + size);
> +
> +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> +		flush_dcache_range(start + i, min(start + size, start + i + FLUSH_CHUNK_SIZE));

Isn't the line a bit long (I have not checked).

> +		cond_resched();
> +	}
>   
>   	return __add_pages(nid, start_pfn, nr_pages, restrictions);
>   }
> @@ -131,13 +138,18 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
>   	unsigned long start_pfn = start >> PAGE_SHIFT;
>   	unsigned long nr_pages = size >> PAGE_SHIFT;
>   	struct page *page = pfn_to_page(start_pfn) + vmem_altmap_offset(altmap);
> +	unsigned long i;
>   	int ret;
>   
>   	__remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
>   
>   	/* Remove htab bolted mappings for this section of memory */
>   	start = (unsigned long)__va(start);
> -	flush_dcache_range(start, start + size);
> +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> +		flush_dcache_range(start + i, min(start + size, start + i + FLUSH_CHUNK_SIZE));
> +		cond_resched();
> +	}
> +
>   	ret = remove_section_mapping(start, start + size);
>   	WARN_ON_ONCE(ret);
>   
> 

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus

