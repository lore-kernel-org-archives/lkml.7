Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B40C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7533521783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 14:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfJBOrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 10:47:07 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:47261 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfJBOrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:47:06 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id A38B624000E;
        Wed,  2 Oct 2019 14:47:03 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 1/4] dt-bindings: i2c: at91: document optional bus recovery properties
Date:   Wed,  2 Oct 2019 16:46:55 +0200
Message-Id: <20191002144658.7718-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
References: <20191002144658.7718-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The at91 I2C controller can support bus recovery by re-assigning SCL
and SDA to gpios. Add the optional pinctrl and gpio properties to do
so.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index b7cec17c3daf..8ea2ce5d8610 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -19,8 +19,13 @@ Optional properties:
   capable I2C controllers.
 - i2c-sda-hold-time-ns: TWD hold time, only available for "atmel,sama5d4-i2c"
   and "atmel,sama5d2-i2c".
+- scl-gpios: specify the gpio related to SCL pin
+- sda-gpios: specify the gpio related to SDA pin
+- pinctrl: add extra pinctrl to configure i2c pins to gpio function for i2c
+  bus recovery, call it "gpio" state
 - Child nodes conforming to i2c bus binding
 
+
 Examples :
 
 i2c0: i2c@fff84000 {
@@ -55,6 +60,11 @@ i2c0: i2c@f8034600 {
 	clocks = <&flx0>;
 	atmel,fifo-size = <16>;
 	i2c-sda-hold-time-ns = <336>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	pinctrl-1 = <&pinctrl_i2c0_gpio>;
+	sda-gpios = <&pioA 30 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&pioA 31 GPIO_ACTIVE_HIGH>;
 
 	wm8731: wm8731@1a {
 		compatible = "wm8731";
-- 
2.23.0

