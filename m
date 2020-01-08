Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E026C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3448C20692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 19:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="l9vtLCRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730351AbgAHTmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:42:16 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:43283 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgAHTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 14:42:16 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8256B886BF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jan 2020 08:42:12 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1578512532;
        bh=hpXV36CIsgy5ynnFu8u+VdStPHigm1kegpp8yqYEU8w=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=l9vtLCRM1M+QJyLmUvGXsxi4BG04tEuHoCjgf3b4dnvUUudPXSgzDTeaLAVJNI1Oa
         3Dg/ix2J0MvB48mSua/QfKy0gFYWApVdDc+UFkAyEynOHdh4Tj9xmBAFUtpQrrsSkY
         pXuJwp73T941PmLKhRGoLA+HQoqXDNdzGQoZr3Qb+Qt2mw+ll5nv31bL+v97HA5Dri
         hFhaiJ/dCA62NbNjSoa6m6TwzKqrbkJUmwVGd6JeHiUgxkoCzkBE1dng7mX3Ns8GtG
         JhAjyDxjCvkSPQUcmgpUmBpehYgsibPQLwZ9hD7Z1OvXnoGPSDepKOr/jNUjQlHnLU
         blU0eaGdJYV9Q==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e1630940001>; Thu, 09 Jan 2020 08:42:12 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan 2020 08:42:12 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Thu, 9 Jan 2020 08:42:12 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mvebu: Enable MBUS error propagation
Thread-Topic: [PATCH] ARM: mvebu: Enable MBUS error propagation
Thread-Index: AQHVoqqJx9twrZNTn0+9dczHY+j8Sqff+80AgACcYQA=
Date:   Wed, 8 Jan 2020 19:42:12 +0000
Message-ID: <0285a09b2b1b7ae2ccc268a37e4357c95d270ac9.camel@alliedtelesis.co.nz>
References: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
         <8736cqb63d.fsf@FE-laptop>
