Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB08C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239FB20640
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfJJSzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfJJSzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:55:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC12A30224AA;
        Thu, 10 Oct 2019 18:55:43 +0000 (UTC)
Received: from [10.36.116.80] (ovpn-116-80.ams2.redhat.com [10.36.116.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6BDA85C660;
        Thu, 10 Oct 2019 18:55:42 +0000 (UTC)
Subject: Re: [PATCH] mm/page_owner: fix a crash after memory offline
To:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "mhocko@suse.com" <mhocko@suse.com>
References: <1570732366-16426-1-git-send-email-cai@lca.pw>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <2e36a929-0fc7-d32a-d838-de746ff071fc@redhat.com>
Date:   Thu, 10 Oct 2019 20:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1570732366-16426-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 10 Oct 2019 18:55:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.10.19 20:32, Qian Cai wrote:
> The linux-next series "mm/memory_hotplug: Shrink zones before removing
> memory" [1] seems make a crash easier to reproduce while reading
> /proc/pagetypeinfo after offlining a memory section. Fix it by using
> pfn_to_online_page() in the PFN walker.

Can you please rephrase the subject+description to describe the actual 
problem and drop the reference to the series?

E.g., similar to my recent patches:

"mm/page_owner: Don't access uninitialized memmaps when reading 
/proc/pagetypeinfo

Uninitialized memmaps contain garbage and in the worst case trigger 
kernel BUGs, especially with CONFIG_PAGE_POISONING. They should not get
touched.

For example, when not onlining a memory block that is spanned by a zone 
and reading /proc/pagetypeinfo, we can trigger a kernel BUG: ...
"

However, you also have to justify why it is okay to no longer consider 
ZONE_DEVICE (I think walk_zones_in_node() will skip ZONE_DEVICE due to 
assert_populated == true and ZONE_DEVICE will never be populated, 
Therefore, we will never end in this code path with ZONE_DEVICE).


> 
> [1] https://lore.kernel.org/linux-mm/20191006085646.5768-1-david@redhat.com/
> 
> page:ffffea0021200000 is uninitialized and poisoned
> raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> There is not page extension available.
> ------------[ cut here ]------------
> kernel BUG at include/linux/mm.h:1107!
> RIP: 0010:pagetypeinfo_showmixedcount_print+0x4fb/0x680
> Call Trace:
>   walk_zones_in_node+0x3a/0xc0
>   pagetypeinfo_show+0x260/0x2c0
>   seq_read+0x27e/0x710
>   proc_reg_read+0x12e/0x190
>   __vfs_read+0x50/0xa0
>   vfs_read+0xcb/0x1e0
>   ksys_read+0xc6/0x160
>   __x64_sys_read+0x43/0x50
>   do_syscall_64+0xcc/0xaec
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   mm/page_owner.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index dee931184788..03a6b19b3cdd 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -296,11 +296,10 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>   		pageblock_mt = get_pageblock_migratetype(page);
>   

What about the pfn_valid() in the outermost loop? You can skip over the 
whole pageblock if the first page is not online.

>   		for (; pfn < block_end_pfn; pfn++) {
> -			if (!pfn_valid_within(pfn))
> +			page = pfn_to_online_page(pfn);
> +			if (!page)
>   				continue;
>   
> -			page = pfn_to_page(pfn);
> -
>   			if (page_zone(page) != zone)
>   				continue;
>   
> 


-- 

Thanks,

David / dhildenb
