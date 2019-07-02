Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA3CC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28552146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rjM7Jsv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGBHvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:51:05 -0400
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:51522
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfGBHvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYlmHxUy/fHLGSiFQ+YJWdEtdH9/VGB1oYYg2CsLb9k=;
 b=rjM7Jsv45tW34QZJHspKQ9AHjQ4RfeIXJP8rb1WhdSN7VD68Qt0nEUo8j8Q4zV9sCsMDlI9z/SyzMbkYxf5FKYMw070k62EpkUPSh21bWX6uGD5YAcpgeGnrAjDmg/fm43jh+6xrDtMDdBqOZATE+VgyS3nRZXBHT1x63CHJuR8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.17; Tue, 2 Jul 2019 07:51:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 07:51:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Topic: [PATCH V2] soc: imx-scu: Add SoC UID(unique identifier) support
Thread-Index: AQHVLWJufgF2wmbUA02qCFDX/HZj7qa29qQAgAAAUZCAAAOOcA==
Date:   Tue, 2 Jul 2019 07:51:00 +0000
Message-ID: <DB3PR0402MB3916DE79C32C23A8C3C11280F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190628032544.8317-1-Anson.Huang@nxp.com>
 <20190702073522.blujpmxddw7brr7c@pengutronix.de>
 <DB3PR0402MB3916EE2A43DAFFEAB592BE61F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916EE2A43DAFFEAB592BE61F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e08c552-c7e9-4901-07e7-08d6fec206b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB378789AF28B5F295F20B2C9DF5F80@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(199004)(6116002)(3846002)(71200400001)(71190400001)(186003)(76116006)(6506007)(68736007)(66066001)(26005)(76176011)(73956011)(53936002)(66946007)(66446008)(66476007)(66556008)(64756008)(33656002)(2940100002)(81156014)(8676002)(8936002)(55016002)(81166006)(6246003)(4326008)(6436002)(9686003)(2906002)(102836004)(25786009)(229853002)(86362001)(446003)(11346002)(476003)(7696005)(74316002)(99286004)(305945005)(7736002)(6916009)(14454004)(256004)(54906003)(316002)(486006)(44832011)(5660300002)(52536014)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cWMDLC37lxrPVkV3M/U5YcMnK7zMe+cIITu+CfGb6eKJ4WhGx9gpOxFLBXEyds8dtLk8jTzh5MZUwOa+fByglPucFaorDx51T6kI+FwtXdAcE8Hns6mSi/zq7+3gVdAvghXs+++eTbIoiq122TsTIzUQg4D5PfjyFCkd6y6W6ZUFJGorMC0JH18EwJcFb3JdHA12+1Avsesx2pHA/YGY4gcdui8duag9iABDuuIf9p/PegEe4ubFY0x05b8foQuCgXTxUQ36DUN3KHGUv7YETsDxv0spn0KvpkfuXkM5sQmeqCedMmngLqIN4t522rdDe6WBB0LUo1LKnMcpK/k69wLKkKdEGP0EGOuRaK5Z2iiRXRda5wIr/KQcGBpXslxroLoBOU2mBCV7/m6qpnk130nG3mlFSzQxNLexGiTRgQ8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e08c552-c7e9-4901-07e7-08d6fec206b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 07:51:00.7025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gPiA+ICsJaGRyLT52ZXIgPSBJTVhfU0NfUlBDX1ZFUlNJT047DQo+ID4g
PiArCWhkci0+c3ZjID0gSU1YX1NDX1JQQ19TVkNfTUlTQzsNCj4gPiA+ICsJaGRyLT5mdW5jID0g
SU1YX1NDX01JU0NfRlVOQ19VTklRVUVfSUQ7DQo+ID4gPiArCWhkci0+c2l6ZSA9IDE7DQo+ID4g
PiArDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIFNDVSBGVyBBUEkgYWx3YXlzIHJldHVybnMgYW4g
ZXJyb3IgZXZlbiB0aGUNCj4gPiA+ICsJICogZnVuY3Rpb24gaXMgc3VjY2Vzc2Z1bGx5IGV4ZWN1
dGVkLCBzbyBza2lwDQo+ID4gPiArCSAqIHJldHVybmVkIHZhbHVlIGNoZWNrLg0KPiA+ID4gKwkg
Ki8NCj4gPiA+ICsJaW14X3NjdV9jYWxsX3JwYyhzb2NfaXBjX2hhbmRsZSwgJm1zZywgdHJ1ZSk7
DQo+ID4NCj4gPiBQbGVhc2UgY2FuIHlvdSBhZGQgYSBUT0RPOiBvciBGSVhNRTogdGFnIGFuZCBh
bHNvIHByb3ZpZGUgdGhlIGZpcm13YXJlDQo+ID4gdmVyc2lvbiBjb250YWluaW5nIHRoZSBidWc/
IEkga25vdyB0aGF0IGRldmVsb3BlcnMgYXJlIHZlcnkgYnVzeSBhbmQNCj4gPiBmb2xsb3ctIHVw
IGZpeGVzIG5ldmVyIHJlYWNoIG1haW5saW5lIDspDQo+IA0KPiBBcyBJIHJlcGxpZWQgaW4gcHJl
dmlvdXMgbWFpbCwgSSB3aWxsIHNlbmQgb3V0IGEgVjMgd2l0aCBiZWxvdyBjb21tZW50Og0KPiAN
Cj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFNDVSBGVyBBUEkgZG9lcyBOT1QgaGF2ZSByZXR1
cm5lZCB2YWx1ZSBmb3INCj4gKyAgICAgICAgKiB0aGlzIGZ1bmN0aW9uLCBzbyBza2lwIHJldHVy
bmVkIHZhbHVlIGNoZWNrLg0KPiArICAgICAgICAqLw0KPiArICAgICAgIGlteF9zY3VfY2FsbF9y
cGMoc29jX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KPiANCj4gVGhhbmtzLA0KPiBBbnNvbi4N
Cg0KU29ycnksIGFmdGVyIGZ1cnRoZXIgdGhvdWdodCwgcmVnYXJkaW5nIGZvciBTQ1UgQVBJIHdp
dGhvdXQgcmVzcG9uc2UsIHdlIHNob3VsZA0KcGFzcyB0aGUgImZhbHNlIiBhcyBpbXhfc2N1X2Nh
bGxfcnBjKCkncyAzcmQgcGFyYW1ldGVyLCBzbyBJIHdpbGwgcmVtb3ZlIHRoZSBjb21tZW50DQph
bmQgdXNlIGJlbG93IGluIFYzOg0KDQorICAgICAgIHJldCA9IGlteF9zY3VfY2FsbF9ycGMoc29j
X2lwY19oYW5kbGUsICZtc2csIGZhbHNlKTsNCisgICAgICAgaWYgKHJldCkgew0KKyAgICAgICAg
ICAgICAgIHByX2VycigiJXM6IGdldCBzb2MgdWlkIGZhaWxlZCwgcmV0ICVkXG4iLCBfX2Z1bmNf
XywgcmV0KTsNCisgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KKyAgICAgICB9DQoNClRoYW5r
cywNCkFuc29uDQoNCg==
