Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297BBC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC1B20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="qnWewvUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390722AbfDXSGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:06:04 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:64286
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388155AbfDXSGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjagF4bebdGI3tHctPDug8oaSFai7tHLEKsgko1oFyw=;
 b=qnWewvUhOya6TBC102laoQ529BuifdQ8lyqJb2GJ6wVLPBGfHbyJ6ig4NPzXA7soIQW6/jZYYhYgkJl9ImcKfC9HNEQgnTp1EfQuxqUyjDsOvuFT77Iiq5PVKeuWDPRLY7nBZTv9yd3SzB0IcFtKd1gU6YAv0jFfoH1jonLxltE=
Received: from VI1PR05MB5902.eurprd05.prod.outlook.com (20.178.125.223) by
 VI1PR05MB4352.eurprd05.prod.outlook.com (52.133.12.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 18:05:52 +0000
Received: from VI1PR05MB5902.eurprd05.prod.outlook.com
 ([fe80::7dcb:2fef:8f5d:5a65]) by VI1PR05MB5902.eurprd05.prod.outlook.com
 ([fe80::7dcb:2fef:8f5d:5a65%6]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 18:05:52 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "stefanc@marvell.com" <stefanc@marvell.com>,
        "nadavh@marvell.com" <nadavh@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>
Subject: Re: [PATCH net-next v2] net: mvpp2: cls: Add Classification offload
 support
Thread-Topic: [PATCH net-next v2] net: mvpp2: cls: Add Classification offload
 support
Thread-Index: AQHU+alMGCHmeegJL0m0xxs+vFmZxKZKCPGAgADayYCAALmkgA==
Date:   Wed, 24 Apr 2019 18:05:51 +0000
Message-ID: <78f50363899afdd2a5ca2c8895cafa3b6e6c13ce.camel@mellanox.com>
References: <20190423075031.26074-1-maxime.chevallier@bootlin.com>
         <d62a09aa9194784f93d8ca1df6b4607529008a5f.camel@mellanox.com>
         <20190424090123.5089586c@bootlin.com>
In-Reply-To: <20190424090123.5089586c@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 719acb59-651c-4826-d818-08d6c8df7d16
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR05MB4352;
x-ms-traffictypediagnostic: VI1PR05MB4352:
x-microsoft-antispam-prvs: <VI1PR05MB4352C83DB05404E27925A2D8BE3C0@VI1PR05MB4352.eurprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(51914003)(189003)(199004)(66556008)(66476007)(64756008)(66446008)(6916009)(478600001)(2906002)(486006)(2501003)(36756003)(66946007)(73956011)(91956017)(76176011)(102836004)(68736007)(97736004)(7416002)(8676002)(76116006)(5660300002)(66066001)(6506007)(2351001)(26005)(71190400001)(71200400001)(14454004)(186003)(11346002)(446003)(476003)(2616005)(229853002)(58126008)(118296001)(8936002)(4326008)(14444005)(7736002)(86362001)(54906003)(6246003)(305945005)(53936002)(81156014)(99286004)(81166006)(25786009)(6116002)(3846002)(6436002)(316002)(256004)(6512007)(5640700003)(6486002)(134885004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4352;H:VI1PR05MB5902.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c9LU6FFWk9PQlxDM/HdkpmyQzYywBG+EGRBg5LYoBSg6Kdray7bJsZqEk6zuZ0r+PcsiR/+ETA0AIFSbOE+OU/gvNJv+nMPRvf7Wr8FyA5j5U9F60ekxpA5qYhXjffPKVrya7ssZsHKwIvJMk1T5C+FrNk5xctRKutjE1/htbks9WjlAGZn4xI5sY/3UZIQBZ/+UqmLTTVayfk+Of6JAqGzPskWcFNsvEbK7yf9shR25dgr1lNI+LA6fe5hJyOheoJDVA6Q7o0/K72dYDj153ignfzjGMLLSXN1WdWDaM1HlrthtcficAyCcz1Dm5RPo3r/byxE67nkNGZBmMLimKoO2ZhNzFErTlin2sZVUApzPoIUS1BO+IpqMYSLjF9DJVYEm2RgOkr/3A+GJ63Pd+r0fH9/hFDwVN4T5D32xcmY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70F0C2BA2176204DB0AAA87576097048@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719acb59-651c-4826-d818-08d6c8df7d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 18:05:51.9964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA0LTI0IGF0IDA5OjAxICswMjAwLCBNYXhpbWUgQ2hldmFsbGllciB3cm90
ZToNCj4gSGVsbG8gU2FlZWQsDQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXcsDQo+IA0KPiA+
ID4gV2hlbiBpbnNlcnRpbmcgYSBydWxlIGluIGEgZ2l2ZW4gZmxvdywgdGhlIGxvY2F0aW9uIGdp
dmVuIGlzDQo+ID4gPiByZWxhdGl2ZQ0KPiA+ID4gdG8NCj4gPiA+IHRoZSBmbG93IDoNCj4gPiA+
IA0KPiA+ID4gZXRodG9vbCAtTiBldGgwIGZsb3ctdHlwZSB1ZHA0IGRzdC1wb3J0IDEyMzQgYWN0
aW9uIDIgbG9jIDANCj4gPiA+IA0KPiA+ID4gZXRodG9vbCAtTiBldGgwIGZsb3ctdHlwZSB0Y3A0
IGRzdC1wb3J0IDEyMzQgYWN0aW9uIDMgbG9jIDANCj4gPiA+IA0KPiA+ID4gSG93ZXZlciB3aGVu
IHJlbW92aW5nIGEgcnVsZSwgdGhlIGdsb2JhbCBsb2NhdGlvbiBpcyB0byBiZSB1c2VkLg0KPiA+
ID4gVGhpcw0KPiA+ID4gbG9jYXRpb24gY2FuIGJlIHJldHJpZXZlZCBieSB1c2luZyBldGh0b29s
IC1uIDxpbnRlcmZhY2U+Lg0KPiA+ID4gICANCj4gPiANCj4gPiBJIGFtIG5vdCBzdXJlIHdoYXQg
eW91IG1lYW4gYnkgInRoZSBsb2NhdGlvbiBnaXZlbiBpcyByZWxhdGl2ZSB0bw0KPiA+IHRoZQ0K
PiA+IGZsb3ciLCBpdCBzZWVtcyBsaWtlIHRoZSBydWxlIHdpbGwgZW5kIHVwIGluIGEgZGlmZmVy
ZW50IGxvY2F0aW9uDQo+ID4gdGhhbg0KPiA+IHRoZSB1c2VyIGludGVuZGVkLCBidXQgbG9va2lu
ZyBhdCBldGh0b29sIGRvY3VtZW50YXRpb24gaXQgY2xlYXJseQ0KPiA+IHNheXMNCj4gPiB0aGF0
IHRoZSBsb2NhdGlvbiB0aGUgdXNlciBwcm92aWRlcyBpcyBhbiBhYnNvbHV0ZSBydWxlDQo+ID4g
aWQvbG9jYXRpb24sDQo+ID4gd2hpY2ggd2lsbCBiZSB1c2VkIHRvIGRlbGV0ZSB0aGlzIHJ1bGUu
DQo+ID4gDQo+ID4gZnJvbSAibWFuIGV0aHRvb2wiOg0KPiA+IGxvYyBOOg0KPiA+IFNwZWNpZnkg
dGhlIGxvY2F0aW9uL0lEIHRvIGluc2VydCB0aGUgcnVsZS4gVGhpcyB3aWxsIG92ZXJ3cml0ZSBh
bnkNCj4gPiBydWxlIHByZXNlbnQgaW4gdGhhdCBsb2NhdGlvbiBhbmQgd2lsbCBub3QgZ28gdGhy
b3VnaCBhbnkgb2YgdGhlDQo+ID4gcnVsZQ0KPiA+IG9yZGVyaW5nIHByb2Nlc3MuDQo+ID4gDQo+
ID4gZGVsZXRlIE4NCj4gPiBEZWxldGVzIHRoZSBSWCBjbGFzc2lmaWNhdGlvbiBydWxlIHdpdGgg
dGhlIGdpdmVuIElELg0KPiANCj4gSSB3YXMgdW5zdXJlIGFib3V0IHRoaXMsIHNvIEknbSBnbGFk
IHlvdSBjb21tZW50ZWQuIE9uZSB0aGluZw0KPiB0aGF0IG1hZGUgbWUgdGhpbmsgd2hhdCBJIGRp
ZCBjb3VsZCBiZSBva2F5IGlzIHRoYXQgdGhlIGRvY3VtZW50YXRpb24NCj4gZm9yIEVUSFRPT0xf
U1JYQ0xTUkxJTlMgaW4gZXRodG9vbC5oIHNheXMgOg0KPiANCj4gIkZvciAlRVRIVE9PTF9TUlhD
TFNSTElOUywgQGZzIHNwZWNpZmllcyB0aGUgcnVsZSB0byBhZGQgb3IgdXBkYXRlLg0KPiAgQGZz
LkBsb2NhdGlvbiBlaXRoZXIgc3BlY2lmaWVzIHRoZSBsb2NhdGlvbiB0byB1c2Ugb3IgaXMgYSBz
cGVjaWFsDQo+ICBsb2NhdGlvbiB2YWx1ZSB3aXRoICVSWF9DTFNfTE9DX1NQRUNJQUwgZmxhZyBz
ZXQuICBPbiByZXR1cm4sDQo+ICBAZnMuQGxvY2F0aW9uIGlzIHRoZSBhY3R1YWwgcnVsZSBsb2Nh
dGlvbi4iDQo+IA0KPiBJIGludGVycHJldGVkIHRoZSAiT24gcmV0dXJuIFsuLi5dIiBwYXJ0IGFz
IGlmIHdlIGNvdWxkIHJld3JpdGUgdGhlDQo+IGxvY2F0aW9uIGlmIG5lZWRlZCB3aGVuIGluc2Vy
dGluZyBhIHJ1bGUgKGFsdGhvdWdoIGl0IHNlZW1zIGV0aHRvb2wNCj4gZG9lc24ndCBkbyBhbnl0
aGluZyB3aXRoIHRoaXMgcmV0dXJuIHZhbHVlKQ0KPiANCg0KICogRm9yICVFVEhUT09MX0dSWENM
U1JMQ05ULCBAcnVsZV9jbnQgaXMgc2V0IHRvIHRoZSBudW1iZXIgb2YgZGVmaW5lZA0KICogcnVs
ZXMgb24gcmV0dXJuLiAgSWYgQGRhdGEgaXMgbm9uLXplcm8gb24gcmV0dXJuIHRoZW4gaXQgaXMg
dGhlDQogKiBzaXplIG9mIHRoZSBydWxlIHRhYmxlLCBwbHVzIHRoZSBmbGFnICUgaWYgdGhlDQog
KiBkcml2ZXIgc3VwcG9ydHMgYW55IHNwZWNpYWwgbG9jYXRpb24gdmFsdWVzLiAgSWYgdGhhdCBm
bGFnIGlzIG5vdA0KICogc2V0IGluIEBkYXRhIHRoZW4gc3BlY2lhbCBsb2NhdGlvbiB2YWx1ZXMg
c2hvdWxkIG5vdCBiZSB1c2VkLg0KDQpNYXliZSBldGh0b29sIGRvZXNuJ3QgZG8gYW55dGhpbmcg
d2l0aCB0aGUgcmV0dXJuIHZhbHVlLCBidXQgaWYgdGhlDQp1c2VyIGlzIG5vdCB1c2luZyBhbnkg
c3BlY2lhbCBmbGFnLCB0aGVuIHRoZSBpbnRlcnByZXRhdGlvbiBzaG91bGQgYmUNCmFic29sdXRl
IGxvY2F0aW9uL0lEIGFzIHByb3ZpZGVkIGJ5IHRoZSB1c2VyLCBzZWUgYmVsb3cgc2NlbmFyaW8N
CmV4YW1wbGUNCg0KPiBUaGUgcG9pbnQgZm9yIGRvaW5nIHNvIGlzIHRoYXQgd2UgaGF2ZSBhIGNs
ZWFyIHNlcGFyYXRpb24gaW4gb3VyDQo+IGNsYXNzaWZpY2F0aW9uIHRhYmxlcyBiZXR3ZWVuIGRp
ZmZlcmVudCB0cmFmZmljIGNsYXNzZXMsIHNvIHdlIGhhdmUgYQ0KPiByYW5nZSBvZiBlbnRyaWVz
IGZvciB0Y3A0LCBvbmUgZm9yIHVkcDQsIG9uZSBmb3IgdGNwNiwgZXRjLg0KPiANCj4gSGF2aW5n
IGEgImdsb2JhbCIgbG9jYXRpb24gbnVtYmVyaW5nIHNjaGVtZSB3b3VsZCwgSSB0aGluaywgYWxz
byBiZQ0KPiBjb25mdXNpbmcsIHNpbmNlIGl0IHdvdWxkIG1ha2UgdGhlIHVzZXIgdXNlIGxvYyAw
LT43IGZvciB0Y3A0LCBsb2MNCj4gOC0+MTUgZm9yIHVkcDQgYW5kIHNvIG9uLg0KPiANCg0Kd2h5
ID8gZXZlbiB3aXRoIHlvdXIgaHcgY2xlYXIgY2xhc3Mgc2VwYXJhdGlvbiwgdXNlciBjYW4gdXNl
IGFueSBsb2MNCmZvciB1ZHA0IGFuZCB0Y3A0IG9yIGFueSBmbG93IGZvciB0aGF0IG1hdHRlciwg
aW4gY2FzZSB0aGV5IHdvbid0DQpvdmVybGFwLg0KDQpBbmQgaW4gY2FzZSB0aGV5IGRvIG92ZXJs
YXAsIHRoZW4gSSB0aGluayB5b3UgbXVzdCBoYXZlIGEgZ2xvYmFsIA0KbG9jYXRpb24gc2NoZW1l
ISB0YWtlIHRoaXMgc2NlbmFyaW8gZm9yIGluc3RhbmNlOg0KDQpzY2VuYXJpbyAxOg0KbG9jIDAg
aXA0IGFjdGlvbiAyDQpsb2MgMSB1ZHA0IGFjdGlvbiAtMQ0KbG9jIDIgdGNwNCBhY3Rpb24gLTEN
Cg0KVGhpcyBzaG91bGQgcmVzdWx0IG9mIGFsbCB1ZHA0LCB0Y3A0LCBhbmQgaXA0IHRyYWZmaWMg
dG8gZ28gdG8gcnggcmluZw0KMiwgZXZlbiBpZiB0aGUgdXNlciBhc2tlZCB0byBkcm9wIHVkcC90
Y3A0LiBvbmNlIHJ1bGUgYXQgbG9jYXRpb24gMCBpcw0KZGVsZXRlZCB0aGVuIHVkcC90Y3A0IHRy
YWZmaWMgd2lsbCBiZSBkcm9wcGVkLg0KDQpzY2VuYXJpbyAyOg0KbG9jIDAgdWRwNCBhY3Rpb24g
LTENCmxvYyAxIHRjcDQgYWN0aW9uIC0xDQpsb2MgMiBpcDQgYWN0aW9uIDINCg0Kc2hvdWxkIHJl
c3VsdCBpbiBkcm9wcGluZyBhbGwgdXBkNC90Y3A0IGJ1dCBhbGxvdyByZWNlaXZpbmcgaXA0IG9u
IHJpbmcNCjQuDQoNClVzZXIgZG9lc24ndCBzZWUgYW5kIHNob3VsZCBub3Qgc2VlIHlvdXIgaHcg
dGFibGVzIHNjaGVtZSwgaSBmZWVsIHRoYXQNCmZvciBzY2VuYXJpbyAxIHlvdXIgaW1wbGVtZW50
YXRpb24gd2lsbCBkcm9wIHVkcDQgYW5kIHRjcDQgc2luY2UgdGhleQ0Kd2lsbCBiZSBzZXBhcmF0
ZWQgZnJvbSBpcDQgcnVsZSBhdCBsb2MgMCwgd2hpY2ggaXMgbm90IHdoYXQgdGhlIHVzZXINCmV4
cGVjdHMsIHBsZWFzZSBjb3JyZWN0IG1lIGlmIGkgYW0gd3JvbmcuDQoNCnRoYXQgYmVpbmcgc2Fp
ZCwgaSB0aGluayB5b3Ugc2hvdWxkIGtlZXAgdGhlIGdsb2JhbCBsb2NhdGlvbiBzY2hlbWUgYXQN
CmxlYXN0IGZyb20gdXNlciBwZXJzcGVjdGl2ZSBhbmQgcmVzcGVjdCB0aGUgcHJpb3JpdGl6YXRp
b24gb2YgdGhlIHVzZXINCmluc2VydGVkIHJ1bGVzIGVzcGVjaWFsbHkgd2hlbiB0aGVyZSBhcmUg
b3ZlcmxhcHBpbmcuDQoNCmV2ZW4gaWYgdGhlcmUgaXMgbm8gb3ZlcmxhcHBpbmcsIGxvY2F0aW9u
IGNvdWxkIG1lYW46IHByaW9yaXRpZXMgcnVsZXMNCmF0IGxvd2VyIGxvY2F0aW9ucyBpbiBodyBw
cm9jZXNzaW5nIHNvIHRoZXkgY2FuIGdldCBoaWdoZXIgcGVyZm9ybWFuY2UuDQoNCj4gTWF5YmUg
aW4gdGhpcyBjYXNlIEkgc2hvdWxkIHN0aWNrIHdpdGggaW5zZXJ0aW9ucyB0aGF5IHJlbHkgb24N
Cj4gIChzdWNoIGFzICJmaXJzdCIsICJsYXN0IiwgImFueSIpIGFuZCBoYXZlIGEgc2NoZW1lDQo+
IHdoZXJlIHByaW9yaXNhdGlvbiBpcyBiYXNlZCBzdHJpY3RseSBvbiB0aGUgcnVsZSBpbnNlcnRp
b24gb3JkZXIgPw0KPiANCg0KU3VyZSBmb3Igd2hlbiB0aGUgc3BlY2lhbCBmbGFncyBhcmUgc2V0
LCBidXQgeW91IHdpbGwgaGF2ZSB0byByZXBvcnQgDQpSWF9DTFNfTE9DX1NQRUNJQUwgb24gRVRI
VE9PTF9HUlhDTFNSTENOVC4NCg0KYWxzbyBpZiB5b3UgZG9uJ3Qgd2FudCB0byBzdXBwb3J0IHRo
ZSBnbG9iYWwgbG9jYXRpb24gc2NoZW1lIHRoZW4NCnJldHVybiAtRU9QTk9UU1VQUC8tRUlOVkFM
IHdoZW4gdXNlciBzcGVjaWZpZXMgYSBub24gc3BlY2lhbCBsb2NhdGlvbiANCj8NCg0KPiA+IFNv
IHRoZSBhYm92ZSBleGFtcGxlIHNob3VsZCByZXN1bHQgaW4gb25lIGZsb3cgcnVsZSBpbiB5b3Vy
DQo+ID4gaGFyZHdhcmUuDQo+ID4gYnV0IGFjY29yZGluZyB0aGUgY29kZSBiZWxvdyB0aGUgY2Fs
Y3VsYXRlZCBpbmRleCBpbg0KPiA+IG12cHAyX2V0aHRvb2xfY2xzX3J1bGVfaW5zIG1pZ2h0IGVu
ZCB1cCBkaWZmZXJlbnQgdGhhbiB0aGUNCj4gPiByZXF1ZXN0ZWQNCj4gPiBsb2NhdGlvbiwgd2hp
Y2ggd2lsbCBjb25mdXNlIHRoZSB1c2VyLg0KPiANCj4gSSdtIGFsc28gd29ya2luZyBvbiB3cml0
aW5nIGEgcHJvcGVyIGRvY3VtZW50YXRpb24gZm9yIHRoaXMgZHJpdmVyLA0KPiBpbmNsdWRpbmcg
dGhlIGJlaGF2aW91ciBvZiB0aGUgY2xhc3NpZmllciBpbXBsZW1lbnRhdGlvbiwgaG9wZWZ1bGx5
DQo+IHRoaXMgd291bGQgaGVscC4NCj4gDQoNCmhtbSwgaSB0aGluayBhbGwgZHJpdmVyIHNob3Vs
ZCBiZSBhbGlnbmVkIGFuZCBwcm92aWRlIHNhbWUgYmVoYXZpb3IsIGF0DQpsZWFzdCBmb3IgdGhl
IG5vbiBzcGVjaWFsIGZsYWcgdXNlIGNhc2UsDQp2ZW5kb3JzIG11c3QgcmVwb3J0IC1FT1BOT1RT
VVBQT1JUIGlmIGEgc3BlY2lmaWMgdXNlIGNhc2Ugb3BlcmF0aW9uIGlzDQpub3Qgc3VwcG9ydGVk
Lg0KDQo+IFRoYW5rcyBhZ2FpbiBmb3IgdGhlIHJldmlldywNCj4gDQo+IE1heGltZQ0K
