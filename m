Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DB7C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7091F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfJNIld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:41:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbfJNIlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:41:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7727C10CC1F7;
        Mon, 14 Oct 2019 08:41:32 +0000 (UTC)
Received: from [10.36.117.10] (ovpn-117-10.ams2.redhat.com [10.36.117.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A62A5D6A3;
        Mon, 14 Oct 2019 08:41:31 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] mm/memory-failure.c: Don't access uninitialized
 memmaps in memory_failure()
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20191009142435.3975-1-david@redhat.com>
 <20191009142435.3975-3-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1c61f433-74a0-73ca-0a8b-9ac7252ec6f8@redhat.com>
Date:   Mon, 14 Oct 2019 10:41:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191009142435.3975-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Mon, 14 Oct 2019 08:41:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.19 16:24, David Hildenbrand wrote:
> We should check for pfn_to_online_page() to not access uninitialized
> memmaps. Reshuffle the code so we don't have to duplicate the error
> message.
> 
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/memory-failure.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 7ef849da8278..e866e6e5660b 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1253,17 +1253,19 @@ int memory_failure(unsigned long pfn, int flags)
>   	if (!sysctl_memory_failure_recovery)
>   		panic("Memory failure on page %lx", pfn);
>   
> -	if (!pfn_valid(pfn)) {
> +	p = pfn_to_online_page(pfn);
> +	if (!p) {
> +		if (pfn_valid(pfn)) {
> +			pgmap = get_dev_pagemap(pfn, NULL);
> +			if (pgmap)
> +				return memory_failure_dev_pagemap(pfn, flags,
> +								  pgmap);
> +		}
>   		pr_err("Memory failure: %#lx: memory outside kernel control\n",
>   			pfn);
>   		return -ENXIO;
>   	}
>   
> -	pgmap = get_dev_pagemap(pfn, NULL);
> -	if (pgmap)
> -		return memory_failure_dev_pagemap(pfn, flags, pgmap);
> -
> -	p = pfn_to_page(pfn);
>   	if (PageHuge(p))
>   		return memory_failure_hugetlb(pfn, flags);
>   	if (TestSetPageHWPoison(p)) {
> 

@Andrew, can you add

Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319

And

Cc: stable@vger.kernel.org # v4.13+

The stable backports won't be clean cherry-picks AFAIKS, but do-able.

-- 

Thanks,

David / dhildenb
