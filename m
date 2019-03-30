Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62CFC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911C82184C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbfC3C1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:27:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730184AbfC3C1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:27:35 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 30AEB943E52F6AA8A77A;
        Sat, 30 Mar 2019 10:27:33 +0800 (CST)
Received: from DGGEMM506-MBS.china.huawei.com ([169.254.4.235]) by
 DGGEMM401-HUB.china.huawei.com ([10.3.20.209]) with mapi id 14.03.0415.000;
 Sat, 30 Mar 2019 10:27:28 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "labbott@redhat.com" <labbott@redhat.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Todd Kjos <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        "Christian Brauner" <christian@brauner.io>
Subject: RE: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Thread-Topic: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Thread-Index: AQHU5hvBBBKtnihC9E+86WTyiok4UaYiPySAgAE0wWA=
Date:   Sat, 30 Mar 2019 02:27:27 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24EBDE20@DGGEMM506-MBS.china.huawei.com>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
 <20190329160157.GA5906@kroah.com>
In-Reply-To: <20190329160157.GA5906@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEdyZWcgS3JvYWgtSGFydG1h
biBbbWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXQ0KPlNlbnQ6IFNhdHVyZGF5LCBN
YXJjaCAzMCwgMjAxOSAxMjowMiBBTQ0KPlRvOiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNp
bGljb24uY29tPg0KPkNjOiBsYWJib3R0QHJlZGhhdC5jb207IHN1bWl0LnNlbXdhbEBsaW5hcm8u
b3JnOw0KPmRldmVsQGRyaXZlcmRldi5vc3Vvc2wub3JnOyBUb2RkIEtqb3MgPHRram9zQGFuZHJv
aWQuY29tPjsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOw0KPmxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZzsgQXJ2ZSBI
asO4bm5ldsOlZyA8YXJ2ZUBhbmRyb2lkLmNvbT47DQo+Sm9lbCBGZXJuYW5kZXMgPGpvZWxAam9l
bGZlcm5hbmRlcy5vcmc+OyBNYXJ0aWpuIENvZW5lbg0KPjxtYWNvQGFuZHJvaWQuY29tPjsgQ2hy
aXN0aWFuIEJyYXVuZXIgPGNocmlzdGlhbkBicmF1bmVyLmlvPg0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0hdIHN0YWdpbmc6IGFuZHJvaWQ6IGlvbjogcmVmYWN0b3J5IGlvbl9hbGxvYyBmb3Iga2VybmVs
DQo+ZHJpdmVyIHVzZQ0KPg0KPk9uIFNhdCwgTWFyIDMwLCAyMDE5IGF0IDAyOjQwOjE2QU0gKzA4
MDAsIFplbmcgVGFvIHdyb3RlOg0KPj4gVGhlcmUgYXJlIHR3byByZWFzb25zIGZvciB0aGlzIHBh
dGNoOg0KPj4gMS4gVGhlcmUgYXJlIHNvbWUgcG90ZW50aWFsIHJlcXVpcmVtZW50cyBmb3IgaW9u
X2FsbG9jIGluIGtlcm5lbA0KPj4gc3BhY2UsIHNvbWUgbWVkaWEgZHJpdmVycyBuZWVkIHRvIGFs
bG9jYXRlIG1lZGlhIGJ1ZmZlcnMgZnJvbSBpb24NCj4+IGluc3RlYWQgb2YgYnVkZHkgb3IgZG1h
IGZyYW1ld29yaywgdGhpcyBpcyBtb3JlIGNvbnZpZW50IGFuZCBjbGVhbg0KPj4gdmVyeSBmb3Ig
bWVkaWEgZHJpdmVycy4gQW5kIEluIHRoYXQgY2FzZSwgaW9uIGlzIHRoZSBvbmx5IG1lZGlhIGJ1
ZmZlcg0KPj4gcHJvdmlkZXIsIGl0J3MgbW9yZSBlYXNpZXIgdG8gbWFpbnRhaW4uDQo+PiAyLiBG
ZCBpcyBvbmx5IG5lZWRlZCBieSB1c2VyIHByb2Nlc3Nlcywgbm90IHRoZSBrZXJuZWwgc3BhY2Us
IHNvDQo+PiBkbWFfYnVmIHNob3VsZCBiZSByZXR1cm5lZCBpbnN0ZWFkIG9mIGZkIGZvciBrZXJu
ZWwgc3BhY2UsIGFuZA0KPj4gZG1hX2J1Zl9mZCBzaG91bGQgYmUgY2FsbGVkIG9ubHkgZm9yIHVz
ZXJzcGFjZSBhcGkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmVuZyBUYW8gPHByaW1lLnplbmdA
aGlzaWxpY29uLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2lvbi9p
b24uYyB8IDMyDQo+PiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPj4gIDEgZmls
ZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQvaW9uL2lvbi5jDQo+PiBiL2RyaXZlcnMv
c3RhZ2luZy9hbmRyb2lkL2lvbi9pb24uYw0KPj4gaW5kZXggOTJjMjkxNC4uZTkzZmI0OSAxMDA2
NDQNCj4+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2lvbi9pb24uYw0KPj4gKysrIGIv
ZHJpdmVycy9zdGFnaW5nL2FuZHJvaWQvaW9uL2lvbi5jDQo+PiBAQCAtMzg3LDEzICszODcsMTMg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkbWFfYnVmX29wcw0KPmRtYV9idWZfb3BzID0gew0KPj4g
IAkudW5tYXAgPSBpb25fZG1hX2J1Zl9rdW5tYXAsDQo+PiAgfTsNCj4+DQo+PiAtc3RhdGljIGlu
dCBpb25fYWxsb2Moc2l6ZV90IGxlbiwgdW5zaWduZWQgaW50IGhlYXBfaWRfbWFzaywgdW5zaWdu
ZWQNCj4+IGludCBmbGFncykNCj4+ICtzdHJ1Y3QgZG1hX2J1ZiAqaW9uX2FsbG9jKHNpemVfdCBs
ZW4sIHVuc2lnbmVkIGludCBoZWFwX2lkX21hc2ssDQo+PiArCQkJICB1bnNpZ25lZCBpbnQgZmxh
Z3MpDQo+PiAgew0KPj4gIAlzdHJ1Y3QgaW9uX2RldmljZSAqZGV2ID0gaW50ZXJuYWxfZGV2Ow0K
Pj4gIAlzdHJ1Y3QgaW9uX2J1ZmZlciAqYnVmZmVyID0gTlVMTDsNCj4+ICAJc3RydWN0IGlvbl9o
ZWFwICpoZWFwOw0KPj4gIAlERUZJTkVfRE1BX0JVRl9FWFBPUlRfSU5GTyhleHBfaW5mbyk7DQo+
PiAtCWludCBmZDsNCj4+ICAJc3RydWN0IGRtYV9idWYgKmRtYWJ1ZjsNCj4+DQo+PiAgCXByX2Rl
YnVnKCIlczogbGVuICV6dSBoZWFwX2lkX21hc2sgJXUgZmxhZ3MgJXhcbiIsIF9fZnVuY19fLA0K
PkBADQo+PiAtNDA3LDcgKzQwNyw3IEBAIHN0YXRpYyBpbnQgaW9uX2FsbG9jKHNpemVfdCBsZW4s
IHVuc2lnbmVkIGludA0KPmhlYXBfaWRfbWFzaywgdW5zaWduZWQgaW50IGZsYWdzKQ0KPj4gIAls
ZW4gPSBQQUdFX0FMSUdOKGxlbik7DQo+Pg0KPj4gIAlpZiAoIWxlbikNCj4+IC0JCXJldHVybiAt
RUlOVkFMOw0KPj4gKwkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7DQo+Pg0KPj4gIAlkb3duX3Jl
YWQoJmRldi0+bG9jayk7DQo+PiAgCXBsaXN0X2Zvcl9lYWNoX2VudHJ5KGhlYXAsICZkZXYtPmhl
YXBzLCBub2RlKSB7IEBAIC00MjEsMTANCj4rNDIxLDEwDQo+PiBAQCBzdGF0aWMgaW50IGlvbl9h
bGxvYyhzaXplX3QgbGVuLCB1bnNpZ25lZCBpbnQgaGVhcF9pZF9tYXNrLA0KPnVuc2lnbmVkIGlu
dCBmbGFncykNCj4+ICAJdXBfcmVhZCgmZGV2LT5sb2NrKTsNCj4+DQo+PiAgCWlmICghYnVmZmVy
KQ0KPj4gLQkJcmV0dXJuIC1FTk9ERVY7DQo+PiArCQlyZXR1cm4gRVJSX1BUUigtRU5PREVWKTsN
Cj4+DQo+PiAgCWlmIChJU19FUlIoYnVmZmVyKSkNCj4+IC0JCXJldHVybiBQVFJfRVJSKGJ1ZmZl
cik7DQo+PiArCQlyZXR1cm4gRVJSX1BUUihQVFJfRVJSKGJ1ZmZlcikpOw0KPj4NCj4+ICAJZXhw
X2luZm8ub3BzID0gJmRtYV9idWZfb3BzOw0KPj4gIAlleHBfaW5mby5zaXplID0gYnVmZmVyLT5z
aXplOw0KPj4gQEAgLTQzMiwxNyArNDMyLDEyIEBAIHN0YXRpYyBpbnQgaW9uX2FsbG9jKHNpemVf
dCBsZW4sIHVuc2lnbmVkIGludA0KPmhlYXBfaWRfbWFzaywgdW5zaWduZWQgaW50IGZsYWdzKQ0K
Pj4gIAlleHBfaW5mby5wcml2ID0gYnVmZmVyOw0KPj4NCj4+ICAJZG1hYnVmID0gZG1hX2J1Zl9l
eHBvcnQoJmV4cF9pbmZvKTsNCj4+IC0JaWYgKElTX0VSUihkbWFidWYpKSB7DQo+PiArCWlmIChJ
U19FUlIoZG1hYnVmKSkNCj4+ICAJCV9pb25fYnVmZmVyX2Rlc3Ryb3koYnVmZmVyKTsNCj4+IC0J
CXJldHVybiBQVFJfRVJSKGRtYWJ1Zik7DQo+PiAtCX0NCj4+DQo+PiAtCWZkID0gZG1hX2J1Zl9m
ZChkbWFidWYsIE9fQ0xPRVhFQyk7DQo+PiAtCWlmIChmZCA8IDApDQo+PiAtCQlkbWFfYnVmX3B1
dChkbWFidWYpOw0KPj4gLQ0KPj4gLQlyZXR1cm4gZmQ7DQo+PiArCXJldHVybiBkbWFidWY7DQo+
PiAgfQ0KPj4gK0VYUE9SVF9TWU1CT0woaW9uX2FsbG9jKTsNCj4NCj5JZiB5b3UgYXJlIGdvaW5n
IHRvIGRvIHRoaXMgKGFuZCBwZXJzb25hbGx5IEknbSB3aXRoIExhdXJhIGluIHRoYXQgSSBkb24n
dA0KPnRoaW5rIHlvdSBuZWVkIGl0KSB0aGlzIHNob3VsZCBiZSBFWFBPUlRfU1lNQk9MX0dQTCgp
IHBsZWFzZS4NCj4NCkFncmVlLCB0aGFua3MgDQoNClJlZ2FyZHMNClplbmd0YW8gDQoNCj50aGFu
a3MsDQo+DQo+Z3JlZyBrLWgNCg==
