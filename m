Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20338C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10D2229F3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tIBqeQJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbfHGI0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:34 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:35606
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729148AbfHGI0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgXqucb6Bhf45Cbao2/DwQkG5kl/Ba6Ixp9URqIfpdR12wh4//jwX2HonyfO9omtZ8FEN2OVQb9C97KKVO5p9TFepVS2CsGybZACoH5u1fWGUnOHpyYrrPCLN02ilvouDUvMY6FLdUyMU79GEoIShaBC7kPWfWP4z/N0/LnSKk23HDMvvGdUh/9mZim0kJ5/4+8A50oAeOCY2vA7Xr09nveJMUf84+PDKJf5rqzR/rD2I6zWpOCZ7bz1juLahhWAuKpcjz0qMbsCn6WmIWKpBHZrUXsOcu5mlOYyR0H1NX1AOL3VGfM/KHxOKxcDqTEKq93ZuAVHxCMjV2DiotZxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oVzOhC+3cT2Oy3E+NJBu08cX9OZ/z0bnOdpLwScPJA=;
 b=ad2IILBSjxXqdQySu5Fn+7MK0e35OHRDvQlgwBN7ixDN2H9A+uBWk0lTwA/QZ6MxxkGJN1Bs4Ip4cCY7izFgCAfaoVIMsYldoJ8MqLSHVcE5sN9C20jujaIQpCKFvJxbdw7stxHdAEgp7TXKbM0ARAq+tLi/8APpXMIVTeZkZ9vcOw7r8PY/t5rNs/tFjPft8ia2e2YlB9EfGDD0i/zAub94Q2poDGJTlYz6Iw09ASPjghNj8vWBvjBkR+i7dJ4rR66jbJRU86jr4DoU0qT54tVXYS3lJzqv5idCvOnilqHXaQfQcbx4tabQ7J5y1ot188EvfmU0Jrx5Vo20u5grGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oVzOhC+3cT2Oy3E+NJBu08cX9OZ/z0bnOdpLwScPJA=;
 b=tIBqeQJuVR74kM18++B6DRYRNAGjgjCennSk80M6r4Zsk8ATufC0RDh5h5BBjQ09Uvr+BYU9VeVFacA9ecjH02qjC7aHs4Mq/9p19i9RrKPPatnLLwAiwEn6TUu4KEprnz0gpwf/YJ5LLK2mC6yDLtjoyKrnow6noqJx3c/C+40=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:20 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:19 +0000
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
CC:     Stefan Agner <stefan.agner@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Topic: [PATCH v3 07/21] ARM: dts: imx7-colibri: fix 1.8V/UHS support
Thread-Index: AQHVTPnJFwE/N2EWdUa4MifpBqKEzA==
Date:   Wed, 7 Aug 2019 08:26:19 +0000
Message-ID: <20190807082556.5013-8-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: ed0a133d-4997-48ed-c459-08d71b10ec4b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB36147A1268788EC0AADDD9E4F4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(76176011)(561944003)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k59G8qjBrZJlCQYbxxQIDhxfGDJHIF+u0JcDc/WLwQ60tlVDJrUeZpe3owa6LBi5QpJeiw/f/hPcZjvR4FtE/krMuLPf2+w1fEw4W0xxdLCUD2K37OqjeJ9Zw34uoyucPWlAiihM+s3gw6ZO9EZpAiTzb3b26I8RF8eZsaLpONU32EJCuTAMMJXkkCgfMWDgt2FQBwQ1/QhJi0qkVGQhebSlisCv0exNaiEY0uEesDcN9YbFJduhhS2ETieqKSUPcnb0ohITTtMhgaytfq02EksgEIllF0Q4+n9SCPnIQpLVIWNrRNGMXQ3Nbj841y44Uy4S22pzM5bkx8gQRhR/Eg87SmQHXQVXc7XGA+clXyg5zRPngi2aPxuhOJd/3RCtDcxk+Q5iuSDtDad+WpCjTf9wgrA+3lECt9g0uMBvx+g=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0a133d-4997-48ed-c459-08d71b10ec4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:19.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWBg7DNNYue2lGG5D1Cqi0HRyOP0K3MDGJ81WV0EbCIZjX6Va0NgPX7ip2z8sejqO0jvhRErohP8LtnIxHUSJ2IbhNWmXpswdYfDzBaEZJY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Add pinmuxing and do not specify voltage restrictions for the usdhc
instance available on the modules edge connector. This allows to use
SD-cards with higher transfer modes if supported by the carrier board.

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

Changes in v3:
- Add new commit message from Stefan's proposal on ML

Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index 16d1a1ed1aff..67f5e0c87fdc 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -326,7 +326,6 @@
 &usdhc1 {
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_usdhc1 &pinctrl_cd_usdhc1>;
-	no-1-8-v;
 	cd-gpios =3D <&gpio1 0 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	vqmmc-supply =3D <&reg_LDO2>;
@@ -671,6 +670,28 @@
 		>;
 	};
=20
+	pinctrl_usdhc1_100mhz: usdhc1grp_100mhz {
+		fsl,pins =3D <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x5a
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x1a
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5a
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5a
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5a
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5a
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp_200mhz {
+		fsl,pins =3D <
+			MX7D_PAD_SD1_CMD__SD1_CMD	0x5b
+			MX7D_PAD_SD1_CLK__SD1_CLK	0x1b
+			MX7D_PAD_SD1_DATA0__SD1_DATA0	0x5b
+			MX7D_PAD_SD1_DATA1__SD1_DATA1	0x5b
+			MX7D_PAD_SD1_DATA2__SD1_DATA2	0x5b
+			MX7D_PAD_SD1_DATA3__SD1_DATA3	0x5b
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins =3D <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
--=20
2.22.0

