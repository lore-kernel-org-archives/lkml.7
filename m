Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A017BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B9B205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 09:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLPJ70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 04:59:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37377 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727036AbfLPJ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 04:59:26 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-YTZyHXAxOrWjw6ETI5Awig-1; Mon, 16 Dec 2019 09:59:20 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Dec 2019 09:59:20 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Dec 2019 09:59:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVsSQN6yBAo1s5f0Kws0hZvGpx8qe8iNtw
Date:   Mon, 16 Dec 2019 09:59:20 +0000
Message-ID: <8d880a468c6242b9a951a83716ddeb07@AcuMS.aculab.com>
References: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
 <20191121185303.GB199273@romley-ivt3.sc.intel.com>
 <20191121202508.GZ4097@hirez.programming.kicks-ass.net>
 <CALCETrXbe_q07kL1AyaNaAqgUHsdN6rEDzzZ0CEtv-k9VvQL0A@mail.gmail.com>
 <20191122092555.GA4097@hirez.programming.kicks-ass.net>
 <3908561D78D1C84285E8C5FCA982C28F7F4DD19F@ORSMSX115.amr.corp.intel.com>
 <20191122203105.GE2844@hirez.programming.kicks-ass.net>
 <CALCETrVjXC7RHZCkAcWEeCrJq7DPeVBooK8S3mG0LT8q9AxvPw@mail.gmail.com>
 <20191211175202.GQ2827@hirez.programming.kicks-ass.net>
 <CALCETrXUZ790WFk9SEzuiKg-wMva=RpWhZNYPf+MqzT0xdu+gg@mail.gmail.com>
 <20191211223407.GT2844@hirez.programming.kicks-ass.net>
 <CALCETrUr+LwpQm5caeKgXGhaZ87HmcNn4wTsmkPzTEptp6sC6g@mail.gmail.com>
