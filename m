Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D332C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57A92089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="DhsJYvm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387715AbfGaMiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:15 -0400
Received: from mail-eopbgr00121.outbound.protection.outlook.com ([40.107.0.121]:56484
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387674AbfGaMiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9MVFHkWnhYR1CAjS30X+mMNj8D3gJ0BDo2+8cpeC4BMIEVqrImkxHUF054TF0vxXLoJOey0HFbqxtgFwiuOZHr6JMSPehnx6TBogqMVtRwlgkcsX1NunjD8Vmz3iq436zxxUhVOpYzQaXnyKMk40imXF04RrhsSYCbrtTvMcENHcluunTMLEMGqBbNGGfehfgQZLe/KHPIMHw/4YYGSiwcJavpYI9miCFM3VSNiQRzq27nncSnahScNjKkCSb1Jcbn/5aSQ3xaTQlnlr6Cgu0fFJhEr9gj/XKx8BW8YqQ9IY2JTi8CWMFwqPc6cbhWAhjyiFOdF8NGCFXQOgwyodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXEGd6GE27j6romxb8yNqfyiU9YCWJArLtxHDtKVapE=;
 b=FgJkEvhscW+xdz2bF23U98bAFbNB1PgI8IMXiyX7ntR2Lz4ukpHgZONR7FryAzf2d+heUCgupMwfftiqnw6TAokcGdZA9tc656W66aeFNDhQLSnfaLKv4tk3/r9EKNWm6E5J4BzRPG+yZcXJH9sn6rp8TgiBUA8jrc5RW+uCb+O22mW1syHnTUvvSQnrvOXx8f1t1Yorr7cvSGqZSJAP3SpBKnOqHeEvF0YOBVaqYAxYD0b5LORmHdvvLkvqvuQO3F3NrmxjFedX+fNIjE7ILRrPtlfLLSb3CUml59VkFA29+Mhsf596KkN6ZAw7umL/6+jenH+lgD+oSKmmFteZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXEGd6GE27j6romxb8yNqfyiU9YCWJArLtxHDtKVapE=;
 b=DhsJYvm92GPJIa5H99TW7ijmEvSYwPUNID9qGEPF8qzcI91UTHQoXL5lTwqGbhLm5QK23d1tU4/So0cBqFyXxUGhI82RaiJ6Ofx+8qL0dzfQE17Tu6G8MqROuBzQFnqcNsEK1ZDEVxS/8wUph8Y4f3EA+CgZ0qDU0QCdPt/PU/4=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:07 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:07 +0000
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
Subject: [PATCH v2 04/20] ARM: dts: imx7-colibri: Add sleep mode to ethernet
Thread-Topic: [PATCH v2 04/20] ARM: dts: imx7-colibri: Add sleep mode to
 ethernet
Thread-Index: AQHVR5zNpzPPnhwDRkytX8iwKmxe9w==
Date:   Wed, 31 Jul 2019 12:38:06 +0000
Message-ID: <20190731123750.25670-5-philippe.schenker@toradex.com>
References: <20190731123750.25670-1-philippe.schenker@toradex.com>
In-Reply-To: <20190731123750.25670-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0012.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::25) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 216457b4-90d7-425d-c5d1-08d715b3f01a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB3615A4B1C16ED31B58BB0A57F4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(14444005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qBb97LgbxOmYdOoBPwJRkZAmaiyQV2EkTavplfh8vJqeOyRkJwHMWUXR9hBssjJJDS+6K5bCWq+ATGMzhF35IQakkwZOdixG4cQ7BCoEmv77olMEkOzjqm0gQyKsVJUYg5y/3d9UumlefkmzJvx7Lwo6Q/vLO2UoEZGKi/CMM+Ifcp7ur5an6Fdu5tcYCRrD3azWOmSHv05tXdHvAmx6hOgjRgwdYb/vs3JhVoufMqBZu1woyosLx3UuvKewMFjIIAxHvgFdU2FG9SdhofFIPUHLHGyNlCEOTNHoiMaOP2nhdkvetEhPvug8uNvZnIqFG7OcrR4++n23Sp3hGtHmYbl0D6KNsubDq+E6srfYyICQBBp1FNRFE1iEtrzonGZkPw/FB/3ZvFgNKqUUhncRRy/ixAy3CPmf3q1BJvIZzng=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216457b4-90d7-425d-c5d1-08d715b3f01a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:06.9529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sleep pinmux to the fec so it can properly sleep.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

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

