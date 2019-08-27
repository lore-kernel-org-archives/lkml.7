Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F60C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6B9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CF99QN/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbfH0NTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:19:06 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:29946
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729810AbfH0NSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk2BtpmBv5OoSGBgbzQrZr/YEbteoaHoY8r+1JxXzhaM7C31aXGUM0j2M4tbh2MuWHkK+hYbLA/Cl1x73WYV1t0d//MiF9uCvrQdoigA6I/bILNcMkD5Ueer0YEvA6lDfCqyjyFnDDZas7WYKstBMCReyknGfeu7lDXmkywgP6LuOuz44uT5onldMM4hw8LbeAz9ZsNjjb5IE8GzAV6F52Y0obvvvJwoN6olVqG+5Ch/yA9Tay4CnZUpSVfPlokC1y/MTllOWSWwSaVPWTEFa/gAaBnnBYIHF9NqRRgFEwawq+zDDU7hszo9Vbw/DdEGCmdbtiIJjbU7lTodTm0u4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF0vUPYDx6834cH7zlHc+B8vMi1IQkeBeWO+IsmhPPw=;
 b=BpzL8QAIGvPq+ycUjHiczZX4ISwCCi2CBO63SeAzWQ+kdhk/lx/KD2ITfyR2yt8Xb8eJLqQSDRQxlnpfhYqgzv0xkDQ6O4WBqGWw+Wdms84Pb7/X+QbANHFxvOgjT89hWEUjJ3uLgGg6Mr1DKZN9EOCe/VzVWsEv4LbEScdKfAp4Y6flBLMiei72YMC6c10m9A5Wy9W9ikLZJkFouGUnKNtSwU+tC7zUxzcWNmrLzeIad8uQY1HTRSV/l2OJmE37T9oZ/ZjBXtOoUKLMHcDtD5f+PKz1aaMcOboyktzBaEPfzm9iiWrHbr50Y1uBBfOMOFEfAdL9Tz+KXm0denp9SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF0vUPYDx6834cH7zlHc+B8vMi1IQkeBeWO+IsmhPPw=;
 b=CF99QN/vFG7w4OamwBdzTbQXJf8VNZ7ofxEQwpQ6cPVo2fjzHHsLjvz1CqGf4ZZSZfSKXgXTytZ4DpfGtCA8j8L0prtUBX4t3+ZtMZlsrZFcHZ1g7d8sFbjO/XYtiT/8XKHglT3YkDuTgIEYqr3WiyBddckacyP7SBrOloOkJNw=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3008.eurprd05.prod.outlook.com (10.172.255.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:36 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:36 +0000
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
Subject: [PATCH v5 10/13] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Topic: [PATCH v5 10/13] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Index: AQHVXNnvIkDHPkM4fEe9n/ZzEOccfg==
Date:   Tue, 27 Aug 2019 13:18:36 +0000
Message-ID: <20190827131806.6816-11-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: dff97774-933c-4923-868e-08d72af1115b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3008;
x-ms-traffictypediagnostic: VI1PR0502MB3008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3008C8441614BD1C1EA02255F4A00@VI1PR0502MB3008.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(199004)(189003)(4326008)(256004)(36756003)(6512007)(86362001)(5660300002)(25786009)(66446008)(64756008)(66476007)(66556008)(1076003)(478600001)(66066001)(316002)(110136005)(53936002)(71200400001)(54906003)(71190400001)(7416002)(8936002)(8676002)(52116002)(76176011)(6116002)(6486002)(50226002)(3846002)(2906002)(66946007)(4744005)(99286004)(486006)(44832011)(2616005)(14454004)(305945005)(6506007)(386003)(186003)(7736002)(26005)(81156014)(81166006)(6436002)(476003)(11346002)(446003)(102836004)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3008;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QMdE00kSMHXNPJvi9Z614jWJ3iqdBDv4hzr7Mxjh/AiQucDd8708ZbrWmlVuKVZbp9fXuvLsVoEp+DMu+3XaF++iI1u6MIxCtzczDZ4y4EAg7GbID7KwFWWVNEaPspJippVkL55QOimOXLvR9UIFQGQUvC9e5z9kMjwaNHj32ySBWdFiyj9RePk1oHDXMDneKSUxkkhpXga493MjDzT51q2Ap5Qy+Fw7sf7TK9SLnm4jIwlhciqmL5QyiNqOY1AgdEHCWBd8YmzhOVPJSk/vQF/LANN3BL37uPTfoz/OGKAIFrZudYRC49V3TFjIjuAmdQqohUNpBSsBvIAxNkIlf5/dUMZMjx1aVa+8l7asBXLqJhc+uZpXHNFkS72LsMn1vdyetfLkp9JA7O/yz4rAVHBciA1R/ipUHVKBR5vmWL8=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dff97774-933c-4923-868e-08d72af1115b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:36.5279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Toxhhlk0q8QkmsW4MwmIC3hFs16csH1w9Wujh93bRifuChYObcBLLiqlJm64P0wml9wh3I4UMKhdqGHVf1r05jXF3unzm4rlivXcJe5g26s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the watchdog to the imx6ull-colibri devicetree

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v5: None
Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index 1f112ec55e5c..e3220298dd6f 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -199,6 +199,12 @@
 	assigned-clock-rates =3D <0>, <198000000>;
 };
=20
+&wdog1 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
 &iomuxc {
 	pinctrl_can_int: canint-grp {
 		fsl,pins =3D <
@@ -506,6 +512,12 @@
 			MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT	0x14
 		>;
 	};
+
+	pinctrl_wdog: wdog-grp {
+		fsl,pins =3D <
+			MX6UL_PAD_LCD_RESET__WDOG1_WDOG_ANY    0x30b0
+		>;
+	};
 };
=20
 &iomuxc_snvs {
--=20
2.23.0

