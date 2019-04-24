Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3067C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9578B20652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556120378;
	bh=jvxdpg7JNYO7cH9UgE326EZK0YBQDcpNaQukxRtj+Nc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MFrLYVIcu6lBgXlY9zpIFcluhLrJeVpMwdSpl2lDw7FxLTca4dm19INem1Vza3wr2
	 l1aJnEPFmQeAy6ZtYf0krzHLF7cIJioRsXYAfvxgYK8EZoGTYmKEOvqEVemYoUv1rB
	 my5OxgoYNFUqttleicmbV64+q2ra/2exOHCLKJjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfDXPjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730398AbfDXPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:39:37 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC61520652;
        Wed, 24 Apr 2019 15:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556120376;
        bh=jvxdpg7JNYO7cH9UgE326EZK0YBQDcpNaQukxRtj+Nc=;
        h=From:To:Cc:Subject:Date:From;
        b=kHjo/8cg+RadZoE3zYrmSVm06KnqycNCYpOIhrPwsqle4Mo/cV/9coHtcgVnhxT5S
         79NYawnKWH9sM9pFd0FwLiFvvukUGuuex3tYRuR/N7TWXj0uVxR3+tIUJ2Bvgj6Uut
         ZPJkMx/NhsREl2dYDBXmfpxBMGlouMWGaWPy1kTU=
From:   Alan Tull <atull@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        delicious.quinoa@gmail.com, Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] ARM: dts: socfpga: add ltc2497 on arria10 devkit
Date:   Wed, 24 Apr 2019 10:39:15 -0500
Message-Id: <20190424153916.30115-1-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the two ltc2497 devices that are on the SoCFPGA Arria10
Socdk board at addresses 0x14 and 0x16.

Signed-off-by: Alan Tull <atull@kernel.org>
---
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
index 360dae5a5b12..0efbeccc5cd2 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
@@ -48,6 +48,13 @@
 		};
 	};
 
+	ref_033v: 033-v-ref {
+		compatible = "regulator-fixed";
+		regulator-name = "0.33V";
+		regulator-min-microvolt = <330000>;
+		regulator-max-microvolt = <330000>;
+	};
+
 	soc {
 		clkmgr@ffd04000 {
 			clocks {
@@ -128,6 +135,18 @@
 	i2c-sda-falling-time-ns = <6000>;
 	i2c-scl-falling-time-ns = <6000>;
 
+	adc@14 {
+		compatible = "lltc,ltc2497";
+		reg = <0x14>;
+		vref-supply = <&ref_033v>;
+	};
+
+	adc@16 {
+		compatible = "lltc,ltc2497";
+		reg = <0x16>;
+		vref-supply = <&ref_033v>;
+	};
+
 	eeprom@51 {
 		compatible = "atmel,24c32";
 		reg = <0x51>;
-- 
2.21.0

