Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EB6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCD120645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfDWIeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:34:21 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:46745 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfDWIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:34:19 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 487704000A;
        Tue, 23 Apr 2019 08:34:15 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH v5 1/6] dt-bindings: ap806: add the cluster clock node in the syscon file
Date:   Tue, 23 Apr 2019 10:33:49 +0200
Message-Id: <20190423083354.17785-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423083354.17785-1-gregory.clement@bootlin.com>
References: <20190423083354.17785-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device tree binding for the cluster clock controllers found
in the Armada 7K/8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../arm/marvell/ap806-system-controller.txt   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 7b8b8eb0191f..a65d3e9ff915 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -143,3 +143,29 @@ ap_syscon1: system-controller@6f8000 {
 		#thermal-sensor-cells = <1>;
 	};
 };
+
+Cluster clocks:
+---------------
+
+Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
+cluster contain up to 2 CPUs running at the same frequency.
+
+Required properties:
+- compatible: must be  "marvell,ap806-cpu-clock";
+- #clock-cells : should be set to 1.
+- clocks : shall be the input parents clock phandle for the clock.
+- reg: register range associated the cluster clocks, offset must be 0
+  and the size have to be the whole size of the system-controller
+
+
+ap_syscon1: system-controller@6f8000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x6f8000 0x1000>;
+
+	cpu_clk: clock-cpu@0 {
+		compatible = "marvell,ap806-cpu-clock";
+		clocks = <&ap_clk 0>, <&ap_clk 1>;
+		#clock-cells = <1>;
+		reg = <0x0 0x1000>;
+	};
+};
-- 
2.20.1

