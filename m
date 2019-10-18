Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D251CA9EAB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BDD21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505484AbfJRPoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:44:44 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408927AbfJRPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:42:40 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MTREY-1iT8oJ32Uu-00TnA9; Fri, 18 Oct 2019 17:42:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 43/46] ARM: pxa: pci-it8152: add platform checks
Date:   Fri, 18 Oct 2019 17:41:58 +0200
Message-Id: <20191018154201.1276638-43-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191018154052.1276506-1-arnd@arndb.de>
References: <20191018154052.1276506-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WnpsrCVsFtLZwYDKVWua5rhQugWiG4CHVyH0zXtk8Rwkd0XKS4O
 qLuwINJDZ99vCTkcLsvQieydiJjBBtfN8tJDP0HhkRRNiEApdn2+aHy+DIM2j8X+6/YS43G
 wkPG2uBkHUdQDHMAYY3e8pRHaIavRFuvZNCI5mEas5JaiBNLql2O4WsNCli9kkHM1Emglla
 oR9lTxTbZFwTF6ZybhGyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cGFaOYnGTA4=:iSgeRul54ih3AO6Q/YxyU6
 U56cbaP608/+NlW6qy+EG1HeDZXJrVG8T8CF8/AgXYePJWOmx/z8vZhp+klobV6qB1amz3c1U
 Cd8QWozNwoBbI9ogvT9vJBo9dUpAl8FQTrN14OZkECNkSL4jOejc9CL2XV23wsGrJbxvVkfVA
 TatH5aKMGNBPCL/vyouOtxzVlRQ4BJsFyDwriU+9pLkn3NwMyxumR8AH++65ey/QzwaGiRDFG
 WNpijKl+ZCr6NTJ3Ds7FAmDztmzBIs4TIL9dWOagIIcv4KGC/l8r1PLOfD+HQ3wAtczvc6lXz
 gxH3SJXQ8A5+S0YwTB4eEkpFXGEntQg+djH4ZApbOH2xmU4V1aKjrFq9FTiypT7YsB9ajCH7a
 MXUeg1RrdQe4aGqyG+cmt0iD6ub4ioFc8McLJfSBgurh4FnuuiFksdv9VhGb3ZO/vBGatpl22
 Sk/t2Gs45fI0zHutMBgEVKilapZyuTDvUnROxD0hlaXk5Bg8Uipi9q3mdrBTha4+ZKu3t9ozp
 rxAnBvwS/JOU6RHZ59TQYI3iN4yGrqpvfkgae8ZgAwHGc9s2meWcc+ZX9bLvDkGdRBwctG0z4
 mgcMyZZXieGKA+85rjZRMiHYYVUV8+sSX4zURLELMbnqQzUnB6vzyvzxvVd3mGpZoxCkDYhog
 rLLOsAglaBDPaMPeqzbqXxFgnskROJkwN5cGKMArRm9rCM8Jyh+FyHDTqOc3DvH+kYwhgIQ+k
 Ly8tTwT7XaArfI935W5g+JvGv/8cmuPrNLfZe+hRPqyC0na1ARqm6VDysZSp/KaDh3kyECHfn
 DkMYGehNO7cuKNmxd5h7cN0RUU1GAeALUm3m6dcV+LE9RzT4e48WWeP6OLmqM/tWse1AJEjcf
 CC2GVCoYUa1FCftOz2XA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The it8152 driver does a few things differently from
everyone else. Make sure that these have no effect when
running on anything other than a pxa2xx.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/pci-it8152.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/pci-it8152.c b/arch/arm/mach-pxa/pci-it8152.c
index af99c990f0c1..fe8cf7d2234d 100644
--- a/arch/arm/mach-pxa/pci-it8152.c
+++ b/arch/arm/mach-pxa/pci-it8152.c
@@ -23,6 +23,7 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/export.h>
+#include <linux/soc/pxa/cpu.h>
 
 #include <asm/mach/pci.h>
 
@@ -274,10 +275,21 @@ static int it8152_pci_platform_notify_remove(struct device *dev)
 
 int dma_set_coherent_mask(struct device *dev, u64 mask)
 {
-	if (mask >= PHYS_OFFSET + SZ_64M - 1)
-		return 0;
+	/* We've always done it like this, but it looks wrong */
+	if (cpu_is_pxa2xx()) {
+		if (mask >= PHYS_OFFSET + SZ_64M - 1)
+			return 0;
 
-	return -EIO;
+		return -EIO;
+	}
+
+	/* generic implementation from kernel/dma/mapping.c */
+	mask = (dma_addr_t)mask;
+	if (!dma_supported(dev, mask))
+		return -EIO;
+
+	dev->coherent_dma_mask = mask;
+	return 0;
 }
 
 int __init it8152_pci_setup(int nr, struct pci_sys_data *sys)
@@ -331,6 +343,10 @@ void pcibios_set_master(struct pci_dev *dev)
 {
 	u8 lat;
 
+	/* running on something else */
+	if (!cpu_is_pxa2xx())
+		return;
+
 	/* no need to update on-chip OHCI controller */
 	if ((dev->vendor == PCI_VENDOR_ID_ITE) &&
 	    (dev->device == PCI_DEVICE_ID_ITE_8152) &&
-- 
2.20.0

