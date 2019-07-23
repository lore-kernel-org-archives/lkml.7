Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0CCC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C491120823
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfGWQTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:19:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:54940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728180AbfGWQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:19:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B21ADAF19;
        Tue, 23 Jul 2019 16:19:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     mbrugger@suse.com, hch@lst.de,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
Subject: [RFC] ARM: bcm2835: register dmabounce on devices hooked to main interconnect
Date:   Tue, 23 Jul 2019 18:19:33 +0200
Message-Id: <20190723161934.4590-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NOTE: This patch builds upon Stefan's series providing basic support for
RPi4[1]. I'm mostly interested in verifying if this is the correct approach
to the issue stated below. If so I assume this will be added to Stefan's
v2 series.

The new Raspberry Pi 4 happens to have weird DMA constraints. Even
though it might contain up to 4 GB of ram, most devices can only access
the first lower GB of memory.

This breaks the overall assumption DMA API makes whereas 32-bit DMA
masks are always supported[2], and potentially breaks DMA addressing for
all streaming DMA users. This has already been observed with
'sdhci-iproc' but might as well happen elsewhere. Note that contiguous
allocations are safe as 'dma_zone_size' is set accordingly.

To get around that limitation we register arm's dmabounce dma-ops on all
devices hooked to the SoC's main interconnect.

[1] https://www.spinics.net/lists/arm-kernel/msg742120.html
[2] https://www.spinics.net/lists/arm-kernel/msg742736.html

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/mach-bcm/Kconfig         |  1 +
 arch/arm/mach-bcm/board_bcm2835.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 5e5f1fabc3d4..588326f7e269 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -168,6 +168,7 @@ config ARCH_BCM2835
 	select PINCTRL
 	select PINCTRL_BCM2835
 	select MFD_CORE
+	select DMABOUNCE if ARCH_MULTI_V7
 	help
 	  This enables support for the Broadcom BCM2835 and BCM2836 SoCs.
 	  This SoC is used in the Raspberry Pi and Roku 2 devices.
diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/mach-bcm/board_bcm2835.c
index c09cf25596af..7aff29f77ca7 100644
--- a/arch/arm/mach-bcm/board_bcm2835.c
+++ b/arch/arm/mach-bcm/board_bcm2835.c
@@ -3,6 +3,8 @@
  * Copyright (C) 2010 Broadcom
  */
 
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/of_address.h>
@@ -24,8 +26,35 @@ static const char * const bcm2835_compat[] = {
 	NULL
 };
 
+static int bcm2835_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
+{
+	/*
+	 * The accepted dma addresses are [0xc0000000, 0xffffffff] which map to
+	 * ram's [0x00000000, 0x3fffffff].
+	 */
+	return dma_addr < 3ULL * SZ_1G;
+}
+
+static int bcm2835_platform_notify(struct device *dev)
+{
+	if (dev->parent && !strcmp("soc", dev_name(dev->parent))) {
+		dev->dma_mask = &dev->coherent_dma_mask;
+		dev->coherent_dma_mask = DMA_BIT_MASK(30);
+		dmabounce_register_dev(dev, 2048, 4096, bcm2835_needs_bounce);
+	}
+
+	return 0;
+}
+
+void __init bcm2835_init_early(void)
+{
+	if(of_machine_is_compatible("brcm,bcm2711"))
+		platform_notify = bcm2835_platform_notify;
+}
+
 DT_MACHINE_START(BCM2835, "BCM2835")
 	.dma_zone_size	= SZ_1G,
 	.dt_compat = bcm2835_compat,
 	.smp = smp_ops(bcm2836_smp_ops),
+	.init_early = bcm2835_init_early,
 MACHINE_END
-- 
2.22.0

