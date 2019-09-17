Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C958C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5942821897
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 10:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfIQKzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 06:55:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32213 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfIQKzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 06:55:16 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-6--ko-SATcNWqgGhEDOWvmRg-1;
 Tue, 17 Sep 2019 11:55:13 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 17 Sep 2019 11:55:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 17 Sep 2019 11:55:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Borislav Petkov <bp@alien8.de>,
        Rasmus Villemoes <mail@rasmusvillemoes.dk>,
        x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Improve memset
Thread-Topic: [RFC] Improve memset
Thread-Index: AQHVbLPIu4hecDwEF0u+nZH4epFBdqcvr1XQ
Date:   Tue, 17 Sep 2019 10:55:12 +0000
Message-ID: <2061267c74254b03ad5b7b23d6dfd961@AcuMS.aculab.com>
References: <20190913072237.GA12381@zn.tnic>
 <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk>
 <20190913104232.GA4190@zn.tnic> <20190913163645.GC4190@zn.tnic>
 <3fc31917-9452-3a10-d11d-056bf2d8b97d@rasmusvillemoes.dk>
 <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
In-Reply-To: <CAHk-=wjdpJ+VapXfoZE8JRUfvMb8JrVTZe0=TDFYZ-ke+uqBOA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: -ko-SATcNWqgGhEDOWvmRg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTYgU2VwdGVtYmVyIDIwMTkgMTg6MjUNCi4u
Lg0KPiBZb3UgY2FuIGJhc2ljYWxseSBhbHdheXMgYmVhdCAicmVwIG1vdnMvc3RvcyIgd2l0aCBo
YW5kLXR1bmVkIEFWWDIvNTEyDQo+IGNvZGUgZm9yIHNwZWNpZmljIGNhc2VzIGlmIHlvdSBkb24n
dCBsb29rIGF0IEkkIGZvb3RwcmludCBhbmQgdGhlIGNvc3QNCj4gb2YgdGhlIEFWWCBzZXR1cCAo
YW5kIHRoZSBjb3N0IG9mIGZyZXF1ZW5jeSBjaGFuZ2VzLCB3aGljaCBvZnRlbiBnbw0KPiBoYW5k
LWluLWhhbmQgd2l0aCB0aGUgQVZYIHVzZSkuIFNvICJyZXAgbW92cy9zdG9zIiBpcyBzZWxkb20N
Cj4gX29wdGltYWxfLCBidXQgaXQgdGVuZHMgdG8gYmUgInF1aXRlIGdvb2QiIGZvciBtb2Rlcm4g
Q1BVJ3Mgd2l0aA0KPiB2YXJpYWJsZSBzaXplcyB0aGF0IGFyZSBpbiB0aGUgMTAwKyBieXRlIHJh
bmdlLg0KDQpZZWFycyBhZ28gSSBtYW5hZ2VkIHRvIG1hdGNoICdyZXAgbW92cycgb24gbXkgQXRo
bG9uIDcwMCB3aXRoIGENCidub3JtYWwnIGNvZGUgbG9vcC4NCkkgY2FuJ3QgcmVtZW1iZXIgd2hl
dGhlciBJIGJlYXQgdGhlIHNldHVwIHRpbWUgdGhvdWdoLg0KVGhlICd0cmljaycgd2FzIHRvIGRv
ICdyZWFkIChyZWFkLXdyaXRlKSpuIHdyaXRlJyB0bw0KYXZvaWQgc3RhbGxzIGFuZCBnZXQgYWxs
IHRoZSBsb29wIHByb2Nlc3NpbmcgZm9yIGZyZWUuDQpUaGUgSSQgZm9vdHByaW50IHdhcyBsYXJn
ZXIgdGhvdWdoLg0KDQpUaGUgc2V0dXAgY29zdHMgZm9yICdyZXAgbW92eCcgYXJlIHNpZ25pZmlj
YW50Lg0KSSB0aGluayB0aGUgd29yc3QgY3B1IHdhcyB0aGUgUDQtTmV0YnVzdCBhdCA0MC01MCBj
bG9ja3MuDQpNeSBndWVzcyBpcyBvdmVyIDEwIGZvciBhbGwgY3B1IChleGNlcHQgcHJlLXBlbnRp
dW0gb25lcykuDQoNCklJUkMgdGhlIG9ubHkgY3B1IG9uIHdoaWNoIHlvdSBzaG91bGQgdXNlICdy
ZXAgbW92c2InIGZvciB0aGUNCnRyYWlsaW5nIGJ5dGVzIGlzIHRoZSBvbmUgYmVmb3JlIEludGVs
IGFkZGVkIHRoZSBmYXN0IGNvcHkgbG9naWMuDQpUaGF0IG9uZSBoYWQgc3BlY2lhbCBvcHRpbWlz
YXRpb25zIGZvciAncmVwIG1vdnNiJyBvZiBsZW5ndGggPCA4Lg0KDQpSZW1lbWJlciwgaWYgeW91
IGFyZSBpbmxpbmluZyB5b3UgcHJvYmFibHkgaGF2ZSB0byBhc3N1bWUgY29sZC1jYWNoZQ0KYW5k
IGFuIHVudHJhaW5lZCBicmFuY2ggcHJlZGljdG9yLg0KTW9zdCBiZW5jaG1hcmtpbmcgaXMgZG9u
ZSBob3QtY2FjaGUgd2l0aCB0aGUgYnJhbmNoIHByZWRpY3RvciB0cmFpbmVkLg0KDQoJRGF2aWQN
Cg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZh
cm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYg
KFdhbGVzKQ0K

