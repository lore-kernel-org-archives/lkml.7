Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDF8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D24208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CvR8DBIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfHLOVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:33 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:32224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727960AbfHLOV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DS/cAMqrpW/W+gmWbEwRKI67gsxNlbVsOf7+xO4THhEnmSPOJsmgJO/wIKomWmOdP77eWKktAH+blp+K+AWxY1o8koLfQ/bVMQhU2+k8+bfRVks++AjLLCWBBtfoPxVQT83zlGJSMDpvtlLWnqGg07u9BljDHtZi/iKwpugpLPyOPcREGYNoCM/I4IdqXB/cnzVxPYYiavAWAN62C5oDX2bvyW5/l03fu7sLz1ZvdhKW8mlR8X0WwF/W3Dm34VwpR2EKgL2asec8Ju/KIzMPTuftIP1KakklglDqQ3c9lIcSVvBkF62e2WyNaxg3FrQP1C55Bb7VcHiPCJjAw5zx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BL+wtbvGROgAklWb22NDPZKTCnaruZvxXIpdPOj7qU=;
 b=nA4Ypn+eNlhk7BAuxP3tdZMOKvr3zPCnDyo552vv6m/eUPgBqI2M5u4Bile48n2NG2phB1sj05wtZJWzHBxvL3L9or9OnVTqQJUMLdtqDWxDh6cpuoJBatTs7PxUKOaFo8ngorwZtGH1RoE1ymclvsSLMhJmECQfLtrSLdvweae7PqTz041sGNKwgTdvsQUnXZ2I9U6lQ/4DDVwaUEvorz0hyefsuCCmkjtYMqmvgBzyjrHeR4TkeerNnmSyg5pYz60LEtN2Vn1xozcX2TSe69oWyyNd1fZ7yCGAJoqUrM/rv162MWR9JEooyJc1EAq0xdnfZTBkiSTXwkwUmDhpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BL+wtbvGROgAklWb22NDPZKTCnaruZvxXIpdPOj7qU=;
 b=CvR8DBIJ2hFsVj2LqvvKg+Vq7slKp5gA1rfsb0mVajqCoQ5hPqeucPG15y1jhgXzaPJuDLJoXj0CyT63BmGRwUYPq3m+/lGpPwtb3yolEr0hc59ZljyQhEuzMH29nNPkytiRsxHEuxIv0eS7o7otoZtOMrIAOVwIfBjgrd7YWPw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:20 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:20 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 04/21] ARM: dts: imx7-colibri: Add sleep mode to ethernet
Thread-Topic: [PATCH v4 04/21] ARM: dts: imx7-colibri: Add sleep mode to
 ethernet
Thread-Index: AQHVURk2kJQjWsnXNEOsBLkXxu0G9w==
Date:   Mon, 12 Aug 2019 14:21:19 +0000
Message-ID: <20190812142105.1995-5-philippe.schenker@toradex.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0055.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31ac3b4a-0e7d-44dd-68a6-08d71f30585f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2942929B3959FE5AD2F9A94CF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FzKQ/Fftq4KxRGuVKnimX9u45+0SROa36DGiGedmeQWtXj/tj6qFFHnryeG5x9ThRL2vOY9G6UVEwSXRQvX7hI8DwXSAMLm0tuaG+pgpMg+wFaXnbZYnqVTMrzz3dITNuxka2dg5sbX5jXPMA2sa3g3fpLYpBRZJ3L5hE2wUpcpdhnqyt/jg+hTzwTIYlz89wROMu15TIuL5TkMCvM3orcTW4PTleMInCVfUm1GI95cTS2Oyt25pnYFCtoVo3ncpGSTPaIumTAUKESWZRCjAHm4+CNBXkokR8pttJ2imRRiecjXJrmhxoWSKzmG+Q91csW6Yp5R9rIzdKjJ8ClMvlSnnqfYP+G1vXOV3WvmbW1piHB35iqaLodIoBO+moHksWuJ3z6JzwUYmBL2SK8q3xjsqEkxb37YvqhPa8FXAMRY=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ac3b4a-0e7d-44dd-68a6-08d71f30585f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:19.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U50VP+opM85WXygZC2wJGT3ZsR85CZzVP3Oh9v5ejlZb6+NUg3tJSrl/TgoP6+U7VFJF9r6RaaH7yykEYxZuE2ZskkFyLmVjcZ+wFH/8a78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sleep pinmux to the fec so it can properly sleep.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Added Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index 52046085ce6f..a8d992f3e897 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -101,8 +101,9 @@
 };
=20
 &fec1 {
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "sleep";
 	pinctrl-0 =3D <&pinctrl_enet1>;
+	pinctrl-1 =3D <&pinctrl_enet1_sleep>;
 	clocks =3D <&clks IMX7D_ENET_AXI_ROOT_CLK>,
 		<&clks IMX7D_ENET_AXI_ROOT_CLK>,
 		<&clks IMX7D_ENET1_TIME_ROOT_CLK>,
@@ -463,6 +464,22 @@
 		>;
 	};
=20
+	pinctrl_enet1_sleep: enet1sleepgrp {
+		fsl,pins =3D <
+			MX7D_PAD_ENET1_RGMII_RX_CTL__GPIO7_IO4		0x0
+			MX7D_PAD_ENET1_RGMII_RD0__GPIO7_IO0		0x0
+			MX7D_PAD_ENET1_RGMII_RD1__GPIO7_IO1		0x0
+			MX7D_PAD_ENET1_RGMII_RXC__GPIO7_IO5		0x0
+
+			MX7D_PAD_ENET1_RGMII_TX_CTL__GPIO7_IO10		0x0
+			MX7D_PAD_ENET1_RGMII_TD0__GPIO7_IO6		0x0
+			MX7D_PAD_ENET1_RGMII_TD1__GPIO7_IO7		0x0
+			MX7D_PAD_GPIO1_IO12__GPIO1_IO12			0x0
+			MX7D_PAD_SD2_CD_B__GPIO5_IO9			0x0
+			MX7D_PAD_SD2_WP__GPIO5_IO10			0x0
+		>;
+	};
+
 	pinctrl_ecspi3_cs: ecspi3-cs-grp {
 		fsl,pins =3D <
 			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x14
--=20
2.22.0

