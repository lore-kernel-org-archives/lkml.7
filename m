Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7902C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3C206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199638;
	bh=zJNvKnMK00uNaNrcsVzz6KGw7d6tV45AYuDx6s54UIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jYdjX/055fKiDed0stBd9DKqapt5QuJHmQfyRYI1qXz5PxGzEMXn/h+Y59elCgdKb
	 xG2yfI+17vOCMnbtNU0q9SkZJf/1alSe2bGk6TjFsh1308sbtbLh2sWO4QscJmPXi+
	 ZH1Ube8omM/WVdVcZoV9NdOFOpBD/9FWkYfkdMzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfGOOHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:07:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388018AbfGOOHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:07:14 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E272206B8;
        Mon, 15 Jul 2019 14:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199633;
        bh=zJNvKnMK00uNaNrcsVzz6KGw7d6tV45AYuDx6s54UIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvdPlIXR5Qv7Dtptx43gb6QaIaQAZ1NhVKMT6BZZ36pCkG+eMuEU6WWazOt9Vx2Xq
         KdHATqO4ffBMFnQJOupeBsvS6IhdV7PdlRWdutHmbtMVwHg8jbCQ2CF1mQ84BdJ+fe
         DVNmaiABVGDm1saivWFG/JJA4iVz1pcBQlaRprWo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miles Chen <miles.chen@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 058/219] arm64: mm: make CONFIG_ZONE_DMA32 configurable
Date:   Mon, 15 Jul 2019 10:00:59 -0400
Message-Id: <20190715140341.6443-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miles Chen <miles.chen@mediatek.com>

[ Upstream commit 0c1f14ed12262f45a3af1d588e4d7bd12438b8f5 ]

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
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig   | 3 ++-
 arch/arm64/mm/init.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d218729ec852..dc3e62a18b62 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -258,7 +258,8 @@ config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
 config ZONE_DMA32
-	def_bool y
+	bool "Support DMA32 zone" if EXPERT
+	default y
 
 config HAVE_GENERIC_GUP
 	def_bool y
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7cae155e81a5..fff8c61ff608 100644
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
2.20.1

