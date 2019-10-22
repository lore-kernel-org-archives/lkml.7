Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C71CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EE720B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 02:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbfJVC74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 22:59:56 -0400
Received: from mail-sh.amlogic.com ([58.32.228.43]:48010 "EHLO
        mail-sh.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVC7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 22:59:55 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Oct 2019 22:59:53 EDT
Received: from mail-sz.amlogic.com (10.28.11.5) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 22 Oct
 2019 10:45:02 +0800
Received: from mail-sz.amlogic.com ([fe80::ed49:2000:aa3e:d8d6]) by
 mail-sz.amlogic.com ([fe80::ed49:2000:aa3e:d8d6%4]) with mapi id
 15.01.1591.008; Tue, 22 Oct 2019 10:45:02 +0800
From:   Nan Li <Nan.Li@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jianxin Pan <Jianxin.Pan@amlogic.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
CC:     "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Victor Wan <victor.wan@amlogic.com>
Subject: Re: [PATCH] mmc: fix mmc dma operation
Thread-Topic: [PATCH] mmc: fix mmc dma operation
Thread-Index: AQHVh9Sr7hMU2KXmREa05uz490zVL6dkNLiAgAAWKoCAASS2AA==
Date:   Tue, 22 Oct 2019 02:45:02 +0000
Message-ID: <8fc785d5-78a7-6933-8462-22d4afa24068@amlogic.com>
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com>
 <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
 <1jwocybgpw.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jwocybgpw.fsf@starbuckisacylon.baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
x-originating-ip: [10.28.18.42]
Content-Type: text/plain; charset="utf-8"
Content-ID: <21F36A73DE7F4C4491A23F3C776498B7@amlogic.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMTkvMTAvMjEgMTc6MTcsIEplcm9tZSBCcnVuZXQg5YaZ6YGTOg0KPiBPbiBNb24gMjEg
T2N0IDIwMTkgYXQgMDk6NTcsIE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNv
bT4gd3JvdGU6DQo+DQo+PiBIaSwNCj4+DQo+PiBUaGFua3MgZm9yIHRoZSBmaXguDQo+Pg0KPj4g
Rmlyc3QsIHlvdSBzaG91bGQgYWRkICJtbWM6IG1lc29uLWd4OiIgaW4gdGhlIHN1YmplY3QuDQo+
Pg0KPj4gT24gMjEvMTAvMjAxOSAwNzo1OSwgSmlhbnhpbiBQYW4gd3JvdGU6DQo+Pj4gRnJvbTog
TmFuIExpIDxuYW4ubGlAYW1sb2dpYy5jb20+DQo+Pj4NCj4+PiBJbiBNTUMgZG1hIHRyYW5zZmVy
LCB0aGUgcmVnaW9uIHJlcXVlc3RlZCBieSBkbWFfbWFwX3NnKCkgbWF5IGJlIHJlbGVhc2VkDQo+
Pj4gYnkgZG1hX3VubWFwX3NnKCkgYmVmb3JlIHRoZSB0cmFuc2ZlciBpcyBjb21wbGV0ZWQuDQo+
Pj4NCj4+PiBQdXQgdGhlIHVubWFwIG9wZXJhdGlvbiBpbiBmcm9udCBvZiBtbWNfcmVxdWVzdF9k
b25lKCkgdG8gYXZvaWQgdGhpcy4NCj4gU2luY2Ugd2UgaGF2ZSBzZWVuIHRoaXMgcHJvYmxlbSAo
eWV0KSwgY291bGQgeW91IGJyaWVmbHkgaG93IHlvdSd2ZQ0KPiB0cmlnZ2VyZWQgaXQgPw0KDQpU
aGUgcHJvYmxlbSB3ZSBmb3VuZCBpbiB0aGUgc3RyZXNzIHRlc3Qgd2FzIHRoYXQgdGhlIHNkaW8g
ZGV2aWNlIHdhcyANCmNvbnN0YW50bHkgb3BlcmF0ZWQgb24gYW5kIG9mZiBlbGVjdHJpY2l0eSB0
byBtYWtlIGl0IHJlcGVhdGVkbHkgDQppbml0aWFsaXplZC4NCg0KRHVyaW5nIHRoZSB0ZXN0LCB3
ZSBmb3VuZCB0aGF0IHRoZXJlIHdhcyBhIGNoYW5jZSB0aGF0IHRoZSBpbmZvcm1hdGlvbiANCnJl
YWQgYnkgdGhlIGNvbnRyb2xsZXIgZnJvbSB0aGUgc2RpbyBkZXZpY2Ugc2lkZSB3YXMgd3Jvbmcs
IHdoaWNoIG1hZGUgDQp0aGUgc2RpbyBpbml0aWFsaXphdGlvbiBmYWlsLg0KDQo+PiBZb3Ugc2hv
dWxkIGFkZCBhICJGaXhlczoiIHRhZyBzbyBpdCBjYW4gYmUgYmFja3BvcnRlZCBvbiBzdGFibGUg
a2VybmVscy4NCj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTmFuIExpIDxuYW4ubGlAYW1sb2dpYy5j
b20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSmlhbnhpbiBQYW4gPGppYW54aW4ucGFuQGFtbG9naWMu
Y29tPg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9tbWMvaG9zdC9tZXNvbi1neC1tbWMuYyB8IDE1
ICsrKysrKysrLS0tLS0tLQ0KPj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwg
NyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L21l
c29uLWd4LW1tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9tZXNvbi1neC1tbWMuYw0KPj4+IGluZGV4
IGU3MTIzMTUuLjc2NjdlOGEgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9tZXNv
bi1neC1tbWMuYw0KPj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvbWVzb24tZ3gtbW1jLmMNCj4+
PiBAQCAtMTczLDYgKzE3Myw3IEBAIHN0cnVjdCBtZXNvbl9ob3N0IHsNCj4+PiAgIAlpbnQgaXJx
Ow0KPj4+ICAgDQo+Pj4gICAJYm9vbCB2cW1tY19lbmFibGVkOw0KPj4+ICsJYm9vbCBuZWVkc19w
cmVfcG9zdF9yZXE7DQo+Pj4gICB9Ow0KPj4+ICAgDQo+Pj4gICAjZGVmaW5lIENNRF9DRkdfTEVO
R1RIX01BU0sgR0VOTUFTSyg4LCAwKQ0KPj4+IEBAIC02NTQsNiArNjU1LDggQEAgc3RhdGljIHZv
aWQgbWVzb25fbW1jX3JlcXVlc3RfZG9uZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYywNCj4+PiAgIAlz
dHJ1Y3QgbWVzb25faG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7DQo+Pj4gICANCj4+PiAgIAlo
b3N0LT5jbWQgPSBOVUxMOw0KPj4+ICsJaWYgKGhvc3QtPm5lZWRzX3ByZV9wb3N0X3JlcSkNCj4+
PiArCQltZXNvbl9tbWNfcG9zdF9yZXEobW1jLCBtcnEsIDApOw0KPj4+ICAgCW1tY19yZXF1ZXN0
X2RvbmUoaG9zdC0+bW1jLCBtcnEpOw0KPj4+ICAgfQ0KPj4+ICAgDQo+Pj4gQEAgLTgwMywyNSAr
ODA2LDIzIEBAIHN0YXRpYyB2b2lkIG1lc29uX21tY19zdGFydF9jbWQoc3RydWN0IG1tY19ob3N0
ICptbWMsIHN0cnVjdCBtbWNfY29tbWFuZCAqY21kKQ0KPj4+ICAgc3RhdGljIHZvaWQgbWVzb25f
bW1jX3JlcXVlc3Qoc3RydWN0IG1tY19ob3N0ICptbWMsIHN0cnVjdCBtbWNfcmVxdWVzdCAqbXJx
KQ0KPj4+ICAgew0KPj4+ICAgCXN0cnVjdCBtZXNvbl9ob3N0ICpob3N0ID0gbW1jX3ByaXYobW1j
KTsNCj4+PiAtCWJvb2wgbmVlZHNfcHJlX3Bvc3RfcmVxID0gbXJxLT5kYXRhICYmDQo+Pj4gKw0K
Pj4+ICsJaG9zdC0+bmVlZHNfcHJlX3Bvc3RfcmVxID0gbXJxLT5kYXRhICYmDQo+Pj4gICAJCQkh
KG1ycS0+ZGF0YS0+aG9zdF9jb29raWUgJiBTRF9FTU1DX1BSRV9SRVFfRE9ORSk7DQo+Pj4gICAN
Cj4+PiAtCWlmIChuZWVkc19wcmVfcG9zdF9yZXEpIHsNCj4+PiArCWlmIChob3N0LT5uZWVkc19w
cmVfcG9zdF9yZXEpIHsNCj4+PiAgIAkJbWVzb25fbW1jX2dldF90cmFuc2Zlcl9tb2RlKG1tYywg
bXJxKTsNCj4+PiAgIAkJaWYgKCFtZXNvbl9tbWNfZGVzY19jaGFpbl9tb2RlKG1ycS0+ZGF0YSkp
DQo+Pj4gLQkJCW5lZWRzX3ByZV9wb3N0X3JlcSA9IGZhbHNlOw0KPj4+ICsJCQlob3N0LT5uZWVk
c19wcmVfcG9zdF9yZXEgPSBmYWxzZTsNCj4+PiAgIAl9DQo+Pj4gICANCj4+PiAtCWlmIChuZWVk
c19wcmVfcG9zdF9yZXEpDQo+Pj4gKwlpZiAoaG9zdC0+bmVlZHNfcHJlX3Bvc3RfcmVxKQ0KPj4+
ICAgCQltZXNvbl9tbWNfcHJlX3JlcShtbWMsIG1ycSk7DQo+Pj4gICANCj4+PiAgIAkvKiBTdG9w
IGV4ZWN1dGlvbiAqLw0KPj4+ICAgCXdyaXRlbCgwLCBob3N0LT5yZWdzICsgU0RfRU1NQ19TVEFS
VCk7DQo+Pj4gICANCj4+PiAgIAltZXNvbl9tbWNfc3RhcnRfY21kKG1tYywgbXJxLT5zYmMgPzog
bXJxLT5jbWQpOw0KPj4+IC0NCj4+PiAtCWlmIChuZWVkc19wcmVfcG9zdF9yZXEpDQo+Pj4gLQkJ
bWVzb25fbW1jX3Bvc3RfcmVxKG1tYywgbXJxLCAwKTsNCj4+PiAgIH0NCj4gVGhlIGNvZGUgYXJv
dW5kIGFsbCB0aGlzIGlzIGdldHRpbmcgcXVpdGUgZGlmZmljdWx0IHRvIGZvbGxvdyBldmVudGhv
dWdoDQo+IGl0IGRvZXMgbm90IGFjdHVhbGx5IGRvIG11Y2gNCj4NCj4gVGhlIHJvb3Qgb2YgdGhl
IHByb2JsZW0gc2VlbXMgYmUgdGhhdCBtZXNvbl9tbWNfcHJlX3JlcSgpIGFuZA0KPiBtZXNvbl9t
bWNfcG9zdF9yZXEoKSBhcmUgcGFzc2VkIHRvIGZyYW1ld29yayBidXQgYWxzbyBjYWxsZWQgbWFu
dWFsbHkNCj4gZnJvbSBtZXNvbl9tbWNfcmVxdWVzdCgpLg0KPg0KPiBCZWNhdXNlIG9mIHRoaXMs
IHNvbWUgY29kZSBpcyBhZGRlZCB0byBtYWtlIHN1cmUgd2UgZG9uJ3QgZG8gdGhpbmdzIHR3aWNl
Lg0KPiBNYXliZSBJJ20gbWlzc2luZyBzb21ldGhpbmcgYnV0IGl0IGxvb2sgd2VpcmQgPyBVbGYs
IGNvdWxkIHlvdSBnaXZlIHVzDQo+IHlvdXIgdmlldyA/DQo+DQo+IEFzIGZhciBhcyBJIGNhbiB0
ZWxsOg0KPiAgICogcHJlX3JlcSA6IGRldGVybWluZSBpZiB3ZSB1c2UgQ0hBSU5fTU9ERSBvciBu
b3QgQU5EDQo+ICAgICAgICAgICAgICAgZG1hX21hcF9zZygpIGlmIHdlIGRvDQo+ICAgKiBwb3N0
X3JlcSA6IGRtYV91bm1hcF9zZygpIGlmIHByZXZpb3VzbHkgYWxsb2NhdGVkDQo+DQo+IERvIHdl
IHJlYWxseSBuZWVkIHRvIGRvIGFsbCB0aGlzIG1lc29uX21tY19yZXF1ZXN0KCkgPyBTaG91bGRu
J3Qgd2UgbGV0IHRoZQ0KPiBmcmFtZXdvcmsgZG8gdGhlIGNhbGxzIHRvIHByZS9wb3N0X3JlcSBm
b3IgdXMgPw0KPg0KPj4+ICAgDQo+Pj4gICBzdGF0aWMgdm9pZCBtZXNvbl9tbWNfcmVhZF9yZXNw
KHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBzdHJ1Y3QgbW1jX2NvbW1hbmQgKmNtZCkNCj4+Pg0KPj4g
TmVpbA0KDQoNCg==
