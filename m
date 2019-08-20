Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC71C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AA022CF4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfHTJ4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:56:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51889 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbfHTJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:56:41 -0400
Received: from orion.localdomain ([95.117.23.32]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWR6x-1hjmFV3PPX-00Xsl0; Tue, 20 Aug 2019 11:56:34 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform: x86: pcengines-apuv2: detect apuv4 board
Date:   Tue, 20 Aug 2019 11:56:32 +0200
Message-Id: <1566294992-703-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:WgNAV2krKnxLCY8x20TlniRC4puehCjaKaSvDFOd5zklm6NcQqU
 Y2cAKov/DYvTPJOmQGexLLH4o3qcKzttVRBcRGNB9rTfCynrr0RZnphMEl6yvLbnzhGhbgI
 gvyGEIqMgTyssIXblGVpLOHGUelv8cFFrVqa5n4T8N+OyDY10x4MvQwNs7Uw4zGRpSW3XyI
 iZ1Wq54ASw0crmfWd3qsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aiDu7tFnQlk=:ZoYeHiLsslBu2VpqoMiC46
 Rav7ZP8oW+RPBE5p3EfdeL7a1K1Yydytv7TXBrlfzI8Bw/TEOPW8JwwsLEPRMV7vBaJwaLRBn
 dRPAUIvlOs/34s7sKk6MErOY9rmv43R+XamOPk4Cr/1LrHYHMsgJS+WlDuDrD18kUwQCOLFOQ
 LFt87WkZlXuz7rj6XcM/gz3EI42HoPV/WtVbQThjFdpvQebFgkf3x+9lofWAVFbW7aoVXzkTH
 5Rjv0E2jLZKHuSN0OxMFtFJSVb0BvashsA9vpc72ERUEI9nYexzU4vcWL09myXHVcXtOIcMY/
 eEo4lXWHadfUs1n6BWsZHfloYo/n753vn7Mk0Vb9X2V7Y4uqmqX62zWt1wa/yRlynrZfGWBg5
 jukXKb5UrHf/qx6jalhkNlTq+cC+Eon839lH+4l4e4nbPwGrzRtXMJdelnicbgVoNcqtOxONc
 7V2iEzGbQVvMXPR0oIjpzYDmwO7OP1HHC4o3EVT2D9w5y4mihSfXxwap4nPRiuY0ppJzKU8li
 RKGaLogjjPP24+QiCE11oo+fi6a72FQCQuSSiNk15nsKiaNlj9LsTbsPmW2RVCchS+6n+AK/s
 syRgmp6Bf/EqCpqPQyX2fHbd5n72bUNqU1elZP4jnvNZT/LzuuoCW94UX/GOu482Wuj4lVjUR
 Mu/WLY2q21zwQbemch5lUiodVLm+rvm+nKqIkwZe7Ul5TrtSwhoTLjnz4vBgqHJUdYlgV6lgS
 qk/3+RCyUw8jCVXKe0DJT1oOyK/8/3H/bcBweA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO stuff on APUv4 seems to be the same as on APUv2, so we just
need to match on DMI data.

Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe
---
 drivers/platform/x86/pcengines-apuv2.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index e4c68ef..ea0c6bb 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -178,6 +178,33 @@
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
1.9.1

