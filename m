Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E0C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F700218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390468AbfISNdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:33:05 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:33392 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389991AbfISNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:33:04 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 7AE1667A652;
        Thu, 19 Sep 2019 15:33:02 +0200 (CEST)
Received: from sntmail14r.snt-is.com (10.203.32.184) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Sep
 2019 15:33:01 +0200
Received: from sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8]) by
 sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8%3]) with mapi id
 15.01.1713.004; Thu, 19 Sep 2019 15:33:01 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Piotr Sroka <piotrs@cadence.com>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Boris Brezillon" <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] - change calculating of position page containing BBM
Thread-Topic: [PATCH] - change calculating of position page containing BBM
Thread-Index: AQHVbufQ3Mlqal1wVUGzYKwyTjL7Iacy1HqAgAAEsICAAADoAIAABBqA
Date:   Thu, 19 Sep 2019 13:33:01 +0000
Message-ID: <7a9675e4-8bcc-f822-6028-f78d0d12c3bf@kontron.de>
References: <20190919124139.10856-1-piotrs@cadence.com>
 <20190919145819.66e74aef@xps13>
 <f03d93a5-4393-2405-b597-80b762059f01@kontron.de>
 <20190919151820.2bb8313d@xps13>
In-Reply-To: <20190919151820.2bb8313d@xps13>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <88D06F7733C0434CBD14FC36A30B9E8C@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7AE1667A652.A175D
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, piotrs@cadence.com, richard@nod.at,
        vigneshr@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDkuMTkgMTU6MTgsIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+IEhlbGxvLA0KPiANCj4g
