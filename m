Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E2FD206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="VXoQCz97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbfGaMjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:39:32 -0400
Received: from mail-eopbgr50111.outbound.protection.outlook.com ([40.107.5.111]:36399
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387666AbfGaMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NotAz3L3oDbk/kCDjLdWO0CNBz0SLP8QXz07CoYRl4rFP1IV4nacMURfpZDRThnY4+VuYAzFE1k69Uus7iT5xI6XkC58uHaNgnbrYLfq1sG10lDBDmrOtL9Q1V5htSm6gei46I3TVtKhSKM9IR8XWALuTRb2x51QXwnZ/o7ET0RHKdhLQ+zQxOPcbftlrNGulwC6Qf2AT3jRKJwZoLwZHdvHJzHeKj6SFmGyO1fCWMBfgPOhIlOxsAlmjI+jxGRPpuZ7vQC6492xQ0bPFkUsf/aPRlA9fIEjuO+j67RBYDA+pG6j3DvmeIBNkWkBUo6OKlbAWAy9w4ZnHE3V7styHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pFpANg1QWyaias9o7WBx7/ZHRoqm/1T9ByDlomlWoc=;
 b=VGNAGNkKu5vCLM3lpA5pRplT4PnQFm2fEp3o39kfSvssh2H88I3sqEZjX/fpKo82gxJ/5snDruevYO6DGI91HQP32oI9BSdm/8keLWUIRTFRRInp33VB5EFrA7utRxh14FHE9Xyt1g7KMEwi55BntQStElPDlSODV+fGGBU4jtkjg6RPuE0vYR0tyv52A+Ke5bT9LN8Vey7RLUpIoIRrMwVwFx0wLrs4HSpcDCRTfwXk4VcZRso4ZjpuLycaFQRd4zogkBmMz1yrUlTQ9F9Kvn3C3H6y1W3Ry0BhCQyH96a/q1iWs9ti9OeB+ln4rBZtEsmvLdjzAi4Lp3tdm1EqCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pFpANg1QWyaias9o7WBx7/ZHRoqm/1T9ByDlomlWoc=;
 b=VXoQCz978Vyl5DQt7L5Fjesahfv3XnTwc2awzcmANX51k3b/AhzlQvYJNBdbb/GM9/5N/4thDCM2p69lCxykX5L3+Y6dZo2ocWNI8TlD13OWRTQJbujOb76IY8EJz44Rw3SuvV0nIRblpQtYQPARcdZIN+hw34RIhWZ7hmDqQgY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2944.eurprd05.prod.outlook.com (10.175.25.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:05 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:05 +0000
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
Subject: [PATCH v2 03/20] ARM: dts: imx7-colibri: prepare module device tree
 for FlexCAN
Thread-Topic: [PATCH v2 03/20] ARM: dts: imx7-colibri: prepare module device
 tree for FlexCAN
Thread-Index: AQHVR5zM0DucEJ1MlUWyeL1xbvhzZw==
Date:   Wed, 31 Jul 2019 12:38:05 +0000
Message-ID: <20190731123750.25670-4-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 63a9afab-331b-4871-f194-08d715b3ef1b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2944;
x-ms-traffictypediagnostic: VI1PR0502MB2944:
x-microsoft-antispam-prvs: <VI1PR0502MB2944EFAD2FC76EC3BAEE1936F4DF0@VI1PR0502MB2944.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(346002)(39850400004)(396003)(366004)(189003)(199004)(66066001)(305945005)(26005)(2906002)(81166006)(81156014)(7736002)(52116002)(1076003)(36756003)(476003)(64756008)(66446008)(186003)(66556008)(66946007)(66476007)(256004)(2501003)(14444005)(71200400001)(8676002)(86362001)(68736007)(5660300002)(71190400001)(8936002)(76176011)(478600001)(54906003)(110136005)(14454004)(6486002)(2201001)(6436002)(3846002)(99286004)(6116002)(446003)(11346002)(6512007)(2616005)(7416002)(386003)(486006)(102836004)(44832011)(6506007)(316002)(25786009)(53936002)(50226002)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2944;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dNebd+UI4dXCUzx+3IRmb+2j1PCiziK7N3boIR3J1jcuxx5ANxQR4X3JL0Sii9peHDUfRTQVqKc9ydFT21Z79deZS9FOyBzCLVsNsxOCYexdFLPd9rbv1L8JIlKQeyMcK3/NQlXWVS6EuPyMR64jQ38KSmnCtJ7fPgCTMdWOgNINdie5lZ7FCDclgIIEVT9YTuBvLpA0Oug2KXS6jQ69oCsIIfoI1THIXMNtpUvMUbvCLjuFJJKp12AAwEfCfWw0rr0MqIlWdilvMoaIL7oQxiiqtxS7XrFxXKaBpgdcpFSWkDRf01WfhrW7Tg0Rm1lzWLr1pTtwfsOBT9fKHRWXF6L80O0vul7kBm4OPcxYs5tgbEIoZd56zRXaT72XcK2JEcT7MLe8H07cDFE6EpR35JDYkbq7Hhtyn2t5yZ0cxzw=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a9afab-331b-4871-f194-08d715b3ef1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:05.2908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2944
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare FlexCAN use on SODIMM 55/63 178/188. Those SODIMM pins are
compatible for CAN bus use with several modules from the Colibri
family.
Add Better drivestrength and also add flexcan2.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 35 ++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index f7c9ce5bed47..52046085ce6f 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -117,6 +117,18 @@
 	fsl,magic-packet;
 };
=20
+&flexcan1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	status =3D "disabled";
+};
+
+&flexcan2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan2>;
+	status =3D "disabled";
+};
+
 &gpmi {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_gpmi_nand>;
@@ -330,12 +342,11 @@
=20
 &iomuxc {
 	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio=
4>;
+	pinctrl-0 =3D <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio=
4
+		     &pinctrl_gpio7>;
=20
 	pinctrl_gpio1: gpio1-grp {
 		fsl,pins =3D <
-			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3	0x74 /* SODIMM 55 */
-			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2	0x74 /* SODIMM 63 */
 			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x14 /* SODIMM 77 */
 			MX7D_PAD_EPDC_DATA09__GPIO2_IO9		0x14 /* SODIMM 89 */
 			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x74 /* SODIMM 91 */
@@ -416,6 +427,13 @@
 		>;
 	};
=20
+	pinctrl_gpio7: gpio7-grp { /* Alternatively CAN1 */
+		fsl,pins =3D <
+			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3	0x14 /* SODIMM 55 */
+			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2	0x14 /* SODIMM 63 */
+		>;
+	};
+
 	pinctrl_i2c1_int: i2c1-int-grp { /* PMIC / TOUCH */
 		fsl,pins =3D <
 			MX7D_PAD_GPIO1_IO13__GPIO1_IO13	0x79
@@ -459,10 +477,17 @@
 		>;
 	};
=20
+	pinctrl_flexcan1: flexcan1-grp {
+		fsl,pins =3D <
+			MX7D_PAD_ENET1_RGMII_RD3__FLEXCAN1_TX	0x79 /* SODIMM 55 */
+			MX7D_PAD_ENET1_RGMII_RD2__FLEXCAN1_RX	0x79 /* SODIMM 63 */
+		>;
+	};
+
 	pinctrl_flexcan2: flexcan2-grp {
 		fsl,pins =3D <
-			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x59
-			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x59
+			MX7D_PAD_GPIO1_IO14__FLEXCAN2_RX	0x79 /* SODIMM 188 */
+			MX7D_PAD_GPIO1_IO15__FLEXCAN2_TX	0x79 /* SODIMM 178 */
 		>;
 	};
=20
--=20
2.22.0

