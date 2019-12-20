Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A14AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9B824683
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLTK7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:59:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59824 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727177AbfLTK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:59:37 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-6-_nn-FqbbNh-qOyl_rRohbA-1;
 Fri, 20 Dec 2019 10:59:34 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 20 Dec 2019 10:59:33 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 20 Dec 2019 10:59:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@amacapital.net>
CC:     Brian Gerst <brgerst@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: RE: [PATCH] x86: Remove force_iret()
Thread-Topic: [PATCH] x86: Remove force_iret()
Thread-Index: AQHVtuhWtS7aVpT6VkyrDyqz06b2R6fCyteggAAITICAAAFfwA==
Date:   Fri, 20 Dec 2019 10:59:33 +0000
Message-ID: <227c8442919d44a790370870aaba416c@AcuMS.aculab.com>
References: <431a146f6461402da61d09fff155f35b@AcuMS.aculab.com>
 <D890A7DA-542B-42A7-8F82-CDBA6EBCA958@amacapital.net>
In-Reply-To: <D890A7DA-542B-42A7-8F82-CDBA6EBCA958@amacapital.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: _nn-FqbbNh-qOyl_rRohbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDIwIERlY2VtYmVyIDIwMTkgMTA6MzANCj4g
PiBPbiBEZWMgMjAsIDIwMTksIGF0IDY6MTAgUE0sIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4g77u/RnJvbTogQnJpYW4gR2Vyc3QNCj4gPj4g
U2VudDogMjAgRGVjZW1iZXIgMjAxOSAwMzo0OA0KPiA+Pj4gT24gVGh1LCBEZWMgMTksIDIwMTkg
YXQgODo1MCBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+ID4+
Pg0KPiA+Pj4gT24gVGh1LCBEZWMgMTksIDIwMTkgYXQgMzo1OCBBTSBCcmlhbiBHZXJzdCA8YnJn
ZXJzdEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4gZm9yY2VfaXJldCgpIHdhcyBv
cmlnaW5hbGx5IGludGVuZGVkIHRvIHByZXZlbnQgdGhlIHJldHVybiB0byB1c2VyIG1vZGUgd2l0
aA0KPiA+Pj4+IHRoZSBTWVNSRVQgb3IgU1lTRVhJVCBpbnN0cnVjdGlvbnMsIGluIGNhc2VzIHdo
ZXJlIHRoZSByZWdpc3RlciBzdGF0ZSBjb3VsZA0KPiA+Pj4+IGhhdmUgYmVlbiBjaGFuZ2VkIHRv
IGJlIGluY29tcGF0aWJsZSB3aXRoIHRob3NlIGluc3RydWN0aW9ucy4NCj4gPj4+DQo+ID4+PiBJ
dCdzIG1vcmUgdGhhbiB0aGF0LiAgQmVmb3JlIHRoZSBiaWcgc3lzY2FsbCByZXdvcmssIHdlIGRp
ZG4ndCByZXN0b3JlDQo+ID4+PiB0aGUgY2FsbGVyLXNhdmVkIHJlZ3MuICBTZWU6DQo+ID4+Pg0K
PiA+Pj4gY29tbWl0IDIxZDM3NWI2YjM0ZmY1MTFhNTA3ZGUyN2JmMzE2YjNkZGU2OTM4ZDkNCj4g
Pj4+IEF1dGhvcjogQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+DQo+ID4+PiBEYXRl
OiAgIFN1biBKYW4gMjggMTA6Mzg6NDkgMjAxOCAtMDgwMA0KPiA+Pj4NCj4gPj4+ICAgIHg4Ni9l
bnRyeS82NDogUmVtb3ZlIHRoZSBTWVNDQUxMNjQgZmFzdCBwYXRoDQo+ID4+Pg0KPiA+Pj4gU28g
aWYgeW91IGNoYW5nZWQgcjEyLCBmb3IgZXhhbXBsZSwgdGhlIGNoYW5nZSB3b3VsZCBnZXQgbG9z
dC4NCj4gPj4NCj4gPj4gZm9yY2VfaXJldCgpIHNwZWNpZmljYWxseSBkZWFsdCB3aXRoIGNoYW5n
ZXMgdG8gQ1MsIFNTIGFuZCBFRkxBR1MuDQo+ID4+IFNhdmluZyBhbmQgcmVzdG9yaW5nIHRoZSBl
eHRyYSByZWdpc3RlcnMgd2FzIGEgZGlmZmVyZW50IHByb2JsZW0NCj4gPj4gYWx0aG91Z2ggaXQg
YWZmZWN0ZWQgdGhlIHNhbWUgZnVuY3Rpb25zIGxpa2UgcHRyYWNlLCBzaWduYWxzLCBhbmQNCj4g
Pj4gZXhlYy4NCj4gPg0KPiA+IElzIGl0IGV2ZXIgcG9zc2libGUgZm9yIGFueSBvZiB0aGUgc2Vn
bWVudCByZWdpc3RlcnMgdG8gcmVmZXIgdG8gdGhlIExEVA0KPiA+IGFuZCBmb3IgYW5vdGhlciB0
aHJlYWQgdG8gaW52YWxpZGF0ZSB0aGUgZW50cmllcyAndmVyeSBsYXRlJyA/DQo+IA0KPiBOb3Qg
aW4gbmV3ZXIga2VybmVscywgYmVjYXVzZSB0aGUgYWN0dWFsIExEVCBpcyBuZXZlciBtb2RpZmll
ZC4NCj4gSW5zdGVhZCwgTERUIGNoYW5nZXMgY3JlYXRlIGEgd2hvbGUgbmV3IExEVCBhbmQgcHJv
cGFnYXRlIGl0IHdpdGggYW4gSVBJLg0KDQpDYW4gdGhlIElQSSBiZSBkaXNhYmxlZCB0aHJvdWdo
IHRoZSBTWVNSRVQgcGF0aD8NCk9uY2UgaW4gdXNlciBzcGFjZSwgdGhlIElQSSB3aWxsIGludGVy
cnVwdCB0aGUgcHJvY2VzcyBhbmQsIEkgcHJlc3VtZSwgaXQgd2lsbA0KcGljayB1cCB0aGUgbmV3
IExEVCBvbiAncmV0dXJuIHRvIHVzZXInLg0KQnV0IGlmIHRoZSBJUEkgaGFwcGVucyBiZXR3ZWVu
IHRoZSBMRFQgYmVpbmcgc2V0IGFuZCBTWVNSRVQgaXQgd2lsbCAocHJlc3VtYWJseSkNCnJlbWFp
biAncGVuZGluZycgdW50aWwgdGhlIG5leHQgc3lzdGVtIGNhbGw/DQpXaGljaCBjb3VsZCBiZSBs
b25nIGVub3VnaCBmb3Igb25lIHRocmVhZCB0byBoYXZlIHBhc3NlZCBhIHBvaW50ZXIgYWNyb3Nz
IGdpdmluZw0KYW4gdW5leHBlY3RlZCBTRUdWIChvciBtYXliZSB3b3JzZSwgZmFpbGluZyB0byBn
aXZlIGFuIGV4cGVjdGVkIG9uZSkuDQoNCj4gQnV0IHRoZSBJUkVUIHBhdGggY2FuIGZhaWwgZHVl
IHRvIGNoYW5nZXMgdG8gdGhlIHNlbGVjdG9ycyB3aGlsZSBpbiB0aGUga2VybmVsLCBkdWUgdG8g
c2lncmV0dXJuIG9yIHB0cmFjZS4gIFdlIGhhdmUgZGVsaWdodGZ1bCBzZWxmdGVzdHMNCj4gZm9y
IHRoaXMuDQo+IA0KPiA+DQo+ID4gU28gZXZlbiB0aG91Z2ggdGhlIHZhbHVlcyB3ZXJlIHZhbGlk
IHdoZW4gY2hhbmdlZCwgdGhleSBhcmUNCj4gPiBpbnZhbGlkIGR1cmluZyB0aGUgJ3JldHVybiB0
byB1c2VyJyBzZXF1ZW5jZS4NCj4gPg0KPiA+IEkgcmVtZW1iZXIgd3JpdGluZyBhIHNpZ25hbCBo
YW5kbGVyIHRoYXQgJ2NvcnJ1cHRlZCcgYWxsIHRoZQ0KPiA+IHNlZ21lbnQgcmVnaXN0ZXJzIChl
dGMpIGFuZCBmaXhpbmcgdGhlIE5ldEJTRCBrZXJuZWwgdG8gaGFuZGxlDQo+ID4gYWxsIHRoZSBm
YXVsdHMgcmVzdG9yaW5nIHRoZSBzZWdtZW50IHJlZ2lzdGVycyBhbmQgSVJFVCBmYXVsdGluZw0K
PiA+IGluIGtlcm5lbCAoSUlSQyBpbnZhbGlkIHVzZXIgJVNTIG9yICVDUykuDQo+ID4gKElSRVQg
Y2FuIGFsc28gZmF1bHQgaW4gdXNlciBzcGFjZSwgYnV0IHRoYXQgaXMgYSBub3JtYWwgZmF1bHQu
KQ0KPiANCj4gRGlkIHlvdSByZW1lbWJlciB0byB0ZXN0IHRoZSAjTlAgY2FzZT8gIE1hbnkga2Vy
bmVscyBmb3Jnb3QgdGhhdCB0aGlzIHdhcyBwb3NzaWJsZSA6KQ0KDQpUaGF0IG1pZ2h0IGhhdmUg
YmVlbiB3aHkgSSB3YXMgZml4aW5nIGl0Lg0KSSBjZXJ0YWlubHkgdGVzdGVkIHRoZSBjYXNlcyB3
aGVyZSBsb2FkaW5nIHRoZSB1c2VyIHNlZ21lbnQgcmVnaXN0ZXJzIGZhdWx0ZWQgaW4ga2VybmVs
DQooYWZ0ZXIgbG9hZGluZyB0aGUgdXNlci1HUykgYW5kIHdoZXJlIElSRVQgZmF1bHRlZCBpbiBr
ZXJuZWwuDQpJIGZpeGVkIHVwIHRoZSBzdGFjayBpbiB0aGUgaW50ZXJydXB0IGVudHJ5IGNvZGUg
dG8gbWFrZSBpdCBhbGwgYXBwZWFyIHRvIGJlIGEgZmF1bHQNCmluIHVzZXItc3BhY2UgKGRlbGV0
aW5nIG9uZSBvZiB0aGUgdHJhcCBmcmFtZXMpLg0KVGhpcyBhbHNvIHN0b3BzIHJlcGVhdGVkIGZh
dWx0cyBnZXR0aW5nIGZ1cnRoZXIgYW5kIGZ1cnRoZXIgZG93biB0aGUga2VybmVsIHN0YWNrLg0K
DQo+ID4gSXMgaXQgYWN0dWFsbHkgY2hlYXBlciB0byBwcm9wZXJseSB2YWxpZGF0ZSB0aGUgc2Vn
bWVudCByZWdpc3RlcnMsDQo+ID4gb3IgdGFrZSB0aGUgJ2hpdCcgb2YgdGhlIHNsaWdodGx5IHNs
b3dlciBJUkVUIHBhdGggYW5kIGdldCB0aGUgY3B1DQo+ID4gdG8gZG8gaXQgZm9yIHlvdT8NCj4g
DQo+IFRoZSB2YWxpZGF0aW9uIHdl4oCZcmUgdGFsa2luZyBhYm91dCBpcyBmb3IgU1lTUkVULCBu
b3QgSVJFVC4gIEl0IGhhcyBpdHMgb3duIHNldCBvZiBuYXN0eSBjb25kaXRpb25zIGludm9sdmlu
ZyBFRkxBR1MsIFIxMSwgUklQLCBhbmQgUkNYLg0KPiBGb3J0dW5hdGVseSBubyBzZWdtZW50cyBh
cmUgaW52b2x2ZWQuIFRoZSBhbGdvcml0aG0gaXMsIHJvdWdobHk6DQo+IA0KPiBpZiAob2theSBm
b3IgU1lTUkVUKSB7DQo+ICAgU1lTUkVUIChhbmQgYXNzdW1lIGl0IGNhbuKAmXQgZmFpbCkNCj4g
fSBlbHNlIHsNCj4gICBpZiAobmVlZCBFU1BGSVgpDQo+ICAgIEhvcnJpYmxlIGhhY2tzOw0KPiAg
IElSRVQ7DQo+IH0NCg0KT2ssIEkgd2FzIHBhcnQgd29ycmllZCB5b3Ugd2VyZSBmb3JjaW5nICdv
a2F5IGZvciBTWVNSRVQnIHRvIDEuDQogDQo+IEFuZCB3ZSBoYW5kbGUgI0dQLCAjU1MsICNOUCBh
bmQgI0RGIGZyb20gSVJFVC4gQW5kIHdlIGhhdmUgc2VsZnRlc3RzIGZvciBhbGwgb2YgdGhpcy4N
Cg0KWWVzLCBpdCB3b3VsZCBiZSBiZXN0IGlmIElSRVQgb25seSBldmVyIGZhdWx0ZWQgaW4gdXNl
ci1zcGFjZS4NCg0KPiBBbmQgbm8gb25lIHJ1bnMgdGhlIGJsb29keSBzZWxmdGVzdHMgb24gMzIt
Yml0IGtlcm5lbHMsIHJlc3VsdGluZyBpbiB0cnVseSBhd2Z1bCBidWdzLg0KDQpJIHN1c3BlY3Qg
SSBkaWRuJ3QgdHJ5IGhhcmQgZW5vdWdoIHRvIGdldCBGUy9HUyBhbmQgRlNCQVNFL0dTQkFTRSBj
b3JyZWN0bHkgcmVzdG9yZWQuDQooR2l2ZW4gdGhhdCB0aGUgc2VnbWVudCBkZXNjcmlwdG9ycyBt
YXkgbm90IGNvbnRhaW4gdGhlIHJlcXVpcmVkIHZhbHVlcy4pDQoNCj4gV2UgY2Fu4oCZdCBoYW5k
bGUgI0dQIGZyb20gU1lTUkVULiBUaGFua3MsIEludGVsLg0KPiANCj4gKEFNRCBnZXRzIHRoaXMg
bW9yZSByaWdodC4gU1lTUkVUIGlzIHN0aWxsIGEgdHVyZCwgYnV0IGl0IGNhbuKAmXQgZmF1bHQu
IEludGVsIGhhbmRsZXMgUklQIGNhbm9uaWNhbCBjaGVja3MgZGlmZmVyZW50bHkgZnJvbSBBTUQs
IGFuZCBTWVNSRVQNCj4gd2lsbCAjR1AgaWYgUkNYIGlzIG5vbmNhbm9uaWNhbC4gIFRoZSByZXN1
bHQgd2FzIHByaXZpbGVnZSBlc2NhbGF0aW9uIG9uIGJhc2ljYWxseSBldmVyeSBPUyB3aGVuIHRo
aXMgd2FzIG5vdGljZWQuKQ0KDQpZZXMsIGFsbCB0aGUgJ2Zhc3Qgc3lzdGVtIGNhbGwnIGluc3Ry
dWN0aW9ucyB3ZXJlIGJhZGx5IHRob3VnaHQgb3V0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

