Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB37C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD122082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfDDOAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:00:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:20337 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727441AbfDDOAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:00:40 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-113-8eB9-lQSN_KfDzsHNHWmvw-1; Thu, 04 Apr 2019 15:00:36 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 4 Apr 2019 15:01:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 4 Apr 2019 15:01:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: RE: [PATCH v9 00/27] x86: load FPU registers on return to userland
Thread-Topic: [PATCH v9 00/27] x86: load FPU registers on return to userland
Thread-Index: AQHU6jzQfWf8irPe1UiHuip9snecjKYsB0gw
Date:   Thu, 4 Apr 2019 14:01:43 +0000
Message-ID: <c4af28470a4347f5aa222a99471c939a@AcuMS.aculab.com>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 8eB9-lQSN_KfDzsHNHWmvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiBTZW50OiAwMyBBcHJpbCAyMDE5IDE3
OjQxDQouLi4NCj4gVG8gYWNjZXNzIHRoZSBGUFUgcmVnaXN0ZXJzIGluIGtlcm5lbCB3ZSBuZWVk
Og0KPiAtIGRpc2FibGUgcHJlZW1wdGlvbiB0byBhdm9pZCB0aGF0IHRoZSBzY2hlZHVsZXIgc3dp
dGNoZXMgdGFza3MuIEJ5DQo+ICAgZG9pbmcgc28gaXQgd291bGQgc2V0IFRJRl9ORUVEX0ZQVV9M
T0FEIGFuZCB0aGUgRlBVIHJlZ2lzdGVycyB3b3VsZCBiZQ0KPiAgIG5vdCB2YWxpZC4NCj4gLSBk
aXNhYmxlIEJIIGJlY2F1c2UgdGhlIHNvZnRpcnEgbWlnaHQgdXNlIGtlcm5lbF9mcHVfYmVnaW4o
KSBhbmQgdGhlbg0KPiAgIHNldCBUSUZfTkVFRF9GUFVfTE9BRCBpbnN0ZWFkIGxvYWRpbmcgdGhl
IEZQVSByZWdpc3RlcnMgb24gY29tcGxldGlvbi4NCg0KSXMgdGhlcmUgYSBwb3NzaWJsZSBvcHRp
bWlzYXRpb24gaGVyZSBmb3Iga2VybmVsIHRocmVhZHM/DQpTaW5jZSB0aGVyZSBpcyBubyAndXNl
ciBGUCBzdGF0ZScgdGhlICdrZXJuZWwgRlAgc3RhdGUnIGNhbg0KYmUgc2F2ZWQgYnkgYSB0YXNr
IHN3aXRjaCBvciBzb2Z0aXJxLg0KDQpZb3UnZCBzdGlsbCB3YW50IHRoZSBrZXJuZWwgdGhyZWFk
IHRvIGJyYWNrZXQgZnB1IHVzYWdlIChvciBhdCBsZWFzdCBzYXkNCnRoYXQgaXQgaXMgYSBrZXJu
ZWwgdGhyZWFkIHRoYXQgYWx3YXlzIG5lZWRzIHRoZSBmcHUpIHRvIGF2b2lkIGhhdmluZw0KdG8g
c2F2ZSBhbmQgcmVzdG9yZSB0aGUgZnB1IHJlZ2lzdGVycyBvbiBldmVyeSBjb250ZXh0IHN3aXRj
aCB0by9mcm9tDQphIGtlcm5lbCB0aHJlYWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

