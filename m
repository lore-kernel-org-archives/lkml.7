Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB4206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="BQcpIQye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfH0IpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:45:03 -0400
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:23680
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbfH0IpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:45:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iekqz/DKMNCsjM0zKyAQX0nYt12UghpMjVTxPZFl5+4Xgg7DYzu9EqHupmS0E63dY1QR2NRNfTSNJuQ3st2nLt4qwEJh46uwe42D1lLSUb1YYx96PpR+g1JvTcE9p1gDll3Ionx92ux0jen2EnpgYhNhLU/44ZasyTynbhWMKDbGGHwOHAd1y1l4MXkykPsnsZHgbtIUZqPfysKlIw8IrEGWiTRR6f42252Fkh5bMSyUGfesnv5jt3HkAhKviD26Ug4Sw//MZeqqgidfVbrYDaUhYs6nw6R4PsfAO7Su4qQ89mgQdzjctMfo105Y6n2NIq44sg8O/C7Gay5DXMY0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RERL0TOi6wCwMg1U6k8F+/1A4BHrHMxNgHnSYhQVX1w=;
 b=m0mtg9lBaN5zCYkaHqf6k2qHOwlCauhKZBljY0Lq8Jjcp79GXe9MHdk249+jcxPQgXUJ4zsTOKghLc0oZo8OtheyIguK8UoHNm3kddwZcSa2PXPetkamleVlqeBszM5AXftb49pGnoR1HT/XIAMSUtnj1Ssq2jxG0esp1izACyB3IYguqY+2aaipZHJ8W3GrFUg3/xuNGVAHB9GDYd7AEbmrjo65253ET07TMIrp4DM9IbLwMdEkSBLh6r8RUnNd/7RP2fdYIrgSvbp6T/UkDvcFHDB0Xn9qLTEbW1kF36YmOQLLvkOyWRDRSqU5T7LDlgV/ljeIT9iWpyAbfVcTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RERL0TOi6wCwMg1U6k8F+/1A4BHrHMxNgHnSYhQVX1w=;
 b=BQcpIQye05Zig0yNVAe1YC5zECq56xdFK/LXHSNHCBxYeJUQ6FooHtt9zjh19koo8e6YSnEd6ISDD8rkUrbFdMbc/tgJqeRl7JlYqCHQRXlW/hfMaMkr+uzOhSg3RTLwFbxHjwcWopclLHEMu9vXzkHW/E/9uOa7SYOcUdMoorA=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.92.152) by
 BYAPR03MB4263.namprd03.prod.outlook.com (20.177.185.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 08:45:00 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::b050:60f8:d275:e9f4%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 08:45:00 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH 1/8] regulator: add binding for the SY8824C voltage regulator
Thread-Topic: [PATCH 1/8] regulator: add binding for the SY8824C voltage
 regulator
Thread-Index: AQHVXLO2VDBQrBcjWE+hqujIXiXjBA==
Date:   Tue, 27 Aug 2019 08:45:00 +0000
Message-ID: <20190827163341.61df63a7@xhacker.debian>
References: <20190827163252.4982af95@xhacker.debian>
In-Reply-To: <20190827163252.4982af95@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR01CA0160.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::28) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:134::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9e40bd1-6c89-4298-5dfc-08d72acad8b4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR03MB4263;
x-ms-traffictypediagnostic: BYAPR03MB4263:
x-microsoft-antispam-prvs: <BYAPR03MB42639CA87DF380CBEE010609EDA00@BYAPR03MB4263.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(486006)(25786009)(66946007)(11346002)(446003)(66066001)(71190400001)(186003)(110136005)(53936002)(386003)(6506007)(7736002)(305945005)(54906003)(1076003)(6116002)(3846002)(256004)(86362001)(2906002)(8936002)(14454004)(81156014)(81166006)(8676002)(71200400001)(50226002)(99286004)(4326008)(476003)(6436002)(26005)(6512007)(5660300002)(316002)(52116002)(76176011)(478600001)(66556008)(64756008)(66446008)(102836004)(9686003)(66476007)(6486002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4263;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rdbpzWT+6LVSzNLKP+c8ex7XjK+CCIljJ3LLUWBfJ4IPegBVqr+RRmuR5L+82Xs6UExiSiDSQHLiHXNOn9YTwlbXYDSbWZEtxppiKcomQIKsoQzPT1Exd8S+KSswlAKK2knIWnHyeFATDLRI7/efoKGSmTS5apP3mH0C5WfKG5hoxLuYpEErcx20HjeVCLvMB3vKzAHlCmBahPCyG8q5biPe9R7BoHblBjelior1OaDpXFnZIGLaFKbDIqorZTPMqbIjB+DGR/nMyHbjCUXdCQ+0nZuUdBsDRzb0uwPo7iM74qSK4DKyEJD/BRKQExbbnwOdJj+6cBnOZjZMjO7oUmy8wbTnMQJT3vtgU6Cpq9C01szE3hmBPjH0QKSfaPIUqaf66NnQV3bAfeLsiZNoX03Yr63SHRY1ttH9HsHMGY8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E6175D44DB608748A81936955122836D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e40bd1-6c89-4298-5dfc-08d72acad8b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 08:45:00.5433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A3W4FeQ8pixlGg8opx2jacxl4CrHLVU6l3HmRqRZTUtBMViejr3gaGEYLfua6ehkaZh7wIgaWwrSxEPbVIMVeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SY8824C is an I2C-controlled adjustable voltage regulator made by
Silergy Corp.

Add its device tree binding.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../devicetree/bindings/regulator/sy8824x.txt | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt

diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Docu=
mentation/devicetree/bindings/regulator/sy8824x.txt
new file mode 100644
index 000000000000..ff8d1af04f7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/sy8824x.txt
@@ -0,0 +1,20 @@
+SY8824C Voltage regulator
+
+Required properties:
+- compatible: Must be "silergy,sy8824c"
+- reg: I2C slave address
+
+Any property defined as part of the core regulator binding, defined in
+./regulator.txt, can also be used.
+
+Example:
+
+	vcore: regulator@00 {
+		compatible =3D "silergy,sy8824c";
+		reg =3D <0x66>;
+		regulator-name =3D "vcore";
+		regulator-min-microvolt =3D <800000>;
+		regulator-max-microvolt =3D <1150000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
--=20
2.23.0.rc1

