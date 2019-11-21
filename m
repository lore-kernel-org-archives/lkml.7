Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE4720692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKUP6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:58:05 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55157 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUP6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:58:04 -0500
Received: from orion.localdomain ([95.115.120.75]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MPosX-1iBbIX35UJ-00Mqxr; Thu, 21 Nov 2019 16:58:03 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform: x86: pcengines-apuv2: detect apuv4 board
Date:   Thu, 21 Nov 2019 16:57:43 +0100
Message-Id: <20191121155743.28755-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:FFinIR+bmKvR9eQY2dnfiPu7KToYiAC40zr4SVkjX/oUxI3pU5/
 yMjbACur20mr0gM3qTEwWleo9ehKTi48w2Dz9vJ5n+gfgeZLgAjLdaZjXQx4djSCupx6B+M
 8V/yZjRM5u8z60ikJuuGe4P8pFH8kCsMT4vGNb1wdmHtzg1WeIl/dq+LqmBVAmS+yoWV+Dr
 EmP7d3FP3YE49CHo9ZrZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Gs8DMwwI9c=:8tVTICvQLHhhm2GvbeJPYP
 MfYfayyAxv6F9lPO4wPuXU4Uq5F2v3R4W5moWj4OaDLaq/4bX00kzb/Ar7MDkPWk6zBB0dIBk
 e1gSkuXVAqH8woju+fGDLyJK8shXLhHIw3zYZoeKkcmEmT1vv6BqmR0/S7krKLOxPJuz9ty+k
 0kgvf44gU7VL96QM5GCbkTZ4SzgXAgEvKR4OjCqx4h++ZL7wWyCFGJaPYXBdq+OjzgAkx3IF5
 OF9aykoHHs2FvVC7LTPNRThyFCelHUJxphMBuzej/+AgRpNbLIsWQGnhboWQAucV/V63t5ExQ
 EuYo/9oxFMb4vclUyhlorIu1QQbStndk7SYmgQZ/JVvvOfQp1n97F1qvsLFFYoGR6i/O3yz9y
 KhlMnsDPsiS5+jmHAj0+kPEgDMOXtE4DA9Q9GcLN7M6Xdi74smrHT89eBPVzmQWaB7uzI57PP
 n9x/08Frp2X1f4IjnjnXUyhyFz0j2dubrbuoRr9l28jnwJLMS83GjHI7J3XBW4Fk9l1iqlHv3
 2GROououNCqM9SaD54rAqZys1BBK1Og6GeLUFPxdoUxgTpt1CdNBuSuU1e7hZEJoa4YstJQEL
 hVfEI9fYNQWiLyyq1y9Omnxf7YjktxBP1PNW5wm2LiZMC3JDRKsE1ACqf7YoP/870e+of5Z6o
 YmlHmUeFQHMF+fd4shqW+MRiQ5sPDc5JOzm7Ne6Nq6TwLE/iLaGs8AtcWlEXbNB7T/v8YD4Kc
 b4qTT948R9V2U7DJ55gA6GxqQTTmjo1ITaEqZdtG/Hb8OzUeZa17l+PwWUnNH/URy+yu13QMM
 ZyP3b0CDQhXkiHY1gxO0FwLHNykS8TCBChuyauespVn8jCeN3xrO0Ze8meEbWuJCRFN+SYohL
 oPUHmXIIgjoJjSo4I5Hg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO stuff on APUv4 seems to be the same as on APUv2, so we just
need to match on DMI data.

Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe
Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/platform/x86/pcengines-apuv2.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 48b112b4f0b0..49f25bffce3c 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -189,6 +189,33 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 		},
 		.driver_data = (void *)&board_apu2,
 	},
+	/* APU4 w/ legacy bios < 4.0.8 */
+	{
+		.ident        = "apu4",
+		.matches    = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU4")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
+	/* APU4 w/ legacy bios >= 4.0.8 */
+	{
+		.ident       = "apu4",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu4")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
+	/* APU4 w/ mainline bios */
+	{
+		.ident       = "apu4",
+		.matches     = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu4")
+		},
+		.driver_data = (void *)&board_apu2,
+	},
 	{}
 };
 
-- 
2.11.0