In-Reply-To: <8736cqb63d.fsf@FE-laptop>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:cca2:aede:7cb9:9a1a]
Content-Type: text/plain; charset="utf-8"
Content-ID: <46151702CF11BB4B9A8821030BD57E40@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZ29yeSwNCg0KT24gV2VkLCAyMDIwLTAxLTA4IGF0IDExOjIyICswMTAwLCBHcmVnb3J5
IENMRU1FTlQgd3JvdGU6DQo+IEhlbGxvIENocmlzLA0KPiANCj4gPiBVLWJvb3QgZGlzYWJsZXMg
TUJVUyBlcnJvciBwcm9wYWdhdGlvbiBmb3IgQXJtYWRhLTM4NS4gVGhlIGVmZmVjdCBvZg0KPiA+
IHRoaXMgb24gdGhlIGtlcm5lbCBpcyB0aGF0IGFueSBhY2Nlc3MgdG8gYSBtYXBwZWQgYnV0IGlu
YWNjZXNzaWJsZQ0KPiA+IGFkZHJlc3MgY2F1c2VzIHRoZSBzeXN0ZW0gdG8gaGFuZy4NCj4gPiAN
Cj4gPiBCeSBlbmFibGluZyBNQlVTIGVycm9yIHByb3BhZ2F0aW9uIHRoZSBrZXJuZWwgY2FuIHJh
aXNlIGEgQnVzIEVycm9yIGFuZA0KPiA+IHBhbmljIHRvIHJlc3RhcnQgdGhlIHN5c3RlbS4NCj4g
DQo+IFVubGVzcyBJIG1pc3MgaXQsIGl0IHNlZW1zIHRoYXQgbm9ib2R5IGNvbW1lbnQgdGhpcyBw
YXRjaDogc29ycnkgZm9yIHRoZQ0KPiBkZWxheS4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIHJlc3Bv
bnNlLg0KDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFj
a2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiA+IC0tLQ0KPiA+IA0KPiA+IE5vdGVzOg0KPiA+
ICAgICBXZSd2ZSBlbmNvdW50ZXJlZCBhbiBpc3N1ZSB3aGVyZSByb2d1ZSBhY2Nlc3NlcyB0byBQ
Q0ktZSBzcGFjZSBjYXVzZSBhbg0KPiA+ICAgICBBcm1hZGEtMzg1IHN5c3RlbSB0byBsb2NrdXAu
IFdlJ3ZlIGZvdW5kIHRoYXQgZW5hYmxpbmcgTUJVUyBlcnJvcg0KPiA+ICAgICBwcm9wYWdhdGlv
biBsZXRzIHVzIGdldCBhIGJ1cyBlcnJvciB3aGljaCBhdCBsZWFzdCBnaXZlcyB1cyBhIHBhbmlj
IHRvDQo+ID4gICAgIGhlbHAgaWRlbnRpZnkgd2hhdCB3YXMgYWNjZXNzZWQuDQo+ID4gICAgIA0K
PiA+ICAgICBVLWJvb3QgY2xlYXJzIHRoZSBJTyBFcnIgUHJvcCBFbmFibGUgQml0WzFdIGJ1dCBz
byBmYXIgbm8tb25lIHNlZW1zIHRvDQo+ID4gICAgIGtub3cgd2h5Lg0KPiA+ICAgICANCj4gPiAg
ICAgSSB3YXNuJ3Qgc3VyZSB3aGVyZSB0byBwdXQgdGhpcyBjb2RlLiBUaGVyZSBpcyBzaW1pbGFy
IGNvZGUgZm9yIGtpcndvb2QNCj4gPiAgICAgaW4gdGhlIGVxdWl2YWxlbnQgZHRfaW5pdCBmdW5j
dGlvbi4gT24gQXJtYWRhLVhQIHRoZSByZWdpc3RlciBpcyBwYXJ0IG9mDQo+ID4gICAgIHRoZSBD
b3JlIENvaGVyZW5jeSBGYWJyaWMgYmxvY2sgKGZvciBBMzg1IGl0J3MgZG9jdW1lbnRlZCBhcyBw
YXJ0IG9mIHRoZQ0KPiA+ICAgICBDQ0YgYmxvY2spLg0KPiANCj4gV2hhdCBhYm91dCBhZGRpbmcg
YSBuZXcgc2V0IG9mIHJlZ2lzdGVyIHRvIHRoZSBtdmVidSBtYnVzIGRyaXZlcj8NCj4gDQoNCkFm
dGVyIG1vcmUgdGVzdGluZyB3ZSBmb3VuZCB0aGF0IHNvbWUgcHJldmlvdXNseSAiZ29vZCIgYm9h
cmRzIHN0YXJ0ZWQNCnRocm93aW5nIHVwIHBhbmljcyB3aXRoIHRoaXMgY2hhbmdlLiBJIHRoaW5r
IHRoYXQgdGhpcyBtaWdodCByZXF1aXJlDQpoYW5kbGluZyBzb21lIG9mIHRoZSBQQ0ktZSBpbnRl
cnJ1cHRzIChmb3IgY29ycmVjdGFibGUgZXJyb3JzKSB2aWEgdGhlDQpFREFDIHN1YnN5c3RlbS4N
Cg0KV2UncmUgc3RpbGwgd29ya2luZyB3aXRoIE1hcnZlbGwgdG8gdHJhY2sgZG93biBleGFjdGx5
IHdoeSB0aGlzIGlzDQpoYXBwZW5pbmcgb24gb3VyIHN5c3RlbS4NCg0KPiBJbiB0aGlzIGNhc2Ug
aXQgd2lsbCBiZSBjYWxsZWQgZXZlbiBlYXJsaWVyIGFsbG93aW5nIHRvIHNlZSBidXMgZXJyb3IN
Cj4gZWFybGllci4NCj4gDQo+IEluIGFueSBjYXNlLCB5b3Ugc2hvdWxkIHNlcGFyYXRlIHRoZSBk
ZXZpY2UgdHJlZSBjaGFuZ2UgZnJvbSB0aGUgY29kZQ0KPiBjaGFuZ2UgYW5kIGF0IGxlYXN0IHBy
b3ZpZGUgMiBwYXRjaGVzLg0KDQpBZ3JlZWQuIElmL3doZW4gc29tZXRoaW5nIHNvbGlkIGV2ZW50
dWF0ZXMgd2UnbGwgZG8gaXQgYXMgYSBwcm9wZXINCnNlcmllcy4NCg0KPiANCj4gR3JlZ29yeQ0K
PiANCj4gPiAgICAgDQo+ID4gICAgIC0tDQo+ID4gICAgIFsxXSAtIGh0dHBzOi8vZ2l0bGFiLmRl
bnguZGUvdS1ib290L3UtYm9vdC9ibG9iL21hc3Rlci9hcmNoL2FybS9tYWNoLW12ZWJ1L2NwdS5j
I0w0ODkNCj4gPiANCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4eC5kdHNpIHwgIDUg
KysrKysNCj4gPiAgYXJjaC9hcm0vbWFjaC1tdmVidS9ib2FyZC12Ny5jICAgIHwgMjcgKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4LmR0c2kNCj4gPiBpbmRleCAzZjRi
YjQ0ZDg1ZjAuLjMyMTRjNjc0MzNlYiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9ib290L2R0
cy9hcm1hZGEtMzh4LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzh4
LmR0c2kNCj4gPiBAQCAtMzg2LDYgKzM4NiwxMSBAQA0KPiA+ICAJCQkJICAgICAgPDB4MjAyNTAg
MHg4PjsNCj4gPiAgCQkJfTsNCj4gPiAgDQo+ID4gKwkJCWlvZXJyYzogaW8tZXJyLWNvbnRyb2xA
MjAyMDAgew0KPiA+ICsJCQkJY29tcGF0aWJsZSA9ICJtYXJ2ZWxsLGlvLWVyci1jb250cm9sIjsN
Cj4gPiArCQkJCXJlZyA9IDwweDIwMjAwIDB4ND47DQo+ID4gKwkJCX07DQo+ID4gKw0KPiA+ICAJ
CQltcGljOiBpbnRlcnJ1cHQtY29udHJvbGxlckAyMGEwMCB7DQo+ID4gIAkJCQljb21wYXRpYmxl
ID0gIm1hcnZlbGwsbXBpYyI7DQo+ID4gIAkJCQlyZWcgPSA8MHgyMGEwMCAweDJkMD4sIDwweDIx
MDcwIDB4NTg+Ow0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW12ZWJ1L2JvYXJkLXY3
LmMgYi9hcmNoL2FybS9tYWNoLW12ZWJ1L2JvYXJkLXY3LmMNCj4gPiBpbmRleCBkMmRmNWVmOTM4
MmIuLmZiNzcxODM4NmVmOSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9tYWNoLW12ZWJ1L2Jv
YXJkLXY3LmMNCj4gPiArKysgYi9hcmNoL2FybS9tYWNoLW12ZWJ1L2JvYXJkLXY3LmMNCj4gPiBA
QCAtMTM4LDEwICsxMzgsMzYgQEAgc3RhdGljIHZvaWQgX19pbml0IGkyY19xdWlyayh2b2lkKQ0K
PiA+ICAJfQ0KPiA+ICB9DQo+ID4gIA0KPiA+ICsjZGVmaW5lIE1CVVNfRVJSX1BST1BfRU4gQklU
KDgpDQo+ID4gKw0KPiA+ICsvKg0KPiA+ICsgKiBVLWJvb3QgZGlzYWJsZXMgTUJVUyBlcnJvciBw
cm9wYWdhdGlvbi4gUmUtZW5hYmxlIGl0IHNvIHdlDQo+ID4gKyAqIGNhbiBoYW5kbGUgdGhlbSBh
cyBCdXMgRXJyb3JzLg0KPiA+ICsgKi8NCj4gPiArc3RhdGljIHZvaWQgX19pbml0IGVuYWJsZV9t
YnVzX2Vycm9yX3Byb3BhZ2F0aW9uKHZvaWQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqbnAgPQ0KPiA+ICsJCW9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJt
YXJ2ZWxsLGlvLWVyci1jb250cm9sIik7DQo+ID4gKw0KPiA+ICsJaWYgKG5wKSB7DQo+ID4gKwkJ
dm9pZCBfX2lvbWVtICpyZWc7DQo+ID4gKw0KPiA+ICsJCXJlZyA9IG9mX2lvbWFwKG5wLCAwKTsN
Cj4gPiArCQlpZiAocmVnKSB7DQo+ID4gKwkJCXUzMiB2YWw7DQo+ID4gKw0KPiA+ICsJCQl2YWwg
PSByZWFkbF9yZWxheGVkKHJlZyk7DQo+ID4gKwkJCXdyaXRlbF9yZWxheGVkKHZhbCB8IE1CVVNf
RVJSX1BST1BfRU4sIHJlZyk7DQo+ID4gKwkJfQ0KPiA+ICsJCW9mX25vZGVfcHV0KG5wKTsNCj4g
PiArCX0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgX19pbml0IG12ZWJ1X2R0X2lu
aXQodm9pZCkNCj4gPiAgew0KPiA+ICAJaWYgKG9mX21hY2hpbmVfaXNfY29tcGF0aWJsZSgibWFy
dmVsbCxhcm1hZGF4cCIpKQ0KPiA+ICAJCWkyY19xdWlyaygpOw0KPiA+ICsJZW5hYmxlX21idXNf
ZXJyb3JfcHJvcGFnYXRpb24oKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQgX19p
bml0IGFybWFkYV8zNzBfeHBfZHRfZml4dXAodm9pZCkNCj4gPiBAQCAtMTkxLDYgKzIxNyw3IEBA
IERUX01BQ0hJTkVfU1RBUlQoQVJNQURBXzM4WF9EVCwgIk1hcnZlbGwgQXJtYWRhIDM4MC8zODUg
KERldmljZSBUcmVlKSIpDQo+ID4gIAkubDJjX2F1eF92YWwJPSAwLA0KPiA+ICAJLmwyY19hdXhf
bWFzawk9IH4wLA0KPiA+ICAJLmluaXRfaXJxICAgICAgID0gbXZlYnVfaW5pdF9pcnEsDQo+ID4g
KwkuaW5pdF9tYWNoaW5lCT0gbXZlYnVfZHRfaW5pdCwNCj4gPiAgCS5yZXN0YXJ0CT0gbXZlYnVf
cmVzdGFydCwNCj4gPiAgCS5kdF9jb21wYXQJPSBhcm1hZGFfMzh4X2R0X2NvbXBhdCwNCj4gPiAg
TUFDSElORV9FTkQNCj4gPiAtLSANCj4gPiAyLjI0LjANCj4gPiANCj4gDQo+IA0K
