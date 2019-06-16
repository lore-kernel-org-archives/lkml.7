Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF54C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769F42085A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfFPPoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:44:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:7286 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfFPPoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:44:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 08:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,382,1557212400"; 
   d="scan'208";a="185491381"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jun 2019 08:44:14 -0700
Received: from fmsmsx116.amr.corp.intel.com (10.18.116.20) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Jun 2019 08:44:14 -0700
Received: from crsmsx104.amr.corp.intel.com (172.18.63.32) by
 fmsmsx116.amr.corp.intel.com (10.18.116.20) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Jun 2019 08:44:14 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.187]) by
 CRSMSX104.amr.corp.intel.com ([169.254.6.16]) with mapi id 14.03.0439.000;
 Sun, 16 Jun 2019 09:44:12 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 01/18] x86/fsgsbase/64: Fix ARCH_SET_FS/GS behaviors
 for a remote task
Thread-Topic: [PATCH v7 01/18] x86/fsgsbase/64: Fix ARCH_SET_FS/GS behaviors
 for a remote task
Thread-Index: AQHVBb/onKwUkeAk7kuRgUjnvLmEiKZh3xmAgDpUuACAAtnzgA==
Date:   Sun, 16 Jun 2019 15:44:11 +0000
Message-ID: <9040CFCD-74BD-4C17-9A01-B9B713CF6B10@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
 <1557309753-24073-2-git-send-email-chang.seok.bae@intel.com>
 <74F4F506-2913-4013-9D81-A0C69FA8CDF1@intel.com>
 <6420E1A5-B5AD-4028-AA91-AA4D5445AC83@intel.com>
