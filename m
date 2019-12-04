Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30C7C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702A52077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575498179;
	bh=xu5fRs2BjQuoKaF211fLwgk9jK1HqBNUwBTkTbdDXUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D7IEKGrXMwb5VlmX/ap/yIuyc4/ZOdpiBOj9+iXLa7kN4NBmpjlAXxKBRLmSgfLqe
	 4HJDwEFenvbHZsPZM3ilZ/LzMdAVWCb3/oRghT4zVmeIdwMOgkKbX5Pxct+uczdv8N
	 2FaYV+waXMCJ24OYkej8KCHLfItcM1Tg/qbrYdAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfLDWW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:22:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfLDWW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:22:58 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE40E2073C;
        Wed,  4 Dec 2019 22:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575498177;
        bh=xu5fRs2BjQuoKaF211fLwgk9jK1HqBNUwBTkTbdDXUM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JT5/M9L4Mhmay7liKuA1o9Gcitjzu2T60T5e3jqOuE/mwxqOHk3wOf2UInxPHQ/G5
         w08Yz3NJ8xDhHYXGTiNyy+j14XGVwRnRfUzJESFtOvM0OK8bFrRvELIkuOFvo5DPbd
         +6JsR8+BziehqLqj5tRBDgeto4ADB9cug69N4UJA=
Date:   Wed, 4 Dec 2019 14:22:56 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Daniel Axtens <dja@axtens.net>, Qian Cai <cai@lca.pw>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kasan: Don't allocate page tables in
 kasan_release_vmalloc()
Message-Id: <20191204142256.567b143cfde572acd804544a@linux-foundation.org>
In-Reply-To: <20191204204534.32202-2-aryabinin@virtuozzo.com>
References: <20191204204534.32202-1-aryabinin@virtuozzo.com>
        <20191204204534.32202-2-aryabinin@virtuozzo.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Dec 2019 23:45:34 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:

> The purpose of kasan_release_vmalloc() is to unmap and deallocate shadow
> memory. The usage of apply_to_page_range() isn't suitable in that scenario
> because it allocates pages to fill missing page tables entries.
> This also cause sleep in atomic bug:
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

Why is this warning happening?  Some lock held?  If so, which one?

> Add kasan_unmap_page_range() which skips empty page table entries instead
> of allocating them.

Adding an open-coded range walker is unfortunate.  Did you consider
generalizing apply_to_page_range() for this purpose?  I did - it looks
messy.

Somewhat.  I guess adding another arg to
apply_to_p4d_range...apply_to_pte_range wouldn't kill us.  I wonder if
there would be other sites which could utilize the additional control.