U2NocmVtcGYgRnJpZWRlciA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPiB3cm90ZSBvbiBU
aHUsIDE5IFNlcA0KPiAyMDE5IDEzOjE1OjA4ICswMDAwOg0KPiANCj4+IE9uIDE5LjA5LjE5IDE0
OjU4LCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0KPj4+IEhpIFBpb3RyLA0KPj4+DQo+Pj4gUGlvdHIg
U3Jva2EgPHBpb3Ryc0BjYWRlbmNlLmNvbT4gd3JvdGUgb24gVGh1LCAxOSBTZXAgMjAxOSAxMzo0
MTozNQ0KPj4+ICswMTAwOg0KPj4+ICAgIA0KPj4+PiBDaGFuZ2UgY2FsY3VsYXRpbmcgb2YgcG9z
aXRpb24gcGFnZSBjb250YWluaW5nIEJCTQ0KPj4+Pg0KPj4+PiBJZiBub25lIG9mIEJCTSBmbGFn
cyBpcyBzZXQgdGhlbiBmdW5jdGlvbiBuYW5kX2JibV9nZXRfbmV4dF9wYWdlDQo+Pj4+IHJlcG9y
dHMgRUlOVkFMLiBJdCBjYXVzZXMgdGhhdCBCQk0gaXMgbm90IHJlYWQgYXQgYWxsIGR1cmluZyBz
Y2FubmluZw0KPj4+PiBmYWN0b3J5IGJhZCBibG9ja3MuIFRoZSByZXN1bHQgaXMgdGhhdCB0aGUg
QkJUIHRhYmxlIGlzIGJ1aWxkIHdpdGhvdXQNCj4+Pj4gY2hlY2tpbmcgZmFjdG9yeSBCQk0gYXQg
YWxsLiBGb3IgTWljcm9uIGZsYXNoIG1lbW9yaWVzIG5vbmUgb2YgdGhpcw0KPj4+PiBmbGFnIGlz
IHNldCBpZiBwYWdlIHNpemUgaXMgZGlmZmVyZW50IHRoYW4gMjA0OCBieXRlcy4NCj4+DQo+PiBJ
IHdvbmRlciBpZiBpdCB3b3VsZG4ndCBiZSBiZXR0ZXIgdG8gZml4IHRoZSBNaWNyb24gZHJpdmVy
IGluc3RlYWQ6DQo+Pg0KPj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9taWNyb24u
Yw0KPj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9taWNyb24uYw0KPj4gQEAgLTQ0
OCw2ICs0NDgsOCBAQCBzdGF0aWMgaW50IG1pY3Jvbl9uYW5kX2luaXQoc3RydWN0IG5hbmRfY2hp
cCAqY2hpcCkNCj4+DQo+PiAgICAgICAgICAgaWYgKG10ZC0+d3JpdGVzaXplID09IDIwNDgpDQo+
PiAgICAgICAgICAgICAgICAgICBjaGlwLT5vcHRpb25zIHw9IE5BTkRfQkJNX0ZJUlNUUEFHRSB8
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5BTkRfQkJNX1NFQ09ORFBB
R0U7DQo+PiArICAgICAgIGVsc2UNCj4+ICsgICAgICAgICAgICAgICBjaGlwLT5vcHRpb25zIHw9
IE5BTkRfQkJNX0ZJUlNUUEFHRTsNCj4gDQo+IFRoYXQncyB3aGF0IEkgZm9yZ290IGluIG15IGxh
c3QgYW5zd2VyIHRvIHRoaXMgdGhyZWFkLCBJIHRoaW5rIEkgb25seQ0KPiB0b2xkIFBpb3RyIHBy
aXZhdGVseTogSSB3b3VsZCBsaWtlIGJvdGguIEkgdGhpbmsgaXQgaXMgaW1wb3J0YW50IHRvIGZp
eA0KPiB0aGUgYmJtX2dldF9uZXh0X3BhZ2UgZnVuY3Rpb24gYnV0IGZvciBjbGFyaXR5LCBzZXR0
aW5nIHRoZSBGSVJTVFBBR0UNCj4gZmxhZyBpbiBNaWNyb24ncyBkcml2ZXIgc2VlbXMgYWxzbyBw
ZXJ0aW5lbnQuDQoNCkluZGVlZCwgdGhhdCBzb3VuZHMgcmVhc29uYWJsZS4gUGlvdHIsIGNhbiB5
b3Ugc2VuZCBhbm90aGVyIHBhdGNoIHdpdGggDQp0aGUgZGlmZiBhYm92ZT8gQW5kIGJ5IHRoZSB3
YXk6IHRoYW5rcyBmb3IgZml4aW5nIG15IGNvZGUgOykNCg0KUmV2aWV3ZWQtYnk6IEZyaWVkZXIg
U2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCg0KPiANCj4+DQo+PiAgICAg
ICAgICAgb25kaWUgPSBtaWNyb25fc3VwcG9ydHNfb25fZGllX2VjYyhjaGlwKTsNCj4+DQo+Pg0K
Pj4+DQo+Pj4gIm5vbmUgb2YgdGhlc2UgZmxhZ3MgYXJlIHNldCINCj4+PiAgICANCj4+Pj4NCj4+
Pj4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSBuYW5kX2JibV9nZXRfbmV4dF9wYWdlIGZ1bmN0aW9u
Lg0KPj4+DQo+Pj4gIkFkZHJlc3MgdGhpcyByZWdyZXNzaW9uIGJ5IGNoYW5naW5nIHRoZQ0KPj4+
IG5hbmRfYmJtX2dldF9uZXh0X3BhZ2VfZnVuY3Rpb24uIg0KPj4+ICAgIA0KPj4+PiBJdCB3aWxs
IHJldHVybiAwIGlmIG5vbmUgb2YgQkJNIGZsYWcgaXMgc2V0IGFuZCBwYWdlIHBhcmFtZXRlciBp
cyAwLg0KPj4+DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgbm8gQkJNIGZsYWcgaXMgc2V0
DQo+Pj4gICAgDQo+Pj4+IEFmdGVyIHRoYXQgbW9kaWZpY2F0aW9uIHdheSBvZiBkaXNjb3Zlcmlu
ZyBmYWN0b3J5IGJhZCBibG9ja3Mgd2lsbCB3b3JrDQo+Pj4+IHNpbWlsYXIgYXMgaW4ga2VybmVs
IHZlcnNpb24gNS4xLg0KPj4+PiAgIA0KPj4+DQo+Pj4gRml4ZXMgKyBzdGFibGUgdGFncyB3b3Vs
ZCBiZSBncmVhdCENCj4+PiAgICANCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGlvdHIgU3Jva2EgPHBp
b3Ryc0BjYWRlbmNlLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMvbXRkL25hbmQvcmF3
L25hbmRfYmFzZS5jIHwgOCArKysrKystLQ0KPj4+PiAgICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMgYi9kcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Jh
c2UuYw0KPj4+PiBpbmRleCA1YzJjMzBhN2RmZmEuLmY2NGUzYjY2MDVjNiAxMDA2NDQNCj4+Pj4g
LS0tIGEvZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMNCj4+Pj4gKysrIGIvZHJpdmVy
cy9tdGQvbmFuZC9yYXcvbmFuZF9iYXNlLmMNCj4+Pj4gQEAgLTI5MiwxMiArMjkyLDE2IEBAIGlu
dCBuYW5kX2JibV9nZXRfbmV4dF9wYWdlKHN0cnVjdCBuYW5kX2NoaXAgKmNoaXAsIGludCBwYWdl
KQ0KPj4+PiAgICAJc3RydWN0IG10ZF9pbmZvICptdGQgPSBuYW5kX3RvX210ZChjaGlwKTsNCj4+
Pj4gICAgCWludCBsYXN0X3BhZ2UgPSAoKG10ZC0+ZXJhc2VzaXplIC0gbXRkLT53cml0ZXNpemUp
ID4+DQo+Pj4+ICAgIAkJCSBjaGlwLT5wYWdlX3NoaWZ0KSAmIGNoaXAtPnBhZ2VtYXNrOw0KPj4+
PiArCXVuc2lnbmVkIGludCBiYm1fZmxhZ3MgPSBOQU5EX0JCTV9GSVJTVFBBR0UgfCBOQU5EX0JC
TV9TRUNPTkRQQUdFDQo+Pj4+ICsJCXwgTkFORF9CQk1fTEFTVFBBR0U7DQo+Pj4+ICAgIA0KPj4+
PiArCWlmIChwYWdlID09IDAgJiYgIShjaGlwLT5vcHRpb25zICYgYmJtX2ZsYWdzKSkNCj4+Pj4g
KwkJcmV0dXJuIDA7DQo+Pj4+ICAgIAlpZiAocGFnZSA9PSAwICYmIGNoaXAtPm9wdGlvbnMgJiBO
QU5EX0JCTV9GSVJTVFBBR0UpDQo+Pj4+ICAgIAkJcmV0dXJuIDA7DQo+Pj4+IC0JZWxzZSBpZiAo
cGFnZSA8PSAxICYmIGNoaXAtPm9wdGlvbnMgJiBOQU5EX0JCTV9TRUNPTkRQQUdFKQ0KPj4+PiAr
CWlmIChwYWdlIDw9IDEgJiYgY2hpcC0+b3B0aW9ucyAmIE5BTkRfQkJNX1NFQ09ORFBBR0UpDQo+
Pj4+ICAgIAkJcmV0dXJuIDE7DQo+Pj4+IC0JZWxzZSBpZiAocGFnZSA8PSBsYXN0X3BhZ2UgJiYg
Y2hpcC0+b3B0aW9ucyAmIE5BTkRfQkJNX0xBU1RQQUdFKQ0KPj4+PiArCWlmIChwYWdlIDw9IGxh
c3RfcGFnZSAmJiBjaGlwLT5vcHRpb25zICYgTkFORF9CQk1fTEFTVFBBR0UpDQo+Pj4+ICAgIAkJ
cmV0dXJuIGxhc3RfcGFnZTsNCj4+Pj4gICAgDQo+Pj4+ICAgIAlyZXR1cm4gLUVJTlZBTDsNCj4+
Pg0KPj4+IExvb2tncyBnb29kIG90aGVyd2lzZS4NCj4+Pg0KPj4+IFRoYW5rcywNCj4+PiBNaXF1
w6hsDQo+Pj4gICANCj4gDQo+IFRoYW5rcywNCj4gTWlxdcOobA0KPiA=
