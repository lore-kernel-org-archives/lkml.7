Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E23C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2320700
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 21:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570915880;
	bh=OHyj5bDPQVGUT3OAq33STpc0n0zo2JvrtJXGizaQcDY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qFRK9/AIO95tIWLHX9C7RDeXCqb5W2dhiFNa8r63e+Z0/NZEW0OirGAxhNJjwO1U6
	 tI9JwRF5NsbMHnvH1+Uqx1UpINiG8McIttERSCju84BfK7V+HKKXnPSh9pfMCv6uDE
	 NtdqBOvhGTcMbr+0iOULvWbPMBZImTtxm15wFN70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfJLVbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 17:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbfJLVbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 17:31:10 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2863A20700;
        Sat, 12 Oct 2019 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570915870;
        bh=OHyj5bDPQVGUT3OAq33STpc0n0zo2JvrtJXGizaQcDY=;
        h=From:To:Cc:Subject:Date:From;
        b=vu47EcJeCFg9jYw+oumKYKxLlJhGtj+LBscpj0cCbgcfqWendWjFUBnPb9d7UXyU8
         fozUFlb1gn+IEfL0TkG5M9th+YM1wqEDBdX2xjWVXFis+BaWkID414k8OGXdcLV0sd
         z1fL/pyGWzYUI4MjFbxiEEIq3qPcDEc/7TTmhbR0=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Adam Ford <aford173@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        etnaviv@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm: memblock: do not enforce current limit for memblock_phys* family
Date:   Sun, 13 Oct 2019 00:31:01 +0300
Message-Id: <1570915861-17633-1-git-send-email-rppt@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Until commit 92d12f9544b7 ("memblock: refactor internal allocation
functions") the maximal address for memblock allocations was forced to
memblock.current_limit only for the allocation functions returning virtual
address. The changes introduced by that commit moved the limit enforcement
into the allocation core and as a result the allocation functions returning
physical address also started to limit allocations to
memblock.current_limit.

This caused breakage of etnaviv GPU driver:

[    3.682347] etnaviv etnaviv: bound 130000.gpu (ops gpu_ops)
[    3.688669] etnaviv etnaviv: bound 134000.gpu (ops gpu_ops)
[    3.695099] etnaviv etnaviv: bound 2204000.gpu (ops gpu_ops)
[    3.700800] etnaviv-gpu 130000.gpu: model: GC2000, revision: 5108
[    3.723013] etnaviv-gpu 130000.gpu: command buffer outside valid
memory window
[    3.731308] etnaviv-gpu 134000.gpu: model: GC320, revision: 5007
[    3.752437] etnaviv-gpu 134000.gpu: command buffer outside valid
memory window
[    3.760583] etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215
[    3.766766] etnaviv-gpu 2204000.gpu: Ignoring GPU with VG and FE2.0

Restore the behaviour of memblock_phys* family so that these functions will
not enforce memblock.current_limit.

Fixes: 92d12f9544b7 ("memblock: refactor internal allocation functions")
Reported-by: Adam Ford <aford173@gmail.com>
Tested-by: Adam Ford <aford173@gmail.com> #imx6q-logicpd
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/memblock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 7d4f61a..c4b16ca 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1356,9 +1356,6 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 		align = SMP_CACHE_BYTES;
 	}
 
-	if (end > memblock.current_limit)
-		end = memblock.current_limit;
-
 again:
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
@@ -1469,6 +1466,9 @@ static void * __init memblock_alloc_internal(
 	if (WARN_ON_ONCE(slab_is_available()))
 		return kzalloc_node(size, GFP_NOWAIT, nid);
 
+	if (max_addr > memblock.current_limit)
+		max_addr = memblock.current_limit;
+
 	alloc = memblock_alloc_range_nid(size, align, min_addr, max_addr, nid);
 
 	/* retry allocation without lower limit */
-- 
2.7.4

