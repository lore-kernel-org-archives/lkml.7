Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA56C48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47098208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 18:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ILnjeNcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFUSBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 14:01:04 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:43420 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfFUSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:01:04 -0400
Received: from grover.flets-west.jp (softbank126125154139.bbtec.net [126.125.154.139]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x5LI0Wvw030591;
        Sat, 22 Jun 2019 03:00:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x5LI0Wvw030591
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561140033;
        bh=gmN+6EpvZxwlHEVbdGNCjhmKTNUl54+7mWpdXjRHo+8=;
        h=From:To:Cc:Subject:Date:From;
        b=ILnjeNcNJ6aEAgZBkHfURXwDC8QagWDgMY5McU02iJtGrDE5GHwtHJ6FoPOWDKvE+
         5pJjGMfunMT13NCOY5zYqVWWqmY4ggxJ26fU2dmvQlunWlFmITtLkAn1WxHnUgw4HF
         06uih0+BhOrofH5n0/hHtVWHgsU7vILen0iH6CJQQmfh+DtKK52ALV4dSEXThCIn6H
         OGxic7pnepBkMI83oaPb/c6KCVFBiKIo0qNz7oROKuWlcrm102TQnOOl9C+5h6dJoi
         nph+72NKw5b7Q/Vh4RoUMQD/A/0sniSBvXulZfaT2N4FTrUnCI2CsM/kxFVhlsSHwH
         +cKCC5nwoDOXQ==
X-Nifty-SrcIP: [126.125.154.139]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: uniphier: add reserved-memory for secure memory
Date:   Sat, 22 Jun 2019 03:00:26 +0900
Message-Id: <20190621180026.25071-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory regions specified by /memreserve/ are passed to
early_init_dt_reserve_memory_arch() with nomap=false, so it is
not suitable for reserving memory for Trusted Firmware-A etc.

Use the more robust /reserved-memory node with the no-map property
to prevent the kernel from mapping it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 13 +++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 13 +++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 13 +++++++++++--
 3 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index e32f8aef40bf..8ec40a0b8b1e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -8,8 +8,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
-/memreserve/ 0x80000000 0x02000000;
-
 / {
 	compatible = "socionext,uniphier-ld11";
 	#address-cells = <2>;
@@ -110,6 +108,17 @@
 			     <1 10 4>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure-memory@81000000 {
+			reg = <0x0 0x81000000 0x0 0x01000000>;
+			no-map;
+		};
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 0e1b30656fea..b658f2b641e2 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -9,8 +9,6 @@
 #include <dt-bindings/gpio/uniphier-gpio.h>
 #include <dt-bindings/thermal/thermal.h>
 
-/memreserve/ 0x80000000 0x02000000;
-
 / {
 	compatible = "socionext,uniphier-ld20";
 	#address-cells = <2>;
@@ -215,6 +213,17 @@
 		};
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure-memory@81000000 {
+			reg = <0x0 0x81000000 0x0 0x01000000>;
+			no-map;
+		};
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index d3863157ddd9..d6f6cee4d549 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -8,8 +8,6 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/gpio/uniphier-gpio.h>
 
-/memreserve/ 0x80000000 0x02000000;
-
 / {
 	compatible = "socionext,uniphier-pxs3";
 	#address-cells = <2>;
@@ -138,6 +136,17 @@
 			     <1 10 4>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		secure-memory@81000000 {
+			reg = <0x0 0x81000000 0x0 0x01000000>;
+			no-map;
+		};
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.17.1

