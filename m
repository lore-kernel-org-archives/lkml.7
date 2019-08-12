Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E0AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7092085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="GW11du9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfHLOV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:29 -0400
Received: from mail-eopbgr150109.outbound.protection.outlook.com ([40.107.15.109]:32224
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbfHLOVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd9796iRTs/hXa7wNHfL/OBw2Jgz6YDytbTwhgdk2j0+6LCvMIplap/mP601Rdm1dhbh4IQAvWUIqr/BmpD5TTrZ/UjzFF+b3ahMK/bRnShuvjhXVCFOy6vJDdDLoXXdGTNPbOxvQTXjRicybNZ0qqqeZ0wspSQsnzW9jQI3SXimFoHW/oyCqwYZvrJsX6WnqRTGkfuRyghJbcDmCuGakp7DIk0+H/Hn4yXyxdvBkC5sy4JrbnQfEfJK4k8qwONUFtA/ZZnbcLPrRR7DiPP+KcQzWUKc7K3wraoU8VhRDNV15gfXwIb2UQd0c0Pbt6m1Rg20Vo1ZNpLWb5XHr8ypyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkat0NfGfZuXprgBMxB+9AIWEB/XaWRTuRAmHwEIuJA=;
 b=SrMDEDiMYvAeWZMYHsRTD2ZqSKTrWgWoZi4+XVgW7QecYRd9+2nxitHpmxces9d0XdTg64pJ43HcH58RJYz8FRg+fgttSJAoq9+7zc/AtgZgIdWVOVJ81U4rjDiTdDIZMgUmrTe9pQ8wFoGPxW07rGgUk0Nke21Lbz30HSl7CIBYl4WM6gSRE1iF9olwTOJw+hvrcMPflK70Vx4MDgqv4nRYw/CigEuQUBFbrwIeqsmietqB4ooB97NIG8iSk9cK57T3x9i62t7A39jxwwktDh0e0105JeFTYM8WzoGJoyvxdm4MNwXGfOcxkOHMbAJGgvACiE85rB6Y9GD/mxxOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkat0NfGfZuXprgBMxB+9AIWEB/XaWRTuRAmHwEIuJA=;
 b=GW11du9gSQn5VluRyF4aJ9r+kdU4CFc2oylhCH+99y/D1z+a63Ow/NeeywgI982HoUmGZS2x0agG34t+LayA8865Bv5sw3i5oG9mo4PexUaH2N89yDVkjflVEEdZDmpszmS9MoNuBS/ldh5UR/QT/zxNVcjAyxLEVibG6UVKFvA=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:16 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:16 +0000
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
Subject: [PATCH v4 01/21] ARM: dts: imx7-colibri: make sure module supplies
 are always on
Thread-Topic: [PATCH v4 01/21] ARM: dts: imx7-colibri: make sure module
 supplies are always on
Thread-Index: AQHVURkz1TGp90q5Q0KIRAUabfIgfA==
Date:   Mon, 12 Aug 2019 14:21:15 +0000
Message-ID: <20190812142105.1995-2-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 262f067f-40fb-49a0-e9a8-08d71f305600
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB294215D73BE0EFF84B08A4C9F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39840400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(4744005)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MI4V9MPukQ2GcJTYvecws/uvmtYFnj9S5dvi9XZE1Vfzkc/7buRbpThRYboQoyCAnbuAYb7e7co8FOGcvQVFRRb6TFXdhmOvDP+ttOnQRc/pEakdWXcaFmjbgY+OUKN6qbYKtY87TnN4SzuhPASsymTqc/qdBdiViifYLFJvUxC6KSd6Y85Wtat8KKaviu/baBhEfyL5sMQfnxOJ7UgdtNC/8p7Br+mjXT961GGSHaaOmDCP3cot4yKBCD8Vvh8XFxUK0idk/OMDmGRjHhF0vcsGEZI+N4iSWDwwd7M4OF8zCLvZpR0CqqL17liKtXv+RuQbGH3cnaB0Et7QLNva5vVYmCFQKMF5S8a45KjOpCnm2oPRGW22F3QlRe0gNeVdtJbgg28MShDm8LOsm3o2TvoKomIz2SI3s8SQYYFd0jI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262f067f-40fb-49a0-e9a8-08d71f305600
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:15.9945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOBSsDLUb8kztjZjeS3IQ6LUqF+ICLiwhT2LAxkV/IwLDC9PrbZjXk5F/MTV63QqYfKGlo9Ks0as2iX6Tz3HVcuL7YAAHvM6J5uPIePpUks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Prevent regulators from being switched off.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx7-colibri.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index 895fbde4d433..f1c1971f2160 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -54,6 +54,7 @@
 		regulator-name =3D "+V3.3";
 		regulator-min-microvolt =3D <3300000>;
 		regulator-max-microvolt =3D <3300000>;
+		regulator-always-on;
 	};
=20
 	reg_module_3v3_avdd: regulator-module-3v3-avdd {
@@ -61,6 +62,7 @@
 		regulator-name =3D "+V3.3_AVDD_AUDIO";
 		regulator-min-microvolt =3D <3300000>;
 		regulator-max-microvolt =3D <3300000>;
+		regulator-always-on;
 	};
=20
 	sound {
--=20
2.22.0

