Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E70C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66762075E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEAVEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:04:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:46894 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfEAVEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:04:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 14:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,419,1549958400"; 
   d="scan'208";a="147367495"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 01 May 2019 14:04:13 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 1 May 2019 14:04:13 -0700
Received: from crsmsx102.amr.corp.intel.com (172.18.63.137) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 1 May 2019 14:04:12 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.116]) by
 CRSMSX102.amr.corp.intel.com ([169.254.2.124]) with mapi id 14.03.0415.000;
 Wed, 1 May 2019 15:04:10 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base
 as GSBASE at the paranoid_entry
Thread-Topic: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base
 as GSBASE at the paranoid_entry
Thread-Index: AQHU22qy2YcgqOSDVkqDsKh+C1SMYaYcjFAAgBE2kgCAAFfpAIAo3UsAgAA/sgCAAAW8AIAAJw0AgAABWACAAAqsAA==
Date:   Wed, 1 May 2019 21:04:09 +0000
Message-ID: <2B69DB9F-A3FC-4C60-BA51-E11EB9C5877D@intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-9-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904050007050.1802@nanos.tec.linutronix.de>
 <5DCF2089-98EC-42D3-96C3-6ECCDA0B18E2@amacapital.net>
 <C79FA889-BD9B-4427-902F-52EE33A3E6EF@intel.com>
 <CALCETrV4zACb9L_FaU12ZF1O6_vjVyGrcyWwk-mfSUhyxGMXJA@mail.gmail.com>
 <0816B012-44E8-40FB-8003-33C4841CD0E1@intel.com>
 <7029A32B-958E-4C1E-8B5F-D49BA68E4755@intel.com>
 <2863FA6C-F783-4322-9A01-4A2B8A7817A3@amacapital.net>
