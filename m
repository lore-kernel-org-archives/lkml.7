Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE658C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2FD206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575375058;
	bh=mM13KHxBngohOxFi/TTFeMlKRJJ80enDLR3A+PBKNYg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=liv22Ka60zIJr/YdBUccieJgEDbieARzCd2dpQwza0H2Ve30fPiz1SQbCmDgPyoJ2
	 z60obhtEnD3rzIto5uzOgB17jY/pPlxgqM3BYNBjNn2+F+gkUwyvKj8PM5QRsOd1K4
	 MtIIyAz7Or6shI0Y+vlzHdrKyjcfwGLn+sbpM8M0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLCMK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfLCMK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:10:57 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F49C20659;
        Tue,  3 Dec 2019 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575375056;
        bh=mM13KHxBngohOxFi/TTFeMlKRJJ80enDLR3A+PBKNYg=;
        h=From:To:Cc:Subject:Date:From;
        b=YJq54cNGOravzW6GKl2E/rJ1C/BJibT6H/beqkESWRLue1bUynPWXuNY7N+wW6/zH
         fP7avqLbUEo+Q7OMcHsTF0rM2UBgQF8zMof3ZaYih+p45LV7/+89Bz82xezXXTFoVx
         q4jsxxEKSoz9xBFXRYeOKrjzRBsG7dddYcExEwRk=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH] arm64: mm: Fix initialisation of DMA zones on non-NUMA systems
Date:   Tue,  3 Dec 2019 12:10:13 +0000
Message-Id: <20191203121013.9280-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John reports that the recently merged commit 1a8e1cef7603 ("arm64: use
both ZONE_DMA and ZONE_DMA32") breaks the boot on his DB845C board:

  | Booting Linux on physical CPU 0x0000000000 [0x517f803c]
  | Linux version 5.4.0-mainline-10675-g957a03b9e38f
  | Machine model: Thundercomm Dragonboard 845c
  | [...]
  | Built 1 zonelists, mobility grouping on.  Total pages: -188245
  | Kernel command line: earlycon
  | firmware_class.path=/vendor/firmware/ androidboot.hardware=db845c
  | init=/init androidboot.boot_devices=soc/1d84000.ufshc
  | printk.devkmsg=on buildvariant=userdebug root=/dev/sda2
  | androidboot.bootdevice=1d84000.ufshc androidboot.serialno=c4e1189c
  | androidboot.baseband=sda
  | msm_drm.dsi_display0=dsi_lt9611_1080_video_display:
  | androidboot.slot_suffix=_a skip_initramfs rootwait ro init=/init
  |
  | <hangs indefinitely here>

This is because, when CONFIG_NUMA=n, zone_sizes_init() fails to handle
memblocks that fall entirely within the ZONE_DMA region and erroneously ends up
trying to add a negatively-sized region into the following ZONE_DMA32, which is
later interpreted as a large unsigned region by the core MM code.

Rework the non-NUMA implementation of zone_sizes_init() so that the start
address of the memblock being processed is adjusted according to the end of the
previous zone, which is then range-checked before updating the hole information
of subsequent zones.

Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Link: https://lore.kernel.org/lkml/CALAqxLVVcsmFrDKLRGRq7GewcW405yTOxG=KR3csVzQ6bXutkA@mail.gmail.com
Fixes: 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
Reported-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/mm/init.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

Compile-tested only.

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index be9481cdf3b9..b65dffdfb201 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -214,15 +214,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 {
 	struct memblock_region *reg;
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
-	unsigned long max_dma32 = min;
-	unsigned long __maybe_unused max_dma = min;
+	unsigned long __maybe_unused max_dma, max_dma32;
 
 	memset(zone_size, 0, sizeof(zone_size));
 
+	max_dma = max_dma32 = min;
 #ifdef CONFIG_ZONE_DMA
-	max_dma = PFN_DOWN(arm64_dma_phys_limit);
+	max_dma = max_dma32 = PFN_DOWN(arm64_dma_phys_limit);
 	zone_size[ZONE_DMA] = max_dma - min;
-	max_dma32 = max_dma;
 #endif
 #ifdef CONFIG_ZONE_DMA32
 	max_dma32 = PFN_DOWN(arm64_dma32_phys_limit);
@@ -236,25 +235,23 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 		unsigned long start = memblock_region_memory_base_pfn(reg);
 		unsigned long end = memblock_region_memory_end_pfn(reg);
 
-		if (start >= max)
-			continue;
 #ifdef CONFIG_ZONE_DMA
-		if (start < max_dma) {
-			unsigned long dma_end = min_not_zero(end, max_dma);
+		if (start >= min && start < max_dma) {
+			unsigned long dma_end = min(end, max_dma);
 			zhole_size[ZONE_DMA] -= dma_end - start;
+			start = dma_end;
 		}
 #endif
 #ifdef CONFIG_ZONE_DMA32
-		if (start < max_dma32) {
+		if (start >= max_dma && start < max_dma32) {
 			unsigned long dma32_end = min(end, max_dma32);
-			unsigned long dma32_start = max(start, max_dma);
-			zhole_size[ZONE_DMA32] -= dma32_end - dma32_start;
+			zhole_size[ZONE_DMA32] -= dma32_end - start;
+			start = dma32_end;
 		}
 #endif
-		if (end > max_dma32) {
+		if (start >= max_dma32 && start < max) {
 			unsigned long normal_end = min(end, max);
-			unsigned long normal_start = max(start, max_dma32);
-			zhole_size[ZONE_NORMAL] -= normal_end - normal_start;
+			zhole_size[ZONE_NORMAL] -= normal_end - start;
 		}
 	}
 
-- 
2.17.1

