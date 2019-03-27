Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B40C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3663B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714134;
	bh=+jRmlI9jydengIYYee9lkuKne34KR/MTF4Wa1DnWYyU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JgSFSTuWdUGHhYQ0b/T8Wl8tVmIUf5lTJkClsD2iAh/aIWOc0kFtCdQAG/DayT5uN
	 Y730x1TZOrUW0kWouYolNlSe2dU/8IB5dUYhKnNAdhsx3so2ZfReXbG7WXFb8bzPY7
	 CAVzprCcjtEAshSdR16TdHMmXDpcFgKV+6Uv3wKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbfC0TPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:15:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:51178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388546AbfC0SJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77551217F9;
        Wed, 27 Mar 2019 18:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710160;
        bh=+jRmlI9jydengIYYee9lkuKne34KR/MTF4Wa1DnWYyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OP1xxOrRb/ihKb0pAHIusXdm+f8jJbXIXeAAZurGkzQNapcwzj93JhWP9WpgiP50s
         jE4cNINOnUpMmKoLVgS/xpttl6TuqWtHY3FsxrFhsAtGP5jqESGfUAls4At/3K7mcY
         mjoQqfJq0ET/plPBUWI/Tz2H/Es+l0cS7qoIxQW0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 227/262] pinctrl: sh-pfc: r8a77990: Fix MOD_SEL bit numbering
Date:   Wed, 27 Mar 2019 14:01:22 -0400
Message-Id: <20190327180158.10245-227-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

[ Upstream commit 3e3eebeacad79bda8a9664c86c04f5201e86fece ]

MOD_SEL register bit numbering was different from R-Car E3 SoC and
R-Car H3/M3-[WN] SoCs.

MOD_SEL 1-bit      H3/M3-[WN]  E3
===============    ==========  =====
Set Value = H'0    b'0         b'0
Set Value = H'1    b'1         b'1

MOD_SEL 2-bits     H3/M3-[WN]  E3
===============    ==========  =====
Set Value = H'0    b'00        b'00
Set Value = H'1    b'01        b'10
Set Value = H'2    b'10        b'01
Set Value = H'3    b'11        b'11

MOD_SEL 3-bits     H3/M3-[WN]  E3
===============    ==========  =====
Set Value = H'0    b'000       b'000
Set Value = H'1    b'001       b'100
Set Value = H'2    b'010       b'010
Set Value = H'3    b'011       b'110
Set Value = H'4    b'100       b'001
Set Value = H'5    b'101       b'101
Set Value = H'6    b'110       b'011
Set Value = H'7    b'111       b'111

This patch replaces the #define name and value of MOD_SEL.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Fixes: 6d4036a1e3b3 ("pinctrl: sh-pfc: Initial R8A77990 PFC support")
[shimoda: Split a patch per SoC and revise the commit log]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[geert: Use macros to do the actual reordering]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c | 32 +++++++++++++++------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
index e40908dc37e0..1ce286f7b286 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77990.c
@@ -391,29 +391,33 @@ FM(IP12_23_20)	IP12_23_20	FM(IP13_23_20)	IP13_23_20	FM(IP14_23_20)	IP14_23_20	FM
 FM(IP12_27_24)	IP12_27_24	FM(IP13_27_24)	IP13_27_24	FM(IP14_27_24)	IP14_27_24	FM(IP15_27_24)	IP15_27_24 \
 FM(IP12_31_28)	IP12_31_28	FM(IP13_31_28)	IP13_31_28	FM(IP14_31_28)	IP14_31_28	FM(IP15_31_28)	IP15_31_28
 
+/* The bit numbering in MOD_SEL fields is reversed */
+#define REV4(f0, f1, f2, f3)			f0 f2 f1 f3
+#define REV8(f0, f1, f2, f3, f4, f5, f6, f7)	f0 f4 f2 f6 f1 f5 f3 f7
+
 /* MOD_SEL0 */			/* 0 */				/* 1 */				/* 2 */				/* 3 */			/* 4 */			/* 5 */		/* 6 */		/* 7 */
-#define MOD_SEL0_30_29		FM(SEL_ADGB_0)			FM(SEL_ADGB_1)			FM(SEL_ADGB_2)			F_(0, 0)
+#define MOD_SEL0_30_29	   REV4(FM(SEL_ADGB_0),			FM(SEL_ADGB_1),			FM(SEL_ADGB_2),			F_(0, 0))
 #define MOD_SEL0_28		FM(SEL_DRIF0_0)			FM(SEL_DRIF0_1)
