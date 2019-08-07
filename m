Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0000DC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C13217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Oh967Ivz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfHGI0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:38 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:35606
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729278AbfHGI0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2QMYgzG9GbmxB3ydRUA2LzF7zFRTmFU9oeVxZR31N0eTHjxUpqCs4micIxc4kcwrAiXFqUXUY/78w2Mp6NX2mvov8r25kKUEE/N2gLxbvb707bMgxLjj4+Q99VduaWiavcoByMu0TcbvXT9O1aSbSIdhBzcYZ11NHrCfVl3coRl8kxnGICq6fzeAqrl9TE91DPRZGVJo65+kdXuxEehtZwTf88EvUFa46fuPdVJJD+uaxTiYnfKYYtd2NI3vmIC9bgJYQqRC8x3vKJtQKdYgK8IVNr9UxSt2Wz9uFwRsBJcgb7CHf0usOZWaWkltcpbAco3WM7x5M1RZGzf+A0dXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkqCRFFN/hlVRrfJN1nrTRZQzsBGHOjky7Z8/27GypY=;
 b=b8Y4LVnKuzyQAr+nF7/h3vF5XSgGbb9I6O2WHL9AAitWpRnAKcb8YKBOD/TBhmpTpJnLbCHVJ5nyvcEeCep1DJB3TBqT7eUulNiOzeLZZSvkkt8TqAid82NAGdCfycyKWyoyWN4jdV0OSg2Wu5RREcAooSc7jkmOqcqrFe8y6tIMhElT5gVBtfqNQlUCaC7pxONkS4Zxs+5EDnhR2L7R/QvAw1zQSpA5Qv00MaEjDKF9iu3cu3/zlHacaBU/0IPoHDcf3aQ7owJMKDtM9HJpghA332oOlOAxZK1l6T2Nmcg7ug8GPVLQhoOn70H57O5lovmKGcwgI2pzAZlDDrI4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkqCRFFN/hlVRrfJN1nrTRZQzsBGHOjky7Z8/27GypY=;
 b=Oh967Ivzb4alIqnW5YP8m1Xjs7k3z9WlRuqg0WvWTZy9/xzxAKRb/VK1LF/0CE4vLnJr7VKx6URY34k/eI3Ee1rLh4EMctk5LKaVkw7iJ+TMfh/vJ/nEbGWyCOCvALgK9Huqv2nByk3dZuYhQjD9dXEA1VQvOhT56FYOIzha2po=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3614.eurprd05.prod.outlook.com (52.134.7.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.16; Wed, 7 Aug 2019 08:26:23 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:23 +0000
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
Subject: [PATCH v3 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Topic: [PATCH v3 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Index: AQHVTPnMzs9IdJAHC02xaJ72tyIhqA==
Date:   Wed, 7 Aug 2019 08:26:23 +0000
Message-ID: <20190807082556.5013-10-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 3b2f7e75-86b0-4c7c-7a40-08d71b10eeb4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3614;
x-ms-traffictypediagnostic: VI1PR0502MB3614:
x-microsoft-antispam-prvs: <VI1PR0502MB3614BFF32615714F14AF88E2F4D40@VI1PR0502MB3614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(199004)(189003)(305945005)(6116002)(26005)(81156014)(76176011)(36756003)(3846002)(6486002)(86362001)(6512007)(478600001)(25786009)(71190400001)(2906002)(7416002)(81166006)(256004)(316002)(71200400001)(2201001)(44832011)(53936002)(7736002)(110136005)(8936002)(54906003)(52116002)(66446008)(64756008)(14454004)(99286004)(476003)(102836004)(8676002)(6436002)(1076003)(66556008)(5660300002)(6506007)(2501003)(4326008)(66946007)(486006)(4744005)(446003)(11346002)(66066001)(68736007)(50226002)(186003)(66476007)(2616005)(386003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3614;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uUzqilWEKricxIhSWa6+hh4zZhg3klxdBxrrlWWynQnnRlhz/VdfBELjJ/1ae58vKPfBE7YLhOOwiTV1055bIljcOJ2WZd0e6LvcTPx6gNlaIb1+MxFwFztDF5F/eqRoSUWT01t8qkETlPvc/Uu7JAajjJBlD87L9VxHtQuLW9YYnC9wg5CabcgJffF06QlxbIkk+yqOhRY3WCh//QtJ/T8+60p9HjiNwaBrN1eUUFcsRdZejaHlF1ajFNL7xIhkIe21TJEkErduZI56VqYBQQ/QZaThYmOTkciK53hr/fRHSgzwWQk/3f23unXVbBs7nhv8eiFtuunfS+hRZSzVGPcs/IkUgGEjKsuHTKLQoafZ0FvD1wldFruSPwdQfmkVsqBrr0/W+9tQlJ53YUIbEU+OWFK6k6VD1PN51THc6sU=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2f7e75-86b0-4c7c-7a40-08d71b10eeb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:23.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1yPT4/INfIEDnadRiNJhhSrbXMRJMYie5dCmrd+4TurN3DnosOHgY1OOqXbm/Ia4d7ar+Cxfxy/46t3NvjO49EPiiFnbcJZo5Pf1C1e1m1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the phy-node and mdio bus to the fec-node, represented as is on
hardware.
This commit includes micrel,led-mode that is set to the default
value, prepared for someone who wants to change this.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx=
6qdl-colibri.dtsi
index 1beac22266ed..019dda6b88ad 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -140,7 +140,18 @@
 	pinctrl-names =3D "default";
 	pinctrl-0 =3D <&pinctrl_enet>;
 	phy-mode =3D "rmii";
+	phy-handle =3D <&ethphy>;
 	status =3D "okay";
+
+	mdio {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		ethphy: ethernet-phy@0 {
+			reg =3D <0>;
+			micrel,led-mode =3D <0>;
+		};
+	};
 };
=20
 &hdmi {
--=20
2.22.0

