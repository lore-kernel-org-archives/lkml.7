Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6051C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964DC2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714126;
	bh=cIpuZnpyq/TmAYcpoMyCiTg7Gr/A4hgnYe6oTwNUWjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mRNPLU39lyQhOfaKtDU08uzdwuf7Pxf6Vu5A0o2KIw1pFnIUx7ILouA8Yhr+vGhlm
	 pV/nikXsKbOsbA6QdGBEt8TWHJLZ6Qojbrue+HBr1gczQCCHq4YESUZvnOox3Bh1mM
	 32YjVuHQS8MWlzlvnyZ8g0U2HsBr771VGJ6y53sY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388897AbfC0TPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388554AbfC0SJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:09:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDC782183F;
        Wed, 27 Mar 2019 18:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710161;
        bh=cIpuZnpyq/TmAYcpoMyCiTg7Gr/A4hgnYe6oTwNUWjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZMjpd3IU3LkNux5wLAe5kkAhW2fJYYYzPc0JkHoiVlddX+fKLv8PRV8pwXI6jevx
         5nplDOBxJIb3Hr5NkoiEft6pTghifRRV3uyTxpzYF79EBUjDq9wyVN7ehEO7KjirNI
         iAsKrvW55BsHLD4cULzmCKPgfMjW5sMamA0Qrzi4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 228/262] pinctrl: sh-pfc: r8a77995: Fix MOD_SEL bit numbering
Date:   Wed, 27 Mar 2019 14:01:23 -0400
Message-Id: <20190327180158.10245-228-sashal@kernel.org>
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

[ Upstream commit 5219aa33caec2f7b68eda2b7e4ab8e276f323254 ]

MOD_SEL register bit numbering was different from R-Car D3 SoC and
R-Car H3/M3-[WN] SoCs.

MOD_SEL 1-bit      H3/M3-[WN]  D3
===============    ==========  =====
Set Value = H'0    b'0         b'0
Set Value = H'1    b'1         b'1

MOD_SEL 2-bits     H3/M3-[WN]  D3
===============    ==========  =====
Set Value = H'0    b'00        b'00
Set Value = H'1    b'01        b'10
Set Value = H'2    b'10        b'01
Set Value = H'3    b'11        b'11

MOD_SEL 3-bits     H3/M3-[WN]  D3
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
Fixes: 794a67117646 ("pinctrl: sh-pfc: Initial R8A77995 PFC support")
[shimoda: split a patch per SoC and revise the commit log]
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[geert: Use a macro to do the actual reordering]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
index 84d78db381e3..9e377e3b9cb3 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
@@ -381,6 +381,9 @@ FM(IP12_23_20)	IP12_23_20 \
 FM(IP12_27_24)	IP12_27_24 \
 FM(IP12_31_28)	IP12_31_28 \
 
+/* The bit numbering in MOD_SEL fields is reversed */
+#define REV4(f0, f1, f2, f3)			f0 f2 f1 f3
+
 /* MOD_SEL0 */			/* 0 */			/* 1 */			/* 2 */			/* 3 */
 #define MOD_SEL0_30		FM(SEL_MSIOF2_0)	FM(SEL_MSIOF2_1)
 #define MOD_SEL0_29		FM(SEL_I2C3_0)		FM(SEL_I2C3_1)
@@ -388,10 +391,10 @@ FM(IP12_31_28)	IP12_31_28 \
 #define MOD_SEL0_27		FM(SEL_MSIOF3_0)	FM(SEL_MSIOF3_1)
 #define MOD_SEL0_26		FM(SEL_HSCIF3_0)	FM(SEL_HSCIF3_1)
 #define MOD_SEL0_25		FM(SEL_SCIF4_0)		FM(SEL_SCIF4_1)
-#define MOD_SEL0_24_23		FM(SEL_PWM0_0)		FM(SEL_PWM0_1)		FM(SEL_PWM0_2)		F_(0, 0)
-#define MOD_SEL0_22_21		FM(SEL_PWM1_0)		FM(SEL_PWM1_1)		FM(SEL_PWM1_2)		F_(0, 0)
-#define MOD_SEL0_20_19		FM(SEL_PWM2_0)		FM(SEL_PWM2_1)		FM(SEL_PWM2_2)		F_(0, 0)
-#define MOD_SEL0_18_17		FM(SEL_PWM3_0)		FM(SEL_PWM3_1)		FM(SEL_PWM3_2)		F_(0, 0)
+#define MOD_SEL0_24_23	   REV4(FM(SEL_PWM0_0),		FM(SEL_PWM0_1),		FM(SEL_PWM0_2),		F_(0, 0))
+#define MOD_SEL0_22_21	   REV4(FM(SEL_PWM1_0),		FM(SEL_PWM1_1),		FM(SEL_PWM1_2),		F_(0, 0))
+#define MOD_SEL0_20_19	   REV4(FM(SEL_PWM2_0),		FM(SEL_PWM2_1),		FM(SEL_PWM2_2),		F_(0, 0))
+#define MOD_SEL0_18_17	   REV4(FM(SEL_PWM3_0),		FM(SEL_PWM3_1),		FM(SEL_PWM3_2),		F_(0, 0))
 #define MOD_SEL0_15		FM(SEL_IRQ_0_0)		FM(SEL_IRQ_0_1)
 #define MOD_SEL0_14		FM(SEL_IRQ_1_0)		FM(SEL_IRQ_1_1)
 #define MOD_SEL0_13		FM(SEL_IRQ_2_0)		FM(SEL_IRQ_2_1)
-- 
2.19.1

