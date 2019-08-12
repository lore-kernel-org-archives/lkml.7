Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F404DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3F7206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="NgUcDmnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfHLOV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:26 -0400
Received: from mail-eopbgr30135.outbound.protection.outlook.com ([40.107.3.135]:32259
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfHLOVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebTRz4M3Kaw05LsVn/QV7oh3D4fZc6JfwrtA77E/GjkeoZZ1PKelW3DxWReaobzfXwZxabLA6f7vkZLIU5LpLPPk85TeOGZZi1dSys+w/Vz6IrV9wjmXq//BPUido10djTlB50sxLiASUiHKQD+890II+RJSUID2u3EOyIdQ7bpOovsllp7GQrzNL5bO2vF96FDOwZI1YkRTZArfiGE1tTa/VAX7a5D0Ww4Sr4yYUfcbfK13pbW7G8KK4isff+0rNqUQ+zhAZ6HoY9L18WWbiLwrBXWNBcpDXpatgKfufPfcQUlRfm9c45dV5l4zN08/BeI57RR6Zc4JtS13tWkrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WhBnZxB+3Hn6umCyMsJDKrRJrre26Pve5F9n5SsD8U=;
 b=NkvMwaxxP8/T1EgcQfGmYdlGCw4LxAyXISThTjbwJfJOodTLmATejK+3nvAizKJuqzudsQcYPy3HPn9Wu5xsU8E29dLCpejygHPVSrZTi9sF7ZqyRDjwpnmewgvx8qTzEUXl5/gT1Hvc8lTGleV6tHcXtKD18AgQCRDw8qNCFxx7HYovjL18JI74Ux8sK8eqv/qFJmPWWYKQWqVwriaZtFd1ciBBbbo6MGQ6bKeitL9IXQbEBCR/8g/kPFdHyx0rq+48mAhAAHfrrtCLTc6ndeIX5MxWTj7ElDHvwPnh09CZ//O1OQVvAIezkLpWB/I81Jp5jxkLPcNJ3fCEzMgzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WhBnZxB+3Hn6umCyMsJDKrRJrre26Pve5F9n5SsD8U=;
 b=NgUcDmnIX7AJmjKr1OhhS7btysS1PBaTjkvdllzU/I8j9cEdlDGZW9deCA5AbBodUYBXWOAIirjTRyvq+vonkmG/PbRcrUZPQIsOKY0LnMNe/vAx7T2a/MPa4rocHFIRMvtausmQaNtrzvr6hPMZ5/qp7C6zdG3dg963GRHjkfY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3998.eurprd05.prod.outlook.com (52.134.18.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.20; Mon, 12 Aug 2019 14:21:18 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:18 +0000
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
Subject: [PATCH v4 03/21] ARM: dts: imx7-colibri: prepare module device tree
 for FlexCAN
Thread-Topic: [PATCH v4 03/21] ARM: dts: imx7-colibri: prepare module device
 tree for FlexCAN
Thread-Index: AQHVURk1RFYhwM5lNEGqu2Ft+OOp9g==
Date:   Mon, 12 Aug 2019 14:21:18 +0000
Message-ID: <20190812142105.1995-4-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 4d843c7c-5cba-4e3d-4b8c-08d71f305792
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3998;
x-ms-traffictypediagnostic: VI1PR0502MB3998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3998DF0A2ABC35FC8E76E7FCF4D30@VI1PR0502MB3998.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39840400004)(136003)(396003)(376002)(366004)(189003)(199004)(2501003)(6436002)(6512007)(478600001)(52116002)(71200400001)(71190400001)(53936002)(4326008)(486006)(81166006)(81156014)(36756003)(14444005)(256004)(2201001)(2906002)(66476007)(66556008)(64756008)(446003)(66446008)(386003)(6486002)(76176011)(66946007)(6506007)(1076003)(476003)(2616005)(86362001)(14454004)(11346002)(8676002)(7416002)(5660300002)(50226002)(316002)(66066001)(7736002)(186003)(102836004)(8936002)(26005)(54906003)(110136005)(25786009)(6116002)(305945005)(3846002)(99286004)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3998;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TOTGy7oFu/EySy9MNetWO1ph1fon5jodT3jsddfNqEPMV5sTXxtbUXUGBY8XZpKOqxxMhbwhFeqhLMbGAP5M7GoMO/ARInIRoMiFqnFzAHHGPdxW+73H2+c9Gmxwql22EebF+z4hxRQKAH1Qtd8De+X/NeV+vRbdvn/bpW1DJ04nEbFFGkBzUzOs0jkNZOlKLbwBgBL47KqJeHX1C/EPJRcfiZGZeVQLdIxmQmyMIimydPNYJqhlavn2eLYdp82WK2diK8U3jHc9DdM2XMORFdKl9JQjd7bRxROb2w6VOuDw1WJSjX8uq2Z3R4PXTmV7eyrP5+d8NE2UZkfF+6S03Rcd1d3xx6NDUQ+pIIiCsO3YD/8Kmr0ahPYcLes17jplYzGsXcPpTfhvFGlormHmFmGObtiZp0fxecs3JfQarkI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d843c7c-5cba-4e3d-4b8c-08d71f305792
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:18.6389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cShbNHJkULFUdiv1FXEJmc4sp3bSHtHFVrH7vTkGoBw242kG4MminWNTzuM50Vbniyavi1O1+WKIBseryE/3/Clc1ntkAW9ApcoxjTHdRgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare FlexCAN use on SODIMM 55/63 178/188. Those SODIMM pins are
compatible for CAN bus use with several modules from the Colibri
family.
Add Better drivestrength and also add flexcan2.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Added Marcel Ziswiler's Ack

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

