Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2E2C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542B72072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgAGVwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:52:11 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:47273 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgAGVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:52:11 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ml6Zo-1jXrM32fs4-00lT3G; Tue, 07 Jan 2020 22:51:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: imx: only select ARM_ERRATA_814220 for ARMv7-A
Date:   Tue,  7 Jan 2020 22:51:39 +0100
Message-Id: <20200107215157.1450319-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IOTDqnkpbH8/vAmKOC5zE6L15ys1fxtzqis6/HShFAh2u0AZB8g
 K/VjWhwqUgdufgU1FpFXCGc4KMN7nwf9Ru1cKgdewNw7/2tiqwVpuBW/Ng5b1FMo/h3Ffd2
 gFSlWK3VZiNHUV9J2h9dxIrrCGtwUVS6dTMwvt74SUirIZsD7HYWDtFkDM8VIzW/PShSXvb
 q9FqOZ4A6286lyMWibtag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:agKvm2/8XaQ=:aHsB/iqpC114ScSlWlkfMd
 iDCZuvbSFh0o9sTvsBP11KDeJ9FH/mDWRiO2vMU8oabdc0eL8IuziuaUn0m+GOOG2SOgwsqnD
 OoQHSODU/VpooIWc8xAyCMamMdQMqYv3Hq33k6bBOZw7LjUKrf1WCDER8bvV204TX1pvHtBuI
 nkfYxfImoyybXa41lHQikzPCWaKjA5d4KmVdfv2kWakdh4iZGYwTsY5mX6SBV7pHhGRm8tAyn
 +WG0FH1VUteguMfzDtiBjgHmQ/Yx9QYM/IfBWMo99vZK5w7tm7q6c0DrwLgb7u+F39ixvYVg/
 xTjB1qlnZi/sDDJuOg2l5xrZEaSYzBjqcGtAWjCW5uilXMu/DUwJDdRRzHL4Yffgny10eDEdE
 utRGOKCZwW2JMLw9EY7MnpwlJXXey3twbw6LySMdvM6IIWL9aguWFRKlPDu/gSo//u5DkkF34
 9TkTdiTmcUM9nn3HIwLOSMi782dvJaw/xah+rTGkE1wnQWb5PbMbKwdgYWXSGCm5UMCUTRyQi
 xq03kcX/wYxM5yItjq1BBdkfyhAsTqLipTcMknH5Dftwey06/eNNvJX9leQrwkRbxK0zH697z
 wMzLG2EEudylQl5VvJ3+tCjSKVVrAD9R0prXu4D6zF6xZodT78oe0Xgur5Y2bj/ovunfJeP2r
 khHzPQ0+7wfCP2k1pa5FtuFqWFbHLRuH1EFI/j7j4ke2BTayIgmNaXS5miI7JbLr+lKSpMxdg
 VtD7FzZyr7XjzI9jHcKgp2RmXjmr9mqmihJorRiKArz1egbwtYOzxN+7CylgEOGbZNEJLu8Fs
 2PrpYRWjEYCqJqyv6vX7hqdqjnshZHWyWRew60qFFpQO7kbrP7kMw7qMVeECDW6WUkjX0EdcC
 hmhY8bRT/1NYjcIFGbdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7D is supported for either the v7-A or the v7-M cores,
but the latter causes a warning:

WARNING: unmet direct dependencies detected for ARM_ERRATA_814220
  Depends on [n]: CPU_V7 [=n]
  Selected by [y]:
  - SOC_IMX7D [=y] && ARCH_MXC [=y] && (ARCH_MULTI_V7 [=n] || ARM_SINGLE_ARMV7M [=y])

Make the select statement conditional.

Fixes: 4562fa4c86c9 ("ARM: imx: Enable ARM_ERRATA_814220 for i.MX6UL and i.MX7D")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4326c8f53462..95584ee02b55 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -557,7 +557,7 @@ config SOC_IMX7D
 	select PINCTRL_IMX7D
 	select SOC_IMX7D_CA7 if ARCH_MULTI_V7
 	select SOC_IMX7D_CM4 if ARM_SINGLE_ARMV7M
-	select ARM_ERRATA_814220
+	select ARM_ERRATA_814220 if ARCH_MULTI_V7
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
-- 
2.20.0

