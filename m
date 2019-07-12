Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587BCC742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D28A208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfGLUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:49:14 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37037 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726976AbfGLUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:49:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TWjde2R_1562964544;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TWjde2R_1562964544)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 13 Jul 2019 04:49:11 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: page_alloc: document kmemleak's non-blockable __GFP_NOFAIL case
Date:   Sat, 13 Jul 2019 04:49:04 +0800
Message-Id: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running ltp's oom test with kmemleak enabled, the below warning was
triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
passed in:

WARNING: CPU: 105 PID: 2138 at mm/page_alloc.c:4608 __alloc_pages_nodemask+0x1c31/0x1d50
Modules linked in: loop dax_pmem dax_pmem_core
ip_tables x_tables xfs virtio_net net_failover virtio_blk failover
ata_generic virtio_pci virtio_ring virtio libata
CPU: 105 PID: 2138 Comm: oom01 Not tainted 5.2.0-next-20190710+ #7
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
RIP: 0010:__alloc_pages_nodemask+0x1c31/0x1d50
...
 kmemleak_alloc+0x4e/0xb0
 kmem_cache_alloc+0x2a7/0x3e0
 ? __kmalloc+0x1d6/0x470
 ? ___might_sleep+0x9c/0x170
 ? mempool_alloc+0x2b0/0x2b0
 mempool_alloc_slab+0x2d/0x40
 mempool_alloc+0x118/0x2b0
 ? __kasan_check_read+0x11/0x20
 ? mempool_resize+0x390/0x390
 ? lock_downgrade+0x3c0/0x3c0
 bio_alloc_bioset+0x19d/0x350
 ? __swap_duplicate+0x161/0x240
 ? bvec_alloc+0x1b0/0x1b0
 ? do_raw_spin_unlock+0xa8/0x140
 ? _raw_spin_unlock+0x27/0x40
 get_swap_bio+0x80/0x230
 ? __x64_sys_madvise+0x50/0x50
 ? end_swap_bio_read+0x310/0x310
 ? __kasan_check_read+0x11/0x20
 ? check_chain_key+0x24e/0x300
 ? bdev_write_page+0x55/0x130
 __swap_writepage+0x5ff/0xb20

The mempool_alloc_slab() clears __GFP_DIRECT_RECLAIM, kmemleak has
__GFP_NOFAIL set all the time due to commit
d9570ee3bd1d4f20ce63485f5ef05663866fe6c0 ("kmemleak: allow to coexist
with fault injection").

The fault-injection would not try to fail slab or page allocation if
__GFP_NOFAIL is used and that commit tries to turn off fault injection
for kmemleak allocation.  Although __GFP_NOFAIL doesn't guarantee no
failure for all the cases (i.e. non-blockable allocation may fail), it
still makes sense to the most cases.  Kmemleak is also a debugging tool,
so it sounds not worth changing the behavior.

It also meaks sense to keep the warning, so just document the special
case in the comment.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/page_alloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d66bc8a..cac6efb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4531,8 +4531,14 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	 */
 	if (gfp_mask & __GFP_NOFAIL) {
 		/*
-		 * All existing users of the __GFP_NOFAIL are blockable, so warn
-		 * of any new users that actually require GFP_NOWAIT
+		 * The users of the __GFP_NOFAIL are expected be blockable,
+		 * and this is true for the most cases except for kmemleak.
+		 * The kmemleak pass in __GFP_NOFAIL to skip fault injection,
+		 * however kmemleak may allocate object at some non-blockable
+		 * context to trigger this warning.
+		 *
+		 * Keep this warning since it is still useful for the most
+		 * normal cases.
 		 */
 		if (WARN_ON_ONCE(!can_direct_reclaim))
 			goto fail;
-- 
1.8.3.1

