Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0056EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50BD214D9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 06:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfIVGEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 02:04:35 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:35237 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfIVGEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 02:04:34 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46bcNc4NSLz1rK4Q;
        Sun, 22 Sep 2019 08:04:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46bcNc4BHCz1qqkb;
        Sun, 22 Sep 2019 08:04:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id MDlRqTc9Cnk6; Sun, 22 Sep 2019 08:04:31 +0200 (CEST)
X-Auth-Info: ql7TW5oEUst6fnsIVESQC8zKpMvwzu2qLWE9+T/FRL8=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 22 Sep 2019 08:04:31 +0200 (CEST)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 0F7B618530C;
        Sun, 22 Sep 2019 08:04:05 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 0B2FA1A0097; Sun, 22 Sep 2019 08:04:05 +0200 (CEST)
From:   Heiko Schocher <hs@denx.de>
To:     linux-kernel@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] misc: add cc1101 devicetree binding
Date:   Sun, 22 Sep 2019 08:03:55 +0200
Message-Id: <20190922060356.58763-2-hs@denx.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190922060356.58763-1-hs@denx.de>
References: <20190922060356.58763-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add devicetree binding for cc1101 misc driver.

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 .../devicetree/bindings/misc/cc1101.txt       | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/cc1101.txt

diff --git a/Documentation/devicetree/bindings/misc/cc1101.txt b/Documentation/devicetree/bindings/misc/cc1101.txt
new file mode 100644
index 0000000000000..afea6acf4a9c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/cc1101.txt
@@ -0,0 +1,27 @@
+driver cc1101 Low-Power Sub-1 GHz RF Transceiver chip from Texas
+Instruments.
+
+Requires node properties:
+- compatible : should be "ti,cc1101";
+- reg        : Chip select address of device, see:
+               Documentation/devicetree/bindings/spi/spi-bus.txt
+- gpios      : list of 2 gpios, first gpio is for GDO0 pin
+               second for GDO2 pin, see more:
+               Documentation/devicetree/bindings/gpio/gpio.txt
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+                Documentation/devicetree/bindings/spi/spi-bus.txt
+ - freq       : used spi frequency for communication with cc1101 chip
+
+example:
+
+&ecspi4 {
+        cc1101@0 {
+                compatible = "ti,cc1101";
+                spi-max-frequency = <10000000>;
+                reg = <0>;
+                freq = <5000000>;
+                gpios = <&gpio2 11 GPIO_ACTIVE_HIGH &gpio5 8 GPIO_ACTIVE_HIGH>;
+        };
+};
-- 
2.21.0

