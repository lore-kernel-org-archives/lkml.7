Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6796C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E5D218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731240AbfDXPbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:31:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2939 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730792AbfDXPbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:31:47 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id C32F62A72E9C2319A846;
        Wed, 24 Apr 2019 23:31:43 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 23:31:25 +0800
Received: from DGGEMM507-MBX.china.huawei.com ([169.254.1.118]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0415.000;
 Wed, 24 Apr 2019 23:31:23 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "mojha@codeaurora.org" <mojha@codeaurora.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "soren.brinkmann@xilinx.com" <soren.brinkmann@xilinx.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] clk:Fix divide-by-zero in
 divider_ro_round_rate_parent
Thread-Topic: [PATCH v3 1/2] clk:Fix divide-by-zero in
 divider_ro_round_rate_parent
Thread-Index: AQHU5v/EB8Y/TuEMr0agd+bsHqWgi6ZJ+iAAgAF14SA=
Date:   Wed, 24 Apr 2019 15:31:23 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12AB29F5F@dggemm507-mbx.china.huawei.com>
References: <1553954090-65470-1-git-send-email-nixiaoming@huawei.com>
 <155605990288.15276.7089726827167650203@swboyd.mtv.corp.google.com>
In-Reply-To: <155605990288.15276.7089726827167650203@swboyd.mtv.corp.google.com>
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

