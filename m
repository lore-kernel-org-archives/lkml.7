Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E023CC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A947720665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="aa1Lu9H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfHLOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:12 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728874AbfHLOWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0QATL+RZ+uZfaFJTEK+OwnjMVSefBp0WLw9tBrTR9Zx6uzH+hAEmlD/VKjcmf4rlmfJTmuIMbU+JBiskV+JRkemYVpt45msLOcYbCH1+TdWJUmlh1TtXLWTcijYwLltfay71m5agXH3QVtivYFW5A/N25tLx2YrsUY2pk2wjzb5a/pAqmoaUFQiZCEM/dAQJHRxTpBr4Vb8WvXb8vNGV08xYzCNxXVTvYX5nRIGbabzZ3rZbbt55hfgoU7u27eQO8fiwFByiSpWrcSzbgsrMMjYeF4JHbhsAPyhvG5vi1H0johD6K/4E+rq7kIZ6rSGin6i5vNjIftG8B5ZCNrPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u+hyau+hoSzjk4+N2Y/RQDOqCZXmiSHVhKg4A9tagU=;
 b=l1HTuY4+KcYwT5rykpjb/lK2u+W55vhemodagWwZ+lO+ZKZYuaJDfrIGp8s0dxpIuTzjPgxpeuOrmojPHyo2ELKHtEs3T8x7XDWH/u/jXn7xYgwLsM2zQ8j0gege0IX5Fu07X9fcd9kq+2luVMsTlF2JyT4MjZjB+JEzYNcDdJt7YCw+FkzpiFKYsp5gOQJaX3L8CxVjbN010j1aAtECc8kdLnXmllGNM8eoSItWaPOsq1oj94rAPurFQs1g8mBo2W8/oMGJC14KvRUpVC0VwTOWa41MRuEUt68wrmFDQU4tiH6s5B/H1msIyi7M++iZkj+1IS5Co5BZgFA63epvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6u+hyau+hoSzjk4+N2Y/RQDOqCZXmiSHVhKg4A9tagU=;
 b=aa1Lu9H//YUC7EGnAKemqUunw5hEyQnJQhAe2be+S3JV62mHbpUR6sguqf7l3w/w22Bcqf5wp4Exm4mSh77UQFODBPxugaRWv+CO2RvFZrwwCHRjwlndfOKUHzyxYXFeN254GPN7ppbwXL2bX0HCFKmB8xVvJJZsVD3oI3iJymg=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:40 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:40 +0000
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
Subject: [PATCH v4 16/21] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Topic: [PATCH v4 16/21] ARM: dts: imx6ull-colibri: Add watchdog
Thread-Index: AQHVURlCfEjdq9SVhUGuplq6y+p4Lg==
Date:   Mon, 12 Aug 2019 14:21:40 +0000
Message-ID: <20190812142105.1995-17-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: aacf1369-ff17-4e2b-3269-08d71f3064a9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2942A352716587597EE9584CF4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(4744005)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h8Vd4094eqwMiH+LUD7Z+UHrMp0M2Cbr+II3yMEQ0EllAQpentDNC4Q4PvYpZewJVpk1akWXDdIWT1uDXOCdQx29EClv4XDo4YCZkarb72K4BOORfshTSE00NDRK1/PgZbJACJmKzO8Tf3iJja3PioKCRBVXgONC353LP/skiRpypMSWCAinDffQ3AP7g22vg1fish8d37uZBGthiYE12iCUIax4/vLXWOxWmx8iOdWz87xHqTGAiONEX9ktNDeqntqMWz6DJpwKuUqc30RHYC5N8XXjwmW49m3UekMvhiRIUcbLvPZtHj3SOtWnmE+RXoKdkLyaC4rDvsIq0YS8KTN6J6inN1CA57U6/BybvpmwmZs35usJS6P99z+CpASb7vylFOsvu4BS0UNJmtxOz7dX+9BvAJE4weooFSaxozw=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf1369-ff17-4e2b-3269-08d71f3064a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:40.6234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfHEc8+EoJgU6iIPRbdNP/hqSfzlIq2NwzZ5TdpLsT2piArKMq5Tj5/inXuIyTTEKvJELiAl2/WpR4Y5Ux8J1PCV3mUzEdnQJCSfCcjYeEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the watchdog to the imx6ull-colibri devicetree

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

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
2.22.0

