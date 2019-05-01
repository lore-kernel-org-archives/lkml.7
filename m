Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0252C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8772085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 13:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfEANxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 09:53:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:44567 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfEANw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 09:52:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 06:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="145139334"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga008.fm.intel.com with ESMTP; 01 May 2019 06:52:56 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 1 May 2019 06:52:56 -0700
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 1 May 2019 06:52:56 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.116]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.91]) with mapi id 14.03.0415.000;
 Wed, 1 May 2019 07:52:53 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base
 as GSBASE at the paranoid_entry
Thread-Topic: [RESEND PATCH v6 08/12] x86/fsgsbase/64: Use the per-CPU base
 as GSBASE at the paranoid_entry
Thread-Index: AQHU22qy2YcgqOSDVkqDsKh+C1SMYaYcjFAAgBE2kgCAAFfpAIAo3UsA
Date:   Wed, 1 May 2019 13:52:52 +0000
Message-ID: <C79FA889-BD9B-4427-902F-52EE33A3E6EF@intel.com>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com>
 <1552680405-5265-9-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1903251003090.1798@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1904050007050.1802@nanos.tec.linutronix.de>
 <5DCF2089-98EC-42D3-96C3-6ECCDA0B18E2@amacapital.net>
In-Reply-To: <5DCF2089-98EC-42D3-96C3-6ECCDA0B18E2@amacapital.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.48.92]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D45D011BB5F73448B22D78C6D10E8E0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEFwciA1LCAyMDE5LCBhdCAwNjo1MCwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFtYWNh
cGl0YWwubmV0PiB3cm90ZToNCj4gDQo+IA0KPiANCj4+IE9uIEFwciA1LCAyMDE5LCBhdCAyOjM1
IEFNLCBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4gd3JvdGU6DQo+PiANCj4+
PiBPbiBNb24sIDI1IE1hciAyMDE5LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4+IE9uIEZy
aSwgMTUgTWFyIDIwMTksIENoYW5nIFMuIEJhZSB3cm90ZToNCj4+Pj4gRU5UUlkocGFyYW5vaWRf
ZXhpdCkNCj4+Pj4gICBVTldJTkRfSElOVF9SRUdTDQo+Pj4+ICAgRElTQUJMRV9JTlRFUlJVUFRT
KENMQlJfQU5ZKQ0KPj4+PiAgIFRSQUNFX0lSUVNfT0ZGX0RFQlVHDQo+Pj4+ICsgICAgQUxURVJO
QVRJVkUgImptcCAuTHBhcmFub2lkX2V4aXRfbm9fZnNnc2Jhc2UiLCAgICAibm9wIixcDQo+Pj4+
ICsgICAgICAgIFg4Nl9GRUFUVVJFX0ZTR1NCQVNFDQo+Pj4+ICsgICAgd3Jnc2Jhc2UgICAgJXJi
eA0KPj4+PiArICAgIGptcCAgICAuTHBhcmFub2lkX2V4aXRfbm9fc3dhcGdzOw0KPj4+IA0KPj4+
IEFnYWluLiBBIGZldyBuZXdsaW5lcyB3b3VsZCBtYWtlIGl0IG1vcmUgcmVhZGFibGUuDQo+Pj4g
DQo+Pj4gVGhpcyBtb2RpZmllcyB0aGUgc2VtYW50aWNzIG9mIHBhcmFub2lkX2VudHJ5IGFuZCBw
YXJhbm9pZF9leGl0LiBMb29raW5nIGF0DQo+Pj4gdGhlIHVzYWdlIHNpdGVzIHRoZXJlIGlzIHRo
ZSBmb2xsb3dpbmcgY29kZSBpbiB0aGUgbm1pIG1hemU6DQo+Pj4gDQo+Pj4gICAvKg0KPj4+ICAg
ICogVXNlIHBhcmFub2lkX2VudHJ5IHRvIGhhbmRsZSBTV0FQR1MsIGJ1dCBubyBuZWVkIHRvIHVz
ZSBwYXJhbm9pZF9leGl0DQo+Pj4gICAgKiBhcyB3ZSBzaG91bGQgbm90IGJlIGNhbGxpbmcgc2No
ZWR1bGUgaW4gTk1JIGNvbnRleHQuDQo+Pj4gICAgKiBFdmVuIHdpdGggbm9ybWFsIGludGVycnVw
dHMgZW5hYmxlZC4gQW4gTk1JIHNob3VsZCBub3QgYmUNCj4+PiAgICAqIHNldHRpbmcgTkVFRF9S
RVNDSEVEIG9yIGFueXRoaW5nIHRoYXQgbm9ybWFsIGludGVycnVwdHMgYW5kDQo+Pj4gICAgKiBl
eGNlcHRpb25zIG1pZ2h0IGRvLg0KPj4+ICAgICovDQo+Pj4gICBjYWxsICAgIHBhcmFub2lkX2Vu
dHJ5DQo+Pj4gICBVTldJTkRfSElOVF9SRUdTDQo+Pj4gDQo+Pj4gICAvKiBwYXJhbm9pZGVudHJ5
IGRvX25taSwgMDsgd2l0aG91dCBUUkFDRV9JUlFTX09GRiAqLw0KPj4+ICAgbW92cSAgICAlcnNw
LCAlcmRpDQo+Pj4gICBtb3ZxICAgICQtMSwgJXJzaQ0KPj4+ICAgY2FsbCAgICBkb19ubWkNCj4+
PiANCj4+PiAgIC8qIEFsd2F5cyByZXN0b3JlIHN0YXNoZWQgQ1IzIHZhbHVlIChzZWUgcGFyYW5v
aWRfZW50cnkpICovDQo+Pj4gICBSRVNUT1JFX0NSMyBzY3JhdGNoX3JlZz0lcjE1IHNhdmVfcmVn
PSVyMTQNCj4+PiANCj4+PiAgIHRlc3RsICAgICVlYngsICVlYnggICAgICAgICAgICAvKiBzd2Fw
Z3MgbmVlZGVkPyAqLw0KPj4+ICAgam56ICAgIG5taV9yZXN0b3JlDQo+Pj4gbm1pX3N3YXBnczoN
Cj4+PiAgIFNXQVBHU19VTlNBRkVfU1RBQ0sNCj4+PiBubWlfcmVzdG9yZToNCj4+PiAgIFBPUF9S
RUdTDQo+Pj4gDQo+Pj4gSSBtaWdodCBiZSBtaXNzaW5nIHNvbWV0aGluZywgYnV0IGhvdyBpcyB0
aGF0IHN1cHBvc2VkIHRvIHdvcmsgd2hlbg0KPj4+IHBhcmFub2lkX2VudHJ5IHVzZXMgRlNHU0JB
U0U/IEkgdGhpbmsgaXQncyBicm9rZW4sIGJ1dCBpZiBpdCdzIG5vdCB0aGVuDQo+Pj4gdGhlcmUg
aXMgYSBiaWcgZmF0IGNvbW1lbnQgbWlzc2luZyBleHBsYWluaW5nIHdoeS4NCj4+IA0KPj4gU28g
dGhpcyBfaXNfIGJyb2tlbi4NCj4+IA0KPj4gIE9uIGVudHJ5Og0KPj4gDQo+PiAgICAgcmJ4ID0g
cmRnc2Jhc2UoKQ0KPj4gICAgIHdyZ3NiYXNlKEtFUk5FTF9HUykNCj4+IA0KPj4gIE9uIGV4aXQ6
DQo+PiANCj4+ICAgICBpZiAoZWJ4ID09IDApDQo+PiAgICAgICAgICBzd2FwZ3MNCj4+IA0KPj4g
VGhlIHJlc3VsdGluZyBtYXRyaXg6DQo+PiANCj4+ICB8ICBFTlRSWSBHUyAgICB8IFJCWCAgICAg
ICAgfCBFWElUICAgICAgICB8IEdTIG9uIElSRVQgICAgfCBSRVNVTFQNCj4+ICB8ICAgICAgICB8
ICAgICAgICB8ICAgICAgICB8ICAgICAgICB8DQo+PiAxIHwgIEtFUk5FTF9HUyAgICB8IEtFUk5F
TF9HUyAgICB8IEVCWCA9PSAwICAgIHwgVVNFUl9HUyAgICB8IEZBSUwNCj4+ICB8ICAgICAgICB8
ICAgICAgICB8ICAgICAgICB8ICAgICAgICB8DQo+PiAyIHwgIEtFUk5FTF9HUyAgICB8IEtFUk5F
TF9HUyAgICB8IEVCWCAhPSAwICAgIHwgS0VSTkVMX0dTICAgIHwgb2sNCj4+ICB8ICAgICAgICB8
ICAgICAgICB8ICAgICAgICB8ICAgICAgICB8DQo+PiAzIHwgIFVTRVJfR1MgICAgfCBVU0VSX0dT
ICAgIHwgRUJYID09IDAgICAgfCBVU0VSX0dTICAgIHwgb2sNCj4+ICB8ICAgICAgICB8ICAgICAg
ICB8ICAgICAgICB8ICAgICAgICB8DQo+PiA0IHwgIFVTRVJfR1MgICAgfCBVU0VSX0dTICAgIHwg
RUJYICE9IDAgICAgfCBLRVJORUxfR1MgICAgfCBGQUlMDQo+PiANCj4+IA0KPj4gIzEgSnVzdCB3
b3JrcyBieSBjaGFuY2UgYmVjYXVzZSBpdCdzIHVubGlrZWx5IHRoYXQgdGhlIGxvd2VyIDMyYml0
cyBvZiBhDQo+PiAgcGVyIENQVSBrZXJuZWwgR1MgYXJlIGFsbCAwLg0KPj4gDQo+PiAgQnV0IGl0
J3MganVzdCBhIHF1ZXN0aW9uIG9mIHByb2JhYmlsaXR5IHRoYXQgdGhpcyB0dXJucyBpbnRvIGEN
Cj4+ICBub24tZGVidWdnYWJsZSBvbmNlIHBlciB5ZWFyIGNyYXNoICh0aGluayBLQVNMUikuDQo+
PiANCj4+ICM0IFRoaXMgY2FuIGhhcHBlbiB3aGVuIHRoZSBOTUkgaGl0cyB0aGUga2VybmVsIGlu
IHNvbWUgb3RoZXIgZW50cnkgY29kZQ0KPj4gIF9CRUZPUkVfIG9yIF9BRlRFUl8gc3dhcGdzLg0K
Pj4gDQo+PiAgVXNlciBzcGFjZSB1c2luZyBHUyBhZGRyZXNzaW5nIHdpdGggR1NbMzE6MF0gIT0g
MCB3aWxsIGNyYXNoIGFuZCBidXJuLg0KPj4gDQo+PiANCj4gDQo+IEhpIGFsbC0NCj4gDQo+IElu
IGEgcHJldmlvdXMgaW5jYXJuYXRpb24gb2YgdGhlc2UgcGF0Y2hlcywgSSBjb21wbGFpbmVkIGFi
b3V0IHRoZSB1c2Ugb2YgU1dBUEdTIGluIHRoZSBwYXJhbm9pZCBwYXRoLiBOb3cgSeKAmW0gcHV0
dGluZyBteSBtYWludGFpbmVyIGZvb3QgZG93bi4gIE9uIGEgbm9uLUZTR1NCQVNFIHN5c3RlbSwg
dGhlIHBhcmFub2lkIHBhdGgga25vd24sIGRlZmluaXRpdmVseSwgd2hpY2ggR1MgaXMgd2hlcmUs
IHNvIFNXQVBHUyBpcyBhbm5veWluZy4gV2l0aCBGU0dTQkFTRSwgdW5sZXNzIHlvdSBzdGFydCBs
b29raW5nIGF0IHRoZSBSSVAgdGhhdCB5b3UgaW50ZXJydXB0ZWQsIHlvdSBjYW5ub3Qga25vdyB3
aGV0aGVyIHlvdSBoYXZlIHVzZXIgb3Iga2VybmVsIEdTQkFTRSBsaXZlLCBzaW5jZSB0aGV5IGNh
biBoYXZlIGxpdGVyYWxseSB0aGUgc2FtZSB2YWx1ZS4gIE9uZSBvZiB0aGUgbnVtZXJvdXMgdmVy
c2lvbnMgb2YgdGhpcyBwYXRjaCBjb21wYXJlZCB0aGUgdmFsdWVzIGFuZCBqdXN0IHNhaWQg4oCc
d2VsbCwgaXTigJlzIGhhcm1sZXNzIHRvIFNXQVBHUyBpZiB1c2VyIGNvZGUgaGFwcGVucyB0byB1
c2UgdGhlIHNhbWUgdmFsdWUgYXMgdGhlIGtlcm5lbOKAnS4gIEkgY29tcGxhaW5lZCB0aGF0IGl0
IHdhcyBmYXIgdG9vIGZyYWdpbGUuDQo+IA0KPiBTbyBJ4oCZbSBwdXR0aW5nIG15IGZvb3QgZG93
bi4gSWYgeW91IGFsbCB3YW50IG15IGFjaywgeW914oCZcmUgZ29pbmcgdG8gc2F2ZSB0aGUgb2xk
IEdTLCBsb2FkIHRoZSBuZXcgb25lIHdpdGggV1JHU0JBU0UsIGFuZCwgb24gcmV0dXJuLCB5b3Xi
gJlyZSBnb2luZyB0byByZXN0b3JlIHRoZSBvbGQgb25lIHdpdGggV1JHU0JBU0UuIFlvdSB3aWxs
IG5vdCB1c2UgU1dBUEdTIGluIHRoZSBwYXJhbm9pZCBwYXRoLg0KPiANCj4gT2J2aW91c2x5LCBm
b3IgdGhlIG5vbi1wYXJhbm9pZCBwYXRoLCBpdCBhbGwga2VlcHMgd29ya2luZyBleGFjdGx5IGxp
a2UgaXQgZG9lcyBub3cuDQoNCkFsdGhvdWdoIEkgY2FuIHNlZSBzb21lIG90aGVyIGNvbmNlcm5z
IHdpdGggdGhpcywgbG9va3MgbGlrZSBpdCBpcyBzdGlsbCB3b3J0aCBwdXJzdWluZy4NCg0KPiAN
Cj4gRnVydGhlcm1vcmUsIGlmIHlvdSBmb2xrcyBldmVuIHdhbnQgbWUgdG8gcmV2aWV3IHRoaXMg
c2VyaWVzLCB0aGUgcHRyYWNlIHRlc3RzIG5lZWQgdG8gYmUgaW4gcGxhY2UuICBPbiBpbnNwZWN0
aW9uIG9mIHRoZSBjdXJyZW50IGNvZGUgKGFmdGVyIHRoZSBkZWJhY2xlIGEgZmV3IHJlbGVhc2Vz
IGJhY2spLCBpdCBhcHBlYXJzIHRoZSBTRVRSRUdTRVTigJlzIGVmZmVjdCBkZXBlbmRzIG9uIHRo
ZSBjdXJyZW50IHZhbHVlcyBpbiB0aGUgcmVnaXN0ZXJzIOKAlCBpdCBkb2VzIG5vdCBhY3R1YWxs
eSBzZWVtIHRvIHJlbGlhYmx5IGxvYWQgdGhlIHdob2xlIHN0YXRlLiBTbyBteSBjb25maWRlbmNl
IHdpbGwgYmUgZ3JlYXRseSBpbmNyZWFzZWQgaWYgeW91ciBzZXJpZXMgZmlyc3QgYWRkcyBhIHRl
c3QgdGhhdCBkZXRlY3RzIHRoYXQgYnVnIChhbmQgZmFpbHMhKSwgdGhlbiBmaXhlcyB0aGUgYnVn
IGluIGEgdGlueSBsaXR0bGUgcGF0Y2gsIHRoZW4gYWRkcyBGU0dTQkFTRSwgYW5kIGtlZXBzIHRo
ZSB0ZXN0IHdvcmtpbmcuDQo+IA0KDQpJIHRoaW5rIEkgbmVlZCB0byB1bmRlcnN0YW5kIHRoZSBp
c3N1ZS4gQXBwcmVjaWF0ZSBpZiB5b3UgY2FuIGVsYWJvcmF0ZSBhIGxpdHRsZSBiaXQuDQoNCj4g
4oCUQW5keQ0KDQo=
