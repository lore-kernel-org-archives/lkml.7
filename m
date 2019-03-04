Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F9AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B9A206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfCDUYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:24:33 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:34529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:24:33 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHFwM-1gnkyI0qI4-00DIlm; Mon, 04 Mar 2019 21:24:26 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Roger Quadros <rogerq@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] phy: ti: usb2: fix OMAP_CONTROL_PHY dependency
Date:   Mon,  4 Mar 2019 21:23:57 +0100
Message-Id: <20190304202406.1716350-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304202406.1716350-1-arnd@arndb.de>
References: <20190304202406.1716350-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JQmSenYXKz0L0BH+G3P7TY1KisuMQn0QAx1QkrKe2qDgQGQMrTQ
 ESSgdIMGeWW9yzezgH/Qx9E0QJBCyIppPHjLqXU1kAQEDVDDq1X7+3SklTrCn5133oVA7kd
 HPcAvx7ub5KYYTcZYkPmJ383/IC69nkGTQKXLgdi+yHmtCqwufG5D8KJGMCk1TfYQEmvMc6
 gS3hOTsbvjl1+PNeJQdYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FRjI4uFPDe4=:N9u4e4zQicx39gEeMMAziA
 XkdZIZ4KZEfeYXi1KcNK4e/QFcFkGfsAf8D1TP2Gjk1f9YLult+/0ryKjoj0cwblahtP6ojXT
 o9K9YCxnNxp9E9/UAqEbFYeA08YKaqgBoU8wvyxyWkLWK3F55D0/YQa66hcLNkxqGb3GjpJ6Y
 Q96QRd45lQsjjpFush718wbCv8a4KVwX0AhN2HN7n4cNvDKDfOTbTbIAaB/l1JO74ydoc6fdg
 qh81ggJokvmxqFCJlUjylWfRu+8YiPYKqFS0JyEm1rr6csb/qiaxnz5iqB9ZDaZL683vcmMAc
 vmHLrXA0WQg29l9Pr8Hu+96eQwINKgrd9qLHRRrUZVL6ukzIqz8wJ/PwZJFs/reA/BDGdPZ5z
 /bGcELv8VdeqHabZu/uQw7k7X5BzkyQBOm/JK8WHiuRis82ORsYu0ue+7r3/PALHU1mABSeOH
 lNlAFsn5KJ2ayNGZd7hvwRE1QVwiUta41exSOvpu2mZ//PsyrI99mp11Fr0OdaieFF0UeMvSk
 Ce5UzGz12pD+/siGaZTaS7b5UyU6NRmzcDYYvKZhIIshVu+qrpXUv+y6sUFiCBdYC2uM4Y8YL
 CfbMpiOQHfP9fJ0HsjGo8QhC6xkC1FVsDWDlsbjUsm5r7AqdM/vLrEngD712RQ6hjTCo1yJE/
 6JOpPIvINapgVpnd6LR0gROo5pIHQllOCzqdYrAOb0UUOFyYVZLFury55P1jOvxK+JstBia4E
 Cg4P8gaOjH8yEDl2CJ+kZfgPEnT6NPvBEygAuA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With randconfig build testing on arm64, we can run into a configuration
that has CONFIG_OMAP_CONTROL_PHY=m and CONFIG_OMAP_USB2=y, which in turn
causes a link failure:

drivers/phy/ti/phy-omap-usb2.o: In function `omap_usb_phy_power':
phy-omap-usb2.c:(.text+0x17c): undefined reference to `omap_control_phy_power'

I could not come up with a good way to correctly describe the relation
of the two symbols, but if we just select CONFIG_OMAP_CONTROL_PHY
during compile testing, we can no longer run into the broken configuration.

Fixes: 6777cee3a872 ("phy: ti: usb2: Add support for AM654 USB2 PHY")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/ti/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/Kconfig b/drivers/phy/ti/Kconfig
index 103efc456a12..022ac16f626c 100644
--- a/drivers/phy/ti/Kconfig
+++ b/drivers/phy/ti/Kconfig
@@ -37,7 +37,7 @@ config OMAP_USB2
 	depends on USB_SUPPORT
 	select GENERIC_PHY
 	select USB_PHY
-	select OMAP_CONTROL_PHY if ARCH_OMAP2PLUS
+	select OMAP_CONTROL_PHY if ARCH_OMAP2PLUS || COMPILE_TEST
 	help
 	  Enable this to support the transceiver that is part of SOC. This
 	  driver takes care of all the PHY functionality apart from comparator.
-- 
2.20.0

