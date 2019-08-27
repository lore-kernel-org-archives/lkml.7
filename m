Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2923C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F1C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="U2LKODTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfH0NSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:18:49 -0400
Received: from mail-eopbgr60138.outbound.protection.outlook.com ([40.107.6.138]:29946
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730123AbfH0NSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:18:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuBESknWd5yf9qB+KYQ4NXiT5k3vQhm5o4+4OfRMDeGuLR7WY68g4xqYAjvSd0ep3mkqJyt5X+EnaDFsbWAnJZ/vbZrNxaEu8z/BaGPS6Fus6mUVxY4RXjErPiVtXmjdjC0chv5fgZCxH5aES74dkzw3pDlzN5XOMZYGbT1xZioJxM8b5sSzyhq1akwmui9ORP4j6Jc4ldCnt1z1FXrNkgUnlGL4AxPToctW/aoFWL23dgJXeM/jmrgf60zbDJxOV3TMyr+/lyDJqZZ5t5oSMFfVk/tWeLsUr4Q23NtJf71SiNNbmpmTojVsUSjpvPY3j5slKfjhzlkAL3eTi247cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAJuL5aTe4u1XWf1r0IY+TrTVa8XUAkbW1V4st3P5W8=;
 b=Jrmq7ruIaBZyFxvnoZjESvdjzCK6AgJxK6XaWJg2Bqf0O+tm+7pYB5doW0rE7XBJcT/fYmVgEwZbtmjcTkwzAvzUWXI96u1t4p7vK0YU0JaZ8bNc57VTZBsVbxSNUec4fejkoPVvVFflnxGuHpkgoCbw6BMQJFa/yuXEdQ5oS+GU5CkryCgvFpT/kR4z3u734zGco9hLTENI9NVzyTsFNDiVEjiN7UbQBBYvmDgZa1Ib5ujddKQqkzzyJEA7Gzg0LyePqK+blHn41+NPwLVsa9QbXoleHmlQxYfi37hK3khhTt7XAglgQAZWY9uDgXLZVrgKUYIxb3VC9UELzxt5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAJuL5aTe4u1XWf1r0IY+TrTVa8XUAkbW1V4st3P5W8=;
 b=U2LKODTUHJuFV9LNh89wJ65ME0KCyp3ypKQE4K3RbFYTW05zhFIgfMiWrtfLZKUhWSHRQBiPKX+2w2H4cIRJUMLiS5DzLWaCmMfKv2gUmpN6GkZHA2f8aPS2mzFuAj0OlkFjxmvWUnxw5QuBTobNnnhK7pjTvZaPHvwIuhPA+yU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3008.eurprd05.prod.outlook.com (10.172.255.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Tue, 27 Aug 2019 13:18:40 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 13:18:40 +0000
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
Subject: [PATCH v5 12/13] ARM: dts: imx6ull-colibri: Add general wakeup key
 used on Colibri
Thread-Topic: [PATCH v5 12/13] ARM: dts: imx6ull-colibri: Add general wakeup
 key used on Colibri
Thread-Index: AQHVXNnx1F1NxUdM6Ua8QNTzvlmBow==
Date:   Tue, 27 Aug 2019 13:18:40 +0000
Message-ID: <20190827131806.6816-13-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: bc69689e-d4d9-40ed-0c02-08d72af1139d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3008;
x-ms-traffictypediagnostic: VI1PR0502MB3008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB300845B7EDCCE6CC4AE4FA9AF4A00@VI1PR0502MB3008.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(199004)(189003)(4326008)(256004)(36756003)(6512007)(86362001)(5660300002)(25786009)(66446008)(64756008)(66476007)(66556008)(1076003)(478600001)(66066001)(316002)(110136005)(53936002)(71200400001)(54906003)(71190400001)(7416002)(8936002)(8676002)(52116002)(76176011)(6116002)(6486002)(50226002)(3846002)(2906002)(66946007)(99286004)(486006)(44832011)(2616005)(14454004)(305945005)(6506007)(386003)(186003)(7736002)(26005)(81156014)(81166006)(6436002)(476003)(11346002)(446003)(102836004)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3008;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 22/fNY6k7A1eprDTB7H4kiX5xIIPrPUNepvfxXKVB5DQNAAute5hNYjtmRRpGyJEHQjfCp9Oj8XarJwINwiTYRc8JzGPs2qsAV6A3wcHJs5tU+NR9TU+vxyLXsh8SA6FhkQiGKDINfrzmFYaSllTK+7lV0FIgnykPya3sPXERooPkGJCcqnYUK5eHo3fU07TTH3gZ1kSbFAUl5eS7j7ILflKvzglvW9Y9CPgD5/2J0WIl6+qj3KDQPniJqZEiG7yRfKKeEXLpc1bp345tM5PLJtYhYvtyKLjX/yPq7VmNe4W5IcfS2NabMCtGEDWLhLFXGC+Y8jITurMclIo+COp1d23xSUCONIdxgWJk2ff2MAHsdr51tUa/IjlzERIfFe48kECTHI8TGGPpFiCW1iVAHiaOD98+nokyYF3r49cdEI=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc69689e-d4d9-40ed-0c02-08d72af1139d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 13:18:40.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DxJaw3vjBQ9QGXWtJi9BD8eMGW2PXGHWb0CZXWG0WfhUDef3ZSBIAwCrkt1928A/XLNJj/N2rtWCYxwTY8ZuwoS08+ZM0UEniFTMFUm7pSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the possibility to wake the module with an external signal
as defined in the Colibri standard

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

Changes in v5:
- Add Olek's Reviewed-by

Changes in v4:
- Add Marcel Ziswiler's Ack

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot=
/dts/imx6ull-colibri-eval-v3.dtsi
index b6147c76d159..a78849fd2afa 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi
@@ -8,6 +8,20 @@
 		stdout-path =3D "serial0:115200n8";
 	};
=20
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_snvs_gpiokeys>;
+
+		power {
+			label =3D "Wake-Up";
+			gpios =3D <&gpio5 1 GPIO_ACTIVE_HIGH>;
+			linux,code =3D <KEY_WAKEUP>;
+			debounce-interval =3D <10>;
+			wakeup-source;
+		};
+	};
+
 	/* fixed crystal dedicated to mcp2515 */
 	clk16m: clk16m {
 		compatible =3D "fixed-clock";
--=20
2.23.0

