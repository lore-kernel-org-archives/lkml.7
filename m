Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E844DC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2612173B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Vil0qKez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfHLOWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:22:09 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728838AbfHLOWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:22:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpTXBmrVriF7wJZfRComhYkmwxWKh/lf5gPTnbWh0tGwy95tJHnenpF1g4/bFrIJf3fssYW6RDFTeG4rBuS7Rk+xl918uq9G4Hd+T461OSlOva8ErRAP4C1cjNvWoWCcwNxTLY3EmAtuPM1BtFtJ/0wAV1yHyVhp850O1Vj+F7kp6IovYGCt8uwjye2DQH9uhJAHtH9XPYLITOXJDLTzVlnx9KDN/x5UcQWXEAD1qcgR4w/ByVbeFO5ydQfdpTOoYiK1ENdA7P8srrl84RQThxLIsvBWaetf+f2yyDiAJR/mFPoB90/fGKU/sja+40gXUiR5G3TlI5ql0rQWicE0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWa/xHZsIFGQ+ba+M2ppoyAUYYK9GUj20s8s+K/o+Ak=;
 b=WBUWCEr6YcVOHeHVnUrLzpixQz8zZ5X4qJebujhLPmwGy9SCqv/OrUb3mWTeW6zpRcBrReZQVBh1rdgIQr9x6fmuLc3xqElSg9oBIdSFMWA8TygJea1oC4ts3D1dKB59g9pdEQiGHGQe+6y6uynpfgB43d3ta8E+d6lXlhMolNvxMo+B7FPRSZw6a1o5Ma45KVF5XqKo9tbg0XTKYNCXyJuHMHRGg+CiGnCt8siuf1rD0iVZhxhgFTi0M6O7/dH8oxCBMwsGXrgqH3zuIm5H7EOre/rkpaOLom9oaMBmlHJKiiGEv/0lebL370BcSgGxteWeYIwHfSc230IqW75DkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWa/xHZsIFGQ+ba+M2ppoyAUYYK9GUj20s8s+K/o+Ak=;
 b=Vil0qKez2X3ffWq8ru6QCvtwU+IXuCW50+zh8OyglpgF7g95AAbB5/Lob9Oc9vACwq5W4pqG8RdhvTmWHjFOZ2iYmRhN6go7/oRSefYGR9xWLgAxmtxzcf9eCC6D+gHiZE0OCA1ctuoh3NfTTZ61SqIFB9p7jrMrmII41EFv22k=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:39 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:39 +0000
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
Subject: [PATCH v4 15/21] ARM: dts: imx6ull-colibri: reduce v_batt current in
 power off
Thread-Topic: [PATCH v4 15/21] ARM: dts: imx6ull-colibri: reduce v_batt
 current in power off
Thread-Index: AQHVURlBuMVOeqxvH0CXDzr0Xq36VA==
Date:   Mon, 12 Aug 2019 14:21:39 +0000
Message-ID: <20190812142105.1995-16-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 58d0bd7d-a2e3-45b0-e21a-08d71f3063cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB29428286B6C4E1B4335B86A2F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Vu3/KTrkjap3yXkAaXkkVNw41QYNQhGtH2PJGq7RTsa2kk2z3Mwxg69ISozXt515iC2PEZlxBqMIPTMFh20r9SbQMdy4lJrlpNMpDD0BU3Re7qvnC4PJrw3wcZjfC40KA8Kr8RJx8CMagQVXBWWCDZWOt54R1xRGEoQ3CnlNZ+ujFlfeWK2d8LVKxm91vfGOh1U//+H2aZfNvgFc8h4VyhODyMqZUQej7NeoaU9xTeRXX3S1FEAAvDX04CBg8GyhK+twt1tTUWe6MkR33Q3Pkq4i/T2mXmCgwS/a9B5V5g0iQNEjHS7SRQIjuxj3INyd6hehZ/bnAREMTD87cHVcg5C80n0Y/4AhXrVPIey2BhAP38VpJOYG1DerA0hcTiQSuz+BLXepbNNoyLz2kmQnVhpzT6Apu7gbw9w+jZKqt0=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d0bd7d-a2e3-45b0-e21a-08d71f3063cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:39.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74Yz1nqjlMEjnml1SNTzfrXETRH7U/PNcbh2N/AT4FjeX/9FX/7oFFqoVNA+50TqvKPePsC2GyRmLnoUZvyh6TkTLK9SB1Npcj5Pf1wIlN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

Reduce the current drawn from VCC_BATT when the main power on the 3V3
pins to the module are switched off.

This switches off SoC internal pull resistors which are provided on the
module for TAMPER7 and TAMPER9 SoC pin and switches on a pull down
instead of a pullup for the USBC_DET module pin (TAMPER2).

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index 1019ce69a242..1f112ec55e5c 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -533,19 +533,19 @@
=20
 	pinctrl_snvs_ad7879_int: snvs-ad7879-int-grp { /* TOUCH Interrupt */
 		fsl,pins =3D <
-			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x100b0
 		>;
 	};
=20
 	pinctrl_snvs_reg_sd: snvs-reg-sd-grp {
 		fsl,pins =3D <
-			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x4001b8b0
+			MX6ULL_PAD_SNVS_TAMPER9__GPIO5_IO09	0x400100b0
 		>;
 	};
=20
 	pinctrl_snvs_usbc_det: snvs-usbc-det-grp {
 		fsl,pins =3D <
-			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x1b0b0
+			MX6ULL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x130b0
 		>;
 	};
=20
--=20
2.22.0

