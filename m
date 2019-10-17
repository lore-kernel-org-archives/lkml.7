Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8341AFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D862089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395301AbfJQOZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:25:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:38830 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727671AbfJQOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:25:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-35-wLuQ8dFnOzq0PfuTddZlqw-1; Thu, 17 Oct 2019 15:25:15 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 17 Oct 2019 15:25:14 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 17 Oct 2019 15:25:14 +0100
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
Thread-Index: AQHVhO5+Vr2ETd8AWEKYYhhOaw9ZuKde3Cgg///1GwCAABHQgA==
Date:   Thu, 17 Oct 2019 14:25:14 +0000
Message-ID: <173d1913031b4ecb88f0c6e421cc5cf8@AcuMS.aculab.com>
References: <18068756-0f39-6388-3290-cf03746e767d@huawei.com>
 <9df267db-e647-a81d-16bb-b8bfb06c2624@huawei.com>
 <20191016153221.GA8978@bogus>
 <0f550044-9ed2-5f72-1335-73417678ba45@huawei.com>
 <c97c87b52f474463bc30ff8033a57e0c@AcuMS.aculab.com>
 <1cd555f0-4074-36b7-8426-6f01130051d2@huawei.com>
In-Reply-To: <1cd555f0-4074-36b7-8426-6f01130051d2@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: wLuQ8dFnOzq0PfuTddZlqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVuZmVuZyBZZQ0KID4gU2VudDogMTcgT2N0b2JlciAyMDE5IDE1OjIwDQo+IE9uIDIw
MTkvMTAvMTcgMjI6MDAsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBGcm9tOiBZdW5mZW5nIFll
DQo+ID4+IFNlbnQ6IDE3IE9jdG9iZXIgMjAxOSAxNDoyNg0KPiA+IC4uLg0KPiA+Pj4+IC0JZm9y
IChpID0gMDsgaSA8IDEwOyBpKyspIHsNCj4gPj4+PiArCWkgPSAwOw0KPiA+Pj4+ICsJdGltZW91
dCA9IGppZmZpZXMgKyBtc2Vjc190b19qaWZmaWVzKDEwMCk7DQo+ID4+Pj4gKwlkbyB7DQo+ID4+
Pj4gIAkJZXJyID0gcHNjaV9vcHMuYWZmaW5pdHlfaW5mbyhjcHVfbG9naWNhbF9tYXAoY3B1KSwg
MCk7DQo+ID4+Pj4gIAkJaWYgKGVyciA9PSBQU0NJXzBfMl9BRkZJTklUWV9MRVZFTF9PRkYpIHsN
Cj4gPj4+PiAgCQkJcHJfaW5mbygiQ1BVJWQga2lsbGVkLlxuIiwgY3B1KTsNCj4gPj4+PiAgCQkJ
cmV0dXJuIDA7DQo+ID4+Pj4gIAkJfQ0KPiA+Pj4+DQo+ID4+Pj4gLQkJbXNsZWVwKDEwKTsNCj4g
Pj4+PiAtCQlwcl9pbmZvKCJSZXRyeWluZyBhZ2FpbiB0byBjaGVjayBmb3IgQ1BVIGtpbGxcbiIp
Ow0KPiA+Pj4NCj4gPj4+IFlvdSBkcm9wcGVkIHRoaXMgbWVzc2FnZSwgYW55IHBhcnRpY3VsYXIg
cmVhc29uID8NCj4gPj4+DQo+ID4+IFdoZW4gcmVkdWNlIHRoZSB0aW1lIGludGVydmFsIHRvIDFt
cywgdGhlIHByaW50IG1lc3NhZ2UgbWF5YmUgaW5jcmVhc2UgMTAgdGltZXMuDQo+ID4+IG9uIHRo
ZSBvdGhlciBoYW5kLCBjcHVfcHNjaV9jcHVfa2lsbCgpIHdpbGwgcHJpbnQgbWVzc2FnZSBvbiBz
dWNjZXNzIG9yIGZhaWx1cmUsIHdoaWNoDQo+ID4+IHRoaXMgcmV0cnkgbG9nIGlzIG5vdCB2ZXJ5
IG5lY2Vzc2FyeS4gb2YgY291cmNlLCBJIHRoaW5rIHVzZSBwcl9pbmZvX29uY2UoKSBpbnN0ZWFk
IG9mDQo+ID4+IHByX2luZm8oKSBpcyBiZXR0ZXIuDQo+ID4NCj4gPiBNYXliZSB5b3Ugc2hvdWxk
IHByaW50IGluIG9uIChzYXkpIHRoZSAxMHRoIHRpbWUgYXJvdW5kIHRoZSBsb29wLg0KPiA+DQo+
IENhbiBpdCBsaWtlIHRoaXM6DQo+ICAgcHJfaW5mbygiQ1BVJWQga2lsbGVkIHdpdGggJWQgbG9v
cHMuXG4iLCBjcHUsIGxvb3BzKTsNCj4gDQo+IElmIHB1dCB0aGUgbnVtYmVyIG9mIHdhaXRpbmcg
dGltZXMgaW4gdGhlIHN1Y2Nlc3NmdWwgcHJpbnRpbmcgbWVzc2FnZSwgaXQgaXMNCj4gbm90IG5l
Y2Vzc2FyeSB0byBwcmludCB0aGUgIlJldHJ5aW5nIC4uLiIgbWVzc2FnZS4NCg0KVGhhdCBkZXBl
bmRzIG9uIHdoZXRoZXIgeW91IHdhbnQgdG8ga25vdyBob3cgbG9uZyBpdCB0b29rIG9yIHdoeSB0
aGUgc3lzdGVtDQppcyAnc3R1Y2snLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

