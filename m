Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10758C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D362F20811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="MHDPhn54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfCNPCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:02:14 -0400
Received: from mail.nic.cz ([217.31.204.67]:33433 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfCNPCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:02:14 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id B7849601B9;
        Thu, 14 Mar 2019 16:02:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1552575730; bh=z/VntqA6mUbnpmvU2cVG8YcDHU+QQQM3Ynj0lpfK9zg=;
        h=From:To:Date;
        b=MHDPhn54OJzBjx4o3OCBiVF1p8ZgNYPp4oWTCpQBhFdup0doxLnbJrZw7uXc2guyU
         SBJgdmEEirOvQs9xdOPSpgGOoQ5QpzvjCT6c65b+QFhsJAvCatrIg5fxdWa7BGunQk
         ZinBsS74FfWpV2XRiUDbOR1P3BofvF72+ZV5df5Q=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4.1 armsoc/drivers/bus+gpio 2/5] dt-bindings: bus: Document moxtet bus binding
Date:   Thu, 14 Mar 2019 16:01:35 +0100
Message-Id: <20190314150135.4362-1-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190311225906.GA9056@bogus>
References: <20190307125251.724-1-marek.behun@nic.cz> <20190307125251.724-3-marek.behun@nic.cz> <20190311225906.GA9056@bogus>
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
@@ -0,0 +1,46 @@
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
+ - reg			: Should be position on the Moxtet bus (how many Moxtet
+			  modules are between this module and CPU module, so
+			  either 0 or a positive integer)
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
+			compatible = "cznic,moxtet-gpio";
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