-#define MOD_SEL0_27_26		FM(SEL_FM_0)			FM(SEL_FM_1)			FM(SEL_FM_2)			F_(0, 0)
+#define MOD_SEL0_27_26	   REV4(FM(SEL_FM_0),			FM(SEL_FM_1),			FM(SEL_FM_2),			F_(0, 0))
 #define MOD_SEL0_25		FM(SEL_FSO_0)			FM(SEL_FSO_1)
 #define MOD_SEL0_24		FM(SEL_HSCIF0_0)		FM(SEL_HSCIF0_1)
 #define MOD_SEL0_23		FM(SEL_HSCIF1_0)		FM(SEL_HSCIF1_1)
 #define MOD_SEL0_22		FM(SEL_HSCIF2_0)		FM(SEL_HSCIF2_1)
-#define MOD_SEL0_21_20		FM(SEL_I2C1_0)			FM(SEL_I2C1_1)			FM(SEL_I2C1_2)			FM(SEL_I2C1_3)
-#define MOD_SEL0_19_18_17	FM(SEL_I2C2_0)			FM(SEL_I2C2_1)			FM(SEL_I2C2_2)			FM(SEL_I2C2_3)		FM(SEL_I2C2_4)		F_(0, 0)	F_(0, 0)	F_(0, 0)
+#define MOD_SEL0_21_20	   REV4(FM(SEL_I2C1_0),			FM(SEL_I2C1_1),			FM(SEL_I2C1_2),			FM(SEL_I2C1_3))
+#define MOD_SEL0_19_18_17  REV8(FM(SEL_I2C2_0),			FM(SEL_I2C2_1),			FM(SEL_I2C2_2),			FM(SEL_I2C2_3),		FM(SEL_I2C2_4),		F_(0, 0),	F_(0, 0),	F_(0, 0))
 #define MOD_SEL0_16		FM(SEL_NDFC_0)			FM(SEL_NDFC_1)
 #define MOD_SEL0_15		FM(SEL_PWM0_0)			FM(SEL_PWM0_1)
 #define MOD_SEL0_14		FM(SEL_PWM1_0)			FM(SEL_PWM1_1)
-#define MOD_SEL0_13_12		FM(SEL_PWM2_0)			FM(SEL_PWM2_1)			FM(SEL_PWM2_2)			F_(0, 0)
-#define MOD_SEL0_11_10		FM(SEL_PWM3_0)			FM(SEL_PWM3_1)			FM(SEL_PWM3_2)			F_(0, 0)
+#define MOD_SEL0_13_12	   REV4(FM(SEL_PWM2_0),			FM(SEL_PWM2_1),			FM(SEL_PWM2_2),			F_(0, 0))
+#define MOD_SEL0_11_10	   REV4(FM(SEL_PWM3_0),			FM(SEL_PWM3_1),			FM(SEL_PWM3_2),			F_(0, 0))
 #define MOD_SEL0_9		FM(SEL_PWM4_0)			FM(SEL_PWM4_1)
 #define MOD_SEL0_8		FM(SEL_PWM5_0)			FM(SEL_PWM5_1)
 #define MOD_SEL0_7		FM(SEL_PWM6_0)			FM(SEL_PWM6_1)
-#define MOD_SEL0_6_5		FM(SEL_REMOCON_0)		FM(SEL_REMOCON_1)		FM(SEL_REMOCON_2)		F_(0, 0)
+#define MOD_SEL0_6_5	   REV4(FM(SEL_REMOCON_0),		FM(SEL_REMOCON_1),		FM(SEL_REMOCON_2),		F_(0, 0))
 #define MOD_SEL0_4		FM(SEL_SCIF_0)			FM(SEL_SCIF_1)
 #define MOD_SEL0_3		FM(SEL_SCIF0_0)			FM(SEL_SCIF0_1)
 #define MOD_SEL0_2		FM(SEL_SCIF2_0)			FM(SEL_SCIF2_1)
-#define MOD_SEL0_1_0		FM(SEL_SPEED_PULSE_IF_0)	FM(SEL_SPEED_PULSE_IF_1)	FM(SEL_SPEED_PULSE_IF_2)	F_(0, 0)
+#define MOD_SEL0_1_0	   REV4(FM(SEL_SPEED_PULSE_IF_0),	FM(SEL_SPEED_PULSE_IF_1),	FM(SEL_SPEED_PULSE_IF_2),	F_(0, 0))
 
 /* MOD_SEL1 */			/* 0 */				/* 1 */				/* 2 */				/* 3 */			/* 4 */			/* 5 */		/* 6 */		/* 7 */
 #define MOD_SEL1_31		FM(SEL_SIMCARD_0)		FM(SEL_SIMCARD_1)
