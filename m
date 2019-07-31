Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89241206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="IoyDJh6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbfGaMjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:39:43 -0400
Received: from mail-eopbgr00121.outbound.protection.outlook.com ([40.107.0.121]:56484
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387663AbfGaMiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:38:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmsgyayGIKutLZZOTdBeGaBixzL6YTI7rMowgzbyQ+5QeK/yEDPGqvI1ZYaTLxefAyp6YjwABrQ3FLBKsnKQ9kQ00CCCVLjdXGpgJo/hX102t1q3MPIk+7B35t8/M421y3wcaZ9amdZKHK/72IvbAss7k5Sslopx/EYIqqwaW61i3HwyfTGHSK38nOQN3yw1qQbzxBQxtKjhZL0HPN6+vgyp0NOku3TTfVGNf99VmgHPsdT0uBdCCqb0dm8DRzm6sdCBbUnuRPt1yC+SdpNkvhsiB0gJdlKoiP2+Ye3aQMjnBg/dhgwRM1XeYP1w5u3KGTKS40Qi+cjE/O3flD4hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB0vKYFbbdUeb19EeNeDiYIfwhKA7fkP3O+tYQyTnlU=;
 b=OMxhSAG2tBndNN7S6pOzVqnDEOiBvo5mHEvWvG2a11pyI295ExU7MWGhkexw+9XxJYWKsf1UHTLNYeTqX2QvyE+0KfbEuGs7HMFMEs7QpjlucU3k5zLqmFq8uzh9uH+iWUydxCjb3kSDW0yyaMyxhNU3PCOuf99MGgNKXKzDNFNw2t8LdD2Hna7Zhp1IZntuz5Fy1denVPSHm7R+U4wLJLr5ouKycpXtiz1x5JBXURhBq67J4/Cs2pGnWgipGHoA1GH0c3VZcIpaP5NkvBJ+XWR3XaA/yuzKN/tDEufJ1tg7mKBvQIgOLSJ0bg8hdWiSBEh11atF4O0/9AnehO53Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=toradex.com;dmarc=pass action=none
 header.from=toradex.com;dkim=pass header.d=toradex.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PB0vKYFbbdUeb19EeNeDiYIfwhKA7fkP3O+tYQyTnlU=;
 b=IoyDJh6CB5ZGegdnbNxRXjHuCbxQg8RtxwnmXLHFGgVBYiMDtSkL635Lv1Yq76+XbPgWZwb6baZgOUx+pc95MQ7Sv73c6CtO2fP0P+wHh6IeraWuiLgH8UI0JAfeQ9qHe/eteTehAtH6v9mqSj4hnEcyd14rwK4dhxx2HaGEIeY=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3615.eurprd05.prod.outlook.com (52.134.7.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 12:38:01 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 12:38:01 +0000
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
Subject: [PATCH v2 01/20] ARM: dts: imx7-colibri: make sure module supplies
 are always on
Thread-Topic: [PATCH v2 01/20] ARM: dts: imx7-colibri: make sure module
 supplies are always on
Thread-Index: AQHVR5zKtbFqHRg9tECU9zfITiqrSw==
Date:   Wed, 31 Jul 2019 12:38:01 +0000
Message-ID: <20190731123750.25670-2-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 0ade3b61-8280-4817-1531-08d715b3ecde
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3615;
x-ms-traffictypediagnostic: VI1PR0502MB3615:
x-microsoft-antispam-prvs: <VI1PR0502MB361586B912B38A5F875AD83CF4DF0@VI1PR0502MB3615.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(4636009)(39850400004)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(66946007)(52116002)(66446008)(64756008)(66556008)(66476007)(76176011)(4744005)(99286004)(53936002)(6512007)(6436002)(5660300002)(4326008)(7416002)(66066001)(6486002)(25786009)(478600001)(14454004)(7736002)(305945005)(71190400001)(71200400001)(3846002)(6116002)(36756003)(2501003)(68736007)(2906002)(2201001)(44832011)(486006)(476003)(86362001)(446003)(2616005)(11346002)(256004)(186003)(81166006)(81156014)(26005)(102836004)(50226002)(8936002)(8676002)(6506007)(386003)(316002)(54906003)(110136005)(1076003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3615;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GW5L58SC0Pk+UEbS/G14HjKLB2T1hfYgO3jVmz89Si7x5Qo2c3TmiHbkcSJybnpTchlGbi0LKSMqIlmPa5eGuxEtAVCfMCmJaTfPGoCRLZk6hHE1O0PtV9dewDWMfCrMD4AZyT2PPETBFlnKw1JIlj+KranOftAkifASU0nM2VY+nVPUrv8VJpNgua4o9sZ0He5895+NVLjCuvarGoFvuVaCCaf9lwIISrhAuVrl/k7dAGWuNcg3C4bbSGVVzU50Hho721LNMtKsopoYaUb0I2Iutbv1qpX/opBx2H8qm3YrZfGRzMPOy9mf596z1np5TYCmzBkD2J/FPdzsvydFhRlewsL3BoKTNXxy2Rfm37DZVoATdKgNsQE0AT8fVngq0C102GG9MWxP6qxo/Mdj2Ye2vp1Tu1Arwo7ZK97iqsc=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ade3b61-8280-4817-1531-08d715b3ecde
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 12:38:01.5480
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

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Prevent regulators from being switched off.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

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

