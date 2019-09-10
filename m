Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12C3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997DC21924
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="kZww++Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390695AbfIJGOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:14:40 -0400
Received: from mail-eopbgr20108.outbound.protection.outlook.com ([40.107.2.108]:35552
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726229AbfIJGOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:14:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIiF5svL6kNoA7vMcaIGfSaMQM4PNAoYsBlhWDuPAmwnFzmLTri+A5e8pqZQZ+NYQ7j2VBhWYRqlgGpjmZzJg/o9Ca6HW6d38IEnsUbLWLispuYqG+gs380AbYf224BLQFsQbtRYE1u0rdddzJ0HowobNoy2wBHdNUktXp0+Pf6fExYTPc8bGpOFJy7GmEoXK7UBQ+kVoihvZOl/TIGJmcJ2m3csSaJtdnT7VXRiGVLo+Dm7jd/6j12TaUbDz6vqsxK99tYK8bj5bjP7adEBNPxFdLAPuh8NbWH9vNVfGRusels/oRkGHtRxFUnNTiUxk42e5FCzfoMgJXDtWrSbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb3/Ci37umcxR/akK46NuZXvT/O1CRVMTKs1mlhRsC8=;
 b=PWtA90pwNQLQy43IO/su9ouThrgTbOmYOb6q8lrUVXWCFAQeQIx/f/HNN/bfCMtPwKJoNgz1yGf6G/S7fRH8BbKwvQ2FPa15mPpoFR6A56/UsfFxQbxgrsT/xzy4JWUOQuGB0GfZ1Xt+n8SgH6XlbdXBYJ/OUhT4nGQ/3iQ856X3nWA2nVapSAiQc48Z/h7exMQhuFkcgrRQVkj01kt6R11GlegiIj21hjPAOP3IylaAIpxVERrz8J8KRLlur/BNiTqWz56gR9iJq6lwxZ8/2V46n9TXIRId9u9wPzkSxq0AT+cPFtzmU87DATF4ogbHexXCMUvfubENuMuc7/IE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lb3/Ci37umcxR/akK46NuZXvT/O1CRVMTKs1mlhRsC8=;
 b=kZww++RorQl9VImqOrQnk+86XbtCdkyQ/CbO0irPMjthfqqyH0GgOHB3jUKIxyIh2vgp6DTJisHOtD5yBaNykwJj3AoI+Amtg+jQqDMPDx9v5uMnTTAZZTlADVPSP83cAhWJ8Qm9ggRUiLJY+T4PskZCqrWJOMlm7pSQPCrIjBs=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB3711.eurprd05.prod.outlook.com (52.134.8.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.20; Tue, 10 Sep 2019 06:14:36 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f59f:a307:9c53:63b9%6]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 06:14:36 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Luka Pivk <luka.pivk@toradex.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan.agner@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] regulator: fixed: add possibility to enable by clock
Thread-Topic: [PATCH 1/3] regulator: fixed: add possibility to enable by clock
Thread-Index: AQHVYi4cgyK53mdiuEKJwWlDc8lst6cdZNqAgAcTQoCAAAGQgA==
Date:   Tue, 10 Sep 2019 06:14:36 +0000
Message-ID: <8304353c288dd924d31e5ddb5e0368b2c436b2fb.camel@toradex.com>
References: <20190903080336.32288-1-philippe.schenker@toradex.com>
         <20190903080336.32288-2-philippe.schenker@toradex.com>
         <20190905180615.GG4053@sirena.co.uk>
         <c44f33e7396c87afecec234975652c1445d7be9d.camel@toradex.com>
