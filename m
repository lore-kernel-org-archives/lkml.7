Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C33DC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F404422593
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354182;
	bh=5UlIQR2DCq+pOvDPurmJbhIK5FNedXV0/VZEjZx8hAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+C3zZHBjYAlIXxk+Pk/LB8QXLMKFdmkDgPz5V29tZXakj2K+pGGfWiL3o/EAsoq/
	 OJAtc0vgfLuZ9Hr7jnfK6jEgwJeEI5LBKRmw1AXSmYt7B1kEHUfGrvvTNFVuzxRTm9
	 7wHxF6VNBod0+rLSiMdE9k7ZPeHeG8IoZJ6kLUbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfKJCtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbfKJCtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:49:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD6522582;
        Sun, 10 Nov 2019 02:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354164;
        bh=5UlIQR2DCq+pOvDPurmJbhIK5FNedXV0/VZEjZx8hAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcSMUzHFUpHvDZBregxmYGzzukMs+5xoJbaqGC09hQhQVyebRD6fud9sfHMHX+giA
         YFUmWM2/OQ3CQDpKLK+TUlnTQgcrtnwEN6LAdop4pL88FytqoWQiHFM4GUsnaqPOd0
         We0iu66Bx0KabkUayX+WLjD4HVceeIAi/3tsA2kQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 21/66] ARM: dts: ux500: Fix LCDA clock line muxing
Date:   Sat,  9 Nov 2019 21:48:00 -0500
Message-Id: <20191110024846.32598-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit ecde29569e3484e1d0a032bf4074449bce4d4a03 ]

The "lcdaclk_b_1" group is muxed with the function "lcd"
but needs a separate entry to be muxed in with "lcda"
rather than "lcd".

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
index 5c5cea232743d..1ec193b0c5065 100644
--- a/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
+++ b/arch/arm/boot/dts/ste-href-family-pinctrl.dtsi
@@ -607,16 +607,20 @@
 
 			mcde {
 				lcd_default_mode: lcd_default {
-					default_mux {
+					default_mux1 {
 						/* Mux in VSI0 and all the data lines */
 						function = "lcd";
 						groups =
 						"lcdvsi0_a_1", /* VSI0 for LCD */
 						"lcd_d0_d7_a_1", /* Data lines */
 						"lcd_d8_d11_a_1", /* TV-out */
-						"lcdaclk_b_1", /* Clock line for TV-out */
 						"lcdvsi1_a_1"; /* VSI1 for HDMI */
 					};
+					default_mux2 {
+						function = "lcda";
+						groups =
+						"lcdaclk_b_1"; /* Clock line for TV-out */
+					};
 					default_cfg1 {
 						pins =
 						"GPIO68_E1", /* VSI0 */
-- 
2.20.1

