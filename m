Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DD5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9DC20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Q1LDICZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfHLOWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:43 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728880AbfHLOWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C812ZtbApt+RGCKAPX7aN4oROgJkPA8GxVLNk5bJL6yazbrrF3md2jEoodYyxpHSu/VJMM7jqHxMSj2LhKNT9WnReDq7ojvNa49ZD4+PJWrSJtdbn+mssFX8Ur6By5+FFpYHqpGJAfSYrClpvYUThuuitMdRPRJtnPSTligCwogDimfMkVaiLDbjBYMYZ3FSj2pA2Lp6txZq6IRCXLSjcz36deZVC9iv9JnYUMCVCjDKX7qQL/v2rMHxN4HMkXASn7hyAp582s6IteDoU9qlb7aMXSXT/nHJp9e8T6OvsS6yYxgxsbpVuV6Su6ElkAtNn8zN0cUVmPLY/yZBA0z/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPkOseLBB1BoR6gCR072kWsNuiP2GOdelo3+ZSFMAw4=;
 b=DoXdFpnrXqJ4Y6CfbgcJ3/haRW8PaBBhJ3A4/8hkJ5kIn68eHrbPZQ9giWFOb6e59/rVfLia2+CRJmLC5HUNuMxxHoL/nDBzUElWzrYuziuv7H70Zsf+AiI6l1Ri3bphxjyDMlnEQpfWcLHVarveoc7Q+RmRZI9r4g8LKfBwOErvsbybcidlyXuQZV/zE8rxVrTimcnhm9jy4Aq+u4MXuYQDQJMfrBpFjyn4hTnF9YcJNr1DrEI+UJvLfkXIxUycvtBSTnjVgOz97FSfcGfvHKv9/yXcUJSDedSVgsJmm2wNLUFU/xCTVHoKZo53Kbqiqk9XWpV0Bgif5aqu8zPCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPkOseLBB1BoR6gCR072kWsNuiP2GOdelo3+ZSFMAw4=;
 b=Q1LDICZWeA2V+1DIS4Kv1j3eMEfYLTCtgzaHDgEV4FPNUpWZuudib4hLcv8ojwblbv1TiHjvx1PrbQ4I1Ds9jrZAWBQdfmK7feQUY3gwrdfFJeSp10Y3aLQqesJCHcCCWqlranAm5TfnjHUdJguUByhBpVUonrAcGcCiIDpBAlM=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:42 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:42 +0000
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
Subject: [PATCH v4 17/21] ARM: dts: imx6ull: improve can templates
Thread-Topic: [PATCH v4 17/21] ARM: dts: imx6ull: improve can templates
Thread-Index: AQHVURlDPLPwUxcCdkKwWI1vd7kU8A==
Date:   Mon, 12 Aug 2019 14:21:41 +0000
Message-ID: <20190812142105.1995-18-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: bcee2d3f-8969-4a59-f4a7-08d71f306572
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29422C717923D62CEAB3B25AF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mzuktvfXb3+aLktiqhe53DY3E+hYg/L4y6fnLJRe+dQNvLo7IvyKjITMK1QnINEuhk+8Rqdm3ZXokH9SPFzuUlTQFfxzNlJCg3Uzr6FLhZi43s4W59WRB6Kh1taVbiIc/PydmZVIc//tB1cM1OhmQrMLARNWGZ8YFPQ86daYov/6UiXbtcQirtilD3/YPxRBeEx1rrHKa+GZVqW4IN7Drv5coqkVPoxATD4UeIVnMjcmmDC7ReRO28XQD73JZ86TsMYuByn7QEoZnJpUdFzaht4wd6fm1tuyelhzPXc0tIolzWJwpLyTh8w4n2ZIrqR0aAmoJmTCvpExN70myiLvRdE6sJ1YJYeIOjlWvGR6iZJ4Qcdi55C9+dPV+NBykG80kaYa+Y1b//T5X5sXBW6jtmtu3166oyGO2S/y6o7+NF4=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcee2d3f-8969-4a59-f4a7-08d71f306572
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:41.8977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA16Dw7NubCy365zcDkqO4lvgdwoHVVSUGcakAV0GE2olqkYNeM1LaJrd75CPY0P88H9FcCTsIT//fq2vCUdj+7IhOBrgF3vT5rwRx+66zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
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

Changes in v4:
- Move can nodes to module deviceteree include imx6ull-colibri.dtsi

Changes in v3: None
Changes in v2: None

 .../arm/boot/dts/imx6ull-colibri-nonwifi.dtsi |  2 +-
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi   |  2 +-
 arch/arm/boot/dts/imx6ull-colibri.dtsi        | 28 +++++++++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

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
index e3220298dd6f..6d850d997e1e 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -54,6 +54,18 @@
 	vref-supply =3D <&reg_module_3v3_avdd>;
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
 /* Colibri SPI */
 &ecspi1 {
 	cs-gpios =3D <&gpio3 26 GPIO_ACTIVE_HIGH>;
@@ -256,6 +268,13 @@
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
@@ -271,8 +290,6 @@
=20
 	pinctrl_gpio1: gpio1-grp {
 		fsl,pins =3D <
-			MX6UL_PAD_ENET1_RX_DATA0__GPIO2_IO00	0x74 /* SODIMM 55 */
-			MX6UL_PAD_ENET1_RX_DATA1__GPIO2_IO01	0x74 /* SODIMM 63 */
 			MX6UL_PAD_UART3_RX_DATA__GPIO1_IO25	0X14 /* SODIMM 77 */
 			MX6UL_PAD_JTAG_TCK__GPIO1_IO14		0x14 /* SODIMM 99 */
 			MX6UL_PAD_NAND_CE1_B__GPIO4_IO14	0x14 /* SODIMM 133 */
@@ -325,6 +342,13 @@
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

