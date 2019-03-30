Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C492C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02982218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfC3CED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:04:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2099 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730107AbfC3CED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:04:03 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 518A5EDF6931E36797A6;
        Sat, 30 Mar 2019 10:03:59 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 30 Mar 2019 10:03:58 +0800
Received: from DGGEMM527-MBS.china.huawei.com ([169.254.5.15]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0415.000;
 Sat, 30 Mar 2019 10:03:54 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "rnayak@ti.com" <rnayak@ti.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk:Fix divide by 0 error in
 divider_ro_round_rate_parent
Thread-Topic: [PATCH] clk:Fix divide by 0 error in
 divider_ro_round_rate_parent
Thread-Index: AQHU5g4qGuS4E91IJkeHCCRnAu+mCqYirwcAgAC2brA=
Date:   Sat, 30 Mar 2019 02:03:54 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12AABF10E@DGGEMM527-MBS.china.huawei.com>
References: <1553850324-25625-1-git-send-email-nixiaoming@huawei.com>
 <155389932276.20095.12054188967513679921@swboyd.mtv.corp.google.com>
In-Reply-To: <155389932276.20095.12054188967513679921@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8zMC8yMDE5IDY6NDIgQU0gU3RlcGhlbiBCb3lkIHdyb3RlOg0KPlF1b3Rpbmcgbml4aWFv
bWluZyAoMjAxOS0wMy0yOSAwMjowNToyNCkNCj4+IEluIHRoZSBmdW5jdGlvbiBkaXZpZGVyX3Jl
Y2FsY19yYXRlIFRoZSBqdWRnbWVudCBvZiB0aGUgcmV0dXJuIHZhbHVlIG9mDQo+DQo+UGxlYXNl
IHdyaXRlIGRpdmlkZXJfcmVjYWxjX3JhdGUoKSB3aXRoIHBhcmVudGhlc2lzIHRvIHNob3cgaXQn
cyBhDQo+ZnVuY3Rpb24uDQo+DQo+PiBfZ2V0X2RpdiBpbmRpY2F0ZXMgdGhhdCB0aGUgcmV0dXJu
IHZhbHVlIG9mIF9nZXRfZGl2IG1heSBiZSAwLg0KPg0KPl9fZ2V0X2RpdigpDQpUaGFuayB5b3Ug
Zm9yIHlvdXIgZ3VpZGFuY2UsIEkgd2lsbCBjb3JyZWN0IGl0IGxhdGVyIGluIHRoZSBwYXRjaC4N
Cg0KPj4gSW4gb3JkZXIgdG8gYXZvaWQgdGhlIGRpdmlkZS1ieS16ZXJvIGVycm9yLCBhZGQgY2hl
Y2sgdGhlIHJldHVybiB2YWx1ZQ0KPj4gb2YgX2dldF9kaXYgaW4gdGhlIGRpdmlkZXJfcm9fcm91
bmRfcmF0ZV9wYXJlbnQNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogbml4aWFvbWluZyA8bml4aWFv
bWluZ0BodWF3ZWkuY29tPg0KPg0KPklzIHRoaXMgeW91ciBuYW1lPyBuaXhpYW9taW5nPyBPciBp
cyBpdCB3cml0dGVuIHNvbWUgb3RoZXIgd2F5Pw0KDQpDaGluZXNlIG5hbWUg5YCq5bCP5piODQo+
PiAtLS0NCj4+ICBkcml2ZXJzL2Nsay9jbGstZGl2aWRlci5jIHwgMiArKw0KPj4gIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L2Nsay1kaXZpZGVyLmMgYi9kcml2ZXJzL2Nsay9jbGstZGl2aWRlci5jDQo+PiBpbmRleCBlNWEx
NzI2Li4wODU0ZTNlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLWRpdmlkZXIuYw0K
Pj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWRpdmlkZXIuYw0KPj4gQEAgLTM0Nyw2ICszNDcsOCBA
QCBsb25nIGRpdmlkZXJfcm9fcm91bmRfcmF0ZV9wYXJlbnQoc3RydWN0IGNsa19odyAqaHcsIHN0
cnVjdCBjbGtfaHcgKnBhcmVudCwNCj4+ICAgICAgICAgaW50IGRpdjsNCj4+ICANCj4+ICAgICAg
ICAgZGl2ID0gX2dldF9kaXYodGFibGUsIHZhbCwgZmxhZ3MsIHdpZHRoKTsNCj4+ICsgICAgICAg
aWYgKCFkaXYpIC8qIGF2b2lkIGRpdmlkZS1ieS16ZXJvICovDQo+PiArICAgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7DQo+DQo+SG93IGRvZXMgX2dldF9kaXYoKSByZXR1cm4gMD8gV2hhdCBp
cyB0aGUgdmFsdWUgb2YgJ2ZsYWdzJyBoZXJlIHdoZW4NCj50aGlzIGdvZXMgd3Jvbmc/DQoNCmRp
dmlkZXJfcm9fcm91bmRfcmF0ZV9wYXJlbnQoKSBhbmQgZGl2aWRlcl9yZWNhbGNfcmF0ZSgpIGFy
ZSBmdW5jdGlvbnMNCiBvZiB0aGUgRVhQT1JUX1NZTUJPTF9HUEwgYXR0cmlidXRlDQoNCklmIF9n
ZXRfZGl2KCkgY2FuIHJldHVybiAwIGluIHRoZSBhcmd1bWVudCBvZiBkaXZpZGVyX3JlY2FsY19y
YXRlKCkNClRoZW4gc2hvdWxkIGJlIGFibGUgdG8gcmV0dXJuIDAgaW4gZGl2aWRlcl9yb19yb3Vu
ZF9yYXRlX3BhcmVudCgpDQoNCj4NCj4+ICANCj4+ICAgICAgICAgLyogRXZlbiBhIHJlYWQtb25s
eSBjbG9jayBjYW4gcHJvcGFnYXRlIGEgcmF0ZSBjaGFuZ2UgKi8NCj4+ICAgICAgICAgaWYgKGNs
a19od19nZXRfZmxhZ3MoaHcpICYgQ0xLX1NFVF9SQVRFX1BBUkVOVCkgew0KPj4gLS0gDQo+PiAx
LjguNS42DQo+PiANCj4NCj5Xb3cgdGhhdCdzIGEgNSB5ZWFyIG9sZCB2ZXJzaW9uIG9mIGdpdCEN
Cj4NCj4NCg==
