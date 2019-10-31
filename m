Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7C4CA9EC9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8D620856
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 00:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfJaArM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 20:47:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47200 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfJaArL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 20:47:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D3C61A04BC;
        Thu, 31 Oct 2019 01:47:09 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A4CD01A01F5;
        Thu, 31 Oct 2019 01:47:04 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CE09E4029B;
        Thu, 31 Oct 2019 08:46:58 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2] ARM: dts: imx7ulp-evk: Use APLL_PFD1 as usdhc's clock source
Date:   Thu, 31 Oct 2019 08:43:42 +0800
Message-Id: <1572482622-22070-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP does NOT support runtime switching clock source for PCC,
APLL_PFD1 by default is usdhc's clock source, so just use it
in kernel to avoid below kernel dump during kernel boot up and
make sure kernel can boot up with SD root file-system.

[    3.035892] Loading compiled-in X.509 certificates
[    3.136301] sdhci-esdhc-imx 40370000.mmc: Got CD GPIO
[    3.242886] mmc0: Reset 0x1 never completed.
[    3.247190] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[    3.253751] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000002
[    3.260218] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000001
[    3.266775] mmc0: sdhci: Argument:  0x00009a64 | Trn mode: 0x00000000
[    3.273333] mmc0: sdhci: Present:   0x00088088 | Host ctl: 0x00000002
[    3.279794] mmc0: sdhci: Power:     0x00000000 | Blk gap:  0x00000080
[    3.286350] mmc0: sdhci: Wake-up:   0x00000008 | Clock:    0x0000007f
[    3.292901] mmc0: sdhci: Timeout:   0x0000008c | Int stat: 0x00000000
[    3.299364] mmc0: sdhci: Int enab:  0x007f010b | Sig enab: 0x00000000
[    3.305918] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00008402
[    3.312471] mmc0: sdhci: Caps:      0x07eb0000 | Caps_1:   0x0000b400
[    3.318934] mmc0: sdhci: Cmd:       0x0000113a | Max curr: 0x00ffffff
[    3.325488] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x0039b37f
[    3.332040] mmc0: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00400e00
[    3.338501] mmc0: sdhci: Host ctl2: 0x00000000
[    3.343051] mmc0: sdhci: ============================================

Fixes: 20434dc92c05 ("ARM: dts: imx: add common imx7ulp dtsi support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Tested-by: Fabio Estevam <festevam@gmail.com>
---
Changes since V1:
	- Add fixes tag.
---
 arch/arm/boot/dts/imx7ulp-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7ulp-evk.dts b/arch/arm/boot/dts/imx7ulp-evk.dts
index f1093d2..a863a2b 100644
--- a/arch/arm/boot/dts/imx7ulp-evk.dts
+++ b/arch/arm/boot/dts/imx7ulp-evk.dts
@@ -78,7 +78,7 @@
 
 &usdhc0 {
 	assigned-clocks = <&pcc2 IMX7ULP_CLK_USDHC0>;
-	assigned-clock-parents = <&scg1 IMX7ULP_CLK_NIC1_DIV>;
+	assigned-clock-parents = <&scg1 IMX7ULP_CLK_APLL_PFD1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc0>;
 	cd-gpios = <&gpio_ptc 10 GPIO_ACTIVE_LOW>;
-- 
2.7.4

