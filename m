Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A08720840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="YytnFtdU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCGMxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:53:18 -0500
Received: from mail.nic.cz ([217.31.204.67]:34459 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfCGMxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:53:18 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 6637E6348F;
        Thu,  7 Mar 2019 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551963195; bh=vRe7XAbsJ40Axhxh8KhqzfK0vJg6CFuXizzsgEBoeoQ=;
        h=From:To:Date;
        b=YytnFtdU3h0tXXGVQVZvB6YHa3uBfJhu8fwxZWCl+qjzX25c7nfb2uv/1t/VCVAYe
         DgLSLkHIfpvslX0fk/Kp0IB0+G+HckZki0A2/qrrDxB2cOhOCdIqxzb4CSo7Ybqoar
         7VXvSNxW/j3xvBMH64fn0BsK2QiXnLXQq9jdXGQk=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 armsoc/drivers/bus+gpio 2/5] dt-bindings: bus: Document moxtet bus binding
Date:   Thu,  7 Mar 2019 13:52:48 +0100
Message-Id: <20190307125251.724-3-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307125251.724-1-marek.behun@nic.cz>
References: <20190307125251.724-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds device tree binding documentation for the Moxtet bus, a bus
via which the different modules connected to the Turris Mox router can
be configured.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 .../devicetree/bindings/bus/moxtet.txt        | 44 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt

diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documentation/devicetree/bindings/bus/moxtet.txt
new file mode 100644
index 000000000000..7be9d00c1767
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/moxtet.txt
@@ -0,0 +1,44 @@
+Turris Mox module status and configuration bus (over SPI)
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet"
+ - #address-cells	: Has to be 1
+ - #size-cells		: Has to be 0
+ - spi-cpol		: Required inverted clock polarity
+ - spi-cpha		: Required shifted clock phase
+ - interrupts		: Must contain reference to the shared interrupt line
+ - interrupt-controller	: Required
+ - #interrupt-cells	: Has to be 1
+
+For other required and optional properties of SPI slave nodes please refer to
+../spi/spi-bus.txt.
+
+Required properties of subnodes:
+ - reg			: Should be position on the Moxtet bus
+
+The driver finds the devices connected to the bus by itself, but it may be
+needed to reference some of them from other parts of the device tree. In that
+case the devices can be defined as subnodes of the moxtet node.
+
+Example:
+
+	moxtet@1 {
+		compatible = "cznic,moxtet";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+		spi-cpol;
+		spi-cpha;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&gpiosb>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+
+		moxtet_sfp: gpio@0 {
+			compatible = "cznic,moxtet-sfp";
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0>;
+		}
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index d96d36c83bc3..3f461a2d776a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1502,6 +1502,7 @@ ARM/CZ.NIC TURRIS MOX SUPPORT
 M:	Marek Behun <marek.behun@nic.cz>
 W:	http://mox.turris.cz
 S:	Maintained
+F:	Documentation/devicetree/bindings/bus/moxtet.txt
 F:	include/linux/moxtet.h
 F:	drivers/bus/moxtet.c
 
-- 
2.19.2

