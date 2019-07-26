Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F87C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50499218DA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfGZGVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:21:32 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:65147
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725869AbfGZGVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:21:31 -0400
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 22E5A21602;
        Fri, 26 Jul 2019 06:21:29 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v2 1/1] platform/x86/pcengines-apuv2: add mpcie reset gpio export
Date:   Fri, 26 Jul 2019 08:21:15 +0200
Message-Id: <20190726062115.16231-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
the ports from the userspace, add the definition to this platform
device. The gpio can then be exported by the legancy gpio subsystem to
toggle the mpcie reset pin.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---

v2:
  Noting changed for this patch. Only resend because other patches of
  the series where dropped or updated and resend by other people

 drivers/platform/x86/pcengines-apuv2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index c1ca931e1fab..f6d8ed100cab 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -32,6 +32,8 @@
 #define APU2_GPIO_REG_LED3		AMD_FCH_GPIO_REG_GPIO59_DEVSLP1
 #define APU2_GPIO_REG_MODESW		AMD_FCH_GPIO_REG_GPIO32_GE1
 #define APU2_GPIO_REG_SIMSWAP		AMD_FCH_GPIO_REG_GPIO33_GE2
+#define APU2_GPIO_REG_MPCIE2		AMD_FCH_GPIO_REG_GPIO59_DEVSLP0
+#define APU2_GPIO_REG_MPCIE3		AMD_FCH_GPIO_REG_GPIO51
 
 /* order in which the gpio lines are defined in the register list */
 #define APU2_GPIO_LINE_LED1		0
@@ -39,6 +41,8 @@
 #define APU2_GPIO_LINE_LED3		2
 #define APU2_GPIO_LINE_MODESW		3
 #define APU2_GPIO_LINE_SIMSWAP		4
+#define APU2_GPIO_LINE_MPCIE2		5
+#define APU2_GPIO_LINE_MPCIE3		6
 
 /* gpio device */
 
@@ -48,6 +52,8 @@ static int apu2_gpio_regs[] = {
 	[APU2_GPIO_LINE_LED3]		= APU2_GPIO_REG_LED3,
 	[APU2_GPIO_LINE_MODESW]		= APU2_GPIO_REG_MODESW,
 	[APU2_GPIO_LINE_SIMSWAP]	= APU2_GPIO_REG_SIMSWAP,
+	[APU2_GPIO_LINE_MPCIE2]		= APU2_GPIO_REG_MPCIE2,
+	[APU2_GPIO_LINE_MPCIE3]		= APU2_GPIO_REG_MPCIE3,
 };
 
 static const char * const apu2_gpio_names[] = {
@@ -56,6 +62,8 @@ static const char * const apu2_gpio_names[] = {
 	[APU2_GPIO_LINE_LED3]		= "front-led3",
 	[APU2_GPIO_LINE_MODESW]		= "front-button",
 	[APU2_GPIO_LINE_SIMSWAP]	= "simswap",
+	[APU2_GPIO_LINE_MPCIE2]		= "mpcie2_reset",
+	[APU2_GPIO_LINE_MPCIE3]		= "mpcie3_reset",
 };
 
 static const struct amd_fch_gpio_pdata board_apu2 = {
-- 
2.11.0

