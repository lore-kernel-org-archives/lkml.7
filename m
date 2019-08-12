Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B702AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF4520665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Zu9QQRtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfHLOWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:49 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728463AbfHLOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhKMHRcjV2W1+kY/mLKMonEFQML+mHJrPCg9H/yKrpZrnRo+qAmAtUhHeskJ9eCE1QHQF+0tRcwo45t8ObcVr8FTqfDCsHzaUrUSsPJX4HxnhC90UOlbqBVd1VSDDVYC+sOtXyJfeQeSiwUgrF5a9lMuvW45GjVwQlX0W6qgc69/oPTsKK1tMOTLw2Pv52ikmoweNHy/7rnSHiBnroNzI9rs5Py2setk6YWggnqMjOy2tkCFKZGbhMl6zZV/EoaxiiauK4R2GWpavWR3zwKUHGBr+XgnSGtKNvBlffAWOSR+tjy0CwLKDLCOlyiieuYgdODKyn6fr4V3rZvRgH5k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haJ+RPuA11Fu5iwSQ9+pX6qnr+3x5lNecJWdNQOTrB4=;
 b=ahG71vLMv2X3DOr0YxADwBsdCGS+DlCVZQtIYYyn3L67Lo6G7NNRQxMA1smTnoaOjBTAww/opqBFZZtZ5IAYi3JtvDXJowsBRrIzEAoG17DOjZtNNtm6bqRFmp/cGxFAy6MWE+SeMKs5JmJjNtSh4ADJfa8SeRFPFe6TBD1Biz/v1BifUn4GOrmyRp1YYpLEWtI5odk6XUE2zQfNvygtzk2kl4VoI9kbM9cnoMSLDZPkPCcpisryOLJb1aPPmxN0Uq9DdOJ6Sb+k4A1FTXrwITZVjtRmvledpi0J/6k6FI0KMzxPwDhG/CSnW8W7mn+dKFytR5nXKB6qHx2lprWQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haJ+RPuA11Fu5iwSQ9+pX6qnr+3x5lNecJWdNQOTrB4=;
 b=Zu9QQRtbvgn4dJLRFKDozGTBW5KrM+MJCCiq324Mmu7Nv02gnUU1AEPOA/40eM2Y5lhYVtuamDEUOz+cScubPDFR2kE/yO2fzGVHRkPummAcYQGcYu8sn27Nu7pvt4dx1mM/f4nSHIDqDSwGjv03yWGQkmrKwvXfRVkIVv0fiaE=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:34 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:34 +0000
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
Subject: [PATCH v4 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing to
 Toradex eval board
Thread-Topic: [PATCH v4 13/21] ARM: dts: imx6-colibri: Add missing pinmuxing
 to Toradex eval board
Thread-Index: AQHVURk+uU2lGxrxjk+Uj7oHaTp4/g==
Date:   Mon, 12 Aug 2019 14:21:34 +0000
Message-ID: <20190812142105.1995-14-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: b3b7de91-3310-4a12-0a0b-08d71f306116
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB294207DDAB79ADE155BA0769F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(4744005)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: epyvqD2rvs/R/5iBq5y30Xj1cbnn/GoeGP1/RjGiXR8wutxtEuvneekfD2ciZqv918o0YhppQ+4Y9QMp1oF48EBL8pbeJ8G+7okZKzShV/EFIFgDRbXb1bFWin7a+60cTVQypysx7KEHQdLJ1uI0exOBbBckLi/ngcrKNL5jlhfSFp/Rd+9OvIUNSz0t/O49o/dVGyuedt1i4bS6JDmenV5r//y0tGE8HylYx9bsku9qthsHhPLwyJirGgGmG00URNv/lXYY5bBoIoVsWL8HadWlWcL+ItDozeyQqHL2dmjDgTreLFhAvUNGCLJGAelXh17qKVoox6+ZzeSQ7Vs2ZEeadqQBZ9YXCAdpXCSnk4rTaSaG72QhVSW6jjWQ8z9qAx9MONbdIirDJNONiDCJ5IKN2heVwHOmaaAkAViqiXA=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b7de91-3310-4a12-0a0b-08d71f306116
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:34.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWy2buv8TMoqMsnyQbSEKSsvrVCbPTXUQgsdH4YPG+XsgeQEf38t/hm5lVtNnyXOy9lFbElQLT6oCd+yb/lDTAButSlIKf+lOnAx0TDixCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds some missing pinmuxing that is in the colibri
standard to the dts.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2:
- Commit title

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/d=
ts/imx6dl-colibri-eval-v3.dts
index 763fb5e90bd3..e7a2d8c3b2d4 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -191,6 +191,14 @@
 };
=20
 &iomuxc {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <
+		&pinctrl_weim_gpio_1 &pinctrl_weim_gpio_2
+		&pinctrl_weim_gpio_3 &pinctrl_weim_gpio_4
+		&pinctrl_weim_gpio_5 &pinctrl_weim_gpio_6
+		&pinctrl_usbh_oc_1 &pinctrl_usbc_id_1
+	>;
+
 	pinctrl_pcap_1: pcap-1 {
 		fsl,pins =3D <
 			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
--=20
2.22.0

