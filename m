Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE47C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B15218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfCUIr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:47:57 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:32914 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbfCUIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:47:57 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id A6DD967A90E;
        Thu, 21 Mar 2019 09:47:53 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 21 Mar
 2019 09:47:53 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 21 Mar 2019 09:47:53 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "richard@nod.at" <richard@nod.at>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/7] mtd: onenand: Store bad block marker position in
 chip struct
Thread-Topic: [PATCH v4 2/7] mtd: onenand: Store bad block marker position in
 chip struct
Thread-Index: AQHUx3asBl+PaSojc0CFv8B5tA994qX7UtGAgBqTBwA=
Date:   Thu, 21 Mar 2019 08:47:52 +0000
Message-ID: <71f425a5-4028-1a8a-26db-b4b0860326dc@kontron.de>
References: <20190218104122.18788-1-frieder.schrempf@kontron.de>
 <20190218104122.18788-3-frieder.schrempf@kontron.de>
 <20190304115853.35216632@xps13>
In-Reply-To: <20190304115853.35216632@xps13>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB0D8AA8A2B96C4E81CDF431E3008133@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: A6DD967A90E.A0A26
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMDMuMTkgMTE6NTgsIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+IEhpIEZyaWVkZXIsDQo+
IA0KPiBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+IHdyb3Rl
IG9uIE1vbiwgMTggRmViDQo+IDIwMTkgMTA6NDI6NDEgKzAwMDA6DQo+IA0KPj4gRnJvbTogRnJp
ZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPj4NCj4+IFRoZSBp
bmZvcm1hdGlvbiBhYm91dCB3aGVyZSB0aGUgbWFudWZhY3R1cmVyIHB1dHMgdGhlIGJhZCBibG9j
aw0KPj4gbWFya2VycyBpbnNpZGUgdGhlIGJhZCBibG9jayBhbmQgaW4gdGhlIE9PQiBkYXRhIGlz
IHN0b3JlZCBpbg0KPj4gZGlmZmVyZW50IHBsYWNlcy4gTGV0J3MgbW92ZSB0aGlzIGluZm9ybWF0
aW9uIHRvIHRoZSBjaGlwIHN0cnVjdCwNCj4+IGFzIHdlIGRpZCBpdCBmb3IgcmF3bmFuZC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9tdGQvbmFuZC9vbmVuYW5kL29uZW5hbmRf
YmFzZS5jIHwgNSArKysrLQ0KPj4gICBkcml2ZXJzL210ZC9uYW5kL29uZW5hbmQvb25lbmFuZF9i
YnQuYyAgfCAzIC0tLQ0KPj4gICBpbmNsdWRlL2xpbnV4L210ZC9vbmVuYW5kLmggICAgICAgICAg
ICAgfCAzICsrKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvbmFuZC9vbmVuYW5kL29u
ZW5hbmRfYmFzZS5jIGIvZHJpdmVycy9tdGQvbmFuZC9vbmVuYW5kL29uZW5hbmRfYmFzZS5jDQo+
PiBpbmRleCA0Y2E0YjE5NGU3ZDcuLmY0MWQ3NjI0ODU1MCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2Jhc2UuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQv
bmFuZC9vbmVuYW5kL29uZW5hbmRfYmFzZS5jDQo+PiBAQCAtMjQ1OCw3ICsyNDU4LDcgQEAgc3Rh
dGljIGludCBvbmVuYW5kX2RlZmF1bHRfYmxvY2tfbWFya2JhZChzdHJ1Y3QgbXRkX2luZm8gKm10
ZCwgbG9mZl90IG9mcykNCj4+ICAgICAgICAgICAgICAgICAgIGJibS0+YmJ0W2Jsb2NrID4+IDJd
IHw9IDB4MDEgPDwgKChibG9jayAmIDB4MDMpIDw8IDEpOw0KPj4gICANCj4+ICAgICAgICAgICAv
KiBXZSB3cml0ZSB0d28gYnl0ZXMsIHNvIHdlIGRvbid0IGhhdmUgdG8gbWVzcyB3aXRoIDE2LWJp
dCBhY2Nlc3MgKi8NCj4+IC0gICAgICAgIG9mcyArPSBtdGQtPm9vYnNpemUgKyAoYmJtLT5iYWRi
bG9ja3BvcyAmIH4weDAxKTsNCj4+ICsgICAgICAgIG9mcyArPSBtdGQtPm9vYnNpemUgKyAodGhp
cy0+YmFkYmxvY2twb3MgJiB+MHgwMSk7DQo+PiAgIAkvKiBGSVhNRSA6IFdoYXQgdG8gZG8gd2hl
biBtYXJraW5nIFNMQyBibG9jayBpbiBwYXJ0aXRpb24NCj4+ICAgCSAqIAkgICB3aXRoIE1MQyBl
cmFzZXNpemU/IEZvciBub3csIGl0IGlzIG5vdCBhZHZpc2FibGUgdG8NCj4+ICAgCSAqCSAgIGNy
ZWF0ZSBwYXJ0aXRpb25zIGNvbnRhaW5pbmcgYm90aCBTTEMgYW5kIE1MQyByZWdpb25zLg0KPj4g
QEAgLTM5NjcsNiArMzk2Nyw5IEBAIGludCBvbmVuYW5kX3NjYW4oc3RydWN0IG10ZF9pbmZvICpt
dGQsIGludCBtYXhjaGlwcykNCj4+ICAgCWlmICghKHRoaXMtPm9wdGlvbnMgJiBPTkVOQU5EX1NL
SVBfSU5JVElBTF9VTkxPQ0tJTkcpKQ0KPj4gICAJCXRoaXMtPnVubG9ja19hbGwobXRkKTsNCj4+
ICAgDQo+PiArCS8qIFNldCB0aGUgYmFkIGJsb2NrIG1hcmtlciBwb3NpdGlvbiAqLw0KPj4gKwl0
aGlzLT5iYWRibG9ja3BvcyA9IE9ORU5BTkRfQkFEQkxPQ0tfUE9TOw0KPj4gKw0KPj4gICAJcmV0
ID0gdGhpcy0+c2Nhbl9iYnQobXRkKTsNCj4+ICAgCWlmICgoIUZMRVhPTkVOQU5EKHRoaXMpKSB8
fCByZXQpDQo+PiAgIAkJcmV0dXJuIHJldDsNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9u
YW5kL29uZW5hbmQvb25lbmFuZF9iYnQuYyBiL2RyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9vbmVu
YW5kX2JidC5jDQo+PiBpbmRleCBkZGUyMDQ4NzkzN2QuLjU3YzMxYzgxYmUxOCAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2JidC5jDQo+PiArKysgYi9k
cml2ZXJzL210ZC9uYW5kL29uZW5hbmQvb25lbmFuZF9iYnQuYw0KPj4gQEAgLTE5MCw5ICsxOTAs
NiBAQCBzdGF0aWMgaW50IG9uZW5hbmRfc2Nhbl9iYnQoc3RydWN0IG10ZF9pbmZvICptdGQsIHN0
cnVjdCBuYW5kX2JidF9kZXNjciAqYmQpDQo+PiAgIAlpZiAoIWJibS0+YmJ0KQ0KPj4gICAJCXJl
dHVybiAtRU5PTUVNOw0KPj4gICANCj4+IC0JLyogU2V0IHRoZSBiYWQgYmxvY2sgcG9zaXRpb24g
Ki8NCj4+IC0JYmJtLT5iYWRibG9ja3BvcyA9IE9ORU5BTkRfQkFEQkxPQ0tfUE9TOw0KPj4gLQ0K
Pj4gICAJLyogU2V0IGVyYXNlIHNoaWZ0ICovDQo+PiAgIAliYm0tPmJidF9lcmFzZV9zaGlmdCA9
IHRoaXMtPmVyYXNlX3NoaWZ0Ow0KPj4gICANCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L210ZC9vbmVuYW5kLmggYi9pbmNsdWRlL2xpbnV4L210ZC9vbmVuYW5kLmgNCj4+IGluZGV4IDBh
YWE5OGIyMTlhNC4uZTAzYWVhN2Y3ZTYxIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9t
dGQvb25lbmFuZC5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L210ZC9vbmVuYW5kLmgNCj4+IEBA
IC05NCw2ICs5NCw3IEBAIHN0cnVjdCBvbmVuYW5kX2NoaXAgew0KPj4gICAJdW5zaWduZWQgaW50
CQl0ZWNobm9sb2d5Ow0KPj4gICAJdW5zaWduZWQgaW50CQlkZW5zaXR5X21hc2s7DQo+PiAgIAl1
bnNpZ25lZCBpbnQJCW9wdGlvbnM7DQo+PiArCWludAkJCWJhZGJsb2NrcG9zOw0KPiANCj4gQW55
IHJlYXNvbiBub3QgdG8gdW5zaWduIHRoaXMgZmllbGQ/DQoNCkl0IHdhcyBzaWduZWQgc28gZmFy
LCBidXQgeW91J3JlIHJpZ2h0IHRoYXQgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byANCnVuc2lnbiBp
dC4NCg0KPiANCj4+ICAgDQo+PiAgIAl1bnNpZ25lZCBpbnQJCWVyYXNlX3NoaWZ0Ow0KPj4gICAJ
dW5zaWduZWQgaW50CQlwYWdlX3NoaWZ0Ow0KPj4gQEAgLTE4OCw2ICsxODksOCBAQCBzdHJ1Y3Qg
b25lbmFuZF9jaGlwIHsNCj4+ICAgLyogQ2hlY2sgYnl0ZSBhY2Nlc3MgaW4gT25lTkFORCAqLw0K
Pj4gICAjZGVmaW5lIE9ORU5BTkRfQ0hFQ0tfQllURV9BQ0NFU1MoYWRkcikJCShhZGRyICYgMHgx
KQ0KPj4gICANCj4+ICsjZGVmaW5lIE9ORU5BTkRfQkFEQkxPQ0tfUE9TCQkwDQo+PiArDQo+PiAg
IC8qDQo+PiAgICAqIE9wdGlvbnMgYml0cw0KPj4gICAgKi8NCj4gDQo+IFRoYW5rcywNCj4gTWlx
dcOobA0KPiA=
