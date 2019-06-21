Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEA321530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="V8ciSa4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFULXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:23:45 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:51955 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFULXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:23:45 -0400
Received: from localhost.localdomain (softbank126205003112.bbtec.net [126.205.3.112]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x5LBNBVG009682;
        Fri, 21 Jun 2019 20:23:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x5LBNBVG009682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561116193;
        bh=QbSpRhPCko1oAe/ciitvIbxO8D+SdDlQvNNtyfUnX9A=;
        h=From:To:Cc:Subject:Date:From;
        b=V8ciSa4abgStdvuFnsOHO6f1XVDMZHgkDhQZrC04DNFZYgAhyAsFOdjk/NmqprgGL
         R888tLjyzguPUC9poWAhvqozzhYxlDBox8hc9CiUFioam4LB1ol7Z43Ig7xNZPIuYc
         ci+a71SEvpAeaZ206s0SIHPO1Hsm/lRY3Oa8QqJUhstSI2Fu6e08jbnNfafhJPXDNm
         jpppC1iKF32jSGer3oSrhGZKUsHod8KlyoDsJf2iTpiz8Okej8SDquRJwAY5LEOKqk
         Od+SPOsJCPlfJYEaBXQDM7+HYuSaZOlw4SxDwpoAm0sMaE4a0Wj72wym337xcS/HwT
         1gbY6Zbr78NdQ==
X-Nifty-SrcIP: [126.205.3.112]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: socfpga: update to new Denali NAND binding
Date:   Fri, 21 Jun 2019 20:23:06 +0900
Message-Id: <20190621112306.17769-1-yamada.masahiro@socionext.com>
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

 arch/arm/boot/dts/socfpga.dtsi                |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi        |  2 +-
 .../boot/dts/socfpga_arria10_socdk_nand.dts   | 20 ++++++++++++-------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index ec1966480f2f..90d6d0d4417d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -747,7 +747,7 @@
 
 		nand0: nand@ff900000 {
 			#address-cells = <0x1>;
-			#size-cells = <0x1>;
+			#size-cells = <0x0>;
 			compatible = "altr,socfpga-denali-nand";
 			reg = <0xff900000 0x100000>,
 			      <0xffb80000 0x10000>;
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index ae24599d5829..677394153f4d 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -659,7 +659,7 @@
 
 		nand: nand@ffb90000 {
 			#address-cells = <1>;
-			#size-cells = <1>;
+			#size-cells = <0>;
 			compatible = "altr,socfpga-denali-nand";
 			reg = <0xffb90000 0x72000>,
 			      <0xffb80000 0x10000>;
diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
index e36e0a0f8aa6..9bd9e04c7361 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts
@@ -9,12 +9,18 @@
 &nand {
 	status = "okay";
 
-	partition@nand-boot {
-		label = "Boot and fpga data";
-		reg = <0x0 0x1C00000>;
-	};
-	partition@nand-rootfs {
-		label = "Root Filesystem - JFFS2";
-		reg = <0x1C00000 0x6400000>;
+	nand@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "Boot and fpga data";
+			reg = <0x0 0x1C00000>;
+		};
+		partition@1c00000 {
+			label = "Root Filesystem - JFFS2";
+			reg = <0x1C00000 0x6400000>;
+		};
 	};
 };
-- 
2.17.1

