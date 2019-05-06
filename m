Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35887C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D29214C6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153510;
	bh=m3SyE3HDVUxz0/YHku9Vj8PnmGa/Efm5Uo1tFhUs7wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Mhgi0db18J2YZIuLRqNjdTaWRjV2k31pJlWXNZv654Hgtw+FnvsCpfOSpy+CeEF9
	 OAW7uU2nEtDB7+rFYuQXjsf4rja95lVqos5juPJmQx2dcpMfJ8OcBN0fjQlmGCQg+7
	 cl0zamVI8KXE1HACC5QtOeWjnevGUB4unjjIGLq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfEFOi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:38:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfEFOi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:38:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03046206A3;
        Mon,  6 May 2019 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153506;
        bh=m3SyE3HDVUxz0/YHku9Vj8PnmGa/Efm5Uo1tFhUs7wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdUjSBWUJaWGkZ/qDkxcHOAXrpx21oQ5uf/VsuY1KjzSx8l89NWBNWc+UkEA3nzyj
         l0/esad5pLAaEgJneqj6yFU7FBbCNfJNnwoNYPTnOhHL+1zj5dNgJKt+dBTl2mcg+O
         Sl4+aayt3bQZTkzfJzdTp+db+fGkhLFEJanHgkqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 115/122] powerpc/mm/hash: Handle mmap_min_addr correctly in get_unmapped_area topdown search
Date:   Mon,  6 May 2019 16:32:53 +0200
Message-Id: <20190506143104.717707766@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit 3b4d07d2674f6b4a9281031f99d1f7efd325b16d upstream.

When doing top-down search the low_limit is not PAGE_SIZE but rather
max(PAGE_SIZE, mmap_min_addr). This handle cases in which mmap_min_addr >
PAGE_SIZE.

Fixes: fba2369e6ceb ("mm: use vm_unmapped_area() on powerpc architecture")
Reviewed-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/slice.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -32,6 +32,7 @@
 #include <linux/export.h>
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
+#include <linux/security.h>
 #include <asm/mman.h>
 #include <asm/mmu.h>
 #include <asm/copro.h>
@@ -377,6 +378,7 @@ static unsigned long slice_find_area_top
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long addr, found, prev;
 	struct vm_unmapped_area_info info;
+	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
@@ -393,7 +395,7 @@ static unsigned long slice_find_area_top
 	if (high_limit > DEFAULT_MAP_WINDOW)
 		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
 
-	while (addr > PAGE_SIZE) {
+	while (addr > min_addr) {
 		info.high_limit = addr;
 		if (!slice_scan_available(addr - 1, available, 0, &addr))
 			continue;
@@ -405,8 +407,8 @@ static unsigned long slice_find_area_top
 		 * Check if we need to reduce the range, or if we can
 		 * extend it to cover the previous available slice.
 		 */
-		if (addr < PAGE_SIZE)
-			addr = PAGE_SIZE;
+		if (addr < min_addr)
+			addr = min_addr;
 		else if (slice_scan_available(addr - 1, available, 0, &prev)) {
 			addr = prev;
 			goto prev_slice;
@@ -528,7 +530,7 @@ unsigned long slice_get_unmapped_area(un
 		addr = _ALIGN_UP(addr, page_size);
 		slice_dbg(" aligned addr=%lx\n", addr);
 		/* Ignore hint if it's too large or overlaps a VMA */
-		if (addr > high_limit - len ||
+		if (addr > high_limit - len || addr < mmap_min_addr ||
 		    !slice_area_is_free(mm, addr, len))
 			addr = 0;
 	}


