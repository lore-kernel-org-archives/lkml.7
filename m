Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A54C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A8621707
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="Bk59+xg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfGIHfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:35:17 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61846 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfGIHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656769; x=1565248769;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z/Ce/mLF65vxqmXovjOXbBz9hT5T4pHaAptHuYI5I90=;
        b=Bk59+xg0GUKvuP9xK1qEx1MPp1VeUT6dI/VlX+NYBGGM0x0Y9L2RF5S76F4xQecB
        4V/I256BmfEZt7QKDfbNqVT7QkS8GCMn8kMKy7nCwU1gRfllgdlE39MGHvYg30Ir
        DAVyvQbj10T93RBSGb3RZ70VSjqjoHS5pZ3Wh4EhjLY=;
X-AuditID: c39127d2-17dff70000001aee-05-5d244001f440
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9B.B0.06894.100442D5; Tue,  9 Jul 2019 09:19:29 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192876-309709 ;
          Tue, 9 Jul 2019 09:19:28 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 06/10] ARM: dts: imx6ul: segin: Only enable NAND if it is populated
Date:   Tue, 9 Jul 2019 09:19:23 +0200
Message-Id: <1562656767-273566-7-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:28,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:29,
        Serialize complete at 09.07.2019 09:19:29
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWyRoCBS5fRQSXW4PJBTov5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaLpdcvMlk8uNjFYtG69wi7xd/tm1gsXmwRd+D2WDNvDaPH
        jrtLGD12zrrL7rFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqRvl0CV8bEmauY
        C9ZxVRzZvZW5gfElRxcjB4eEgInEth1cXYxcHEICOxglXl2ZwAzhXGCUuNO7EMjh5GATMJJY
        MK2RCcQWEYiUeLf9NztIEbPAHkaJadevM4IkhAWCJU4dmc0CYrMIqEi8u/yODcTmFfCQeHJx
        PzuILSEgJ3HzXCfYUE4BT4mjF3+B2UJANZcXTGMBGSoh0Mgk8frUNiaIBiGJ04vPMk9g5FvA
        yLCKUSg3Mzk7tSgzW68go7IkNVkvJXUTIzBQD09Uv7SDsW+OxyFGJg7GQ4wSHMxKIrz73JVj
        hXhTEiurUovy44tKc1KLDzFKc7AoifNu4C0JExJITyxJzU5NLUgtgskycXBKNTB2BKi17e5e
        IVYefYdD6GJ/5au9b62+XFZddyFtsdyl2C+XRBObejuu9Gusu93canWiqMRj0W0J96oK9b1c
        /Ambf23ysS+8sav8XOHGz6KzQnKDui/zXGF/KHdr7++pvBcOKb454ug6/Xj4uWvlBjkmC0td
        p02Z7nDL/Yj504V/nF9JPxCUmXlCiaU4I9FQi7moOBEAuVJR6EICAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phyCORE-i.MX 6UL/ULL now comes either with NAND flash or eMMC. We
have to configure the populated memory type in the device tree files. So
the GPMI node gets disabled by default and only enabled if populated.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi      | 2 +-
 arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index fee7a7e938ee..de6ffbb0183c 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -65,7 +65,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
 	nand-on-flash-bbt;
-	status = "okay";
+	status = "disabled";
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
index 81a82dd65019..c6ef13685a7c 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dts
@@ -50,6 +50,10 @@
 	status = "okay";
 };
 
+&gpmi {
+	status = "okay";
+};
+
 &i2c_rtc {
 	status = "okay";
 };
-- 
2.7.4