In-Reply-To: <CALCETrUr+LwpQm5caeKgXGhaZ87HmcNn4wTsmkPzTEptp6sC6g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: YTZyHXAxOrWjw6ETI5Awig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDEyIERlY2VtYmVyIDIwMTkgMTk6NDENCj4g
T24gV2VkLCBEZWMgMTEsIDIwMTkgYXQgMjozNCBQTSBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBEZWMgMTEsIDIwMTkgYXQgMTA6
MTI6NTZBTSAtMDgwMCwgQW5keSBMdXRvbWlyc2tpIHdyb3RlOg0KPiANCj4gPiA+ID4gU3VyZSwg
YnV0IHdlJ3JlIHRhbGtpbmcgdHdvIGNwdXMgaGVyZS4NCj4gPiA+ID4NCj4gPiA+ID4gICAgICAg
ICB1MzIgdmFyID0gMDsNCj4gPiA+ID4gICAgICAgICB1OCAqcHRyID0gJnZhcjsNCj4gPiA+ID4N
Cj4gPiA+ID4gICAgICAgICBDUFUwICAgICAgICAgICAgICAgICAgICBDUFUxDQo+ID4gPiA+DQo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGNoZyhwdHIsIDEpDQo+ID4g
PiA+DQo+ID4gPiA+ICAgICAgICAgeGNoZygocHRyKzEsIDEpOw0KPiA+ID4gPiAgICAgICAgIHIg
PSBSRUFEX09OQ0UodmFyKTsNCj4gPiA+ID4NCj4gPiA+ID4gQUZBSUNUIG5vdGhpbmcgZ3VhcmFu
dGVlcyByID09IDB4MDEwMS4gVGhlIENQVTEgc3RvcmUgY2FuIGJlIHN0dWNrIGluDQo+ID4gPiA+
IENQVTEncyBzdG9yZS1idWZmZXIuIENQVTAncyB4Y2hnKCkgZG9lcyBub3Qgb3ZlcmxhcCBhbmQg
dGhlcmVmb3JlDQo+ID4gPiA+IGRvZXNuJ3QgZm9yY2UgYSBzbm9vcCBvciBmb3J3YXJkLg0KPiA+
ID4NCj4gPiA+IEkgdGhpbmsgSSBkb24ndCBxdWl0ZSB1bmRlcnN0YW5kLiAgVGhlIGZpbmFsIHZh
bHVlIG9mIHZhciBoYWQgYmV0dGVyDQo+ID4gPiBiZSAweDAxMDEgb3Igc29tZXRoaW5nIGlzIHNl
dmVyZWx5IHdyb25nLg0KPiA+DQo+ID4gPiBCdXQgciBjYW4gYmUgMHgwMTAwIGJlY2F1c2UNCj4g
PiA+IG5vdGhpbmcgaW4gdGhpcyBleGFtcGxlIGd1YXJhbnRlZXMgdGhhdCB0aGUgdG90YWwgb3Jk
ZXIgb2YgdGhlIGxvY2tlZA0KPiA+ID4gaW5zdHJ1Y3Rpb25zIGhhcyBDUFUgMSdzIGluc3RydWN0
aW9uIGZpcnN0Lg0KPiA+DQo+ID4gQXNzdW1pbmcgQ1BVMSBnb2VzIGZpcnN0LCB3aHkgd291bGQg
dGhlIGxvYWQgZnJvbSBDUFUwIHNlZSBDUFUxJ3MNCj4gPiBwdHJbMF0/IEl0IGNhbiBiZSBpbiBD
UFUxIHN0b3JlIGJ1ZmZlciwgYW5kIFRTTyBhbGxvd3MgcmVndWxhciByZWFkcyB0bw0KPiA+IGln
bm9yZSAocmVtb3RlKSBzdG9yZS1idWZmZXJzLg0KPiANCj4gV2hhdCBJJ20gc2F5aW5nIGlzOiBp
ZiBDUFUwIGdvZXMgZmlyc3QsIHRoZW4gdGhlIHRocmVlIG9wZXJhdGlvbnMgb3JkZXIgYXM6DQo+
IA0KPiANCj4gDQo+IHhjaGcocHRyKzEsIDEpOw0KPiByID0gUkVBRF9PTkNFKHZhcik7ICAvKiAw
eDAxMDAgKi8NCj4geGNoZyhwdHIsIDEpOw0KPiANCj4gQW55d2F5LCB0aGlzIGlzIGFsbCBhIGJp
dCB0b28gaHlwb3RoZXRpY2FsIGZvciBtZS4gIElzIHRoZXJlIGEgY2xlYXINCj4gZXhhbXBsZSB3
aGVyZSB0aGUgdG90YWwgb3JkZXJpbmcgb2YgTE9DS2VkIGluc3RydWN0aW9ucyBpcyBvYnNlcnZh
YmxlPw0KPiAgVGhhdCBpcywgaXMgdGhlcmUgYSBzZXF1ZW5jZSBvZiBvcGVyYXRpb25zIG9uLCBw
cmVzdW1hYmx5LCB0d28gb3INCj4gdGhyZWUgQ1BVcywgc3VjaCB0aGF0IExPQ0tlZCBpbnN0cnVj
dGlvbnMgYmVpbmcgb25seSBwYXJ0aWFsbHkgb3JkZXJlZA0KPiBhbGxvd3MgYW4gb3V0Y29tZSB0
aGF0IGlzIGRpc2FsbG93ZWQgYnkgYSB0b3RhbCBvcmRlcmluZz8gIEkgc3VzcGVjdA0KPiB0aGVy
ZSBpcywgYnV0IEkgaGF2ZW4ndCBjb21lIHVwIHdpdGggaXQgeWV0LiAgKEkgbWVhbiBpbiBhbiB4
ODYtbGlrZQ0KPiBtZW1vcnkgbW9kZWwuICBHZXR0aW5nIHRoaXMgaW4gYSByZWxheGVkIGF0b21p
YyBtb2RlbCBpcyBlYXN5LikNCj4gDQo+IEFzIGEgcHJvYmFibHkgYmFkIGV4YW1wbGU6DQo+IA0K
PiB1MzIgeDAsIHgxLCBhMSwgYjAsIGIxOw0KPiANCj4gQ1BVIDA6DQo+IHhjaGcoJngwLCAxKTsN
Cj4gYmFycmllcigpOw0KPiBhMSA9IFJFQURfT05DRSh4MSk7DQo+IA0KPiBDUFUgMToNCj4geGNo
ZygmYiwgMSk7DQo+IA0KPiBDUFUgMjoNCj4gYjEgPSBSRUFEX09OQ0UoeDEpOw0KPiBzbXBfcm1i
KCk7ICAvKiB3aGljaCBpcyBqdXN0IGJhcnJpZXIoKSBvbiB4ODYgKi8NCj4gYjAgPSBSRUFEX09O
Q0UoeDApOw0KPiANCj4gU3VwcG9zZSBhMSA9PSAwIGFuZCBiMSA9PSAxLiAgVGhlbiB3ZSBrbm93
IHRoYXQgQ1BVMCdzIFJFQURfT05DRQ0KPiBoYXBwZW5lZCBiZWZvcmUgQ1BVMSdzIHhjaGcgYW5k
IGhlbmNlIENQVTAncyB4Y2hnIGhhcHBlbmVkIGJlZm9yZQ0KPiBDUFUxJ3MgeGNoZy4gIFdlIGFs
c28ga25vdyB0aGF0IENQVTIncyBmaXJzdCByZWFkIG9ic2VydmVkIHRoZSB3cml0ZQ0KPiBmcm9t
IENQVTEncyB4Y2hnLCB3aGljaCBtZWFucyB0aGF0IENQVTIncyBzZWNvbmQgcmVhZCBzaG91bGQg
aGF2ZSBiZWVuDQo+IGFmdGVyIENQVTAncyB4Y2hnIChiZWNhdXNlIHRoZSB4Y2hnIG9wZXJhdGlv
bnMgaGF2ZSBhIHRvdGFsIG9yZGVyDQo+IGFjY29yZGluZyB0byB0aGUgU0RNKS4gIFRoaXMgbWVh
bnMgdGhhdCBiMCBjYW4ndCBiZSAwLg0KPiANCj4gSGVuY2UgdGhlIG91dGNvbWUgKGExLCBiMSwg
YjApID09ICgwLCAxLCAwKSBpcyBkaXNhbGxvd2VkLg0KPiANCj4gSXQncyBlbnRpcmVseSBwb3Nz
aWJsZSB0aGF0IEkgc2NyZXdlZCB1cCB0aGUgYW5hbHlzaXMuICBCdXQgSSB0aGluaw0KPiB0aGlz
IG1lYW5zIHRoYXQgdGhlIGNhY2hlIGNvaGVyZW5jeSBtZWNoYW5pc20gaXMgZG9pbmcgc29tZXRo
aW5nIG1vcmUNCj4gaW50ZWxsaWdlbnQgdGhhbiBqdXN0IHNob3ZpbmcgdGhlIHgwPTEgd3JpdGUg
aW50byB0aGUgc3RvcmUgYnVmZmVyIGFuZA0KPiBsZXR0aW5nIGl0IGhhbmcgb3V0IHRoZXJlLiAg
U29tZXRoaW5nIG5lZWRzIHRvIG1ha2Ugc3VyZSB0aGF0IENQVSAyDQo+IG9ic2VydmVzIGV2ZXJ5
dGhpbmcgaW4gdGhlIHNhbWUgb3JkZXIgdGhhdCBDUFUgMCBvYnNlcnZlcywgYW5kLCBhcyBmYXIN
Cj4gYXMgSSBrbm93IGl0LCB0aGVyZSBpcyBhIGNvbnNpZGVyYWJsZSBhbW91bnQgb2YgY29tcGxl
eGl0eSBpbiB0aGUgQ1BVcw0KPiB0aGF0IG1ha2VzIHN1cmUgdGhpcyBoYXBwZW5zLg0KPiANCj4g
U28gaGVyZSdzIG15IHF1ZXN0aW9uOiBkbyB5b3UgaGF2ZSBhIGNvbmNyZXRlIGV4YW1wbGUgb2Yg
YSBzZXJpZXMgb2YNCj4gb3BlcmF0aW9ucyBhbmQgYW4gb3V0Y29tZSB0aGF0IHlvdSBzdXNwZWN0
IEludGVsIENQVXMgYWxsb3cgYnV0IHRoYXQNCj4gaXMgZGlzYWxsb3dlZCBpbiB0aGUgU0RNPw0K
DQpJJ20gbm90IHN1cmUgdGhhdCBleGFtcGxlIGlzIGF0IGFsbCByZWxldmFudC4NClJFQURfT05D
RSgpIGRvZXNuJ3QgaGF2ZSBhbnkgc2VxdWVuY2luZyByZXF1aXJlbWVudHMgb24gdGhlIGNwdSwg
anVzdCBvbiB0aGUgY29tcGlsZXIuDQooVGhlIHNhbWUgaXMgdHJ1ZSBvZiBhbnkgJ2F0b21pYyBy
ZWFkJy4pDQpMb2NrcyB3b3JrIGJlY2F1c2UgdGhlIFJNVyBvcGVyYXRpb24gaXMgYXRvbWljLCBh
bGwgd3JpdGVzIG9jY3VyIGluIHNlcXVlbmNlDQphbmQgKEkgdGhpbmspIHJlYWRzIGNhbm5vdCAn
b3ZlcnRha2UnIHRoZSBSTVcgc2VxdWVuY2UuDQpJbiBwYXJ0aWN1bGFyIHlvdSBkb24ndCB3YW50
IHNwZWN1bGF0aXZlIHJlYWRzIGJlaW5nIGRvbmUgYmVmb3JlIHRoZSBSTVcNCmluc3RydWN0aW9u
IGNvbXBsZXRlcy4NCkkgYmVsaWV2ZSB0aGF0LCBvbiB4ODYsIHRoaXMgaXMgZ3VhcmFudGVlZCB3
aXRob3V0IHJlcXVpcmluZyBhbiBMRkVOQ0UgcHJvdmlkZWQNCnRoZXJlIGFyZSBubyBub24tdGVt
cG9yYWwgKGllIGNhY2hlIGJ5cGFzc2luZykgb3Igd3JpdGUtY29tYmluaW5nIG1lbW9yeSBjeWNs
ZXMuDQpPdGhlciBhcmNoaXRlY3R1cmVzIHJlcXVpcmUgYWRkaXRpb25hbCBzb2Z0d2FyZS4NCg0K
VG8gZ2V0IGFueSBraW5kIG9mIGhhcmR3YXJlIGludGVybG9jayBmcm9tIGEgcmVhZCAoZWcgb2Yg
YW4gYXRvbWljIGNvdW50ZXIpDQp5b3UgbmVlZCB0byByZWFkIGl0IHdpdGggYSBSTVcgY3ljbGUg
KGVnIFhBREQgJDAsbWVtb3J5KS4NCg0KVGhlIHBvaW50IGFib3V0IGJpcygmeCwxKSBhbmQgYmlz
KCYoeCsxKSwxKSBpcyB0aGF0LCBpcyB5b3Ugd2FpdCBsb25nIGVub3VnaA0KeW91J2xsIGFsd2F5
cyBzZWUgYm90aCBiaXRzIHNldC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

