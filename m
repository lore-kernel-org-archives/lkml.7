Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88662C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD1B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388316AbfB1PMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:12:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2459 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388245AbfB1PM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:12:26 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id B66D33A35A602205F53F;
        Thu, 28 Feb 2019 23:12:20 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 28 Feb 2019 23:12:20 +0800
Received: from DGGEMM528-MBX.china.huawei.com ([169.254.8.114]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0415.000;
 Thu, 28 Feb 2019 23:12:16 +0800
From:   "liujian (CE)" <liujian56@huawei.com>
To:     Tokunori Ikegami <ikegami.t@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "joakim.tjernlund@infinera.com" <joakim.tjernlund@infinera.com>,
        "ikegami@allied-telesis.co.jp" <ikegami@allied-telesis.co.jp>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Topic: [PATCH v3] cfi: fix deadloop in cfi_cmdset_0002.c
 do_write_buffer
Thread-Index: AQHUzdvN8JD42IGEz0+tKjpXrjJ4RaX0wTIAgACMYjA=
Date:   Thu, 28 Feb 2019 15:12:15 +0000
Message-ID: <4F88C5DDA1E80143B232E89585ACE27D0264F137@DGGEMM528-MBX.china.huawei.com>
References: <1551189648-58073-1-git-send-email-liujian56@huawei.com>
 <016001d4cf71$865e7b60$931b7220$@gmail.com>
In-Reply-To: <016001d4cf71$865e7b60$931b7220$@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.97.126]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUb2t1bm9yaSBJa2Vn
YW1pIFttYWlsdG86aWtlZ2FtaS50QGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1
YXJ5IDI4LCAyMDE5IDEwOjI2IFBNDQo+IFRvOiBsaXVqaWFuIChDRSkgPGxpdWppYW41NkBodWF3
ZWkuY29tPjsgZHdtdzJAaW5mcmFkZWFkLm9yZzsNCj4gY29tcHV0ZXJzZm9ycGVhY2VAZ21haWwu
Y29tOyBiYnJlemlsbG9uQGtlcm5lbC5vcmc7DQo+IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgcmlj
aGFyZEBub2QuYXQ7IGpvYWtpbS50amVybmx1bmRAaW5maW5lcmEuY29tOw0KPiBpa2VnYW1pQGFs
bGllZC10ZWxlc2lzLmNvLmpwOyBrZWVzY29va0BjaHJvbWl1bS5vcmc7IHZpZ25lc2hyQHRpLmNv
bQ0KPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2M10gY2ZpOiBmaXggZGVhZGxvb3Ag
aW4gY2ZpX2NtZHNldF8wMDAyLmMgZG9fd3JpdGVfYnVmZmVyDQo+IA0KPiANCj4gDQo+ID4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBsaW51eC1tdGQgW21haWx0bzpsaW51
eC1tdGQtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQub3JnXSBPbg0KPiA+IEJlaGFsZiBPZiBMaXUg
Smlhbg0KPiA+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDI2LCAyMDE5IDExOjAxIFBNDQo+ID4g
VG86IGR3bXcyQGluZnJhZGVhZC5vcmc7IGNvbXB1dGVyc2ZvcnBlYWNlQGdtYWlsLmNvbTsNCj4g
PiBiYnJlemlsbG9uQGtlcm5lbC5vcmc7IG1hcmVrLnZhc3V0QGdtYWlsLmNvbTsgcmljaGFyZEBu
b2QuYXQ7DQo+ID4gam9ha2ltLnRqZXJubHVuZEBpbmZpbmVyYS5jb207IGlrZWdhbWlAYWxsaWVk
LXRlbGVzaXMuY28uanA7DQo+ID4ga2Vlc2Nvb2tAY2hyb21pdW0ub3JnOyB2aWduZXNockB0aS5j
b20NCj4gPiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpdWppYW41NkBodWF3
ZWkuY29tOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiBTdWJqZWN0OiBb
UEFUQ0ggdjNdIGNmaTogZml4IGRlYWRsb29wIGluIGNmaV9jbWRzZXRfMDAwMi5jDQo+ID4gZG9f
d3JpdGVfYnVmZmVyDQo+ID4NCj4gPiBJbiBmdW5jdGlvbiBkb193cml0ZV9idWZmZXIoKSwgaW4g
dGhlIGZvciBsb29wLCB0aGVyZSBpcyBhIGNhc2UNCj4gPiBjaGlwX3JlYWR5KCkgcmV0dXJucyAx
IHdoaWxlIGNoaXBfZ29vZCgpIHJldHVybnMgMCwgc28gaXQgbmV2ZXIgYnJlYWsNCj4gPiB0aGUg
bG9vcC4NCj4gPiBUbyBmaXggdGhpcywgY2hpcF9nb29kKCkgaXMgZW5vdWdoIGFuZCBpdCBzaG91
bGQgdGltZW91dCBpZiBpdCBzdGF5DQo+ID4gYmFkIGZvciBhIHdoaWxlLg0KPiA+DQo+ID4gRml4
ZXM6IGRmZWFlMTA3MzU4MygibXRkOiBjZmlfY21kc2V0XzAwMDI6IENoYW5nZSB3cml0ZSBidWZm
ZXIgdG8NCj4gPiBjaGVjayBjb3JyZWN0IHZhbHVlIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZaSBI
dWFpamllIDx5aWh1YWlqaWVAaHVhd2VpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgSmlh
biA8bGl1amlhbjU2QGh1YXdlaS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFRva3Vub3JpIElrZWdh
bWkgPGlrZWdhbWlfdG9AeWFob28uY28uanA+DQo+ID4gLS0tDQo+ID4gdjItPnYzOg0KPiA+IEZv
bGxvdyBWaWduZXNoJ3MgYWR2aWNlOg0KPiA+IGFkZCBvbmUgbW9yZSBjaGVjayBmb3IgY2hlY2tf
Z29vZCgpIGV2ZW4gd2hlbiB0aW1lX2FmdGVyKCkgcmV0dXJucyB0cnVlLg0KPiA+DQo+ID4gIGRy
aXZlcnMvbXRkL2NoaXBzL2NmaV9jbWRzZXRfMDAwMi5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9jaGlwcy9jZmlfY21kc2V0XzAwMDIuYw0KPiA+IGIvZHJpdmVycy9tdGQv
Y2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMNCj4gPiBpbmRleCA3MjQyOGI2Li4zZGEyMzc2IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRkL2NoaXBzL2NmaV9jbWRzZXRfMDAwMi5jDQo+ID4gKysr
IGIvZHJpdmVycy9tdGQvY2hpcHMvY2ZpX2NtZHNldF8wMDAyLmMNCj4gPiBAQCAtMTg3Niw3ICsx
ODc2LDcgQEAgc3RhdGljIGludCBfX3hpcHJhbSBkb193cml0ZV9idWZmZXIoc3RydWN0DQo+ID4g
bWFwX2luZm8gKm1hcCwgc3RydWN0IGZsY2hpcCAqY2hpcCwNCj4gPiAgCQkJY29udGludWU7DQo+
ID4gIAkJfQ0KPiA+DQo+ID4gLQkJaWYgKHRpbWVfYWZ0ZXIoamlmZmllcywgdGltZW8pICYmICFj
aGlwX3JlYWR5KG1hcCwgYWRyKSkNCj4gPiArCQlpZiAodGltZV9hZnRlcihqaWZmaWVzLCB0aW1l
bykgJiYgIWNoaXBfZ29vZChtYXAsIGFkciwNCj4gPiBkYXR1bSkpDQo+IA0KPiAgIEp1c3QgYW5v
dGhlciBpZGVhIHRvIHVuZGVyc3RhbmQgZWFzaWx5Lg0KPiANCj4gICAgIHVuc2lnbmVkIGxvbmcg
bm93ID0gamlmZmllczsNCj4gDQo+ICAgICBpZiAoY2hpcF9nb29kKG1hcCwgYWRyLCBkYXR1bSkp
IHsNCj4gICAgICAgICB4aXBfZW5hYmxlKG1hcCwgY2hpcCwgYWRyKTsNCj4gICAgICAgICBnb3Rv
IG9wX2RvbmU7DQo+ICAgICB9DQo+IA0KPiAgICAgaWYgKHRpbWVfYWZ0ZXIobm93LCB0aW1lbykg
ew0KPiAgICAgICAgIGJyZWFrOw0KPiAgICAgfQ0KPiANCg0KVGhhbmsgeW91fi4gSXQgaXMgbW9y
ZSBlYXNpZXIgdG8gdW5kZXJzdGFuZKOhDQpJZiB0aGVyZSBhcmUgbm8gb3RoZXIgY29tbWVudHMs
IEkgd2lsbCBzZW5kIG5ldyBwYXRjaCBhZ2FpbiApOiAgDQoNCkJlc3QgUmVnYXJkcywNCkxpdWpp
YW4NCg0KPiBSZWdhcmRzLA0KPiBJa2VnYW1pDQo+IA0KPiA+ICAJCQlicmVhazsNCj4gPg0KPiA+
ICAJCWlmIChjaGlwX2dvb2QobWFwLCBhZHIsIGRhdHVtKSkgew0KPiA+IC0tDQo+ID4gMi43LjQN
Cj4gPg0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+ID4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0DQo+ID4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvDQoN
Cg==
