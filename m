Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD00C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4E4206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLPRp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:45:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43162 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725805AbfLPRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:45:26 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-43-acutJ5mMOdScnvq5_4WRig-1; Mon, 16 Dec 2019 17:45:23 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Dec 2019 17:45:22 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Dec 2019 17:45:22 +0000
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
Thread-Index: AQHVsSQN6yBAo1s5f0Kws0hZvGpx8qe8iNtwgAB/vgCAAAOJwA==
Date:   Mon, 16 Dec 2019 17:45:22 +0000
Message-ID: <053a199934844aef9745d7398494b5a0@AcuMS.aculab.com>
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
In-Reply-To: <CALCETrW1LDuzcnvav=MY1bUv4jQ25n30La5m5x8tXfDknfV_cQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: acutJ5mMOdScnvq5_4WRig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDE2IERlY2VtYmVyIDIwMTkgMTc6MjMNCi4u
Lg0KPiBJJ20gdGFsa2luZyBzcGVjaWZpY2FsbHkgYWJvdXQgeDg2IGhlcmUsIHdoZXJlLCBmb3Ig
ZXhhbXBsZSwgIlJlYWRzDQo+IGFyZSBub3QgcmVvcmRlcmVkIHdpdGggb3RoZXIgcmVhZHMiLiAg
U28gUkVBRF9PTkNFICpkb2VzKiBoYXZlDQo+IHNlcXVlbmNpbmcgcmVxdWlyZW1lbnRzIG9uIHRo
ZSBDUFVzLg0KPiANCj4gRmVlbCBmcmVlIHRvIHJlcGxhY2UgUkVBRF9PTkNFIHdpdGggTU9WIGlu
IHlvdXIgaGVhZCBpZiB5b3UgbGlrZSA6KQ0KDQpJIGdvdCBhIGxpdHRsZSBjb25mdXNlZCBiZWNh
dXNlIEkgdGhvdWdodCB5b3VyIHJlZmVyZW5jZSB0byBSRUFEX09OQ0UoKQ0Kd2FzIHJlbGV2YW50
Lg0KDQpTb21ldGltZXMgcmVtZW1iZXJpbmcgYWxsIHRoaXMgZ2V0cyBoYXJkLg0KVGhlIGRvY3Mg
YWJvdXQgdGhlIGVmZmVjdHMgb2YgTEZFTkNFIGFuZCBNRkVOQ0UgZG9uJ3QgcmVhbGx5IGhlbHAN
Cih0aGV5IG1ha2UgbXkgYnJhaW4gaHVydCkuDQpJJ20gcHJldHR5IHN1cmUgSSd2ZSBkZWNpZGVk
IGluIHRoZSBwYXN0IHRoZXkgYXJlIGFsbW9zdCBuZXZlciBuZWVkZWQuDQoNClVzdWFsbHkgdGhl
IG9yZGVyaW5nIG9mIHJlYWRzIGRvZXNuJ3QgaGVscCB5b3UuDQpJSVJDIElmIGxvY2F0aW9ucyAn
YScgYW5kICdiJyBnZXQgY2hhbmdlZCBmcm9tIDAgdG8gMSBpdCBpcyBwZXJmZWN0bHkgcG9zc2li
bGUNCmZvciBvbmUgY3B1IHRvIHNlZSBhPT0wLCBiPT0xIGFuZCBhbm90aGVyIGE9PTEsIGI9PTAg
ZXZlbg0KdGhvdWdoIGJvdGggcmVhZCBhIHRoZW4gYi4NCihPbiBub24tYWxwaGEgdGhpcyBtYXkg
cmVxdWlyZSBkaWZmZXJlbnQgY3B1cyB1cGRhdGUgYSBhbmQgYi4pDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

