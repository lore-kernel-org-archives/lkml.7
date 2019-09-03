Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBA6C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B039C20882
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="jSi/qWON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfICGXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:23:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2208 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfICGXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:23:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46MxjD5f4jzB09ZG;
        Tue,  3 Sep 2019 08:23:28 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=jSi/qWON; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yI4Wk4yYjcQ6; Tue,  3 Sep 2019 08:23:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46MxjD4JnLzB09ZC;
        Tue,  3 Sep 2019 08:23:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1567491808; bh=3rMEla0IRyGqnTbAGeQB90lkVJ6wbzqtAr9Y3HR5NO4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jSi/qWONxHtO6HDsgkiglSSzPgvKuGVlatFhk3N+t6KuTIsZ6seRgJoCkVKpYasUg
         N24RMQnqqTSMkdU0MqAwYjX9ArNBNR87dD5imn8hOwLcyc4bgyIoKiople5dcIQFoU
         twlrhgP2nLDU1Ja5a8HaVQJYWX+lz3bs6VpgwCZI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B0B58B7A3;
        Tue,  3 Sep 2019 08:23:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7Kxqw9KkM_4J; Tue,  3 Sep 2019 08:23:29 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 80AC28B761;
        Tue,  3 Sep 2019 08:23:28 +0200 (CEST)
Subject: Re: [PATCH v2 6/6] powerpc: Don't flush caches when adding memory
To:     Alastair D'Silva <alastair@au1.ibm.com>, alastair@d-silva.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190903052407.16638-1-alastair@au1.ibm.com>
 <20190903052407.16638-7-alastair@au1.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <e6713f8a-6465-f9fe-40e9-91d52aa06195@c-s.fr>
Date:   Tue, 3 Sep 2019 08:23:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903052407.16638-7-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/09/2019 à 07:24, Alastair D'Silva a écrit :
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> This operation takes a significant amount of time when hotplugging
> large amounts of memory (~50 seconds with 890GB of persistent memory).
> 
> This was orignally in commit fb5924fddf9e
> ("powerpc/mm: Flush cache on memory hot(un)plug") to support memtrace,
> but the flush on add is not needed as it is flushed on remove.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>   arch/powerpc/mm/mem.c | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 854aaea2c6ae..2a14b5b93e19 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -111,7 +111,6 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>   {
>   	unsigned long start_pfn = start >> PAGE_SHIFT;
>   	unsigned long nr_pages = size >> PAGE_SHIFT;
> -	u64 i;
>   	int rc;
>   
>   	resize_hpt_for_hotplug(memblock_phys_mem_size());
> @@ -124,12 +123,6 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>   		return -EFAULT;
>   	}
>   
> -	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> -		flush_dcache_range(start + i,
> -				   min(start + size, start + i + FLUSH_CHUNK_SIZE));
> -		cond_resched();
> -	}
> -

So you are removing the code you added in patch 4. Why not move this one 
before patch 4 ?

>   	return __add_pages(nid, start_pfn, nr_pages, restrictions);
>   }
>   
> 

Christophe
