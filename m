Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76218C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8B320679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="gMKwg6Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfHLOV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:21:58 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:51614
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728463AbfHLOVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:21:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIRZ2hI2D9fjSIRYuPKu25lOwMgCxBfLLCuY1SxQ4iFSbmkWiz80KN3abpJ+R65jXQBakt1Ws3lD7Yxtja+TCNvhxvkitrbPIShQBYIFck/60SkRRyrXVPohmqdpVleZyuukYdaaxZPF7xB6c77UwjHQ0QHPVSHi0/RAwzHsR0xhnpSfycC/aMPjCkyTZgRjRyFzz8PeCpFWUt5jestiR5qmeV5a+rTyt+LbKx42CVpIppZfMXrvCVNSpPXQVVYEIBoQLjzaYUSg+I2DgJZ3/0tj7E075znbmOtM7KLbj6DA/8uC50PkKJA4bzpdAgKt/4BHIwf6FpZfE7xVHM817Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDy1L5U6xp0iacLO8nad/HCH5CUuB3U5SC2dF2Z3Xpk=;
 b=f2QkTDNqTD2sbvkM60ViqiIq182YHE2voJt7BjBgxe+VFUJSGk2sCBVCbUHPZgb1zcOCHdPK1v0k8V49lYMKWoQ7mlZ4USIVgFidRmJPizKRWi8I1TqtAaMP5TuvZyqdISSjdFjnb+rwq27r2MGS4x6foV5kh4IZwQXmTtNNHZ6Na8ubA7P1wX3AFkcJ/VuK7w03oiPqjirW//j+v+ahVFMhw9IzMgJepqigrqwRabS0tU8MU3DWxeT27bKkVNEZ7RoioJp0hoG1qr8jY49ebyne/IVeIdpCLnDkoyl1973Pve9+5WKqQDElfxg3c8S9fQvH9kF5hyV+1jzFvKmvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDy1L5U6xp0iacLO8nad/HCH5CUuB3U5SC2dF2Z3Xpk=;
 b=gMKwg6FdM9zR5XVbGAEh3UZ4qmAvQep5UsMglZFBoYJULyvfIGTxr2H+fDZBmiutcp/cEVU1Uarsm26EDq5x9x9S0oX+Rf0c/MiNIJeoGP2pYeLGw7BXQdl8JZoRufgRA4gw8AQnkDleCq/+iKPsitDEP4Wl/666PCSVU8CJDL4=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2942.eurprd05.prod.outlook.com (10.175.26.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Mon, 12 Aug 2019 14:21:28 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 14:21:28 +0000
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
Subject: [PATCH v4 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Topic: [PATCH v4 09/21] ARM: dts: imx6qdl-colibri: add phy to fec
Thread-Index: AQHVURk7/55ROUuEwESnbBW0XYyw6Q==
Date:   Mon, 12 Aug 2019 14:21:28 +0000
Message-ID: <20190812142105.1995-10-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 25b1b4bc-2a23-445c-ab34-08d71f305d66
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2942;
x-ms-traffictypediagnostic: VI1PR0502MB2942:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB294247A702AF14FD2E8B7443F4D30@VI1PR0502MB2942.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39850400004)(346002)(366004)(396003)(199004)(189003)(5660300002)(54906003)(110136005)(316002)(478600001)(6486002)(86362001)(2201001)(66066001)(53936002)(6116002)(1076003)(3846002)(2906002)(4326008)(25786009)(66446008)(64756008)(66556008)(66946007)(66476007)(4744005)(6436002)(8676002)(11346002)(476003)(2616005)(446003)(256004)(81166006)(81156014)(2501003)(44832011)(6512007)(486006)(50226002)(71200400001)(71190400001)(7416002)(8936002)(36756003)(52116002)(7736002)(305945005)(99286004)(102836004)(386003)(14454004)(76176011)(186003)(6506007)(26005)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2942;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M127OYan1f5pX4TD+C7ZN9ngrvUJxU2vhsBiTfyoOqB2Nrq6bBUxhhX3qcOfe/mNzg+a00EYyD1aAvhHAfFJrfAHdbgQOy6KoQFhsJLGVpiZqMvB5qo6Jn4au9YhFPHxgzNX9PI+GmBZcJDN+eWMByiaY2/riJca6iREFXARloUTlgDbeSwxgjoyAPqXTHmWN5fce6VXAat3ZTFLfKcPcjaMIAexhhMUQ1OJUmF2hadTAjViFiyLLPtIvVPnz/ALPeZCYz71ozq9ZXaUJfpLeM5eyp6CtQKYz8JYM9IxExLgat+TCaEYh8EFHAS6EUKWKgdfLkLPry/VaqMsWo6Xj3Ub4P8/W+C+wtIGyFU/V1n1hRmKcke34OsKup2ihMFTT8DtQwG0Aj8pka+jrUlF9Wf2riFNnPGZHDR0OHaU3fY=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b1b4bc-2a23-445c-ab34-08d71f305d66
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 14:21:28.5863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eUOvZDl0wv+Lob/rLMUdrJpyzO9aORm78HpyynG5fOTYdDq+w/adnJR8iFZtV3NnwrsyBoMyObu2z/qmRmvyeJzjaUkguEp2JA+cjvQyIQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2942
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the phy-node and mdio bus to the fec-node, represented as is on
hardware.
This commit includes micrel,led-mode that is set to the default
value, prepared for someone who wants to change this.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- Add Marcel Ziswiler's Ack

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

