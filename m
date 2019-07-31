Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FADC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC177208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="dce9Ok+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfGaMjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:39:07 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:6722
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727061AbfGaMio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwRIH71msIg8SS3SzJpqxn8SXJ+CSTUVin4MvQcFCtTvvh0j91Z2mIUaOJy90GfG1YNRQCQLxJaC+FAkAa9hlGGraS6Q+21etuil+PanD9cRGjnHVsTZLd63CFdt2xRClKpNb5xQPgE10nndtBDtQ8vF2dtAkiaA0JRsEQ7uOZnpmqZB6P1lbUuQDYrYaUkGFys6/hm2izx0t2Phgdn1pgS7DDdT6djsfDCjRaGOWgPlFnkLFaml/1UrZq8oeKHdIrUCWTqbUAV4B0+uc6DaR07Zu12oAaNkz87H8KuUEs7WKmHjPbBjSpESRyue6/rHBjHmBIj3tCqKc3ToPftyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loaE2ZolOrOQi9hWR1Ho1G3WPDf0z125fSqZaVTGY9w=;
 b=XN+SiNsU4yNYEFHWN8GiK4QkROhlote8Kg8BOdUQU/AOzb875uny65HiQUWXhKWnrPE/ONuJvUF3xip1k+Imr6SlWwVC1XpKStf5t/Rdoxh/Kj+kbwiALhmVjjJDc5K2IVwhKthD7SJ7W2As6S5wg1qHX6Y/0shvwRpvoL9B6ApJ9putuHgQjynDrf8o6L8iKThUXWHpcCf4Zy2DEbjhWXTRWQ3qD8FXEwR+MK+S+6v7IAu4SJVqSyQF0k6Tooyj+nvjD2z2LhW2aQT2wFtYG5v49W3tVkppV8JCeM+6W0/Tzb5ZhyOV2tjbQk5KGzM7t6Uy1njuY/QUDygscSQAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=loaE2ZolOrOQi9hWR1Ho1G3WPDf0z125fSqZaVTGY9w=;
 b=dce9Ok+plHISiCRUkawN1aUHLFwEK/EQcdziiZosX7VzlU1EL0tb7AChY/8VX9C32AdG4kh0Jmr47Tg4w9YJo3h9iP0DPfcaF7KzZY6RbBdTPq7pKvi4zTGqUcrM1YGeE6CYvJ9Ssn3l2mJEbqP692oksrYm+RzZSFDt1m7H1e0=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:32 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:32 +0000
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
Subject: [PATCH v2 17/20] ARM: dts: imx6ull: improve can templates
Thread-Topic: [PATCH v2 17/20] ARM: dts: imx6ull: improve can templates
Thread-Index: AQHVR5zbf5khJC3/fky6UlRx5z3ZAQ==
Date:   Wed, 31 Jul 2019 12:38:30 +0000
Message-ID: <20190731123750.25670-18-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: c4e50de6-43c8-40de-3780-08d715b3fdf1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB3648;
x-ms-traffictypediagnostic: VI1PR0502MB3648:
x-microsoft-antispam-prvs: <VI1PR0502MB36486CF4AE46BA239F094378F4DF0@VI1PR0502MB3648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(64756008)(66446008)(66476007)(66946007)(6512007)(476003)(66556008)(8676002)(86362001)(36756003)(44832011)(478600001)(5660300002)(71190400001)(71200400001)(1076003)(53936002)(6486002)(486006)(6436002)(2201001)(446003)(52116002)(50226002)(11346002)(316002)(99286004)(66066001)(2616005)(305945005)(256004)(26005)(14444005)(14454004)(102836004)(7736002)(3846002)(25786009)(6116002)(76176011)(2906002)(81156014)(81166006)(68736007)(386003)(6506007)(2501003)(4326008)(8936002)(110136005)(54906003)(186003)(7416002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3648;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zEuYpUBZUZNdklNmpaD1VAKOZy76lupU4JLluBXutaykBz331WRDGUWo1q6aacHMncPg1gJ4zPrdqmEu6s36gCSSp+x8ZRQaRRZvtQj3JWY5GrSxfPZrozgg3wu5yW5xytjidP6vajrfUi4iHrx5WeCERKB6UF9dm0W6oOkrnnS8KFkoL6/h5aMv+BeNzpwHmjt5Mxl7P59sgPsl/P5nMEr+6FlsRH/uhoH2FmQHZBQ/0efzBsfXaL+pc8wh5jXRNuIlq7NuIFUAu0OhUxl6JmtilT+Y4WdndDjzWyKx0MEcQh57+qYWgKNxxalIfJfoLT5HNPwrMeJ/yn0rcBni/CxMHx0hPEqwK38STdzhj/rVg0qHqExsPCmgqrY1xI2RncQZUfaPQ0pmZfdEuZkNDWEUnsZ4D63N/njDnz1/ty4=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e50de6-43c8-40de-3780-08d715b3fdf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:30.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Add the pinmuxing and a inactive node for flexcan1 on SODIMM 55/63
and move the inactive flexcan nodes to imx6ull-colibri-eval-v3.dtsi
where they belong.

Note that this commit does not enable flexcan functionality, but rather
eases the effort needed to do so.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi |  2 +-
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi    |  2 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi         | 16 ++++++++++++++--
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot=
/dts/imx6ull-colibri-eval-v3.dtsi
index b6147c76d159..3bee37c75aa6 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -83,6 +83,18 @@
 	};
 };
