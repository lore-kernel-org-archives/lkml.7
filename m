Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B615CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1022075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfDOT17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:27:59 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:46841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfDOT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:27:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8ysi-1hB9SM1EKE-00674C; Mon, 15 Apr 2019 21:27:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        David Ahern <dsahern@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 1/4] ARM: ep93xx: move network platform data to separate header
Date:   Mon, 15 Apr 2019 21:25:23 +0200
Message-Id: <20190415192734.935387-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7r+4JlmJvPvM2nMPpt2FgcrqkZ9O2yXFTBYzL79J2n1R3gNsh/I
 zJMiJz8yleneH9BgK+3DA6euAm9OBrFBVqYEnYfi8KOfp9koIp176i3pXHKoXLt0TLtR9HD
 2KtYPTztUNtZy5X0U8Wff5PQIwLt/up9RF3G5UbUGPB4XISltrdFVGVhDSuGGSQFpSHnQPe
 UsLWgi5C9ubd95k4xDVIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:htVNGk9GjfE=:8kjSBdwfuVj67ArJmu3r2I
 Mk2fc2oxt/2uttWubzOjlR+4odS9D3Hui8yKU97BhjkeijT9SOxFRHWMkwKtOJGQJzGEeVQO6
 fJAezqbiOLxP0p4rez36baBm813X2m2VlhsdAo9aygLqPflPXIC4U7J9fKH6KcOK3Umts2eS6
 tdZfZFDxbrfwr3aBRplYuOu+zUW8ZMiUSw1Ox/OGlVc0yj/GoaVpihoXpXZzacc8m/E1SNdNr
 58JNdx6D78Y83s90YNo2ixoi0cH5zgNSt4uxvTuHfih95VBvyAeeOnAPL++uNg/W8vGJMh/RJ
 DMOUBoSVs2CiBuVvt2Zb46u6MRpQ7q71q9iRBInGqZeKh1D/+mnhyUJ/EoMIkEsx+Jd/6yUsN
 3z5STqII//8IWzlOdZ5uLhOngUHJZjGZ5E8PeCx2rqrGcAsjAo4t6rcUo/TG5xAqUdObpr/7S
 kBsMJfT1owAp95s+RhwvuQG89JD/Hb2v+7wxWgJWEzETTTq4qNZZDRri82OyhYLypJRW9XHCV
 zYDEtOkn65Bfc7KYGHJljNgvwBkLkdmXbsN10zuINzZePJ7Sy4S25zWQ6rHUVPta74539eFjq
 uDpsAIiWFeKCTjNVn/knGM1aZ0yW8Tvaake3dWigzrRJHBpPCGArwpQonD+Ik+cHUK6WoRqtJ
 Mn2fkzOI9XiNfERYw14un8oCH1XggQlYYcz4zTL9lZjZupS2vFVvCKjFZwo5z0yS6nIPM1cUS
 LGuQDd8ZOJ1plRIq1/vZ7RwSUXDkuu4EkpnJrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file is the only thing preventing us from building the
driver in a cross-platform configuration, so move the structure
we are interested in to the global platform_data location
and enable compile testing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ep93xx/include/mach/platform.h |  7 +------
 drivers/net/ethernet/cirrus/Kconfig          |  2 +-
 drivers/net/ethernet/cirrus/ep93xx_eth.c     |  2 +-
 include/linux/platform_data/eth-ep93xx.h     | 10 ++++++++++
 4 files changed, 13 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/platform_data/eth-ep93xx.h

diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
index 6c41c794bed5..43446f33c2be 100644
--- a/arch/arm/mach-ep93xx/include/mach/platform.h
+++ b/arch/arm/mach-ep93xx/include/mach/platform.h
@@ -5,6 +5,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/platform_data/eth-ep93xx.h>
 #include <linux/reboot.h>
 
 struct device;
@@ -15,12 +16,6 @@ struct ep93xxfb_mach_info;
 struct ep93xx_keypad_platform_data;
 struct ep93xx_spi_info;
 
-struct ep93xx_eth_data
-{
-	unsigned char	dev_addr[6];
-	unsigned char	phy_id;
-};
-
 void ep93xx_map_io(void);
 void ep93xx_init_irq(void);
 
diff --git a/drivers/net/ethernet/cirrus/Kconfig b/drivers/net/ethernet/cirrus/Kconfig
index e9a0213b08c4..6238e6951336 100644
--- a/drivers/net/ethernet/cirrus/Kconfig
+++ b/drivers/net/ethernet/cirrus/Kconfig
@@ -41,7 +41,7 @@ config CS89x0_PLATFORM
 
 config EP93XX_ETH
 	tristate "EP93xx Ethernet support"
-	depends on ARM && ARCH_EP93XX
+	depends on (ARM && ARCH_EP93XX) || COMPILE_TEST
 	select MII
 	help
 	  This is a driver for the ethernet hardware included in EP93xx CPUs.
diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index 13dfdfca49fc..a6da9873570b 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -25,7 +25,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include <mach/hardware.h>
+#include <linux/platform_data/eth-ep93xx.h>
 
 #define DRV_MODULE_NAME		"ep93xx-eth"
 #define DRV_MODULE_VERSION	"0.1"
diff --git a/include/linux/platform_data/eth-ep93xx.h b/include/linux/platform_data/eth-ep93xx.h
new file mode 100644
index 000000000000..8eef637a804d
--- /dev/null
+++ b/include/linux/platform_data/eth-ep93xx.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PLATFORM_DATA_ETH_EP93XX
+#define _LINUX_PLATFORM_DATA_ETH_EP93XX
+
+struct ep93xx_eth_data {
+	unsigned char	dev_addr[6];
+	unsigned char	phy_id;
+};
+
+#endif
-- 
2.20.0

