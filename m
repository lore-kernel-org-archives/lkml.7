Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C3DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE020679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="vkkM87xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfHLOWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:05 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728816AbfHLOWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGMvz2pF1tKz71QeHnPaygf30VoM20XSCMN+pf9l2yjQLWpjn6nQpOVSGuN7bdqSpOqyKALiMs+vF+pmdmoaqbKk5JiHJtJE8yp7I+WjyL+C2Jh6FUWZ4J9vgsy5FejpzSR8iqVxSGChWIrSacmvopxAxxRn9ljgPM+l7eRw9PzN9eOX0qkzyAkx2aI8IpC2cKYBV+GyUQG51Eey/z/msFUVCL2KWFdFykaEOqBR99anHhG8Rqt+5oDpIl3Ji/03mBuV7beZWJcCNGCxsz8+vePcKiLweUQzeoPiIHgeV3ZK/IMH/lhQDstQGFFzmWXEGIWayxbJ3wqZbbI2c8UdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV//qlcwX0PpDGnwIbhhQgXo58Kpo+OjjMTA3aPCl7s=;
 b=J6K19tC0LMH85CaoAqYZea9hoaEb2rp02BMbHcfYuhRhmiKMx5wPW1wpI7lVNBPzo951zOum4cgKVD27ic3hlr737qAtF1bYv4Oi1oMOvinpeTg1wVWairW+g1wLcvTYNWVxWG5D8jHnoRjvXeSl03Lz37DC7On8LboWXQLu7ui5JBLTOUVX0jUVFa9jchRLBKlxqr3F3WPVoNl/1FlwkkEYNNZ/hoEXSJMvbHKkEMtza9jnSgoCgbcbtmmmEp+0IR+jf1FCRkMDBPEcFEwuSYKBVlhyTSP/aKypbPHCYJkcY2D0Jx6tpkRdIAjcrnA6d0M/e0/74rKShoPOCWtGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SV//qlcwX0PpDGnwIbhhQgXo58Kpo+OjjMTA3aPCl7s=;
 b=vkkM87xStvx2Rbdi7j4MUzY9c5prjT4cXXW5Ys+dcx2AZAUHLfJqAHfmnYPVa9Lir0OlpqpPXKvX5u2NlEPRlPRbAnMgckSPJ09R7lz3xfaP2o9BTxyg1PYN3HHRXITto2ke7wydCujhHD6KsE4fxVk6a1a/2rrL0tE7R40b1P8=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:37 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:36 +0000
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
Subject: [PATCH v4 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to fec
Thread-Topic: [PATCH v4 14/21] ARM: dts: imx6ull-colibri: Add sleep mode to
 fec
Thread-Index: AQHVURk/ykft4ua73EKmDHr197vAbw==
Date:   Mon, 12 Aug 2019 14:21:36 +0000
Message-ID: <20190812142105.1995-15-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: d33325c0-f01c-4f2c-fa79-08d71f306233
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29429E8F39C3516DF73D32B1F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FxwGlQd5CvizkbYfuMQ491bQHzz7Rb8JXSCgYkFjw2tJ4gl9g0xTWnrDzVCqZu4lMUjNQYjV5qDemaDlFWqU3JVei0hvKYNbUH5uCQEW67FZUMYnPwFOZx2ct08vCCHN0dE7q3G2jnb6eHdabgnnKJ6Ea72t5ZsMTn+GHhDpgx8qYlmpa7TpeDJDHDK+fGneUh/pB/oN6NbpK1oaUVyjGfLu0R6vmkeE9KMEXQjfcIxVspPCAxzAwpmbahFWYnucoMYpPx3ZVt3nrPFnWATT2Jstx78x21sH1xTP8zrWYVg+FmFuAnlY7uZUNImf1yJz/n24ESWQSdhblASDkdchRIPi/8ho7usBREs1C9P5jG6aU44ifl9UhrCa/wwHmATR6ZEP0lA2cZDDO+D+HV6HMlfSE2o+9htPGZ58CUu5rk4=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33325c0-f01c-4f2c-fa79-08d71f306233
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:36.4688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9A+Bd86VEYs5YiGGo8ayCyH3oJ5lLmv3QjSR89UXRKQE6/GMvpSnVxdHy9ApcvrPcBIb/8fKp9QT+H6EZsyd4EOqLzCsfkxCmflFKYWGwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not change the clock as the power for this phy is switched
with that clock.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

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