@@ -422,18 +426,18 @@ FM(IP12_31_28)	IP12_31_28	FM(IP13_31_28)	IP13_31_28	FM(IP14_31_28)	IP14_31_28	FM
 #define MOD_SEL1_28		FM(SEL_USB_20_CH0_0)		FM(SEL_USB_20_CH0_1)
 #define MOD_SEL1_26		FM(SEL_DRIF2_0)			FM(SEL_DRIF2_1)
 #define MOD_SEL1_25		FM(SEL_DRIF3_0)			FM(SEL_DRIF3_1)
-#define MOD_SEL1_24_23_22	FM(SEL_HSCIF3_0)		FM(SEL_HSCIF3_1)		FM(SEL_HSCIF3_2)		FM(SEL_HSCIF3_3)	FM(SEL_HSCIF3_4)	F_(0, 0)	F_(0, 0)	F_(0, 0)
-#define MOD_SEL1_21_20_19	FM(SEL_HSCIF4_0)		FM(SEL_HSCIF4_1)		FM(SEL_HSCIF4_2)		FM(SEL_HSCIF4_3)	FM(SEL_HSCIF4_4)	F_(0, 0)	F_(0, 0)	F_(0, 0)
+#define MOD_SEL1_24_23_22  REV8(FM(SEL_HSCIF3_0),		FM(SEL_HSCIF3_1),		FM(SEL_HSCIF3_2),		FM(SEL_HSCIF3_3),	FM(SEL_HSCIF3_4),	F_(0, 0),	F_(0, 0),	F_(0, 0))
+#define MOD_SEL1_21_20_19  REV8(FM(SEL_HSCIF4_0),		FM(SEL_HSCIF4_1),		FM(SEL_HSCIF4_2),		FM(SEL_HSCIF4_3),	FM(SEL_HSCIF4_4),	F_(0, 0),	F_(0, 0),	F_(0, 0))
 #define MOD_SEL1_18		FM(SEL_I2C6_0)			FM(SEL_I2C6_1)
 #define MOD_SEL1_17		FM(SEL_I2C7_0)			FM(SEL_I2C7_1)
 #define MOD_SEL1_16		FM(SEL_MSIOF2_0)		FM(SEL_MSIOF2_1)
 #define MOD_SEL1_15		FM(SEL_MSIOF3_0)		FM(SEL_MSIOF3_1)
-#define MOD_SEL1_14_13		FM(SEL_SCIF3_0)			FM(SEL_SCIF3_1)			FM(SEL_SCIF3_2)			F_(0, 0)
-#define MOD_SEL1_12_11		FM(SEL_SCIF4_0)			FM(SEL_SCIF4_1)			FM(SEL_SCIF4_2)			F_(0, 0)
-#define MOD_SEL1_10_9		FM(SEL_SCIF5_0)			FM(SEL_SCIF5_1)			FM(SEL_SCIF5_2)			F_(0, 0)
+#define MOD_SEL1_14_13	   REV4(FM(SEL_SCIF3_0),		FM(SEL_SCIF3_1),		FM(SEL_SCIF3_2),		F_(0, 0))
+#define MOD_SEL1_12_11	   REV4(FM(SEL_SCIF4_0),		FM(SEL_SCIF4_1),		FM(SEL_SCIF4_2),		F_(0, 0))
+#define MOD_SEL1_10_9	   REV4(FM(SEL_SCIF5_0),		FM(SEL_SCIF5_1),		FM(SEL_SCIF5_2),		F_(0, 0))
 #define MOD_SEL1_8		FM(SEL_VIN4_0)			FM(SEL_VIN4_1)
 #define MOD_SEL1_7		FM(SEL_VIN5_0)			FM(SEL_VIN5_1)
-#define MOD_SEL1_6_5		FM(SEL_ADGC_0)			FM(SEL_ADGC_1)			FM(SEL_ADGC_2)			F_(0, 0)
+#define MOD_SEL1_6_5	   REV4(FM(SEL_ADGC_0),			FM(SEL_ADGC_1),			FM(SEL_ADGC_2),			F_(0, 0))
 #define MOD_SEL1_4		FM(SEL_SSI9_0)			FM(SEL_SSI9_1)
 
 #define PINMUX_MOD_SELS	\
-- 
2.19.1

