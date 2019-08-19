Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9593C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4387206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfHSLox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:44:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17463 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726703AbfHSLox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:44:53 -0400
X-UUID: 5c5b18c1eaff4ff3965997d79be92ffe-20190819
X-UUID: 5c5b18c1eaff4ff3965997d79be92ffe-20190819
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 1040434438; Mon, 19 Aug 2019 19:44:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Aug 2019 19:44:46 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Aug 2019 19:44:47 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>
CC:     <kasan-dev@googlegroups.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH] arm64: kasan: fix phys_to_virt() false positive on tag-based kasan
Date:   Mon, 19 Aug 2019 19:44:20 +0800
Message-ID: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__arm_v7s_unmap() call iopte_deref() to translate pyh_to_virt address,
but it will modify pointer tag into 0xff, so there is a false positive.

When enable tag-based kasan, phys_to_virt() function need to rewrite
its original pointer tag in order to avoid kasan report an incorrect
memory corruption.

BUG: KASAN: double-free or invalid-free in __arm_v7s_unmap+0x720/0xda4
Pointer tag: [ff], memory tag: [c1]

Call trace:
 dump_backtrace+0x0/0x1d4
 show_stack+0x14/0x1c
 dump_stack+0xe8/0x140
 print_address_description+0x80/0x2f0
 kasan_report_invalid_free+0x58/0x74
 __kasan_slab_free+0x1e4/0x220
 kasan_slab_free+0xc/0x18
 kmem_cache_free+0xfc/0x884
 __arm_v7s_unmap+0x720/0xda4
 __arm_v7s_map+0xc8/0x774
 arm_v7s_map+0x80/0x158
 mtk_iommu_map+0xb4/0xe0
 iommu_map+0x154/0x450
 iommu_map_sg+0xe4/0x150
 iommu_dma_map_sg+0x214/0x4ec
 __iommu_map_sg_attrs+0xf0/0x110
 ion_map_dma_buf+0xe8/0x114
 dma_buf_map_attachment+0x4c/0x80
 disp_sync_prepare_buf+0x378/0x820
 _ioctl_prepare_buffer+0x130/0x870
 mtk_disp_mgr_ioctl+0x5c4/0xab0
 do_vfs_ioctl+0x8e0/0x15a4
 __arm64_sys_ioctl+0x8c/0xb4
 el0_svc_common+0xe4/0x1e0
 el0_svc_handler+0x30/0x3c
 el0_svc+0x8/0xc

Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
---
 arch/arm64/include/asm/kasan.h  |  1 -
 arch/arm64/include/asm/memory.h | 10 ++++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kasan.h b/arch/arm64/include/asm/kasan.h
index b52aacd2c526..59894cafad60 100644
--- a/arch/arm64/include/asm/kasan.h
+++ b/arch/arm64/include/asm/kasan.h
@@ -5,7 +5,6 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
-#include <asm/memory.h>
 #include <asm/pgtable-types.h>
 
 #define arch_kasan_set_tag(addr, tag)	__tag_set(addr, tag)
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 8ffcf5a512bb..75af5ba9ff22 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -171,6 +171,7 @@
 
 #include <linux/bitops.h>
 #include <linux/mmdebug.h>
+#include <asm/kasan.h>
 
 extern s64			memstart_addr;
 /* PHYS_OFFSET - the physical address of the start of memory. */
@@ -282,7 +283,16 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
 #define phys_to_virt phys_to_virt
 static inline void *phys_to_virt(phys_addr_t x)
 {
+#ifdef CONFIG_KASAN_SW_TAGS
+	unsigned long addr = __phys_to_virt(x);
+	u8 *tag = (void *)(addr >> KASAN_SHADOW_SCALE_SHIFT)
+				+ KASAN_SHADOW_OFFSET;
+
+	addr = __tag_set(addr, *tag);
+	return (void *)addr;
+#else
 	return (void *)(__phys_to_virt(x));
+#endif
 }
 
 /*
-- 
2.18.0

