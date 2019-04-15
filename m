Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E56DC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3B32073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfDORgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:36:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23539 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727490AbfDORgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:36:44 -0400
X-UUID: f17344b417b24d7a9176044fd3f84ed4-20190416
X-UUID: f17344b417b24d7a9176044fd3f84ed4-20190416
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1714215129; Tue, 16 Apr 2019 01:36:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 16 Apr 2019 01:36:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 01:36:37 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64: mm: check virtual addr in virt_to_page() if CONFIG_DEBUG_VIRTUAL=y
Date:   Tue, 16 Apr 2019 01:36:36 +0800
Message-ID: <1555349796-9456-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change uses the original virt_to_page() (the one with __pa()) to
check the given virtual address if CONFIG_DEBUG_VIRTUAL=y.

Recently, I worked on a bug: a driver passes a symbol address to
dma_map_single() and the virt_to_page() (called by dma_map_single())
does not work for non-linear addresses after commit 9f2875912dac
("arm64: mm: restrict virt_to_page() to the linear mapping").

I tried to trap the bug by enabling CONFIG_DEBUG_VIRTUAL but it
did not work - bacause the commit removes the __pa() from
virt_to_page() but CONFIG_DEBUG_VIRTUAL checks the virtual address
in __pa()/__virt_to_phys().

A simple solution is to use the original virt_to_page()
(the one with__pa()) if CONFIG_DEBUG_VIRTUAL=y.

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 290195168bb3..2cb8248fa2c8 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -302,7 +302,7 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 #define ARCH_PFN_OFFSET		((unsigned long)PHYS_PFN_OFFSET)
 
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
+#if !defined(CONFIG_SPARSEMEM_VMEMMAP) || defined(CONFIG_DEBUG_VIRTUAL)
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define _virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 #else
-- 
2.18.0

