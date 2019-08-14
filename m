Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F9C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B717B206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 10:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="oJ4tUi89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfHNKxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 06:53:44 -0400
Received: from mail-eopbgr150112.outbound.protection.outlook.com ([40.107.15.112]:7969
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfHNKxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 06:53:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iItQmnBcLLXrlfcTcrzZxuc1blJq/95490Qtie1I+MzH5dJ5To2wuJUSYO4P05C55SIRCJVrbB6hgDSu73+GPi9g6q2O99iWa0ydC2uVPGlc7KvyR4m+YqG3ZPA3KuxifTtc1skyeeDWTFWlIyaNmGocOxHqN00rs05z3xHXGPxydZOG4G6xkBGdI7An1lwlXpJOb1yXhui+vs2J5nTSQPbUJoFVTXWUpqCxv79LwG/2cAb5PWupHDMXKUlHuV7KRwf3wXDM3LogFUOiBoB4olV+RgX27qsqJwdpE9+kaYz8U4enwpOXe7vOx62wtbE0+bLLN+S4oVizHus0uLuyzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2TQDTAP/UNdzdZ/ZHInZ/qgPmHGu8WGwpWv/YEe7jw=;
 b=RfSy0NHRBZV/+4BpBS2S4NWe+2I7bPEG+vxcoReyMXsrPZEeH6Un7ml7/2LcyPhvrD8JOaH9fF/ZxiEQ4eLtyvOwClEwiwTgdPKUltEcHUJTM1NspEnQ74FA7W8FPj/w+etm5tq++k9WiSx/kSgzBbmGVyzZLZEXqyP+1zp/aDYdwxbDDslzQSy5+JPxskUXrvymK8D4VnyvHb+X5mR3h4O27H/Btwd0N3bSO/Xo76TaEhvdkW0N/s17wFq2mOt65peix8e3nfxoNC4HjiDvRDfCCGkRYgOkoAb0twKmuVrfGDQW926RVI8q0X9OTnvYUXHplcvuVS1ZLO6a9W/4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2TQDTAP/UNdzdZ/ZHInZ/qgPmHGu8WGwpWv/YEe7jw=;
 b=oJ4tUi89zZZBq82xYyBe0WgcvWreHsD3DNEdOZi03DvqlSQCdRWHS9M5JVBm9GYknu/b+GY+3OSxgagIMH5gfjvOTUaX0wEleB+aRUk+/K6zDLuTbwH32uslcmCG1YhJb+46xajnZiwfv9hYUXkg3+u8d3O07nrCqhRe6d6WKCU=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2974.eurprd05.prod.outlook.com (10.175.20.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.14; Wed, 14 Aug 2019 10:53:38 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Wed, 14 Aug 2019
 10:53:38 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30 modules
Thread-Topic: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Thread-Index: AQHVUo6HlKoSMlWVHkKJ8B1IIQyZPQ==
Date:   Wed, 14 Aug 2019 10:53:38 +0000
Message-ID: <20190814105318.21902-1-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0051.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::28) To VI1PR0502MB3965.eurprd05.prod.outlook.com
 (2603:10a6:803:23::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.22.0
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 267bb34c-e691-4c60-17f7-08d720a5a97f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB2974;
x-ms-traffictypediagnostic: VI1PR0502MB2974:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2974F80128F71DFC499C5954F4AD0@VI1PR0502MB2974.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 01294F875B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(199004)(189003)(110136005)(5660300002)(2501003)(81156014)(81166006)(2616005)(8676002)(478600001)(66066001)(4326008)(316002)(2906002)(54906003)(14454004)(66476007)(6486002)(66556008)(8936002)(486006)(6436002)(44832011)(64756008)(1076003)(66946007)(66446008)(476003)(86362001)(36756003)(386003)(52116002)(3846002)(102836004)(186003)(50226002)(99286004)(6506007)(25786009)(256004)(6512007)(53936002)(14444005)(71200400001)(7736002)(26005)(71190400001)(305945005)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2974;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FWW13/uCEMK1ypEeSOft5ysvQshLXmRTdUpvdjvypOpFSis9M9wJbonPbLiDi57R5/ouroO8SjYc2EW37Dd6IxNJeeMQaui+cuQn1Jq+aRcJc3x25QCoEraauLdStAZpKnTg2gKruWj8ZBurhvQhjCIT6eoj+mjTmITPeAg3P2YNYDDg9ol6fk1D6snI6ELqmeetrwVEDjeB1rMDF5vkzlN327fQuFHPYhg+VTNCYZ/pFQzPpTmq90lybhX2BHwVeEO5CPvl+SqCDlp+1EGHiSuy8jlEhci0CFk0OA7hlSvj4dzgBEUQazHt2zPc+GIF9MC+jN6pWuG9XdJomg6nUmVUA8LbcXekCP/bmIreRrVGKrcGViNI/ttmBnMgvJikicKkUhtYDP6M/UZmjWHvxjUGhCvJmj3U9LNVUecShA0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 267bb34c-e691-4c60-17f7-08d720a5a97f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2019 10:53:38.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/0PRtwww7xww74ZRfE1diqBd+xA5Xm9HFVWbUFV/Zbm208oVOKwBlOY6vci7DEqoFZb2n89tGetCL02+59a3oV4QkE0Qq/pLaQQFii7G50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2974
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the stmpe-adc DT node as found on Toradex T30 modules

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-apalis.dtsi      | 22 ++++++++++++++--------
 arch/arm/boot/dts/tegra30-colibri.dtsi     | 22 ++++++++++++++--------
 3 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi b/arch/arm/boot/dts=
/tegra30-apalis-v1.1.dtsi
index 02f8126481a2..8b7a827d604d 100644
--- a/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
@@ -994,11 +994,17 @@
 			id =3D <0>;
 			blocks =3D <0x5>;
 			irq-trigger =3D <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq =3D <1>;
+			/* 12-bit ADC */
+			st,mod-12b =3D <1>;
+			/* internal ADC reference */
+			st,ref-sel =3D <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time =3D <4>;
=20
 			stmpe_touchscreen {
 				compatible =3D "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq =3D <1>;
 				/* 8 sample average control */
 				st,ave-ctrl =3D <3>;
 				/* 7 length fractional part in z */
@@ -1008,17 +1014,17 @@
 				 * current limit value
 				 */
 				st,i-drive =3D <1>;
-				/* 12-bit ADC */
-				st,mod-12b =3D <1>;
-				/* internal ADC reference */
-				st,ref-sel =3D <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time =3D <4>;
 				/* 1 ms panel driver settling time */
 				st,settling =3D <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay =3D <5>;
 			};
+
+			stmpe_adc {
+				compatible =3D "st,stmpe-adc";
+				/* forbid to use ADC channels 3-0 (touch) */
+				st,norequest-mask =3D <0x0F>;
+			};
 		};
=20
 		/*
diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegr=
a30-apalis.dtsi
index 7f112f192fe9..c18f6f61d764 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -976,11 +976,17 @@
 			id =3D <0>;
 			blocks =3D <0x5>;
 			irq-trigger =3D <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq =3D <1>;
+			/* 12-bit ADC */
+			st,mod-12b =3D <1>;
+			/* internal ADC reference */
+			st,ref-sel =3D <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time =3D <4>;
=20
 			stmpe_touchscreen {
 				compatible =3D "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq =3D <1>;
 				/* 8 sample average control */
 				st,ave-ctrl =3D <3>;
 				/* 7 length fractional part in z */
@@ -990,17 +996,17 @@
 				 * current limit value
 				 */
 				st,i-drive =3D <1>;
-				/* 12-bit ADC */
-				st,mod-12b =3D <1>;
-				/* internal ADC reference */
-				st,ref-sel =3D <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time =3D <4>;
 				/* 1 ms panel driver settling time */
 				st,settling =3D <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay =3D <5>;
 			};
+
+			stmpe_adc {
+				compatible =3D "st,stmpe-adc";
+				/* forbid to use ADC channels 3-0 (touch) */
+				st,norequest-mask =3D <0x0F>;
+			};
 		};
