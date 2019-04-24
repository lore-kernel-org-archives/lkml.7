Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A19C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134D8208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="jPAltHVl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbfDXQIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:08:19 -0400
Received: from mail-eopbgr140055.outbound.protection.outlook.com ([40.107.14.55]:18011
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729027AbfDXQIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpCAjwGucBwjrXssGVDfNm/2Y246dcR70OkyCUr6abA=;
 b=jPAltHVloefK92/YLOFrgX/KE7rksPAjDIpsTo43ATcXxD2kpHwR/lSAEQOum7WMB1Gz0kS9PVOXDwnzrjv5xomkny8yIb/DJKKkRxujY8AEDPJyrEg86VGPhi7gTyTplOl+U0sBvBvhAkMospe9tZQuRpOrLgdo+i6OgIVgirY=
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com (20.178.84.149) by
 DB7PR08MB3611.eurprd08.prod.outlook.com (20.177.120.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 16:08:15 +0000
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::fdd5:e065:ed96:45da]) by DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::fdd5:e065:ed96:45da%3]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 16:08:15 +0000
From:   Raphael Gault <Raphael.Gault@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [PATCH 0/6] objtool: Add support for Arm64
Thread-Topic: [PATCH 0/6] objtool: Add support for Arm64
Thread-Index: AQHU7tucgWhyorPOJEqTsRwCtBB+aqZKVAuAgAE+FQA=
Date:   Wed, 24 Apr 2019 16:08:15 +0000
Message-ID: <e256ae12-bba0-fc39-6d14-89cb89d31a25@arm.com>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190423210947.b2qomzj3qb4pzfr5@treble>
In-Reply-To: <20190423210947.b2qomzj3qb4pzfr5@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0225.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::21) To DB7PR08MB3865.eurprd08.prod.outlook.com
 (2603:10a6:10:32::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c564e95-8a73-49d2-5fed-08d6c8cf0eb0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB3611;
x-ms-traffictypediagnostic: DB7PR08MB3611:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB7PR08MB3611D6370C072615E03A0033ED3C0@DB7PR08MB3611.eurprd08.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(40434004)(199004)(189003)(11346002)(66946007)(26005)(73956011)(66476007)(66556008)(66066001)(66446008)(64756008)(2616005)(486006)(6116002)(3846002)(14454004)(186003)(5660300002)(476003)(6916009)(6506007)(386003)(446003)(229853002)(76176011)(86362001)(2906002)(966005)(99286004)(53546011)(31696002)(102836004)(52116002)(25786009)(6486002)(72206003)(31686004)(71190400001)(53936002)(36756003)(305945005)(68736007)(478600001)(8936002)(97736004)(4326008)(54906003)(5024004)(81166006)(8676002)(14444005)(81156014)(256004)(44832011)(6306002)(316002)(7736002)(71200400001)(6436002)(6512007)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB3611;H:DB7PR08MB3865.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yuag40ir65NwykgwmX8tPIN+mUKw44f8f+U/fyOr0uF2oiA3lXoGytHv7ezZwUCOas3XneGenlPn1Hy/KA58mLdeUMjEYTMMkDQ+hprt6zbHIIW2HVX4P3JlfR4MlRejEvYCDH3RXQOLPuwArv1zX3RB4qGsD5F2aqaMcWQAbf8qb4IV72uDpprgAPn+hKd+rXrd5YFkFp0Hwi/MtBUTshi8ZwHl4jzwx7ImZfGr8PQKHTeUA4bF28g0DIpvE+vLyEplrST5WdsBobUxyMncTxpSid83OQvPGiiV91Vp9fYmUmXBCUBHAz5v7q1e1TVOg/rrdaLvWhAVAabaABWd9I0Pig+hpEfTdzlxZ2MCPMAwroFj3XUqwSmQ70Xu2jYYKIriaEY43SMrlgC5oCFe/zyyAzK5VUY88JXl2vNL96c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2450D06978B175418E89AC1283560D73@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c564e95-8a73-49d2-5fed-08d6c8cf0eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 16:08:15.2521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zaCwNCg0KT24gNC8yMy8xOSAxMDowOSBQTSwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+
IE9uIFR1ZSwgQXByIDA5LCAyMDE5IGF0IDAyOjUyOjM3UE0gKzAxMDAsIFJhcGhhZWwgR2F1bHQg
d3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBBcyBvZiBub3csIG9ianRvb2wgb25seSBzdXBwb3J0cyB0
aGUgeDg2XzY0IGFyY2hpdGVjdHVyZSBidXQgdGhlDQo+PiBncm91bmR3b3JrIGhhcyBhbHJlYWR5
IGJlZW4gZG9uZSBpbiBvcmRlciB0byBhZGQgc3VwcG9ydCBmb3Igb3RoZXINCj4+IGFyY2hpdGVj
dHVyZSB3aXRob3V0IHRvbyBtdWNoIGVmZm9ydC4NCj4+DQo+PiBUaGlzIHNlcmllcyBvZiBwYXRj
aGVzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIGFybTY0IGFyY2hpdGVjdHVyZQ0KPj4gYmFzZWQgb24g
dGhlIEFybXY4LjUgQXJjaGl0ZWN0dXJlIFJlZmVyZW5jZSBNYW51YWwuDQo+Pg0KPj4gKiBQYXRj
aCAxIGFkYXB0cyB0aGUgZXhpc3RpbmcgY29kZSB0byBiZSBhYmxlIHRvIGFkZCBzdXBwb3J0IGZv
ciBvdGhlcg0KPj4gICAgYXJjaGl0ZWN0dXJlLg0KPj4gKiBQYXRjaCAyIHByb3ZpZGUgaW1wbGVt
ZW50YXRpb24gb2YgdGhlIHJlcXVpcmVkIGZ1bmN0aW9uIGZvciB0aGUgYXJtNjQNCj4+ICAgIGFy
Y2hpdGVjdHVyZS4NCj4+ICogUGF0Y2ggMyBhZGFwdHMgdGhlIGNoZWNraW5nIG9mIHRoZSBzdGFj
ayBzdGF0ZSBmb3IgdGhlIGFybTY0DQo+PiAgICBhcmNoaXRlY3R1cmUuDQo+PiAqIFBhdGNoIDQg
JiA1IGZpeCBzb21lIHdhcm5pbmcgb2JqdG9vbCByYWlzZWQgaW4gc29tZSBwYXJ0aWN1bGFyDQo+
PiAgICBmdW5jdGlvbnMgb2Ygfi9hcmNoL2FybTY0L2tlcm5lbC9zbGVlcC5TLiBQYXRjaCA0IGFk
ZCBhIG1hY3JvIHRvDQo+PiAgICBzaWduYWwgdGhhdCBzb21lIGZ1bmN0aW9uIHNob3VsZCBiZSBp
Z25vcmVkIGJ5IG9ianRvb2wuDQo+PiAqIFBhdGNoIDYgZW5hYmxlcyBzdGFjayB2YWxpZGF0aW9u
IGZvciBhcm02NC4NCj4+DQo+PiBUaGVzZXMgcGF0Y2hlcyBzaG91bGQgcHJvdmlkZSBzdXBwb3J0
IGZvciB0aGUgbWFpbiBjYXNlcyBhbmQgYmVoYXZpb3VyLg0KPj4gSG93ZXZlciBhIGZldyBjb3Ju
ZXIgY2FzZXMgYXJlIG5vdCB5ZXQgaGFuZGxlZCBieSBvYmp0b29sOg0KPj4NCj4+ICogSW4gdGhl
IGB+L2FyY2gvYXJtNjQvY3J5cHRvL2AgZGlyZWN0b3J5LCBJIG5vdGljZWQgdGhhdCBzb21lIHBs
YWluDQo+PiAgICBkYXRhIGFyZSBzb21ldGltZXMgc3RvcmVkIGluIHRoZSBgLnRleHRgIHNlY3Rp
b24gY2F1c2luZyBvYmp0b29sIHRvIG1pc3Rha2UNCj4+ICAgIHRoaXMgZm9yIGluc3RydWN0aW9u
cyBhbmQgdHJ5aW5nIChhbmQgZmFpbGluZykgdG8gaW50ZXJwcmV0ZSB0aGVtLiAgSWYgc29tZW9u
ZQ0KPj4gICAgY291bGQgZXhwbGFpbiB0byBtZSB3aHkgd2Ugc3RvcmUgZGF0YSBkaXJlY3RseSBp
biB0aGUgLnRleHQgc2VjdGlvbiBJIHdvdWxkDQo+PiAgICBhcHByZWNpYXRlIGl0Lg0KPg0KPiBJ
IGhhdmVuJ3QgbG9va2VkLCBidXQgaXQgc2hvdWxkIHByb2JhYmx5IGJlIG1vdmVkIHRvIC5yb2Rh
dGEuICBXZSBoYWQNCj4gY2FzZXMgbGlrZSB0aGF0IGZvciB4ODYuDQo+DQo+PiAqIEluIHRoZSBz
dXBwb3J0IGZvciBhcm0zMiBhcmNoaXRlY3R1cmUgc3VjaCBhcyBpbiBgfi9hcmNoL2FybTY0L2tl
cm5lbC9rdXNlcjMyLlNgDQo+PiAgICBzb21lIEEzMiBpbnN0cnVjdGlvbnMgYXJlIHVzZWQgYnV0
IHN1Y2ggaW5zdHJ1Y3Rpb25zIGFyZSBub3QgdW5kZXJzdG9vZCBieQ0KPj4gICAgb2JqdG9vbCBj
YXVzaW5nIGEgd2FybmluZy4NCj4+DQo+PiBJIGFsc28gaGF2ZSBhIGZldyB1bmNsZWFyIHBvaW50
cyBJIHdvdWxkIGxpa2UgdG8gYnJpbmcgdG8geW91cg0KPj4gYXR0ZW50aW9uOg0KPj4NCj4+ICog
Rm9yIHg4Nl82NCwgd2hlbiBsb29raW5nIGZvciBhIHN5bWJvbCByZWxvY2F0aW9uIHdpdGggZXhw
bGljaXQNCj4+ICAgIGFkZGVuZCwgb2JqdG9vbCBzeXN0ZW1hdGljYWxseSBhZGRzIGEgKzQgb2Zm
c2V0IHRvIHRoZSBhZGRlbmQuDQo+PiAgICBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IGV2ZW4gaWYg
SSBoYXZlIGEgZmVlbGluZyBpdCBpcyByZWxhdGVkDQo+PiAgICB0byB0aGUgdHlwZSBvZiByZWxh
Y2F0aW9uLg0KPg0KPiBUaGlzIGlzIGJlY2F1c2Ugb2YgaG93IHJlbGF0aXZlIGNhbGwvanVtcCBh
ZGRyZXNzZXMgYXJlIGltcGxlbWVudGVkIG9uDQo+IHg4Ni4gIEl0IGNhbGN1bGF0ZXMgdGhlIGNh
bGwvanVtcCBkZXN0aW5hdGlvbiBieSBhZGRpbmcgdGhlIGVuY29kZWQgb2Zmc2V0DQo+IHRvIHRo
ZSAqZW5kaW5nKiBhZGRyZXNzIG9mIHRoZSBpbnN0cnVjdGlvbiwgcmF0aGVyIHRoYW4gdG8gdGhl
IGFkZHJlc3MNCj4gb2YgdGhlIGVuY29kZWQgb2Zmc2V0IGl0c2VsZi4NCj4NCj4gRm9yIGV4YW1w
bGU6DQo+DQo+ICAgIDExOWNhMDogICAgICAgZTggMDAgMDAgMDAgMDAgICAgICAgICAgY2FsbHEg
IDExOWNhNSA8X19pYTMyX3N5c19zY2hlZF9ycl9nZXRfaW50ZXJ2YWwrMHg1Pg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgMTE5Y2ExOiBSX1g4Nl82NF9QQzMyICAgX19mZW50cnlfXy0weDQN
Cj4NCj4gVGhpcyBpbnN0cnVjdGlvbiBpcyBhIGNhbGwgdG8gdGhlIF9fZmVudHJ5X18gZnVuY3Rp
b24uICBUaGUgcmVsYSBhZGRlbmQNCj4gaXMgdGhlIGFkZHJlc3Mgb2YgdGhlIGRlc3RpbmF0aW9u
IGZ1bmN0aW9uIChfX2ZlbnRyeV9fKSBtaW51cyA0LiAgQWZ0ZXINCj4gYXBwbHlpbmcgdGhlIHJl
bG9jYXRpb24sIGl0IHJlc29sdmVzIHRvOg0KPg0KPiBmZmZmZmZmZjgxMDAyMDEwOiAgICAgICBl
OCBlYiBmNyA5ZiAwMCAgICAgICAgICBjYWxscSAgZmZmZmZmZmY4MWEwMTgwMCA8X19mZW50cnlf
Xz4NCj4NCj4gVGhlIGRlc3RpbmF0aW9uIGFkZHJlc3MgaXMgIjB4OWZmN2ViIiwgd2hpY2ggaXMg
aW5kZWVkIF9fZmVudHJ5X18gLSA0Lg0KPg0KPiB4ODYgZXhwZWN0cyBpdCB0byBiZSB0aGF0IHdh
eSwgYmVjYXVzZSB0aGUgeDg2IENQVSBhZGRzIHRoZSBvZmZzZXQgdG8NCj4gdGhlICplbmQqIG9m
IHRoZSBpbnN0cnVjdGlvbjogZmZmZmZmZmY4MTAwMjAxNSAobGFzdCBkaWdpdCBpcyA1LCBub3Qg
MCkuDQo+DQo+IDB4ZmZmZmZmZmY4MTAwMjAxNSArIDB4OWZmN2ViID0gMHhmZmZmZmZmODFhMDE4
MDAsIHdoaWNoIGlzIGluZGVlZCB0aGUNCj4gYWRkcmVzcyBvZiBfX2ZlbnRyeV9fLg0KPg0KPiBB
bmQgdGhlcmUncyBhbHdheXMgYSA0LWJ5dGUgZ2FwIGJldHdlZW4gdGhlIHJlbG9jYXRpb24gdGFy
Z2V0IGFuZCB0aGUNCj4gZW5kIG9mIHRoZSBpbnN0cnVjdGlvbiwgc28gdGhlIHJlbGEgYWRkZW5k
IGFsd2F5cyBoYXMgdGhlIC00LiAgU28gd2hlbg0KPiByZWFkaW5nIHRoZSByZWxvY2F0aW9uIHdl
IGhhdmUgdG8gYWRkIHRoZSA0IGJ5dGVzIGJhY2sgdG8gZ2V0IHRoZSBhY3R1YWwNCj4gZGVzdGlu
YXRpb24gYWRkcmVzcy4NCj4NCg0KVGhhbmsgeW91IGZvciB0aGUgZXhwbGFuYXRpb24hDQoNCj4+
ICogSSBjdXJyZW50bHkgZG9uJ3QgaGF2ZSBhIGNsZWFyIHVuZGVyc3RhbmRpbmcgYWJvdXQgaG93
IHN3aXRjaC10YWJsZXMNCj4+ICAgIGFyZSBnZW5lcmF0ZWQgb24gYXJtNjQgYW5kIGhvdyB0byBy
ZXRyaWV2ZSB0aGVtIChiYXNlZCBvbiByZWxvY2F0aW9ucykuDQo+DQo+IFRoaXMgaXMgaW5kZWVk
IGEgYml0IHRyaWNreSBvbiB4ODYuDQo+DQo+PiBQbGVhc2UgcHJvdmlkZSBtZSB3aXRoIGFueSBm
ZWVkYmFjayBhbmQgY29tbWVudHMgYXMgd2VsbCBvbiB0aGUgY29udGVudA0KPj4gdGhhbiB0aGUg
c3R5bGUgb2YgdGhlc2UgcGF0Y2hlcy4NCj4NCj4gT3ZlcmFsbCBpdCBsb29rcyBsaWtlIGEgZ3Jl
YXQgc3RhcnQuICBJIGFkZGVkIHNvbWUgcGVyLXBhdGNoIGNvbW1lbnRzLg0KPg0KDQpUaGFuayB5
b3UsIEkgd2lsbCBhZGRyZXNzIHRoZW0uDQoNCj4gSGFzIHRoZSBjcm9zcy1jb21waWxlIHBhdGgg
YmVlbiB0ZXN0ZWQ/ICBTcGVjaWZpY2FsbHksIGNvbXBpbGluZyBmb3IgYQ0KPiBhcm02NCB0YXJn
ZXQgb24gYW4geDg2IGhvc3Q/ICBJbiBvdGhlciB3b3Jkcywgb2JqdG9vbCB3b3VsZCBiZSBhbiB4
ODYNCj4gYmluYXJ5IHdoaWNoIHJlYWRzIGFybTY0IG9iamVjdHMuICBJIGltYWdpbmUgdGhhdCB3
aWxsIGJlIGEgc2VtaS1jb21tb24NCj4gdXNlIGNhc2UuICBPYmp0b29sIGFscmVhZHkgc3VwcG9y
dHMgY3Jvc3MtY29tcGlsaW5nIGZvciBhbiB4ODYtNjQgdGFyZ2V0DQo+IG9uIGFuIHg4Ni0zMiBo
b3N0IChhbmQgYWxzbyBhIHBvd2VycGMgaG9zdCBJSVJDKSwgc28gaXQgc2hvdWxkIGJlDQo+IGRv
LWFibGUgaW4gdGhlb3J5LCBhbmQgaXQgbWlnaHQgImp1c3Qgd29yayIuDQo+DQoNCkl0IGhhcyBp
bmRlZWQgYmVlbiB0ZXN0ZWQgdG8gYnVpbGQgZm9yIGFybTY0IHRhcmdldCBvbiBhIHg4NiBob3N0
IGFuZCBpdA0Kd29ya3MgZmluZS4NCg0KPiBGb3IgdGhlIG5leHQgdmVyc2lvbiwgcGxlYXNlIGJh
c2UgaXQgb24gdGhlIC10aXAgdHJlZSwgYXMgdGhhdCdzIHdoZXJlDQo+IGFsbCB0aGUgbGF0ZXN0
IG9ianRvb2wgY2hhbmdlcyBhcmUuICBQZXRlciByZWZhY3RvcmVkIHNvbWUgY29kZSB3aGljaA0K
PiBoYXMgc29tZSBtaW5vciBjb25mbGljdHMgd2l0aCB5b3Vycy4NCj4NCg0KVGhhbmtzIGZvciBs
ZXR0aW5nIG1lIGtub3cgYWJvdXQgdGhpcy4gSnVzdCBhIHF1aWNrIHByZWNpc2lvbiwgd2hlbiB5
b3UNCnRhbGsgYWJvdXQgdGhlIC10aXAgdHJlZSwgYXJlIHlvdSB0YWxraW5nIGFib3V0IHRoaXMg
dHJlZSA/DQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
aXAvdGlwLmdpdC8NCg0KVGhhbmtzLA0KDQotLQ0KUmFwaGFlbCBHYXVsdA0KSU1QT1JUQU5UIE5P
VElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUg
Y29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0
aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRl
bHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwg
dXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24g
aW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K
