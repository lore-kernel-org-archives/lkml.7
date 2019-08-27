Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD1FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C2A22CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="VWf3p82U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbfH0NSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:18:51 -0400
Received: from mail-eopbgr50112.outbound.protection.outlook.com ([40.107.5.112]:14974
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730015AbfH0NSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX3SMWqclsxf00Y2euMF47DG0I3j/c5J6H5SHAUF/ZPBIUy+Z3vYHDGvBe0Vaf3Ng/baVKDgNSkcXdwBSu0eUWwbap+DImcSrClx8DEHP7Dfu8KODeKvsNWk9ibuEwIcM3zMm6IlQjuu0k268TtC4do314qX2yzk8+Wary5XEy5vg5RSGtmawMwUARevEInAAoIUsGL+WUXOxy0OIKDw2F8F5P+9SVOo+IogiKM5RruykGtCF021Nw01UGCGUTU+JhufSKfKRxAEKXu7a5CJe5aXqLEv4a/n48MQq2ladk3nroau2YJYMSaeYpntp1EvNjGj+BunuI1uYpsI0dl9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg+qFwjett/snkiiV898c5SkqczXgVyzPDgEgNPRfrE=;
 b=XivkQqUhCsRhmNJvMjAgbhD0Iyfpo3JXi6oU8nOm2a6KFgymrJk21Fi/3CpSFzY4zyGshbefvQf59zfkPhl28jlFQl/W0JLY9//VHcqfiI902M1L+OqRp0BDYr/WvIKKjzhUP5m11VH7bDxMuWBdh6esrn/64JQF5saDHFQZwMRn9KYmyMby5uz3rGG6tjwADs4PyacNPDFEzeLBJol+ld+JIfRBhDJy1QOprtOvmIEh4rHSBC6qTWXdEJk/DkMOowV/nXgSij0YargcDqNXR4+K/Vo4TwzEZOKJ/kBS83ng+QVM3xy3LXWDSRPze2k/bh8zZ8+d2j1OTZjVt6Y9ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bg+qFwjett/snkiiV898c5SkqczXgVyzPDgEgNPRfrE=;
 b=VWf3p82UppAhVSO8nBNcq2qCuRuxikIFYopc9B8PyzivYMTbbiJCSKVbJbUVFhpMb7LwtOzEMsnoSfrLi5EMY0GWQHSxewpHQpnlyO02eYg1PnALAgQLS9+WPjKvuWAG6VjsBBASNyC91v5HGMxWbmbtYJrPeh4enNVWwI8BU6k=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3872.eurprd05.prod.outlook.com (52.134.5.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:34 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:34 +0000
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
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 09/13] ARM: dts: imx6ull-colibri: reduce v_batt current in
 power off
Thread-Topic: [PATCH v5 09/13] ARM: dts: imx6ull-colibri: reduce v_batt
 current in power off
Thread-Index: AQHVXNntUi9gc5UvokqnPHWDCbjaog==
Date:   Tue, 27 Aug 2019 13:18:34 +0000
Message-ID: <20190827131806.6816-10-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 5de08525-a580-4804-542a-08d72af11049
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3872;
x-ms-traffictypediagnostic: VI1PR0502MB3872:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB387244FDE03CB00ABE9FCE2CF4A00@VI1PR0502MB3872.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(8936002)(66946007)(2906002)(11346002)(5660300002)(50226002)(54906003)(110136005)(316002)(14454004)(1076003)(256004)(64756008)(6506007)(386003)(7736002)(478600001)(36756003)(53936002)(66556008)(6116002)(66066001)(66446008)(3846002)(6436002)(76176011)(476003)(2616005)(446003)(486006)(6512007)(26005)(305945005)(102836004)(6486002)(71200400001)(186003)(8676002)(86362001)(81166006)(4326008)(71190400001)(81156014)(66476007)(25786009)(99286004)(7416002)(52116002)(44832011)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3872;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vj1ui1CBsvP/WPGhuEZSeUsg8ioweqDla38p6uYrHZ4l+rZrypHuIQLJxaO3euVqjuMbPvpOuJKDw4cGf0GZVsVjJTZc0rTIEbEXNRsOrGfL/ZjH00xvf9k7zXpfc7GedU9R5noSVZDLpnOc5FAeoN/4IgE5ixBbX1kX6QxUoQBIhy/9YfuEXx9hnZDmNwhAZ2qBtkZREovzUq8m7GDnBdiW5x7on2rfeylF/Vw25uPqUDKlba289xDX8o2AFW4BboWkZAtnmiW57iHgH7dIhQXnr5mJdS4Md/MKpv/SwEfvc1lE5fhKun4D4vZD/V6m9uayj/h7QijQ0uQf7pxdyOCA16ObmQvK6N+qpKfPKdkNTsseuyAWtk8iFd60QmNaXF4hcrGKbjW487Lj/Y3mJTNWk2aGoajOmyaen8Egj04=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de08525-a580-4804-542a-08d72af11049
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:34.6889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jVem9PlH+z2bL9AQ0QIgJ3xTXUANKhKmivHmz3HRFaCN5APfiDwV094N0oeGa8wT6fLh2cZBz3cvaOc57OEWooLxpBRRcWw+pTILQQdPAHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3872
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
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

Changes in v5:
- Added Olek's Reviewd-by

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
2.23.0

