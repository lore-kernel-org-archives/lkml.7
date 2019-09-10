Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDCC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F5F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 12:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbfIJMVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:21:12 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53438 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388888AbfIJMVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 08:21:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7ECCB20006B;
        Tue, 10 Sep 2019 14:21:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0D7C7200236;
        Tue, 10 Sep 2019 14:21:05 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 490D8402CF;
        Tue, 10 Sep 2019 20:21:00 +0800 (SGT)
From:   Ashish Kumar <Ashish.Kumar@nxp.com>
To:     devicetree@vger.kernel.org, robh@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ashish Kumar <Ashish.Kumar@nxp.com>
Subject: [PATCH] arm64: dts: ls1046a: Append missing properties of QSPI node on ls1046ardb
Date:   Tue, 10 Sep 2019 17:50:53 +0530
Message-Id: <1568118055-9740-3-git-send-email-Ashish.Kumar@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568118055-9740-1-git-send-email-Ashish.Kumar@nxp.com>
References: <1568118055-9740-1-git-send-email-Ashish.Kumar@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the max-freqquncy to 50MHz, also adding "fast,read,m25p80" property.

Align the QSPI node with other similar boards like(ls1088ardb,
ls1046afrwy) as per bindings.

Also, correct compatible node to fix this warning:
m25p80 spi0.0: found s25fl512s, expected m25p80
m25p80 spi0.1: found s25fl512s, expected m25p80

Signed-off-by: Ashish Kumar <Ashish.Kumar@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 6a6514d..9c4113a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -101,21 +101,23 @@
 &qspi {
 	status = "okay";
 
-	qflash0: flash@0 {
-		compatible = "spansion,m25p80";
+	qflash0: s25fs512a@0 {
+		compatible = "spansion,s25fs512a", "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <4>;
 		reg = <0>;
 	};
 
-	qflash1: flash@1 {
-		compatible = "spansion,m25p80";
+	qflash1: s25fs152a@1 {
+		compatible = "spansion,s25fs512a", "jedec,spi-nor";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		spi-max-frequency = <20000000>;
+		m25p,fast-read;
+		spi-max-frequency = <50000000>;
 		spi-rx-bus-width = <4>;
 		spi-tx-bus-width = <4>;
 		reg = <1>;
-- 
2.7.4

