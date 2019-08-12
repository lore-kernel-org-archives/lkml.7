Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99876C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610C1206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="eoMPfarj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfHLOVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:55 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:32224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727361AbfHLOV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGUgQnJo3Q43KGB3FQ7CieoIMHUa55WKHQdekrod3VYQsEC599fF35SHFKD7QYLp1qrOQm674XFwQPr8Rwyc03NHLVouRicyy4AK+M2JsoOAkmd1LwkMqBn3/581+Apsqbd382bHvzzwGGTELYPvX9SwD6dtyc1w7qRPOBkhZsgsa9NEweCJp32XoL72f79n+PC3BT0fKdCgTwpCXiVebJ+3jkyPDRzdIEdRCfGtkcICbWDpA1WbPZimmto/hP+MZwMdzLKm3ntwOj2IHLJ+PJZejWwnkelNMUHJBsp3dDcvmGFkmJCcdEaL56xbAnFBcxnwAyW9wUTHOJRF27u2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJKB/KlXUrEXOzbpFKR85GHHuORNdZYUD6R5zrDCCsU=;
 b=Q6LRqCtbt2nXFuSDaQI+EFL51HCAbSIKSzm0sfrQHpi1LubtNC/YU0VpFOHaDGQb1nh4E0ZBzwEq2xwGiXTSsN4QNwVX+ciplDmRnN80okWGCaB/82e7RG070M33kiMny1I3e2bLh8T/54TO1E97RxoSqoH1BDVmCcpjvJG68V1i76Zr+bv9VkpnW9HGxTs1xzmszJbMMONcd1WKomoEQDHbUec1PnLBcMqEIFRu+y4dLXU83bpzsUvtQFu+dXvy70x726OCP4jVJnUGOFSvbxYKYVJhipXaBAgEo+7vKYNhD9/Y+lJL5R0pqv+6djKnZOM6P6RF5EI6XBOMVeGsdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJKB/KlXUrEXOzbpFKR85GHHuORNdZYUD6R5zrDCCsU=;
 b=eoMPfarjXotCequWea5avOcEBmzS7UH2JVLQap+eUpaszww/784SGjG+u9hLyKbqljfxgt9mwGV9i8Fk/6bBDHws/by+5DKriKKgXQ3uJtq5hMnXN000F6N+zfkmDvnQDtXJ0eexPB2eMptQC2xDD4QUPqO8i5E8vvvecSH660U=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:17 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:17 +0000
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
Subject: [PATCH v4 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Topic: [PATCH v4 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Index: AQHVURk0iDp9zOnvgka28q+w6ZrWzw==
Date:   Mon, 12 Aug 2019 14:21:17 +0000
Message-ID: <20190812142105.1995-3-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: c23784aa-d077-41f8-5100-08d71f3056c7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29428A7A1EBB290431BA9BFAF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TwiMqcf0xnQoZzQb2j7TIbbQM7d/i+Onz+W4WoYIyZzxA4pXXfO68rK5gzcsBSrFmfg744vQQBNV6zeJyc6qEsPM3JBhpdswVrE62nzwyT+45R6RsAomBoGx7+LBPT80Kbl7zfFR5AChi3jAm4TEiqo8AMq+PX+QoyyX4uFUEEB7og6EYDjg3kd+RWx55h0lHSDVNeYzG7WJv1meBWJD4LMBW/7hqTMWzYv/YRhAHuGHjyNs+3Ew5HROJWy2DBFIKh8xKZ6lzAU2NdkZo/rj4ak2A/blpado3lVWWXl/2vkDgYLlcklJm5PFkzaxIQDp/29Owc25mVSOYUu6AMZ4p4ysK6btmLf4Ceej1SxXMS81z24Q694WW3f9KU33qXEqm3mFC5tVgqrCQM2f6WwMHeyPXqeHGNL4Ts5v4SoDID4=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23784aa-d077-41f8-5100-08d71f3056c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:17.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jrWz+4C+v9FlVg/TjQS4Lj0CvyCrzYbf4dAXo8d6p3i2LJ69jM6cDfpKnk27S5XzeTcvBqbbuG6zSgJsCh/0UU3yp5UWLoQSjKtV6q3Zvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan.agner@toradex.com>

Force HS200 by masking bit 63 of the SDHCI capability register.
The i.MX ESDHC driver uses SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400. With
that the stack checks bit 63 to descide whether HS400 is available.
Using sdhci-caps-mask allows to mask bit 63. The stack then selects
HS200 as operating mode.

This prevents rare communication errors with minimal effect on
performance:
	sdhci-esdhc-imx 30b60000.usdhc: warning! HS400 strobe DLL
		status REF not lock!

Signed-off-by: Stefan Agner <stefan.agner@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index f1c1971f2160..f7c9ce5bed47 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -325,6 +325,7 @@
 	vmmc-supply =3D <&reg_module_3v3>;
 	vqmmc-supply =3D <&reg_DCDC3>;
 	non-removable;
+	sdhci-caps-mask =3D <0x80000000 0x0>;
 };
=20
 &iomuxc {
--=20
2.22.0