T24gV2VkLCBBcHIgMjQsIDIwMTkgYXQgNjo1MiBBTSBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5l
bC5vcmc+IHdyb3RlOg0KPlF1b3Rpbmcgbml4aWFvbWluZyAoMjAxOS0wMy0zMCAwNjo1NDo1MCkN
Cj4+IEluIHRoZSBmdW5jdGlvbiBkaXZpZGVyX3JlY2FsY19yYXRlKCkgVGhlIGp1ZGdtZW50IG9m
IHRoZSByZXR1cm4gdmFsdWUgb2YNCj4+IF9nZXRfZGl2KCkgaW5kaWNhdGVzIHRoYXQgdGhlIHJl
dHVybiB2YWx1ZSBvZiBfZ2V0X2RpdigpIGNhbiBiZSAwLg0KPg0KPldoZW4gZG9lcyBfZ2V0X2Rp
digpIHJldHVybiAwPyBJdCBjYW4ndCBiZSBDTEtfRElWSURFUl9NQVhfQVRfWkVSTyBvcg0KPkNM
S19ESVZJREVSX1BPV0VSX09GX1RXTy4gSSBzdXBwb3NlIGl0IGNvdWxkIGJlIENMS19ESVZJREVS
X09ORV9CQVNFRCBpZg0KPkNMS19ESVZJREVSX0FMTE9XX1pFUk8gaXMgc2V0PyBPciBqdXN0IENM
S19ESVZJREVSX0FMTE9XX1pFUk8gaXMgc2V0PyBPcg0KPmEgdGFibGUgdGhhdCBoYXMgMCBpbiBp
dCBmb3Igc29tZSBvZGQgcmVhc29uLg0KPg0KZGl2aWRlcl9yb19yb3VuZF9yYXRlX3BhcmVudCgp
IGlzIGFuIGV4cG9ydGVkIGZ1bmN0aW9uLg0KVGhlcmUgaXMgbm8gcGFyYW1ldGVyIGNoZWNrIG9y
IHJldHVybiB2YWx1ZSBjaGVjayBiZWZvcmUgDQphbmQgYWZ0ZXIgY2FsbGluZyBfZ2V0X2Rpdigp
LCB3aGljaCBtYXkgcmVzdWx0IGluIGEgZGl2aWRlIGJ5IHplcm8gZXJyb3IuDQoNCkNhc2UxOiBU
aGUgImZsYWdzIiBjb250YWlucyBDTEtfRElWSURFUl9PTkVfQkFTRUQsIGFuZCAidmFsIiBpcyAw
Lg0KQ2FzZTI6IFRoZSAiZmxhZ3MiIGRvZXMgbm90IGNvbnRhaW4gQ0xLX0RJVklERVJfT05FX0JB
U0VELCANCiAgICBDTEtfRElWSURFUl9QT1dFUl9PRl9UV08sIENMS19ESVZJREVSX01BWF9BVF9a
RVJPLCAgDQogICAgInRhYmxlIiBpcyBOVUxMLiAgInZhbCIgaXMgMHhmZmZmZmZmZg0KSW4gYm90
aCBjYXNlcyBfZ2V0X2RpdigpIHJldHVybnMgMA0KDQo+PiBJbiBvcmRlciB0byBhdm9pZCB0aGUg
ZGl2aWRlLWJ5LXplcm8gZXJyb3IsIGFkZCBjaGVjayBmb3IgcmV0dXJuIHZhbHVlDQo+PiBvZiBf
Z2V0X2RpdigpIGluIHRoZSBkaXZpZGVyX3JvX3JvdW5kX3JhdGVfcGFyZW50KCkNCj4+IA0KPj4g
U2lnbmVkLW9mZi1ieTogbml4aWFvbWluZyA8bml4aWFvbWluZ0BodWF3ZWkuY29tPg0KPj4gUmV2
aWV3ZWQtYnk6IE11a2VzaCBPamhhIDxtb2poYUBjb2RlYXVyb3JhLm9yZz4NCj4+IC0tLQ0KPj4g
IGRyaXZlcnMvY2xrL2Nsay1kaXZpZGVyLmMgfCAzICsrKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1kaXZp
ZGVyLmMgYi9kcml2ZXJzL2Nsay9jbGstZGl2aWRlci5jDQo+PiBpbmRleCBlNWExNzI2Li5mNGJm
N2E0IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9jbGsvY2xrLWRpdmlkZXIuYw0KPj4gKysrIGIv
ZHJpdmVycy9jbGsvY2xrLWRpdmlkZXIuYw0KPj4gQEAgLTM0Nyw2ICszNDcsOSBAQCBsb25nIGRp
dmlkZXJfcm9fcm91bmRfcmF0ZV9wYXJlbnQoc3RydWN0IGNsa19odyAqaHcsIHN0cnVjdCBjbGtf
aHcgKnBhcmVudCwNCj4+ICAgICAgICAgaW50IGRpdjsNCj4+ICANCj4+ICAgICAgICAgZGl2ID0g
X2dldF9kaXYodGFibGUsIHZhbCwgZmxhZ3MsIHdpZHRoKTsNCj4+ICsgICAgICAgLyogYXZvaWQg
ZGl2aWRlLWJ5LXplcm8gKi8NCj4+ICsgICAgICAgaWYgKCFkaXYpDQo+PiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+DQo+Q2FuIHlvdSBwbGVhc2UgZ2l2ZSBtb3JlIGRldGFpbHMg
b24gd2hhdCdzIGhhcHBlbmluZyBoZXJlPyBXaG8ncyB0aGUNCj5jYWxsZXI/IFdoYXQgYXJlIHRo
ZSBhcmd1bWVudHMgYmVpbmcgcGFzc2VkIGluPyBTaG91bGRuJ3Qgd2UgY2hlY2sgZm9yDQo+Q0xL
X0RJVklERVJfQUxMT1dfWkVSTyBhbmQgdGhlbiByZXR1cm4gcHJhdGUgYXMgaXQgY29tZXMgaW4g
aW5zdGVhZCBvZg0KPnJldHVybmluZyBhbiBlcnJvcj8NCj4NCkkgZm91bmQgdGhhdCB0aGVyZSBt
YXkgYmUgYSBkaXZpZGUtYnktemVybyBlcnJvciBieSBjb2RlIHJldmlldywNCiBmb3IgZXhhbXBs
ZTogImZsYWdzIiBpcyBDTEtfRElWSURFUl9PTkVfQkFTRUQgYW5kICJ2YWwiIGlzIDAuDQpTbyBz
aW1wbHkgYWRkIGEgcmV0dXJuIHZhbHVlIGNoZWNrIHRvIGF2b2lkIGRpdmlkZS1ieS16ZXJvDQoN
CnRoYW5rcyBmb3IgeW91ciBzdWdnZXN0aW9uLCANCkkgd2lsbCByZXNlbmQgdGhlIHBhdGNoIGxh
dGVyDQpyZWZlciB0byB5b3VyIGFkdmljZSBhbmQgZGl2aWRlcl9yZWNhbGNfcmF0ZSgpIHRvIGFk
ZCBhIGNoZWNrIGZvciBDTEtfRElWSURFUl9BTExPV19aRVJPDQoNCnRoYW5rcw0K
