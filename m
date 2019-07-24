Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09EFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C72083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997554;
	bh=PQQ4zdOibTf1/2BVN4RCUWGIip6pZVmCxeYVcAFnBzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0QF7GuTrdBAN3EG+/znAJdqQp4jzVvgR0CzxXwVoVf/mdaSMs2v2mepZtSh3ShmPF
	 tOyMDg/iC10BuZ+diMplP1bRYwx0AiqDt8zQQFKxXyyVXgF7ebgVt266Vce44wNqxI
	 JZIslBGidJ0uQlmhzo1/g98L07X6NI25XQdzVVAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389638AbfGXTpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390599AbfGXTpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:45:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03146217D4;
        Wed, 24 Jul 2019 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997548;
        bh=PQQ4zdOibTf1/2BVN4RCUWGIip6pZVmCxeYVcAFnBzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mf2JikTlAiEJ5Zjk7LoYsA26mIeedFGRjX8YsSx0JGeYABFMsRuf8qDswlU0JwSt9
         wDJpIamWrA8uW9iUYXLnpJiReRM0k6SUCv64ogbmKAvwxxsElhtgfqAjQ4xwv4bqvh
         bmDhCKQ37aDtdY+OudNOxt2++9Pb8tLWtKT5NlAc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 060/371] arm64: mm: make CONFIG_ZONE_DMA32 configurable
Date:   Wed, 24 Jul 2019 21:16:52 +0200
Message-Id: <20190724191729.388098882@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



