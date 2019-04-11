Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E279C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461A120850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDKJc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:32:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19631 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726106AbfDKJc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:32:27 -0400
X-UUID: 7a47800325c04888a9aef94c0fc8b703-20190411
X-UUID: 7a47800325c04888a9aef94c0fc8b703-20190411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <light.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1661400953; Thu, 11 Apr 2019 17:32:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 11 Apr 2019 17:32:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 11 Apr 2019 17:32:20 +0800
From:   Light Hsieh <light.hsieh@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sean.wang@kernel.org>,
        <wsd_upstream@mediatek.com>, Light Hsieh <light.hsieh@mediatek.com>
Subject: [PATCH] pinctrl: Add kernel config PINCTRL_MTK_V2
Date:   Thu, 11 Apr 2019 17:32:18 +0800
Message-ID: <1554975138-801-1-git-send-email-light.hsieh@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A6DD1241F2D8275B83E54A096B950E706E0CC870382B6252B194A838054000E22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since no single Mediatek chip use code for PINCTRL_MTK and code for
PINCTRL_MTK_MOORE/PINCTRL_MTK_PARIS simultaneously, it is better to use
different config to determine if related code will be built or not on
building non-generic kernel.

Add kernel config PINCTRL_MTK_V2 selected by either PINCTRL_MTK_MOORE
or PINCTRL_MTK_PARIS.
Use PINCTRL_MTK and PINCTRL_MTK_V2 to control building of
drivers/pinctrl/medaitek/.
Remove selection of EINT_MTK from PINCTRL_MTK since code for EINT_MTK is
only related to PINCTRL_MTK_MOORE/PINCTRL_MTK_PARIS, i.e. PINCTL_MTK_V2.

---
 drivers/pinctrl/Makefile         |  3 ++-
 drivers/pinctrl/mediatek/Kconfig | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 712184b..fcee0e0 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_PINCTRL_SUNXI)	+= sunxi/
 obj-y				+= ti/
 obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
-obj-y				+= mediatek/
+obj-$(CONFIG_PINCTRL_MTK)	+= mediatek/
+obj-$(CONFIG_PINCTRL_MTK_V2)	+= mediatek/
 obj-$(CONFIG_PINCTRL_ZX)	+= zte/
 obj-y				+= cirrus/
diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index a005cbc..5e26462 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -2,10 +2,15 @@ menu "MediaTek pinctrl drivers"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 
 config EINT_MTK
-	bool "MediaTek External Interrupt Support"
-	depends on PINCTRL_MTK || PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
+	bool "MediaTek External Interrupt driver that is based on PINCTRL_MTK_V2"
+	depends on PINCTRL_MTK_MOORE || PINCTRL_MTK_PARIS || COMPILE_TEST
 	select GPIOLIB
 	select IRQ_DOMAIN
+	help
+	  Say yes here to enable support for MediaTek External Interrupt
+	  (EINT) driver based on PINCTRL_MTK version 2.
+	  This driver is combined with MediaTek Pinctrl driver version 2
+	  so PINCTRL_MTK_V2 shall be set first.
 
 config PINCTRL_MTK
 	bool
@@ -13,9 +18,11 @@ config PINCTRL_MTK
 	select PINMUX
 	select GENERIC_PINCONF
 	select GPIOLIB
-	select EINT_MTK
 	select OF_GPIO
 
+config PINCTRL_MTK_V2
+	bool "MediaTek Pinctrl Support V2"
+
 config PINCTRL_MTK_MOORE
 	bool
 	depends on OF
@@ -24,6 +31,7 @@ config PINCTRL_MTK_MOORE
 	select GENERIC_PINMUX_FUNCTIONS
 	select GPIOLIB
 	select OF_GPIO
+	select PINCTRL_MTK_V2
 
 config PINCTRL_MTK_PARIS
 	bool
@@ -33,6 +41,7 @@ config PINCTRL_MTK_PARIS
 	select GPIOLIB
 	select EINT_MTK
 	select OF_GPIO
+	select PINCTRL_MTK_V2
 
 # For ARMv7 SoCs
 config PINCTRL_MT2701
-- 
1.8.1.1.dirty

