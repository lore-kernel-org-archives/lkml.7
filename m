Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95696C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C98217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="croJcq/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbfHGI1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:27:09 -0400
Received: from mail-eopbgr130117.outbound.protection.outlook.com ([40.107.13.117]:6210
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387713AbfHGI0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kVllv5MTvrVclAKhUuM1zMilcut9Q7wAlL6KFz4Udj0lEHwV2IHaF6tTQ5tLPljs15bYI+dfd9dW05TaYLlzOvj+XY0U2x/PvQ+T0LXQgbGxgtM3NIT7j1skbY7u3I1QWvCCuvIJj3Prc6d6Ca8l2TMFy9eJkd+XByFRnUc0Nd4GHWyAf7/wxbzO4BorRwYfmTiPasXXTpcxzxQ92V4yXtT3koDajOp+RYpLvcDvNUOzpci1Aii88mGPf93nyqU6DQPI2Njn0pa0cWz7iWOhvEVFRUXcjHcOmk0y7qbyvhhM2mAYEaogEdlLcq0Qo4GgbTPfZMmbdjoGranSvsCh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku3AQfp5VQeDR/9dE4om5YBobpXhmfT8C78mfIroT5M=;
 b=ZJtQyoG0s3+cBwJe37O0LbP6DlhDFD8CQzNIGU331p6W2v6lz8Pcza1ASE2y0d5zYavI/666dH7zabH8BtHnqDPnO9oYcK2JsxLclrPLCjcj2GK/zaIbhoZv1Qmh5oZup79oifuZ4nyCNsMYaq048ecickihacCfpghSL4y/gLQrG3b24O7hvmZWZwiRA+BCkxWRKBJ9ygUnzCHf7BZCCvXzkA+Dwn2Yd65SwmXrFgJ5LFZIu/7gpiAiTUQU93xbCdhgQBTkIA/z0iva01iUdS57yvPG4iB5/w/1Yy1WYWNep05xdavB4SqVag8bpkFb3eEElN5qAemPcp6A2KZyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku3AQfp5VQeDR/9dE4om5YBobpXhmfT8C78mfIroT5M=;
 b=croJcq/e9v23KVGfHXesCs0aiYygA9SCcFsuzJo9ji/e0EclYMo/wUiUaVGAfNEokET0LxoBnBTtdmmxiSyGNJ7uH8r/zjw2swgytV3d5YshUNfrOtA2fPqKUpCLj4Bs3HATYw8hOm1y+u1kNXnyFiqMzIu0EEXGKDeYMDOzVBo=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:45 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:45 +0000
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
Subject: [PATCH v3 19/21] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Topic: [PATCH v3 19/21] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Index: AQHVTPnYpzmKFIEQakCY1BjdKzKruA==
Date:   Wed, 7 Aug 2019 08:26:44 +0000
Message-ID: <20190807082556.5013-20-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: dd8aebf6-b3c7-417c-5029-08d71b10fb4e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB361419D9772F15FD356515C0F4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(14444005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GVqh8h7h0ixmkXCtfV8tDccrbp0bZhaO9eyt3cWVGoIPVNi53ulcc6CIP2KrF72fv1Fp7VP5dH9YZh7hbLPo4EXnYmlwv77yubGzgorzxAWKoWeddM7TDOqnf4M8ZDTdv0DnAX93W3kbO8mo5hj514tU98nmNEfRZm+MyDYqRdYuE/Yspp7jTQsUsxnt03TELT//9MedTQcfVSSlzmRb5msbwSP3G5zLsz6Sin712TOzMvYp7U++deyRYIUbVug0atdkCYZta6z/eVNV5wRX7VueqQuv79XHCW3npT/wtVSNYmuHo+6WFJH5qNI1O90/kVCj/BVlpOeZTs1TEtQmKNVXU9JKNTunC+Zh6PWL9qKV6SjO0lxEulpIvVfzWfPGkeNwt0hEHocbleRUqJmyWbltnTkzg0Rpb8TWRkhEpRI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8aebf6-b3c7-417c-5029-08d71b10fb4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:45.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ae+nn+lNBJSnsFzpjCKnSRbx9pfVNp6gmNfFDfkhnif8DFtLyELqg19HZaDZSJk0t7e6wWoRPzkrtKTn1YgN2s6rjVqCFEbC6jIjDs+HkUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the otg ports, that these modules support, it is needed
that dr_mode is on otg. Switch to use that feature.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 arch/arm/boot/dts/imx7-colibri.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx=
6qdl-colibri.dtsi
index 9a63debab0b5..6674198346d2 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -388,7 +388,7 @@
 &usbotg {
 	pinctrl-names =3D "default";
 	disable-over-current;
-	dr_mode =3D "peripheral";
+	dr_mode =3D "otg";
 	status =3D "disabled";
 };
=20
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index 67f5e0c87fdc..42478f1aa146 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -320,7 +320,7 @@
 };
=20
 &usbotg1 {
-	dr_mode =3D "host";
+	dr_mode =3D "otg";
 };
=20
 &usdhc1 {
--=20
2.22.0

