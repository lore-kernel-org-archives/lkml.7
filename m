Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04723ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81432054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439752AbfJQOAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:00:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59304 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437275AbfJQOAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:00:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-236-V6OhvOg1OhyF6nLWHS1ciQ-1; Thu, 17 Oct 2019 15:00:43 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 17 Oct 2019 15:00:42 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 17 Oct 2019 15:00:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yunfeng Ye' <yeyunfeng@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: RE: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
Thread-Topic: [PATCH V2] arm64: psci: Reduce waiting time of
 cpu_psci_cpu_kill()
Thread-Index: AQHVhO5+Vr2ETd8AWEKYYhhOaw9ZuKde3Cgg
Date:   Thu, 17 Oct 2019 14:00:42 +0000
Message-ID: <c97c87b52f474463bc30ff8033a57e0c@AcuMS.aculab.com>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <9df267db-e647-a81d-16bb-b8bfb06c2624@huawei.com>
 <20191016153221.GA8978@bogus>
 <0f550044-9ed2-5f72-1335-73417678ba45@huawei.com>
In-Reply-To: <0f550044-9ed2-5f72-1335-73417678ba45@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: V6OhvOg1OhyF6nLWHS1ciQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVuZmVuZyBZZQ0KPiBTZW50OiAxNyBPY3RvYmVyIDIwMTkgMTQ6MjYNCi4uLg0KPiA+
PiAtCWZvciAoaSA9IDA7IGkgPCAxMDsgaSsrKSB7DQo+ID4+ICsJaSA9IDA7DQo+ID4+ICsJdGlt
ZW91dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMCk7DQo+ID4+ICsJZG8gew0KPiA+
PiAgCQllcnIgPSBwc2NpX29wcy5hZmZpbml0eV9pbmZvKGNwdV9sb2dpY2FsX21hcChjcHUpLCAw
KTsNCj4gPj4gIAkJaWYgKGVyciA9PSBQU0NJXzBfMl9BRkZJTklUWV9MRVZFTF9PRkYpIHsNCj4g
Pj4gIAkJCXByX2luZm8oIkNQVSVkIGtpbGxlZC5cbiIsIGNwdSk7DQo+ID4+ICAJCQlyZXR1cm4g
MDsNCj4gPj4gIAkJfQ0KPiA+Pg0KPiA+PiAtCQltc2xlZXAoMTApOw0KPiA+PiAtCQlwcl9pbmZv
KCJSZXRyeWluZyBhZ2FpbiB0byBjaGVjayBmb3IgQ1BVIGtpbGxcbiIpOw0KPiA+DQo+ID4gWW91
IGRyb3BwZWQgdGhpcyBtZXNzYWdlLCBhbnkgcGFydGljdWxhciByZWFzb24gPw0KPiA+DQo+IFdo
ZW4gcmVkdWNlIHRoZSB0aW1lIGludGVydmFsIHRvIDFtcywgdGhlIHByaW50IG1lc3NhZ2UgbWF5
YmUgaW5jcmVhc2UgMTAgdGltZXMuDQo+IG9uIHRoZSBvdGhlciBoYW5kLCBjcHVfcHNjaV9jcHVf
a2lsbCgpIHdpbGwgcHJpbnQgbWVzc2FnZSBvbiBzdWNjZXNzIG9yIGZhaWx1cmUsIHdoaWNoDQo+
IHRoaXMgcmV0cnkgbG9nIGlzIG5vdCB2ZXJ5IG5lY2Vzc2FyeS4gb2YgY291cmNlLCBJIHRoaW5r
IHVzZSBwcl9pbmZvX29uY2UoKSBpbnN0ZWFkIG9mDQo+IHByX2luZm8oKSBpcyBiZXR0ZXIuDQoN
Ck1heWJlIHlvdSBzaG91bGQgcHJpbnQgaW4gb24gKHNheSkgdGhlIDEwdGggdGltZSBhcm91bmQg
dGhlIGxvb3AuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJy
YW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lz
dHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

