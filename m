Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54813C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 232CE229FA
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="upop39H9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbfHGI0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:43 -0400
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:5766
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387632AbfHGI0k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go1pKk/0Xxg5dpRmu2Gv0sQhiG/p6GRUNuycbcytyeK/O5x4sduZW2MeGcGY1Cv0IS7Ph73b+21H2L9gTOUjqOgeuBceOYKGaJPA5X3wfC1nO/UMIGUKrtdx/ZXWX7DV63RI91f9JqaOVb1PHjbs++qzJjhf08jo1ni7XFlltfM1DxDx8eGTUqYkBEl1U4POYmQrZdU4LlvPiJxidPWXGizjkj4P/18B4KR5kRpSAiwQajZ1+2d3A3n+EucAblsymR7kSzFD4ns+XTo8ExlCwodpKTxQNx56aZ/fqXD1EyTPJVgt+VA5OPmjvJRcFEWzJUi1fygGemlesHX+lpcxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSFS2LJJ0zicorNPhJ7OWocIA82+ZuKzKdOE75UdIbI=;
 b=D4rrR5d2VrrUagvRf6E0ax07ObWBhir+Mm1dkPT6HcKtCv2fe1kVuBkKwweuLlo/tdTdE6E+FqyvVK3ntRpqOvb2hIgF7qTD146EXQ6AyKvQrJr1JeJ0vNUBYKPf21SKAk+7aQxZXhNlvw3a6rKg3jkhq+ahesvwc7jIHpNjJ6fhcfNwuezpwROnFKNdSxcJ/sYuiJ8ZbV8v6FrjrhVlj901U9nnSik0lq5qB5ZSyfrb9Nr2mObHP/+IWJA5Sf68zf5r5Gp9XFSqfyDfdFFyHdRkH9fVGrzBuuFaBb2V2FyYNAZGllnV2hO2yugZtdrfqCm+NKHHTpdpjCnbBs4pSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSFS2LJJ0zicorNPhJ7OWocIA82+ZuKzKdOE75UdIbI=;
 b=upop39H9xO6SJsFAEjQD8sg8sS2x5B48n8UwLsnNpp+UDZq4lFWM84fL+w5auXj5AgmJR0eAaN6TmjTPKm/kTWnJn9fiMiV37utcqHkjOyps7IjMZIDPeClV2CP7GlrFtydKRWOaDy2u79bG2tmvLGiv8473thdJ0B2wxt3mo6U=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2928.eurprd05.prod.outlook.com (10.175.25.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 7 Aug 2019 08:26:34 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:34 +0000
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
Subject: [PATCH v3 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to fec
Thread-Topic: [PATCH v3 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to
 fec
Thread-Index: AQHVTPnShAEl9rBXM06Q0r7r7OuWuA==
Date:   Wed, 7 Aug 2019 08:26:34 +0000
Message-ID: <20190807082556.5013-15-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 83c4a4ae-0c21-4897-df19-08d71b10f519
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2928;
x-ms-traffictypediagnostic: VI1PR0502MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2928BAAEB9B7AE00C09A3DC4F4D40@VI1PR0502MB2928.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(64756008)(66556008)(66476007)(66946007)(36756003)(11346002)(476003)(6436002)(76176011)(2906002)(316002)(305945005)(2616005)(66446008)(1076003)(54906003)(110136005)(68736007)(486006)(14454004)(14444005)(5660300002)(446003)(256004)(86362001)(44832011)(50226002)(4326008)(66066001)(53936002)(6486002)(186003)(8676002)(26005)(71200400001)(99286004)(6512007)(2501003)(2201001)(71190400001)(102836004)(386003)(8936002)(6506007)(478600001)(7736002)(7416002)(52116002)(3846002)(81156014)(81166006)(6116002)(25786009)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2928;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rT1xkFVa0bYFLQCWJgNCqPbfvd1e3zp/4PSAAncnChGpO5lAcCL2lHmdAl0AJdnurCp9TGhFn+QbBiUa1ufC+ahq2Pcrt60/7TEncO3GW+Tyf8lBMyDzqCmVcOjINpMX2wIztdHlA4gMCNL9zbuz7VKqwXNYAl6KRk9xAjXu8PVnqyGQnMZJZACOxNvrguTUFzQrRsUOR1DfliONnd7q5c9VtiaPPnU3kKDHrb3qC0Y3Ivt8hMgvubRG3rD5bVX9oX90WjnRtTAgoydWUqyydQqR7cP/qfJoZJ1u5p45oOPAR/grxBEQyTNPloOiiOzYdkyLhHs2ErCqwjHiX9eg0musRv+1i6D8Wki9UiEInqa9C9Far6GMstVQVyiksh+ntJs4MYNFnM4MbQQoylBcNVfiBc1DMvU8zxrCz+aGBL0=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c4a4ae-0c21-4897-df19-08d71b10f519
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:34.3743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hh1jiUc+lmwgz+E7xP2e/Wcum+OkSwpt16xEooG1nAHQ2EpDterKj76lYPSmU5xrDME7ClZsl8o0I3c/zBD/yyjBTyuQjskfaVYC1ThlKV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not change the clock as the power for this phy is switched
with that clock.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index d56728f03c35..1019ce69a242 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -62,8 +62,9 @@
 };
=20
 &fec2 {
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "sleep";
 	pinctrl-0 =3D <&pinctrl_enet2>;
+	pinctrl-1 =3D <&pinctrl_enet2_sleep>;
 	phy-mode =3D "rmii";
 	phy-handle =3D <&ethphy1>;
 	status =3D "okay";
@@ -220,6 +221,21 @@
 		>;
 	};
=20
+	pinctrl_enet2_sleep: enet2sleepgrp {
+		fsl,pins =3D <
+			MX6UL_PAD_GPIO1_IO06__GPIO1_IO06	0x0
+			MX6UL_PAD_GPIO1_IO07__GPIO1_IO07	0x0
+			MX6UL_PAD_ENET2_RX_DATA0__GPIO2_IO08	0x0
+			MX6UL_PAD_ENET2_RX_DATA1__GPIO2_IO09	0x0
+			MX6UL_PAD_ENET2_RX_EN__GPIO2_IO10	0x0
+			MX6UL_PAD_ENET2_RX_ER__GPIO2_IO15	0x0
+			MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+			MX6UL_PAD_ENET2_TX_DATA0__GPIO2_IO11	0x0
+			MX6UL_PAD_ENET2_TX_DATA1__GPIO2_IO12	0x0
+			MX6UL_PAD_ENET2_TX_EN__GPIO2_IO13	0x0
+		>;
+	};
+
 	pinctrl_ecspi1_cs: ecspi1-cs-grp {
 		fsl,pins =3D <
 			MX6UL_PAD_LCD_DATA21__GPIO3_IO26	0x000a0
--=20
2.22.0