In-Reply-To: <2863FA6C-F783-4322-9A01-4A2B8A7817A3@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.153.227]
Content-Type: text/plain; charset="utf-8"
Content-ID: <485C925A6CD3324D81341EC8CD671B35@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIE1heSAxLCAyMDE5LCBhdCAxMzoyNSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNh
cGl0YWwubmV0PiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIE1heSAxLCAyMDE5LCBhdCAxOjIx
IFBNLCBCYWUsIENoYW5nIFNlb2sgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT4gd3JvdGU6DQo+
PiANCj4+IA0KPj4+PiBPbiBNYXkgMSwgMjAxOSwgYXQgMTE6MDEsIEJhZSwgQ2hhbmcgU2VvayA8
Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IE9uIE1heSAxLCAy
MDE5LCBhdCAxMDo0MCwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGtlcm5lbC5vcmc+IHdyb3RlOg0K
Pj4+PiANCj4+Pj4gT24gV2VkLCBNYXkgMSwgMjAxOSBhdCA2OjUyIEFNIEJhZSwgQ2hhbmcgU2Vv
ayA8Y2hhbmcuc2Vvay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+
Pj4gT24gQXByIDUsIDIwMTksIGF0IDA2OjUwLCBBbmR5IEx1dG9taXJza2kgPGx1dG9AYW1hY2Fw
aXRhbC5uZXQ+IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+IEZ1cnRoZXJtb3JlLCBpZiB5b3UgZm9s
a3MgZXZlbiB3YW50IG1lIHRvIHJldmlldyB0aGlzIHNlcmllcywgdGhlIHB0cmFjZSB0ZXN0cyBu
ZWVkIHRvIGJlIGluIHBsYWNlLiAgT24gaW5zcGVjdGlvbiBvZiB0aGUgY3VycmVudCBjb2RlIChh
ZnRlciB0aGUgZGViYWNsZSBhIGZldyByZWxlYXNlcyBiYWNrKSwgaXQgYXBwZWFycyB0aGUgU0VU
UkVHU0VU4oCZcyBlZmZlY3QgZGVwZW5kcyBvbiB0aGUgY3VycmVudCB2YWx1ZXMgaW4gdGhlIHJl
Z2lzdGVycyDigJQgaXQgZG9lcyBub3QgYWN0dWFsbHkgc2VlbSB0byByZWxpYWJseSBsb2FkIHRo
ZSB3aG9sZSBzdGF0ZS4gU28gbXkgY29uZmlkZW5jZSB3aWxsIGJlIGdyZWF0bHkgaW5jcmVhc2Vk
IGlmIHlvdXIgc2VyaWVzIGZpcnN0IGFkZHMgYSB0ZXN0IHRoYXQgZGV0ZWN0cyB0aGF0IGJ1ZyAo
YW5kIGZhaWxzISksIHRoZW4gZml4ZXMgdGhlIGJ1ZyBpbiBhIHRpbnkgbGl0dGxlIHBhdGNoLCB0
aGVuIGFkZHMgRlNHU0JBU0UsIGFuZCBrZWVwcyB0aGUgdGVzdCB3b3JraW5nLg0KPj4+Pj4+IA0K
Pj4+Pj4gDQo+Pj4+PiBJIHRoaW5rIEkgbmVlZCB0byB1bmRlcnN0YW5kIHRoZSBpc3N1ZS4gQXBw
cmVjaWF0ZSBpZiB5b3UgY2FuIGVsYWJvcmF0ZSBhIGxpdHRsZSBiaXQuDQo+Pj4+PiANCj4+Pj4g
DQo+Pj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGdpdmVzIGEgcGFydGljdWxhciBiZWhhdmlvciB0byBQ
VFJBQ0VfU0VUUkVHUyBhbmQNCj4+Pj4gUFRSQUNFX1BPS0VVU0VSLiAgVGhlcmUgc2hvdWxkIGJl
IGEgdGVzdCBjYXNlIHRoYXQgdmFsaWRhdGVzIHRoYXQNCj4+Pj4gYmVoYXZpb3IsIGluY2x1ZGlu
ZyB0ZXN0aW5nIHRoZSB3ZWlyZCBjYXNlcyB3aGVyZSBncyAhPSAwIGFuZCBnc2Jhc2UNCj4+Pj4g
Y29udGFpbnMgdW51c3VhbCB2YWx1ZXMuICBTb21lIGV4aXN0aW5nIHRlc3RzIG1pZ2h0IGJlIHBy
ZXR0eSBjbG9zZSB0bw0KPj4+PiBkb2luZyB3aGF0J3MgbmVlZGVkLg0KPj4+PiANCj4+Pj4gQmV5
b25kIHRoYXQsIHRoZSBjdXJyZW50IHB1dHJlZygpIGNvZGUgZG9lcyB0aGlzOg0KPj4+PiANCj4+
Pj4gY2FzZSBvZmZzZXRvZihzdHJ1Y3QgdXNlcl9yZWdzX3N0cnVjdCxnc19iYXNlKToNCj4+Pj4g
ICAgIC8qDQo+Pj4+ICAgICAgKiBFeGFjdGx5IHRoZSBzYW1lIGhlcmUgYXMgdGhlICVmcyBoYW5k
bGluZyBhYm92ZS4NCj4+Pj4gICAgICAqLw0KPj4+PiAgICAgaWYgKHZhbHVlID49IFRBU0tfU0la
RV9NQVgpDQo+Pj4+ICAgICAgICAgcmV0dXJuIC1FSU87DQo+Pj4+ICAgICBpZiAoY2hpbGQtPnRo
cmVhZC5nc2Jhc2UgIT0gdmFsdWUpDQo+Pj4+ICAgICAgICAgcmV0dXJuIGRvX2FyY2hfcHJjdGxf
NjQoY2hpbGQsIEFSQ0hfU0VUX0dTLCB2YWx1ZSk7DQo+Pj4+ICAgICByZXR1cm4gMDsNCj4+Pj4g
DQo+Pj4+IGFuZCBkb19hcmNoX3ByY3RsXzY0KCksIGluIHR1cm4sIGRvZXMgdGhpczoNCj4+Pj4g
DQo+Pj4+IGNhc2UgQVJDSF9TRVRfR1M6IHsNCj4+Pj4gICAgIGlmICh1bmxpa2VseShhcmcyID49
IFRBU0tfU0laRV9NQVgpKQ0KPj4+PiAgICAgICAgIHJldHVybiAtRVBFUk07DQo+Pj4+IA0KPj4+
PiAgICAgcHJlZW1wdF9kaXNhYmxlKCk7DQo+Pj4+ICAgICAvKg0KPj4+PiAgICAgICogQVJDSF9T
RVRfR1MgaGFzIGFsd2F5cyBvdmVyd3JpdHRlbiB0aGUgaW5kZXgNCj4+Pj4gICAgICAqIGFuZCB0
aGUgYmFzZS4gWmVybyBpcyB0aGUgbW9zdCBzZW5zaWJsZSB2YWx1ZQ0KPj4+PiAgICAgICogdG8g
cHV0IGluIHRoZSBpbmRleCwgYW5kIGlzIHRoZSBvbmx5IHZhbHVlIHRoYXQNCj4+Pj4gICAgICAq
IG1ha2VzIGFueSBzZW5zZSBpZiBGU0dTQkFTRSBpcyB1bmF2YWlsYWJsZS4NCj4+Pj4gICAgICAq
Lw0KPj4+PiAgICAgaWYgKHRhc2sgPT0gY3VycmVudCkgew0KPj4+PiAgICAgIFtub3QgdXNlZCBm
b3IgcHRyYWNlXQ0KPj4+PiAgICAgfSBlbHNlIHsNCj4+Pj4gICAgICAgICB0YXNrLT50aHJlYWQu
Z3NpbmRleCA9IDA7DQo+Pj4+ICAgICAgICAgeDg2X2dzYmFzZV93cml0ZV90YXNrKHRhc2ssIGFy
ZzIpOw0KPj4+PiAgICAgfQ0KPj4+PiANCj4+Pj4gICAgIC4uLg0KPj4+PiANCj4+Pj4gU28gd3Jp
dGluZyB0aGUgdmFsdWUgdGhhdCB3YXMgYWxyZWFkeSB0aGVyZSB0byBnc2Jhc2UgdmlhIHB1dHJl
ZygpDQo+Pj4+IGRvZXMgbm90aGluZywgYnV0IHdyaXRpbmcgYSAqZGlmZmVyZW50KiB2YWx1ZSBp
bXBsaWNpdGx5IGNsZWFycyBncywNCj4+Pj4gYnV0IHdyaXRpbmcgYSBkaWZmZXJlbnQgdmFsdWUg
d2lsbCBjbGVhciBncy4NCj4+Pj4gDQo+Pj4+IFRoaXMgYmVoYXZpb3IgaXMsIEFGQUlDVCwgY29t
cGxldGUgbm9uc2Vuc2UuICBJdCBoYXBwZW5zIHRvIHdvcmsNCj4+Pj4gYmVjYXVzZSB1c3VhbGx5
IGdkYiB3cml0ZXMgdGhlIHNhbWUgdmFsdWUgYmFjaywgYW5kLCBpbiBhbnkgY2FzZSwgZ3MNCj4+
Pj4gY29tZXMgKmFmdGVyKiBnc2Jhc2UgaW4gdXNlcl9yZWdzX3N0cnVjdCwgc28gZ3MgZ2V0cyBy
ZXBsYWNlZCBhbnl3YXkuDQo+Pj4+IEJ1dCBJIHRoaW5rIHRoYXQgdGhpcyBiZWhhdmlvciBzaG91
bGQgYmUgZml4ZWQgdXAgYW5kIHByb2JhYmx5IHRlc3RlZC4NCj4+Pj4gQ2VydGFpbmx5IHRoZSBi
ZWhhdmlvciBzaG91bGQgKm5vdCogYmUgdGhlIHNhbWUgb24gYSBmc2dzYmFzZSBrZXJuZWwsDQo+
Pj4+IGFuZCBhbmQgdGhlIGZzZ3NiYXNlIGJlaGF2aW9yIGRlZmluaXRlbHkgbmVlZHMgYSBzZWxm
dGVzdC4NCj4+PiANCj4+PiBPa2F5LCBnb3QgdGhlIHBvaW50OyBub3cgY3J5c3RhbCBjbGVhci4N
Cj4+PiANCj4+PiBJIGhhdmUgbXkgb3duIHRlc3QgY2FzZSBmb3IgdGhhdCB0aG91Z2gsIG5lZWQg
dG8gZmluZCBhIHZlcnkgc2ltcGxlIGFuZA0KPj4+IGFjY2VwdGFibGUgc29sdXRpb24uDQo+Pj4g
DQo+PiANCj4+IE9uZSBzb2x1dGlvbiB0aGF0IEkgcmVjYWxsLCBIUEEgb25jZSBzdWdnZXN0ZWQs
IGlzOg0KPj4gICBXcml0ZSByZWdpc3RlcnMgaW4gYSByZXZlcnNlIG9yZGVyIGZyb20gdXNlcl9y
ZWdzX3N0cnVjdCwgZm9yIFNFVFJFR1MNCj4+IA0KPj4gQXNzdW1pbmcgdGhlc2UgZm9yIGNsYXJp
ZmljYXRpb24sIGZpcnN0Og0KPj4gICAqIG9sZCBhbmQgbmV3IGluZGV4ICE9IDANCj4+ICAgKiB0
YWtpbmcgR1MgYXMgYW4gZXhhbXBsZSB0aG91Z2gsIHNob3VsZCBiZSB0aGUgc2FtZSB3aXRoIEZT
DQo+PiANCj4+IFRoZW4sIGludGVyZXN0aW5nIGNhc2VzIHdvdWxkIGJlIHNvbWV0aGluZyBsaWtl
IHRoZXNlLCB3aXRob3V0IEZTR1NCQVNFOg0KPj4gICBDYXNlIChhKSwgd2hlbiBpbmRleCBvbmx5
IGNoYW5nZWQgdG8gKG5ldyBpbmRleCk6DQo+PiAgICAgICAoVGhlbiwgdGhlIHJlc3VsdCBhZnRl
ciBTRVRSRUdTIHdvdWxkIGJlKQ0KPj4gICAgICAgR1MgPSAobmV3IGluZGV4KSwgR1NCQVNFID0g
dGhlIGJhc2UgZmV0Y2hlZCBmcm9tIChuZXcgaW5kZXgpDQo+PiAgIENhc2UgKGIpLCB3aGVuIGJh
c2Ugb25seSBjaGFuZ2VkIHRvIChuZXcgYmFzZSk6DQo+PiAgIENhc2UgKGMpLCB3aGVuIGJvdGgg
YXJlIGNoYW5nZWQ6DQo+PiAgICAgICBHUyA9IDAsIEdTQkFTRSA9IChuZXcgYmFzZSkNCj4+IA0K
Pj4gTm93LCB3aXRoIEZTR1NCQVNFOg0KPj4gICBDYXNlIChhKToNCj4+ICAgICAgIEdTID0gKG5l
dyBpbmRleCksIEdTQkFTRSA9IChvbGQgYmFzZSkNCj4+ICAgQ2FzZSAoYik6DQo+PiAgICAgICBH
UyA9IChvbGQgaW5kZXgpLCBHU0JBU0UgPSAobmV3IGJhc2UpDQo+PiAgIENhc2UgKGMpOg0KPj4g
ICAgICAgR1MgPSAobmV3IGluZGV4KSwgR1NCQVNFID0gKG5ldyBiYXNlKQ0KPj4gDQo+PiBBcyBh
IHJlZmVyZW5jZSwgdG9kYXkncyBrZXJuZWwgYmVoYXZpb3IsIHdpdGhvdXQgRlNHU0JBU0U6DQo+
PiAgIENhc2UgKGEpOg0KPj4gICAgICAgR1MgPSAobmV3IGluZGV4KSwgR1NCQVNFID0gdGhlIGJh
c2UgZmV0Y2hlZCBmcm9tIChuZXcgaW5kZXgpDQo+PiAgIENhc2UgKGIpOg0KPj4gICAgICAgR1Mg
PSAob2xkIGluZGV4KSwgR1NCQVNFID0gKG9sZCBiYXNlKQ0KPj4gICBDYXNlIChjKToNCj4+ICAg
ICAgIEdTID0gKG5ldyBpbmRleCksIEdTQkFTRSA9IHRoZSBiYXNlIGZldGNoZWQgZnJvbSAobmV3
IGluZGV4KQ0KPj4gDQo+PiBOb3csIHdpdGggdGhhdCByZXZlcnNlIG9yZGVyaW5nIGFuZCB0YWtp
bmcgdGhhdCAiR1NCQVNFIGlzIGltcG9ydGFudCIgWzFdLA0KPj4gaXQgbG9va3MgbGlrZSB0byBi
ZSB3b3JraW5nIGluIHRlcm1zIG9mIGl0cyBiYXNlIHZhbHVlOg0KPj4gICBDYXNlIChiKSBhbmQg
KGMpIHdpbGwgYmVoYXZlIHRoZSBzYW1lIGFzIHdpdGggRlNHU0JBU0UNCj4+ICAgQ2FzZSAoYSkg
c3RpbGwgZGlmZmVycyBiZXR3ZWVuIHcvIGFuZCB3L28gRlNHU0JBU0UuDQo+PiAgICAgICBXZWxs
LCBJJ2Qgc2F5IHRoaXMgYml0IGNvbWVzIGZyb20gdGhlICduZXcgbW9kZWwnIHZzLiB0aGUgJ2xl
YWdjeQ0KPj4gICAgICAgbW9kZWwnLiBTbywgdGhlbiBva2F5IHdpdGggdGhhdC4gQW55IHRob3Vn
aHRzPw0KPj4gDQo+PiANCj4+IA0KPiANCj4gVGhpcyBzZWVtcyBtb3JlIGNvbXBsaWNhdGVkIHRo
YW4gbmVlZGVkLiAgSG93IGFib3V0IHdlIGp1c3QgcmVtb3ZlIGFsbCB0aGUgbWFnaWMgYW5kIG1h
a2UgcHV0cmVnIG9uIHRoZSBiYXNlIHJlZ2lzdGVycyBuZXZlciBjaGFuZ2UgdGhlIHNlbGVjdG9y
Lg0KPiANCg0KSG1tLCBqdXN0IHdvbmRlciB3aGF0J3MgYmVuZWZpdCBpbiB0ZXJtcyBvZiBtYWtp
bmcgYSBub24tRlNHU0JBU0Ugc3lzdGVtDQpiZWhhdmUgIG1vcmUgc2ltaWxhciB0byBvbmUgd2l0
aCBGU0dTQkFTRSAoYWx0aG91Z2ggSSB3b3VsZCBidXkgdGhhdCByZW1vdmFsKS4NCldlbGwsIGlm
IHdlJ3JlIG9rYXkgd2l0aCBzdWNoIGRpdmVyZ2VuY2UsIG1heWJlIHRoYXQncyBpdC4NCg0KPiBB
cyBmYXIgYXMgSSBjYW4gdGVsbCwgdGhlIG9ubHkgZG93bnNpZGUgaXMgdGhhdCwgb24gYSBub24t
RlNHU0JBU0Uga2VybmVsLCBzZXR0aW5nIG9ubHkgdGhlIGJhc2UgaWYgdGhlIHNlbGVjdG9yIGFs
cmVhZHkgaGFzIGEgbm9uemVybyB2YWx1ZSB3b27igJl0IHdvcmssIGJ1dCBJIHdvdWxkIGJlIHF1
aXRlIHN1cnByaXNlZCBpZiB0aGlzIGJyZWFrcyBhbnl0aGluZy4NCg0KDQoNCg==