In-Reply-To: <c44f33e7396c87afecec234975652c1445d7be9d.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ee813b0-2c6c-4a76-5f24-08d735b627ee
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:VI1PR0502MB3711;
x-ms-traffictypediagnostic: VI1PR0502MB3711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB37113599B41D1BCDAD8A518DF4B60@VI1PR0502MB3711.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(366004)(136003)(39850400004)(396003)(189003)(199004)(11346002)(446003)(478600001)(305945005)(2616005)(44832011)(486006)(5660300002)(53936002)(102836004)(6506007)(66066001)(14454004)(99286004)(316002)(54906003)(26005)(3846002)(6116002)(256004)(25786009)(2906002)(71190400001)(118296001)(2351001)(4326008)(36756003)(2501003)(5640700003)(8936002)(76176011)(476003)(81156014)(1730700003)(76116006)(91956017)(8676002)(6512007)(186003)(6916009)(229853002)(6436002)(66946007)(6246003)(66446008)(64756008)(66556008)(66476007)(6486002)(7736002)(86362001)(71200400001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB3711;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KdIZfnuQK8G5CieQbbrxRjTVFHJ9V4OK01Jcjo+0KqsF2LOhoDPu2/TvG/AgCCn/O6woSplvzQXaHeMkdS+IMt16RhIhd3fbryfOt/tIM2CdyFFJ+uDTp6iqrKtv7eYSOA55C/HKwHeJbRqAy38NtCJdLum69B5JgybVmh20Yfac0E4Wk7FiNu1dpW1P9f11ACni0i4dhL7E/HUyAjgNkazdZBOlCbrmZOKQr9iBmfXvzEbeZYKmxSi06ijooJ7Pkdt278R0Ig7yz0wk9EwMx5Z7r+IRsemqHADNjP+x43jd1xpmMLhGPKV/tKsHDD+bCGXHIh0xN/5gbpOxH7L4fPtAGQ7vqSvUMpwOql+/BOGD2L91xUISOa1FIMm9rmOKRxToeD1tmqp38QKBwdX1wAwjM8V02L8QzzehQ7Mp0Xs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4FC123D6148AD84E861B8D513AC51C44@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee813b0-2c6c-4a76-5f24-08d735b627ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 06:14:36.5278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YnlJ2idbaYluL82I2r98F8Zcy+Ws/Uwt0G8sDCbp5A9Zv40r53PGBlTgG8EuGCOEPJ8domIlGYHhnzBHpXzOYx4LvkZ9GbZ3Viyaxkv+70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA5LTEwIGF0IDA2OjA4ICswMDAwLCBQaGlsaXBwZSBTY2hlbmtlciB3cm90
ZToNCj4gT24gVGh1LCAyMDE5LTA5LTA1IGF0IDE5OjA2ICswMTAwLCBNYXJrIEJyb3duIHdyb3Rl
Og0KPiA+IE9uIFR1ZSwgU2VwIDAzLCAyMDE5IGF0IDA4OjAzOjQ2QU0gKzAwMDAsIFBoaWxpcHBl
IFNjaGVua2VyIHdyb3RlOg0KPiA+ID4gVGhpcyBjb21taXQgYWRkcyB0aGUgcG9zc2liaWxpdHkg
dG8gY2hvb3NlIHRoZSBjb21wYXRpYmxlDQo+ID4gPiAicmVndWxhdG9yLWZpeGVkLWNsb2NrIiBp
biBkZXZpY2V0cmVlLg0KPiA+ID4gDQo+ID4gPiBUaGlzIGlzIGEgc3BlY2lhbCByZWd1bGF0b3It
Zml4ZWQgdGhhdCBoYXMgdG8gaGF2ZSBhIGNsb2NrLCBmcm9tDQo+ID4gPiB3aGljaA0KPiA+ID4g
dGhlIHJlZ3VsYXRvciBnZXRzIHN3aXRjaGVkIG9uIGFuZCBvZmYuDQo+ID4gDQo+ID4gVGhpcyBz
ZWVtcyBjb25jZXB0dWFsbHkgZmluZS4gIE1pbm9yIGlzc3VlcyB0aG91Z2g6DQo+IA0KPiBUaGFu
a3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIEknbSBnbGFkIHlvdSBsaWtlIGl0ISBJIHdpbGwgc2Vu
ZCBhIHYyDQo+IHNob3J0bHksIGFsc28gd2l0aCBSb2IncyBmaXhlcyBpbi4gQ2FuIEkgZXhwZWN0
IGl0IHRvIGJlIHB1bGxlZCBmb3INCj4gNS40Pw0KDQpJIG1lYW50IDUuNSBvZiBjb3Vyc2UuDQoN
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gUGhpbGlwcGUNCj4gDQo+ID4gPiArc3RhdGljIGludCBy
ZWdfY2xvY2tfaXNfZW5hYmxlZChzdHJ1Y3QgcmVndWxhdG9yX2RldiAqcmRldikNCj4gPiA+ICt7
DQo+ID4gPiArCXN0cnVjdCBmaXhlZF92b2x0YWdlX2RhdGEgKnByaXYgPSByZGV2X2dldF9kcnZk
YXRhKHJkZXYpOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAocHJpdi0+Y2xrX2VuYWJsZV9jb3VudGVy
ID4gMCkNCj4gPiA+ICsJCXJldHVybiAxOw0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4g
PiA+ICt9DQo+ID4gDQo+ID4gVGhpcyBjb3VsZCBqdXN0IGJlIHJldHVybiBwcml2LT5jbGtfZW5h
YmxlX2NvdW50ZXIgPiAwIC0gaWRlYWxseSB0aGUNCj4gPiBjbG9jayBBUEkgd291bGQgbGV0IHVz
IHF1ZXJ5IGlmIHRoZSBjbG9jayBpcyBlbmFibGVkIGJ1dCB0aGF0IG1pZ2h0DQo+ID4gYmUNCj4g
PiBhDQo+ID4gYml0IGNvbmZ1c2VkIGFueXdheSBnaXZlbiB0aGF0IGl0J3MgcG9zc2libHkgc2hh
cmVkLg0K
