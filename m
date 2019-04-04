Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445E82177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369415;
	bh=XBlXoNZUBBoSgafKCat+RYWkre2LTP5IEDRR9MUG+e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nYFlWftngXg4O02zTp1d+vG0b3rX0hq1nbz2AVH4h00xdE0aDu8B0qQ9FsqF/tNAH
	 qz6qnFJ+EEkHVbHaPscG+Hczu3aaG1OliWJXFrLzbLKNt7bc0zU6MX9W94xBKJ8VNY
	 VnZLstWzappkY/E+denhn8gVLEW8caJhram3WhMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfDDJQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387703AbfDDJQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81482054F;
        Thu,  4 Apr 2019 09:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369410;
        bh=XBlXoNZUBBoSgafKCat+RYWkre2LTP5IEDRR9MUG+e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n6pxEMhxXY0/KXny0N3rSy5/+ytbOPVSYg7yoxExLJriYu80q003VlY5Z/VWt6bZg
         hUV/VwfIAap1wPNzIgK+d98Rv2/VCKKRSpOkAg1Y0RbTIiRGoUxGYuVtKLtse8FjC0
         1v+xc/nVDVtuYBNWiuXbBTm9lxz/kdn2homPDiFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 213/246] pinctrl: sh-pfc: r8a77995: Fix MOD_SEL bit numbering
Date:   Thu,  4 Apr 2019 10:48:33 +0200
Message-Id: <20190404084626.649913177@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



