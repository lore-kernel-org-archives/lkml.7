Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D4C606D8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7BE216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=phytec.de header.i=@phytec.de header.b="Dod327Qb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfGIHfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:35:07 -0400
Received: from mickerik.phytec.de ([195.145.39.210]:61840 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfGIHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:34:46 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 03:34:44 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1562656769; x=1565248769;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6ULrCnQ2EXZKEZiCe54JkHz/IplY+eiMTmG6iPQMJ3w=;
        b=Dod327QbHiD3fTXVvysNZkgKhhvSF+GEYBCpaJtt76MbBg+xYAqlpMrC7eBenIFV
        gXq+s8NZebDVow92tEVwR+88xIaHJ1CMHjH4FtgBWLoVQp2kpJssbanj6mWQsdHA
        VSMWIuTdbWqml5jS9gWyEsRdb+Dq0n7uyVexbLBBeYw=;
X-AuditID: c39127d2-193ff70000001aee-06-5d244001f5c9
Received: from idefix.phytec.de (idefix.phytec.de [172.16.0.10])
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5C.B0.06894.100442D5; Tue,  9 Jul 2019 09:19:29 +0200 (CEST)
Received: from augenblix2.phytec.de ([172.16.21.122])
          by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
          with ESMTP id 2019070909192901-309710 ;
          Tue, 9 Jul 2019 09:19:29 +0200 
From:   Stefan Riedmueller <s.riedmueller@phytec.de>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, martyn.welch@collabora.com,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com
Subject: [PATCH 07/10] ARM: dts: imx6ul: phycore: Add eMMC at usdhc2
Date:   Tue, 9 Jul 2019 09:19:24 +0200
Message-Id: <1562656767-273566-8-git-send-email-s.riedmueller@phytec.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
References: <1562656767-273566-1-git-send-email-s.riedmueller@phytec.de>
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:29,
        Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 09.07.2019 09:19:29,
        Serialize complete at 09.07.2019 09:19:29
X-TNEFEvaluated: 1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPLMWRmVeSWpSXmKPExsWyRoCBS5fRQSXW4OcSWYv5R86xWjy86m+x
        aupOFotNj6+xWnT9WslscXnXHDaLpdcvMlk8uNjFYtG69wi7xd/tm1gsXmwRd+D2WDNvDaPH
        jrtLGD12zrrL7rFpVSebx+Yl9R4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqRvl0CV8bbjoVM
        BVe5K85132drYLzN2cXIySEhYCLxZuk29i5GLg4hgR2MEtffbmOBcC4wSmzb/ZIJpIpNwEhi
        wbRGMFtEIFLi3fbfYB3MAnsYJaZdv87YxcjBISzgIvH+FhdIDYuAisScq5PYQGxeAQ+J9S8W
        MkJsk5O4ea6TGcTmFPCUOHrxF5gtBFRzecE0sMUSAo1MEtdeb4FqEJI4vfgs8wRGvgWMDKsY
        hXIzk7NTizKz9QoyKktSk/VSUjcxAgP18ET1SzsY++Z4HGJk4mA8xCjBwawkwrvPXTlWiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO8G3pIwIYH0xJLU7NTUgtQimCwTB6dUA+Me1e9xeddCTUz7
        /GPWfEqxy1v/wNX6xc/iFy8DdZ76bZ1zWOBLWasSR8cSiZNn9RYa/Pu4NSaJMbHo6+fvcnfn
        HCpSc3Qv1bWZzjbL7JPB5pVT3rWrFDA8t7q6s1tzAuszvx4LdZNlM0Mczp9n0VRkDWk8+2bH
        I6ePgjvuF/seXGB04fulRgUlluKMREMt5qLiRAA22/WSQgIAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phyCORE-i.MX 6UL/ULL now can have eMMC instead of the NAND flash
memory. Add the eMMC node and disable it by default so it can be enabled
in case it is populated.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
---
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index de6ffbb0183c..09a313daedb8 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -90,6 +90,15 @@
 	status = "okay";
 };
 
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	bus-width = <8>;
+	no-1-8-v;
+	non-removable;
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
@@ -145,4 +154,19 @@
 		>;
 	};
 
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_WE_B__USDHC2_CMD		0x170f9
+			MX6UL_PAD_NAND_RE_B__USDHC2_CLK		0x100f9
+			MX6UL_PAD_NAND_DATA00__USDHC2_DATA0	0x170f9
+			MX6UL_PAD_NAND_DATA01__USDHC2_DATA1	0x170f9
+			MX6UL_PAD_NAND_DATA02__USDHC2_DATA2	0x170f9
+			MX6UL_PAD_NAND_DATA03__USDHC2_DATA3	0x170f9
+			MX6UL_PAD_NAND_DATA04__USDHC2_DATA4	0x170f9
+			MX6UL_PAD_NAND_DATA05__USDHC2_DATA5	0x170f9
+			MX6UL_PAD_NAND_DATA06__USDHC2_DATA6	0x170f9
+			MX6UL_PAD_NAND_DATA07__USDHC2_DATA7	0x170f9
+		>;
+	};
+
 };
-- 
2.7.4

