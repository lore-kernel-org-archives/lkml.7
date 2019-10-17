Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F63FA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F7920663
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393751AbfJQJfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:35:36 -0400
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:37327 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfJQJfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:35:36 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x9H9ZI2v031655
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 17 Oct 2019 18:35:18 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9H9ZIZk017697;
        Thu, 17 Oct 2019 18:35:18 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x9H9XxSD007541;
        Thu, 17 Oct 2019 18:35:18 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-9601025; Thu, 17 Oct 2019 18:34:11 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Thu,
 17 Oct 2019 18:34:11 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Qian Cai <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Thread-Topic: memory offline infinite loop after soft offline
Thread-Index: AQHVgHtyUduz67i7AUWqxWZ+Pu+7vadZPeAAgATGWAA=
Date:   Thu, 17 Oct 2019 09:34:10 +0000
Message-ID: <20191017093410.GA19973@hori.linux.bs1.fc.nec.co.jp>
References: <1570829564.5937.36.camel@lca.pw>
 <20191014083914.GA317@dhcp22.suse.cz>
In-Reply-To: <20191014083914.GA317@dhcp22.suse.cz>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.150]
Content-Type: text/plain; charset="utf-8"
Content-ID: <692601B2CEEE6741AC8F87F189667CC0@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMTQsIDIwMTkgYXQgMTA6Mzk6MTRBTSArMDIwMCwgTWljaGFsIEhvY2tvIHdy
b3RlOg0KPiBPbiBGcmkgMTEtMTAtMTkgMTc6MzI6NDQsIFFpYW4gQ2FpIHdyb3RlOg0KPiA+ICMg
L29wdC9sdHAvcnVudGVzdC9iaW4vbW92ZV9wYWdlczEyDQo+ID4gbW92ZV9wYWdlczEyLmM6MjYz
OiBJTkZPOiBGcmVlIFJBTSAyNTg5ODg5Mjgga0INCj4gPiBtb3ZlX3BhZ2VzMTIuYzoyODE6IElO
Rk86IEluY3JlYXNpbmcgMjA0OGtCIGh1Z2VwYWdlcyBwb29sIG9uIG5vZGUgMCB0byA0DQo+ID4g
bW92ZV9wYWdlczEyLmM6MjkxOiBJTkZPOiBJbmNyZWFzaW5nIDIwNDhrQiBodWdlcGFnZXMgcG9v
bCBvbiBub2RlIDggdG8gNA0KPiA+IG1vdmVfcGFnZXMxMi5jOjIwNzogSU5GTzogQWxsb2NhdGlu
ZyBhbmQgZnJlZWluZyA0IGh1Z2VwYWdlcyBvbiBub2RlIDANCj4gPiBtb3ZlX3BhZ2VzMTIuYzoy
MDc6IElORk86IEFsbG9jYXRpbmcgYW5kIGZyZWVpbmcgNCBodWdlcGFnZXMgb24gbm9kZSA4DQo+
ID4gbW92ZV9wYWdlczEyLmM6MTk3OiBQQVNTOiBCdWcgbm90IHJlcHJvZHVjZWQNCj4gPiBtb3Zl
X3BhZ2VzMTIuYzoxOTc6IFBBU1M6IEJ1ZyBub3QgcmVwcm9kdWNlZA0KPiA+IA0KPiA+IGZvciBt
ZW0gaW4gJChscyAtZCAvc3lzL2RldmljZXMvc3lzdGVtL21lbW9yeS9tZW1vcnkqKTsgZG8NCj4g
PiDCoMKgwqDCoMKgwqDCoMKgZWNobyBvZmZsaW5lID4gJG1lbS9zdGF0ZQ0KPiA+IMKgwqDCoMKg
wqDCoMKgwqBlY2hvIG9ubGluZSA+ICRtZW0vc3RhdGUNCj4gPiBkb25lDQo+ID4gDQo+ID4gVGhh
dCBMVFAgbW92ZV9wYWdlczEyIHRlc3Qgd2lsbCBmaXJzdCBtYWR2aXNlKE1BRFZfU09GVF9PRkZM
SU5FKSBmb3IgYSByYW5nZS4NCj4gPiBUaGVuLCBvbmUgb2YgImVjaG8gb2ZmbGluZSIgd2lsbCB0
cmlnZ2VyIGFuIGluZmluaXRlIGxvb3AgaW4gX19vZmZsaW5lX3BhZ2VzKCkNCj4gPiBoZXJlLA0K
PiA+IA0KPiA+IAkJLyogY2hlY2sgYWdhaW4gKi8NCj4gPiAJCXJldCA9IHdhbGtfc3lzdGVtX3Jh
bV9yYW5nZShzdGFydF9wZm4sIGVuZF9wZm4gLSBzdGFydF9wZm4sDQo+ID4gCQkJCQnCoMKgwqDC
oE5VTEwsIGNoZWNrX3BhZ2VzX2lzb2xhdGVkX2NiKTsNCj4gPiAJfSB3aGlsZSAocmV0KTsNCj4g
PiANCj4gPiBiZWNhdXNlIGNoZWNrX3BhZ2VzX2lzb2xhdGVkX2NiKCkgYWx3YXlzIHJldHVybiAt
RUJVU1kgZnJvbQ0KPiA+IHRlc3RfcGFnZXNfaXNvbGF0ZWQoKSwNCj4gPiANCj4gPiANCj4gPiAJ
cGZuID0gX190ZXN0X3BhZ2VfaXNvbGF0ZWRfaW5fcGFnZWJsb2NrKHN0YXJ0X3BmbiwgZW5kX3Bm
biwNCj4gPiAJCQkJCQlza2lwX2h3cG9pc29uZWRfcGFnZXMpOw0KPiA+ICAgICAgICAgLi4uDQo+
ID4gICAgICAgICByZXR1cm4gcGZuIDwgZW5kX3BmbiA/IC1FQlVTWSA6IDA7DQo+ID4gDQo+ID4g
VGhlIHJvb3QgY2F1c2UgaXMgaW4gX190ZXN0X3BhZ2VfaXNvbGF0ZWRfaW5fcGFnZWJsb2NrKCkg
d2hlcmUgInBmbiIgaXMgYWx3YXlzDQo+ID4gbGVzcyB0aGFuICJlbmRfcGZuIiBiZWNhdXNlIHRo
ZSBhc3NvY2lhdGVkIHBhZ2UgaXMgbm90IGEgUGFnZUJ1ZGR5Lg0KPiA+IA0KPiA+IAl3aGlsZSAo
cGZuIDwgZW5kX3Bmbikgew0KPiA+IAkuLi4NCj4gPiAJCWVsc2UNCj4gPiAJCQlicmVhazsNCj4g
PiANCj4gPiAJcmV0dXJuIHBmbjsNCj4gDQo+IEhtbSwgdGhpcyBpcyBpbnRlcmVzdGluZy4gSSB3
b3VsZCBleHBlY3QgdGhhdCB0aGlzIHdvdWxkIGhpdCB0aGUNCj4gcHJldmlvdXMgYnJhbmNoDQo+
IAlpZiAoc2tpcF9od3BvaXNvbmVkX3BhZ2VzICYmIFBhZ2VIV1BvaXNvbihwYWdlKSkNCj4gYW5k
IHNraXAgb3ZlciBod3BvaXNvbmVkIHBhZ2UuIEJ1dCBJIGNhbm5vdCBzZWVtIHRvIGZpbmQgdGhh
dCB3ZSB3b3VsZA0KPiBtYXJrIGFsbCB0YWlsIHBhZ2VzIEhXUG9pc29uIGFzIHdlbGwgYW5kIHNv
IGFueSB0YWlsIHBhZ2Ugc2VlbSB0bw0KPiBjb25mdXNlIF9fdGVzdF9wYWdlX2lzb2xhdGVkX2lu
X3BhZ2VibG9jay4NCj4gDQo+IE9zY2FyIGlzIHJld3JpdGluZyB0aGUgaHdwb2lzb24gaW1wbGVt
ZW50YXRpb24gYnV0IEkgYW0gbm90IHN1cmUNCj4gaG93L3doZXRoZXIgaGUgaXMgaGFuZGxpbmcg
dGhpcyBjYXNlIGRpZmZlcmVudGx5LiBOYW95YSwgc2hvdWxkbid0IHdlIGRvDQo+IHRoZSBmb2xs
b3dpbmcgYXQgbGVhc3Q/DQoNCk15IGFwcG9sb2d5IGZvciBsYXRlIHJlc3BvbnNlLg0KDQo+IC0t
LQ0KPiBkaWZmIC0tZ2l0IGEvbW0vcGFnZV9pc29sYXRpb24uYyBiL21tL3BhZ2VfaXNvbGF0aW9u
LmMNCj4gaW5kZXggODljMTljMGZlYWRiLi41ZmIzZmVlMTZmZGUgMTAwNjQ0DQo+IC0tLSBhL21t
L3BhZ2VfaXNvbGF0aW9uLmMNCj4gKysrIGIvbW0vcGFnZV9pc29sYXRpb24uYw0KPiBAQCAtMjc0
LDcgKzI3NCw3IEBAIF9fdGVzdF9wYWdlX2lzb2xhdGVkX2luX3BhZ2VibG9jayh1bnNpZ25lZCBs
b25nIHBmbiwgdW5zaWduZWQgbG9uZyBlbmRfcGZuLA0KPiAgCQkJICogc2ltcGxlIHdheSB0byB2
ZXJpZnkgdGhhdCBhcyBWTV9CVUdfT04oKSwgdGhvdWdoLg0KPiAgCQkJICovDQo+ICAJCQlwZm4g
Kz0gMSA8PCBwYWdlX29yZGVyKHBhZ2UpOw0KPiAtCQllbHNlIGlmIChza2lwX2h3cG9pc29uZWRf
cGFnZXMgJiYgUGFnZUhXUG9pc29uKHBhZ2UpKQ0KPiArCQllbHNlIGlmIChza2lwX2h3cG9pc29u
ZWRfcGFnZXMgJiYgUGFnZUhXUG9pc29uKGNvbXBvdW5kX2hlYWQocGFnZSkpKQ0KPiAgCQkJLyog
QSBIV1BvaXNvbmVkIHBhZ2UgY2Fubm90IGJlIGFsc28gUGFnZUJ1ZGR5ICovDQo+ICAJCQlwZm4r
KzsNCj4gIAkJZWxzZQ0KDQpUaGlzIGZpeCBsb29rcyBnb29kIHRvIG1lLiBUaGUgb3JpZ2luYWwg
Y29kZSBvbmx5IGFkZHJlc3NlcyBod3BvaXNvbmVkIDRrQi1wYWdlLA0Kd2Ugc2VlbSB0byBoYXZl
IHRoaXMgaXNzdWUgc2luY2UgdGhlIGZvbGxvd2luZyBjb21taXQsDQoNCiAgY29tbWl0IGIwMjNm
NDY4MTNjZGU2ZTNiOGE4YzI0ZjQzMmZmOWMxZmQ4ZTlhNjQNCiAgQXV0aG9yOiBXZW4gQ29uZ3lh
bmcgPHdlbmN5QGNuLmZ1aml0c3UuY29tPg0KICBEYXRlOiAgIFR1ZSBEZWMgMTEgMTY6MDA6NDUg
MjAxMiAtMDgwMA0KICANCiAgICAgIG1lbW9yeS1ob3RwbHVnOiBza2lwIEhXUG9pc29uZWQgcGFn
ZSB3aGVuIG9mZmxpbmluZyBwYWdlcw0KDQphbmQgZXh0ZW5zaW9uIG9mIExUUCBjb3ZlcmFnZSBm
aW5hbGx5IGRpc2NvdmVyZWQgdGhpcy4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp

