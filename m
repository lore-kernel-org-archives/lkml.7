Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEACFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B23D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 10:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lYuDi8gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392490AbfJPKgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 06:36:10 -0400
Received: from mail-eopbgr50048.outbound.protection.outlook.com ([40.107.5.48]:20247
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729559AbfJPKgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 06:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TphEzX1WGSBq3X3polQkmoyerqg4CaUvjCUWZr5O0pO8BqSXeLlOVH/oTJpHARh+kCjkusvya9UcqClea8UxTgjzqGAGOjk07Rj18e1cLDW+rEU2Ey1yG0VP6kWrx4FY6vPnOzhz0MSp0eBKdsJINIS66PW0VC2Gdb47trAMc0VF7tmy/Bc7WcWZICzq06v4VVqtCSuQKrHVtlCOugBkhMIqv/cSoS5qz01lD18F3Jo029G648aAYzP/7SXXgjEYcrK3aefw5oAtpGjD48oKVAcGl3WxscQuiTMP1wSHfNsM5gH+OHeleYaB6Se7NTubLCKlaMwxCGgRZMawd8Hs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BPlfa9H0xqu9yfqTMuB0WEmh4SUQ8MIR1A1jzuoTwY=;
 b=X1FOaP8CZ5yGyawAtgildYpbYJPAIPk31BmyGYr8WFKIS1CRngXDBWjfDFUeeOAy3W+V/w005sqcyHU0UaR9XG2fmEDs9zpEX/herYqcbizLPzn+nZ6l/pzTEMBzZ4gtIsBzvvQ3HY1iO5fsVeZ5LVYRM9ssKnPVnHeR6GRuLU6OpMyDh0Z0IuOzPv9Se3DQreBikdPreeJOEmepNkLbdSOfDeAhAdnAvf1y5J79N6yntWYg9gQsh8OCOiQjQXdXSks7Q/OrWuuDKjzxW6qcwpnwU2uCHsTAcmq6XChVUa+GoeEdQiC7lLXG+8e0I8F5/IPdOZkH7NxOcEuiI0Tx1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BPlfa9H0xqu9yfqTMuB0WEmh4SUQ8MIR1A1jzuoTwY=;
 b=lYuDi8gyHvsu06m2rrtE1MKf606hX0LnhDN6saf/+zf9kD1DVECgvrQ0hEBB42hIqmaZygqWGVt5r2WCe0Z4qkMDAOoYFCSNW6xLkA/RjWPDxxix+eKsJEY/9TRFrx1iq+G3tM2pdH67AQb66o8aFiCiMQGgzYEMDBBhJx3FwHw=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.232.225) by
 VE1PR04MB6685.eurprd04.prod.outlook.com (20.179.233.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 10:36:06 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::e052:9278:76a3:27c]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::e052:9278:76a3:27c%6]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 10:36:06 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM64: dts: imx8mm-evk: Assigned clocks for audio plls
Thread-Topic: [PATCH] ARM64: dts: imx8mm-evk: Assigned clocks for audio plls
Thread-Index: AQHVhA2D/VrUFzy1602vrssfnC7nGg==
Date:   Wed, 16 Oct 2019 10:36:05 +0000
Message-ID: <20191016103513.13088-1-shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK0PR03CA0080.apcprd03.prod.outlook.com
 (2603:1096:203:72::20) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11c::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36756735-579c-4453-57e9-08d75224a64e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VE1PR04MB6685:|VE1PR04MB6685:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6685FD371C21F557286C884FE3920@VE1PR04MB6685.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(7736002)(71190400001)(7416002)(36756003)(2501003)(71200400001)(8676002)(52116002)(2906002)(5660300002)(102836004)(386003)(186003)(26005)(99286004)(6506007)(14454004)(6512007)(1076003)(81166006)(6436002)(305945005)(478600001)(66066001)(81156014)(256004)(50226002)(66446008)(66476007)(64756008)(66946007)(110136005)(6486002)(66556008)(2616005)(25786009)(476003)(86362001)(8936002)(6116002)(316002)(2201001)(3846002)(486006)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6685;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j9hl6cXmZZCnAUE9i5G6000BpEFll9DfAHceVrUdPvcAROPfoSWocgNPeS1+rePJDeVpNTsfpaxEFOb2Myn3ucleR8uj6iCxtpMrKXGkM8x7FDlsyrP8Zt6kZzDQUHWqjxXAoBWcFYu6I8VPxZAgr6n9r+5VB9ylwh6S9jI2IX9/x8FBQeutHeOWawwe/jA7SYwR7jxHF5T5hbLOJmaZmi7KZcHboaeygfly3WGGhQanXccEliRiiWrRQGp3lrbQJSmQze47+EOenr/dq0gjgNRE4XrrEB/X9X5u7unjE3JOjyEkAJBGiJYx5LC4VasV4E7hphnV8At/K9m5b7DA3R9lHUbfar0SYrtmghop45Az0/MwX3mCD90BHsQDzApenGC3eRTq3H0+4hcuWEjIMP4n5Yoaya3qK8RrVvurWTM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36756735-579c-4453-57e9-08d75224a64e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 10:36:06.0515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjr4aR42le1D9J4VIXdU5NVl7N8S0H6SgXwiM2NSgFhr1SvX7OEJQRdjvgZFRuGi8D7Vywa6CvHyCzZzM7gULw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6685
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign clocks and clock-rates for audio plls, that audio
drivers can utilize them.

Add dai-tdm-slot-num and dai-tdm-slot-width for sound-wm8524,
that sai driver can generate correct bit clock.

Fixes: 13f3b9fdef6c ("arm64: dts: imx8mm-evk: Enable audio codec wm8524")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 2 ++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi    | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot=
/dts/freescale/imx8mm-evk.dts
index f7a15f3904c2..13137451b438 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -62,6 +62,8 @@
=20
 		cpudai: simple-audio-card,cpu {
 			sound-dai =3D <&sai3>;
+			dai-tdm-slot-num =3D <2>;
+			dai-tdm-slot-width =3D <32>;
 		};
=20
 		simple-audio-card,codec {
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index 5f9d0da196e1..2139c0a9c495 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -479,14 +479,18 @@
 						<&clk IMX8MM_CLK_AUDIO_AHB>,
 						<&clk IMX8MM_CLK_IPG_AUDIO_ROOT>,
 						<&clk IMX8MM_SYS_PLL3>,
-						<&clk IMX8MM_VIDEO_PLL1>;
+						<&clk IMX8MM_VIDEO_PLL1>,
+						<&clk IMX8MM_AUDIO_PLL1>,
+						<&clk IMX8MM_AUDIO_PLL2>;
 				assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL3_OUT>,
 							 <&clk IMX8MM_SYS_PLL1_800M>;
 				assigned-clock-rates =3D <0>,
 							<400000000>,
 							<400000000>,
 							<750000000>,
-							<594000000>;
+							<594000000>,
+							<393216000>,
+							<361267200>;
 			};
=20
 			src: reset-controller@30390000 {
--=20
2.21.0

