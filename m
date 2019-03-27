Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4271C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B242177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709885;
	bh=ua7LJnVXX/Vm3FqF5WFEnE7RJx6RGO6dq81BORIG8QA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jOgXb1QM0Fo77rfC3aDw+beLxSZyZE6bUOknzdFOjKB1pkHEWy4DRgTE6tt4a8eHD
	 c5hWpJbRErqcNQ+ZoSiYzNJtkl9EnX0t9Ofx1oiMrsAYdjf1S226Urvy6ogqfvNL+Y
	 rEdhwH5F7aTF1lYbbeFO0bwmj0Fp+X84wn4hyIXY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbfC0SEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbfC0SEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:04:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EB5217D9;
        Wed, 27 Mar 2019 18:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709881;
        bh=ua7LJnVXX/Vm3FqF5WFEnE7RJx6RGO6dq81BORIG8QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBnpBF9rTVFd1ygqzoyhuGKxlIzPlX05PVO2NcF39NZBCktc4KBSbLO84jnJo3yCP
         AnV43znsOdRJIlPLhI2sN24gYi1OJMv/eKtHwkGWL+4GN9Y2Ic2eoyRuoIYa8CEweu
         aIEYb+3UYn8EEH9iw9vKoD9ShXT5XozcMehs7Ss4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.0 086/262] powerpc/hugetlb: Handle mmap_min_addr correctly in get_unmapped_area callback
Date:   Wed, 27 Mar 2019 13:59:01 -0400
Message-Id: <20190327180158.10245-86-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

[ Upstream commit 5330367fa300742a97e20e953b1f77f48392faae ]

After we ALIGN up the address we need to make sure we didn't overflow
and resulted in zero address. In that case, we need to make sure that
the returned address is greater than mmap_min_addr.

This fixes selftest va_128TBswitch --run-hugetlb reporting failures when
run as non root user for

mmap(-1, MAP_HUGETLB)

The bug is that a non-root user requesting address -1 will be given address 0
which will then fail, whereas they should have been given something else that
would have succeeded.

We also avoid the first mmap(-1, MAP_HUGETLB) returning NULL address as mmap address
with this change. So we think this is not a security issue, because it only affects
whether we choose an address below mmap_min_addr, not whether we
actually allow that address to be mapped. ie. there are existing capability
checks to prevent a user mapping below mmap_min_addr and those will still be
honoured even without this fix.

Fixes: 484837601d4d ("powerpc/mm: Add radix support for hugetlb")
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/hugetlbpage-radix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
index 2486bee0f93e..97c7a39ebc00 100644
--- a/arch/powerpc/mm/hugetlbpage-radix.c
+++ b/arch/powerpc/mm/hugetlbpage-radix.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
+#include <linux/security.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
@@ -73,7 +74,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
-		if (high_limit - len >= addr &&
+		if (high_limit - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
@@ -83,7 +84,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	 */
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = PAGE_SIZE;
+	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
-- 
2.19.1

