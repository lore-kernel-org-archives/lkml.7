Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB22C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DF3214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kTbxRw1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfDYIMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:12:31 -0400
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:57342
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbfDYIMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axpRc3QKEsPpm3SZ3F1NQzKZB8dKLOVU10DKjNvuPqk=;
 b=kTbxRw1UUaxmoyhlw0gmlJYWRqmdOx45RVw2aF6ILfxEjytr86ALuRtsXK9AcItBPBSPBiLEvyfXDg8oGvEaiAA8+K/wJ5NfkKaRmbMR+PVM0Vp8AmbBlQhPSXbUHP160CanMz41FEjVhf+rfW4Et1TAK9Eiu95Vl/9SQRUkHvo=
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com (20.178.84.149) by
 DB7PR08MB4603.eurprd08.prod.outlook.com (20.178.85.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.19; Thu, 25 Apr 2019 08:12:25 +0000
Received: from DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::fdd5:e065:ed96:45da]) by DB7PR08MB3865.eurprd08.prod.outlook.com
 ([fe80::fdd5:e065:ed96:45da%3]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 08:12:25 +0000
From:   Raphael Gault <Raphael.Gault@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Thread-Topic: [RFC 3/6] objtool: arm64: Adapt the stack frame checks and the
 section analysis for the arm architecture
Thread-Index: AQHU7tulYY+OqZKg/k6QJwe1WY2Za6ZKSruAgAFe/4D///XuAIAA/9mA
Date:   Thu, 25 Apr 2019 08:12:24 +0000
Message-ID: <c90f402e-6494-73bc-1df8-516c3113019a@arm.com>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190409135243.12424-4-raphael.gault@arm.com>
 <20190423203627.mwnaknit7cvr3l5l@treble>
 <cd86ce1a-7c6a-9ebf-4c84-6cb6ffd88017@arm.com>
 <20190424165640.5yeg2yicl7ej7g3i@treble>
In-Reply-To: <20190424165640.5yeg2yicl7ej7g3i@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LNXP123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::30) To DB7PR08MB3865.eurprd08.prod.outlook.com
 (2603:10a6:10:32::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Raphael.Gault@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 216ad549-97c2-49c7-0f63-08d6c955bfc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR08MB4603;
x-ms-traffictypediagnostic: DB7PR08MB4603:
x-microsoft-antispam-prvs: <DB7PR08MB4603803EFC135D6E5A8DE543ED3D0@DB7PR08MB4603.eurprd08.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(366004)(136003)(346002)(54094003)(40434004)(199004)(189003)(186003)(44832011)(52116002)(486006)(102836004)(53546011)(386003)(6506007)(86362001)(93886005)(26005)(25786009)(446003)(97736004)(4326008)(31686004)(76176011)(99286004)(229853002)(508600001)(36756003)(11346002)(476003)(316002)(2616005)(14454004)(6436002)(71200400001)(6486002)(53936002)(3846002)(81166006)(68736007)(7736002)(8676002)(73956011)(64756008)(66556008)(66446008)(66066001)(54906003)(66946007)(71190400001)(2906002)(6246003)(8936002)(6916009)(81156014)(66476007)(305945005)(6512007)(256004)(5024004)(14444005)(5660300002)(72206003)(6116002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB4603;H:DB7PR08MB3865.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: owQauCDnfk9qlq6vfTUKmKJcsrqmrqW+P6c9YVP6W5g/KXJ5bXwiYK5JUdoubmamgcQdUPnkD/xbKbuTa7YHGfuDbEJeVJJs5ncnsk0dw8I2ehNH33U5UbbOp4BynnR2PRp5WwwP6m/aSrxi5l8IxTZOHNWT6KpnXvCv4egoZrKbPbqbkBXVXdKHV6kvCjmekaIeo+r0R2WSapIPqHVHmZb7m5adLc53Jk1mLXX4wOkRXpXhXnQIvwjPmcMTuz/ME0FfLfwGfgWkQZS43C/pLPs/l6dxR4I+bf+grl39hNLjjPwB2KbJKxAM8qd0yjGC8q8yvlSDW3EPTwHQXRljQOsg80jXvaVECA284UQ+kS5ZOKElEqLIGE1xDLA/Fn1tCFb75j/lkewbfwtBbrDEfDYzbl2yJmhJxf6PhRWQx6I=
Content-Type: text/plain; charset="utf-8"
Content-ID: <109510A83B6F6C468FC3905BECEF32C5@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 216ad549-97c2-49c7-0f63-08d6c955bfc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 08:12:25.2624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4603
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9zaCwNCg0KT24gNC8yNC8xOSA1OjU2IFBNLCBKb3NoIFBvaW1ib2V1ZiB3cm90ZToNCj4g
T24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgMDQ6MzI6NDRQTSArMDAwMCwgUmFwaGFlbCBHYXVsdCB3
cm90ZToNCj4+Pj4gZGlmZiAtLWdpdCBhL3Rvb2xzL29ianRvb2wvYXJjaC9hcm02NC9kZWNvZGUu
YyBiL3Rvb2xzL29ianRvb2wvYXJjaC9hcm02NC9kZWNvZGUuYw0KPj4+PiBpbmRleCAwZmViM2Fl
M2FmNWQuLjhiMjkzZWFlMmIzOCAxMDA2NDQNCj4+Pj4gLS0tIGEvdG9vbHMvb2JqdG9vbC9hcmNo
L2FybTY0L2RlY29kZS5jDQo+Pj4+ICsrKyBiL3Rvb2xzL29ianRvb2wvYXJjaC9hcm02NC9kZWNv
ZGUuYw0KPj4+PiBAQCAtMTA1LDYgKzEwNSwzMyBAQCB1bnNpZ25lZCBsb25nIGFyY2hfY29tcHV0
ZV9yZWxhX3N5bV9vZmZzZXQoaW50IGFkZGVuZCkNCj4+Pj4gICAgcmV0dXJuIGFkZGVuZDsNCj4+
Pj4gICAgfQ0KPj4+Pg0KPj4+PiArLyoNCj4+Pj4gKyAqIEluIG9yZGVyIHRvIGtub3cgaWYgd2Ug
YXJlIGluIHByZXNlbmNlIG9mIGEgc2libGluZw0KPj4+PiArICogY2FsbCBhbmQgbm90IGluIHBy
ZXNlbmNlIG9mIGEgc3dpdGNoIHRhYmxlIHdlIGxvb2sNCj4+Pj4gKyAqIGJhY2sgYXQgdGhlIHBy
ZXZpb3VzIGluc3RydWN0aW9ucyBhbmQgc2VlIGlmIHdlIGFyZQ0KPj4+PiArICoganVtcGluZyBp
bnNpZGUgdGhlIHNhbWUgZnVuY3Rpb24gdGhhdCB3ZSBhcmUgYWxyZWFkeQ0KPj4+PiArICogaW4u
DQo+Pj4+ICsgKi8NCj4+Pj4gK2Jvb2wgYXJjaF9pc19pbnNuX3NpYmxpbmdfY2FsbChzdHJ1Y3Qg
aW5zdHJ1Y3Rpb24gKmluc24pDQo+Pj4+ICt7DQo+Pj4+ICtzdHJ1Y3QgaW5zdHJ1Y3Rpb24gKnBy
ZXY7DQo+Pj4+ICtzdHJ1Y3QgbGlzdF9oZWFkICpsOw0KPj4+PiArc3RydWN0IHN5bWJvbCAqc3lt
Ow0KPj4+PiArbGlzdF9mb3JfZWFjaF9wcmV2KGwsICZpbnNuLT5saXN0KSB7DQo+Pj4+ICtwcmV2
ID0gKHZvaWQgKilsOw0KPj4+PiAraWYgKCFwcmV2LT5mdW5jDQo+Pj4+ICt8fCBwcmV2LT5mdW5j
LT5wZnVuYyAhPSBpbnNuLT5mdW5jLT5wZnVuYykNCj4+Pj4gK3JldHVybiBmYWxzZTsNCj4+Pj4g
K2lmIChwcmV2LT5zdGFja19vcC5zcmMucmVnICE9IEFEUl9TT1VSQ0UpDQo+Pj4+ICtjb250aW51
ZTsNCj4+Pj4gK3N5bSA9IGZpbmRfc3ltYm9sX2NvbnRhaW5pbmcoaW5zbi0+c2VjLCBpbnNuLT5p
bW1lZGlhdGUpOw0KPj4+PiAraWYgKCFzeW0gfHwgc3ltLT50eXBlICE9IFNUVF9GVU5DDQo+Pj4+
ICt8fCBzeW0tPnBmdW5jICE9IGluc24tPmZ1bmMtPnBmdW5jKQ0KPj4+PiArcmV0dXJuIHRydWU7
DQo+Pj4+ICticmVhazsNCj4+Pj4gK30NCj4+Pj4gK3JldHVybiB0cnVlOw0KPj4+PiArfQ0KPj4+
DQo+Pj4gSSBnZXQgdGhlIGZlZWxpbmcgdGhlcmUgbWlnaHQgYmUgYSBiZXR0ZXIgd2F5IHRvIGRv
IHRoaXMsIGJ1dCBJIGNhbid0DQo+Pj4gZmlndXJlIG91dCB3aGF0IHRoaXMgZnVuY3Rpb24gaXMg
YWN0dWFsbHkgZG9pbmcuICBJdCBsb29rcyBsaWtlIGl0DQo+Pj4gc2VhcmNoZXMgYmFja3dhcmRz
IGluIHRoZSBmdW5jdGlvbiBmb3IgYW4gaW5zdHJ1Y3Rpb24gd2hpY2ggaGFzDQo+Pj4gc3RhY2tf
b3Auc3JjLnJlZyAhPSBBRFJfU09VUkNFIC0tIHdoYXQgZG9lcyB0aGF0IG1lYW4/ICBBbmQgd2h5
IGRvZXNuJ3QNCj4+PiBpdCBkbyBhbnl0aGluZyB3aXRoIHRoZSBpbnN0cnVjdGlvbiBhZnRlciBp
dCBmaW5kcyBpdD8NCj4+Pg0KPj4NCj4+IEkgd2lsbCBpbmRlZWQgdHJ5IHRvIG1ha2UgaXQgYmV0
dGVyLg0KPg0KPiBJIHN0aWxsIGRvbid0IHF1aXRlIGdldCB3aGF0IGl0J3MgdHJ5aW5nIHRvIGFj
Y29tcGxpc2gsIGJ1dCBJIHdvbmRlciBpZg0KPiB0aGVyZSdzIHNvbWUga2luZCBvZiB0cmFja2lu
ZyB5b3UgY2FuIGFkZCBpbiB2YWxpZGF0ZV9icmFuY2goKSB0byBrZWVwDQo+IHRyYWNrIG9mIHdo
YXRldmVyIHlvdSdyZSBsb29raW5nIGZvciwgbGVhZGluZyB1cCB0byB0aGUgaW5kaXJlY3QganVt
cC4NCj4NCg0KVGhlIG1vdGl2YXRpb24gYmVoaW5kIHRoaXMgaXMgdGhhdCB0aGUgYGJyIDxYbj5g
IGluc3RydWN0aW9uIGlzIGENCmR5bmFtaWMganVtcCAoanVtcCB0byB0aGUgYWRkcmVzcyBjb250
YWluZWQgaW4gdGhlIHByb3ZpZGVkIHJlZ2lzdGVyKS4NClRoaXMgaW5zdHJ1Y3Rpb24gaXMgdXNl
ZCBmb3Igc2libGluZyBjYWxscyBidXQgY2FuIGFsc28gYmUgdXNlZCBmb3INCnN3aXRjaCB0YWJs
ZS4gSSB1c2UgdGhpcyB0byBkaWZmZXJlbnRpYXRlIHRoZXNlIHR3byBjYXNlcyBmcm9tIG9uZSBh
bm90aGVyOg0KDQpHZW5lcmFsbHkgdGhlIGBhZHIvYWRycGAgaW5zdHJ1Y3Rpb24gaXMgdXNlZCBw
cmlvciB0byBgYnJgIGluIG9yZGVyIHRvDQpsb2FkIHRoZSBhZGRyZXNzIGludG8gdGhlIHJlZ2lz
dGVyLiBXaGF0IEkgZG8gaGVyZSBpcyBnbyBiYWNrIHRocm91Z2h0DQp0aGUgaW5zdHJ1Y3Rpb25z
IGFuZCB0cnkgdG8gaWRlbnRpZnkgaWYgdGhlIGFkZHJlc3MgbG9hZGVkLg0KDQpJIGFsc28gdGhv
dWdodCBvZiBpbXBsZW1lbnRpbmcgc29tZSBzb3J0IG9mIHRyYWNraW5nIGluIHZhbGlkYXRlIGJy
YW5jaA0KYmVjYXVzZSBpdCBjb3VsZCBiZSB1c2VmdWwgZm9yIGlkZW50aWZ5aW5nIHRoZSBzd2l0
Y2ggdGFibGVzIGFzIHdlbGwuDQpCdXQgaXQgc2VlbWVkIHRvIG1lIGxpa2UgYSBtYWpvciBjaGFu
Z2UgaW4gdGhlIHNlbWVudGljIG9mIHRoaXMgdG9vbDoNCmluZGVlZCwgZnJvbSBteSBwZXJzcGVj
dGl2ZSBJIHdvdWxkIGhhdmUgdG8gdHJhY2sgdGhlIHN0YXRlIG9mIHRoZQ0KcmVnaXN0ZXJzIGFu
ZCBJIGRvbid0IGtub3cgaWYgd2Ugd2FudCB0byBkbyB0aGF0Lg0KDQo+Pj4+IC1oYXNoX2FkZChm
aWxlLT5pbnNuX2hhc2gsICZpbnNuLT5oYXNoLCBpbnNuLT5vZmZzZXQpOw0KPj4+PiArLyoNCj4+
Pj4gKyAqIEZvciBhcm02NCBhcmNoaXRlY3R1cmUsIHdlIHNvbWV0aW1lIHNwbGl0IGluc3RydWN0
aW9ucyBzbyB0aGF0DQo+Pj4+ICsgKiB3ZSBjYW4gdHJhY2sgdGhlIHN0YXRlIGV2b2x1dGlvbiAo
aS5lLiBsb2FkL3N0b3JlIG9mIHBhaXJzIG9mIHJlZ2lzdGVycykuDQo+Pj4+ICsgKiBXZSB0aHVz
IG5lZWQgdG8gdGFrZSBib3RoIGludG8gYWNjb3VudCBhbmQgbm90IGVyYXNlIHRoZSBwcmV2aW91
cyBvbmVzLg0KPj4+PiArICovDQo+Pj4NCj4+PiBFdy4uLiAgSXMgdGhpcyBhbiBhcmNoaXRlY3R1
cmFsIHRoaW5nLCBvciBqdXN0IGEgcXVpcmsgb2YgdGhlIGFybTY0DQo+Pj4gZGVjb2Rlcj8NCj4+
Pg0KPj4NCj4+IFRoZSBtb3RpdmF0aW9uIGZvciB0aGlzIGlzIHRvIHNpbXVsYXRlIHRoZSB0d28g
Y29uc2VjdXRpdmUgb3BlcmF0aW9ucw0KPj4gdGhhdCB3b3VsZCBiZSBleGVjdXRlZCBvbiB4ODYg
YnV0IGFyZSBkb25lIGluIG9uZSBvbiBhcm02NC4gVGhpcyBpcw0KPj4gc3RyaWN0bHkgYSBkZWNv
ZGVyIHJlbGF0ZWQgcXVpcmsuIEkgZG9uJ3Qga25vdyBpZiB0aGVyZSBpcyBhIGJldHRlciB3YXkN
Cj4+IHRvIGRvIGl0IHdpdGhvdXQgbW9kaWZ5aW5nIHRoZSBzdHJ1Y3Qgb3Bfc3JjIGFuZCBzdHJ1
Y3QgaW5zdHJ1Y3Rpb24uDQo+DQo+IEFoLiAgV2hpY2ggb3BzIGFyZSB0aG9zZT8gIEhvcGVmdWxs
eSB3ZSBjYW4gZmluZCBhIGJldHRlciB3YXkgdG8NCj4gcmVwcmVzZW50IHRoYXQgd2l0aCBhIHNp
bmdsZSBpbnN0cnVjdGlvbi4gIEFkZGluZyBmYWtlIGluc3RydWN0aW9ucyBpcw0KPiBmcmFnaWxl
Lg0KPg0KDQpUaG9zZSBhcmUgdGhlIGxvYWQvc3RvcmUgb2YgcGFpcnMgb2YgcmVnaXN0ZXJzLCBt
YWlubHkgc3RwL2xkcC4gVGhvc2UNCmFyZSBvZnRlbiB1c2UgaW4gdGhlIGZ1bmN0aW9uIHByb2xv
Z3Vlcy9lcGlsb2d1ZXMgdG8gc2F2ZS9yZXN0b3JlIHRoZQ0Kc3RhY2sgcG9pbnRlcnMgYW5kIGZy
YW1lIHBvaW50ZXJzIGhvd2V2ZXIgaXQgY2FuIGJlIHVzZWQgd2l0aCBhbnkNCnJlZ2lzdGVyIHBh
aXIuDQoNClRoZSBpZGVhIHRvIGFkZCBhIG5ldyBpbnN0cnVjdGlvbiBjb3VsZCB3b3JrIGJ1dCBJ
IHdvdWxkIG5lZWQgdG8gZXh0ZW5kDQp0aGUgYHN0cnVjdCBvcF9zcmNgIGFzIHdlbGwgSSB0aGlu
ay4NCg0KVGhhbmtzLA0KDQotLQ0KUmFwaGFlbCBHYXVsdA0KSU1QT1JUQU5UIE5PVElDRTogVGhl
IGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50
aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5k
ZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRv
IG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZv
ciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1l
ZGl1bS4gVGhhbmsgeW91Lg0K
