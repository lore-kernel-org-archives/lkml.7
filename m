Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC7CC31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF2021744
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="QCOJkxkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfHOLEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:04:37 -0400
Received: from mail-eopbgr50130.outbound.protection.outlook.com ([40.107.5.130]:35752
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727814AbfHOLEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgoQzLFxd0YluMOd3TOeUXormJZMC8hWCmUUvRKFoQtCxGJ0cuh5t4U9+dI9v6gT5ZyoyuRN+LeXr+JjOnp22gWZZW4cYlFoQbVKIuRL2LkoKx4R5XC55bPfouYG1E+eCOG1KI/wnTPPQE7tsPfihn94fgcKJok+u/AxfYrMt29DYslRwJg9ApGpeGXFTppP/ObmO32rse2994y9te0THYhU/UDegpvZ7Y5O8A0C0HATTk12vntG0WNfhZmH885c/24hG/2CGF3L2EsoMio+piaoXMmBCW9UICKMuuXy8B0r6jLyXKuPN/jbZg2xl0Xjv2cHQZ0iUkhTMm96GNiQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR4drwO2pECVlXf8muLob/2LjTtGlI5oD3W5a5diY9w=;
 b=bhdXTs8dy9kYQH6cqtgaF3nuqxAZTJQ3F62ro1jD3AoI/xohORfTq8ZkW+KDYzGwAAuMBtGJxylZIu1qTso3da6kud1n9fp2AtpSV20QR2SWmE03X7/UUcBnF01t9+5eaOONzu9G3t+sz/9rvnDETty4scNzGiB9w6zLQawk/eeCijp3L7OaJO1RuIGBiu0V3pPWyzrx/6rxFNgULSmWK0o0PfcaeILvBV5DFQnQtpXbpldqakr2JCSwOXu3R5ODoD5iGx5RvnZ7+lj7nrMfidwkU4p83PaCdOIwVmKaLVL4JiKivQIU9Wo48zjlg2QN2Zql7v2gnYR3iIxfTUperQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tR4drwO2pECVlXf8muLob/2LjTtGlI5oD3W5a5diY9w=;
 b=QCOJkxkfztXD41mj49eToTEUszSAeFCul5Hm0A+ppSZgpAOJ70nnd0p/5yUG9Cumqt5SVfgnLSWfeJZOcuKzuWF595DtFb3dErxvrxGTjnoHsosv+tK1DwKSX9tT/Mef4QcT/YNIMZCTfdlEYjrg/XeZ+S5wgCLfKndBD11ufOE=
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com (20.179.27.210) by
 VI1PR05MB5808.eurprd05.prod.outlook.com (20.178.122.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.21; Thu, 15 Aug 2019 11:04:32 +0000
Received: from VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9]) by VI1PR05MB6544.eurprd05.prod.outlook.com
 ([fe80::4810:d157:267a:83b9%4]) with mapi id 15.20.2157.022; Thu, 15 Aug 2019
 11:04:33 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>
CC:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4 12/21] ARM: dts: imx6-apalis: Add touchscreens used on
 Toradex eval boards
Thread-Topic: [PATCH v4 12/21] ARM: dts: imx6-apalis: Add touchscreens used on
 Toradex eval boards
Thread-Index: AQHVU1gyaZDzHRHaaUC3Kzkn91ZI5g==
Date:   Thu, 15 Aug 2019 11:04:33 +0000
Message-ID: <CAGgjyvF+53CdYUB4QNJWfDqUigDyTi9G06i9wXW_3tmWM8ra=A@mail.gmail.com>
References: <20190812142105.1995-1-philippe.schenker@toradex.com>
 <20190812142105.1995-13-philippe.schenker@toradex.com>
