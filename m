Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26ABC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C52D2464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLFQZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:25:01 -0500
Received: from relay.sw.ru ([185.231.240.75]:51332 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLFQYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:53 -0500
Received: from dhcp-172-16-25-5.sw.ru ([172.16.25.5])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1idGPM-00009W-8m; Fri, 06 Dec 2019 19:24:44 +0300
Subject: Re: [PATCH 2/3] kasan: use apply_to_existing_pages for releasing
 vmalloc shadow
To:     Daniel Axtens <dja@axtens.net>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     daniel@iogearbox.net, cai@lca.pw,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191205140407.1874-1-dja@axtens.net>
 <20191205140407.1874-2-dja@axtens.net>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <d3c4ae49-79d3-3641-947f-52926ffe877c@virtuozzo.com>
Date:   Fri, 6 Dec 2019 19:24:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191205140407.1874-2-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/19 5:04 PM, Daniel Axtens wrote:
> kasan_release_vmalloc uses apply_to_page_range to release vmalloc
> shadow. Unfortunately, apply_to_page_range can allocate memory to
> fill in page table entries, which is not what we want.
> 
> Also, kasan_release_vmalloc is called under free_vmap_area_lock,
> so if apply_to_page_range does allocate memory, we get a sleep in
> atomic bug:
> 
> 	BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
> 	in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15087, name:
> 
> 	Call Trace:
> 	 __dump_stack lib/dump_stack.c:77 [inline]
> 	 dump_stack+0x199/0x216 lib/dump_stack.c:118
> 	 ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
> 	 __might_sleep+0x95/0x190 kernel/sched/core.c:6753
> 	 prepare_alloc_pages mm/page_alloc.c:4681 [inline]
> 	 __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
> 	 alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
> 	 alloc_pages include/linux/gfp.h:532 [inline]
> 	 __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
> 	 __pte_alloc_one_kernel include/asm-generic/pgalloc.h:21 [inline]
> 	 pte_alloc_one_kernel include/asm-generic/pgalloc.h:33 [inline]
> 	 __pte_alloc_kernel+0x1d/0x200 mm/memory.c:459
> 	 apply_to_pte_range mm/memory.c:2031 [inline]
> 	 apply_to_pmd_range mm/memory.c:2068 [inline]
> 	 apply_to_pud_range mm/memory.c:2088 [inline]
> 	 apply_to_p4d_range mm/memory.c:2108 [inline]
> 	 apply_to_page_range+0x77d/0xa00 mm/memory.c:2133
> 	 kasan_release_vmalloc+0xa7/0xc0 mm/kasan/common.c:970
> 	 __purge_vmap_area_lazy+0xcbb/0x1f30 mm/vmalloc.c:1313
> 	 try_purge_vmap_area_lazy mm/vmalloc.c:1332 [inline]
> 	 free_vmap_area_noflush+0x2ca/0x390 mm/vmalloc.c:1368
> 	 free_unmap_vmap_area mm/vmalloc.c:1381 [inline]
> 	 remove_vm_area+0x1cc/0x230 mm/vmalloc.c:2209
> 	 vm_remove_mappings mm/vmalloc.c:2236 [inline]
> 	 __vunmap+0x223/0xa20 mm/vmalloc.c:2299
> 	 __vfree+0x3f/0xd0 mm/vmalloc.c:2356
> 	 __vmalloc_area_node mm/vmalloc.c:2507 [inline]
> 	 __vmalloc_node_range+0x5d5/0x810 mm/vmalloc.c:2547
> 	 __vmalloc_node mm/vmalloc.c:2607 [inline]
> 	 __vmalloc_node_flags mm/vmalloc.c:2621 [inline]
> 	 vzalloc+0x6f/0x80 mm/vmalloc.c:2666
> 	 alloc_one_pg_vec_page net/packet/af_packet.c:4233 [inline]
> 	 alloc_pg_vec net/packet/af_packet.c:4258 [inline]
> 	 packet_set_ring+0xbc0/0x1b50 net/packet/af_packet.c:4342
> 	 packet_setsockopt+0xed7/0x2d90 net/packet/af_packet.c:3695
> 	 __sys_setsockopt+0x29b/0x4d0 net/socket.c:2117
> 	 __do_sys_setsockopt net/socket.c:2133 [inline]
> 	 __se_sys_setsockopt net/socket.c:2130 [inline]
> 	 __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2130
> 	 do_syscall_64+0xfa/0x780 arch/x86/entry/common.c:294
> 	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Switch to using the apply_to_existing_pages helper instead, which
> won't allocate memory.
> 
> Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> Andrew, if you want to take this, it replaces
> "kasan: Don't allocate page tables in kasan_release_vmalloc()"
> ---
>  mm/kasan/common.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 


Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
