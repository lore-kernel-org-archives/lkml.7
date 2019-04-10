Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4B5C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAAF217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554877250;
	bh=8Cem24ody5j9vsJDLEovzkZOF5suymgugjLde+DwsVM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2rCOYMHuRe2Zke5u0aRBiHsStLXjXa32MC+s1hdtQ8166oCwjZoxQPFnGGrabNKLQ
	 y2Kn9F/obOR6KqRZ3qGCRybK3Kwngw/PSunllNEudo/x+TxdfkC+3wDxloDUMGLLZK
	 KHbleITGRxJErHvT9YTk13PiNgNjW63a2mpOxPr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfDJGUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbfDJGUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:20:48 -0400
Received: from localhost.localdomain (unknown [223.93.147.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CABF820850;
        Wed, 10 Apr 2019 06:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554877248;
        bh=8Cem24ody5j9vsJDLEovzkZOF5suymgugjLde+DwsVM=;
        h=From:To:Cc:Subject:Date:From;
        b=1Qn96GXGDpzr+Aqgjb5qZzIrw5+tmrBLr0WETqDuAeBz2lNX/bNjqepQNYOelpuu8
         T5R8G7tBq4Jec+lNn294RL/hpCoeV3ZRzG5lgi1SeKJTYcFGFlSGVVPnicTDIRk9c6
         /v2S9h6PkPC+KSnfD1Jv7RXzluzjSpo2IaloAw2A=
From:   guoren@kernel.org
To:     arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: Fixup wrong update_mmu_cache implementation
Date:   Wed, 10 Apr 2019 14:18:19 +0800
Message-Id: <1554877099-30927-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

In our stress test, we found some crash problem caused by:

if (!(vma->vm_flags & VM_EXEC))
	return;

in update_mmu_cache().

Seems current update_mmu_cache implementation is wrong and we retread
to the conservative implementation.

Also the usage of kmap_atomic in update_mmu_cache is risky, page-virtual
may be scheduled out and changed, so we must use preempt_disable &
pagefault_disable which is called by kmap_atomic().

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv2/cacheflush.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index d22c95f..5bb887b 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -34,10 +34,6 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 {
 	unsigned long addr, pfn;
 	struct page *page;
-	void *va;
-
-	if (!(vma->vm_flags & VM_EXEC))
-		return;
 
 	pfn = pte_pfn(*pte);
 	if (unlikely(!pfn_valid(pfn)))
@@ -47,14 +43,9 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	if (page == ZERO_PAGE(0))
 		return;
 
-	va = page_address(page);
-	addr = (unsigned long) va;
-
-	if (va == NULL && PageHighMem(page))
-		addr = (unsigned long) kmap_atomic(page);
+	addr = (unsigned long) kmap_atomic(page);
 
 	cache_wbinv_range(addr, addr + PAGE_SIZE);
 
-	if (va == NULL && PageHighMem(page))
-		kunmap_atomic((void *) addr);
+	kunmap_atomic((void *) addr);
 }
-- 
2.7.4

