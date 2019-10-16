Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B540FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB382168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404277AbfJPJlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:41:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:60896 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfJPJlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:41:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 02:41:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,303,1566889200"; 
   d="scan'208";a="225733107"
Received: from unknown (HELO ubuntu.localdomain) ([10.226.249.160])
  by fmsmga002.fm.intel.com with ESMTP; 16 Oct 2019 02:41:08 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joyce Ooi <joyce.ooi@intel.com>,
        Ong Hean Loong <hean.loong.ong@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>
Subject: [PATCHv2] arm64: dts: agilex: add QSPI support for Intel Agilex
Date:   Wed, 16 Oct 2019 02:40:46 -0700
Message-Id: <1571218846-12306-1-git-send-email-joyce.ooi@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds QSPI flash interface in device tree for Intel Agilex

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
v2: update the qspi_rootfs partition size
---
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
index 7814a9e..8de8118 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts
@@ -73,3 +73,38 @@
 &watchdog0 {
 	status = "okay";
 };
+
+&qspi {
+	flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "mt25qu02g";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+
+		m25p,fast-read;
+		cdns,page-size = <256>;
+		cdns,block-size = <16>;
+		cdns,read-delay = <1>;
+		cdns,tshsl-ns = <50>;
+		cdns,tsd2d-ns = <50>;
+		cdns,tchsh-ns = <4>;
+		cdns,tslch-ns = <4>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			qspi_boot: partition@0 {
+				label = "Boot and fpga data";
+				reg = <0x0 0x034B0000>;
+			};
+
+			qspi_rootfs: partition@34B0000 {
+				label = "Root Filesystem - JFFS2";
+				reg = <0x034B0000 0x0CB50000>;
+			};
+		};
+	};
+};
-- 
1.9.1

