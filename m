Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934D5C2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C42122525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="HyowXUY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfLEOET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:04:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39317 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEOET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:04:19 -0500
Received: by mail-pl1-f193.google.com with SMTP id o9so1298591plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrl6fsIQIcheAl6pCi+n0PQV4bZosMoozWNraf35XNA=;
        b=HyowXUY/2pXTcknCfKms4yOpx0iCfvrspxJVzVRocIfYTBjLCnFCphoYiXoWPX6yvF
         jQ67TkGT/xU3cdj4zz0GVl92Of4SAIAEy0/cKsKO25T5h7btdVXy1OC/tMhciawvwBa1
         Fwq6o2VQhWPR+gOHSJyR/SmxXvbiY7yGBDRDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrl6fsIQIcheAl6pCi+n0PQV4bZosMoozWNraf35XNA=;
        b=cZe6zGyd5WckzH6S/1kXsAcI11AMYx5EB+hF4GhDIi4is76C3V34FdLGwVoJ9aLQOt
         ijpZWSG1+sBV8tTR+ayOnrA0R7CbJttMn7h9jHMTx8B6ckV7j/mVdW9GSc6P+fe41kzl
         NO/AGwwzqCcG18DaJ+dbCYP1Uxe+clafAekjOVAtAUj7sSL4sKSLqw55YptApWxtGVNy
         XhHqe0VihxC0nhNcEOrGjbacSNaJZfvpKD9M2pgUctPAF3v8KybPX1auSaxwyAZqQwdM
         fadICoRh9BLfOc5FjBa3P0Es/2nSbxTr2ZxNz3MVJZiGW4FIJwssfX/+g5qfSGvvRIht
         rlLw==
X-Gm-Message-State: APjAAAXtHzHp+4Umx7ohdchVOCNuN7vIqvjMLrmsPxxNJ10OeKt0ArBK
        Ui7gZfEuz5v4Ol822DAu71HYMQ==
X-Google-Smtp-Source: APXvYqy1JVUw91MEUMOG+zxi2L3sQWgyNeoYhYioWFiY802l6CyXb7i+PsveBap/gGjV3yI85fV1cQ==
X-Received: by 2002:a17:90a:a881:: with SMTP id h1mr9398250pjq.50.1575554657418;
        Thu, 05 Dec 2019 06:04:17 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-61b9-031c-bed1-3502.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:61b9:31c:bed1:3502])
        by smtp.gmail.com with ESMTPSA id c9sm12165045pfn.65.2019.12.05.06.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 06:04:16 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com
Cc:     daniel@iogearbox.net, cai@lca.pw, Daniel Axtens <dja@axtens.net>
Subject: [PATCH 2/3] kasan: use apply_to_existing_pages for releasing vmalloc shadow
Date:   Fri,  6 Dec 2019 01:04:06 +1100
Message-Id: <20191205140407.1874-2-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205140407.1874-1-dja@axtens.net>
References: <20191205140407.1874-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_release_vmalloc uses apply_to_page_range to release vmalloc
shadow. Unfortunately, apply_to_page_range can allocate memory to
fill in page table entries, which is not what we want.

