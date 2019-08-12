Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A76C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F82208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="H/EQPOwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbfHLOVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:41 -0400
Received: from mail-eopbgr30090.outbound.protection.outlook.com ([40.107.3.90]:46656
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728233AbfHLOVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaLzBebK2FvSwWvy1zNLO475hQ2IA8n2E6w3WiZ0h8q6ABlkEulbjXQTKWULUVE6sUBATkm/QlWs1JwgaTkd7quIHWGXzsXumccw0D8myW1Y4zbB/5vvbF8hzmg7f8q++OkSWObLmO8feeuYKbObjg25VGIns+f1BfaTx7syUxsoSZmp7XVqZO5IOICGknHNEq3g+5nKYkIvGvREUXFSZSHkGSV7+xbLlxuaz97pcyNfD4vQ+Yvd4WRzpgqoM+y+MAbw2h0MzlQjMiI8Om+Lo7heokIii4ZEsTP3TfIbYJRvQmunTpiiI7MJx4eGUUDFgXiyuq32ib6P7qzBq6rr3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCbbi+H9v/D6Xg57240XQERKEeoouzg6Ab/6Nyl33R4=;
 b=JTQs5XIuZLWfZXUYpo7cqRZi23CIg3HlqZBHP0+FuWPalhGktjZyO3OQadpPFMjmaQhUl1XbLDtZNyFis+6vi0AYwD0A9HrEdfGeAtTQmJrYjzCHMSC5E7zbHwHD9r5wg3KH/7Ygs6PojVY175/8nm7ySDhvn/CWnCWNtxA0mwx4C6XkqWMjASioFrk5AFHXEGWnuX7rgSyN5///NSG7ESurlapkOsKuPzEVe7LLaNg9WBrp5zpMM3v+847KwKDi/HEBkciqGD9wKzoMlDdfXXR8Q2kbuUyswMJFdNwVixiv6eq9384mwsysMghdoNhKD5+DuN8RuejIehyy5u4AKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCbbi+H9v/D6Xg57240XQERKEeoouzg6Ab/6Nyl33R4=;
 b=H/EQPOwFUKwfDugAEWcJbjrWXD4fyfPjsC+MQVIM54ipY5NoVNQ/XdxwRiFNtniR3NqfbBunRCBcidWRBtTPN/+Mf2WFKIQtRRm5zuR1pHXo4G3VWbbZOXofmzpmm81ZIeMquMpQHtOKejInKTqJ2nFwkdPNyK2aI2IbrvSjA54=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3808.eurprd05.prod.outlook.com (52.134.9.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Mon, 12 Aug 2019 14:21:31 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:31 +0000
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
Subject: [PATCH v4 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to can
 interfaces
Thread-Topic: [PATCH v4 11/21] ARM: dts: imx6qdl-apalis: Add sleep state to
 can interfaces
Thread-Index: AQHVURk8tkL06lEcYEKQgOqHfUf7lA==
Date:   Mon, 12 Aug 2019 14:21:31 +0000
Message-ID: <20190812142105.1995-12-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 2036573c-842f-4143-be73-08d71f305f3d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3808;
x-ms-traffictypediagnostic: VI1PR0502MB3808:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3808C7D23436F5BE2BC9CE45F4D30@VI1PR0502MB3808.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(39850400004)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(71190400001)(2906002)(71200400001)(66946007)(478600001)(256004)(66556008)(66476007)(7416002)(6116002)(3846002)(1076003)(14454004)(81156014)(81166006)(8676002)(4326008)(8936002)(50226002)(14444005)(36756003)(99286004)(26005)(386003)(6506007)(66066001)(76176011)(305945005)(25786009)(110136005)(316002)(54906003)(102836004)(44832011)(52116002)(64756008)(6486002)(66446008)(5660300002)(53936002)(6512007)(7736002)(2501003)(446003)(2201001)(186003)(86362001)(476003)(486006)(11346002)(2616005)(6436002)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3808;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dsoPriTHhB6FAMePh00J6svE49UJPfJkhlY+XF+3VafHh4Y2vSF3/d4/GwJHcli96dR9G/wvjg6I4RxvZZSDoonQhFucB7KnPY4b7duvo7RZitw5CNYyje67uxfwOgydLrNFxaGrOJ0qAs04Yklzd0eQuWgZPt6zwnMPLmBDjwDmkhiv4oTfluaMR7B7bqVqMSOksRJsrcWW5g6uPdrhdNIHNrq4CRA2cOvRJHlSXZS3dP3KqcEADNHuNcClZw/KZPzatacJAyO6YX8zIjWlwcKyP7I4/lYnVZFA7mcZa1kImNw75n5sIiG5XvOLDw80Hp6s3gwg/7ry/WW/XmR6eJs2LLx0HYjts2PWzWKm8xa67lcLXQNIW+6+eMSzcbpHLw8NzrFUfsuxS0a0yb5UTmZN0wY4RFLKhWwFKDdndSc=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2036573c-842f-4143-be73-08d71f305f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:31.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRvgSROUXk6MM7Bo8J9vGertwnB9QlPwU+/PFvHB32Za+EPfHQIdAe3JBkdJxFlybO5SjEdrdiNdh+dCkpe8y1GqDgPCop7mhwaFZlb1MDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3808
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
2.22.0

