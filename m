Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B87C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C7E32089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="N/+fanxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406138AbfIJGV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:21:26 -0400
Received: from mail-eopbgr50108.outbound.protection.outlook.com ([40.107.5.108]:55813
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfIJGVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceyLj2RS0QMlr0aI7ZM0dBptj2ltM8phmycWQH4fw8o7ADrycQ2HOP3yWkW9T+7MdoWU3HYRzgd8rfmHAXSrr93LqvibSOrcBt0Zd0SbWXmI20YqXEK58Tr0SsprfDApexjpZG/23TjBIOFfuEWYpr+eCt8hyj7yUmnLZ0T6FTgcs8CBoEFSwAaw4DnHAc9mMyInv5AWixHkZKV2mcTTRi6C1zK/SMkr4c/57QlVik9kXJk9WyaF9yuzHBMlkGT3jrlGyzrc4V9x4drrx1LqYQWkiVX7SPxH2Be7Jztk0n/v/CkwsKvGAzaPl12b8lBpoXT0z4Fq6WdsFJxDJoWjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuuAqBC96P1U5OEoXO9c/gozGpkXWCr3gvCIMROLJNE=;
 b=S3xBw/xTdO9mMtD0Qg4JRGSAoHqhueCXdx7dcCJ4mwBzR46pasWT/+ZvlcZnL77yZPt3ALRajOs2ImwS0c2BlfsODHtIfYwnjtQZAF52WpN+WwPygVcO2Q/pTqDY2HazkC2lm1FL1Q/NieX7AKXuUktufCPxyhPEKbHkMiLqmlkGmPVrvqqNfHb1YjpyUjaqCV6l4In/F02kCF4Z6lFrdiZDW9AYrtJn4WEFhlOg8HWFmzZSYiz3DpAITuFDG2GMZ//hgG14gG3ASmwMCkCTkqMUqZQMj9tV91ZeRutakp9jGaSJu3p4p74VqrX20yQoc1Vi0zSzxc0cYKZUXovOxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TuuAqBC96P1U5OEoXO9c/gozGpkXWCr3gvCIMROLJNE=;
 b=N/+fanxWrQR+3OuajH9BVjEwnN+tz4VvPe84/RMNWG2udat5lsyB4sW9wCCA30kGrK009PfXI2X9uVL+S+rSrAwoGTClP6LDj7SkJPJ4dapoaoNeb7d2iJANCIFksprR08Pd3ASbGRatW6jDi0j8L+gAAWRGSAXdKJNFmKCZYrE=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3054.eurprd05.prod.outlook.com (10.175.21.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Tue, 10 Sep 2019 06:21:17 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 06:21:17 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v2 2/3] ARM: dts: imx6ull-colibri: add phy-supply and
 respective regulator
Thread-Topic: [PATCH v2 2/3] ARM: dts: imx6ull-colibri: add phy-supply and
 respective regulator
Thread-Index: AQHVZ5/0DvzwHdzIw0OpocOeSMaWYQ==
Date:   Tue, 10 Sep 2019 06:21:17 +0000
Message-ID: <20190910062103.39641-3-philippe.schenker@toradex.com>
References: <20190910062103.39641-1-philippe.schenker@toradex.com>
In-Reply-To: <20190910062103.39641-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::16) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.23.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73a5e95b-b271-4a7d-36ac-08d735b716b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3054;
x-ms-traffictypediagnostic: VI1PR0502MB3054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB3054E9DB340062402D8522E8F4B60@VI1PR0502MB3054.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39850400004)(366004)(346002)(396003)(376002)(189003)(199004)(316002)(25786009)(14454004)(4326008)(256004)(71200400001)(71190400001)(7736002)(305945005)(53936002)(478600001)(50226002)(36756003)(8936002)(66476007)(66556008)(81156014)(64756008)(81166006)(66446008)(66946007)(486006)(44832011)(110136005)(99286004)(1076003)(6506007)(386003)(11346002)(446003)(8676002)(2616005)(476003)(2501003)(6512007)(26005)(54906003)(5660300002)(7416002)(86362001)(6116002)(3846002)(102836004)(186003)(2906002)(52116002)(76176011)(6486002)(6436002)(66066001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3054;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JziIRkZhh1z3i7nkMUM0w9hTGJgQ00jZw2twDSk52M4umouUesadDQv2Qok1+22fJuZkQ9GVUvLCtoaC9avNDmSCeKibVokM5cMLcBJ6R1az4bIKRPzHaaBQLGg0pSjBkSLcRSMhLF2d2AuZY/7GU6OWvW3Qnu4/QIs8O8V3Cni2B9NKRsabBI/KzRnc7qcd3EhDm83cfIEiXDRe19f1M2smJaQHi+FmR7vH9ZNsqBuO/hI8sLRBGSWpjgI2cPtN37Ut91Q5aEPcH/s5628mPB0k2sXdAuh0RpVtwUbrZg0xa1tDZfjgjZZ+rUi1UHBI97zjCvBjRe2OXfWxfUJT6b6NT7chqO9iIdh+/h2cIs1ro2Ra4g2TgtxUMjpCugDVf4B8DbA3tlHIL3aeGcAgmfLBQ8HgBtTuxFj3405254s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a5e95b-b271-4a7d-36ac-08d735b716b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 06:21:17.5437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6GHjr2rYYo/Vr5I2V8dsw0JcOlKS7USiCQFvycUO01TU8CWjwQw5tzd2Bb6BgIPaELafA9mpGCvzPENk9VwrcXxE/EZstdZXFU2wkz103xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds regulator-fixed-clock, a fixed-regulator that turns on and
off with a clock and add it to the phy.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri.dtsi b/arch/arm/boot/dts/imx=
6ull-colibri.dtsi
index d56728f03c35..76021b842a97 100644
--- a/arch/arm/boot/dts/imx6ull-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri.dtsi
@@ -47,6 +47,17 @@
 		states =3D <1800000 0x1 3300000 0x0>;
 		vin-supply =3D <&reg_module_3v3>;
 	};
+
+	reg_eth_phy: regulator-eth-phy {
+		compatible =3D "regulator-fixed-clock";
+		regulator-boot-on;
+		regulator-name =3D "eth_phy";
+		regulator-min-microvolt =3D <3300000>;
+		regulator-max-microvolt =3D <3300000>;
+		clocks =3D <&clks IMX6UL_CLK_ENET2_REF_125M>;
+		startup-delay-us =3D <150000>;
+		vin-supply =3D <&reg_module_3v3>;
+	};
 };
=20
 &adc1 {
@@ -66,6 +77,7 @@
 	pinctrl-0 =3D <&pinctrl_enet2>;
 	phy-mode =3D "rmii";
 	phy-handle =3D <&ethphy1>;
+	phy-supply =3D <&reg_eth_phy>;
 	status =3D "okay";
=20
 	mdio {
--=20
2.23.0