Also, kasan_release_vmalloc is called under free_vmap_area_lock,
so if apply_to_page_range does allocate memory, we get a sleep in
atomic bug:

	BUG: sleeping function called from invalid context at mm/page_alloc.c:4681
	in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15087, name:

	Call Trace:
	 __dump_stack lib/dump_stack.c:77 [inline]
	 dump_stack+0x199/0x216 lib/dump_stack.c:118
	 ___might_sleep.cold.97+0x1f5/0x238 kernel/sched/core.c:6800
	 __might_sleep+0x95/0x190 kernel/sched/core.c:6753
	 prepare_alloc_pages mm/page_alloc.c:4681 [inline]
	 __alloc_pages_nodemask+0x3cd/0x890 mm/page_alloc.c:4730
	 alloc_pages_current+0x10c/0x210 mm/mempolicy.c:2211
	 alloc_pages include/linux/gfp.h:532 [inline]
	 __get_free_pages+0xc/0x40 mm/page_alloc.c:4786
	 __pte_alloc_one_kernel include/asm-generic/pgalloc.h:21 [inline]
	 pte_alloc_one_kernel include/asm-generic/pgalloc.h:33 [inline]
	 __pte_alloc_kernel+0x1d/0x200 mm/memory.c:459
	 apply_to_pte_range mm/memory.c:2031 [inline]
	 apply_to_pmd_range mm/memory.c:2068 [inline]
	 apply_to_pud_range mm/memory.c:2088 [inline]
	 apply_to_p4d_range mm/memory.c:2108 [inline]
	 apply_to_page_range+0x77d/0xa00 mm/memory.c:2133
	 kasan_release_vmalloc+0xa7/0xc0 mm/kasan/common.c:970
	 __purge_vmap_area_lazy+0xcbb/0x1f30 mm/vmalloc.c:1313
	 try_purge_vmap_area_lazy mm/vmalloc.c:1332 [inline]
	 free_vmap_area_noflush+0x2ca/0x390 mm/vmalloc.c:1368
	 free_unmap_vmap_area mm/vmalloc.c:1381 [inline]
	 remove_vm_area+0x1cc/0x230 mm/vmalloc.c:2209
	 vm_remove_mappings mm/vmalloc.c:2236 [inline]
	 __vunmap+0x223/0xa20 mm/vmalloc.c:2299
	 __vfree+0x3f/0xd0 mm/vmalloc.c:2356
	 __vmalloc_area_node mm/vmalloc.c:2507 [inline]
	 __vmalloc_node_range+0x5d5/0x810 mm/vmalloc.c:2547
	 __vmalloc_node mm/vmalloc.c:2607 [inline]
	 __vmalloc_node_flags mm/vmalloc.c:2621 [inline]
	 vzalloc+0x6f/0x80 mm/vmalloc.c:2666
	 alloc_one_pg_vec_page net/packet/af_packet.c:4233 [inline]
	 alloc_pg_vec net/packet/af_packet.c:4258 [inline]
	 packet_set_ring+0xbc0/0x1b50 net/packet/af_packet.c:4342
	 packet_setsockopt+0xed7/0x2d90 net/packet/af_packet.c:3695
	 __sys_setsockopt+0x29b/0x4d0 net/socket.c:2117
	 __do_sys_setsockopt net/socket.c:2133 [inline]
	 __se_sys_setsockopt net/socket.c:2130 [inline]
	 __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2130
	 do_syscall_64+0xfa/0x780 arch/x86/entry/common.c:294
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Switch to using the apply_to_existing_pages helper instead, which
won't allocate memory.

Fixes: 3c5c3cfb9ef4 ("kasan: support backing vmalloc space with real shadow memory")
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>

---

Andrew, if you want to take this, it replaces
"kasan: Don't allocate page tables in kasan_release_vmalloc()"
---
 mm/kasan/common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index e04e73603dfc..26fd0c13dd28 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -957,6 +957,7 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 {
 	void *shadow_start, *shadow_end;
 	unsigned long region_start, region_end;
+	unsigned long size;
 
 	region_start = ALIGN(start, PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
 	region_end = ALIGN_DOWN(end, PAGE_SIZE * KASAN_SHADOW_SCALE_SIZE);
@@ -979,9 +980,10 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
 	shadow_end = kasan_mem_to_shadow((void *)region_end);
 
 	if (shadow_end > shadow_start) {
-		apply_to_page_range(&init_mm, (unsigned long)shadow_start,
-				    (unsigned long)(shadow_end - shadow_start),
-				    kasan_depopulate_vmalloc_pte, NULL);
+		size = shadow_end - shadow_start;
+		apply_to_existing_pages(&init_mm, (unsigned long)shadow_start,
+					size, kasan_depopulate_vmalloc_pte,
+					NULL);
 		flush_tlb_kernel_range((unsigned long)shadow_start,
 				       (unsigned long)shadow_end);
 	}
-- 
2.20.1

