Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A74BC73C63
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4710F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 02:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3/yneJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfGJC3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 22:29:17 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:61413
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfGJC3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 22:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUhylYQAUibI/PBZndhQZdrgXfSdeExvfg9NpKL3AYc=;
 b=k3/yneJsP1bKXVPLxfXgx4q7Twf3GcqwdA5lWz/4B45GNOaHBP40wL/iXt0hhHJHuPcBJKImdGt9D1YCoqB9WiD/eHGSWtalUIiCsxQhXhHrMf7bnRDZNXcrPLloY4by4g2tESvm3yTaPpij+PW4izwfk8RaSBJMevg630K9fps=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.5.23) by
 VI1PR0402MB3758.eurprd04.prod.outlook.com (52.134.15.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Wed, 10 Jul 2019 02:29:11 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::cddf:10d0:7cb3:c4cc%4]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 02:29:11 +0000
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
Thread-Index: AQHVMnTebEkQdGkfgE+cLXzkUFRHUqa6mimAgAAFbBCAAK/PoIAATbyAgAACa6CAB4nF4A==
Date:   Wed, 10 Jul 2019 02:29:11 +0000
Message-ID: <VI1PR0402MB3600EC453079A1A02BF04401FFF00@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <20190704142015.10701-1-fugang.duan@nxp.com>
        <20190704174543.194a0158@karo-electronics.de>
        <VI1PR0402MB3600D635FF12DC861FAD9BF6FFFA0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
        <VI1PR0402MB360040318C9FB6656B46C566FFF50@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <20190705091235.365b93cb@karo-electronics.de>
 <VI1PR0402MB36002D8F896C5A5033A0DA4AFFF50@VI1PR0402MB3600.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB36002D8F896C5A5033A0DA4AFFF50@VI1PR0402MB3600.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0e1ef52-0ee2-4987-ad0a-08d704de64b1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3758;
