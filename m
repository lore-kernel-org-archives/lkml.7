Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8380C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709362070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="ux0BEoCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfHLIys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:54:48 -0400
Received: from mail-eopbgr140122.outbound.protection.outlook.com ([40.107.14.122]:21103
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfHLIys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:54:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fK+Gvy3nfiDBOpmu0dsGrwG+W4byPbVFyPCDTDir3Zap5gkRCOp7M1BRUr9QkZi+P7LfSn7tSFbVTbcsNeZX/BAqs3msJ7s4gb/XxagPA5/8iJ+a+lMOLSqDmLUk3ow6Gf57wDCL9rFWph63qe5AFvy5vMxtjdz7sYDV+52AMzUnuNMW37MoSwDRTP1x1JUbumPwc7IYK+qtbdXqWywW2DNwUUiVmUBbUn0ofv2qayfhM7ECinHMRzvMuL4djkY1b0xz/c14VX4NneQ9jagt1uTMAiodvquG/tQLazbW34ICG4cVhXWNNGUeWmOkLgU6pnVD/Fs516nu9ckDDJdRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzLwzFTT8sBRJQtlvgWFYmo5dNmiKBkTtxunx6Tn2NQ=;
 b=UhMLSv3l7xaFahkvaPtvNmlm5lyFgQinwXaGaB0/9SW0RdIxjxY3WCWTe+pSuhlj1NUAHNhFGA/nRJ/pAE3N442Dqx2wD43NksFJw3ioHtkkeVVRFwXPp/ALqCJJglHsD99qaJQk3RkOwAyk6lLg8CxW9C4dY1tG/KGHml89mwAP9npVTqL/6HlSz3GDIWAKE4RfUyqQzAU277dHGNFVDPWML1hwcHpocDVOMy/SE6U5hMBMYrszqrP+10vcDDthaIbjN52acpywE0jNHeSOocnqEnWB1uo52tqOCPHQIxG9MaP9MzYnzsNbGYi7zyrEPL4uFxL02Nyeig2hGgTSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzLwzFTT8sBRJQtlvgWFYmo5dNmiKBkTtxunx6Tn2NQ=;
 b=ux0BEoCXcwQSGBvv1+6/c+tKT/G51w/ZhYK0/azQ9RrDL3PWNmOUQe7oDkf8ZS8X5JvSyt0lg7RycbFMXBj9qRZeUyRhsRhfhUaIQu8oO8eyw5SS+vx5ROcD/nzuvCfwfB5DyeLJMcRBm7ge2a/j+GKJwUq1kUFduWu/EIb31oI=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.17.157) by
 VI1PR0502MB2879.eurprd05.prod.outlook.com (10.172.255.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Mon, 12 Aug 2019 08:54:44 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::8405:5b51:b25d:39a2%6]) with mapi id 15.20.2157.022; Mon, 12 Aug 2019
 08:54:44 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "stefan@agner.ch" <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "michal.vokac@ysoft.com" <michal.vokac@ysoft.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v3 17/21] ARM: dts: imx6ull: improve can templates
Thread-Topic: [PATCH v3 17/21] ARM: dts: imx6ull: improve can templates
Thread-Index: AQHVTPnWg3X3des7t06cvcYeXC7Lxaby+aaAgARDkIA=
Date:   Mon, 12 Aug 2019 08:54:43 +0000
Message-ID: <cd5a729891dc88e2d4552d003dc1a1c77b03947a.camel@toradex.com>
References: <20190807082556.5013-1-philippe.schenker@toradex.com>
         <20190807082556.5013-18-philippe.schenker@toradex.com>
         <8ae5742f29f17e61fd9fc39a8dbd1b7c3a2f45b0.camel@toradex.com>
