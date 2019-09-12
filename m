Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA04C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5492084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 08:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfILIsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 04:48:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23224 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbfILIsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 04:48:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-17-AvKfWONiOouzoUVnjrPlUA-1; Thu, 12 Sep 2019 09:48:43 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Sep 2019 09:48:42 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Sep 2019 09:48:42 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yunfeng Ye' <yeyunfeng@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wuyun.wu@huawei.com" <wuyun.wu@huawei.com>
Subject: RE: [PATCH] arm64: psci: Use udelay() instead of msleep() to reduce
 waiting time
Thread-Topic: [PATCH] arm64: psci: Use udelay() instead of msleep() to reduce
 waiting time
Thread-Index: AQHVaH4AwWDpQzK54U6c4a0pGnl8oKcnvCiA
Date:   Thu, 12 Sep 2019 08:48:42 +0000
Message-ID: <18c9fd22d72d4ea1a11e800e8873dd8d@AcuMS.aculab.com>
References: <e4d42bda-72f2-4002-f319-1cbe2bff74d2@huawei.com>
In-Reply-To: <e4d42bda-72f2-4002-f319-1cbe2bff74d2@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: AvKfWONiOouzoUVnjrPlUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVuZmVuZyBZZQ0KPiBTZW50OiAxMSBTZXB0ZW1iZXIgMjAxOSAwOTo1MA0KPiBXZSB3
YW50IHRvIHJlZHVjZSB0aGUgdGltZSBvZiBjcHVfZG93bigpIGZvciBzYXZpbmcgcG93ZXIsIGZv
dW5kIHRoYXQNCj4gY3B1X3BzY2lfY3B1X2tpbGwoKSBjb3N0IDEwbXMgYWZ0ZXIgcHNjaV9vcHMu
YWZmaW5pdHlfaW5mbygpIGZhaWwuDQo+IA0KPiBOb3JtYWxseSB0aGUgdGltZSBjcHUgZGVhZCBp
cyB2ZXJ5IHNob3J0LCBpdCBpcyBubyBuZWVkIHRvIHdhaXQgMTBtcy4NCj4gc28gdXNlIHVkZWxh
eSAxMHVzIHRvIGluc3RlYWQgbXNsZWVwIDEwbXMgaW4gZXZlcnkgd2FpdGluZyBsb29wLCBhbmQg
YWRkDQo+IGNvbmRfcmVzY2hlZCgpIHRvIGdpdmUgYSBjaGFuY2UgdG8gcnVuIGEgaGlnaGVyLXBy
aW9yaXR5IHByb2Nlc3MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdW5mZW5nIFllIDx5ZXl1bmZl
bmdAaHVhd2VpLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L2tlcm5lbC9wc2NpLmMgfCA2ICsr
Ky0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9wc2NpLmMgYi9hcmNoL2FybTY0
L2tlcm5lbC9wc2NpLmMNCj4gaW5kZXggODVlZTdkMC4uOWU5ZDhhNiAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm02NC9rZXJuZWwvcHNjaS5jDQo+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL3BzY2ku
Yw0KPiBAQCAtODYsMTUgKzg2LDE1IEBAIHN0YXRpYyBpbnQgY3B1X3BzY2lfY3B1X2tpbGwodW5z
aWduZWQgaW50IGNwdSkNCj4gIAkgKiB3aGlsZSBpdCBpcyBkeWluZy4gU28sIHRyeSBhZ2FpbiBh
IGZldyB0aW1lcy4NCj4gIAkgKi8NCj4gDQo+IC0JZm9yIChpID0gMDsgaSA8IDEwOyBpKyspIHsN
Cj4gKwlmb3IgKGkgPSAwOyBpIDwgMTAwMDA7IGkrKykgew0KPiAgCQllcnIgPSBwc2NpX29wcy5h
ZmZpbml0eV9pbmZvKGNwdV9sb2dpY2FsX21hcChjcHUpLCAwKTsNCj4gIAkJaWYgKGVyciA9PSBQ
U0NJXzBfMl9BRkZJTklUWV9MRVZFTF9PRkYpIHsNCj4gIAkJCXByX2luZm8oIkNQVSVkIGtpbGxl
ZC5cbiIsIGNwdSk7DQo+ICAJCQlyZXR1cm4gMDsNCj4gIAkJfQ0KPiANCj4gLQkJbXNsZWVwKDEw
KTsNCj4gLQkJcHJfaW5mbygiUmV0cnlpbmcgYWdhaW4gdG8gY2hlY2sgZm9yIENQVSBraWxsXG4i
KTsNCj4gKwkJY29uZF9yZXNjaGVkKCk7DQo+ICsJCXVkZWxheSgxMCk7DQoNCllvdSByZWFsbHkg
ZG9uJ3Qgd2FudCB0byBiZSBkb2luZyAxMDAwMCB1ZGVsYXkoMTApIGJlZm9yZSBnaXZpbmcgdXAu
DQoNCklmIHVkZWxheSgxMCkgaXMgbG9uZyBlbm91Z2ggZm9yIHRoZSBub3JtYWwgY2FzZSwgdGhl
biBkbyB0aGF0IG9uY2UuDQpBZnRlciB0aGF0IHVzZSB1c2xlZXBfcmFuZ2UoKS4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

