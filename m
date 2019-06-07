Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A94C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966DD2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PsP48qsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfFGOsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:48:22 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:41166 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728486AbfFGOsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:48:21 -0400
Received: from mailhost.synopsys.com (unknown [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0571EC01B1;
        Fri,  7 Jun 2019 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559918900; bh=c4JCx7xGqtA6Q0yYJPhCoJ8QkXgg6kd7SK1vh9WrDpA=;
        h=From:To:Cc:Subject:Date:From;
        b=PsP48qsv3Wqvn9GbjqndsazHYaUFh6HfW0T1b4/xc3NS53eIoi0XDfmtTL4nl5I+/
         WCXBUwfEa+H5TQM78cUR213pce50BiJWxmoEugYKGGcwPWeoClterp19B4I5QBgJRl
         TlYL7HUgTY/Fr4uLpvwLCicGPshnEGFSr6ib9r3+LVU33ZcUAwdc379FBXoi5F3Dwf
         rGtnafJqCtr/Kc1XqL2Ji8pPyIUiOH0CrhEavpF3Od9+EMYY2ZTExywWbNd+A5r6ks
         A9BW5vADvRGDNLFPHnRyu0+/L5Jtacnug8n2TJ7z0xLaeJ7sRc7Q0xBu1h7mRSDvc/
         lUasJSAdl1Ocw==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.20])
        by mailhost.synopsys.com (Postfix) with ESMTP id 57C63A022E;
        Fri,  7 Jun 2019 14:48:17 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk]: enable DW SPI controller
Date:   Fri,  7 Jun 2019 17:48:00 +0300
Message-Id: <20190607144800.19234-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSDK SoC has DW SPI controller. Enable it in preparation of
enabling on-board SPI peripherals.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/hsdk.dts      | 14 ++++++++++++++
 arch/arc/configs/hsdk_defconfig |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index e57b24dd02e7..42e1c961ba48 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -11,6 +11,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/reset/snps,hsdk-reset.h>
 
 / {
@@ -233,6 +234,19 @@
 			dma-coherent;
 		};
 
+		spi0: spi@20000 {
+			compatible = "snps,dw-apb-ssi";
+			reg = <0x20000 0x100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <16>;
+			num-cs = <2>;
+			reg-io-width = <4>;
+			clocks = <&input_clk>;
+			cs-gpios = <&creg_gpio 0 GPIO_ACTIVE_LOW>,
+				   <&creg_gpio 1 GPIO_ACTIVE_LOW>;
+		};
+
 		creg_gpio: gpio@14b0 {
 			compatible = "snps,creg-gpio-hsdk";
 			reg = <0x14b0 0x4>;
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 0c4411f50948..ccfa744fe755 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -46,6 +46,9 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_SPI=y
+CONFIG_SPI_DESIGNWARE=y
+CONFIG_SPI_DW_MMIO=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DWAPB=y
-- 
2.21.0

