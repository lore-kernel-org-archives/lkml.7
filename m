Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A3C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D942072B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLPQVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:21:50 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:48671 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfLPQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:21:50 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-27-vU4UXr9UOMKj9wGPg8OC5w-1; Mon, 16 Dec 2019 16:21:47 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Dec 2019 16:21:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Dec 2019 16:21:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVsSbv6yBAo1s5f0Kws0hZvGpx8qe88JNg
Date:   Mon, 16 Dec 2019 16:21:46 +0000
Message-ID: <5c492fa2d2fd47fcaa2c38a812a3d572@AcuMS.aculab.com>
References: <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD20D@ORSMSX115.amr.corp.intel.com>
 <20191122202345.GC2844@hirez.programming.kicks-ass.net>
 <20191122204204.GA192370@romley-ivt3.sc.intel.com>
 <CALCETrUBomb2_2xyX-tZUD84smtDWH6e16zSN1qupkv-DWu5kw@mail.gmail.com>
 <20191212085755.GR2827@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F5011B2@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F5013AA@ORSMSX115.amr.corp.intel.com>
 <CALCETrX6Riy8vHkWcYOt-Vt0xD2JGgua4o-8F6KatUsXH9iEUQ@mail.gmail.com>
In-Reply-To: <CALCETrX6Riy8vHkWcYOt-Vt0xD2JGgua4o-8F6KatUsXH9iEUQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: vU4UXr9UOMKj9wGPg8OC5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDEyIERlY2VtYmVyIDIwMTkgMjA6MDENCj4g
T24gVGh1LCBEZWMgMTIsIDIwMTkgYXQgMTE6NDYgQU0gTHVjaywgVG9ueSA8dG9ueS5sdWNrQGlu
dGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+PiBJZiBhbnl0aGluZyB3ZSBjb3VsZCBzd2l0Y2gg
dGhlIGVudGlyZSBiaXRtYXAgaW50ZXJmYWNlIHRvIHVuc2lnbmVkIGludCwNCj4gPiA+PiBidXQg
SSdtIG5vdCBzdXJlIHRoYXQnZCBhY3R1YWxseSBoZWxwIG11Y2guDQoNClRoYXQgd291bGQgYnJl
YWsgYWxsIHRoZSBjb2RlIHRoYXQgYXNzdW1lcyBpdCBpcyAndW5zaWduZWQgbG9uZycuDQpBdCBi
ZXN0IGl0IGNvdWxkIGJlIGNoYW5nZWQgdG8gYSBzdHJ1Y3R1cmUgd2l0aCBhbiBpbnRlZ3JhbCBt
ZW1iZXIuDQpUaGF0IHdvdWxkIG1ha2UgaXQgYSBsaXR0bGUgaGFyZGVyIGZvciBjb2RlIHRvICdw
ZWVrIGluc2lkZScgdGhlIGFic3RyYWN0aW9uLg0KDQo+ID4gPiBBcyB3ZSd2ZSBiZWVuIGxvb2tp
bmcgZm9yIHBvdGVudGlhbCBzcGxpdCBsb2NrIGlzc3VlcyBpbiBrZXJuZWwgY29kZSwgbW9zdCBv
Zg0KPiA+ID4gdGhlIG9uZXMgd2UgZm91bmQgcmVsYXRlIHRvIGNhbGxlcnMgd2hvIGhhdmUgPD0z
MiBiaXRzIGFuZCB0aHVzIHN0aWNrOg0KPiA+ID4NCj4gPiA+ICAgICAgIHUzMiBmbGFnczsNCj4g
PiA+DQo+ID4gPiBpbiB0aGVpciBzdHJ1Y3R1cmUuICBTbyBpdCB3b3VsZCBzb2x2ZSB0aG9zZSBw
bGFjZXMsIGFuZCBmaXggYW55IGZ1dHVyZSBjb2RlDQo+ID4gPiB3aGVyZSBzb21lb25lIGRvZXMg
dGhlIHNhbWUgdGhpbmcuDQoNCkFuZCBicmVhayBhbGwgdGhlIHBsYWNlcyB0aGF0IHVzZSAndW5z
aWduZWQgbG9uZycgLSBlc3BlY2lhbGx5IG9uIEJFLg0KDQo+ID4gSWYgZGlmZmVyZW50IGFyY2hp
dGVjdHVyZXMgY2FuIGRvIGJldHRlciB3aXRoIDgtYml0LzE2LWJpdC8zMi1iaXQvNjQtYml0IGlu
c3RydWN0aW9ucw0KPiA+IHRvIG1hbmlwdWxhdGUgYml0bWFwcywgdGhlbiBwZXJoYXBzIHRoaXMg
aXMganVzdGlmaWNhdGlvbiB0byBtYWtlIGFsbCB0aGUNCj4gPiBmdW5jdGlvbnMgb3BlcmF0ZSBv
biAiYml0bWFwX3QiIGFuZCBoYXZlIGVhY2ggYXJjaGl0ZWN0dXJlIHByb3ZpZGUgdGhlDQo+ID4g
dHlwZWRlZiBmb3IgdGhlaXIgZmF2b3JpdGUgd2lkdGguDQoNCnR5cGVkZWYgc3RydWN0IHsgdTgv
dTMyL3U2NCBiaXRtYXBfdmFsIH0gYml0bWFwX3Q7DQoNCj4gSG1tLiAgSU1PIHRoZXJlIGFyZSBy
ZWFsbHkgdHdvIGRpZmZlcmVudCB0eXBlcyBvZiB1c2VzIG9mIHRoZSBBUEkuDQo+IA0KPiAxIFRo
ZXJlJ3MgYSBmaWVsZCBzb21ld2hlcmUgYW5kIEkgd2FudCB0byBhdG9taWNhbGx5IHNldCBhIGJp
dC4gIFNvbWV0aGluZyBsaWtlOg0KPiANCj4gc3RydWN0IHdoYXRldmVyIHsNCj4gICAuLi4NCj4g
ICB3aGF0ZXZlcl90IGZpZWxkOw0KPiAgLi4uDQo+IH07DQo+IA0KPiBzdHJ1Y3Qgd2hhdGV2ZXIg
Knc7DQo+IHNldF9iaXQoMywgJnctPmZpZWxkKTsNCj4gDQo+IElmIHdoYXRldmVyX3QgaXMgYXJj
aGl0ZWN0dXJlLWRlcGVuZGVudCwgdGhlbiBpdCdzIHJlYWxseSBhd2t3YXJkIHRvDQo+IHVzZSBt
b3JlIHRoYW4gMzIgYml0cywgc2luY2Ugc29tZSBhcmNoaXRlY3R1cmVzIHdvbid0IGhhdmUgbW9y
ZSB0aGFuDQo+IDMyLWJpdHMuDQoNCllvdSBjb3VsZCBpbXBsZW1lbnQgdGhhdCB1c2luZyBtdWx0
aXBsZSBmdW5jdGlvbnMgYW5kICdzaXplb2YnLg0KDQpBdCB0aGUgbW9tZW50IHRoYXQgY29kZSBp
cyBicm9rZW4gb24gQkUgc3lzdGVtcyB1bmxlc3Mgd2hhdGV2ZXJfdCBpcw0KdGhlIHNhbWUgc2l6
ZSBhcyAndW5zaWduZWQgbG9uZycuDQoNCj4gMi4gREVDTEFSRV9CSVRNQVAoKSwgZXRjLiAgVGhh
dCBpcywgc29tZW9uZSB3YW50cyBhIGJpZ2dpc2ggYml0bWFwDQo+IHdpdGggYSBjZXJ0YWluIG51
bWJlciBvZiBiaXRzLg0KPiANCj4gSGVyZSB0aGUgdHlwZSBkb2Vzbid0IHJlYWxseSBtYXR0ZXIu
DQoNCkV4Y2VwdCBzb21lIGNvZGUgdXNlcyBpdHMgb3duICd1bnNpZ25lZCBsb25nW10nIGluc3Rl
YWQgb2YgREVDQUxSRV9CSVRNQVAuDQoNClRoZSBsb3cgbGV2ZWwgeDg2IGNvZGUgYWN0dWFsbHkg
cGFzc2VzICd1bnNpZ25lZCBpbnRbXScga25vd2luZyB0aGF0DQp0aGUgY2FzdCBoYXBwZW5lZCB0
byBiZSBvay4NCg0KPiBPbiBhbiBhcmNoaXRlY3R1cmUgd2l0aCBnZW51aW5lbHkgYXRvbWljIGJp
dCBvcGVyYXRpb25zIChpLmUuIG5vDQo+IGhhc2hlZCBzcGlubG9ja3MgaW52b2x2ZWQpLCB0aGUg
d2lkdGggcmVhbGx5IHNob3VsZG4ndCBtYXR0ZXIuDQo+IHNldF9iaXQoKSBzaG91bGQgcHJvbWlz
ZSB0byBiZSBhdG9taWMgb24gdGhhdCBiaXQsIHRvIGJlIGEgZnVsbA0KPiBiYXJyaWVyLCBhbmQg
dG8gbm90IG1vZGlmeSBhZGphY2VudCBiaXRzLiAgSSBkb24ndCBzZWUgd2h5IHRoZSB3aWR0aA0K
PiB3b3VsZCBtYXR0ZXIgZm9yIG1vc3QgdXNlIGNhc2VzLiAgSWYgd2UncmUgY29uY2VybmVkLCB0
aGUNCj4gaW1wbGVtZW50YXRpb24gY291bGQgYWN0dWFsbHkgdXNlIHRoZSBsYXJnZXN0IGF0b21p
YyBvcGVyYXRpb24gYW5kDQo+IGp1c3Qgc3VpdGFibHkgYWxpZ24gaXQuICBJT1csIG9uIHg4Niwg
TE9DSyBCVFNRICp3aGVyZSB3ZSBtYW51YWxseQ0KPiBhbGlnbiB0aGUgcG9pbnRlciB0byA4IGJ5
dGVzIGFuZCBhZGp1c3QgdGhlIGJpdCBudW1iZXIgYWNjb3JkaW5nbHkqDQo+IHNob3VsZCBjb3Zl
ciBldmVyeSBwb3NzaWJsZSBjYXNlIGV2ZW4gb2YgUGV0ZXJaJ3MgY29uY2VybnMgYXJlDQo+IGNv
cnJlY3QuDQoNCkEgcHJvcGVybHkgYWJzdHJhY3RlZCBCSVRNQVAgbGlicmFyeSBzaG91bGQgYmUg
YWxsb3dlZCB0byBwZXJtdXRlDQp0aGUgYml0IG51bWJlciB1c2luZyBhIHJ1bi10aW1lIGluaXRp
YWxpc2VkIG1hcC4NCihlZyB4b3Igd2l0aCBhbnkgdmFsdWUgbGVzcyB0aGFuIHRoZSBudW1iZXIg
b2YgYml0cyBpbiAndW5zaWduZWQgbG9uZycuKQ0KT3RoZXJ3aXNlIHlvdSdsbCBhbHdheXMgYWxs
b3cgdGhlIHVzZXIgdG8gJ3BlZWsgaW5zaWRlJy4NCg0KVGhlcmUgaXMgYWxzbzoNCg0KMWEpIEkn
dmUgYSBmaWVsZCBJIG5lZWQgdG8gc2V0IGEgYml0IGluLg0KICBUaGVyZSBtdXN0IGJlIGEgZnVu
Y3Rpb24gdG8gZG8gdGhhdCAoSSBsaWtlIGZ1bmN0aW9ucykuDQogIEFoIHllczoNCglzZXRfYml0
KDMsICZzLT5tKTsNCiAgIEJ1Z2dlciBkb2Vzbid0IGNvbXBpbGUsIHRyeToNCglzZXRfYml0KDMs
ICh2b2lkICopJnMtPm0pOw0KICAgVGhhdCBtdXN0IGJlIGhvdyBJIHNob3VsZCBkbyBpdC4NCg0K
ICAgSVNUUiBhdCBsZWFzdCBvbmUgZHJpdmVyIGRvZXMgdGhhdCB3aGVuIHdyaXRpbmcgcmluZyBi
dWZmZXIgZW50cmllcy4NCg0KMmIpIEkndmUgYSAndTMyW10nLCBpZiBJIGNhc3QgaXQgdG8gJ3Vu
c2lnbmVkIGxvbmcnIEkgY2FuIHVzZSB0aGUgJ2JpdCcgZnVuY3Rpb25zIG9uIGl0Lg0KICAgVGhl
IGRhdGEgbmV2ZXIgY2hhbmdlcyAoYWZ0ZXIgaW5pdGlhbGlzYXRpb24pLCBidXQgSSd2ZSB1c2Ug
dGhlIGF0b21pYyBvcGVyYXRpb25zDQogICBhbnl3YXkuDQoNCj4gRm9yIHRoZSAiSSBoYXZlIGEg
ZmllbGQgaW4gYSBzdHJ1Y3QgYW5kIEkganVzdCB3YW50IGFuIGF0b21pYyBSTVcgdGhhdA0KPiBj
aGFuZ2VzIG9uZSBiaXQqLCBhbiBBUEkgdGhhdCBtYXRjaGVzIHRoZSByZXN0IG9mIHRoZSBhdG9t
aWMgQVBJIHNlZW1zDQo+IG5pY2U6IGp1c3QgYWN0IG9uIGF0b21pY190IGFuZCBhdG9taWM2NF90
Lg0KPiANCj4gVGhlIGN1cnJlbnQgInVuc2lnbmVkIGxvbmciIHRoaW5nIGJhc2ljYWxseSBjYW4n
dCBiZSB1c2VkIG9uIGEgNjQtYml0DQo+IGJpZy1lbmRpYW4gYXJjaGl0ZWN0dXJlIHdpdGggYSAz
Mi1iaXQgZmllbGQgd2l0aG91dCBncm9zcyBoYWNrZXJ5Lg0KDQpXZWxsLCB5b3UgY2FuIHhvciB0
aGUgYml0IG51bWJlciB3aXRoIDYzIG9uIEJFIHN5c3RlbXMuDQpUaGVuIDgvMTYvMzIgc2l6ZWQg
ZmllbGQgbWVtYmVycyB3b3JrIGZpbmUgLSBwcm92aWRlZCB5b3UgZG9uJ3QNCmNhcmUgd2hhdCB2
YWx1ZXMgYXJlIGFjdHVhbGx5IHVzZWQuDQoNCj4gQW5kIHNvbWV0aW1lcyB3ZSBhY3R1YWxseSB3
YW50IGEgMzItYml0IGZpZWxkLg0KPiANCj4gT3IgYW0gSSBtaXNzaW5nIHNvbWUgYW5ub3lpbmcg
c3VidGxlbHkgaGVyZT8NCg0KU29tZSBjb2RlIGhhcyBhc3N1bWVkIERFQ0xBUkVfQklURklFTEQo
KSB1c2VzICd1bnNpZ25lZCBsb25nJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

