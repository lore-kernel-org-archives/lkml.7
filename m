Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB09ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF15B20650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730479AbfJNIg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:36:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbfJNIg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:36:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC5D7859FB;
        Mon, 14 Oct 2019 08:36:27 +0000 (UTC)
Received: from [10.36.117.10] (ovpn-117-10.ams2.redhat.com [10.36.117.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75249600C6;
        Mon, 14 Oct 2019 08:36:25 +0000 (UTC)
Subject: Re: [PATCH v2] mm/page_owner: Don't access uninitialized memmaps when
 reading /proc/pagetypeinfo
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20191011140638.8160-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <56134a52-6113-c501-395f-30eb53b1408d@redhat.com>
Date:   Mon, 14 Oct 2019 10:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011140638.8160-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 14 Oct 2019 08:36:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.19 16:06, David Hildenbrand wrote:
> From: Qian Cai <cai@lca.pw>
> 
> Uninitialized memmaps contain garbage and in the worst case trigger
> kernel BUGs, especially with CONFIG_PAGE_POISONING. They should not get
> touched.
> 
> For example, when not onlining a memory block that is spanned by a zone
> and reading /proc/pagetypeinfo with CONFIG_DEBUG_VM_PGFLAGS and
> CONFIG_PAGE_POISONING, we can trigger a kernel BUG:
> 
> :/# echo 1 > /sys/devices/system/memory/memory40/online
> :/# echo 1 > /sys/devices/system/memory/memory42/online
> :/# cat /proc/pagetypeinfo > test.file
>    [   42.489856] page:fffff2c585200000 is uninitialized and poisoned
>    [   42.489861] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
>    [   42.492235] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
>    [   42.493501] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>    [   42.494533] There is not page extension available.
>    [   42.495358] ------------[ cut here ]------------
>    [   42.496163] kernel BUG at include/linux/mm.h:1107!
>    [   42.497069] invalid opcode: 0000 [#1] SMP NOPTI
> 
> Please not that this change does not affect ZONE_DEVICE, because
> pagetypeinfo_showmixedcount_print() is called from
> mm/vmstat.c:pagetypeinfo_showmixedcount() only for populated zones, and
> ZONE_DEVICE is never populated (zone->present_pages always 0).
> 
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
> Signed-off-by: Qian Cai <cai@lca.pw>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Miles Chen <miles.chen@mediatek.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [ move check to outer loop, add comment, rephrase description ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Cai asked me to follow up on:
> 	[PATCH] mm/page_owner: fix a crash after memory offline
> 
> ---
>   mm/page_owner.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index dee931184788..7d149211f6be 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -284,7 +284,8 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>   	 * not matter as the mixed block count will still be correct
>   	 */
>   	for (; pfn < end_pfn; ) {
> -		if (!pfn_valid(pfn)) {
> +		page = pfn_to_online_page(pfn);
> +		if (!page) {
>   			pfn = ALIGN(pfn + 1, MAX_ORDER_NR_PAGES);
>   			continue;
>   		}
> @@ -292,13 +293,13 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>   		block_end_pfn = ALIGN(pfn + 1, pageblock_nr_pages);
>   		block_end_pfn = min(block_end_pfn, end_pfn);
>   
> -		page = pfn_to_page(pfn);
>   		pageblock_mt = get_pageblock_migratetype(page);
>   
>   		for (; pfn < block_end_pfn; pfn++) {
>   			if (!pfn_valid_within(pfn))
>   				continue;
>   
> +			/* The pageblock is online, no need to recheck. */
>   			page = pfn_to_page(pfn);
>   
>   			if (page_zone(page) != zone)
> 

I guess it's best to just

Cc: stable@vger.kernel.org # v4.13+

here as well. Can be cheery-picked.

@Andrew, can you add that?

-- 

Thanks,

David / dhildenb