In-Reply-To: <8ae5742f29f17e61fd9fc39a8dbd1b7c3a2f45b0.camel@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 809d5546-01a5-474e-8415-08d71f02b871
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0502MB2879;
x-ms-traffictypediagnostic: VI1PR0502MB2879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0502MB2879C9D2D4715A9A5D2A4EA3F4D30@VI1PR0502MB2879.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 012792EC17
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(39840400004)(366004)(376002)(346002)(189003)(199004)(5660300002)(446003)(6506007)(14444005)(66066001)(6512007)(6486002)(478600001)(6436002)(4326008)(256004)(66476007)(66556008)(64756008)(66446008)(7416002)(486006)(25786009)(14454004)(2201001)(11346002)(76116006)(476003)(44832011)(91956017)(66946007)(36756003)(316002)(2616005)(53936002)(110136005)(71200400001)(71190400001)(118296001)(305945005)(7736002)(76176011)(186003)(54906003)(81166006)(81156014)(2501003)(99286004)(8676002)(102836004)(8936002)(229853002)(26005)(6246003)(6116002)(3846002)(2906002)(86362001)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB2879;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gVJPdn4EEQy9cqg5RhCtxW8MBGB4otG4FCFmVeLUgj/Y2vLoTDX/GWUB/qnCQPR/gJgmo8yUgvDoUfAIuDU/+aMN1NlTbRzscwhw8kHnI9AFE5gPM4SLh6y+k7NBhF4YeuefwplVVv16owRYGSsYtG50T1886ZpchxOEQwq5Ix3qBk0hLPeQc3cmW31DUYureRsifB+B1p9vtV0tDMnmZcIGj7P8zFHaU2BzTKOmkSTvYkKUL3s0LRf3/yntvB0TJEwLNjDp+nM8e607cWP21JO0k5UqxTZNfwgcyL0rQRuxdcOTQtvw87ktoT6jHw/4ch8iIG5si6Caf4rN5lB4v6PpOBwBqmSlvmGegbHsbrmpBDMq7ULSiBxQDQkNu5mTbrkuGlROWKEw2AEV7EydmaaBT92JQ/vkVOUDDVECYuk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C14B383B5E775B4D8048422DF03ECA3C@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 809d5546-01a5-474e-8415-08d71f02b871
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2019 08:54:44.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ8rblpoYz4sv8AF2mJpPuxLV1VhEV0dLUfl2Jg0aM2moNu02mArpX15ODIBdVpeZ9KwxizzN+IbRrVHc7ZigsoZWYxR7jlDP5eq7+hBWbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2879
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA4LTA5IGF0IDE1OjQ3ICswMDAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6
DQo+IEhpIFBoaWxpcHBlDQo+IA0KPiBPbiBXZWQsIDIwMTktMDgtMDcgYXQgMDg6MjYgKzAwMDAs
IFBoaWxpcHBlIFNjaGVua2VyIHdyb3RlOg0KPiA+IEZyb206IE1heCBLcnVtbWVuYWNoZXIgPG1h
eC5rcnVtbWVuYWNoZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gQWRkIHRoZSBwaW5tdXhpbmcg
YW5kIGEgaW5hY3RpdmUgbm9kZSBmb3IgZmxleGNhbjEgb24gU09ESU1NIDU1LzYzDQo+ID4gYW5k
IG1vdmUgdGhlIGluYWN0aXZlIGZsZXhjYW4gbm9kZXMgdG8gaW14NnVsbC1jb2xpYnJpLWV2YWwt
djMuZHRzaQ0KPiA+IHdoZXJlIHRoZXkgYmVsb25nLg0KPiA+IA0KPiA+IE5vdGUgdGhhdCB0aGlz
IGNvbW1pdCBkb2VzIG5vdCBlbmFibGUgZmxleGNhbiBmdW5jdGlvbmFsaXR5LCBidXQNCj4gPiBy
YXRoZXINCj4gPiBlYXNlcyB0aGUgZWZmb3J0IG5lZWRlZCB0byBkbyBzby4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBNYXggS3J1bW1lbmFjaGVyIDxtYXgua3J1bW1lbmFjaGVyQHRvcmFkZXgu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBwZS5zY2hl
bmtlckB0b3JhZGV4LmNvbT4NCj4gPiAtLS0NCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYzOiBOb25l
DQo+ID4gQ2hhbmdlcyBpbiB2MjogTm9uZQ0KPiA+IA0KPiA+ICBhcmNoL2FybS9ib290L2R0cy9p
bXg2dWxsLWNvbGlicmktZXZhbC12My5kdHNpIHwgMTIgKysrKysrKysrKysrDQo+ID4gIGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ub253aWZpLmR0c2kgfCAgMiArLQ0KPiA+ICBh
cmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktd2lmaS5kdHNpICAgIHwgIDIgKy0NCj4g
PiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kgICAgICAgICB8IDE2ICsr
KysrKysrKysrKysrLQ0KPiA+IC0NCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290
L2R0cy9pbXg2dWxsLWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2dWxsLWNvbGlicmktZXZhbC12My5kdHNpDQo+ID4gaW5kZXggYjYxNDdjNzZkMTU5Li4z
YmVlMzdjNzVhYTYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1j
b2xpYnJpLWV2YWwtdjMuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwt
Y29saWJyaS1ldmFsLXYzLmR0c2kNCj4gPiBAQCAtODMsNiArODMsMTggQEANCj4gPiAgCX07DQo+
ID4gIH07DQo+ID4gIA0KPiA+ICsmY2FuMSB7DQo+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiOw0KPiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhjYW4xPjsNCj4gPiArCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmY2FuMiB7DQo+ID4gKwlwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhj
YW4yPjsNCj4gPiArCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gK307DQo+IA0KPiBBcyB0aG9z
ZSBkb24ndCByZWFsbHkgaGF2ZSBhbnl0aGluZyB0byBkbyB3aXRoIHRoZSBldmFsIGJvYXJkDQo+
IGRpcmVjdGx5LA0KPiB3b3VsZG4ndCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8gcmF0aGVyIG1vdmUg
dGhlbSBpbnRvIHRoZSBtb2R1bGUncyBkdHNpDQo+IGp1c3QgbGlrZSB0aGUgcGluIG11eGluZyBm
dXJ0aGVyIGJlbG93Pw0KDQpJIGFncmVlLCBtb3ZlZCBmb3IgdjQuDQoNClRoYW5rcywgUGhpbGlw
cGUNCj4gDQo+ID4gICZpMmMxIHsNCj4gPiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgDQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ub253aWZpLmR0
c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS1ub253aWZpLmR0c2kN
Cj4gPiBpbmRleCBmYjIxM2JlYzQ2NTQuLjk1YTExYjhiY2JkYiAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktbm9ud2lmaS5kdHNpDQo+ID4gKysrIGIv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLW5vbndpZmkuZHRzaQ0KPiA+IEBAIC0x
NSw3ICsxNSw3IEBADQo+ID4gICZpb211eGMgew0KPiA+ICAJcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCj4gPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvMSAmcGluY3RybF9ncGlvMiAm
cGluY3RybF9ncGlvMw0KPiA+IC0JCSZwaW5jdHJsX2dwaW80ICZwaW5jdHJsX2dwaW81ICZwaW5j
dHJsX2dwaW82PjsNCj4gPiArCQkmcGluY3RybF9ncGlvNCAmcGluY3RybF9ncGlvNSAmcGluY3Ry
bF9ncGlvNg0KPiA+ICZwaW5jdHJsX2dwaW83PjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gICZpb211
eGNfc252cyB7DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29s
aWJyaS13aWZpLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29saWJyaS13
aWZpLmR0c2kNCj4gPiBpbmRleCAwMzhkOGM5MGY2ZGYuLmEwNTQ1NDMxYjNkYyAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmktd2lmaS5kdHNpDQo+ID4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLXdpZmkuZHRzaQ0KPiA+IEBA
IC0yNiw3ICsyNiw3IEBADQo+ID4gICZpb211eGMgew0KPiA+ICAJcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4gPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9ncGlvMSAmcGluY3RybF9ncGlv
MiAmcGluY3RybF9ncGlvMw0KPiA+IC0JCSZwaW5jdHJsX2dwaW80ICZwaW5jdHJsX2dwaW81PjsN
Cj4gPiArCQkmcGluY3RybF9ncGlvNCAmcGluY3RybF9ncGlvNSAmcGluY3RybF9ncGlvNz47DQo+
ID4gIA0KPiA+ICB9Ow0KPiA+ICANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwtY29s
aWJyaS5kdHNpDQo+ID4gaW5kZXggZTMyMjAyOThkZDZmLi41NTNkNGMxZjgwZTkgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC1jb2xpYnJpLmR0c2kNCj4gPiArKysg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLWNvbGlicmkuZHRzaQ0KPiA+IEBAIC0yNTYsNiAr
MjU2LDEzIEBADQo+ID4gIAkJPjsNCj4gPiAgCX07DQo+ID4gIA0KPiA+ICsJcGluY3RybF9mbGV4
Y2FuMTogZmxleGNhbjEtZ3JwIHsNCj4gPiArCQlmc2wscGlucyA9IDwNCj4gPiArCQkJTVg2VUxf
UEFEX0VORVQxX1JYX0RBVEEwX19GTEVYQ0FOMV9UWAkweDFiDQo+ID4gMA0KPiA+IDIwDQo+ID4g
KwkJCU1YNlVMX1BBRF9FTkVUMV9SWF9EQVRBMV9fRkxFWENBTjFfUlgJMHgxYg0KPiA+IDANCj4g
PiAyMA0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCXBpbmN0cmxfZmxleGNhbjI6
IGZsZXhjYW4yLWdycCB7DQo+ID4gIAkJZnNsLHBpbnMgPSA8DQo+ID4gIAkJCU1YNlVMX1BBRF9F
TkVUMV9UWF9EQVRBMF9fRkxFWENBTjJfUlgJMHgxYg0KPiA+IDANCj4gPiAyMA0KPiA+IEBAIC0y
NzEsOCArMjc4LDYgQEANCj4gPiAgDQo+ID4gIAlwaW5jdHJsX2dwaW8xOiBncGlvMS1ncnAgew0K
PiA+ICAJCWZzbCxwaW5zID0gPA0KPiA+IC0JCQlNWDZVTF9QQURfRU5FVDFfUlhfREFUQTBfX0dQ
SU8yX0lPMDAJMHg3NA0KPiA+IC8qIFNPRElNTSA1NSAqLw0KPiA+IC0JCQlNWDZVTF9QQURfRU5F
VDFfUlhfREFUQTFfX0dQSU8yX0lPMDEJMHg3NA0KPiA+IC8qIFNPRElNTSA2MyAqLw0KPiA+ICAJ
CQlNWDZVTF9QQURfVUFSVDNfUlhfREFUQV9fR1BJTzFfSU8yNQkwWDE0DQo+ID4gLyogU09ESU1N
IDc3ICovDQo+ID4gIAkJCU1YNlVMX1BBRF9KVEFHX1RDS19fR1BJTzFfSU8xNAkJMHgxNA0KPiA+
IC8qIFNPRElNTSA5OSAqLw0KPiA+ICAJCQlNWDZVTF9QQURfTkFORF9DRTFfQl9fR1BJTzRfSU8x
NAkweDE0IC8qDQo+ID4gU09ESU1NIDEzMyAqLw0KPiA+IEBAIC0zMjUsNiArMzMwLDEzIEBADQo+
ID4gIAkJPjsNCj4gPiAgCX07DQo+ID4gIA0KPiA+ICsJcGluY3RybF9ncGlvNzogZ3BpbzctZ3Jw
IHsgLyogQ0FOMSAqLw0KPiA+ICsJCWZzbCxwaW5zID0gPA0KPiA+ICsJCQlNWDZVTF9QQURfRU5F
VDFfUlhfREFUQTBfX0dQSU8yX0lPMDAJMHg3NA0KPiA+IC8qIFNPRElNTSA1NSAqLw0KPiA+ICsJ
CQlNWDZVTF9QQURfRU5FVDFfUlhfREFUQTFfX0dQSU8yX0lPMDEJMHg3NA0KPiA+IC8qIFNPRElN
TSA2MyAqLw0KPiA+ICsJCT47DQo+ID4gKwl9Ow0KPiA+ICsNCj4gPiAgCXBpbmN0cmxfZ3BtaV9u
YW5kOiBncG1pLW5hbmQtZ3JwIHsNCj4gPiAgCQlmc2wscGlucyA9IDwNCj4gPiAgCQkJTVg2VUxf
UEFEX05BTkRfREFUQTAwX19SQVdOQU5EX0RBVEEwMAkweDEwDQo+ID4gMA0KPiA+IGE5DQo+IA0K
PiBDaGVlcnMNCj4gDQo+IE1hcmNlbA0K
