Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BA6C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B30216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Qvea1/7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbfEQNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 09:13:26 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:33865 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbfEQNNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 09:13:13 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 6EDDDA5237;
        Fri, 17 May 2019 15:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1558098790;
        bh=3fqHTQWwFFxlsRLtnrTf/2ecqWmAHakKFLqkKHlonlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qvea1/7zBUyKK/QmHvm2t+OSYWM8gWwChVAPWRmYb0ba7LTRoheLc4Lv9OBilytKO
         hBOLHcvwAWo1lEBd6u3zZDDRuEcze6m5aLCEkWa44Z0KoyIlxKNxKxxwRyz+Z+8bxQ
         OBICb3iu/ZX6mfuxSkOj8POjlnsj2rSNh6RlM0uQ=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH v2 4/4] ARM: dts: imx6dl-yapp4: Enable MPR121 touch keypad on Hydra
Date:   Fri, 17 May 2019 15:12:53 +0200
Message-Id: <1558098773-47416-5-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1558098773-47416-1-git-send-email-michal.vokac@ysoft.com>
References: <1558098773-47416-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the I2C connected touch keypad on Hydra board.
Use the polled binding as the interrupt line is not available.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6dl-yapp4-hydra.dts   |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index e8d800fec637..65a670e5bd4f 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -4,6 +4,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 
 / {
@@ -330,6 +331,17 @@
 		vcc-supply = <&sw2_reg>;
 		status = "disabled";
 	};
+
+	touchkeys: keys@5a {
+		compatible = "fsl,mpr121-touchkey-polled";
+		reg = <0x5a>;
+		vdd-supply = <&sw2_reg>;
+		autorepeat;
+		linux,keycodes = <KEY_1>, <KEY_2>, <KEY_3>, <KEY_4>, <KEY_5>,
+				<KEY_6>, <KEY_7>, <KEY_8>, <KEY_9>,
+				<KEY_BACKSPACE>, <KEY_0>, <KEY_ENTER>;
+		status = "disabled";
+	};
 };
 
 &iomuxc {
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
index f97927064750..84c275bfdd38 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
+++ b/arch/arm/boot/dts/imx6dl-yapp4-hydra.dts
@@ -45,6 +45,10 @@
 	status = "okay";
 };
 
+&touchkeys {
+	status = "okay";
+};
+
 &usdhc3 {
 	status = "okay";
 };
-- 
2.1.4

