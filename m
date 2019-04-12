Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF43C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA51E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfDLKdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:33:47 -0400
Received: from mail2.sp2max.com.br ([138.185.4.9]:54712 "EHLO
        mail2.sp2max.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfDLKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:33:44 -0400
Received: from pgsop.sopnet.com.ar (unknown [179.40.38.12])
        (Authenticated sender: pablo@fliagreco.com.ar)
        by mail2.sp2max.com.br (Postfix) with ESMTPA id 7B2EB7B3075;
        Fri, 12 Apr 2019 07:33:37 -0300 (-03)
From:   Pablo Greco <pgreco@centosproject.org>
To:     linux-sunxi@googlegroups.com
Cc:     Pablo Greco <pgreco@centosproject.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ARM: dts: sun8i: v40: bananapi-m2-berry: Fix WiFi regulator definitions
Date:   Fri, 12 Apr 2019 07:33:04 -0300
Message-Id: <1555065186-8154-6-git-send-email-pgreco@centosproject.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1555065186-8154-1-git-send-email-pgreco@centosproject.org>
References: <1555065186-8154-1-git-send-email-pgreco@centosproject.org>
X-SP2Max-MailScanner-Information: Please contact the ISP for more information
X-SP2Max-MailScanner-ID: 7B2EB7B3075.A1D9E
X-SP2Max-MailScanner: Sem Virus encontrado
X-SP2Max-MailScanner-SpamCheck: nao spam, SpamAssassin (not cached,
        escore=-2.9, requerido 6, autolearn=not spam, ALL_TRUSTED -1.00,
        BAYES_00 -1.90)
X-SP2Max-MailScanner-From: pgreco@centosproject.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like was done for the bananapi-m2-ultra, add the second wifi/bt
regulator and mark both as always-on.

Signed-off-by: Pablo Greco <pgreco@centosproject.org>
---
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index c37c7ab..78f4a1a 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -225,12 +225,27 @@
 	regulator-name = "vcc-wifi-io";
 };
 
+/*
+ * Our WiFi chip needs both DLDO2 and DLDO3 to be powered at the same
+ * time, with the two being in sync, to be able to meet maximum power
+ * consumption during transmits. Since this is not really supported
+ * right now, just use the two as always on, and we will fix it later.
+ */
+
 &reg_dldo2 {
+	regulator-always-on;
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-2";
+};
+
 &reg_dldo4 {
 	regulator-min-microvolt = <2500000>;
 	regulator-max-microvolt = <2500000>;
-- 
1.8.3.1

