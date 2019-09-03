Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3F9C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADC7215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MLogrkjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfICGTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:19:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18832 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfICGTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:19:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46Mxcq0v7nzB09ZC;
        Tue,  3 Sep 2019 08:19:39 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=MLogrkjT; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id q27xp8ZHa-je; Tue,  3 Sep 2019 08:19:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46Mxcp6v03z9vBnX;
        Tue,  3 Sep 2019 08:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567491579; bh=vpywQY0jhYCtLj16pKTZzrclmKJxpqH5sO++tsorcW0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MLogrkjT5XOSI5cZayVsFTMCcSoCuHf36ABgH/ikEzCiH2/FPIB9FWVSFOLz4UQhK
         HSIteJrIO9Uh4EL7RssqI+2ia25i4v8EQDp/PA3dj2u+1a9/I0BLYTsE+NwQuxa9t0
         D7v7bsXUQULUZAhTwvluxL9d+EpRFhNrNed6e3jg=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D15A28B7A3;
        Tue,  3 Sep 2019 08:19:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xkPFnxZYp08y; Tue,  3 Sep 2019 08:19:39 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A71078B761;
        Tue,  3 Sep 2019 08:19:38 +0200 (CEST)
Subject: Re: [PATCH v2 4/6] powerpc: Chunk calls to flush_dcache_range in
 arch_*_memory
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qian Cai <cai@lca.pw>, Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190903052407.16638-1-alastair@au1.ibm.com>
 <20190903052407.16638-5-alastair@au1.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3bde4dbc-5176-0df5-a0bf-993eef2a333b@c-s.fr>
Date:   Tue, 3 Sep 2019 08:19:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903052407.16638-5-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/09/2019 à 07:23, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> When presented with large amounts of memory being hotplugged
> (in my test case, ~890GB), the call to flush_dcache_range takes
> a while (~50 seconds), triggering RCU stalls.
> 
> This patch breaks up the call into 1GB chunks, calling
> cond_resched() inbetween to allow the scheduler to run.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/mm/mem.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index cd540123874d..854aaea2c6ae 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -104,11 +104,14 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
>   	return -ENODEV;
>   }
>   
> +#define FLUSH_CHUNK_SIZE SZ_1G

Maybe the name is a bit long for a local define. See if we could reduce 
code line splits below by shortening this name.

> +
>   int __ref arch_add_memory(int nid, u64 start, u64 size,
>   			struct mhp_restrictions *restrictions)
>   {
>   	unsigned long start_pfn = start >> PAGE_SHIFT;
>   	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	u64 i;
>   	int rc;
>   
>   	resize_hpt_for_hotplug(memblock_phys_mem_size());
> @@ -120,7 +123,12 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>   			start, start + size, rc);
>   		return -EFAULT;
>   	}
> -	flush_dcache_range(start, start + size);
> +
> +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> +		flush_dcache_range(start + i,
> +				   min(start + size, start + i + FLUSH_CHUNK_SIZE));

My eyes don't like it.

What about
	for (; i < size; i += FLUSH_CHUNK_SIZE) {
		int len = min(size - i, FLUSH_CHUNK_SIZE);

		flush_dcache_range(start + i, start + i + len);
		cond_resched();
	}

or

	end = start + size;
	for (; start < end; start += FLUSH_CHUNK_SIZE, size -= FLUSH_CHUNK_SIZE) {
		int len = min(size, FLUSH_CHUNK_SIZE);

		flush_dcache_range(start, start + len);
		cond_resched();
	}

> +		cond_resched();
> +	}
>   
>   	return __add_pages(nid, start_pfn, nr_pages, restrictions);
>   }
> @@ -131,13 +139,19 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
>   	unsigned long start_pfn = start >> PAGE_SHIFT;
>   	unsigned long nr_pages = size >> PAGE_SHIFT;
>   	struct page *page = pfn_to_page(start_pfn) + vmem_altmap_offset(altmap);
> +	u64 i;
>   	int ret;
>   
>   	__remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
>   
>   	/* Remove htab bolted mappings for this section of memory */
>   	start = (unsigned long)__va(start);
> -	flush_dcache_range(start, start + size);
> +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> +		flush_dcache_range(start + i,
> +				   min(start + size, start + i + FLUSH_CHUNK_SIZE));
> +		cond_resched();
> +	}
> +

This piece of code looks pretty similar to the one before. Can we 
refactor into a small helper ?

>   	ret = remove_section_mapping(start, start + size);
>   	WARN_ON_ONCE(ret);
>   
> 

Christophe
