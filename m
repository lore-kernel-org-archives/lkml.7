Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1277ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AED2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403792AbfJ2RVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:21:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:57476 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390793AbfJ2RVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:21:30 -0400
Received: from [172.16.25.5]
        by relay.sw.ru with esmtp (Exim 4.92.2)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1iPVBI-0006h5-VT; Tue, 29 Oct 2019 20:21:21 +0300
Subject: Re: [PATCH v10 4/5] x86/kasan: support KASAN_VMALLOC
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, x86@kernel.org, glider@google.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, dvyukov@google.com, christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191029042059.28541-1-dja@axtens.net>
 <20191029042059.28541-5-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <a144eaca-d7e1-1a18-5975-bd0bfdb9450e@virtuozzo.com>
Date:   Tue, 29 Oct 2019 20:21:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029042059.28541-5-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/29/19 7:20 AM, Daniel Axtens wrote:
> In the case where KASAN directly allocates memory to back vmalloc
> space, don't map the early shadow page over it.
> 
> We prepopulate pgds/p4ds for the range that would otherwise be empty.
> This is required to get it synced to hardware on boot, allowing the
> lower levels of the page tables to be filled dynamically.
> 
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---

> +static void __init kasan_shallow_populate_pgds(void *start, void *end)
> +{
> +	unsigned long addr, next;
> +	pgd_t *pgd;
> +	void *p;
> +	int nid = early_pfn_to_nid((unsigned long)start);

This doesn't make sense. start is not even a pfn. With linear mapping 
we try to identify nid to have the shadow on the same node as memory. But 
in this case we don't have memory or the corresponding shadow (yet),
we only install pgd/p4d.
I guess we could just use NUMA_NO_NODE.

The rest looks ok, so with that fixed:

Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>



