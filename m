Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BE9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F012177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368179;
	bh=sl7L8ILsqxlHfyGIFJaE9lnYYFD9MTdIxzPZvBJ9amo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SlUluxV9UbzyiBIHSm/PD/xwDR4nFxXuNMxzVdjYeQaICKqWZ+5/Pt74ncY/Epl38
	 KQNIqE4XI8S9wXxr5FkGao+qe3tc4udGzFjrQKh8S093biU/PxFqOxuKId7COmc1Le
	 dmc00c8DCL1ucBULCANmyUxBmSRMJOBMOlhGstiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfDDI4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730436AbfDDI4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:56:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FCB220693;
        Thu,  4 Apr 2019 08:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368171;
        bh=sl7L8ILsqxlHfyGIFJaE9lnYYFD9MTdIxzPZvBJ9amo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VU12lp3uh/kkt4awiEiy581TLq/Mr1bYpsq/cyMlPYxOwotk4YMMcSqfL31TLWeXx
         0WBeqW5pOs8oU1tZQTjDIQAuI+o+nafxi0ACMomiBBt5W6Z7hdtA2KWWHNEHZRaLvH
         YzB24wc03iNd46g8P+iG+kpPTiNPoycgvYIyeS6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 047/121] powerpc/hugetlb: Handle mmap_min_addr correctly in get_unmapped_area callback
Date:   Thu,  4 Apr 2019 10:47:15 +0200
Message-Id: <20190404084547.818350022@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index bd022d16745c..a31bad29b55d 100644
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
@@ -79,7 +80,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	if (addr) {
 		addr = ALIGN(addr, huge_page_size(h));
 		vma = find_vma(mm, addr);
-		if (high_limit - len >= addr &&
+		if (high_limit - len >= addr && addr >= mmap_min_addr &&
 		    (!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
@@ -89,7 +90,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
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



