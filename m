Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1DAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C53B4218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 07:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfGaHVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 03:21:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53737 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfGaHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 03:21:18 -0400
Received: from orion.localdomain ([95.117.90.94]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHG4W-1i5ySd0BOq-00DFI6; Wed, 31 Jul 2019 09:21:11 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86/pcengines-apuv2: add mpcie reset gpio export
Date:   Wed, 31 Jul 2019 09:21:10 +0200
Message-Id: <1564557670-10849-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:23H81g46ISdROYhZ+nZlwYGRTmpz9RN/Lrhkne/d7WeRzvym52b
 37kme98Qts62HCKnitY4e1aaSb8pYpYgnUtOY587MduhxWVKYQxbPMbP9IgeU4qwmMzNowP
 L4Et858Sy1rjfeqqljCplx3acZh5CCxS9MKjnQfqz+ILpbsNSiBnnIf4iq6RDigLv6gSZG8
 WGWM5vfFph1c/Jvvg8s4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b09l3q9YQlw=:GfeJo64D52RlYrgxBvRsNu
 VGp+Uy1xPtjXYHuDcagr7ntimY9xMwSolS9lJxnZ5giFv9RQQXNU4zYEEP25EVT75K9++ooyG
 jHOxv+hAnMuePyqya+tgWdp/bueQniWb5hgUcKUw7clfg/11Kgf2BXBWvXtH2UhOnVfwRVmBZ
 p3hPoBfzaJDeMQFC4OalDHwJRB7x0k5n2gRdGcfyx51TlZKv82EZS8eqgzBtY3pzYEccATCkZ
 YOJHhIkLoYwcQJkV7at5G/VkrTdhep9IDLXont8pUBGa/kIVunmEXd0xPh4e5LRGz7kRAQdNt
 uspBlnCcJTLIakLLY+x9rzqRtl21anpaTa+78SmwC49zbj/BbIJSAS3XYotxu/3Q5zWntGDVg
 Z/LVWUbBO3U6TjUYX1/lb6XpsFv/ln7ooTtfkbqZ3JHiaVrkLBce2K24piKGo69zBdTl439jt
 anIV62ac1lRe/l2Fsqkqi3MPCCwI064fdai7XObxViHZCniPNKbN9L4D0HGx6wWlCQehvpfV1
 tfL7aldQFTQoatuY9l+wqb3ULB8WfH85pXYS4wdACGyPjUlN3icK8gLwqNv7923oey+HWu6tH
 BvdAofDFeEtutMUt1FR/nh2MNXio1PWhz0zVtIN9mC7MGxkXccLwDV8XsMIPUks4zEivTU9TH
 0HcLGVbfVQsw7dmW7/ogeTtSyHaH8YtgYA1MhFZC8nNpPISczyGEV3ky2fqRSitj1Mu0EiLcw
 5ff7Ze0lOTLbwdFCshh5EmtWXTZZpcHZG+6FMQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Eckert <fe@dev.tdt.de>

On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
the ports from the userspace, add the definition to this platform
device. The gpio can then be exported by the legancy gpio subsystem to
toggle the mpcie reset pin.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
Acked-By: Enrico Weigelt <info@metux.net>
Author: Florian Eckert <fe@dev.tdt.de>
---
 drivers/platform/x86/pcengines-apuv2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index e4c68ef..56703656 100644
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
 
@@ -48,6 +52,8 @@
 	[APU2_GPIO_LINE_LED3]		= APU2_GPIO_REG_LED3,
 	[APU2_GPIO_LINE_MODESW]		= APU2_GPIO_REG_MODESW,
 	[APU2_GPIO_LINE_SIMSWAP]	= APU2_GPIO_REG_SIMSWAP,
+	[APU2_GPIO_LINE_MPCIE2]		= APU2_GPIO_REG_MPCIE2,
+	[APU2_GPIO_LINE_MPCIE3]		= APU2_GPIO_REG_MPCIE3,
 };
 
 static const char * const apu2_gpio_names[] = {
@@ -56,6 +62,8 @@
 	[APU2_GPIO_LINE_LED3]		= "front-led3",
 	[APU2_GPIO_LINE_MODESW]		= "front-button",
 	[APU2_GPIO_LINE_SIMSWAP]	= "simswap",
+	[APU2_GPIO_LINE_MPCIE2]		= "mpcie2_reset",
+	[APU2_GPIO_LINE_MPCIE3]		= "mpcie3_reset",
 };
 
 static const struct amd_fch_gpio_pdata board_apu2 = {
-- 
1.9.1

