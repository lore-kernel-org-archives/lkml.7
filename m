Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9EBC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C420665
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbfG3JRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:17:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:21107 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727036AbfG3JRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:17:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-26-wAcv3DULNd6JttPo1BEKQg-1; Tue, 30 Jul 2019 10:17:22 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 30 Jul 2019 10:17:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 30 Jul 2019 10:17:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Adrian Hunter' <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "mbd@fb.com" <mbd@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH 3/3] Fix insn.c misaligned address error
Thread-Topic: [PATCH 3/3] Fix insn.c misaligned address error
Thread-Index: AQHVRqwOpfmPP5E8sEGRIUz9LPt6Tqbi4OtQ
Date:   Tue, 30 Jul 2019 09:17:21 +0000
Message-ID: <60dbeb2c6e5d41318e6978d7b4c51ebd@AcuMS.aculab.com>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-4-nums@google.com> <20190726193806.GB24867@kernel.org>
 <20190727184638.3263eb76c3cbde95f9896210@kernel.org>
 <2bc0fcc6-0477-ba1d-7418-5497efa7d571@intel.com>
 <20190730094745.f5d6e7fa062e09d70b643801@kernel.org>
 <e4269cb2-d8e6-da26-6afd-a9df72d4be36@intel.com>
In-Reply-To: <e4269cb2-d8e6-da26-6afd-a9df72d4be36@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: wAcv3DULNd6JttPo1BEKQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWRyaWFuIEh1bnRlcg0KPiBTZW50OiAzMCBKdWx5IDIwMTkgMDg6NTMNCj4gT24gMzAv
MDcvMTkgMzo0NyBBTSwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4gPiBPbiBNb24sIDI5IEp1
bCAyMDE5IDExOjIyOjM0ICswMzAwDQo+ID4gQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBp
bnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4+IE9uIDI3LzA3LzE5IDEyOjQ2IFBNLCBNYXNhbWkg
SGlyYW1hdHN1IHdyb3RlOg0KPiA+Pj4gT24gRnJpLCAyNiBKdWwgMjAxOSAxNjozODowNiAtMDMw
MA0KPiA+Pj4gQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvIDxhY21lQGtlcm5lbC5vcmc+IHdyb3Rl
Og0KPiA+Pj4NCj4gPj4+PiBFbSBXZWQsIEp1bCAyNCwgMjAxOSBhdCAxMTo0NToxMkFNIC0wNzAw
LCBOdW1mb3IgTWJpeml3by1UaWFwbyBlc2NyZXZldToNCj4gPj4+Pj4gVGhlIHVic2FuICh1bmRl
ZmluZWQgYmVoYXZpb3Igc2FuaXRpemVyKSB2ZXJzaW9uIG9mIHBlcmYgdGhyb3dzIGFuDQo+ID4+
Pj4+IGVycm9yIG9uIHRoZSAneDg2IGluc3RydWN0aW9uIGRlY29kZXIgLSBuZXcgaW5zdHJ1Y3Rp
b25zJyBmdW5jdGlvbg0KPiA+Pj4+PiBvZiBwZXJmIHRlc3QuDQo+ID4+Pj4+DQo+ID4+Pj4+IFRv
IHJlcHJvZHVjZSB0aGlzIHJ1bjoNCj4gPj4+Pj4gbWFrZSAtQyB0b29scy9wZXJmIFVTRV9DTEFO
Rz0xIEVYVFJBX0NGTEFHUz0iLWZzYW5pdGl6ZT11bmRlZmluZWQiDQo+ID4+Pj4+DQo+ID4+Pj4+
IHRoZW4gcnVuOiB0b29scy9wZXJmL3BlcmYgdGVzdCA2MiAtdg0KPiA+Pj4+Pg0KPiA+Pj4+PiBU
aGUgZXJyb3Igb2NjdXJzIGluIHRoZSBfX2dldF9uZXh0IG1hY3JvIChsaW5lIDM0KSB3aGVyZSBh
biBpbnQgaXMNCj4gPj4+Pj4gcmVhZCBmcm9tIGEgcG90ZW50aWFsbHkgdW5hbGlnbmVkIGFkZHJl
c3MuIFVzaW5nIG1lbWNweSBpbnN0ZWFkIG9mDQo+ID4+Pj4+IGFzc2lnbm1lbnQgZnJvbSBhbiB1
bmFsaWduZWQgcG9pbnRlci4NCj4gPj4+Pg0KPiA+Pj4+IFNpbmNlIHRoaXMgY2FtZSBmcm9tIHRo
ZSBrZXJuZWwsIGRvbid0IHdlIGhhdmUgdG8gZml4IGl0IHRoZXJlIGFzIHdlbGw/DQo+ID4+Pj4g
TWFzYW1pLCBBZHJpYW4/DQo+ID4+Pg0KPiA+Pj4gSSBndWVzcyB3ZSBkb24ndCBuZWVkIGl0LCBz
aW5jZSB4ODYgY2FuIGFjY2VzcyAidW5hbGlnbmVkIGFkZHJlc3MiIGFuZA0KPiA+Pj4geDg2IGlu
c24gZGVjb2RlciBpbiBrZXJuZWwgcnVucyBvbmx5IG9uIHg4Ni4gSSdtIG5vdCBzdXJlIGFib3V0
IHBlcmYncw0KPiA+Pj4gdGhhdCBwYXJ0LiBNYXliZSBpZiB3ZSBydW4gaXQgb24gb3RoZXIgYXJj
aCBhcyBjcm9zcy1hcmNoIGFwcGxpY2F0aW9uLA0KPiA+Pj4gaXQgbWF5IGNhdXNlIHVuYWxpZ25l
ZCBwb2ludGVyIGlzc3VlLg0KPiA+Pg0KPiA+PiBZZXMsIHRoZW9yZXRpY2FsbHkgSW50ZWwgUFQg
ZGVjb2RpbmcgY2FuIGJlIGRvbmUgb24gYW55IGFyY2guDQo+ID4+DQo+ID4+IEJ1dCB0aGUgbWVt
Y3B5IGlzIHByb2JhYmx5IHN1Yi1vcHRpbWFsIGZvciB4ODYsIHNvIHRoZSBwYXRjaCBhcyBpdCBz
dGFuZHMNCj4gPj4gZG9lcyBub3Qgc2VlbSBzdWl0YWJsZS4gIEkgbm90aWNlIHRoZSBrZXJuZWwg
aGFzIGdldF91bmFsaWduZWQoKSBhbmQNCj4gPj4gcHV0X3VuYWxpZ25lZCgpLg0KPiA+Pg0KPiA+
PiBPYnZpb3VzbHkgaXQgd291bGQgYmUgYmV0dGVyIGZvciBhIHBhdGNoIHRvIGJlIGFjY2VwdGVk
IHRvDQo+ID4+IGFyY2gveDg2L2xpYi9pbnNuLmMgYWxzby4NCj4gPg0KPiA+IEhtbSwgdGhlbiBJ
IHJhdGhlciBsaWtlIG1lbWNweSgpIGZvciBhcmNoL3g4Ni9saWIvaW5zbi5jLCBiZWNhdXNlIGl0
IHJ1bnMgb25seQ0KPiA+IG9uIHg4Ni4NCj4gDQo+IFllcywgSSB3YXMgd3JvbmcgYWJvdXQgbWVt
Y3B5LCBhbmQgaXQgaXMgc2ltcGxlciBmb3IgcGVyZiB0b29scyB0aGFuDQo+IGRyYWdnaW5nIG91
dCBnZXRfdW5hbGlnbmVkKCkuDQoNCkl0IG1heSB3ZWxsIG1ha2UgdGhlIGdlbmVyYXRlZCBjb2Rl
IHdvcnNlIGJlY2F1c2Ugc29tZSBvcHRpbWlzYXRpb25zDQp3b24ndCBoYXBwZW4gYmVjYXVzZSB0
aGV5IHdvdWxkIG5lZWQgdG8gYmUgZG9uZSBiZWZvcmUgbWVtY3B5KCkNCmdldHMgaW5saW5lZC4N
CkkndmUgY2VydGFpbmx5IHNlZW4gY2FzZXMgd2hlcmUgYSAjZGVmaW5lIGdlbmVyYXRlcyBzaWdu
aWZpY2FudGx5DQpiZXR0ZXIgY29kZSB0aGFuIGFuIGlubGluZSBmdW5jdGlvbi4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

