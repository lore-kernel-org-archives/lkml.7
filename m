Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58687C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30649205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WZpixlcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGBHiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:38:12 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:58340
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfGBHiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQmlocEVeiX5yqsJMfurkQCYK4OJK2XSPSxaqiJyk2M=;
 b=WZpixlcLj7VlPvE1cYWX3Jwd6KR6d+g9LeEbmUASEg/92PqgQrbxBm5wJasCFA6b6qdHXaPxCk3NJ58FL8KJpam9hk8D95agvMRmOJdJ/1SphY9R2O68vaW0hszz4mlu92QhBYVh2KUJrRtKfYfu+2Pavzc18XA8Buh8DJY6qHs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3929.eurprd04.prod.outlook.com (52.134.70.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 07:38:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 07:38:07 +0000
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
Thread-Index: AQHVLWJufgF2wmbUA02qCFDX/HZj7qa29qQAgAAAUZA=
Date:   Tue, 2 Jul 2019 07:38:07 +0000
Message-ID: <DB3PR0402MB3916EE2A43DAFFEAB592BE61F5F80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190628032544.8317-1-Anson.Huang@nxp.com>
 <20190702073522.blujpmxddw7brr7c@pengutronix.de>
In-Reply-To: <20190702073522.blujpmxddw7brr7c@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1333016-ef86-42e8-0487-08d6fec039e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3929;
x-ms-traffictypediagnostic: DB3PR0402MB3929:
x-microsoft-antispam-prvs: <DB3PR0402MB39296FC694F09D8C72B5FAEDF5F80@DB3PR0402MB3929.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(6916009)(81166006)(8676002)(81156014)(66556008)(6436002)(229853002)(66446008)(73956011)(6506007)(2906002)(64756008)(66946007)(52536014)(66066001)(74316002)(6116002)(102836004)(76116006)(3846002)(478600001)(66476007)(8936002)(86362001)(4744005)(53936002)(76176011)(446003)(7696005)(11346002)(55016002)(6246003)(476003)(316002)(71190400001)(71200400001)(9686003)(486006)(14454004)(33656002)(305945005)(186003)(68736007)(44832011)(256004)(4326008)(54906003)(99286004)(25786009)(5660300002)(26005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3929;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PmnTKjYXpcUAR+rP4sfDmbGAPJnbvqAbNh6jzhKiX7l4tbma+k7Fj51mqCFgMNWQDB1dV0ROh1aBxMuH+KyxNh+fbpLU6bDVJjLtfN8e11QFO4NSKXcQI87ZSFi2cj8wm8mNPvJVeIC3eAcoUJ1fPgBoEcABfeE1W6x8z4MfAzR/lPxuhG5LQ5H/fCxfxR4+SEy6GQb0ERxuunSIk0Be7N1DGMlUY9isgnOCSKoXke5a7bH67GcGyXBE+FBF2pe5CicUW6fTCRMPEF9+BKR0ix5ymWh0V0rc3/hpsZQwho7Yh9wejdf/ifBgbcZmaJDeItNRiQ8uVd7oY71E/ScxJ9mjFotJuxyHC0vKt535FEdSGuTkAe8/lS8rrEjDhm6gZgGQ7ISCjAdEnSoNe6S+Lieg5rC4yHewWqJCtYbACoU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1333016-ef86-42e8-0487-08d6fec039e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 07:38:07.6565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3929
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmNvDQoNCj4gPiArCWhkci0+dmVyID0gSU1YX1NDX1JQQ19WRVJTSU9OOw0KPiA+ICsJ
aGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDOw0KPiA+ICsJaGRyLT5mdW5jID0gSU1YX1ND
X01JU0NfRlVOQ19VTklRVUVfSUQ7DQo+ID4gKwloZHItPnNpemUgPSAxOw0KPiA+ICsNCj4gPiAr
CS8qDQo+ID4gKwkgKiBTQ1UgRlcgQVBJIGFsd2F5cyByZXR1cm5zIGFuIGVycm9yIGV2ZW4gdGhl
DQo+ID4gKwkgKiBmdW5jdGlvbiBpcyBzdWNjZXNzZnVsbHkgZXhlY3V0ZWQsIHNvIHNraXANCj4g
PiArCSAqIHJldHVybmVkIHZhbHVlIGNoZWNrLg0KPiA+ICsJICovDQo+ID4gKwlpbXhfc2N1X2Nh
bGxfcnBjKHNvY19pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4gDQo+IFBsZWFzZSBjYW4geW91
IGFkZCBhIFRPRE86IG9yIEZJWE1FOiB0YWcgYW5kIGFsc28gcHJvdmlkZSB0aGUgZmlybXdhcmUN
Cj4gdmVyc2lvbiBjb250YWluaW5nIHRoZSBidWc/IEkga25vdyB0aGF0IGRldmVsb3BlcnMgYXJl
IHZlcnkgYnVzeSBhbmQgZm9sbG93LQ0KPiB1cCBmaXhlcyBuZXZlciByZWFjaCBtYWlubGluZSA7
KQ0KDQpBcyBJIHJlcGxpZWQgaW4gcHJldmlvdXMgbWFpbCwgSSB3aWxsIHNlbmQgb3V0IGEgVjMg
d2l0aCBiZWxvdyBjb21tZW50Og0KDQorICAgICAgIC8qDQorICAgICAgICAqIFNDVSBGVyBBUEkg
ZG9lcyBOT1QgaGF2ZSByZXR1cm5lZCB2YWx1ZSBmb3INCisgICAgICAgICogdGhpcyBmdW5jdGlv
biwgc28gc2tpcCByZXR1cm5lZCB2YWx1ZSBjaGVjay4NCisgICAgICAgICovDQorICAgICAgIGlt
eF9zY3VfY2FsbF9ycGMoc29jX2lwY19oYW5kbGUsICZtc2csIHRydWUpOw0KDQpUaGFua3MsDQpB
bnNvbi4NCg0KPiANCj4gUmVnYXJkcywNCj4gICBNYXJjbw0KDQo=