=20
 		/*
diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/teg=
ra30-colibri.dtsi
index 35af03ca9e90..1f9198bb24ff 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -845,11 +845,18 @@
 			id =3D <0>;
 			blocks =3D <0x5>;
 			irq-trigger =3D <0x1>;
+			/* 3.25 MHz ADC clock speed */
+			st,adc-freq =3D <1>;
+			/* 12-bit ADC */
+			st,mod-12b =3D <1>;
+			/* internal ADC reference */
+			st,ref-sel =3D <0>;
+			/* ADC converstion time: 80 clocks */
+			st,sample-time =3D <4>;
+			/* forbid to use ADC channels 3-0 (touch) */
=20
 			stmpe_touchscreen {
 				compatible =3D "st,stmpe-ts";
-				/* 3.25 MHz ADC clock speed */
-				st,adc-freq =3D <1>;
 				/* 8 sample average control */
 				st,ave-ctrl =3D <3>;
 				/* 7 length fractional part in z */
@@ -859,17 +866,16 @@
 				 * current limit value
 				 */
 				st,i-drive =3D <1>;
-				/* 12-bit ADC */
-				st,mod-12b =3D <1>;
-				/* internal ADC reference */
-				st,ref-sel =3D <0>;
-				/* ADC converstion time: 80 clocks */
-				st,sample-time =3D <4>;
 				/* 1 ms panel driver settling time */
 				st,settling =3D <3>;
 				/* 5 ms touch detect interrupt delay */
 				st,touch-det-delay =3D <5>;
 			};
+
+			stmpe_adc {
+				compatible =3D "st,stmpe-adc";
+				st,norequest-mask =3D <0x0F>;
+			};
 		};
=20
 		/*
--=20
2.22.0

