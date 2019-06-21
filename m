Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79180C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC8B21530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="vZRndXuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfFULDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:03:01 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:20684 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFULDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:03:01 -0400
Received: from localhost.localdomain (softbank126205003112.bbtec.net [126.205.3.112]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x5LB2TFi005760;
        Fri, 21 Jun 2019 20:02:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x5LB2TFi005760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561114952;
        bh=566G5ZJA7HhdKKqomzyRKpv+TUpB4KwzLjdLVp/NDac=;
        h=From:To:Cc:Subject:Date:From;
        b=vZRndXuDCODRwLRC1TxbV4cOhoQvs3X2lq5+WWq/oatAqA9MbrYOlbtfOdKct4Caf
         DwlAU9ym+XA6etPb0H6yJ4Ggj47YlNKfAKjHeA/BoptNoUJ9Er7NDoXTNfmzW36EVE
         c9KVfSox+VhFPJUr+3cvnGjRSJYjyIgtLs7tUllSayTmHlv7LTsH+7RVaCuC/CI+q8
         fNIO6avUpH6C4NH0AyxyaAxY2Cc0q1yuUxJVS73by7pnFv6PuX4V5sBVVXFcGTHNwW
         a2EESx/S1DkPAuJQrnOnHezE7MAelTWvHlPubQheedQr2SxEky4k5gNl7CDwGUG/vi
         BfF8LuxIYqebQ==
X-Nifty-SrcIP: [126.205.3.112]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] arm64: dts: uniphier: update to new Denali NAND binding
Date:   Fri, 21 Jun 2019 20:02:25 +0900
Message-Id: <20190621110225.22710-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit d8e8fd0ebf8b ("mtd: rawnand: denali: decouple controller
and NAND chips"), the Denali NAND controller driver migrated to the
new controller/chip representation.

Update DT for it.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 4 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    | 4 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 2 ++
 5 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
index 7968d524351b..f72f048a0c9d 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
@@ -163,4 +163,8 @@
 
 &nand {
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index a3cd475b48d2..e32f8aef40bf 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -617,6 +617,8 @@
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 017f6328c191..0e1b30656fea 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -921,6 +921,8 @@
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
index 1965e4dfe4a4..754315bbd1c8 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
@@ -115,4 +115,8 @@
 
 &nand {
 	status = "okay";
+
+	nand@0 {
+		reg = <0>;
+	};
 };
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index bb97abe1a55f..d3863157ddd9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -779,6 +779,8 @@
 			status = "disabled";
 			reg-names = "nand_data", "denali_reg";
 			reg = <0x68000000 0x20>, <0x68100000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 65 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
-- 
2.17.1

