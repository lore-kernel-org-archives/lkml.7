Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D042C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A26D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 16:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfE1QIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 12:08:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726243AbfE1QIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 12:08:31 -0400
X-UUID: 62d74480a8f848769c2628aab2a5dfce-20190529
X-UUID: 62d74480a8f848769c2628aab2a5dfce-20190529
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2039780566; Wed, 29 May 2019 00:08:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 29 May 2019 00:08:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 29 May 2019 00:08:22 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] arm64: mm: make CONFIG_ZONE_DMA32 configurable
Date:   Wed, 29 May 2019 00:08:20 +0800
Message-ID: <1559059700-19078-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 87B232C704D69A9827EA24D295E4D72D2BDE208AE19017C0BAEB038AA959C9202000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes CONFIG_ZONE_DMA32 defuly y and allows users
to overwrite it only when CONFIG_EXPERT=y.

For the SoCs that do not need CONFIG_ZONE_DMA32, this is the
first step to manage all available memory by a single
zone(normal zone) to reduce the overhead of multiple zones.

The change also fixes a build error when CONFIG_NUMA=y and
CONFIG_ZONE_DMA32=n.

arch/arm64/mm/init.c:195:17: error: use of undeclared identifier 'ZONE_DMA32'
                max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());

Change since v1:
1. only expose CONFIG_ZONE_DMA32 when CONFIG_EXPERT=y
2. remove redundant IS_ENABLED(CONFIG_ZONE_DMA32)

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 arch/arm64/Kconfig   | 3 ++-
 arch/arm64/mm/init.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 76f6e4765f49..20c552b1302c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -260,7 +260,8 @@ config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
 config ZONE_DMA32
-	def_bool y
+	bool "Support DMA32 zone" if EXPERT
+	default y
 
 config HAVE_GENERIC_GUP
 	def_bool y
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index d2adffb81b5d..f643bd45ff69 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -191,8 +191,9 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 
-	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
+#ifdef CONFIG_ZONE_DMA32
+	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
+#endif
 	max_zone_pfns[ZONE_NORMAL] = max;
 
 	free_area_init_nodes(max_zone_pfns);
-- 
2.18.0