=20
+&can1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	status =3D "disabled";
+};
+
+&can2 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_flexcan2>;
+	status =3D "disabled";
+};
+
 &i2c1 {
 	status =3D "okay";
=20
diff --git a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/boot=
/dts/imx6ull-colibri-nonwifi.dtsi
index fb213bec4654..95a11b8bcbdb 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
@@ -15,7 +15,7 @@
 &iomuxc {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
-		&pinctrl_gpio4 &pinctrl_gpio5 &pinctrl_gpio6>;
+		&pinctrl_gpio4 &pinctrl_gpio5 &pinctrl_gpio6 &pinctrl_gpio7>;
 };
=20
 &iomuxc_snvs {
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dt=
s/imx6ull-colibri-wifi.dtsi
index 038d8c90f6df..a0545431b3dc 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
@@ -26,7 +26,7 @@
 &iomuxc {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3
-		&pinctrl_gpio4 &pinctrl_gpio5>;
+		&pinctrl_gpio4 &pinctrl_gpio5 &pinctrl_gpio7>;
=20
 };
=20
diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index e3220298dd6f..553d4c1f80e9 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -256,6 +256,13 @@
 		>;
 	};
=20
+	pinctrl_flexcan1: flexcan1-grp {
+		fsl,pins =3D <
+			MX6UL_PAD_ENET1_RX_DATA0__FLEXCAN1_TX	0x1b020
+			MX6UL_PAD_ENET1_RX_DATA1__FLEXCAN1_RX	0x1b020
+		>;
+	};
+
 	pinctrl_flexcan2: flexcan2-grp {
 		fsl,pins =3D <
 			MX6UL_PAD_ENET1_TX_DATA0__FLEXCAN2_RX	0x1b020
@@ -271,8 +278,6 @@
=20
 	pinctrl_gpio1: gpio1-grp {
 		fsl,pins =3D <
-			MX6UL_PAD_ENET1_RX_DATA0__GPIO2_IO00	0x74 /* SODIMM 55 */
-			MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0x74 /* SODIMM 63 */
 			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0X14 /* SODIMM 77 */
 			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x14 /* SODIMM 99 */
 			MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x14 /* SODIMM 133 */
@@ -325,6 +330,13 @@
 		>;
 	};
=20
+	pinctrl_gpio7: gpio7-grp { /* CAN1 */
+		fsl,pins =3D <
+			MX6UL_PAD_ENET1_RX_DATA0__GPIO2_IO00	0x74 /* SODIMM 55 */
+			MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0x74 /* SODIMM 63 */
+		>;
+	};
+
 	pinctrl_gpmi_nand: gpmi-nand-grp {
 		fsl,pins =3D <
 			MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0x100a9
--=20
2.22.0

