Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981FEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EDC214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388604AbfIPOTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:19:02 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:30267 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbfIPOTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:19:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-134-IsqpMdStPnGw5ESHFgZpvw-1; Mon, 16 Sep 2019 15:18:59 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 16 Sep 2019 15:18:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 16 Sep 2019 15:18:58 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@vger.kernel.org" <x86@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: RE: [PATCH] x86_64: new and improved memset()
Thread-Topic: [PATCH] x86_64: new and improved memset()
Thread-Index: AQHVaufpL07jsuixv0W1QgPRe6Vz4KcuWP2w
Date:   Mon, 16 Sep 2019 14:18:58 +0000
Message-ID: <eb71d765d409413887bab48cbd1fc014@AcuMS.aculab.com>
References: <20190914103345.GA5856@avx2>
In-Reply-To: <20190914103345.GA5856@avx2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: IsqpMdStPnGw5ESHFgZpvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDE0IFNlcHRlbWJlciAyMDE5IDExOjM0DQou
Li4NCj4gK0VOVFJZKG1lbXNldDBfcmVwX3N0b3NxKQ0KPiArCXhvcgllYXgsIGVheA0KPiArLmds
b2JsIG1lbXNldHhfcmVwX3N0b3NxDQo+ICttZW1zZXR4X3JlcF9zdG9zcToNCj4gKwlsZWEJcnNp
LCBbcmRpICsgcmN4XQ0KPiArCXNocglyY3gsIDMNCj4gKwlyZXAgc3Rvc3ENCj4gKwljbXAJcmRp
LCByc2kNCj4gKwlqZQkxZg0KPiArMjoNCj4gKwltb3YJW3JkaV0sIGFsDQo+ICsJYWRkCXJkaSwg
MQ0KPiArCWNtcAlyZGksIHJzaQ0KPiArCWpuZQkyYg0KPiArMToNCj4gKwlyZXQNCg0KWW91IGNh
biBkbyB0aGUgJ3RyYWlsaW5nIGJ5dGVzJyBmaXJzdCB3aXRoIGEgcG90ZW50aWFsbHkgbWlzYWxp
Z25lZCBzdG9yZS4NClNvbWV0aGluZyBsaWtlIChtb2R1bG8gYXNtIHN5bnRheCBhbmQgYXJndW1l
bnQgb3JkZXJpbmcpOg0KCWxlYQlyc2ksIFtyZGkgKyByZHhdDQoJc2hyCXJjeCwgMw0KCWpjeHoJ
MWYJCSMgU2hvcnQgYnVmZmVyDQoJbW92CS04W3JzaV0sIHJheA0KCXJlcCBzdG9zcQ0KCXJldA0K
MToNCgltb3YJW3JkaV0sIGFsDQoJYWRkCXJkaSwgMQ0KCWNtcAlyZGksIHJzaQ0KCWpuZQkxYg0K
CXJldA0KDQpUaGUgZmluYWwgbG9vcCBjYW4gYmUgb25lIGluc3RydWN0aW9uIHNob3J0ZXIgYnkg
YXJyYW5naW5nIHRvIGRvOg0KMToNCgltb3YJW3JkaStyeHhdLCBhbA0KCWFkZAlyZGksIDENCglq
bnoJMWINCglyZXQNCg0KTGFzdCBJIGxvb2tlZCAnamN4eicgd2FzICdvaycgb24gYWxsIHJlY2Vu
dCBhbWQgYW5kIGludGVsIGNwdXMuDQpPVE9IICdsb29wJyBpcyBob3JyaWQgb24gaW50ZWwgb25l
cy4NCg0KVGhlIHNhbWUgYXBwbGllcyB0byB0aGUgb3RoZXIgdmVyc2lvbnMuDQoNCkkgc3VzcGVj
dCBpdCBpc24ndCB3b3J0aCBvcHRpbWlzaW5nIHRvIHJlYWxpZ24gbWlzYWxpZ25lZCBidWZmZXJz
DQp0aGV5IGFyZSB1bmxpa2VseSB0byBoYXBwZW4gb2Z0ZW4gZW5vdWdoLg0KDQpJIGFsc28gdGhp
bmsgdGhhdCBnY2MncyBfX2J1aWx0aW4gdmVyc2lvbiBkb2VzIHNvbWUgb2YgdGhlIHNob3J0DQpi
dWZmZXIgb3B0aW1pc2F0aW9ucyBhbHJlYWR5Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

