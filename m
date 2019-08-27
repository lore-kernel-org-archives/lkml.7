Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D597206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GOympMlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfH0NSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:18:35 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:14974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729903AbfH0NSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJibS1RxorPUN/GXPH/X2IflN72N3yr+AyUC1ry0tUyaQ/9Nd6EzU26rTUti5k6MhZ75MAZhETV3L/ghwCxkH8y5ZYDgyN3HZ7xIRchenmfI8tGJ/X9rqVjiEvLMi4yINIHhY3y18PBegxL46SvziVa59ULc/uqYsqpg4eLUnC52NiZxgxFl7Tu/N3NCCPLaB7jLFyNGdBanK+LKWdeDxzLOxvAHu+TzuRXt3tpjPX+THYDNMwOVLxptp+eQ13MqQgNwgwrxsLSEZs17WSKPys6ClPAz4dI0iXXEZrtuFKi5RNUmUckZCT4kC9YgzuooZA0IpMa24jDScT4siZ+nlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgyfBIr9zQFM0AVMFNXcVwL8kLGr4M+9MEw37Pm068o=;
 b=EBPgtVJL7ZeSPuTxbaclxhcKtrbAzHkpkuvWRQGjDK3J6IyQ+zqo2tbXFMk14ENzRjkExCwmyKndStTIZrqK2aAO7byXnp8TAkgjZ9h1OePIvhFNOZn1plLEabJYxqUBW2U7wlq+REqnlgeDgwc73MVQ5ZWb9IXR/ps/GnLJUIxgOhH6UFGS/e83BHQOaZIbqVt4VIj+MUCZ2p96TIgkacnAJmcVQwKOfpWX1DNKnK2ysqx/tv68qFjMGZ30Sit7tKjfJx2EdAxYe+ZsXfyp8R9YYD7KGlPR23m6A7ahtY8A6FGRNBOPLiDf1nLSIVUWOnAM8ov18o1/XLrCeA+Z+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgyfBIr9zQFM0AVMFNXcVwL8kLGr4M+9MEw37Pm068o=;
 b=GOympMlNEPv9PL37KKVvOjNlSLCfx+ZpalN7QSfWeMg4AAn7F0Hqwcqgt6PZwe1xBcYkvgMKBBRr97EufFL1nQcPeSwy0aPaxyRvkfcKsSYvBwi6DT1/hHZN/HDN1MIngxdVfAduo45SYRpPYKhUpMg5liwegKr2vJBcaHCIzsE=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3872.eurprd05.prod.outlook.com (52.134.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:27 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:27 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan @ agner . ch" <stefan@agner.ch>,
        "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>,
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
Subject: [PATCH v5 05/13] ARM: dts: imx6qdl-apalis: Add sleep state to can
 interfaces
Thread-Topic: [PATCH v5 05/13] ARM: dts: imx6qdl-apalis: Add sleep state to
 can interfaces
Thread-Index: AQHVXNnpQWJjpsUPzUeSw6jWNTsO3A==
Date:   Tue, 27 Aug 2019 13:18:27 +0000
Message-ID: <20190827131806.6816-6-philippe.schenker@toradex.com>
References: <20190827131806.6816-1-philippe.schenker@toradex.com>
In-Reply-To: <20190827131806.6816-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::44) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 735d3312-2224-4d60-756b-08d72af10bbb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3872;
x-ms-traffictypediagnostic: VI1PR0502MB3872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB38726CE8E4DFFD0E1AA8B777F4A00@VI1PR0502MB3872.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(8936002)(66946007)(2906002)(11346002)(5660300002)(50226002)(54906003)(110136005)(316002)(14454004)(1076003)(14444005)(256004)(64756008)(6506007)(386003)(7736002)(478600001)(36756003)(53936002)(66556008)(6116002)(66066001)(66446008)(3846002)(6436002)(76176011)(476003)(2616005)(446003)(486006)(6512007)(26005)(305945005)(102836004)(6486002)(71200400001)(186003)(8676002)(86362001)(81166006)(4326008)(71190400001)(81156014)(66476007)(25786009)(99286004)(7416002)(52116002)(44832011)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3872;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hS/Fs1XLxca56diVKBchRutvl3iDZPvIAltXn0jPEXhaW1GMerGLeD487KbC53A408rUGuJX2s2I7flagVlmPY7zioNnOw+tqSLOIrXsWVncm3gBS6HedQtHLwYa0HXKUbDAUjh5CQewlLJeRDbs1DwWJSoj/ElRgGOI25Yb3OUJRkW5QDfPdzKZr22spZyvpUc/bEugVAzQIgenCkfaoMPgaMXkK+6DEUDxogCaA+8dum4jbtb74wyB1ioBrCqkB13h/skufsjGGESGU13yLbI7HcJ2GAH5tMNKI5bx+6X8bVR/wKM6MRdbhUG0OdV8upHMSbEmZvHnkDbHBvld3wRMAp0lSDMXjFrTcSlxJfusm1TgEd1rSGbYEq/OERniKYGNihT1jykhpM1yHf/dfiqaig+yu7Ptnlh1gbwSKO0=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735d3312-2224-4d60-756b-08d72af10bbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:27.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmm7XZ85L3T3MjhTP2qW5e69CYukU06/eF5XF/OC4rna0Hd4vZLxHCRf4db9PE6L0a2iBefikCBl3OLY4VPLS75vjDdq9hqIB8VwGrggSe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prepares the devicetree for the new Ixora V1.2 where we are
able to turn off the supply of the can transceiver. This implies to use
a sleep state on transmission pins in order to prevent backfeeding.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v5: None
Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2:
- Changed commit title to '...imx6qdl-apalis:...'

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6=
qdl-apalis.dtsi
index 7c4ad541c3f5..59ed2e4a1fd1 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -148,14 +148,16 @@
 };
=20
 &can1 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl_flexcan1>;
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&pinctrl_flexcan1_default>;
+	pinctrl-1 =3D <&pinctrl_flexcan1_sleep>;
 	status =3D "disabled";
 };
=20
 &can2 {
-	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&pinctrl_flexcan2>;
+	pinctrl-names =3D "default", "sleep";
+	pinctrl-0 =3D <&pinctrl_flexcan2_default>;
+	pinctrl-1 =3D <&pinctrl_flexcan2_sleep>;
 	status =3D "disabled";
 };
=20
@@ -599,19 +601,32 @@
 		>;
 	};
=20
-	pinctrl_flexcan1: flexcan1grp {
+	pinctrl_flexcan1_default: flexcan1defgrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX 0x1b0b0
 			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX 0x1b0b0
 		>;
 	};
=20
-	pinctrl_flexcan2: flexcan2grp {
+	pinctrl_flexcan1_sleep: flexcan1slpgrp {
+		fsl,pins =3D <
+			MX6QDL_PAD_GPIO_7__GPIO1_IO07 0x0
+			MX6QDL_PAD_GPIO_8__GPIO1_IO08 0x0
+		>;
+	};
+
+	pinctrl_flexcan2_default: flexcan2defgrp {
 		fsl,pins =3D <
 			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX 0x1b0b0
 			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX 0x1b0b0
 		>;
 	};
+	pinctrl_flexcan2_sleep: flexcan2slpgrp {
+		fsl,pins =3D <
+			MX6QDL_PAD_KEY_COL4__GPIO4_IO14 0x0
+			MX6QDL_PAD_KEY_ROW4__GPIO4_IO15 0x0
+		>;
+	};
=20
 	pinctrl_gpio_bl_on: gpioblon {
 		fsl,pins =3D <
--=20
2.23.0

