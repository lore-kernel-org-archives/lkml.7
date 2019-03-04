Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D0FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E354206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfCDUYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:24:11 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58823 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDUYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:24:11 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Ml76o-1hNtbX3KMW-00lZFu; Mon, 04 Mar 2019 21:24:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] phy: allwinner: allow compile testing
Date:   Mon,  4 Mar 2019 21:23:56 +0100
Message-Id: <20190304202406.1716350-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:otm8/2cZ6fCmXwrkax243T6EKj6TDGcTFhnKQ3Js+OCwc8sROTN
 PUZYs1b0SXIGNaFqfiF3fDD/+eXKdYyZsQ4H3DADLSEDUzYGTkfTs0uAzkTrZWVxQ8UKr6/
 7duNzr2JJM2UIHTMvI18nqGVICrjcc8oDEwmsI8skrl6t6//RwjXj3q+jykEbbTKstWXYkV
 BLHbfybP5KfUVOqk7SxxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixsoeeLvbuA=:TsYI6q74dui33r9hVIm9Jj
 1BJNxRDcF9j+nFLwT10o/fT2O6JsY3I6Gx6OwTqDkzVbpZNqZBhXWOKvuYr6d/S/LJi8xqr4g
 6rjV1vc3KYjDF3iJWqLp7PppRgSHNoiNFj52MVdEL9VqkyflYDvJ831bSuhADcziuNfmjOrXQ
 5aBRdmXJIfNa9/5G2vXg8PjwiRjF1rUdPwjNu94E/dIFAK/rvcJI8wnI2YWaWsFaVubIuLnDK
 j5qGIR9OHI8lJaWBeW/K0Lyd1sMpsZDr0XVh8yFEEyC8Veo4HZciG0ooBTlHjuSw/v7wzRJCG
 TnMFNVVNoZeW1dFqkCdYyzU5DqR010sCfhBcwZkccrt0WC82/tnuLsinpenHI0Py05f52V+fm
 N0kR8KndKvuzCFbC01g4zGp0SjwWLgnB5SvxRZd+vCRvb8EOKt03XkZIsr4cUWlXsoVWCdFI8
 Ay2z8pyOa6nmJ3yuzfKOfoqIFuf2A8SZHJRvOVVVH+OjvuttHnRd/KT2G3BI/UapFSMHPTudw
 v75bK3luCP3IOz8728Iz/a2Wuwei5d/Wu86QulVCW65123+3TiutfHWN8NVlweywXIYBtggqz
 PaXgYCKM1dT1hHIKh9vymB3m5Q8FVe5Tk7Ml9Yve4E7z3xtOKA+GgZ99sOIIwb2z0y3B2z05K
 XYAEY3eTA3Tq+rbGLsS34zWGsTZAMPpkUKIbpKmczAqFdouR4zheXA4ehvoN03ZaqUCVnE1xF
 8Tn65PT6kVw2dnpZEk5ka6920Kr0rDViIEZOmQ==
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

