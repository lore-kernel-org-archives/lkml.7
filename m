Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D83C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09DFE2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbfCUEVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:21:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40143 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725871AbfCUEVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 00:21:45 -0400
X-UUID: 96c85726c45e4f88b40c6250be55700b-20190321
X-UUID: 96c85726c45e4f88b40c6250be55700b-20190321
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 287673506; Thu, 21 Mar 2019 12:21:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 12:21:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 12:21:27 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] arm64: setup min_low_pfn
Date:   Thu, 21 Mar 2019 12:21:25 +0800
Message-ID: <1553142085-5800-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CD9AE3611D2CF0FD265D0346848CD0A719A8894E36F1E39196414851D76275DA2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging with CONFIG_PAGE_OWNER, I noticed that the min_low_pfn
on arm64 is always zero and the page owner scanning has to start from zero.
We have to loop a while before we see the first valid pfn.
(see: read_page_owner())

Setup min_low_pfn to save some loops.

Before setting min_low_pfn:

[   21.265602] min_low_pfn=0, *ppos=0
Page allocated via order 0, mask 0x100cca(GFP_HIGHUSER_MOVABLE)
PFN 262144 type Movable Block 512 type Movable Flags 0x8001e
referenced|uptodate|dirty|lru|swapbacked)
prep_new_page+0x13c/0x140
get_page_from_freelist+0x254/0x1068
__alloc_pages_nodemask+0xd4/0xcb8

After setting min_low_pfn:

[   11.025787] min_low_pfn=262144, *ppos=0
Page allocated via order 0, mask 0x100cca(GFP_HIGHUSER_MOVABLE)
PFN 262144 type Movable Block 512 type Movable Flags 0x8001e
referenced|uptodate|dirty|lru|swapbacked)
prep_new_page+0x13c/0x140
get_page_from_freelist+0x254/0x1068
__alloc_pages_nodemask+0xd4/0xcb8
shmem_alloc_page+0x7c/0xa0
shmem_alloc_and_acct_page+0x124/0x1e8
shmem_getpage_gfp.isra.7+0x118/0x878
shmem_write_begin+0x38/0x68

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 6bc135042f5e..3dbd0c5ce780 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -440,6 +440,7 @@ void __init bootmem_init(void)
 	early_memtest(min << PAGE_SHIFT, max << PAGE_SHIFT);
 
 	max_pfn = max_low_pfn = max;
+	min_low_pfn = min;
 
 	arm64_numa_init();
 	/*
-- 
2.18.0

