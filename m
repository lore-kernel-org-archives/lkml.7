Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5F7C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7645229F5
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="m74gMlGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfHGI0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:18 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:35606
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727842AbfHGI0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYwdqsC+vq8/PnJZ1YfnEXTO5Iv2czzeIzoxP2cMw+HpdvTTMHHXmjk4/JwHg/oSBPt9SyhTy7ZtK/CFy1lkTSYEyHPbFCRagqUDTQXvJQRk1Yzvet6nWJ7BJD02psfj6N4xMy0h4cxk5henyxNK/D4BAatc97ib+l55Z6OdiOIaUDiR5ervAc3s8cNEB0Ao7uqbSe0Sv2Kh9yRKXyYG99e1TxeX4cp6QBRnl8+VgO55qTcyt/gvB1JpIxSsa8JL89+esWE9V3t+5+b8sj99KKfvX0Kq85Gz0lkoMIjRxMWb6UN8+ucB3vjDZr9bpWE4djdrDjLE1HDUBiI7xMl+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LUBrBixX/2ZZ6kl/fbAzYIcTmYzCO+ljWwuYDr1UqI=;
 b=eWsuwwXnUgq+3oVh5NPi2QvqH66H9+dQ8rGd4RL6A43Itue813rax/00/RNcAoX8dad7shdWfQWcLMK87p0eFGwNSQTFQ/kCKI1mXrOuIerjH7s71SPjPRc87JyOO7eCqABqI5764LwRzfkSCqGe10OL1lUcEvui/fIt2ObwYz1xvBEueVwOBMoysIfd8CgEfZlaSh5tMJ9mGNspsmJKEY7WuZcJ4Pdj3Esni672ot4hOnNuCkxRkv2fN22yobM3cwRrwOh4X5+W1RZLWpOYjPGAxDQr69jmT/Ap9ovoHNH/ufWAPWpyt8NSFbYutE/WCzqvq9MCTd6kynMsZdibXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LUBrBixX/2ZZ6kl/fbAzYIcTmYzCO+ljWwuYDr1UqI=;
 b=m74gMlGuq7RUvzuKq0Ql29ITRFBNCOtXYWYsS0i2TM4FLlWWTP3Wu4+4+aCY/MIhLWkHg70ebfXlqvObu/THYtSSzqoGfXSDKH9vOCG5ZtpK4B1Tz+zxhy1H3rubg4uJ3tHAGrC7TD9zSzBG4qB54Yl3baR2L0T8Js4+eq6JZFw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:10 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:10 +0000
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
Subject: [PATCH v3 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Topic: [PATCH v3 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Index: AQHVTPnEmTa3kafJt0yUUyr/5g687A==
Date:   Wed, 7 Aug 2019 08:26:09 +0000
Message-ID: <20190807082556.5013-3-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: adf19d88-a1e0-4fc2-c562-08d71b10e681
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB3614B76F8A0FCEEBB5AA0D76F4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: da9eecfK+nqVm4xT0V5RGnvfggbiZ1XgG5jYKSZB6tYqh4KcZCKCcLNQSBePLclomw8m1eVgdNHF5oXhoLsdYfzkIVfRnXZCBN6QJ0uyJl6BjL335x2PuympSXVkQZDCLS39ERklBQ5lFvFTV783ox3Y0XTQSeSkLzQVNA+Pk/y0UEJNQXvn0ig5rC62108q5qycNNnr4m4Oqoh0L+BQcxd2/UbI2WEQ85BNlSg9+DA9Ii7PJUtgNt0H82xwXKoMrbWswW5qNok32SLe8YsPFZl6hA5oIugeKU3DqUm1XormkiO4WX117fH5amP9lSKLa6lcGuuPI0Pid6vYkW/3R2X+MRRntsracf8Hv8NmUNan8xbqUgu38hFER+r0JlxQ2pWGTJ10cA5GwyL01YQNF+59n8Lf4E3uNsGMdJOwf5c=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf19d88-a1e0-4fc2-c562-08d71b10e681
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:09.9284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8/9Ct+PQJ3PFPQIGPt57sivRN78CXs2PDQss/mxWiy3pbgG4PDpwIl85T7SSskNioigvfIVA2d8y5CVLRFBNXiHcteyuMZgn4OxWeFbadQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
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