In-Reply-To: <20190812142105.1995-13-philippe.schenker@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR06CA0053.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::30) To VI1PR05MB6544.eurprd05.prod.outlook.com
 (2603:10a6:803:ff::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAUxfOcrya5ZEuakezbdTxWPpJ3e2awhEKl0y5GcSNP35UBe7aMp
        THe8ATqGV2lZfhuBejmZW1KXXBpYvdqpr/HTFrU=
x-google-smtp-source: APXvYqwqbYpSrZiP6BavBDffmbiAwf4lC+LyJxAotmzskoITlnYMw+W2c1ESatK3aEs5YsWi9t9jhtrgCnQR2MR6Xag=
x-received: by 2002:a17:906:9453:: with SMTP id
 z19mr3816701ejx.287.1565866646371; Thu, 15 Aug 2019 03:57:26 -0700 (PDT)
x-gmail-original-message-id: <CAGgjyvF+53CdYUB4QNJWfDqUigDyTi9G06i9wXW_3tmWM8ra=A@mail.gmail.com>
x-originating-ip: [209.85.208.47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 941496bf-bb94-4cbf-2477-08d721705a4c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR05MB5808;
x-ms-traffictypediagnostic: VI1PR05MB5808:
x-microsoft-antispam-prvs: <VI1PR05MB5808C9036746E1DDEE196088F9AC0@VI1PR05MB5808.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(366004)(376002)(396003)(346002)(136003)(189003)(199004)(2906002)(6862004)(81166006)(81156014)(71190400001)(8676002)(11346002)(3846002)(8936002)(6512007)(498394004)(71200400001)(86362001)(9686003)(6116002)(55446002)(6436002)(229853002)(6506007)(53546011)(66556008)(66476007)(386003)(486006)(6636002)(476003)(186003)(14454004)(256004)(478600001)(66446008)(5660300002)(53936002)(14444005)(25786009)(6486002)(26005)(66946007)(450100002)(4326008)(44832011)(66066001)(305945005)(61266001)(316002)(95326003)(446003)(107886003)(6246003)(99286004)(102836004)(76176011)(52116002)(7736002)(54906003)(61726006)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5808;H:VI1PR05MB6544.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xx67U4FqfNMFckYQaZpN6btSLUpYydgOvhlS8aADvjI2v0cIa7QBprbv+E8MCYqVJCUdMUI5wrfWe5sE0Kr5/Im/oKm1Uf6zhmnWayQoLncy6wwoYnvVRStjITPJo7KoWMTtU4+TNhna0nz61L0AuCaxCotC1cPKwNTo6r/YHBRw8E9GR3pNaJlZT3ACd1T0N4lOpcb99vEd2gcesHEaDWhwCCDJaz3BOONOnDq//NGNpfuLX6WNr/0Hcx/951gcSsne6Q05j4eKEhsRGtDPA0WOX4pIZc2HsfW2oJm9XRpO9+W7FakJXbMmgcNt3f8uOdxUu75QKK+pGBlrljo91ZAtHSwbNckV+0w9qQTkgRXFiztkuS99dkaoNjY5ne3yMXgymLiAkLY+cBJBG8lYeFwad0k0Ib1QwAZO67ZGpQY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <82F7EAEC14F563459B5D68C4F405FEC2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941496bf-bb94-4cbf-2477-08d721705a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 11:04:33.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clz0SMrNbytygptRc8B7bddNPhH7xg/PDyja7VhJm9VcYcdhrosSeC+wI0nMPdHjKKJ252jxr6jWW7OWMLTrjB8Te0PH6yLIPQnLUOtK/Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBBdWcgMTIsIDIwMTkgYXQgNToyMyBQTSBQaGlsaXBwZSBTY2hlbmtlcg0KPHBoaWxp
cHBlLnNjaGVua2VyQHRvcmFkZXguY29tPiB3cm90ZToNCj4NCj4gVGhpcyBjb21taXQgYWRkcyB0
aGUgdG91Y2hzY3JlZW5zIGZyb20gVG9yYWRleCBzbyBvbmUgY2FuIGVuYWJsZSBpdC4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2NoZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFk
ZXguY29tPg0KPiBBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9y
YWRleC5jb20+DQoNClJldmlld2VkLWJ5OiBPbGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1
dm9yb3ZAdG9yYWRleC5jb20+DQoNCj4NCj4gLS0tDQo+DQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0g
QWRkIE1hcmNlbCBaaXN3aWxlcidzIEFjaw0KPg0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEZpeCBj
b21taXQgdGl0bGUgdG8gIi4uLmlteDYtYXBhbGlzOi4uLiINCj4NCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBEZWxldGVkIHRvdWNocmV2b2x1dGlvbiBkb3duc3RyZWFtIHN0dWZmDQo+IC0gVXNlIGdl
bmVyaWMgbm9kZSBuYW1lDQo+IC0gUHV0IGEgYmV0dGVyIGNvbW1lbnQgaW4gdGhlcmUNCj4NCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZkbC1jb2xpYnJpLWV2YWwtdjMuZHRzICB8IDMxICsrKysr
KysrKysrKysrKysrKysNCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1ldmFsLmR0
cyAgICAgICB8IDEzICsrKysrKysrDQo+ICBhcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFsaXMt
aXhvcmEtdjEuMS5kdHMgfCAxMyArKysrKysrKw0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEt
YXBhbGlzLWl4b3JhLmR0cyAgICAgIHwgMTMgKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwg
NzAgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NmRsLWNvbGlicmktZXZhbC12My5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2ZGwtY29saWJy
aS1ldmFsLXYzLmR0cw0KPiBpbmRleCA5YTVkNmM5NGNjYTQuLjc2M2ZiNWU5MGJkMyAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMNCj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLWNvbGlicmktZXZhbC12My5kdHMNCj4gQEAg
LTE2OCw2ICsxNjgsMjEgQEANCj4gICZpMmMzIHsNCj4gICAgICAgICBzdGF0dXMgPSAib2theSI7
DQo+DQo+ICsgICAgICAgLyoNCj4gKyAgICAgICAgKiBUb3VjaHNjcmVlbiBpcyB1c2luZyBTT0RJ
TU0gMjgvMzAsIGFsc28gdXNlZCBmb3IgUFdNPEI+LCBQV008Qz4sDQo+ICsgICAgICAgICogYWth
IHB3bTIsIHB3bTMuIHNvIGlmIHlvdSBlbmFibGUgdG91Y2hzY3JlZW4sIGRpc2FibGUgdGhlIHB3
bXMNCj4gKyAgICAgICAgKi8NCj4gKyAgICAgICB0b3VjaHNjcmVlbkA0YSB7DQo+ICsgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLG1heHRvdWNoIjsNCj4gKyAgICAgICAgICAgICAg
IHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsgICAgICAgICAgICAgICBwaW5jdHJsLTAg
PSA8JnBpbmN0cmxfcGNhcF8xPjsNCj4gKyAgICAgICAgICAgICAgIHJlZyA9IDwweDRhPjsNCj4g
KyAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW8xPjsNCj4gKyAgICAgICAg
ICAgICAgIGludGVycnVwdHMgPSA8OSBJUlFfVFlQRV9FREdFX0ZBTExJTkc+OyAgICAgICAgIC8q
IFNPRElNTSAyOCAqLw0KPiArICAgICAgICAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW8yIDEw
IEdQSU9fQUNUSVZFX0hJR0g+OyAgICAgLyogU09ESU1NIDMwICovDQo+ICsgICAgICAgICAgICAg
ICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArICAgICAgIH07DQo+ICsNCj4gICAgICAgICAvKiBN
NDFUME02IHJlYWwgdGltZSBjbG9jayBvbiBjYXJyaWVyIGJvYXJkICovDQo+ICAgICAgICAgcnRj
X2kyYzogcnRjQDY4IHsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic3QsbTQxdDAi
Ow0KPiBAQCAtMTc1LDYgKzE5MCwyMiBAQA0KPiAgICAgICAgIH07DQo+ICB9Ow0KPg0KPiArJmlv
bXV4YyB7DQo+ICsgICAgICAgcGluY3RybF9wY2FwXzE6IHBjYXAtMSB7DQo+ICsgICAgICAgICAg
ICAgICBmc2wscGlucyA9IDwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgTVg2UURMX1BBRF9H
UElPXzlfX0dQSU8xX0lPMDkgICAweDFiMGIwIC8qIFNPRElNTSAyOCAqLw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICBNWDZRRExfUEFEX1NENF9EQVQyX19HUElPMl9JTzEwIDB4MWIwYjAgLyog
U09ESU1NIDMwICovDQo+ICsgICAgICAgICAgICAgICA+Ow0KPiArICAgICAgIH07DQo+ICsNCj4g
KyAgICAgICBwaW5jdHJsX214dF90czogbXh0LXRzIHsNCj4gKyAgICAgICAgICAgICAgIGZzbCxw
aW5zID0gPA0KPiArICAgICAgICAgICAgICAgICAgICAgICBNWDZRRExfUEFEX0VJTV9DUzFfX0dQ
SU8yX0lPMjQgIDB4MTMwYjAgLyogU09ESU1NIDEwNyAqLw0KPiArICAgICAgICAgICAgICAgICAg
ICAgICBNWDZRRExfUEFEX1NEMl9EQVQxX19HUElPMV9JTzE0IDB4MTMwYjAgLyogU09ESU1NIDEw
NiAqLw0KPiArICAgICAgICAgICAgICAgPjsNCj4gKyAgICAgICB9Ow0KPiArfTsNCj4gKw0KPiAg
JmlwdTFfZGkwX2Rpc3AwIHsNCj4gICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JmxjZF9kaXNw
bGF5X2luPjsNCj4gIH07DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2cS1h
cGFsaXMtZXZhbC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2cS1hcGFsaXMtZXZhbC5kdHMN
Cj4gaW5kZXggMGVkZDMwNDNkOWMxLi40NjY1ZTE1YjE5NmQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gv
YXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1ldmFsLmR0cw0KPiArKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2cS1hcGFsaXMtZXZhbC5kdHMNCj4gQEAgLTE2Nyw2ICsxNjcsMTkgQEANCj4gICZp
MmMxIHsNCj4gICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+DQo+ICsgICAgICAgLyoNCj4gKyAg
ICAgICAgKiBUb3VjaHNjcmVlbiBpcyB1c2luZyBTT0RJTU0gMjgvMzAsIGFsc28gdXNlZCBmb3Ig
UFdNPEI+LCBQV008Qz4sDQo+ICsgICAgICAgICogYWthIHB3bTIsIHB3bTMuIHNvIGlmIHlvdSBl
bmFibGUgdG91Y2hzY3JlZW4sIGRpc2FibGUgdGhlIHB3bXMNCj4gKyAgICAgICAgKi8NCj4gKyAg
ICAgICB0b3VjaHNjcmVlbkA0YSB7DQo+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImF0
bWVsLG1heHRvdWNoIjsNCj4gKyAgICAgICAgICAgICAgIHJlZyA9IDwweDRhPjsNCj4gKyAgICAg
ICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmdwaW82PjsNCj4gKyAgICAgICAgICAgICAg
IGludGVycnVwdHMgPSA8MTAgSVJRX1RZUEVfRURHRV9GQUxMSU5HPjsNCj4gKyAgICAgICAgICAg
ICAgIHJlc2V0LWdwaW9zID0gPCZncGlvNiA5IEdQSU9fQUNUSVZFX0hJR0g+OyAvKiBTT0RJTU0g
MTMgKi8NCj4gKyAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsgICAgICAg
fTsNCj4gKw0KPiAgICAgICAgIHBjaWUtc3dpdGNoQDU4IHsNCj4gICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAicGx4LHBleDg2MDUiOw0KPiAgICAgICAgICAgICAgICAgcmVnID0gPDB4NTg+
Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEtYXBhbGlzLWl4b3JhLXYx
LjEuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEtYXBhbGlzLWl4b3JhLXYxLjEuZHRzDQo+
IGluZGV4IGI5NGJiNjg3YmU2Yi4uYTNmYTA0YTk3ZDgxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2cS1hcGFsaXMtaXhvcmEtdjEuMS5kdHMNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnEtYXBhbGlzLWl4b3JhLXYxLjEuZHRzDQo+IEBAIC0xNzIsNiArMTcyLDE5
IEBADQo+ICAmaTJjMSB7DQo+ICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPg0KPiArICAgICAg
IC8qDQo+ICsgICAgICAgICogVG91Y2hzY3JlZW4gaXMgdXNpbmcgU09ESU1NIDI4LzMwLCBhbHNv
IHVzZWQgZm9yIFBXTTxCPiwgUFdNPEM+LA0KPiArICAgICAgICAqIGFrYSBwd20yLCBwd20zLiBz
byBpZiB5b3UgZW5hYmxlIHRvdWNoc2NyZWVuLCBkaXNhYmxlIHRoZSBwd21zDQo+ICsgICAgICAg
ICovDQo+ICsgICAgICAgdG91Y2hzY3JlZW5ANGEgew0KPiArICAgICAgICAgICAgICAgY29tcGF0
aWJsZSA9ICJhdG1lbCxtYXh0b3VjaCI7DQo+ICsgICAgICAgICAgICAgICByZWcgPSA8MHg0YT47
DQo+ICsgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZncGlvNj47DQo+ICsgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDEwIElSUV9UWVBFX0VER0VfRkFMTElORz47DQo+ICsg
ICAgICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbzYgOSBHUElPX0FDVElWRV9ISUdIPjsg
LyogU09ESU1NIDEzICovDQo+ICsgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
PiArICAgICAgIH07DQo+ICsNCj4gICAgICAgICAvKiBNNDFUME02IHJlYWwgdGltZSBjbG9jayBv
biBjYXJyaWVyIGJvYXJkICovDQo+ICAgICAgICAgcnRjX2kyYzogcnRjQDY4IHsNCj4gICAgICAg
ICAgICAgICAgIGNvbXBhdGlibGUgPSAic3QsbTQxdDAiOw0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnEtYXBhbGlzLWl4b3JhLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lt
eDZxLWFwYWxpcy1peG9yYS5kdHMNCj4gaW5kZXggMzAyZmQ2YWRjOGE3Li41YmE0OWQwZjQ4ODAg
MTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxLWFwYWxpcy1peG9yYS5kdHMN
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnEtYXBhbGlzLWl4b3JhLmR0cw0KPiBAQCAt
MTcxLDYgKzE3MSwxOSBAQA0KPiAgJmkyYzEgew0KPiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsN
Cj4NCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFRvdWNoc2NyZWVuIGlzIHVzaW5nIFNPRElN
TSAyOC8zMCwgYWxzbyB1c2VkIGZvciBQV008Qj4sIFBXTTxDPiwNCj4gKyAgICAgICAgKiBha2Eg
cHdtMiwgcHdtMy4gc28gaWYgeW91IGVuYWJsZSB0b3VjaHNjcmVlbiwgZGlzYWJsZSB0aGUgcHdt
cw0KPiArICAgICAgICAqLw0KPiArICAgICAgIHRvdWNoc2NyZWVuQDRhIHsNCj4gKyAgICAgICAg
ICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsbWF4dG91Y2giOw0KPiArICAgICAgICAgICAgICAg
cmVnID0gPDB4NGE+Ow0KPiArICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3Bp
bzY+Ow0KPiArICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwxMCBJUlFfVFlQRV9FREdFX0ZB
TExJTkc+Ow0KPiArICAgICAgICAgICAgICAgcmVzZXQtZ3Bpb3MgPSA8JmdwaW82IDkgR1BJT19B
Q1RJVkVfSElHSD47IC8qIFNPRElNTSAxMyAqLw0KPiArICAgICAgICAgICAgICAgc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gKyAgICAgICB9Ow0KPiArDQo+ICAgICAgICAgZWVwcm9tQDUwIHsNCj4g
ICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsMjRjMDIiOw0KPiAgICAgICAgICAg
ICAgICAgcmVnID0gPDB4NTA+Ow0KPiAtLQ0KPiAyLjIyLjANCj4NCg0KDQotLSANCkJlc3QgcmVn
YXJkcw0KT2xla3NhbmRyIFN1dm9yb3YNCg0KVG9yYWRleCBBRw0KQWx0c2FnZW5zdHJhc3NlIDUg
fCA2MDQ4IEhvcncvTHV6ZXJuIHwgU3dpdHplcmxhbmQgfCBUOiArNDEgNDEgNTAwDQo0ODAwICht
YWluIGxpbmUpDQo=
