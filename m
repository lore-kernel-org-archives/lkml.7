Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B2C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC046208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="JdL8fs7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfGaMip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:45 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com ([40.107.14.114]:6722
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387717AbfGaMie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jq5/tOEyUQL8JIriTpniBRdBY7RJvs00XysJXf5vBmekV/tDFsV75q9XToj94bAW5QkSQ+ZWQky1r7DicmW0GlPjRTifMpXfU2DTZjO60Cw62CAG8nxrelM+yXPKjZa/DXPMlEo3G0XlT9zChjP0Rm57M4g2wRgSSdjxaEmoN2J3poeblx5pCBlx8dOfwQz6sTlj9cYkBTSiyM3eBRX956WKxaNwBDqJWf4+1sEJla7tR3kPwYiFHVwl8v1aA/NnwaEman1pPAoifH/SYpEW13r7Hp0UqRJWQLMKAv5wzLse5uqhKN6MCdschLVypsPgbH1RYQkNfk3n9WyyuT/WmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ai4EOMbvz+SH1K4PXOJKwJbgE9Ntryi1jNmtP5LPZE=;
 b=LBbX9Dr8++mm6r7vip4G+CheYcE5JcKTDV/83fAQSZKB8ayxYo0quS5NMy6ZJzHSzAGnNUJ83BpUWFJJA6dm/fIFn/ElpLuGfbE+4g1w655ew7q3e3BDNk/tYzcXxJXVWsUeenOQmoskOYsbOPB998DXUwZCUJWGZrMld0Wu2dUvK1dpllU7uT3TneyoYR7ltmlETQWkR/ym7Jmt8wKRSx3u8n3WnSgpK+w9zJwAcNsenAfzDH9TFQR/TiXwldmgT5TvJF2WS4PMlnLzGxINrZCn2ps3aGoVbC9X7mozzFGuH1+vlTrwFkcTlz2sD/wXY6/IokYf0C4KkY5SYZQUIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Ai4EOMbvz+SH1K4PXOJKwJbgE9Ntryi1jNmtP5LPZE=;
 b=JdL8fs7Kdpa/0jxIe1db0u1pL37LIxUEWB+E5A6NqmfO/TrnQx9WI/epp+41pu4pI//SCIpeMWqN2qySTtu/JA/NrbVC71nDzT32Y02GjdLp5Vp1hyalWwPl/EE3zJqT0ij+KDW8UHZhGswtA6v9OfatW+G84wTPxfYKif9Y2YI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3648.eurprd05.prod.outlook.com (52.134.7.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Wed, 31 Jul 2019 12:38:30 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:30 +0000
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
Subject: [PATCH v2 14/20] ARM: dts: imx6ull-colibri: Add sleep mode to fec
Thread-Topic: [PATCH v2 14/20] ARM: dts: imx6ull-colibri: Add sleep mode to
 fec
Thread-Index: AQHVR5zYbKepQ6GNSUayJhQc0NNcoA==
Date:   Wed, 31 Jul 2019 12:38:25 +0000
Message-ID: <20190731123750.25670-15-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 76d4d909-345f-4cf6-f1d8-08d715b3fb07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB3648;
x-ms-traffictypediagnostic: VI1PR0502MB3648:
x-microsoft-antispam-prvs: <VI1PR0502MB36488303AADC82EB6AEB0E11F4DF0@VI1PR0502MB3648.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(346002)(396003)(39850400004)(189003)(199004)(64756008)(66446008)(66476007)(66946007)(6512007)(476003)(66556008)(8676002)(86362001)(36756003)(44832011)(478600001)(6666004)(5660300002)(71190400001)(71200400001)(1076003)(53936002)(6486002)(486006)(6436002)(2201001)(446003)(52116002)(50226002)(11346002)(316002)(99286004)(66066001)(2616005)(305945005)(256004)(26005)(14444005)(14454004)(102836004)(7736002)(3846002)(25786009)(6116002)(76176011)(2906002)(81156014)(81166006)(68736007)(386003)(6506007)(2501003)(4326008)(8936002)(110136005)(54906003)(186003)(7416002)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3648;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2zbcUgx/j8eq7odW5yZkW88N8IZWT6+Qol1gWhuKyz0Ead7q92gFVabYwAGFnzAmrpJ4GWDj6Ivf24/rJFhA4yOADGne2jK0JsSsbFyfLOm+CSsKi28a/dxnOviwF6LYWlwzo7tNEMUC4AhPNisB6t51WjtvxJR36Ql6q/EJuGxPetv46IyXdp/qw/sXNfiPk0UANkjBWi4qnc1+lOQ8wfN9w0R3syFNvwJBO+9NK1ReuQMB5i2GNqQ2rbZwxZKN00LrvKM6oq3L2sUcIQMltpvYBBY7nEMhrhhWIQRihcD7weKTa7ekTMMI8Bu521RebROzpkOl1PG/Rw4S3RgvGaVeyps29IMpFeQA2S+x5fOkKOdW83D2ti7zagc9ae2RAFT8pMshLVeA2NRYvqU6Kmz5de/iMTZtjb1H3yvnCdQ=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d4d909-345f-4cf6-f1d8-08d715b3fb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:25.3274
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

Do not change the clock as the power for this phy is switched
with that clock.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

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

