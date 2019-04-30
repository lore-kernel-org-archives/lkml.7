Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD43C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ABE2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfD3Epx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 00:45:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:36864 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfD3Epw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:45:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 886691A00DF;
        Tue, 30 Apr 2019 06:45:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2C5E71A0014;
        Tue, 30 Apr 2019 06:45:42 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B9C7E4030F;
        Tue, 30 Apr 2019 12:45:31 +0800 (SGT)
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, leoyang.li@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        festevam@gmail.com, linux-imx@nxp.com,
        wsa+renesas@sang-engineering.com, u.kleine-koenig@pengutronix.de,
        eha@deif.com, linux@rempel-privat.de, l.stach@pengutronix.de,
        peda@axentia.se, sumit.batra@nxp.com,
        Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH 2/2] arm64: dts: fsl: ls1046a: Add the guts node in dts
Date:   Tue, 30 Apr 2019 12:47:19 +0800
Message-Id: <20190430044719.30720-2-chuanhua.han@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190430044719.30720-1-chuanhua.han@nxp.com>
References: <20190430044719.30720-1-chuanhua.han@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For NXP ls1046a SoC, the i2c clock needs to be configured with the
appropriate bit of RCW, so we add the guts node (GUTS/DCFG global
utilities block) for the driver to read.

Signed-off-by: Sumit Batra <sumit.batra@nxp.com>
Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 373310e4c0ea..f88599df18bb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -205,6 +205,11 @@
 			status = "disabled";
 		};
 
+		guts: global-utilities@1ee0000 {
+			compatible = "fsl,qoriq-device-config";
+			reg = <0x0 0x1ee0000 0x0 0x1000>;
+		};
+
 		qspi: spi@1550000 {
 			compatible = "fsl,ls1021a-qspi";
 			#address-cells = <1>;
-- 
2.17.1

