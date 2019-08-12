Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4BDC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E0A20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="tFMXt3YC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfHLOV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:56 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726610AbfHLOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTJ5nNSj8q3s/t/duwSHWjOwCoDsn6NhpLNISNu4VJUJzH2ThIpnMmCpQjMqWowryhtn+qGQ2kWCv1gNZgmMYDow4yM4szdOl2PO5/TVi8Nyj2Pv4U7IH8ylV6s9yR5MxTDm27rxM6N8tGiaIDYr2grWNC2AlrwaO9CwJ2bSDlwxsKUYafelWftoytU0tvKJjzUt1teAhV7QyqZDEAGYLXN6WYi48ys7w1YzoCTrjKNFEpar46MGe/NSHSdgGs4fbVutWBEUoXYaK7yDDCmT2/NCsKQ1bdF9ttV1ylo8JiozfM2iszfaZPVcogR3cAgv9lvbi/1+F3hEAsoI5GXFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51LYowuA4gXph0iNaVlmbfhXgs464Roo0xtuFENEwgw=;
 b=OvHifmzr9bNZ+EGh86SwHzdCvzSOe5HIKyCBddjGkj12aV/1HPkMTFaf7aB9f6zMF/Z8JValjPcBxQuXHWJzSDaO7mKDTbo7/ANrCVarsNV837dpzOWyP4a4tKUQy42TPbWcq1CtQ42pJ6Sg7sdQOq2dNP/6nkY6AAxLVpm3mBGcUs/jNHamr0CQ6Z/ixB41BVi0Yetc12yFSHtnwg0nVTKAkti7Kod7P8DfItgKhJTHgJQjvLTpGt5SCxX8WAterBCXIpxKc1xBRG0nPq7ysjnTO0+TxX2hxgrdZ+5cJkFciuA6MyJviUS98Aa6j8JVgG6MIrnVt/Sn6chyRjB4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51LYowuA4gXph0iNaVlmbfhXgs464Roo0xtuFENEwgw=;
 b=tFMXt3YCGRn/f7RsC2nd4NICG4/0x/dHFEP3F4FQvhpqk9NaimnYV6bTuXM6QueTEIYlcFON1zX5IS7yg/sSyo3g+NGBP7bvSSGmcLQhE/YpLdBHeJ4NRvYyuB7UNNNk/klKzgVUe3I17XPM269gh4wF0iiOrScIVPENtKzmP+Y=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:27 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:27 +0000
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
Subject: [PATCH v4 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Topic: [PATCH v4 08/21] ARM: dts: imx7-colibri: Add touch controllers
Thread-Index: AQHVURk6y2j9GnmWB0SSfLkk7hRFMg==
Date:   Mon, 12 Aug 2019 14:21:26 +0000
Message-ID: <20190812142105.1995-9-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 7a7f7d64-c504-4283-6c2d-08d71f305c8e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB294290E3DDED8236CDC3CD58F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:252;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(14444005)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qf2zw6BubyhPU3Iy+Qr0e8ubm6eyZPGeMkNcYFbGfZ40fz4LC50CvwVAi9ubXhDDBWfzNmSW/AJ+beaqQgN+ae1lNVEqXNATARmk9iDOCv7+ebOvli0yO5yhLnkPpHLnGqulla3WEfVtI2gAR+ToL3Eisn1LGxNamWMJJthM99rmLZU50pvNc9erTbi8+1Cc43csTBTPNZ5d6E/L/FeRbJcxc42OxsTzipgBTIdp1+VCNdAfMEtdhH350av5j2x+zm46qwbDKIVxka73i7Bpy8sU6t4QL1ogCh6HlchWr8GjlYq4appvoGRy9326c6i9ood1226AbD8/AtncIb+zjmfX9yer6lgkn9LudovnXAXy8/meU60XQyAxqvGn4yKV3XjCEsLSkyHMOqfXV2zvr5d33PdophZY/DXjfyeNjYg=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7f7d64-c504-4283-6c2d-08d71f305c8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:26.9702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vX9i2fdAqy3iyg2WLENR4YL/Rh9gMkgoIvP4pkeDysirRHJw7EPRHsvOgzRmUXjwzg3/kmTIOHupAjUCQT+8BRRzKcrg19ELidPqL0UBf+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add touch controller that is connected over an I2C bus.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3:
- Fix commit message

Changes in v2:
- Deleted touchrevolution downstream stuff
- Use generic node name
- Better comment

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dt=
s/imx7-colibri-eval-v3.dtsi
index d4dbc4fc1adf..576dec9ff81c 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -145,6 +145,21 @@
 &i2c4 {
 	status =3D "okay";
=20
+	/*
+	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
+	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
+	 */
+	touchscreen@4a {
+		compatible =3D "atmel,maxtouch";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_gpiotouch>;
+		reg =3D <0x4a>;
+		interrupt-parent =3D <&gpio1>;
+		interrupts =3D <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
+		reset-gpios =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;	/* SODIMM 30 */
+		status =3D "disabled";
+	};
+
 	/* M41T0M6 real time clock on carrier board */
 	rtc: m41t0m6@68 {
 		compatible =3D "st,m41t0";
@@ -200,3 +215,12 @@
 	vmmc-supply =3D <&reg_3v3>;
 	status =3D "okay";
 };
+
+&iomuxc {
+	pinctrl_gpiotouch: touchgpios {
+		fsl,pins =3D <
+			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x74
+			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x14
+		>;
+	};
+};
--=20
2.22.0

