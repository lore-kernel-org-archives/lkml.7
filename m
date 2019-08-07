Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE233C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C04A229FA
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="jhS7+n42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbfHGI0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:26:50 -0400
Received: from mail-eopbgr00133.outbound.protection.outlook.com ([40.107.0.133]:13121
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387632AbfHGI0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNIlHmsXiakh5o3pG+fUzYoZRB6lIeLg6AqDPQrwaVrD5iKXYweOswfi9nb1IaitbJX96KNbkjDDTUxreRoCRzbTsgDmZ+HG3yIH52Pn/aEWNdwJDVpXKKxzi8snnbr+JqbprWN2CjgnJ8N+38tIgsHDTF1yFcnCDqEUWyum8IJh09X77vqDxVBY9GXE/AKm4jezfth3WW4wiqJbQYuQnUyXj6Vtps2Qt7qDX1xRRf1eQ2MGx01aA/GMxPYhMTuBYgWOVQZkjV9HD1veEaW9nmhp4bbCF84cZO1+g7ePn5MxMLUW2TUwF8FDiB5lUlQS/XGMP4iJakoQ1hnAbpoaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb37TPY43ONmiWA1cnZoreqUjLGoT8tdv5O+I0YIJes=;
 b=eQaotfXYcg41Yh2Xg4YbyAyEyvcr7saprVl8DA/A3gDAzUM++8ehHQXkQv5Yz3TMVx/AI19IdoYR8fVwrcRTp3XeX/BrXBIRvR6KkRB5M0/cnEIDH4uvKllCOxDKXEdLDpWRHkiaGag6WdYrlrnwQGRwGSe+x0b/GhLU9l6QYkf8o/au++UBY5BlPhTJ8iwylpNcMje5rZzgKNejE1BSa9it/aZDrJ7i9Cix0ATuACyblxwLLHPwL+9pgBHKHFjCrFiojzSfE1ddCvWy9sQ2KPUUTghwUBjmBBT3Rzhfwk443WSB9Mk1oL14Mum8KYTmuOA/bxaYgZqc/tEs3BCzzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb37TPY43ONmiWA1cnZoreqUjLGoT8tdv5O+I0YIJes=;
 b=jhS7+n42HTK1sSXK7j5gYOjjrZwSbphxrNC5fO3OWltVRrq0p4YtVYBTvg7aewCOmNlWg+acFELicsOxKwPOJRAR8lKdu8YEM+wcaEJWg3MVsf2b6fwGsQLl0XkYkyJySFEAoovJyAxljuHiOmsdjILuN3tlVgk0k0CenWGZEaQ=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2928.eurprd05.prod.outlook.com (10.175.25.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Wed, 7 Aug 2019 08:26:42 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.015; Wed, 7 Aug 2019
 08:26:42 +0000
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
Subject: [PATCH v3 18/21] ARM: dts: imx6ull-colibri: Add general wakeup key
 used on Colibri
Thread-Topic: [PATCH v3 18/21] ARM: dts: imx6ull-colibri: Add general wakeup
 key used on Colibri
Thread-Index: AQHVTPnXHLWlu04kPkWBd19IVBhRuw==
Date:   Wed, 7 Aug 2019 08:26:42 +0000
Message-ID: <20190807082556.5013-19-philippe.schenker@toradex.com>
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
x-ms-office365-filtering-correlation-id: 267702ad-f333-446c-73e7-08d71b10f9d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2928;
x-ms-traffictypediagnostic: VI1PR0502MB2928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB292848B0702C1CCBB4CA5BC1F4D40@VI1PR0502MB2928.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01221E3973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(396003)(346002)(136003)(376002)(199004)(189003)(64756008)(66556008)(66476007)(66946007)(36756003)(11346002)(476003)(6436002)(76176011)(2906002)(316002)(305945005)(2616005)(66446008)(1076003)(54906003)(110136005)(68736007)(486006)(14454004)(5660300002)(446003)(256004)(4744005)(86362001)(44832011)(50226002)(4326008)(66066001)(53936002)(6486002)(186003)(8676002)(26005)(71200400001)(99286004)(6512007)(2501003)(2201001)(71190400001)(102836004)(386003)(8936002)(6506007)(478600001)(7736002)(7416002)(52116002)(3846002)(81156014)(81166006)(6116002)(25786009)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2928;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0OHxEVqBO4f3T/QJUJAp/uTThlRtyZixrlgRd+HdkS7xJX8JOsvIoIvempQvAmbSl3N6z5fhot9VsB1ssSM8I1U/HwoGc5MqUlQrEbhmTyXD4ZQI2L5jKhm5lx32JEXz5Mcf6V+Hn82RrR3IaDGXwnW7th38P2pmsAgT9db4sFGTZHnYTfpZC/EippMmj4T20E/UKBVsjbRS0qW4uwu/wYGDgDx17igUG4swyzHwfJ4U5RVT+ccd2cqbSBjt3QsfzSn0oeQcIE5o4eUQHb6ES5fpGZHcANH1/m/fYy+oCjAF/YBEcLrhVdVYWfzV84Qk2VeYIYYBbCmzg/vwtAW5lI+hpZdCmeLl2H5Pxb+4AD4DpIV813SttTxhFK6KdPSlfJXtqgfq6dM8IkYpir0Gghzd5HY2j57oruOMUOFXmGA=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267702ad-f333-446c-73e7-08d71b10f9d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2019 08:26:42.3557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6LqHIZEKNlZxvdmEqLRysxd4HDCVAXs2L74DB3444bMPIz3WcFUJ8MbjvgvRw19V5/DThntsXo94DL2LZje1ck/fxx3Zq7cZgiy00YyFeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the possibility to wake the module with an external signal
as defined in the Colibri standard

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtsi b/arch/arm/boot=
/dts/imx6ull-colibri-eval-v3.dtsi
index 3bee37c75aa6..d3c4809f140e 100644
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
2.22.0

