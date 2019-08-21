Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D7C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A119E22CF7
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 17:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfHURym convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 13:54:42 -0400
Received: from mail-oln040092065099.outbound.protection.outlook.com ([40.92.65.99]:29141
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726252AbfHURym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:54:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwLj7SIEAPRBvxxzjsjEqMlgslqDfTd6mvM6kWaBfMuALkRhDzQXHG8R2+sdtlsWzTZl+rfDOwonOZfRj6/sviqtspby8XEklusfhPCpKXxhM06O9sO0N7eMnnISdtG/4xN5ePfwAtNryGaSNgI1SOTp+4mmtnqt/gT6hGbftOXXy1MvGZBOBATJxrFiBGS7Eps6aM6QEWrP/vhzx2cVCv9S42Ydy+/m67G95UKSqtwntuwM+u2Q7wUiIAS8Wvv+OsNcCbTM0GYng1Rc9ITkF0Xyyy/re4vI635SuQ8xd0zNtq7lTPvn+XnVRhGPooqe80ZihATtvzlxi5GKDG1yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C9CDOUkw5AUgGLevr93sIeG2zpXiizo6oJblli579c=;
 b=EMpAD0dTHaEXxyfk6VH+uKi/pN5oJ4nEWu9ZXu+MySFsZEkvmXduImrbIrKdZ+XnRDqQb9JxqtQw8Vvm/4bH1qkIcG7KnM6DVOUFJHe63qP4dvSoO1gf0NAkrZXQ1tspmRukS1mpKRHrgc6DInxiBMvsF2MZUwvikTBn/YneaC8NLaI0FOUGKtdnXkL4H4DUqEkrjjolr8lNOGTg7pawO9nGYd655s+RatBb8ao/gPloHqEB3LGOBXPco2XAClQRqYo5XhrtG3ptvpZIZHG2vnSMi65xmedip3LBeoWIVDTP/vkkeNTokxwmzQboKud4/4WuyH3LdE4UE+MezfFORQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB5EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (10.152.4.57) by DB5EUR01HT118.eop-EUR01.prod.protection.outlook.com
 (10.152.5.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2199.13; Wed, 21 Aug
 2019 17:54:38 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com (10.152.4.57) by
 DB5EUR01FT062.mail.protection.outlook.com (10.152.5.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2178.16 via Frontend Transport; Wed, 21 Aug 2019 17:54:38 +0000
Received: from HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::a0ba:e766:2a23:2088]) by HE1PR06MB4011.eurprd06.prod.outlook.com
 ([fe80::a0ba:e766:2a23:2088%3]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 17:54:38 +0000
From:   Jonas Karlman <jonas@kwiboo.se>
To:     Heiko Stuebner <heiko@sntech.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [RESEND PATCH] arm64: dts: rockchip: add rk3328 VPU node
Thread-Topic: [RESEND PATCH] arm64: dts: rockchip: add rk3328 VPU node
Thread-Index: AQHVWEmA6lvnoZnzvUCVSolIcGQxRQ==
Date:   Wed, 21 Aug 2019 17:54:38 +0000
Message-ID: <HE1PR06MB4011C8496657B2C267A66327ACAA0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P192CA0024.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::34)
 To HE1PR06MB4011.eurprd06.prod.outlook.com (2603:10a6:7:9c::32)
x-incomingtopheadermarker: OriginalChecksum:8C597AB4DD1E128AEEBEA014BF3F741B080DA9DBA481AC4D4EF99701F697DA34;UpperCasedChecksum:DDD5D99217A2DE2D00F8877F259A52C93BE75208C2E67B43BC98D7A94D9CF410;SizeAsReceived:7564;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [qMVoivsCgaVQsd1Esgpq1b+VOhhNa+a3]
x-microsoft-original-message-id: <20190821175425.17132-1-jonas@kwiboo.se>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119158)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR01HT118;
x-ms-traffictypediagnostic: DB5EUR01HT118:
x-microsoft-antispam-message-info: GBcsDMx76XzvwoMP4GtlUNcLXJFEX3mAah4xw5woDVmuwKp04Hqo3vTzrMA/KxK1UQoRRF35RerY/BQcKXyUhiJGNQ17BackEswPkwQpMtBBb2+XWE/IYaJGm6kkZ5QUUmgSAqGaTbZsBU30ZrSxnM+pm8dbAGwGZjpOvjoGai0BN6qndomE2aoq3M3SFGlQ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bd19aa3b-26be-46c0-8ccf-08d72660a25d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 17:54:38.2018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a VPU device node for rk3328.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
It would be great if this can be considered for v5.4,
related dt-bindings commit has been merged in media tree for v5.4.

Decoding using hantro driver has been tested on a Pine64 Rock64 RK3328 device.
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index e9fefd8a7e02..4a175fff2861 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -278,6 +278,7 @@
 			};
 			pd_vpu@RK3328_PD_VPU {
 				reg = <RK3328_PD_VPU>;
+				clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 			};
 		};
 
@@ -596,6 +597,17 @@
 		status = "disabled";
 	};
 
+	vpu: video-codec@ff350000 {
+		compatible = "rockchip,rk3328-vpu";
+		reg = <0x0 0xff350000 0x0 0x800>;
+		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "vdpu";
+		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
+		clock-names = "aclk", "hclk";
+		iommus = <&vpu_mmu>;
+		power-domains = <&power RK3328_PD_VPU>;
+	};
+
 	vpu_mmu: iommu@ff350800 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff350800 0x0 0x40>;
@@ -604,7 +616,7 @@
 		clocks = <&cru ACLK_VPU>, <&cru HCLK_VPU>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-		status = "disabled";
+		power-domains = <&power RK3328_PD_VPU>;
 	};
 
 	rkvdec_mmu: iommu@ff360480 {
-- 
2.17.1

