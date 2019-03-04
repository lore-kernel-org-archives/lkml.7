Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB13EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5220835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfCDUXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:23:17 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:43961 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDUXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:23:16 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N9dbx-1h3upI0r0X-015Z5l; Mon, 04 Mar 2019 21:23:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] phy: allwinner: allow compile testing
Date:   Mon,  4 Mar 2019 21:22:49 +0100
Message-Id: <20190304202309.1693081-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FZ2QqYazWAQbqQUgxRGHdnjfqSER0/ElGlN+o13LbhtqTD+KCGe
 xTb0iTla+g1htOsC8sCUGLRAbpGZ4vecTy2m6v+q/MHprBfzIbRNviweE5K1dljjIZtsfM8
 W2lCwvDwgVz5r7j5BFK1fJlJmZLJrdE9VKX05ZYmJxxBID+RHXC2gRhUi/Jhs9J7OtE7Dje
 27wguo1PqLNQa/8HboIqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UmhY1f6dKNo=:hPZfuX99m2Q2s+cnuP04FQ
 VoZT28S7wE00FiTrmqPj2xxkxyQKwu0kb61cYAJlCYQEa+vEChgW7swyvyBALrXbf5cqDqsar
 odvfAW1olXLpyxbd6jmMmaNQ4lC56iQ92Nts1blU8S7YH7Cfn4r645lZsUrZeR+BO32XAOkOJ
 C2CV/NclOp7nzrC+q7DLyeyrCfNham28dCREJkMIr2k/8Rhnb3a2XJcyDzkjvrwCfieZkP9rk
 UvRo/76tfWpvwtZfk8tHNuGDD17UQWp3HEJYlHVChClrfvW/qgrIgRlUiwM621rfdrBXBndhX
 olldxKK8tRx5KbgbbUagF2b8JvMraYzFGBfZ6e7nLBTDeauKdf0Ey/upvCikvttqcdLsKEDN3
 mKbnnDR9ZTUFIZGUyHvUMZ8rXlfIF3X/yYhnNRsR53g+0yEvWvTnQa2nYO5RIAAE2cgfOFrNC
 2MXOr9ADtnUC2sjK/MQrrVWRP3BZYCpycKf82GyJsPi3yLg44BtSYzaZlQpk62W3v1VkpF59G
 HttY1eYLSbcLFFNle97xGzrEP/P8P+gJINCuaxol9HxbjJNBQm3sKnofU5yQIb/oiht5kTc+D
 zjbXVE2i5OrxVgeS9v1QFxv2PTv2BZ5KOHn2//KwnQhdQloSb/6q2jctAqjepb9O9JN6HEFmk
 dBajRhF9bYAGC74UE1sc7Bub2vi2EDOT+HB/MUTgxX2+mFJfZHkSPJNWjicjJrbLLrCi+eCwn
 YfzsOn7HBpMlhQSKYzgkAxPtzGVm9seUj1Hb/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some allwinner specific drivers can be built for testing purposes
on non-sunxi configurations, which then results in a harmless
warning:

WARNING: unmet direct dependencies detected for PHY_SUN6I_MIPI_DPHY
  Depends on [n]: ARCH_SUNXI [=n] && HAS_IOMEM [=y] && OF [=y] && RESET_CONTROLLER [=y]
  Selected by [y]:
  - DRM_SUN6I_DSI [=y] && HAS_IOMEM [=y] && DRM_SUN4I [=y]

Allow compile-test here as well to avoid the warning, and improve
overall build coverage.

Fixes: 5d134abf9530 ("phy: Move Allwinner A31 D-PHY driver to drivers/phy/")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/allwinner/Kconfig | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/allwinner/Kconfig b/drivers/phy/allwinner/Kconfig
index fb1204bcc454..53772d35b36e 100644
--- a/drivers/phy/allwinner/Kconfig
+++ b/drivers/phy/allwinner/Kconfig
@@ -3,7 +3,8 @@
 #
 config PHY_SUN4I_USB
 	tristate "Allwinner sunxi SoC USB PHY driver"
-	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on RESET_CONTROLLER
 	depends on EXTCON
 	depends on POWER_SUPPLY
@@ -19,7 +20,8 @@ config PHY_SUN4I_USB
 
 config PHY_SUN6I_MIPI_DPHY
 	tristate "Allwinner A31 MIPI D-PHY Support"
-	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on RESET_CONTROLLER
 	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
@@ -31,7 +33,8 @@ config PHY_SUN6I_MIPI_DPHY
 
 config PHY_SUN9I_USB
 	tristate "Allwinner sun9i SoC USB PHY driver"
-	depends on ARCH_SUNXI && HAS_IOMEM && OF
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on RESET_CONTROLLER
 	depends on USB_SUPPORT
 	select USB_COMMON
-- 
2.20.0

