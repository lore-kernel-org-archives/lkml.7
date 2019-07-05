Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D57C0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483C421852
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 02:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CXoqteSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfGECqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 22:46:37 -0400
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:19742
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbfGECqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 22:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqFZByzebWWk4LCuAOHcGxLzQtyDGu68w33Dc0Ghb4A=;
 b=CXoqteSQVniml4O5SqmBn3It9MJ6d9f+psiMmxj/NEt2bRM4mXbqr/nOVSm4pybXBIws9h+FHHr4cj2OjkP1DQWH8l0C+FZvaMjYvH4psl/RAcFa/m9Fg7UOIzI0MB7ypqI4KvAgLMKplo9W7XktOl60WtgqvikEBi5/O73wxRs=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB2928.eurprd04.prod.outlook.com (10.175.24.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 02:46:32 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc%4]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 02:46:32 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>
CC:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: correct the fuse word
 index
Thread-Topic: [EXT] Re: [PATCH nvmem 1/1] nvmem: imx: correct the fuse word
 index
Thread-Index: AQHVMnTebEkQdGkfgE+cLXzkUFRHUqa6mimAgAAFbBCAAK/PoA==
Date:   Fri, 5 Jul 2019 02:46:32 +0000
Message-ID: <VI1PR0402MB360040318C9FB6656B46C566FFF50@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704142015.10701-1-fugang.duan@nxp.com>
 <20190704174543.194a0158@karo-electronics.de>
 <VI1PR0402MB3600D635FF12DC861FAD9BF6FFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB3600D635FF12DC861FAD9BF6FFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5fdcaf10-eb66-4408-b42b-08d700f2fd52
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2928;
x-ms-traffictypediagnostic: VI1PR0402MB2928:
x-microsoft-antispam-prvs: <VI1PR0402MB29287BD94E901C7F2D128C78FFF50@VI1PR0402MB2928.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(6246003)(74316002)(476003)(316002)(52536014)(86362001)(14454004)(54906003)(6116002)(229853002)(11346002)(305945005)(486006)(4326008)(7736002)(478600001)(25786009)(66476007)(5660300002)(73956011)(446003)(66946007)(76116006)(64756008)(33656002)(66574012)(71200400001)(66556008)(71190400001)(66446008)(3846002)(7696005)(26005)(2906002)(102836004)(99286004)(76176011)(6916009)(9686003)(81156014)(81166006)(53936002)(8676002)(6436002)(55016002)(68736007)(66066001)(8936002)(6506007)(256004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2928;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZHG6Zsw+Kw8vdXPvjGcNHZodRV4l/eYmiVWXK+1Mw8O8YmG1M/5TwqhHkFP/k3iZkT466hFfdOV4f3DCbYwfjXUF5Jh2DROcOnIleW/gg3FSgLeM/Mc9EF90YjD2qmVPpWVMAe8nDxpWvFFelXoawE3YpcX3gC+weZ2xXQoHbCKunznoypycrz6kymq25k7UYW2gTHaKKdYczaHbduOivhJXEV3Dih0xKT7Tivzhdht93luG7iusUEzPbbAsqZVnaloMyqoaYRpyoz5HaMRGoaSzJ4SGMhZH8o3Szzm++Jk8D7GWtyoNE0xSraZEbGTnxQB/2w1TM4YPBegi6ORU8ZNt5HepRC70x1N2zp03exWF8OmjGHk9MQ/A8WEA8gPQYNN7QNP4qEFjmhObyM7TB9NnJAuCePpe5z+aPHON1Qc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdcaf10-eb66-4408-b42b-08d700f2fd52
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 02:46:32.7426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2928
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBEdWFuIFNlbnQ6IEZyaWRheSwgSnVseSA1LCAyMDE5IDEyOjA4IEFNDQo+IEZy
b206IExvdGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4gU2VudDogVGh1cnNk
YXksIEp1bHkgNCwNCj4gMjAxOSAxMTo0NiBQTQ0KPiA+IEhpLA0KPiA+DQo+ID4gT24gVGh1LCAg
NCBKdWwgMjAxOSAyMjoyMDoxNSArMDgwMCBmdWdhbmcuZHVhbkBueHAuY29tIHdyb3RlOg0KPiA+
ID4gRnJvbTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gPg0KPiA+ID4g
aU1YOCBmdXNlIHdvcmQgaW5kZXggcmVwcmVzZW50IGFzIG9uZSA0LWJ5dGVzIHdvcmQsIGl0IHNo
b3VsZCBub3QgYmUNCj4gPiA+IGRpdmlkZWQgYnkgNC4NCj4gPiA+DQo+ID4gPiBFeHA6DQo+ID4g
PiAtIE1BQzAgYWRkcmVzcyBsYXlvdXQgaW4gZnVzZToNCj4gPiA+IG9mZnNldCA3MDg6IE1BQ1sz
XSBNQUNbMl0gTUFDWzFdIE1BQ1swXQ0KPiA+ID4gb2Zmc2V0IDcwOTogWFggICAgIHh4ICAgICBN
QUNbNV0gTUFDWzRdDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogRnVnYW5nIER1YW4gPGZ1
Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL252bWVtL2lteC1v
Y290cC1zY3UuYyB8IDYgKysrLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lbS9pbXgtb2NvdHAtc2N1LmMNCj4gPiA+IGIvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1
LmMgaW5kZXggZDlkYzQ4Mi4uYmUyZjVmMCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbnZt
ZW0vaW14LW9jb3RwLXNjdS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL252bWVtL2lteC1vY290cC1z
Y3UuYw0KPiA+ID4gQEAgLTcxLDggKzcxLDggQEAgc3RhdGljIGludCBpbXhfc2N1X29jb3RwX3Jl
YWQodm9pZCAqY29udGV4dCwNCj4gPiA+IHVuc2lnbmVkDQo+ID4gaW50IG9mZnNldCwNCj4gPiA+
ICAgICAgIHZvaWQgKnA7DQo+ID4gPiAgICAgICBpbnQgaSwgcmV0Ow0KPiA+ID4NCj4gPiA+IC0g
ICAgIGluZGV4ID0gb2Zmc2V0ID4+IDI7DQo+ID4gPiAtICAgICBudW1fYnl0ZXMgPSByb3VuZF91
cCgob2Zmc2V0ICUgNCkgKyBieXRlcywgNCk7DQo+ID4gPiArICAgICBpbmRleCA9IG9mZnNldDsN
Cj4gPiA+ICsgICAgIG51bV9ieXRlcyA9IHJvdW5kX3VwKGJ5dGVzLCA0KTsNCj4gPiA+ICAgICAg
IGNvdW50ID0gbnVtX2J5dGVzID4+IDI7DQo+ID4gPg0KPiA+ID4gICAgICAgaWYgKGNvdW50ID4g
KHByaXYtPmRhdGEtPm5yZWdzIC0gaW5kZXgpKSBAQCAtMTAwLDcgKzEwMCw3IEBADQo+ID4gPiBz
dGF0aWMgaW50IGlteF9zY3Vfb2NvdHBfcmVhZCh2b2lkICpjb250ZXh0LCB1bnNpZ25lZCBpbnQg
b2Zmc2V0LA0KPiA+ID4gICAgICAgICAgICAgICBidWYrKzsNCj4gPiA+ICAgICAgIH0NCj4gPiA+
DQo+ID4gPiAtICAgICBtZW1jcHkodmFsLCAodTggKilwICsgb2Zmc2V0ICUgNCwgYnl0ZXMpOw0K
PiA+ID4gKyAgICAgbWVtY3B5KHZhbCwgKHU4ICopcCwgYnl0ZXMpOw0KPiA+ID4NCj4gPiA+ICAg
ICAgIGtmcmVlKHApOw0KPiA+ID4NCj4gPiBXaXRoIHRoZXNlIGNoYW5nZXMgeW91IGNvdWxkIHVz
ZSB0aGUgJ3ZhbCcgcG9pbnRlciBkaXJlY3RseSBhcyB0aGUNCj4gPiBkZXN0aW5hdGlvbiBmb3Ig
b2NvdHBfcmVhZCgpIHdpdGhvdXQgbmVlZCBmb3IgYW4gaW50ZXJtZWRpYXRlIGJ1ZmZlci4NCj4g
Pg0KPiA+DQo+ID4gTG90aGFyIFdhw59tYW5uDQo+IA0KPiBZb3UgYXJlIHJpZ2h0LCBpbiBmYWN0
LCB3ZSBjYW4gcmVtb3ZlICJwIiBhbmQgImJ1ZiIgcG9pbnRlci4NCj4gVGhhbmtzIGZvciB5b3Vy
IHJldmlldywgSSB3aWxsIHNlbmQgb3V0IHRoZSBWMi4NCg0KSGkgTG90aGFyLA0KDQpJdCBzdGls
bCBuZWVkIGludGVybWVkaWF0ZSBidWZmZXIgdG8gcmVhZCBvdXQgbiB3b3JkcyAobiAqIDQgYnl0
ZXMpIGZyb20gZUZ1c2UuDQpCZWNhdXNlICd2YWwnIGJ1ZmZlciBzaXplIGlzIHJlYWwgY291bnQg
cGFyc2VkIGZyb20gRFQsIHdoaWNoIGlzIG5vdCBhbiBpbnRlZ2VyIG11bHRpcGxlIG9mIDQuDQoN
CkZvciBleGFtcGxlLCBjZWxsLT5ieXRlcyBpcyBwYXJzZWQgZnJvbSAicmVnIiBwcm9wZXJ0eSBh
bmQgaXQgaXMgcmVhbCBjb3VudCBsaWtlIDYuDQogICAgICAgICAgICAgICAgICAgICAgICBmZWNf
bWFjMDogbWFjQDJjNCB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDww
eDJjNCA2PjsNCiAgICAgICAgICAgICAgICAgICAgICAgIH07IA0KDQpTbyB3ZSBoYXZlIHRvIHVz
ZSBpbnRlcm1lZGlhdGUgYnVmZmVyIGhlcmUuDQo=
