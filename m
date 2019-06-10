Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6F4C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECE120820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iD65cA+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389817AbfFJMQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:16:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46491 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389793AbfFJMPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:15:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so8893168wrw.13;
        Mon, 10 Jun 2019 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e1eMdBaB8RxDD++a+KcSae/AQyqka7jtAWZWQYYGlmA=;
        b=iD65cA+l81B6SQXXC1LquMeeG4t3jBN2ZTecMSnVizkyQZIBk33FfTzsup4SeNCk86
         bCGx7bTbD8rWa8ISAInF8uuVXN82Xom3amX3mPlMvKShbIOkjM4uMFSC38mz9528tD0d
         bmzDll2SHNEEDTTf7IjaAU5qPKonEk7/PDnS4OEcUQsh0Lvrg8SixTaUoF/M0WgoQsQL
         c2WyUBnwxdzveYhzvNSwYKF+NFj21t/wNz/0aBM0OPoMCU9QgJ5zLh8ASkahkX/BLrMz
         yYjW8ZF1KAjbXSLUqsJIcLlKrBLg5PUasjXoIaJ2CzWtQXPHo1jh7RhN2AXdCogTa1Nl
         mBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e1eMdBaB8RxDD++a+KcSae/AQyqka7jtAWZWQYYGlmA=;
        b=Qsn4HSTrPIBSNh3i6foILE+pdA9PNP7CjVND8qWGI1xzMC3duPujzOBNWo+zZa/etp
         BUgcpUoSOAWmdY1NiD/DMnkuEZXFzR6CD0MzlELigubYt/Dh9I7U149+NQHWlK3nBieb
         GecgPk+3LZr4noLUqZeUshkBU/xNueG3xSjACNbkqX5b37IZ2JODE1SUnnUY4r/OMZa8
         fdtdnRkrJ8UgvpgqkmexcLIKEpk80EtxbSe2h5Nvm/QviLoE47H+3tYdQhNPZOsa0e8w
         XGhFeEVbNTBRJX4OJIDXqLtJPxVGFQYNTZgnye84SImEuqyQ9SCdYIDzrD/7IDo2cs2P
         cXhQ==
X-Gm-Message-State: APjAAAUbOZjYdzPhaE6+ixVVGh6DMVFcKk+ZVAx1g17Z8HqZV3JqQbQv
        81tS7cRKysENvevJwmEZlK8=
X-Google-Smtp-Source: APXvYqw8UTMDX4DGV2nn8RWRrsw4aB8Av6boXCrEayOi6E9GJNBAUkqAeuq1Kqe99jhgPkgJ1HLfyg==
X-Received: by 2002:adf:baca:: with SMTP id w10mr35660324wrg.230.1560168952744;
        Mon, 10 Jun 2019 05:15:52 -0700 (PDT)
Received: from ryzen.lan (5-12-114-167.residential.rdsnet.ro. [5.12.114.167])
        by smtp.gmail.com with ESMTPSA id f21sm10385574wmb.2.2019.06.10.05.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 05:15:52 -0700 (PDT)
From:   Abel Vesa <abelvesa@gmail.com>
X-Google-Original-From: Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bai Ping <ping.bai@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>
Subject: [RFC 2/2] arm64: dts: imx8mq: Add idle states and gpcv2 wake_request broken property
Date:   Mon, 10 Jun 2019 15:13:46 +0300
Message-Id: <20190610121346.15779-3-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190610121346.15779-1-abel.vesa@nxp.com>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cpu-sleep idle state with all the necessary parameters and also add
the cpu-idle-states to the cpu nodes.

The 'broken-wake-request-signals' property is used to let the irq-imx-gpcv2
driver know that the wake request signals from GIC are not linked to the
GPC at all and, therefore, the driver should  make use of the dedicated
workaround to explicitly wake up the target core on every IPI.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808..7217138 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -103,6 +103,7 @@
 			#cooling-cells = <2>;
 			nvmem-cells = <&cpu_speed_grade>;
 			nvmem-cell-names = "speed_grade";
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		A53_1: cpu@1 {
@@ -115,6 +116,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		A53_2: cpu@2 {
@@ -127,6 +129,7 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		A53_3: cpu@3 {
@@ -139,11 +142,27 @@
 			next-level-cache = <&A53_L2>;
 			operating-points-v2 = <&a53_opp_table>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_SLEEP>;
 		};
 
 		A53_L2: l2-cache0 {
 			compatible = "cache";
 		};
+
+		idle-states {
+			entry-method = "psci";
+
+			CPU_SLEEP: cpu-sleep {
+				compatible = "arm,idle-state";
+				arm,psci-suspend-param = <0x0010033>;
+				local-timer-stop;
+				entry-latency-us = <1000>;
+				exit-latency-us = <700>;
+				min-residency-us = <2700>;
+				wakeup-latency-us = <1500>;
+			};
+		};
+
 	};
 
 	a53_opp_table: opp-table {
@@ -502,6 +521,7 @@
 				reg = <0x303a0000 0x10000>;
 				interrupt-parent = <&gic>;
 				interrupt-controller;
+				broken-wake-request-signals;
 				#interrupt-cells = <3>;
 
 				pgc {
-- 
2.7.4

