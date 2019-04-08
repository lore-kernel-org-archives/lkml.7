Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E2C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959D620870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDHLM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:12:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40106 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbfDHLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:12:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-20-AjA7cPB9PDOJ66cwZ66R5A-1; Mon, 08 Apr 2019 12:12:25 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 8 Apr 2019 12:13:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Apr 2019 12:13:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Robin Murphy' <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mulu He <muluhe@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Mike Leach" <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>
CC:     Rajendra Nayak <rnayak@codeaurora.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] stm class: Fix out of bound access from bitmap allocation
Thread-Topic: [PATCH] stm class: Fix out of bound access from bitmap
 allocation
Thread-Index: AQHU66qDw2WxOhX8lUugt3I8pBQU16YtixUwgASIUaqAAAHoUP//9OSAgAAR1aA=
Date:   Mon, 8 Apr 2019 11:13:33 +0000
Message-ID: <fcc635f7984a4fe786e37f4c04a6cd86@AcuMS.aculab.com>
References: <20190405122256.27840-1-saiprakash.ranjan@codeaurora.org>
 <fe3a301b03b84761a08d5b15962b8110@AcuMS.aculab.com>
 <dd266f56-b4ea-dc6b-eab1-50e13c820166@codeaurora.org>
 <850ba66b-0e4a-2027-5640-0ee339a7868c@arm.com>
 <2d5e435bf7b344fb835fc58ac36e1c19@AcuMS.aculab.com>
 <f3a699e5-a6c4-83f4-fff3-20515e8caa06@arm.com>
