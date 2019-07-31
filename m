Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F15C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1CF206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Ku6MyA5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387873AbfGaMix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:38:53 -0400
Received: from mail-eopbgr00137.outbound.protection.outlook.com ([40.107.0.137]:9952
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387807AbfGaMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEzOhVbMTyV+bAbiAR5zr/ShWrAS28VMuZhsEpVAs/f117bFM122sPGKfYRbLuOQpucVHn6EDDN7IDw9o09mpFOQzDAvcQISV7KeZKggLPyL4IsF1cDYQ8CHz/WF+CEIkPY3XoiuFonEHEg9S1BXoIpojYly13bPZP7kwSZXqtp1CNH6WZg0kKxMAC1mPCHZH3/f8ulVs5tADjtqrIyxHY+KkLsVl3nGcEtksFTsQamtUIbZk93QBZn3TlX+TNubff47XvGJz/iwa2Fqk8St4Ze7HH2+aIOwflLDPvz+WkXEQf0z8z77WXnk7vWnMHmvAB9LflGsxgejpHcL6MdPKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wanH7p6X7Fm1dk4WmWPJbTHkA5O6X+k2K8g7fGchMOE=;
 b=e4M8SthTX8NeS0kN1U33LV8ZWoTpOgCmOhZCP4XqwkJTvGRJx8/wvkG3s90U6qyao1c0dX/IiPkrrHX2kI5R9zHdLg5EZZBPiHUyWsa+7oZst0Ebhq2MOpaI4fcvfaM5ygposDTksFvoy9zM6yFJs3cuPk5/E0/ZNDV1iTrBexoy/q9rrKP06ftK5TCBHkov1iHawgMRIuRXZr2ktrs99dyHDN5zZfFPmEqf4z34kA9b6CzvIo6R+4GM4uq0XQ2zlRJMny0zmG9VjMej7r5cvsCX1satvvGe2ZAFKs6oS2H64bjrt2PqopPVO0s7CO6atCjh2485r1KuHZrcKFuJrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wanH7p6X7Fm1dk4WmWPJbTHkA5O6X+k2K8g7fGchMOE=;
 b=Ku6MyA5MyyjCqzkDzaLNlK28rXgdtdCmVdIS0gTqhlZlCoSuBzY74UwlDd2bvuQWGAA6xwqYlXx73Qra892Q+R+sYuG8++pxj+ehJECbpzjwly+OGYA4tM4mYn1krnaMVUnsFyMHyBSISauF2sfhoCvQkztVI1weq4scuUrTBZY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:33 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:33 +0000
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
Subject: [PATCH v2 19/20] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Topic: [PATCH v2 19/20] ARM: dts: imx6/7-colibri: switch dr_mode to otg
Thread-Index: AQHVR5zdj+emrim3kkKxDCTUiSuG2A==
Date:   Wed, 31 Jul 2019 12:38:33 +0000
Message-ID: <20190731123750.25670-20-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: c80eb556-e6c1-4cc7-58f4-08d715b3fff6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB361560E18252BBB7C1C6E02DF4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(4744005)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(14444005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3ouXJi+nJuFA3j9QbPdsZQaHcP3eZlhhV9A6RElI0L/8PG9mUR5z22zVAaZLj0Y43LZ93pTNqxwMnk277Nd57oZUUx/w2ubx/373AcZJ8mESNBYXJgAWdbk2ClnhnvvX4mXc1FOmTOS5TOEMTWvp6Dx50MqflDr4QphtwarWOlVCJhJLDYlTqkRXAY/vnBqyr4oFi7QP6AeaPt8pyf70CIi/Nxw2ZEy72TM9QlQEf3BIMALNc6EJrQTI4kqvqJZs8bGmrwufBQaqadc7+NTngqLyPiLkysgyVq4ydjDpByXBJtHhX16vt8xoAcsaIjvKagmVrcnE4DIcXmCiy4E9opex1MN5aKBV5YpPYAlIItDOHxtDBFblaSzzMsMLB8YAOanaw2TSO0CX4v77WYY7GecTIB5CsLmWwTX7Euj6zXE=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80eb556-e6c1-4cc7-58f4-08d715b3fff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:33.5917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: philippe.schenker@toradex.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3615
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the otg ports, that these modules support, it is needed
that dr_mode is on otg. Switch to use that feature.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

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

