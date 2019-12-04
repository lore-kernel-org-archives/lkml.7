Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26AEDC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F00206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 20:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfLDUql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 15:46:41 -0500
Received: from relay.sw.ru ([185.231.240.75]:50584 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727911AbfLDUql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 15:46:41 -0500
Received: from [192.168.15.5]
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1icbXh-0001mE-UP; Wed, 04 Dec 2019 23:46:38 +0300
Subject: Re: [PATCH] kasan: support vmalloc backing of vm_map_ram()
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     Qian Cai <cai@lca.pw>
References: <20191129154519.30964-1-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <cac9cbcf-4286-ae34-d150-79ea81a366b0@virtuozzo.com>
Date:   Wed, 4 Dec 2019 23:44:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191129154519.30964-1-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/19 6:45 PM, Daniel Axtens wrote:
> @@ -1826,7 +1842,15 @@ void *vm_map_ram(struct page **pages, unsigned int count, int node, pgprot_t pro
>  
>  		addr = va->va_start;
>  		mem = (void *)addr;
> +
> +		if (kasan_populate_vmalloc_area(size, mem)) {
> +			vm_unmap_ram(mem, count);
> +			return NULL;
> +		}
>  	}
> +
> +	kasan_unpoison_shadow(mem, size);
> +

This probably gonna explode on CONFIG_KASAN=y && CONFIG_KASAN_VMALLOC=n

I've sent alternative patch which fixes vm_map_ram() and also makes the code a bit easier to follow in my opinion.

>  	if (vmap_page_range(addr, addr + size, prot, pages) < 0) {
>  		vm_unmap_ram(mem, count);
>  		return NULL;
> 
