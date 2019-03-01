Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7938C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CBD20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 03:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="WsfDQmwZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfCAD7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 22:59:20 -0500
Received: from mail.nic.cz ([217.31.204.67]:53115 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfCAD7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 22:59:19 -0500
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 79ABA63323;
        Fri,  1 Mar 2019 04:59:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1551412756; bh=xAfGaCBiJ/vfBIX69l+J1CGUUOEjRlsQiWtBpFmpPsc=;
        h=From:To:Date;
        b=WsfDQmwZp6Ehm4GS5hSGCsV+1N4XDFaRNR/9ZsWFYbIaiUANqL/Y7xDwGJcnp0lZe
         9JEfwmlMkSQmF194YtF25JTtKgC7fF4PeHkotUdKRA/kp4HA8kgUYcnBlrlzybZ+4p
         m55kdKGmfUJzC4AAvKagOH3R/litaZXLwOt4BvKI=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Tony Lindgren <tony@atomide.com>, Shawn Guo <shawnguo@kernel.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 bus+gpio 2/5] dt-bindings: bus: Document moxtet bus binding
Date:   Fri,  1 Mar 2019 04:58:49 +0100
Message-Id: <20190301035852.26780-3-marek.behun@nic.cz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301035852.26780-1-marek.behun@nic.cz>
References: <20190301035852.26780-1-marek.behun@nic.cz>
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
 .../devicetree/bindings/bus/moxtet.txt        | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/moxtet.txt

diff --git a/Documentation/devicetree/bindings/bus/moxtet.txt b/Documentation/devicetree/bindings/bus/moxtet.txt
new file mode 100644
index 000000000000..2bb998cbd3ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/moxtet.txt
@@ -0,0 +1,36 @@
+Turris Mox module configuration bus (over SPI)
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet".
+ - #address-cells	: Has to be 1
+ - #size-cells		: Has to be 0
+ - spi-cpol		: Required inverted clock polarity
+ - spi-cpha		: Required shifted clock phase
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
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "cznic,moxtet";
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+		spi-cpol;
+		spi-cpha;
+
+		moxtet_sfp: gpio@0 {
+			compatible = "cznic,moxtet-sfp";
+			gpio-controller;
+			#gpio-cells = <2>;
+			reg = <0>;
+		}
+	};
-- 
2.19.2

