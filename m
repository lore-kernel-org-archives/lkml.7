Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C906C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20BC1216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ksyG66TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbfDYVUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:20:30 -0400
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:3215
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726813AbfDYVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5zd4O9sNuHjgDVAbQ4gpTaWCDUoZorrA02AVEsug0I=;
 b=ksyG66TFmoWnCfvuzICkoo+6ZjC7J3S4ufoaNyh5qha5ExoEIhZwKUKSqYVxCbA37wBbjJDn8+ljJTOIK8o5tlu0hSR4P01dA1pYzkwNu3Di0ieONtU18KIz6zSP87EorTtsajCT2gxeSZr+9sRe+w9XDoywqtsV7ySbyoHu15Y=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5800.namprd05.prod.outlook.com (20.178.49.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.11; Thu, 25 Apr 2019 21:20:24 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::e862:1b1b:7665:8094%3]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 21:20:24 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Topic: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
Thread-Index: AQHU+5HncRUmcKTEhES/sxCi8aqoJ6ZNQ0QAgAADhICAAAHTgIAAGaSA
Date:   Thu, 25 Apr 2019 21:20:24 +0000
Message-ID: <FA82D7BD-5657-4681-B76E-3452A71171B6@vmware.com>
References: <20190425180828.24959-1-namit@vmware.com>
 <20190425192930.GA91578@gmail.com>
 <82E44F4A-E52D-4666-95B5-C6248A14A442@vmware.com>
 <20190425194837.GB58719@gmail.com>
