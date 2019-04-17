Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00962C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE63420835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfDQMbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:31:24 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:33784 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:31:23 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 4669367A896;
        Wed, 17 Apr 2019 14:31:21 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 17 Apr
 2019 14:31:20 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 17 Apr 2019 14:31:20 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v5 0/7] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Topic: [PATCH v5 0/7] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Index: AQHU9Rcyt+xmDTJnpkOrxDzu8FWr2KZAJzYA
Date:   Wed, 17 Apr 2019 12:31:20 +0000
Message-ID: <7973d314-078e-8065-682e-c29684455bc4@kontron.de>
References: <20190417121420.21752-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190417121420.21752-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EA25AE1441B2147B913420A42D0B761@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4669367A896.AC5C5
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
        richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGxlYXNlIGZvcmdldCBhYm91dCB0aGlzLCBJIGZvcmdvdCB0byBzcXVhc2ggdGhlIGZpeGVzIGZv
ciBwYXRjaCA1Lg0KSSB3aWxsIHNlbmQgYSBuZXcgdmVyc2lvbi4gU29ycnkhDQoNCk9uIDE3LjA0
LjE5IDE0OjE1LCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0KPiBGcm9tOiBGcmllZGVyIFNjaHJl
bXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQo+IA0KPiBDdXJyZW50bHkgc3VwcG9y
dGVkIGJhZCBibG9jayBtYXJrZXIgcG9zaXRpb25zIHdpdGhpbiB0aGUgYmxvY2sgYXJlOg0KPiAq
IGluIGZpcnN0IHBhZ2Ugb25seQ0KPiAqIGluIGxhc3QgcGFnZSBvbmx5DQo+ICogaW4gZmlyc3Qg
b3Igc2Vjb25kIHBhZ2UNCj4gDQo+IEFmdGVyIHNvbWUgY2xlYW51cCBhbmQgcHJlcGFyYXRpb24g
aW4gcGF0Y2hlcyAxIHRvIDQgd2UgbWFrZSBpdA0KPiBwb3NzaWJsZSB0byBzZXQgTkFORF9CQk1f
RklSU1RQQUdFLCBOQU5EX0JCTV9TRUNPTkRQQUdFIGFuZA0KPiBOQU5EX0JCTV9MQVNUUEFHRSBp
bmRlcGVuZGVudGx5IG9mIGVhY2ggb3RoZXIgKHBhdGNoIDUpLg0KPiANCj4gU29tZSBFU01UIE5B
TkRzIGFyZSBrbm93biB0byBoYXZlIGJlZW4gc2hpcHBlZCBieSB0aGUgbWFudWZhY3R1cmVyDQo+
IHdpdGggYmFkIGJsb2NrIG1hcmtlcnMgaW4gdGhlIGZpcnN0IG9yIGxhc3QgcGFnZSwgaW5zdGVh
ZCBvZiB0aGUNCj4gZmlyc3Qgb3Igc2Vjb25kIHBhZ2UuDQo+IA0KPiBBbHNvIHRoZSBkYXRhc2hl
ZXRzIGZvciBDeXByZXNzL1NwYW5zaW9uL0FNRCBOQU5EcyBjbGFpbSB0aGF0IHRoZQ0KPiBmaXJz
dCwgc2Vjb25kICphbmQqIGxhc3QgcGFnZSBuZWVkcyB0byBiZSBjaGVja2VkLg0KPiANCj4gVGhl
cmVmb3JlIGluIHBhdGNoIDYgYW5kIDcgd2Ugc2V0IGFsbCB0aHJlZSBmbGFncyBmb3INCj4gQU1E
L1NwYW5zaW9uL0N5cHJlc3MgYW5kIEVTTVQgY2hpcHMuDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHY1
Og0KPiA9PT09PT09PT09PT09PQ0KPiAqIFJlYmFzZSBvbnRvIGN1cnJlbnQgbmFuZC9uZXh0DQo+
ICogRml4IG5hbmRfYmJtX2dldF9uZXh0X3BhZ2UoKSBkb2NzDQo+ICogVXNlIGluY2x1c2l2ZSB2
YWx1ZXMgZm9yIHN0YXJ0IHBhZ2UgaW4gbmFuZF9iYm1fZ2V0X25leHRfcGFnZSgpDQo+ICogUmV0
dXJuIC1FSU5WQUwgZnJvbSBuYW5kX2JibV9nZXRfbmV4dF9wYWdlKCkgd2hlbiBubyBtb3JlIHBh
Z2VzIGFyZSBhdmFpbGFibGUNCj4gKiBJbXByb3ZlIGNvZGUgc3R5bGUgaW4gbmFuZF9ibG9ja19i
YWQoKQ0KPiAqIEFkZCBwYXJlbnRoZXNlcyBpbiBzY2FuX2Jsb2NrX2Zhc3QoKSBhbmQgbmFuZF9k
ZWZhdWx0X2Jsb2NrX21hcmtiYWQoKQ0KPiAqIFVuc2lnbiBiYWRibG9ja3BvcyBmaWVsZCBpbiBz
dHJ1Y3QgbmFuZF9jaGlwIGFuZCBzdHJ1Y3Qgb25lbmFuZF9jaGlwDQo+ICogQWRkIFItYiB0YWdz
DQo+IA0KPiBDaGFuZ2VzIGluIHY0Og0KPiA9PT09PT09PT09PT09PQ0KPiAqIE1vdmUgb25lbmFu
ZCBjaGFuZ2VzIHRvIHNlcGFyYXRlIHBhdGNoDQo+ICogQWRkIG1pc3NpbmcgYmFkYmxvY2twb3Mg
ZmllbGQgdG8gb25lbmFuZF9jaGlwIHN0cnVjdA0KPiAqIE1vdmUgY2xlYW51cCBvZiBiYWRibG9j
a3BvcyBmaWVsZCBhbmQgZmxhZ3MgdG8gc2VwYXJhdGUgcGF0Y2gNCj4gKiBNb3ZlIGFzc2lnbmVt
bnQgb2YgYmFkYmxvY2twb3MgZnJvbSBvbmVuYW5kX2JidC5jIHRvIG9uZW5hbmRfYmFzZS5jDQo+
ICogRml4IGluY29ycmVjdCB1c2FnZSBvZiBiYnRfb3B0aW9ucyBpbiBuYW5kX2JidC5jDQo+ICog
QWRkIFItYiB0YWdzDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiA9PT09PT09PT09PT09PQ0KPiAq
IEZpeCBiaXQgb2Zmc2V0cyBmb3IgbmV3IGZsYWdzIGluIG5hbmRfY2hpcC0+b3B0aW9ucw0KPiAq
IE1vdmUgc2VwYXJhdGlvbiBvZiBmbGFncyBmb3IgZmlyc3QgYW5kIHNlY29uZCBwYWdlIG1hcmtl
cnMgdG8gYQ0KPiAgICBzZXBhcmF0ZSBwYXRjaA0KPiAqIEZpeCBjb3ZlciBsZXR0ZXINCj4gKiBG
aXggUy1vLWIgdGFnDQo+ICogQWRkIFItYiB0YWdzDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiA9
PT09PT09PT09PT09PQ0KPiAqIFJlYmFzZSBvbiA1LjAtcmMxDQo+ICogQWRkIHBhdGNoIHRvIG1v
dmUgYmFkIGJsb2NrIG1hcmtlciBwb3NpdGlvbiBpbmZvIHRvIGEgY29tbW9uIHBsYWNlIGFuZA0K
PiAgICByZW5hbWUvcHJlcGFyZSBleGlzdGluZyBmbGFncw0KPiAqIGltcHJvdmUvcmVuYW1lIGZ1
bmN0aW9uIG5hbmRfYmJtX2dldF9uZXh0X3BhZ2UoKSB0byB1c2UgbmV3IGZsYWdzDQo+IC0tLQ0K
PiBGcmllZGVyIFNjaHJlbXBmICg3KToNCj4gICAgbXRkOiByYXduYW5kOiBBbHdheXMgc3RvcmUg
aW5mbyBhYm91dCBiYWQgYmxvY2sgbWFya2VycyBpbiBjaGlwIHN0cnVjdA0KPiAgICBtdGQ6IG9u
ZW5hbmQ6IFN0b3JlIGJhZCBibG9jayBtYXJrZXIgcG9zaXRpb24gaW4gY2hpcCBzdHJ1Y3QNCj4g
ICAgbXRkOiBuYW5kOiBDbGVhbnVwIGZsYWdzIGFuZCBmaWVsZHMgZm9yIGJhZCBibG9jayBtYXJr
ZXIgcG9zaXRpb24NCj4gICAgbXRkOiBuYW5kOiBNYWtlIGZsYWdzIGZvciBiYWQgYmxvY2sgbWFy
a2VyIHBvc2l0aW9uIG1vcmUgZ3JhbnVsYXINCj4gICAgbXRkOiByYXduYW5kOiBTdXBwb3J0IGJh
ZCBibG9jayBtYXJrZXJzIGluIGZpcnN0LCBzZWNvbmQgb3IgbGFzdCBwYWdlDQo+ICAgIG10ZDog
cmF3bmFuZDogRVNNVDogQWxzbyB1c2UgdGhlIGxhc3QgcGFnZSBmb3IgYmFkIGJsb2NrIG1hcmtl
cnMNCj4gICAgbXRkOiByYXduYW5kOiBBTUQ6IEFsc28gdXNlIHRoZSBsYXN0IHBhZ2UgZm9yIGJh
ZCBibG9jayBtYXJrZXJzDQo+IA0KPiAgIGRyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5k
X2Jhc2UuYyB8ICA1ICstDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9vbmVuYW5kL29uZW5hbmRfYmJ0
LmMgIHwgIDMgLS0NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9pbnRlcm5hbHMuaCAgICAgICAg
fCAgMSArDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9hbWQuYyAgICAgICAgIHwgIDgg
KysrLQ0KPiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmFzZS5jICAgICAgICB8IDY0ICsr
KysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2Ji
dC5jICAgICAgICAgfCAyOCArKysrKy0tLS0tLQ0KPiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25h
bmRfZXNtdC5jICAgICAgICB8ICA5ICsrKy0NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5k
X2h5bml4LmMgICAgICAgfCAgNCArLQ0KPiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfbWFj
cm9uaXguYyAgICB8ICAyICstDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9taWNyb24u
YyAgICAgIHwgIDIgKy0NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX3NhbXN1bmcuYyAg
ICAgfCAgNCArLQ0KPiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfdG9zaGliYS5jICAgICB8
ICAyICstDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvc2hfZmxjdGwuYyAgICAgICAgIHwgIDQg
Ky0NCj4gICBpbmNsdWRlL2xpbnV4L210ZC9iYm0uaCAgICAgICAgICAgICAgICAgfCAxNCArLS0t
LS0NCj4gICBpbmNsdWRlL2xpbnV4L210ZC9vbmVuYW5kLmggICAgICAgICAgICAgfCAgMyArKw0K
PiAgIGluY2x1ZGUvbGludXgvbXRkL3Jhd25hbmQuaCAgICAgICAgICAgICB8IDE3ICsrKysrKy0N
Cj4gICAxNiBmaWxlcyBjaGFuZ2VkLCAxMDUgaW5zZXJ0aW9ucygrKSwgNjUgZGVsZXRpb25zKC0p
DQo+IA==
