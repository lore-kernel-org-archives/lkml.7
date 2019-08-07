Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA5DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E115229F5
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="o/JvX343"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfHGI0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:21 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:35606
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728889AbfHGI0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnDloEVYaLBOb3b8caNPeILflphr0d6TWlfXh4A5pUABIpjGkPbf8m1QBuWfrhMbB933C9rtugacMt58jaUjKoYmU0HQgQ/aGHaFa8Ypct1iFzaS2rYGIpLrGI+tkLH4w6YcG3dKLG3ssUR748kaJvAvfMWmtCcPBlEO7WkWL+GQFtKEUF2F5vHTsFj3UmMdXLaGURinUWnID7xUZZZxKV+n6ScAyGRtPufeHEmKIjQ91TixrO9n/CMxl9lVIbEP5kOQLlKHlYTXj7luRDEFfYLgZRuHvMtSmx7DDzVl9ZY5QzmAI7MEAk4te0OZ/j48EdqP5Kth8epwDo/jzKWmuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II2x/d3X1OgCBvMXJpQl6iOL2YZnBL1UMNd083xtKa8=;
 b=Dkaf5Vqa/favQq8DyeNn93OwudSNLW0V2FV/CNw7y6CTvbAmg/J/Wz690h16izf0G5EEx3Ga1oL+9rQox5AqyLWWYCCUBQ00lv75CCGLWHG5Fy2QY/06l4IgF04Ot7m8BIAGsDlGLHgvWJ7P/zQbI38zKTXTi9mja4LCwv3GaRZ8+7jfVPYxxKT8O/mYftcpUYFmqA0z31Z/FHLeH3aKgBQuJBDkqHVZZbP9R6Wb96z85Y6UocvNPaOuUEobrM0JLivFDkDWHQ1VWguS/lbQ4X+zah2dmVe0X3dss4qyas87f4Rm1GtgX5xyZqmP9TKJZZBoEATmGNo78C58B9uY1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II2x/d3X1OgCBvMXJpQl6iOL2YZnBL1UMNd083xtKa8=;
 b=o/JvX343YNt+al6jK7DYba1+XYdVc5CAshYlh2nDMkqT4ik8Jo601AMfiv164W0x8826SotNE6qiIo2fx1jmBjSa4CrQv3k603iHCzY3/FDrblhyfoTECHc5dIMdAe/8TlwhQPqSdb/FRC8npcXzJb6bYcnNbLY4p4k8hFoIpCU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:12 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:12 +0000
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
Subject: [PATCH v3 03/21] ARM: dts: imx7-colibri: prepare module device tree
 for FlexCAN
Thread-Topic: [PATCH v3 03/21] ARM: dts: imx7-colibri: prepare module device
 tree for FlexCAN
Thread-Index: AQHVTPnFye4S12f/ck6VNd11DuJmzQ==
Date:   Wed, 7 Aug 2019 08:26:11 +0000
Message-ID: <20190807082556.5013-4-philippe.schenker@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR0101CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::12) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7346dd3a-28a0-43ae-df09-08d71b10e7b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB361442DDD1E486917387244AF4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: COSM2YpBFg5xwpnSl+8YbzUyBLES/pifJIe7NAKAp5vt4a3+z/iTlLFrA/p7SxdyRk1dm8QqRWBK9RTKpqQjagPX+9keUNxpeDATqqwGkYF3YaXPJFjA5l+b6dZ/KNQAbY6b25MEBtfqJg3A+r6scq99yOJ4S2n7pZ9+lcUvGVZqnB8/c+G08DaefUsgSy9ewgrhOs2aPDwCeBysssGmRAgJsSMDrj/J3D4tb5nHjt/lng3kEHzx47IhQVDx6YvG4YqV/kaP9ZHs/DaysVZBDZZo9g1E/hC3bhfUc6/fl74xsVYaThLccVjKVyec1kDt4qVm4RdQF7pDL2uzROmJK388nYB+80wgmkkFVFLxlZHHQTgN6z4mjTjxWnNc7NDialQ6Fn8ofLR9ZM0KVnDI/6oM/STIQG3+7chJKqDp+es=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7346dd3a-28a0-43ae-df09-08d71b10e7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:11.9852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sCYPCtGDFFOzJiomIOX/Q6ufGaK8rYtEuZGorDG6lgo94ezn7+3Q2/7pMFieU54a80fVk898lSmsnMf/PrHuAuZIO7PT+k3FaRywJ7+ijiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
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

Changes in v3: None
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

