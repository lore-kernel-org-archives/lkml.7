Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA76C606D2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD209205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfGHWxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:53:17 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:32914 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727107AbfGHWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:53:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TWPu3JF_1562626390;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TWPu3JF_1562626390)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Jul 2019 06:53:13 +0800
Subject: Re: [PATCH 2/2 -mm] mm: account lazy free pages into available memory
To:     rientjes@google.com, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1561655524-89276-1-git-send-email-yang.shi@linux.alibaba.com>
 <1561655524-89276-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <18a6c461-5300-34ec-3a0f-266c72a2733b@linux.alibaba.com>
Date:   Mon, 8 Jul 2019 15:53:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1561655524-89276-2-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And how about this one?


On 6/27/19 10:12 AM, Yang Shi wrote:
> Available memory is one of the most important metrics for memory
> pressure.  Currently, lazy free pages are not accounted into available
> memory, but they are reclaimable actually, like reclaimable slabs.
>
> Accounting lazy free pages into available memory should reflect the real
> memory pressure status, and also would help administrators and/or other
> high level scheduling tools make better decision.
>
> The /proc/meminfo would show more available memory with test which
> creates ~1GB deferred split THP.
>
> Before:
> MemAvailable:   43544272 kB
> ...
> AnonHugePages:     10240 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> LazyFreePages:   1046528 kB
>
> After:
> MemAvailable:   44415124 kB
> ...
> AnonHugePages:      6144 kB
> ShmemHugePages:        0 kB
> ShmemPmdMapped:        0 kB
> LazyFreePages:   1046528 kB
>
> MADV_FREE pages are not accounted for NR_LAZYFREE since they have been
> put on inactive file LRU and accounted into available memory.
> Accounting here would double account them.
>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>   mm/page_alloc.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index cab50e8..58ceca5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5005,6 +5005,7 @@ long si_mem_available(void)
>   	unsigned long wmark_low = 0;
>   	unsigned long pages[NR_LRU_LISTS];
>   	unsigned long reclaimable;
> +	unsigned long lazyfree;
>   	struct zone *zone;
>   	int lru;
>   
> @@ -5038,6 +5039,10 @@ long si_mem_available(void)
>   			global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE);
>   	available += reclaimable - min(reclaimable / 2, wmark_low);
>   
> +	/* Lazyfree pages are reclaimable when memory pressure is hit */
> +	lazyfree = global_node_page_state(NR_LAZYFREE);
> +	available += lazyfree - min(lazyfree / 2, wmark_low);
> +
>   	if (available < 0)
>   		available = 0;
>   	return available;

