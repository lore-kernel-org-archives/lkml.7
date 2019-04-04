Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0520AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA89020882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfDDPJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:09:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23915 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727212AbfDDPJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:09:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-16-40f3dLdxNiGOFZQ8W49SUA-1; Thu, 04 Apr 2019 16:09:42 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 4 Apr 2019 16:10:49 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 4 Apr 2019 16:10:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v9 00/27] x86: load FPU registers on return to userland
Thread-Topic: [PATCH v9 00/27] x86: load FPU registers on return to userland
Thread-Index: AQHU6jzQfWf8irPe1UiHuip9snecjKYsB0gwgAAJdsKAAAlSEA==
Date:   Thu, 4 Apr 2019 15:10:49 +0000
Message-ID: <e0a03dd5c4a141358940bff185fe3bfb@AcuMS.aculab.com>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
 <c4af28470a4347f5aa222a99471c939a@AcuMS.aculab.com>
 <20190404141409.upfk5z4re3pyvxzn@linutronix.de>
 <CALCETrU4hSC20sExsgPnhkUOfS+kd-hMHK7_amq_C5duNw33cg@mail.gmail.com>
In-Reply-To: <CALCETrU4hSC20sExsgPnhkUOfS+kd-hMHK7_amq_C5duNw33cg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 40f3dLdxNiGOFZQ8W49SUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiBGcm9tOiBBbmR5IEx1dG9taXJza2kg
W21haWx0bzpsdXRvQGtlcm5lbC5vcmddDQo+IFNlbnQ6IDA0IEFwcmlsIDIwMTkgMTU6MjcNCj4g
DQo+IE9uIFRodSwgQXByIDQsIDIwMTkgYXQgNzoxNCBBTSBTZWJhc3RpYW4gQW5kcnplaiBTaWV3
aW9yDQo+IDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+IHdyb3RlOg0KPiA+DQo+ID4gT24gMjAxOS0w
NC0wNCAxNDowMTo0MyBbKzAwMDBdLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gPiBGcm9tOiBT
ZWJhc3RpYW4gQW5kcnplaiBTaWV3aW9yDQo+ID4gPiA+IFNlbnQ6IDAzIEFwcmlsIDIwMTkgMTc6
NDENCj4gPiA+IC4uLg0KPiA+ID4gPiBUbyBhY2Nlc3MgdGhlIEZQVSByZWdpc3RlcnMgaW4ga2Vy
bmVsIHdlIG5lZWQ6DQo+ID4gPiA+IC0gZGlzYWJsZSBwcmVlbXB0aW9uIHRvIGF2b2lkIHRoYXQg
dGhlIHNjaGVkdWxlciBzd2l0Y2hlcyB0YXNrcy4gQnkNCj4gPiA+ID4gICBkb2luZyBzbyBpdCB3
b3VsZCBzZXQgVElGX05FRURfRlBVX0xPQUQgYW5kIHRoZSBGUFUgcmVnaXN0ZXJzIHdvdWxkIGJl
DQo+ID4gPiA+ICAgbm90IHZhbGlkLg0KPiA+ID4gPiAtIGRpc2FibGUgQkggYmVjYXVzZSB0aGUg
c29mdGlycSBtaWdodCB1c2Uga2VybmVsX2ZwdV9iZWdpbigpIGFuZCB0aGVuDQo+ID4gPiA+ICAg
c2V0IFRJRl9ORUVEX0ZQVV9MT0FEIGluc3RlYWQgbG9hZGluZyB0aGUgRlBVIHJlZ2lzdGVycyBv
biBjb21wbGV0aW9uLg0KPiA+ID4NCj4gPiA+IElzIHRoZXJlIGEgcG9zc2libGUgb3B0aW1pc2F0
aW9uIGhlcmUgZm9yIGtlcm5lbCB0aHJlYWRzPw0KPiA+ID4gU2luY2UgdGhlcmUgaXMgbm8gJ3Vz
ZXIgRlAgc3RhdGUnIHRoZSAna2VybmVsIEZQIHN0YXRlJyBjYW4NCj4gPiA+IGJlIHNhdmVkIGJ5
IGEgdGFzayBzd2l0Y2ggb3Igc29mdGlycS4NCj4gPg0KPiA+IFRoZXJlIGlzIG5vIHN1Y2ggdGhp
bmcgYXMgImtlcm5lbCBGUCBzdGF0ZSIgdGhhdCBpcyBzYXZlZC4NCj4gPg0KPiANCj4gSSB0aGlu
ayB0aGF0IERhdmlkIHdhcyBhc2tpbmcgd2hldGhlciB3ZSBjb3VsZCBtYWtlIGtlcm5lbF9mcHVf
YmVnaW4oKQ0KPiByZWdpb25zIHNvbWV0aW1lcyBiZSBwcmVlbXB0aWJsZS4gIFRoZSBhbnN3ZXIg
aXMgcHJlc3VtYWJseSB5ZXMsIGJ1dCBJDQo+IHRoaW5rIHRoYXQgc2hvdWxkIGJlIGEgc2VwYXJh
dGUgZWZmb3J0LCBhbmQgaXQgc2hvdWxkIGJlIGp1c3RpZmllZA0KPiB3aXRoIGltcHJvdmVkIHBl
cmZvcm1hbmNlIGFib3ZlIGFuZCBiZXlvbmQgd2hhdCB3ZSBnZXQgd2l0aCBKYXNvbidzDQo+IHNp
bWRfZ2V0KCkgc3R1ZmYuDQoNClllcC4uLg0KDQotIEFjdHVhbGx5IHRoZXJlIGFyZSBzb21lIGxv
b3BzIHRoYXQgcHJvY2VzcyBtb3JlIG9yIGxlc3MgYXJiaXRyYXJ5DQotIGFtb3VudHMgb2YgZGF0
YS4gQnV0IGFsbCBvZiB0aG9zZSBzb21ld2hhdCBtYW51YWxseSBicmVhayB0aGF0IHVwDQotIGlu
dG8gcGFnZSBzaXplIGNodW5rcyBiZWZvcmUgY2hlY2tpbmcgaWYgd2UndmUgZGlzYWJsZWQgcHJl
ZW1wdGlvbg0KLSBmb3IgdG9vIGxvbmcsIGFuZCB0aGVuIGlmIHNvLCBkbyBhIGVuZCgpYmVnaW4o
KSBzZXF1ZW5jZSBiZWZvcmUNCi0gc3RhcnRpbmcgdGhlIG5leHQgY2h1bmsuIE15IHNpbWRfcmVs
YXggdGFrZXMgY2FyZSBvZiB0aGF0LCBmb3INCi0gZXhhbXBsZS4gR2l2ZW4gdGhhdCBhIGxvbmcg
dGVybSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2hzZXQgaXMgdG8NCi0gb2Jzb2xldGUgdGhlIHNpbWRf
Z2V0L3B1dC9yZWxheCBBUEkgSSd2ZSBwcm9wb3NlZCwgaXQgc2VlbXMgbGlrZQ0KLSBpdCBtaWdo
dCBiZSBuaWNlIHRvIGFsc28gZG8gYXdheSB3aXRoIHRoZSBtYW51YWwgcmVsYXhhdGlvbg0KLSBy
ZXF1aXJlbWVudCwgaWYgdGhhdCdzIHNvbWVob3cgcG9zc2libGUuDQoNClRoZSBhZHZhbnRhZ2Ug
b2YgYSAncmVsYXgnIChvciBrZXJuZWxfZnB1X2VuZCgpL2JlZ2luKCkgcGFpcikNCmlzIHRoYXQg
dGhlIGtlcm5lbCByZWdpc3RlcnMgbmV2ZXIgbmVlZCBzYXZpbmcuDQpPVE9IIGFsbG93aW5nIGFy
Yml0cmFyeSBjb250ZXh0IHN3aXRjaGVzIGlzIChwcm9iYWJseSkgYmV0dGVyDQpmb3IgbGF0ZW5j
eS4gDQoNCkFzIHdlbGwgYXMga2VybmVsIHRocmVhZHMgYmVpbmcgYWJsZSB0byB1c2UgdGhlIHRh
c2tzICdub3JtYWwnIGZwdQ0Kc2F2ZSBhcmVhLCBpdCBvdWdodCB0byBiZSBwb3NzaWJsZSB0byBw
YXNzIGFuICdmcHUgc2F2ZSBhcmVhJw0KdG8ga2VybmVsX2ZwdV9iZWdpbigpIHNvIHRoYXQgYSBu
b24ta2VybmVsIHRocmVhZCBjYW4gYmUgcHJlLWVtcHRlZA0Kd2hpbGUgdXNpbmcgdGhlIGZwdS4N
Cg0KQWN0dWFsbHkgeW91IGNvdWxkIChwcm9iYWJseSkganVzdCBwYXNzIHRoZSBhZGRyZXNzIG9m
IGEgbG9jYXRpb24NCndoZXJlIHRoZSBhZGRyZXNzIG9mIGEga21hbGxvYygpZWQgc2F2ZSBhcmVh
IHdvdWxkIGJlIHdyaXR0ZW4NCndlcmUgb25lIG5lZWRlZCBhbmQgYWxsb2NhdGUgdGhlIHN0cnVj
dHVyZSB0aGUgZmlyc3QgdGltZSBpdA0KaXMgbmVlZGVkIChhbHRob3VnaCBrbWFsbG9jKCkgaW4g
dGhhdCBjb2RlIHBhdGggbWlnaHQgYmUgaGFyZC4pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