In-Reply-To: <20190425194837.GB58719@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3f4c480-4714-4265-1edb-08d6c9c3d4cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5800;
x-ms-traffictypediagnostic: BYAPR05MB5800:
x-microsoft-antispam-prvs: <BYAPR05MB58009FFF34A892AA8B4F13FFD03D0@BYAPR05MB5800.namprd05.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(51444003)(52314003)(189003)(93886005)(64756008)(476003)(66946007)(6246003)(86362001)(2616005)(6486002)(229853002)(486006)(66446008)(7736002)(256004)(99286004)(66556008)(6512007)(6916009)(14454004)(73956011)(68736007)(305945005)(76116006)(2906002)(76176011)(186003)(97736004)(6436002)(102836004)(26005)(4326008)(6116002)(82746002)(81166006)(71190400001)(71200400001)(3846002)(6506007)(478600001)(81156014)(5660300002)(53936002)(8936002)(316002)(66476007)(25786009)(11346002)(33656002)(446003)(54906003)(66066001)(53546011)(8676002)(36756003)(83716004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5800;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sUby4Libjs0XOmXULMt0kUi8JKFBvlzRtfPBYBWzXp4Gv3RyN7RG6brG1UVw0L0RBPzfFdAq7RZD47cKyOhfMLk72ULlmQxHF2I/9uJo7VS0NUvndZjKRhcxQxjqicCC3LRAJtIuvORct2kUw21WEeg9SujSyuxKsNnKY7bsdId3ja7BrXiF6P9tOqUZBTVuo416auhqCr99vf3bASyL1GTP0nitNVxTO/ypTpFBdwGFJFYVAHMgaHm8NhPBlH9Q1ExIq2bs7kN4O/nKhiRl9Tc7EngGKCFX9mZq5n7gXX9WVulhFvblFCPx4B9RCswZYDOyAleIRXv8xS4gbNfRo186B0/aG+IASZP/j5x59UWyYmS17eBveX0fCE2X2ujUwBPyPKswxrUMCowWNIH4iJIoLuwoXH8fgEPl7QUQJn8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE0255DD6AD00B4BA82A934D7B9AFD3D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f4c480-4714-4265-1edb-08d6c9c3d4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 21:20:24.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBcHIgMjUsIDIwMTksIGF0IDEyOjQ4IFBNLCBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVs
Lm9yZz4gd3JvdGU6DQo+IA0KPiANCj4gKiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29tPiB3
cm90ZToNCj4gDQo+Pj4gT24gQXByIDI1LCAyMDE5LCBhdCAxMjoyOSBQTSwgSW5nbyBNb2xuYXIg
PG1pbmdvQGtlcm5lbC5vcmc+IHdyb3RlOg0KPj4+IA0KPj4+IA0KPj4+ICogTmFkYXYgQW1pdCA8
bmFtaXRAdm13YXJlLmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4+IE1vdmUgZmx1c2hfdGxiX2luZm8g
dmFyaWFibGVzIG9mZiB0aGUgc3RhY2suIFRoaXMgYWxsb3dzIHRvIGFsaWduDQo+Pj4+IGZsdXNo
X3RsYl9pbmZvIHRvIGNhY2hlLWxpbmUgYW5kIGF2b2lkIHBvdGVudGlhbGx5IHVubmVjZXNzYXJ5
IGNhY2hlDQo+Pj4+IGxpbmUgbW92ZW1lbnRzLiBJdCBhbHNvIGFsbG93cyB0byBoYXZlIGEgZml4
ZWQgdmlydHVhbC10by1waHlzaWNhbA0KPj4+PiB0cmFuc2xhdGlvbiBvZiB0aGUgdmFyaWFibGVz
LCB3aGljaCByZWR1Y2VzIFRMQiBtaXNzZXMuDQo+Pj4+IA0KPj4+PiBVc2UgcGVyLUNQVSBzdHJ1
Y3QgZm9yIGZsdXNoX3RsYl9tbV9yYW5nZSgpIGFuZA0KPj4+PiBmbHVzaF90bGJfa2VybmVsX3Jh
bmdlKCkuIEFkZCBkZWJ1ZyBhc3NlcnRpb25zIHRvIGVuc3VyZSB0aGVyZSBhcmUNCj4+Pj4gbm8g
bmVzdGVkIFRMQiBmbHVzaGVzIHRoYXQgbWlnaHQgb3ZlcndyaXRlIHRoZSBwZXItQ1BVIGRhdGEu
IEZvcg0KPj4+PiBhcmNoX3RsYmJhdGNoX2ZsdXNoKCkgdXNlIGEgY29uc3Qgc3RydWN0Lg0KPj4+
PiANCj4+Pj4gUmVzdWx0cyB3aGVuIHJ1bm5pbmcgYSBtaWNyb2JlbmNobWFya3MgdGhhdCBwZXJm
b3JtcyAxMF42IE1BRFZfRE9OVEVFRA0KPj4+PiBvcGVyYXRpb25zIGFuZCB0b3VjaGluZyBhIHBh
Z2UsIGluIHdoaWNoIDMgYWRkaXRpb25hbCB0aHJlYWRzIHJ1biBhDQo+Pj4+IGJ1c3ktd2FpdCBs
b29wICg1IHJ1bnMsIFBUSSBhbmQgcmV0cG9saW5lcyBhcmUgdHVybmVkIG9mZik6DQo+Pj4+IA0K
Pj4+PiAJCQliYXNlCQlvZmYtc3RhY2sNCj4+Pj4gCQkJLS0tLQkJLS0tLS0tLS0tDQo+Pj4+IGF2
ZyAodXNlYy9vcCkJCTEuNjI5CQkxLjU3MAkoLTMlKQ0KPj4+PiBzdGRkZXYJCQkwLjAxNAkJMC4w
MDkNCj4+Pj4gDQo+Pj4+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+
DQo+Pj4+IENjOiBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4NCj4+Pj4gQ2M6IERh
dmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+DQo+Pj4+IENjOiBCb3Jpc2xhdiBQZXRr
b3YgPGJwQGFsaWVuOC5kZT4NCj4+Pj4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJv
bml4LmRlPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBOYWRhdiBBbWl0IDxuYW1pdEB2bXdhcmUuY29t
Pg0KPj4+PiANCj4+Pj4gLS0tDQo+Pj4+IA0KPj4+PiB2MS0+djI6DQo+Pj4+IC0gSW5pdGlhbGl6
ZSBhbGwgZmx1c2hfdGxiX2luZm8gZmllbGRzIFtBbmR5XQ0KPj4+PiAtLS0NCj4+Pj4gYXJjaC94
ODYvbW0vdGxiLmMgfCAxMDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLQ0KPj4+PiAxIGZpbGUgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRp
b25zKC0pDQo+Pj4+IA0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vdGxiLmMgYi9hcmNo
L3g4Ni9tbS90bGIuYw0KPj4+PiBpbmRleCA0ODdiODQ3NGMwMWMuLmFhYzE5MWViMmI5MCAxMDA2
NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYvbW0vdGxiLmMNCj4+Pj4gKysrIGIvYXJjaC94ODYvbW0v
dGxiLmMNCj4+Pj4gQEAgLTYzNCw3ICs2MzQsNyBAQCBzdGF0aWMgdm9pZCBmbHVzaF90bGJfZnVu
Y19jb21tb24oY29uc3Qgc3RydWN0IGZsdXNoX3RsYl9pbmZvICpmLA0KPj4+PiAJdGhpc19jcHVf
d3JpdGUoY3B1X3RsYnN0YXRlLmN0eHNbbG9hZGVkX21tX2FzaWRdLnRsYl9nZW4sIG1tX3RsYl9n
ZW4pOw0KPj4+PiB9DQo+Pj4+IA0KPj4+PiAtc3RhdGljIHZvaWQgZmx1c2hfdGxiX2Z1bmNfbG9j
YWwodm9pZCAqaW5mbywgZW51bSB0bGJfZmx1c2hfcmVhc29uIHJlYXNvbikNCj4+Pj4gK3N0YXRp
YyB2b2lkIGZsdXNoX3RsYl9mdW5jX2xvY2FsKGNvbnN0IHZvaWQgKmluZm8sIGVudW0gdGxiX2Zs
dXNoX3JlYXNvbiByZWFzb24pDQo+Pj4+IHsNCj4+Pj4gCWNvbnN0IHN0cnVjdCBmbHVzaF90bGJf
aW5mbyAqZiA9IGluZm87DQo+Pj4+IA0KPj4+PiBAQCAtNzIyLDQzICs3MjIsODEgQEAgdm9pZCBu
YXRpdmVfZmx1c2hfdGxiX290aGVycyhjb25zdCBzdHJ1Y3QgY3B1bWFzayAqY3B1bWFzaywNCj4+
Pj4gKi8NCj4+Pj4gdW5zaWduZWQgbG9uZyB0bGJfc2luZ2xlX3BhZ2VfZmx1c2hfY2VpbGluZyBf
X3JlYWRfbW9zdGx5ID0gMzM7DQo+Pj4+IA0KPj4+PiArc3RhdGljIERFRklORV9QRVJfQ1BVX1NI
QVJFRF9BTElHTkVEKHN0cnVjdCBmbHVzaF90bGJfaW5mbywgZmx1c2hfdGxiX2luZm8pOw0KPj4+
PiArDQo+Pj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX1ZNDQo+Pj4+ICtzdGF0aWMgREVGSU5FX1BF
Ul9DUFUodW5zaWduZWQgaW50LCBmbHVzaF90bGJfaW5mb19pZHgpOw0KPj4+PiArI2VuZGlmDQo+
Pj4+ICsNCj4+Pj4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IGZsdXNoX3RsYl9pbmZvICpnZXRfZmx1
c2hfdGxiX2luZm8oc3RydWN0IG1tX3N0cnVjdCAqbW0sDQo+Pj4+ICsJCQl1bnNpZ25lZCBsb25n
IHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCwNCj4+Pj4gKwkJCXVuc2lnbmVkIGludCBzdHJpZGVf
c2hpZnQsIGJvb2wgZnJlZWRfdGFibGVzLA0KPj4+PiArCQkJdTY0IG5ld190bGJfZ2VuKQ0KPj4+
PiArew0KPj4+PiArCXN0cnVjdCBmbHVzaF90bGJfaW5mbyAqaW5mbyA9IHRoaXNfY3B1X3B0cigm
Zmx1c2hfdGxiX2luZm8pOw0KPj4+PiArDQo+Pj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX1ZNDQo+
Pj4+ICsJLyoNCj4+Pj4gKwkgKiBFbnN1cmUgdGhhdCB0aGUgZm9sbG93aW5nIGNvZGUgaXMgbm9u
LXJlZW50cmFudCBhbmQgZmx1c2hfdGxiX2luZm8NCj4+Pj4gKwkgKiBpcyBub3Qgb3ZlcndyaXR0
ZW4uIFRoaXMgbWVhbnMgbm8gVExCIGZsdXNoaW5nIGlzIGluaXRpYXRlZCBieQ0KPj4+PiArCSAq
IGludGVycnVwdCBoYW5kbGVycyBhbmQgbWFjaGluZS1jaGVjayBleGNlcHRpb24gaGFuZGxlcnMu
DQo+Pj4+ICsJICovDQo+Pj4+ICsJQlVHX09OKHRoaXNfY3B1X2luY19yZXR1cm4oZmx1c2hfdGxi
X2luZm9faWR4KSAhPSAxKTsNCj4+Pj4gKyNlbmRpZg0KPj4+IA0KPj4+IGlzbid0IHRoaXMgZWZm
ZWN0aXZlbHkgVk1fQlVHX09OKCk/DQo+PiANCj4+IE5vdCBleGFjdGx5LiBXaGVuIENPTkZJR19E
RUJVR19WTSBpcyBvZmYgd2UgZ2V0DQo+PiANCj4+IAkjZGVmaW5lIFZNX0JVR19PTihjb25kKSBC
VUlMRF9CVUdfT05fSU5WQUxJRChjb25kKQ0KPj4gDQo+PiBUaGlzIHdpbGwgY2F1c2UgdGhlIGJ1
aWxkIHRvIGZhaWwgc2luY2UgZmx1c2hfdGxiX2luZm9faWR4IGlzIG5vdCBkZWZpbmVkIGluDQo+
PiB3aGVuIENPTkZJR19ERUJVR19WTSBpcyBvZmYuDQo+IA0KPiBVZ2gsIHNvIFZNX0JVR19PTigp
IHNob3VsZCByZWFsbHkgYmUgbmFtZWQgVk1fQlVJTERfQlVHX09OKCk/DQo+IA0KPiBBbnl3YXks
IGFncmVlZC4NCj4gDQo+Pj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgcHV0X2ZsdXNoX3RsYl9pbmZv
KHZvaWQpDQo+Pj4+ICt7DQo+Pj4+ICsjaWZkZWYgQ09ORklHX0RFQlVHX1ZNDQo+Pj4+ICsJLyog
Q29tcGxldGUgcmVlbnRyZW5jeSBwcmV2ZW50aW9uIGNoZWNrcyAqLw0KPj4+PiArCWJhcnJpZXIo
KTsNCj4+Pj4gKwl0aGlzX2NwdV9kZWMoZmx1c2hfdGxiX2luZm9faWR4KTsNCj4+Pj4gKyNlbmRp
Zg0KPj4+IA0KPj4+IEluIHByaW5jaXBsZSB0aGlzX2NwdV9kZWMoKSBzaG91bGQgaW1wbHkgYSBj
b21waWxlciBiYXJyaWVyPw0KPj4gDQo+PiB0aGlzX2NwdV9kZWMoKSBpcyBldmVudHVhbGx5IGV4
cGFuZGVkIHRvIHRoZSBtYWNybyBvZiBwZXJjcHVfYWRkX29wKCkuIEFuZA0KPj4gdGhlIGlubGlu
ZSBhc3NlbWJseSBkb2VzIG5vdCBoYXZlIGEg4oCcbWVtb3J54oCdIGNsb2JiZXIsIHNvIEkgZG9u
4oCZdCB0aGluayBzby4NCj4gDQo+IEkgdGhpbmsgdGhhdCdzIGEgYnVnIGFuZCBQZXRlclogaXMg
Zml4aW5nIHRob3NlLg0KDQpUaGlzIHdvdWxkIGJlIHF1aXRlIHN1cnByaXNpbmcuIEV2ZW4gYXRv
bWljX2RlYygpIGRvZXMgbm90IGltcGx5IGEgY29tcGlsZXJzDQpiYXJyaWVyLiBJIHRoaW5rIEkg
c2hvdWxkIGxlYXZlIGl0IGFzIGlzIGZvciBub3csIGFuZCBsZXQgUGV0ZXIgY2hhbmdlIGl0DQps
YXRlciBpZiBoZSBkZWNpZGVzIHRvIGRvIHNvLiBMZXQgbWUga25vdyBpZiB5b3UgZGlzYWdyZWUu
DQoNCg==
