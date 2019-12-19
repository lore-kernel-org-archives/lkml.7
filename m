Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9281FC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2032467F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="m5/NBG3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfLSUWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:22:11 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:34455 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLSUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:21:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576786906;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=242MZ4oNGy59VHbDAySilGw2vsKQ/HMaVeyHMssbOd8=;
        b=m5/NBG3Aq8mXDpc7Oju4x3DG/EAUcWA/raGmSW1Jy9uhfKiu5Jt/9PFD/Q0qZPSGlH
        cAFVrYNWNLUw69bBeon/RKfOm1tQL19ni/fWL4yYUdq+ydxA2eE75Bpu8l3q+bQHq7SJ
        oCYgwiDmDVhXWo2p+Dm0hjDez8+uI5wR04Dte5uA70A0YYjALPfF8N6ieTxJGis8ru5n
        sEx060Z8ESuRYVNiUyNl41AaiNalULOQnNJnZe3uih6TpvP8pwwKPKmkLPPg5rXs3lfl
        GzYHCFRet+3rwFT7d3+zxklE6rf88Olp4xUni5JLFMxXpRH9QG/eG6KI6TK+LRbaEQFx
        2MoA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXtszvsxM1"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 46.1.1 AUTH)
        with ESMTPSA id f021e2vBJKLk3ZG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 19 Dec 2019 21:21:46 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 8/9] ARM: dts: ux500: samsung-golden: Add Bluetooth
Date:   Thu, 19 Dec 2019 21:20:51 +0100
Message-Id: <20191219202052.19039-9-stephan@gerhold.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219202052.19039-1-stephan@gerhold.net>
References: <20191219202052.19039-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

samsung-golden uses a BCM4334 WiFi+BT combo chip.
The BT part is connected via UART and supported by the hci_bcm
driver in mainline.
Add the necessary device tree changes to make it load correctly.

It requires (seemingly) device-specific firmware that can be
extracted from the stock Android system used on samsung-golden:
  - /system/bin/bcm4334.hcd -> /lib/firmware/brcm/BCM4334B0.hcd

On my device, scanning for other Bluetooth devices works just fine,
but for some reason it keeps disconnecting immediately
when attempting to connect to an other device.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../arm/boot/dts/ste-ux500-samsung-golden.dts | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
index d22b2879c46a..313f0ab16866 100644
--- a/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
+++ b/arch/arm/boot/dts/ste-ux500-samsung-golden.dts
@@ -113,6 +113,19 @@ uart@80120000 {
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&u0_a_1_default>;
 			pinctrl-1 = <&u0_a_1_sleep>;
+
+			bluetooth {
+				compatible = "brcm,bcm4330-bt";
+				/* GPIO222 (BT_VREG_ON) */
+				shutdown-gpios = <&gpio6 30 GPIO_ACTIVE_HIGH>;
+				/* GPIO199 (BT_WAKE) */
+				device-wakeup-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
+				/* GPIO97 (BT_HOST_WAKE) */
+				host-wakeup-gpios = <&gpio3 1 GPIO_ACTIVE_HIGH>;
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&bluetooth_default>;
+			};
 		};
 
 		/* GPF UART */
@@ -396,6 +409,20 @@ golden_cfg1 {
 		};
 	};
 
+	bluetooth {
+		bluetooth_default: bluetooth_default {
+			golden_cfg1 {
+				pins = "GPIO199_AH23",	/* BT_WAKE */
+				       "GPIO222_AJ9";	/* BT_VREG_ON */
+				ste,config = <&gpio_out_lo>;
+			};
+			golden_cfg2 {
+				pins = "GPIO97_D9";	/* BT_HOST_WAKE */
+				ste,config = <&gpio_in_nopull>;
+			};
+		};
+	};
+
 	vibrator {
 		vibrator_default: vibrator_default {
 			golden_cfg1 {
-- 
2.24.1

