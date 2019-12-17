Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C23DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3CF207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfLQKDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:03:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:52706 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727120AbfLQKDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:03:19 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-113-DJi9NBNYOi6lksLiOsDj3w-1; Tue, 17 Dec 2019 10:03:16 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 17 Dec 2019 10:03:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 17 Dec 2019 10:03:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, "Will Deacon" <will@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVsSQN6yBAo1s5f0Kws0hZvGpx8qe8iNtwgAB/vgCAAAOJwIAACIuAgAEIbNA=
Date:   Tue, 17 Dec 2019 10:03:15 +0000
Message-ID: <ac9634cf8e054380acd13178743019d4@AcuMS.aculab.com>
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
 <8d880a468c6242b9a951a83716ddeb07@AcuMS.aculab.com>
 <CALCETrW1LDuzcnvav=MY1bUv4jQ25n30La5m5x8tXfDknfV_cQ@mail.gmail.com>
 <053a199934844aef9745d7398494b5a0@AcuMS.aculab.com>
 <CALCETrWvq9XMTse=9JTtnVYY+U2pGcF-nP=YHvEFq4htxbfGwA@mail.gmail.com>
In-Reply-To: <CALCETrWvq9XMTse=9JTtnVYY+U2pGcF-nP=YHvEFq4htxbfGwA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: DJi9NBNYOi6lksLiOsDj3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDE2IERlY2VtYmVyIDIwMTkgMTg6MDYNCi4u
DQo+IFRoaXMgd2hvbGUgZGlzY3Vzc2lvbiBpcyBhYm91dCB0aGUgZmFjdCB0aGF0IFBldGVyWiBp
cyBzY2VwdGljYWwgdGhhdA0KPiBhY3R1YWwgeDg2IENQVXMgaGF2ZSBhcyBzdHJvbmcgYSBtZW1v
cnkgbW9kZWwgYXMgdGhlIFNETSBzdWdnZXN0cywgYW5kDQo+IEknbSB0cnlpbmcgdG8gdW5kZXJz
dGFuZCB0aGUgZXhhY3QgY29uY2Vybi4gIFRoaXMgbWF5IG9yIG1heSBub3QgYmUNCj4gZGlyZWN0
bHkgcmVsZXZhbnQgdG8gdGhlIGtlcm5lbC4gOikNCg0KVGhlIHg4NiBtZW1vcnkgbW9kZWwgaXMg
cHJldHR5IHN0cm9uZy4NCkl0IGhhcyB0byBiZSB0byBzdXBwb3J0IGhpc3RvcmljIGNvZGUgLSBp
bmNsdWRpbmcgc2VsZiBtb2RpZnlpbmcgY29kZS4NCkkgdGhpbmsgRE9TIGZyb20gMTk4MiBzaG91
bGQgc3RpbGwgYm9vdC4NCg0KRXZlbiBmb3IgU01QIHRoZXkgcHJvYmFibHkgY2FuJ3QgcmVsYXgg
YW55dGhpbmcgZnJvbSB0aGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb25zLg0KKEV4Y2VwdCBjcHUg
c3BlY2lmaWMga2VybmVsIGJpdHMgLSBzaW5jZSB0aGF0IGhhcyBhbGwgY2hhbmdlZCBzaW5jZSBz
b21lIGR1YWwgNDg2IGJveGVzLikNCg0KQWN0dWFsbHkgdGhlIHdlYWtlc3QgeDg2IG1lbW9yeSBt
b2RlbCB3YXMgdGhhdCBkZWZpbmVkIGluIHNvbWUgUC1wcm8NCmVyYSBJbnRlbCBkb2NzIHRoYXQg
c2FpZCB0aGF0IElPUi9JT1cgd2VyZW4ndCBzZXF1ZW5jZWQgd2l0aCBtZW1vcnkgYWNjZXNzZXMu
DQpGb3J0dW5hdGVseSBubyBjcHUgZXZlciBkaWQgdGhhdCByZW9yZGVyaW5nLCBhbmQgbm93IGl0
IGlzbid0IGFsbG93ZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

