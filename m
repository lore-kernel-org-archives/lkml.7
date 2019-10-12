Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D0CC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06807206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 10:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfJLKcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 06:32:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53830 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfJLKaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 06:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3AE6B5BE;
        Sat, 12 Oct 2019 10:30:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 12 Oct 2019 12:30:48 +0200
From:   osalvador <osalvador@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        owner-linux-mm@kvack.org
Subject: Re: memory offline infinite loop after soft offline
In-Reply-To: <1570829564.5937.36.camel@lca.pw>
References: <1570829564.5937.36.camel@lca.pw>
Message-ID: <55ff76d109062a87fb209ecddf167b71@suse.de>
X-Sender: osalvador@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-11 23:32, Qian Cai wrote:
> # /opt/ltp/runtest/bin/move_pages12
> move_pages12.c:263: INFO: Free RAM 258988928 kB
> move_pages12.c:281: INFO: Increasing 2048kB hugepages pool on node 0 to 
> 4
> move_pages12.c:291: INFO: Increasing 2048kB hugepages pool on node 8 to 
> 4
> move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 0
> move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 8
> move_pages12.c:197: PASS: Bug not reproduced
> move_pages12.c:197: PASS: Bug not reproduced
> 
> for mem in $(ls -d /sys/devices/system/memory/memory*); do
>         echo offline > $mem/state
>         echo online > $mem/state
> done
> 
> That LTP move_pages12 test will first madvise(MADV_SOFT_OFFLINE) for a 
> range.
> Then, one of "echo offline" will trigger an infinite loop in 
> __offline_pages()
> here,


I did not deeply check whether this issue is really related 
soft-offline.

As is, soft-offline has a few issues that can lead to tricky problems.
Actually, lately I have received quite a few reports from customers 
where testing soft-offline
resulted in applications crashing all around.

I am working on a re-implementation to fix those issues [1].
I yet have to fix a bug I found yesterday though, but it should be quite 
trivial to fix it up, so I should be able to send a new re-spin next 
week.

[1] https://lore.kernel.org/patchwork/cover/1126173/

Thanks

> 
> 		/* check again */
> 		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
> 					    NULL, check_pages_isolated_cb);
> 	} while (ret);
> 
> because check_pages_isolated_cb() always return -EBUSY from
> test_pages_isolated(),
> 
> 
> 	pfn = __test_page_isolated_in_pageblock(start_pfn, end_pfn,
> 						skip_hwpoisoned_pages);
>         ...
>         return pfn < end_pfn ? -EBUSY : 0;
> 
> The root cause is in __test_page_isolated_in_pageblock() where "pfn" is 
> always
> less than "end_pfn" because the associated page is not a PageBuddy.
> 
> 	while (pfn < end_pfn) {
> 	...
> 		else
> 			break;
> 
> 	return pfn;
> 
> Adding a dump_page() for that pfn shows,
> 
> [  101.665160][ T8885] pfn = 77501, end_pfn = 78000
> [  101.665245][ T8885] page:c00c000001dd4040 refcount:0 mapcount:0
> mapping:0000000000000000 index:0x0
> [  101.665329][ T8885] flags: 0x3fffc000000000()
> [  101.665391][ T8885] raw: 003fffc000000000 0000000000000000 
> ffffffff01dd0500
> 0000000000000000
> [  101.665498][ T8885] raw: 0000000000000000 0000000000000000 
> 00000000ffffffff
> 0000000000000000
> [  101.665588][ T8885] page dumped because: soft_offline
> [  101.665639][ T8885] page_owner tracks the page as freed
> [  101.665697][ T8885] page last allocated via order 5, migratetype 
> Movable,
> gfp_mask
> 0x346cca(GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_
> THISNODE)
> [  101.665924][ T8885]  prep_new_page+0x3c0/0x440
> [  101.665962][ T8885]  get_page_from_freelist+0x2568/0x2bb0
> [  101.666059][ T8885]  __alloc_pages_nodemask+0x1b4/0x670
> [  101.666115][ T8885]  alloc_fresh_huge_page+0x244/0x6e0
> [  101.666183][ T8885]  alloc_migrate_huge_page+0x30/0x70
> [  101.666254][ T8885]  alloc_new_node_page+0xc4/0x380
> [  101.666325][ T8885]  migrate_pages+0x3b4/0x19e0
> [  101.666375][ T8885]  do_move_pages_to_node.isra.29.part.30+0x44/0xa0
> [  101.666464][ T8885]  kernel_move_pages+0x498/0xfc0
> [  101.666520][ T8885]  sys_move_pages+0x28/0x40
> [  101.666643][ T8885]  system_call+0x5c/0x68
> [  101.666665][ T8885] page last free stack trace:
> [  101.666704][ T8885]  __free_pages_ok+0xa4c/0xd40
> [  101.666773][ T8885]  update_and_free_page+0x2dc/0x5b0
> [  101.666821][ T8885]  free_huge_page+0x2dc/0x740
> [  101.666875][ T8885]  __put_compound_page+0x64/0xc0
> [  101.666926][ T8885]  putback_active_hugepage+0x228/0x390
> [  101.666990][ T8885]  migrate_pages+0xa78/0x19e0
> [  101.667048][ T8885]  soft_offline_page+0x314/0x1050
> [  101.667117][ T8885]  sys_madvise+0x1068/0x1080
> [  101.667185][ T8885]  system_call+0x5c/0x68

