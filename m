Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C869C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C33F214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="rf2JqNtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406833AbfHIOFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:05:18 -0400
Received: from mail-eopbgr130097.outbound.protection.outlook.com ([40.107.13.97]:20710
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbfHIOFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:05:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxWac2UPM2CTFEP6O0lu4UfH8yuUQqfCfQqEbg2/D/SFyYOS423sOPWyu/dvOySfR8rVbl2sEe8ke70naYbhNTH32rK4Hz112sv+vXJ2XLEX6Q1p/4IHXnPx/l6p4E5IdrymR3COFet7aO+yVFcydh+4Bd4OJ11nllR8NKkeThGEsfjAdwscecPfzDKdxcBuJf5Zao7D+8wp+ybuoae2SUnOCNinzbnbmYrVRKZ3ZDGo43dLwMh9EQVWejvQuJZ64103ob5cmnjMZhooDzPLbWUM5L3AY8eXgIoLLYg8HiZLySv5kgE1WEjglApoNbyTllJN6kbJEMxaJuB1rMnAvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qufY5/5BquD8wvMf4aMc/wTpvA00byo6dTKME0XDkw=;
 b=Vi0HgaBWS9eFRlVhXpV8wGOxZtLlzSo8yT4kx1SNoR8vtfm3gi3dgtZCr9Db6DLnirDK4SlD/RNPzzgoM3wuajf43qTTGBc6srJbRTKAufs/fu/COXnh0gmZ5KvPRdCBQvpTiKg8Hej2Np59iCsrZLHpJ4CLsbRrfop+1HF85YPZvbB45SIj8NRLrkU5Zt7i/evIRfval0a5/2PxzUwI7wyEyDVxMPUBaKkYHyuxSohADupQxl+52+0p0YRICVgw/z5TmaWoSyuo+3r/ytLNiGUsWLJb5cRezwM3Vpd9Ze+xkJ3+prLlKj3X2d18j5K1Qn6vJS+445GMlKfSq0nDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qufY5/5BquD8wvMf4aMc/wTpvA00byo6dTKME0XDkw=;
 b=rf2JqNtnj8EqXaXYXqo2dFWvzVU/Nii+tlqMC3oACgTxQVblMVZFeMkOxSxH50fRVjuMAc6WalSoI0Rnj07aLe4z7Pxg4t4K3vsyB64m3tSGXV2L1vlGlYNedzfZva1njfQvLYpmi0+vc1VgGw/YpqfKZa1AJG2tABqJWrGnXoo=
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com (20.179.27.139) by
 VI1PR05MB6688.eurprd05.prod.outlook.com (10.141.128.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 9 Aug 2019 14:05:12 +0000
Received: from VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a]) by VI1PR05MB6415.eurprd05.prod.outlook.com
 ([fe80::f1b2:353a:da9b:c19a%4]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 14:05:12 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Topic: [PATCH v3 02/21] ARM: dts: imx7-colibri: disable HS400
Thread-Index: AQHVTPnFNNsmkDlhI0CXoPM6AWE0ZKby3PaA
Date:   Fri, 9 Aug 2019 14:05:12 +0000
Message-ID: <2051fb5874440c47f9419396658aa478e421ce0b.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-3-philippe.schenker@toradex.com>
In-Reply-To: <20190807082556.5013-3-philippe.schenker@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [2a01:2a8:8501:4d00:ca5b:76ff:fedf:3c49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30a68364-22f0-4846-c2fa-08d71cd29898
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB6688;
x-ms-traffictypediagnostic: VI1PR05MB6688:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6688657931E6DAA4156342ACFBD60@VI1PR05MB6688.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39850400004)(376002)(346002)(396003)(189003)(199004)(2501003)(71200400001)(2201001)(14454004)(46003)(6486002)(6436002)(71190400001)(229853002)(14444005)(256004)(5660300002)(7416002)(316002)(66476007)(66446008)(66556008)(64756008)(6506007)(76116006)(91956017)(66946007)(102836004)(86362001)(305945005)(6116002)(7736002)(81156014)(110136005)(8676002)(81166006)(4326008)(76176011)(99286004)(54906003)(36756003)(2906002)(8936002)(53936002)(186003)(446003)(476003)(118296001)(44832011)(486006)(6246003)(6512007)(25786009)(11346002)(2616005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6688;H:VI1PR05MB6415.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pBVAH4fq40VDI3284BdkbiU33nt8UFRUolvQVDQCvNn+HPhdn8GYwF4wwWUhHx5tZn38h1AjDsSW/nWQJmEvBbJx50AbU+OOL5vrByxkEzzkvioKomHGS+HCBVpK7yEpgwTX/kyH1Fd5jVZckA08z8xYKdF3xC0kNE9knlnOZbETZFNCd2ymJvDsuMP2EQ3q+k3o5W0QSMzCX3llCNMZ15bn4bJIO/5vF32Zt1xjQTxl3c3gByahQpPEbZEf2I6rwmYHbhcBKrhKRB8z/SLH40XCy3gwhPP1GawGiJoa2Z5xNA35EXO1PV2Vj9oGFI6wEz+A4nCDjY3c7N1kgrG2TkWVgQp7NjsyUUVUEH+DXchItPSzF7Gcijx8WyIDO9yu6iRMWUlemAzXlkEtK/BLbKr7SdeKDLIvJN6mkL1F8gs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0ADC73EC2A5A5348AE565250F25A52D8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30a68364-22f0-4846-c2fa-08d71cd29898
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 14:05:12.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fpixl3rNMR9DTrbALfEoehCDfVJVckWHIow3SaX0Exabp/+u83nHeAOI1vJaEIWlCGXHCK31wcvRSH4rgieQt9Zit2tzsAHlHQKRY3h0DEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDA4OjI2ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gRnJvbTogU3RlZmFuIEFnbmVyIDxzdGVmYW4uYWduZXJAdG9yYWRleC5jb20+DQo+IA0K
PiBGb3JjZSBIUzIwMCBieSBtYXNraW5nIGJpdCA2MyBvZiB0aGUgU0RIQ0kgY2FwYWJpbGl0eSBy
ZWdpc3Rlci4NCj4gVGhlIGkuTVggRVNESEMgZHJpdmVyIHVzZXMgU0RIQ0lfUVVJUksyX0NBUFNf
QklUNjNfRk9SX0hTNDAwLiBXaXRoDQo+IHRoYXQgdGhlIHN0YWNrIGNoZWNrcyBiaXQgNjMgdG8g
ZGVzY2lkZSB3aGV0aGVyIEhTNDAwIGlzIGF2YWlsYWJsZS4NCj4gVXNpbmcgc2RoY2ktY2Fwcy1t
YXNrIGFsbG93cyB0byBtYXNrIGJpdCA2My4gVGhlIHN0YWNrIHRoZW4gc2VsZWN0cw0KPiBIUzIw
MCBhcyBvcGVyYXRpbmcgbW9kZS4NCj4gDQo+IFRoaXMgcHJldmVudHMgcmFyZSBjb21tdW5pY2F0
aW9uIGVycm9ycyB3aXRoIG1pbmltYWwgZWZmZWN0IG9uDQo+IHBlcmZvcm1hbmNlOg0KPiAJc2Ro
Y2ktZXNkaGMtaW14IDMwYjYwMDAwLnVzZGhjOiB3YXJuaW5nISBIUzQwMCBzdHJvYmUgRExMDQo+
IAkJc3RhdHVzIFJFRiBub3QgbG9jayENCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBBZ25l
ciA8c3RlZmFuLmFnbmVyQHRvcmFkZXguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBT
Y2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNCkFja2VkLWJ5OiBNYXJj
ZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gDQo+
IENoYW5nZXMgaW4gdjM6IE5vbmUNCj4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiANCj4gIGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg3
LWNvbGlicmkuZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDctY29saWJyaS5kdHNpDQo+
IGluZGV4IGYxYzE5NzFmMjE2MC4uZjdjOWNlNWJlZDQ3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg3LWNvbGlicmkuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9p
bXg3LWNvbGlicmkuZHRzaQ0KPiBAQCAtMzI1LDYgKzMyNSw3IEBADQo+ICAJdm1tYy1zdXBwbHkg
PSA8JnJlZ19tb2R1bGVfM3YzPjsNCj4gIAl2cW1tYy1zdXBwbHkgPSA8JnJlZ19EQ0RDMz47DQo+
ICAJbm9uLXJlbW92YWJsZTsNCj4gKwlzZGhjaS1jYXBzLW1hc2sgPSA8MHg4MDAwMDAwMCAweDA+
Ow0KPiAgfTsNCj4gIA0KPiAgJmlvbXV4YyB7DQo=