x-ms-traffictypediagnostic: VI1PR0402MB3758:
x-microsoft-antispam-prvs: <VI1PR0402MB37580E54F4DBD0F989E26BADFFF00@VI1PR0402MB3758.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(68736007)(71190400001)(71200400001)(53936002)(25786009)(6246003)(66476007)(33656002)(6436002)(66446008)(9686003)(478600001)(229853002)(446003)(66574012)(55016002)(4326008)(54906003)(64756008)(6116002)(86362001)(8936002)(11346002)(2906002)(8676002)(305945005)(256004)(66066001)(316002)(3846002)(81156014)(76176011)(74316002)(26005)(81166006)(486006)(186003)(5660300002)(6506007)(76116006)(7736002)(7696005)(14454004)(66946007)(102836004)(52536014)(6916009)(476003)(66556008)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3758;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W+PQdTzZ5U7wN+9KB74FWtFBs6PmOgqi0HNvKZz/Baij6YpzYBXNSZGkYjdvcwDRcij7y6rPv+LoZT7j3I558/2GvUP7EB40JEM5665nOhidQF3dE12RF21LNSliLK5vufH7WWtl6bj1oU+P0E63wtKWX5239SyPy4tTpAo+vORdmjclAOHj9uhR4N7q9AAQ+VYgpzFEvYmxGzos28r4YTw+kPODHq4Wip7l6Phh/C/GN+kpXRGR0Vl957nQufznb2OUqxhm3phRnUtAeD9ixN72qP2NFAXn34InSSuqMOlEpg/C5mcbY52CGxAIual4fJ+F1XBLchUXnkDAsb5mJKa3eDoX2OqIZAzKRnO3ZSd+ncoWByUk560j4EQwhYnnDzL/jsbqtwe6Gz+kdgQBk7690vWgckNknuGAbAw0fmA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e1ef52-0ee2-4987-ad0a-08d704de64b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 02:29:11.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fugang.duan@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3758
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBEdWFuIFNlbnQ6IEZyaWRheSwgSnVseSA1LCAyMDE5IDM6MzMgUE0NCj4gRnJv
bTogTG90aGFyIFdhw59tYW5uIDxMV0BLQVJPLWVsZWN0cm9uaWNzLmRlPiBTZW50OiBGcmlkYXks
IEp1bHkgNSwgMjAxOQ0KPiAzOjEzIFBNDQo+ID4gSGksDQo+ID4NCj4gPiBPbiBGcmksIDUgSnVs
IDIwMTkgMDI6NDY6MzIgKzAwMDAgQW5keSBEdWFuIHdyb3RlOg0KPiA+ID4gRnJvbTogQW5keSBE
dWFuIFNlbnQ6IEZyaWRheSwgSnVseSA1LCAyMDE5IDEyOjA4IEFNDQo+ID4gPiA+IEZyb206IExv
dGhhciBXYcOfbWFubiA8TFdAS0FSTy1lbGVjdHJvbmljcy5kZT4gU2VudDogVGh1cnNkYXksDQo+
IEp1bHkNCj4gPiA+ID4gNCwNCj4gPiA+ID4gMjAxOSAxMTo0NiBQTQ0KPiA+ID4gPiA+IEhpLA0K
PiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVGh1LCAgNCBKdWwgMjAxOSAyMjoyMDoxNSArMDgwMCBm
dWdhbmcuZHVhbkBueHAuY29tIHdyb3RlOg0KPiA+ID4gPiA+ID4gRnJvbTogRnVnYW5nIER1YW4g
PGZ1Z2FuZy5kdWFuQG54cC5jb20+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gaU1YOCBmdXNl
IHdvcmQgaW5kZXggcmVwcmVzZW50IGFzIG9uZSA0LWJ5dGVzIHdvcmQsIGl0IHNob3VsZA0KPiA+
ID4gPiA+ID4gbm90IGJlIGRpdmlkZWQgYnkgNC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBF
eHA6DQo+ID4gPiA+ID4gPiAtIE1BQzAgYWRkcmVzcyBsYXlvdXQgaW4gZnVzZToNCj4gPiA+ID4g
PiA+IG9mZnNldCA3MDg6IE1BQ1szXSBNQUNbMl0gTUFDWzFdIE1BQ1swXQ0KPiA+ID4gPiA+ID4g
b2Zmc2V0IDcwOTogWFggICAgIHh4ICAgICBNQUNbNV0gTUFDWzRdDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRnVnYW5nIER1YW4gPGZ1Z2FuZy5kdWFuQG54cC5jb20+
DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL252bWVtL2lteC1vY290cC1z
Y3UuYyB8IDYgKysrLS0tDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9udm1lbS9pbXgtb2NvdHAtc2N1LmMNCj4gPiA+ID4gPiA+IGIvZHJpdmVycy9u
dm1lbS9pbXgtb2NvdHAtc2N1LmMgaW5kZXggZDlkYzQ4Mi4uYmUyZjVmMCAxMDA2NDQNCj4gPiA+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvbnZtZW0vaW14LW9jb3RwLXNjdS5jDQo+ID4gPiA+ID4gPiAr
KysgYi9kcml2ZXJzL252bWVtL2lteC1vY290cC1zY3UuYw0KPiA+ID4gPiA+ID4gQEAgLTcxLDgg
KzcxLDggQEAgc3RhdGljIGludCBpbXhfc2N1X29jb3RwX3JlYWQodm9pZCAqY29udGV4dCwNCj4g
PiA+ID4gPiA+IHVuc2lnbmVkDQo+ID4gPiA+ID4gaW50IG9mZnNldCwNCj4gPiA+ID4gPiA+ICAg
ICAgIHZvaWQgKnA7DQo+ID4gPiA+ID4gPiAgICAgICBpbnQgaSwgcmV0Ow0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IC0gICAgIGluZGV4ID0gb2Zmc2V0ID4+IDI7DQo+ID4gPiA+ID4gPiAtICAg
ICBudW1fYnl0ZXMgPSByb3VuZF91cCgob2Zmc2V0ICUgNCkgKyBieXRlcywgNCk7DQo+ID4gPiA+
ID4gPiArICAgICBpbmRleCA9IG9mZnNldDsNCj4gPiA+ID4gPiA+ICsgICAgIG51bV9ieXRlcyA9
IHJvdW5kX3VwKGJ5dGVzLCA0KTsNCj4gPiA+ID4gPiA+ICAgICAgIGNvdW50ID0gbnVtX2J5dGVz
ID4+IDI7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgaWYgKGNvdW50ID4gKHByaXYt
PmRhdGEtPm5yZWdzIC0gaW5kZXgpKSBAQCAtMTAwLDcNCj4gPiA+ID4gPiA+ICsxMDAsNyBAQCBz
dGF0aWMgaW50IGlteF9zY3Vfb2NvdHBfcmVhZCh2b2lkICpjb250ZXh0LCB1bnNpZ25lZA0KPiBp
bnQgb2Zmc2V0LA0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBidWYrKzsNCj4gPiA+ID4gPiA+
ICAgICAgIH0NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiAtICAgICBtZW1jcHkodmFsLCAodTgg
KilwICsgb2Zmc2V0ICUgNCwgYnl0ZXMpOw0KPiA+ID4gPiA+ID4gKyAgICAgbWVtY3B5KHZhbCwg
KHU4ICopcCwgYnl0ZXMpOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ICAgICAgIGtmcmVlKHAp
Ow0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiBXaXRoIHRoZXNlIGNoYW5nZXMgeW91IGNvdWxkIHVz
ZSB0aGUgJ3ZhbCcgcG9pbnRlciBkaXJlY3RseSBhcw0KPiA+ID4gPiA+IHRoZSBkZXN0aW5hdGlv
biBmb3Igb2NvdHBfcmVhZCgpIHdpdGhvdXQgbmVlZCBmb3IgYW4gaW50ZXJtZWRpYXRlDQo+IGJ1
ZmZlci4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTG90aGFyIFdhw59tYW5uDQo+
ID4gPiA+DQo+ID4gPiA+IFlvdSBhcmUgcmlnaHQsIGluIGZhY3QsIHdlIGNhbiByZW1vdmUgInAi
IGFuZCAiYnVmIiBwb2ludGVyLg0KPiA+ID4gPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdp
bGwgc2VuZCBvdXQgdGhlIFYyLg0KPiA+ID4NCj4gPiA+IEhpIExvdGhhciwNCj4gPiA+DQo+ID4g
PiBJdCBzdGlsbCBuZWVkIGludGVybWVkaWF0ZSBidWZmZXIgdG8gcmVhZCBvdXQgbiB3b3JkcyAo
biAqIDQgYnl0ZXMpDQo+ID4gPiBmcm9tDQo+ID4gZUZ1c2UuDQo+ID4gPiBCZWNhdXNlICd2YWwn
IGJ1ZmZlciBzaXplIGlzIHJlYWwgY291bnQgcGFyc2VkIGZyb20gRFQsIHdoaWNoIGlzIG5vdA0K
PiA+ID4gYW4gaW50ZWdlcg0KPiA+IG11bHRpcGxlIG9mIDQuDQo+ID4gPg0KPiA+ID4gRm9yIGV4
YW1wbGUsIGNlbGwtPmJ5dGVzIGlzIHBhcnNlZCBmcm9tICJyZWciIHByb3BlcnR5IGFuZCBpdCBp
cw0KPiA+ID4gcmVhbCBjb3VudA0KPiA+IGxpa2UgNi4NCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGZlY19tYWMwOiBtYWNAMmM0IHsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmVnID0gPDB4MmM0IDY+Ow0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gPiA+DQo+ID4gPiBTbyB3ZSBoYXZlIHRvIHVzZSBpbnRlcm1lZGlhdGUgYnVmZmVyIGhl
cmUuDQo+ID4gPg0KPiA+IHZhbCBpcyBhIHUzMiBwb2ludGVyLCBzbyBsZWdhbGx5IGl0IGNhbm5v
dCBwb2ludCB0byBhbnkgYnVmZmVyIHdob3NlDQo+ID4gc2l6ZSBpcyBub3QgZGl2aXNpYmxlIGJ5
IGZvdXIhDQo+ID4NCj4gWWVzLCB2YWwgaXMgYSB1MzIgcG9pbnRlciwgYXMgbXkgdW5kZXJzdGFu
ZCwgaXQgcG9pbnQgdG8gdGhlICdidWYnIHdob3NlIHNpemUgaXMNCj4gY2VsbC0+Ynl0ZXMgKHRo
ZSBzaXplIGlzIG5vdCBwYXJzZWQgZnJvbSAncmVnJyBwcm9wZXJ0eSkNCj4gDQo+IFRoZSBwaWVj
ZSBvZiBjb2RlOg0KPiBidWYgPSBremFsbG9jKGNlbGwtPmJ5dGVzLCBHRlBfS0VSTkVMKTsNCj4g
bnZtZW1fcmVnX3JlYWQobnZtZW0sIGNlbGwtPm9mZnNldCwgYnVmLCBjZWxsLT5ieXRlcyk7DQo+
IGlteF9zY3Vfb2NvdHBfcmVhZCh2b2lkICpjb250ZXh0LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB2
b2lkICp2YWwsIHNpemVfdA0KPiBieXRlcyk7DQo+IA0KPiBJZiBzbywgd2Ugc3RpbGwgbmVlZCBp
bnRlcm1lZGlhdGUgYnVmZmVyIHRvIHJlYWQgb3V0IGVGdXNlIHdvcmRzLCBhbmQgY29weQ0KPiAn
Y2VsbC0+Ynl0ZXMnDQo+IGJ5dGVzIHRvICd2YWwnIGJ1ZmZlci4NCj4gTWF5IEkgdW5kZXJzdGFu
ZCB3cm9uZyA/IFRoYW5rcyB2ZXJ5IG11Y2ghDQoNCkxvdGhhciwgYW55IGNvbW1lbnQgPyBUaGFu
a3MgIQ0K
