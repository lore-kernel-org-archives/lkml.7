Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9362C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4F0206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576522146;
	bh=MaaPmMeYJWo6gV+yUdPw3tOOj9YwHYuuiU/to3VoIvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=12izTxRzZQi70qTM3800mR2L88ApMV25GnnqgB/Gh6PzxB/DSieSCtdUNiAn7Ly7T
	 lHc+l4U0lBktV1wdZK1lZV8k4pUNMu073j1nFKXrLhKzd9uEUvl61de8pHjBxK5JIn
	 6F7vDFVCdRo546jTW/S3gDu5UUsB2ru+/Xpm15wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfLPStF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfLPRxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:53:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 201CA2166E;
        Mon, 16 Dec 2019 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576518813;
        bh=MaaPmMeYJWo6gV+yUdPw3tOOj9YwHYuuiU/to3VoIvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYU+TominRAz0omOhdypkjZuxpVJ0RyD6V4Pn8B4UcWTsUn10O46VbTcqF3lV2QER
         xQGzFnCg2X/uv0AVAgJHhibOh0dNLDI8luLQVQ3tIIPLqyLK20Qno16hmJOqMlKuX5
         oAssYcP4DKW3nY2+ndPNjQN60Pmt7zrHPBkbItDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 078/267] ARM: dts: sun8i: v3s: Change pinctrl nodes to avoid warning
Date:   Mon, 16 Dec 2019 18:46:44 +0100
Message-Id: <20191216174857.106817261@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit 438a44ce7e51ce571f942433c6c7cb87c4c0effd ]

All our pinctrl nodes were using a node name convention with a unit-address
to differentiate the different muxing options. However, since those nodes
didn't have a reg property, they were generating warnings in DTC.

In order to accomodate for this, convert the old nodes to the syntax we've
been using for the new SoCs, including removing the letter suffix of the
node labels to the bank of those pins to make things more readable.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts |  4 ++--
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
index 387fc2aa546d6..333df90e8037c 100644
--- a/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts
@@ -78,7 +78,7 @@
 };
 
 &mmc0 {
-	pinctrl-0 = <&mmc0_pins_a>;
+	pinctrl-0 = <&mmc0_pins>;
 	pinctrl-names = "default";
 	broken-cd;
 	bus-width = <4>;
@@ -87,7 +87,7 @@
 };
 
 &uart0 {
-	pinctrl-0 = <&uart0_pins_a>;
+	pinctrl-0 = <&uart0_pb_pins>;
 	pinctrl-names = "default";
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 3a06dc5b37467..da5823c6fa3e6 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -292,17 +292,17 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
-			i2c0_pins: i2c0 {
+			i2c0_pins: i2c0-pins {
 				pins = "PB6", "PB7";
 				function = "i2c0";
 			};
 
-			uart0_pins_a: uart0@0 {
+			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB8", "PB9";
 				function = "uart0";
 			};
 
-			mmc0_pins_a: mmc0@0 {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
 				function = "mmc0";
@@ -310,7 +310,7 @@
 				bias-pull-up;
 			};
 
-			mmc1_pins: mmc1 {
+			mmc1_pins: mmc1-pins {
 				pins = "PG0", "PG1", "PG2", "PG3",
 				       "PG4", "PG5";
 				function = "mmc1";
@@ -318,7 +318,7 @@
 				bias-pull-up;
 			};
 
-			spi0_pins: spi0 {
+			spi0_pins: spi0-pins {
 				pins = "PC0", "PC1", "PC2", "PC3";
 				function = "spi0";
 			};
-- 
2.20.1



