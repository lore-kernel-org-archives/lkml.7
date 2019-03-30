Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE24C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AF7218D9
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 02:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbfC3CUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 22:20:34 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730001AbfC3CUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 22:20:33 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 2B92843BD1C6D1B2CA67;
        Sat, 30 Mar 2019 10:20:31 +0800 (CST)
Received: from DGGEMM527-MBS.china.huawei.com ([169.254.5.15]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0415.000;
 Sat, 30 Mar 2019 10:20:27 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "chao.xie@marvell.com" <chao.xie@marvell.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk:mmp: clk-mix.c fix divide-by-zero
Thread-Topic: [PATCH] clk:mmp: clk-mix.c fix divide-by-zero
Thread-Index: AQHU5iSaev3dXbGlJEaC+jDlGRDXyaYisJYAgAC9fAA=
Date:   Sat, 30 Mar 2019 02:20:27 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12AAC0143@DGGEMM527-MBS.china.huawei.com>
References: <1553859960-31501-1-git-send-email-nixiaoming@huawei.com>
 <155389969479.20095.682832622477946593@swboyd.mtv.corp.google.com>
In-Reply-To: <155389969479.20095.682832622477946593@swboyd.mtv.corp.google.com>
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

T24gMy8zMC8yMDE5IDY6NDggQU0gU3RlcGhlbiBCb3lkIHdyb3RlOg0KPlF1b3Rpbmcgbml4aWFv
bWluZyAoMjAxOS0wMy0yOSAwNDo0NjowMCkNCj4+IFRoZSBfZ2V0X2RpdiBmdW5jdGlvbiBoYXMg
YSBicmFuY2ggd2l0aCBhIHJldHVybiB2YWx1ZSBvZiAwDQo+PiBBZGQgYSBjaGVjayBvbiB0aGUg
cmV0dXJuIHZhbHVlIG9mIF9nZXRfZGl2IHRvIGF2b2lkIGRpdmlkZS1ieS16ZXJvDQo+PiANCj4+
IFNpZ25lZC1vZmYtYnk6IG5peGlhb21pbmcgPG5peGlhb21pbmdAaHVhd2VpLmNvbT4NCj4NCj5T
aW1pbGFyIHF1ZXN0aW9ucyBhcHBseSBoZXJlIGFzIHRoZXkgZG8gb24gdGhlIGdlbmVyaWMgZGl2
aWRlciBwYXRjaCB5b3UNCj5zZW50Lg0KPg0KX2dldF9kaXYoKSBpbiBib3RoIGZpbGVzIGlzIGEg
ZGlmZmVyZW50IGZ1bmN0aW9uLCB3aXRoIGEgZGl2aWRlLWJ5LXplcm8gcHJvYmxlbQ0KSSB3aWxs
IG9yZ2FuaXplIGl0IGludG8gYSBwYXRjaCBzZXQgbGF0ZXIuDQoNCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvY2xrL21tcC9jbGstbWl4LmMgfCA0ICsrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tbXAvY2xrLW1peC5j
IGIvZHJpdmVycy9jbGsvbW1wL2Nsay1taXguYw0KPj4gaW5kZXggOTA4MTRiMi4uOWQxNTJjMiAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xrL21tcC9jbGstbWl4LmMNCj4+ICsrKyBiL2RyaXZl
cnMvY2xrL21tcC9jbGstbWl4LmMNCj4+IEBAIC0yNDUsNiArMjQ1LDggQEAgc3RhdGljIGludCBt
bXBfY2xrX21peF9kZXRlcm1pbmVfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgIGRpdl92YWxfbWF4ID0gX2dldF9tYXhkaXYobWl4KTsNCj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBkaXZfdmFsX21heDsgaisrKSB7DQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpdiA9IF9nZXRfZGl2KG1peCwgaik7
DQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICghZGl2KSAvKiBhdm9pZCBk
aXZpZGUtYnktemVybyAqLw0KPg0KPldoeSBjYW4ndCB3ZSByZXR1cm4gMSBmb3IgdGhlIGRpdmlk
ZXIgdmFsdWUgaGVyZT8NCg0KSSBwZXJzb25hbGx5IHVuZGVyc3RhbmQgdGhhdCBhbiBleGNlcHRp
b24gb3Igc2tpcCBzaG91bGQgYmUgdGhyb3duIGFmdGVyIGRpdmlkaW5nIGJ5IDAuDQpEaXJlY3Rs
eSBtb2RpZmllZCB0byBvdGhlciB2YWx1ZXMsIEkgYW0gbm90IHN1cmUgd2hldGhlciBpdCBhZmZl
Y3RzIHRoZSBsb2dpYw0KTXkgbG9naWNhbCB1bmRlcnN0YW5kaW5nIG9mIHRoaXMgY29kZSBpcyBu
b3QgY2xlYXIgZW5vdWdoLCBJIHN0aWxsIG5lZWQgeW91ciBndWlkYW5jZS4NCj4NCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgbWl4X3JhdGUgPSBwYXJlbnRfcmF0ZSAvIGRpdjsNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ2FwID0gYWJzKG1peF9yYXRlIC0gcmVx
LT5yYXRlKTsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFwYXJlbnRf
YmVzdCB8fCBnYXAgPCBnYXBfYmVzdCkgew0KPj4gQEAgLTM0MSw2ICszNDMsOCBAQCBzdGF0aWMg
dW5zaWduZWQgbG9uZyBtbXBfY2xrX21peF9yZWNhbGNfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywN
Cj4+ICAgICAgICAgc2hpZnQgPSBtaXgtPnJlZ19pbmZvLnNoaWZ0X2RpdjsNCj4+ICANCj4+ICAg
ICAgICAgZGl2ID0gX2dldF9kaXYobWl4LCBNTVBfQ0xLX0JJVFNfR0VUX1ZBTChtdXhfZGl2LCB3
aWR0aCwgc2hpZnQpKTsNCj4+ICsgICAgICAgaWYgKCFkaXYpIC8qIGF2b2lkIGRpdmlkZS1ieS16
ZXJvICovDQo+DQo+U2FtZSBxdWVzdGlvbi4NCkkgcGVyc29uYWxseSB1bmRlcnN0YW5kIHRoYXQg
YW4gZXhjZXB0aW9uIG9yIHNraXAgc2hvdWxkIGJlIHRocm93biBhZnRlciBkaXZpZGluZyBieSAw
Lg0KRGlyZWN0bHkgbW9kaWZpZWQgdG8gb3RoZXIgdmFsdWVzLCBJIGFtIG5vdCBzdXJlIHdoZXRo
ZXIgaXQgYWZmZWN0cyB0aGUgbG9naWMNCk15IGxvZ2ljYWwgdW5kZXJzdGFuZGluZyBvZiB0aGlz
IGNvZGUgaXMgbm90IGNsZWFyIGVub3VnaCwgSSBzdGlsbCBuZWVkIHlvdXIgZ3VpZGFuY2UuDQo+
DQo+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiAgDQo+PiAgICAgICAgIHJl
dHVybiBwYXJlbnRfcmF0ZSAvIGRpdjsNCj4+ICB9DQo+DQo=