In-Reply-To: <f3a699e5-a6c4-83f4-fff3-20515e8caa06@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: AjA7cPB9PDOJ66cwZ66R5A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5DQo+IFNlbnQ6IDA4IEFwcmlsIDIwMTkgMTE6NTINCj4gT24gMDgv
MDQvMjAxOSAxMTozMywgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IFJvYmluIE11cnBo
eQ0KPiA+PiBTZW50OiAwOCBBcHJpbCAyMDE5IDExOjI0DQo+ID4+IE9uIDA3LzA0LzIwMTkgMDU6
MzEsIFNhaSBQcmFrYXNoIFJhbmphbiB3cm90ZToNCj4gPj4+IE9uIDQvNS8yMDE5IDY6NDQgUE0s
IERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4+PiBGcm9tOiBTYWkgUHJha2FzaCBSYW5qYW4NCj4g
Pj4+Pj4NCj4gPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHd0cmFjaW5nL3N0bS9jb3JlLmMg
Yi9kcml2ZXJzL2h3dHJhY2luZy9zdG0vY29yZS5jDQo+ID4+Pj4+IGluZGV4IDkzY2UzYWE3NDBh
OS4uMjFhNTgzOGY2ZTY3IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL2h3dHJhY2luZy9z
dG0vY29yZS5jDQo+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvaHd0cmFjaW5nL3N0bS9jb3JlLmMNCj4g
Pj4+Pj4gQEAgLTE2OCw3ICsxNjgsNyBAQCBzdGF0aWMgaW50IHN0cF9tYXN0ZXJfYWxsb2Moc3Ry
dWN0IHN0bV9kZXZpY2UNCj4gPj4+Pj4gKnN0bSwgdW5zaWduZWQgaW50IGlkeCkNCj4gPj4+Pj4g
IMKgwqDCoMKgwqAgc3RydWN0IHN0cF9tYXN0ZXIgKm1hc3RlcjsNCj4gPj4+Pj4gIMKgwqDCoMKg
wqAgc2l6ZV90IHNpemU7DQo+ID4+Pj4+DQo+ID4+Pj4+IC3CoMKgwqAgc2l6ZSA9IEFMSUdOKHN0
bS0+ZGF0YS0+c3dfbmNoYW5uZWxzLCA4KSAvIDg7DQo+ID4+Pj4+ICvCoMKgwqAgc2l6ZSA9IEFM
SUdOKHN0bS0+ZGF0YS0+c3dfbmNoYW5uZWxzLCBTVE1fTUFTVEVSX1NaKSAvDQo+ID4+Pj4+IFNU
TV9NQVNURVJfU1o7DQo+ID4+Pj4NCj4gPj4+PiBJJ20gbm90IHN1cmUgdGhhdCB1c2luZyBTVFBf
TUFTVEVSX1NaIGltcHJvdmVzIHJlYWRhYmlsaXR5IGF0IGFsbC4NCj4gPj4+Pg0KPiA+Pj4NCj4g
Pj4+IEkgdGhvdWdodCBpdCB3YXMgYmV0dGVyIHRvIGhhdmUgYSBtYWNybyB0aGFuIGRpcmVjdGx5
IHNwZWNpZnlpbmcNCj4gPj4+IHNpemVvZih1bnNpZ25lZCBsb25nKSwgYW55d2F5cyBJIGNhbiBj
aGFuZ2UgaXQuDQo+ID4+Pg0KPiA+Pj4+IElzIHRoZXJlIHNvbWV0aGluZyB0aGF0IGdpdmVzIHRo
ZSBzaXplIG9mIGEgYml0bWFwIGZvciAnbicgaXRlbXM/DQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBO
b3Qgc3VyZSBpZiB0aGVyZSBpcyBzb21ldGhpbmcuDQo+ID4+DQo+ID4+IElmIHlvdSB3ZXJlIHRv
IGFzayB0aGUgcXVlc3Rpb24gImhvdyBkb2VzIHRoZSBiaXRtYXAgY29kZSBpdHNlbGYga25vdw0K
PiA+PiB3aGF0IHRoZSB0b3RhbCBzaXplIG9mIGEgYml0bWFwIGlzPyIsIHRoYXQgd291bGQgcXVp
Y2tseSBsZWFkIHlvdQ0KPiA+PiB0b3dhcmRzIEJJVFNfVE9fTE9OR1MoKSA7KQ0KPiA+Pg0KPiA+
PiBBbmQgZ2l2ZW4gdGhhdCBzdHBfbWFzdGVyOjpjaGFuX21hcCBpcyBhbHJlYWR5IGFuIGFwcHJv
cHJpYXRlIHR5cGUsIHRoYXQNCj4gPj4gc3VnZ2VzdHMgc2ltcGxpZnlpbmcgdGhlIGVudGlyZSBj
YWxjdWxhdGlvbiBkb3duIHRvIHNvbWV0aGluZyBuZWF0IGFuZA0KPiA+PiB0aWR5IGxpa2U6DQo+
ID4+DQo+ID4+IHNpemUgPSBvZmZzZXRvZihzdHJ1Y3Qgc3RwX21hc3RlciwgY2hhbl9tYXBbQklU
U19UT19MT05HUyhzdG0tPmRhdGEtPnN3X25jaGFubmVscyldKTsNCj4gPg0KPiA+IEV4Y2VwdCB0
aGF0IGlzIGludmFsaWQuDQo+ID4gWW91IGNhbid0IHVzZSBvZmZzZXRvZigpIHdpdGggc29tZXRo
aW5nIHRoYXQgaXNuJ3QgYSBjb21waWxlIHRpbWUgY29uc3RhbnQuDQo+IA0KPiBPaCwgSSBzZWUg
dGhlIHN0YW5kYXJkIGRvZXMgYWN0dWFsbHkgc2F5IHRoYXQsIGFsdGhvdWdoIHRoZXJlIHNlZW0g
dG8gYmUNCj4gZW5vdWdoIG5vbi1jb25zdGFudCB1c2VzIGluIHRoZSBrZXJuZWwgdG8gc3VnZ2Vz
dCB0aGF0IGl0IHN0aWxsIHdvcmtzIGluDQo+IHByYWN0aWNlLg0KDQpPbmUgb2YgdGhlIGNvbXBp
bGVycyB3ZSB1c2UgaGVyZSBjb21wbGFpbnMgYWJvdXQgaXQgLSB3b24ndCBiZSBhIGxpbnV4IG9u
ZS4NCkl0IGFsc28gZmFpbHMgdG8gZ2VuZXJhdGUgY29tcGlsZSB0aW1lIGNvbnN0YW50cyAoZm9y
IHN0YXRpYyBpbml0aWFsaXNlcnMpDQppZiB5b3UgbXVsdGlwbHkgb3IgZGl2aWRlIHRoZSByZXN1
bHQgb2YgYW55dGhpbmcgdGhhdCBsb29rcyBsaWtlIG9mZnNldG9mKCkNCmFwcGxpZWQgdG8gYW4g
YXJyYXkgZWxlbWVudCAod2hpY2ggaXMgYSBidWcpLg0KDQpJJ2QgZ3Vlc3MgdGhhdCB0aGUgcmVx
dWlyZW1lbnQgaW4gdGhlIHN0YW5kYXJkIHdhcyBhZGRlZCBiZWNhdXNlIHNvbWUNCmNvbXBpbGVy
cyB3ZXJlIGdlbmVyYXRpbmcgYSByZXN1bHQgdGhhdCB3YXNuJ3QgYSBjb21waWxlLXRpbWUgY29u
c3RhbnQNCmFuZCBubyBvbmUgdGhvdWdodCB5b3UnZCB3YW50IHRvIHBhc3MgYSBub24tY29uc3Rh
bnQgYXJndW1lbnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

