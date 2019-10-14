Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056C3ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D878921848
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbfJNScF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:32:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388793AbfJNSbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:31:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E07EDBB7A;
        Mon, 14 Oct 2019 18:31:50 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     hch@infradead.org, mbrugger@suse.com, f.fainelli@gmail.com,
        wahrenst@gmx.net, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH RFC 3/5] ARM: let machines select dma-direct over arch's DMA implementation
Date:   Mon, 14 Oct 2019 20:31:05 +0200
Message-Id: <20191014183108.24804-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191014183108.24804-1-nsaenzjulienne@suse.de>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bounce buffering feature is already available in ARM, dmabounce.c, yet
it doesn't support high memory which some devices need. Instead of
fixing it, provide a means for devices to enable dma-direct, which is the
preferred way of doing DMA now days.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/include/asm/mach/arch.h | 1 +
 arch/arm/mm/init.c               | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index e7df5a822cab..3542bf502573 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -33,6 +33,7 @@ struct machine_desc {
 #ifdef CONFIG_ZONE_DMA
 	phys_addr_t		dma_zone_size;	/* size of DMA-able area */
 #endif
+	bool			dma_direct;
 
 	unsigned int		video_start;	/* start of video RAM	*/
 	unsigned int		video_end;	/* end of video RAM	*/
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0a63379a4d1a..556f70665353 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -19,6 +19,7 @@
 #include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-direct.h>
 #include <linux/sizes.h>
 #include <linux/stop_machine.h>
 #include <linux/swiotlb.h>
@@ -119,6 +120,8 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 	 */
 	if (IS_ENABLED(CONFIG_ARM_LPAE))
 		arm_dma_direct = true;
+	else
+		arm_dma_direct = mdesc->dma_direct;
 
 #ifdef CONFIG_ZONE_DMA
 	if (mdesc->dma_zone_size) {
@@ -126,7 +129,10 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 		arm_dma_limit = PHYS_OFFSET + arm_dma_zone_size - 1;
 	} else
 		arm_dma_limit = 0xffffffff;
+
 	arm_dma_pfn_limit = arm_dma_limit >> PAGE_SHIFT;
+
+	zone_dma_bits = ilog2(arm_dma_limit) + 1;
 #endif
 }
 
@@ -482,7 +488,7 @@ static void __init free_highpages(void)
  */
 void __init mem_init(void)
 {
-#ifdef CONFIG_ARM_LPAE
+#ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
 #endif
 
-- 
2.23.0