In-Reply-To: <6420E1A5-B5AD-4028-AA91-AA4D5445AC83@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.190.226]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7F5C17AC34B854BB5D8F34778C50E7F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEp1biAxNCwgMjAxOSwgYXQgMTM6MTEsIEJhZSwgQ2hhbmcgU2VvayA8Y2hhbmcuc2Vv
ay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+IA0KPj4gT24gTWF5IDgsIDIwMTksIGF0IDEwOjI1
LCBCYWUsIENoYW5nIFNlb2sgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT4gd3JvdGU6DQo+PiAN
Cj4+PiBPbiBNYXkgOCwgMjAxOSwgYXQgMDM6MDIsIEJhZSwgQ2hhbmcgU2VvayA8Y2hhbmcuc2Vv
ay5iYWVAaW50ZWwuY29tPiB3cm90ZToNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
a2VybmVsL3B0cmFjZS5jIGIvYXJjaC94ODYva2VybmVsL3B0cmFjZS5jDQo+Pj4gaW5kZXggNGI4
ZWUwNS4uMzMwOWNmZSAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHRyYWNlLmMN
Cj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHRyYWNlLmMNCj4+PiBAQCAtMzk2LDIyICszOTYs
MTIgQEAgc3RhdGljIGludCBwdXRyZWcoc3RydWN0IHRhc2tfc3RydWN0ICpjaGlsZCwNCj4+PiAJ
Y2FzZSBvZmZzZXRvZihzdHJ1Y3QgdXNlcl9yZWdzX3N0cnVjdCxmc19iYXNlKToNCj4+PiAJCWlm
ICh2YWx1ZSA+PSBUQVNLX1NJWkVfTUFYKQ0KPj4+IAkJCXJldHVybiAtRUlPOw0KPj4+IC0JCS8q
DQo+Pj4gLQkJICogV2hlbiBjaGFuZ2luZyB0aGUgRlMgYmFzZSwgdXNlIGRvX2FyY2hfcHJjdGxf
NjQoKQ0KPj4+IC0JCSAqIHRvIHNldCB0aGUgaW5kZXggdG8gemVybyBhbmQgdG8gc2V0IHRoZSBi
YXNlDQo+Pj4gLQkJICogYXMgcmVxdWVzdGVkLg0KPj4+IC0JCSAqLw0KPj4+IC0JCWlmIChjaGls
ZC0+dGhyZWFkLmZzYmFzZSAhPSB2YWx1ZSkNCj4+PiAtCQkJcmV0dXJuIGRvX2FyY2hfcHJjdGxf
NjQoY2hpbGQsIEFSQ0hfU0VUX0ZTLCB2YWx1ZSk7DQo+Pj4gKwkJeDg2X2ZzYmFzZV93cml0ZV9j
cHUoY2hpbGQsIHZhbHVlKTsNCj4gDQo+IFRoaXMgc2hvdWxkIGJlIHg4Nl9mc2Jhc2Vfd3JpdGVf
dGFzaygpIGluc3RlYWQgb2YgKmNwdSgpDQo+IA0KPj4+IAkJcmV0dXJuIDA7DQo+Pj4gCWNhc2Ug
b2Zmc2V0b2Yoc3RydWN0IHVzZXJfcmVnc19zdHJ1Y3QsZ3NfYmFzZSk6DQo+Pj4gLQkJLyoNCj4+
PiAtCQkgKiBFeGFjdGx5IHRoZSBzYW1lIGhlcmUgYXMgdGhlICVmcyBoYW5kbGluZyBhYm92ZS4N
Cj4+PiAtCQkgKi8NCj4+PiAJCWlmICh2YWx1ZSA+PSBUQVNLX1NJWkVfTUFYKQ0KPj4+IAkJCXJl
dHVybiAtRUlPOw0KPj4+IC0JCWlmIChjaGlsZC0+dGhyZWFkLmdzYmFzZSAhPSB2YWx1ZSkNCj4+
PiAtCQkJcmV0dXJuIGRvX2FyY2hfcHJjdGxfNjQoY2hpbGQsIEFSQ0hfU0VUX0dTLCB2YWx1ZSk7
DQo+Pj4gKwkJeDg2X2dzYmFzZV93cml0ZV9jcHUoY2hpbGQsIHZhbHVlKTsNCj4gDQo+IFRoaXMg
c2hvdWxkIGJlIGFsc28geDg2X2dzYmFzZV93cml0ZV90YXNrKCkgaW5zdGVhZCBvZiAqY3B1KCkN
Cj4gDQo+Pj4gDQo+PiANCj4+IEhtbSwgc29ycnkgdGhlcmUgaXMgYSBnbGl0Y2guICBBdCBsZWFz
dCwgaW50ZW5kZWQgdGhpcyB0aXRsZSB0byBiZQ0KPj4g4oCcRml4IHB0cmFjZS1pbmR1Y2VkIEZT
L0dTQkFTRSB3cml0ZSBiZWhhdmlvcuKAnSBhbmQgbm8gY2hhbmdlcw0KPj4gaW4gdGhlIFBSQ1RM
LiBXaWxsIGZpeCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPj4gDQo+IA0KPiBIaSBUaG9tYXMsIA0K
PiANCj4gRHVlIHRvIHRoZSBpc3N1ZXMgb24gdGhpcyBwYXRjaCAtIG15IGFwb2xvZ2llcywgSSB3
YXMgb3JpZ2luYWxseQ0KPiBjb25zaWRlcmluZyB0aGUgdjguIEdpdmVuIHlvdXIgcmUtd3JpdGUg
YW5kIGNvbW1lbnRzIG9uIHRoZSBsYXN0IA0KPiBwYXRjaCAodGhlIGRvY3VtZW50YXRpb24pLCBh
dCBsZWFzdCBJIHdhbnQvbmVlZCB0byBnaXZlIG15IGhlYWRzLXVwLg0KPiANCj4gVGhhbmtzLA0K
PiBDaGFuZw0KDQpbIEluY2x1ZGUgTEtNTCBiYWNrLiBVbmludGVudGlvbmFsbHksIGl0IHdhcyBt
aXNzZWQuIF0NCg0KTG9va3MgYnVpbGQgZXJyb3Igd2FzIHJlcG9ydGVkIHdpdGggdGhpcy4gU29y
cnkgYWdhaW4gZm9yIHRoZSBub2lzZS4NCkJlbG93IHBhdGNoIHdhcyBwcmVwYXJlZCB0byBmaXgg
YW5kIHRvIHNlbmQgd2l0aCB2ODoNCg0KRnJvbSBjOWFhN2Y2YzczMDZhYTQ2YjNlY2JiMjY2OTg5
NzE4YzFiMWRjODVlIE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogIkNoYW5nIFMuIEJh
ZSIgPGNoYW5nLnNlb2suYmFlQGludGVsLmNvbT4NCkRhdGU6IFdlZCwgMSBNYXkgMjAxOSAwODow
Njo0NSAtMDcwMA0KU3ViamVjdDogeDg2L2ZzZ3NiYXNlLzY0OiBGaXggcHRyYWNlLWluZHVjZWQg
RlMvR1NCQVNFIHdyaXRpbmcgYmVoYXZpb3JzDQoNCldoZW4gYSBwdHJhY2VyIHdyaXRlcyB0byBh
IHB0cmFjZWUncyBGUy9HU0JBU0Ugd2l0aCBhIGRpZmZlcmVudCB2YWx1ZSwNCnRoZSBzZWxlY3Rv
ciBpcyBhbHNvIGNsZWFyZWQuIFRoaXMgYmVoYXZpb3IgaXMgbm90IHN0cmFpZ2h0Zm9yd2FyZC4N
Cg0KVGhlIGNoYW5nZSB3aWxsIG1ha2UgdGhlIGJlaGF2aW9yIHNpbXBsZSBhbmQgc2Vuc2libGUs
IGFzIGl0IHdpbGwNCihvbmx5KSB1cGRhdGUgdGhlIGJhc2Ugd2hlbiByZXF1ZXN0ZWQuIEFsc28s
IHRoZSBjb25kaXRpb24gY2hlY2sgZm9yDQpjb21wYXJpbmcgdGhlIGJhc2UgaXMgcmVtb3ZlZCB0
byBtYWtlIG1vcmUgc2ltcGxlLiBJdCBtaWdodCBzYXZlIGEgZmV3DQpjeWNsZXMsIGJ1dCB0aGlz
IHBhdGggaXMgbm90IHBlcmZvcm1hbmNlIGNyaXRpY2FsLg0KDQpUaGUgb25seSByZWNvZ25pemFi
bGUgZG93bnNpZGUgb2YgdGhpcyBjaGFuZ2UgaXMgd2hlbiB3cml0aW5nIHRoZSBiYXNlDQppZiB0
aGUgc2VsZWN0b3IgaXMgYWxyZWFkeSBub256ZXJvLiBUaGUgYmFzZSB3aWxsIGJlIHJlbG9hZGVk
IGFjY29yZGluZw0KdG8gdGhlIHNlbGVjdG9yLiBCdXQgdGhlIGNhc2UgaXMgaGlnaGx5IHVuZXhw
ZWN0ZWQgaW4gcmVhbCB1c2FnZXMuDQoNClN1Z2dlc3RlZC1ieTogQW5keSBMdXRvbWlyc2tpIDxs
dXRvQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBDaGFuZyBTLiBCYWUgPGNoYW5nLnNlb2su
YmFlQGludGVsLmNvbT4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4N
CkNjOiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4NCkNjOiBILiBQZXRlciBBbnZpbiA8
aHBhQHp5dG9yLmNvbT4NCkNjOiBBbmRpIEtsZWVuIDxha0BsaW51eC5pbnRlbC5jb20+DQotLS0N
CiBhcmNoL3g4Ni9rZXJuZWwvcHRyYWNlLmMgfCAxNCArKy0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC94ODYva2VybmVsL3B0cmFjZS5jIGIvYXJjaC94ODYva2VybmVsL3B0cmFjZS5jDQppbmRl
eCBhMTY2Yzk2Li4zMTA4Y2RjIDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL3B0cmFjZS5j
DQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvcHRyYWNlLmMNCkBAIC0zOTcsMjIgKzM5NywxMiBAQCBz
dGF0aWMgaW50IHB1dHJlZyhzdHJ1Y3QgdGFza19zdHJ1Y3QgKmNoaWxkLA0KIAljYXNlIG9mZnNl
dG9mKHN0cnVjdCB1c2VyX3JlZ3Nfc3RydWN0LGZzX2Jhc2UpOg0KIAkJaWYgKHZhbHVlID49IFRB
U0tfU0laRV9NQVgpDQogCQkJcmV0dXJuIC1FSU87DQotCQkvKg0KLQkJICogV2hlbiBjaGFuZ2lu
ZyB0aGUgRlMgYmFzZSwgdXNlIGRvX2FyY2hfcHJjdGxfNjQoKQ0KLQkJICogdG8gc2V0IHRoZSBp
bmRleCB0byB6ZXJvIGFuZCB0byBzZXQgdGhlIGJhc2UNCi0JCSAqIGFzIHJlcXVlc3RlZC4NCi0J
CSAqLw0KLQkJaWYgKGNoaWxkLT50aHJlYWQuZnNiYXNlICE9IHZhbHVlKQ0KLQkJCXJldHVybiBk
b19hcmNoX3ByY3RsXzY0KGNoaWxkLCBBUkNIX1NFVF9GUywgdmFsdWUpOw0KKwkJeDg2X2ZzYmFz
ZV93cml0ZV90YXNrKGNoaWxkLCB2YWx1ZSk7DQogCQlyZXR1cm4gMDsNCiAJY2FzZSBvZmZzZXRv
ZihzdHJ1Y3QgdXNlcl9yZWdzX3N0cnVjdCxnc19iYXNlKToNCi0JCS8qDQotCQkgKiBFeGFjdGx5
IHRoZSBzYW1lIGhlcmUgYXMgdGhlICVmcyBoYW5kbGluZyBhYm92ZS4NCi0JCSAqLw0KIAkJaWYg
KHZhbHVlID49IFRBU0tfU0laRV9NQVgpDQogCQkJcmV0dXJuIC1FSU87DQotCQlpZiAoY2hpbGQt
PnRocmVhZC5nc2Jhc2UgIT0gdmFsdWUpDQotCQkJcmV0dXJuIGRvX2FyY2hfcHJjdGxfNjQoY2hp
bGQsIEFSQ0hfU0VUX0dTLCB2YWx1ZSk7DQorCQl4ODZfZ3NiYXNlX3dyaXRlX3Rhc2soY2hpbGQs
IHZhbHVlKTsNCiAJCXJldHVybiAwOw0KICNlbmRpZg0KIAl9DQotLSANCjIuNy40DQoNCg0K
