Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46677FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E7321835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="lS7aToNd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406228AbfJPQ2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:28:49 -0400
Received: from mail-eopbgr30127.outbound.protection.outlook.com ([40.107.3.127]:36480
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404056AbfJPQ2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T4XIA9QH5uxGOZ+JeporiFSHKvU19eu4hU+429EBsajvVIdjyHU1PN6arHKGyWhsvTek0mKtKOJu/dHq7rr1PujPqZfHpK3zeXnZsAbni4C/D1Iubq5zaUNO6r7cIneqV32V5yHsMvKqdK2RnLQ1QpSsONYU2NGYn4gbdDTgYGAB86BCLAn5SBeorlNWWd0QRlxLmidqmoHV2wUZFSYjdHog9q4TsRGirkJfey6cjxc16stk1X+jBIvXjZFM5UKj6QhXM/kmlMwm3aanSQk/HDSs6nAnLKZwK8KvTheuPz7DH/2u6t8Gcf95eUXp+CclBBEj5kKDPmQaQYoSfe/8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EljIL6vBnzA0UbaGNyDZQxy2ZR+kT+6Lb4aBMLRCIf4=;
 b=C7CDCJqQK1MhwePC6j2ij69FxXRtNn+QgGPPyLwozuJAWaQzjrNewjVO47lagqsNJ1zHtU5D+ksVtqKD0ZWW57j6p2dK9sK1C7oZst7r7rzcNNnpfTzejmEUf6fx5SEJLPP+G2isieP+URFYL0QkXPf34NocRJuGXP4xPbIUayP6Spk3ANHA5kCaRnLJKqoysD9vhy/9AWaWm4sZ7ya5KEppkxQKDCffFewBJdHnw3ZsG3vQgPM5MB9+e+mAKpoLo06VxZWKKOoV6v9jDSp/EFTQBUryXzEZmJOgL46L0cMjaPmmKXoyOjPy5vJXpjpUoAuai74JAcSbzADoVDAF7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EljIL6vBnzA0UbaGNyDZQxy2ZR+kT+6Lb4aBMLRCIf4=;
 b=lS7aToNdkm6QKIWiv6+TEdSCUS+HAdz2UVvQJW6oYjUbT9vFUTjUECkWjh0gcvGkGbDRhKSLwvyDY1RXdYSP4mJoM0JepQAejv5vfwV8lgdvzoqCXuqnJvietbaiBQcpQMzdEiwkfwqSqf/lu0pmvbGBVOvTOWgcHTtDVl/qf20=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB3629.eurprd05.prod.outlook.com (52.134.7.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 16 Oct 2019 16:28:44 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 16:28:44 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luka Pivk <luka.pivk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v1 2/2] arm: dts: vf-colibri: add recovery mode to i2c
Thread-Topic: [PATCH v1 2/2] arm: dts: vf-colibri: add recovery mode to i2c
Thread-Index: AQHVhD7H8G6VDxhlKU2zTwJWkgHwYQ==
Date:   Wed, 16 Oct 2019 16:28:44 +0000
Message-ID: <20191016162833.1893-2-philippe.schenker@toradex.com>
References: <20191016162833.1893-1-philippe.schenker@toradex.com>
In-Reply-To: <20191016162833.1893-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR02CA0006.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::19) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:26::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72a7f2c7-4080-4be9-3a74-08d75255e98c
x-ms-traffictypediagnostic: VI1PR0502MB3629:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3629D6F2504775636C87C829F4920@VI1PR0502MB3629.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(346002)(396003)(376002)(39850400004)(189003)(199004)(66066001)(26005)(86362001)(54906003)(36756003)(8676002)(7736002)(4326008)(66946007)(71190400001)(71200400001)(478600001)(6512007)(256004)(14444005)(44832011)(386003)(66556008)(66446008)(66476007)(2906002)(64756008)(6506007)(5660300002)(102836004)(99286004)(316002)(11346002)(186003)(446003)(25786009)(4744005)(1076003)(486006)(14454004)(8936002)(2501003)(81156014)(3846002)(2616005)(50226002)(305945005)(6116002)(76176011)(476003)(6436002)(81166006)(52116002)(110136005)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3629;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9ZOc+bfuQlrryLjwVFKbjTzv7lgnTLAuglU6L0sxKgVQnaWELhkzPZlCwAcuhfSA1qJoQ3F7DPmHFY7v1mHqftiCt6OMj3jpjJAYNcQ7P7TLZ/HpIRataYUc7S/QfPXcgYC6nad75SmqjrrCs6Sr2/CCmhi6YxjEgg0ZsWmXgUDu5vrD3JoaPvceFHX2E3dn50vNZZcSSqBKbFZpGfWcUguS8Aq3vzAePNh33rLsHggbgI+LNw6eGtU52j8SnydJECd9NUhTX53tCTPi/5gnqdfjZcIUtLqaIMkfGECYZmkWGKVMS3j4Nckizif0+uPo1MDQ54mkZvoRNXjj1E4oa6/hTzIUQh0eYqSqxr66b8hQNoZxuQrbiLoc5lGc+04sXUe0rON3hX6MhfHtPvMin52hlt1uzlP+CCpIQqQw14=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a7f2c7-4080-4be9-3a74-08d75255e98c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 16:28:44.2522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiCLaikWFDhQE9ks6aGZk9XsEVXi8K9PZ7bQ7v2tc39va7SVZMMaHLSZSyGvUZDwgaEDw5sdnMqI6YW1lbHmgGtsr+RAwRvxpQfvNi/yx8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the recovery mode now available.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/vf-colibri.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colib=
ri.dtsi
index b6a1eeeb2bb4..254402c4f872 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -129,8 +129,9 @@
=20
 &i2c0 {
 	clock-frequency =3D <400000>;
-	pinctrl-names =3D "default";
+	pinctrl-names =3D "default", "gpio";
 	pinctrl-0 =3D <&pinctrl_i2c0>;
+	pinctrl-1 =3D <&pinctrl_i2c0_gpio>;
 };
=20
 &nfc {
@@ -308,6 +309,13 @@
 			>;
 		};
=20
+		pinctrl_i2c0_gpio: i2c0gpiogrp {
+			fsl,pins =3D <
+				VF610_PAD_PTB14__GPIO_36		0x37ff
+				VF610_PAD_PTB15__GPIO_37		0x37ff
+			>;
+		};
+
 		pinctrl_nfc: nfcgrp {
 			fsl,pins =3D <
 				VF610_PAD_PTD23__NF_IO7		0x28df
--=20
2.23.0

