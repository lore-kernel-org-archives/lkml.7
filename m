Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F508C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7269E20828
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 11:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfGELsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 07:48:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5258 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726505AbfGELsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 07:48:05 -0400
X-UUID: 52c8e7680f8e49a59d113a524c37eb73-20190705
X-UUID: 52c8e7680f8e49a59d113a524c37eb73-20190705
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1234003082; Fri, 05 Jul 2019 19:47:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 5 Jul 2019 19:47:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 5 Jul 2019 19:47:51 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-mm@kvack.org>
CC:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/sparse: fix memory leak of sparsemap_buf in aliged memory
Date:   Fri, 5 Jul 2019 19:47:30 +0800
Message-ID: <20190705114730.28534-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B5F96B9A41F2DD2F8286049F36ABA0FB5319729559A93CF5867822CD45F83C7F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sparse_buffer_alloc(size) get size of memory from sparsemap_buf after
being aligned with the size. However, the size is at least
PAGE_ALIGN(sizeof(struct page) * PAGES_PER_SECTION) and usually larger
than PAGE_SIZE.
Also, the Sparse_buffer_fini() only frees memory between
sparsemap_buf and sparsemap_buf_end, since sparsemap_buf may be changed
by PTR_ALIGN() first, the aligned space before sparsemap_buf is
wasted and no one will touch it.

In our ARM32 platform (without SPARSEMEM_VMEMMAP)
  Sparse_buffer_init
    Reserve d359c000 - d3e9c000 (9M)
  Sparse_buffer_alloc
    Alloc   d3a00000 - d3E80000 (4.5M)
  Sparse_buffer_fini
    Free    d3e80000 - d3e9c000 (~=100k)
 The reserved memory between d359c000 - d3a00000 (~=4.4M) is unfreed.

In ARM64 platform (with SPARSEMEM_VMEMMAP)

  sparse_buffer_init
    Reserve ffffffc07d623000 - ffffffc07f623000 (32M)
  Sparse_buffer_alloc
    Alloc   ffffffc07d800000 - ffffffc07f600000 (30M)
  Sparse_buffer_fini
    Free    ffffffc07f600000 - ffffffc07f623000 (140K)
 The reserved memory between ffffffc07d623000 - ffffffc07d800000
 (~=1.9M) is unfreed.

Let explicit free redundant aligned memory.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Mark-PK Tsai <Mark-PK.Tsai@mediatek.com>
Cc: YJ Chiang <yj.chiang@mediatek.com>
Cc: Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org
---
 mm/sparse.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index fd13166949b5..2b3b5be85120 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -428,6 +428,12 @@ struct page __init *sparse_mem_map_populate(unsigned long pnum, int nid,
 static void *sparsemap_buf __meminitdata;
 static void *sparsemap_buf_end __meminitdata;
 
+static inline void __init sparse_buffer_free(unsigned long size)
+{
+	WARN_ON(!sparsemap_buf || size == 0);
+	memblock_free_early(__pa(sparsemap_buf), size);
+}
+
 static void __init sparse_buffer_init(unsigned long size, int nid)
 {
 	phys_addr_t addr = __pa(MAX_DMA_ADDRESS);
@@ -444,7 +450,7 @@ static void __init sparse_buffer_fini(void)
 	unsigned long size = sparsemap_buf_end - sparsemap_buf;
 
 	if (sparsemap_buf && size > 0)
-		memblock_free_early(__pa(sparsemap_buf), size);
+		sparse_buffer_free(size);
 	sparsemap_buf = NULL;
 }
 
@@ -456,8 +462,12 @@ void * __meminit sparse_buffer_alloc(unsigned long size)
 		ptr = PTR_ALIGN(sparsemap_buf, size);
 		if (ptr + size > sparsemap_buf_end)
 			ptr = NULL;
-		else
+		else {
+			/* Free redundant aligned space */
+			if ((unsigned long)(ptr - sparsemap_buf) > 0)
+				sparse_buffer_free((unsigned long)(ptr - sparsemap_buf));
 			sparsemap_buf = ptr + size;
+		}
 	}
 	return ptr;
 }
-- 
2.18.0

