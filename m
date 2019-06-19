Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F370DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0957205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfFSOCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:02:19 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:42462 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfFSOCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:02:19 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id AC1FB67A5A7;
        Wed, 19 Jun 2019 16:02:15 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 19 Jun
 2019 16:02:15 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 19 Jun 2019 16:02:15 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Peter Pan" <peterpandong@micron.com>
Subject: Re: [PATCH] mtd: spinand: fix error read return value
Thread-Topic: [PATCH] mtd: spinand: fix error read return value
Thread-Index: AQHVJqDuYWC929vPOUKAUCynvqWA3aai2+yAgAAEfAA=
Date:   Wed, 19 Jun 2019 14:02:14 +0000
Message-ID: <99279437-54a6-c81d-aad2-231009f18cfc@kontron.de>
References: <1560950005-8868-1-git-send-email-liaoweixiong@allwinnertech.com>
 <20190619154611.3bfc007b@collabora.com>
In-Reply-To: <20190619154611.3bfc007b@collabora.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <15DD44F8384FA94BAC65908A2BFF103D@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: AC1FB67A5A7.A231B
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, boris.brezillon@collabora.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        frieder.schrempf@exceet.de, gch981213@gmail.com,
        liaoweixiong@allwinnertech.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, peron.clem@gmail.com,
        peterpandong@micron.com, richard@nod.at, vigneshr@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkuMDYuMTkgMTU6NDYsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gSGkgbGlhb3dlaXhp
b25nLA0KPiANCj4gT24gV2VkLCAxOSBKdW4gMjAxOSAyMToxMzoyNCArMDgwMA0KPiBsaWFvd2Vp
eGlvbmcgPGxpYW93ZWl4aW9uZ0BhbGx3aW5uZXJ0ZWNoLmNvbT4gd3JvdGU6DQo+IA0KPj4gSW4g
ZnVuY3Rpb24gc3BpbmFuZF9tdGRfcmVhZCwgaWYgdGhlIGxhc3QgcGFnZSB0byByZWFkIG9jY3Vy
cyBiaXRmbGlwLA0KPj4gdGhpcyBmdW5jdGlvbiB3aWxsIHJldHVybiBlcnJvciB2YWx1ZSBiZWNh
dXNlIHZlcmlhYmxlIHJldCBub3QgZXF1YWwgdG8gMC4NCj4gDQo+IEFjdHVhbGx5LCB0aGF0J3Mg
ZXhhY3RseSB3aGF0IHRoZSBNVEQgY29yZSBleHBlY3RzIChzZWUgWzFdKSwgc28geW91J3JlDQo+
IHRoZSBvbmUgaW50cm9kdWNpbmcgYSByZWdyZXNzaW9uIGhlcmUuDQoNClRvIG1lIGl0IGxvb2tz
IGxpa2UgdGhlIHBhdGNoIGRlc2NyaXB0aW9uIGlzIHNvbWV3aGF0IGluY29ycmVjdCwgYnV0IHRo
ZSANCmZpeCBpdHNlbGYgbG9va3Mgb2theSwgdW5sZXNzIEknbSBnZXR0aW5nIGl0IHdyb25nLg0K
DQpJbiBjYXNlIG9mIHRoZSBsYXN0IHBhZ2UgY29udGFpbmluZyBiaXRmbGlwcyAocmV0ID4gMCks
IA0Kc3BpbmFuZF9tdGRfcmVhZCgpIHdpbGwgcmV0dXJuIHRoYXQgbnVtYmVyIG9mIGJpdGZsaXBz
IGZvciB0aGUgbGFzdCANCnBhZ2UuIEJ1dCB0byBtZSBpdCBsb29rcyBsaWtlIGl0IHNob3VsZCBp
bnN0ZWFkIHJldHVybiBtYXhfYml0ZmxpcHMgbGlrZSANCml0IGRvZXMgd2hlbiB0aGUgbGFzdCBw
YWdlIHJlYWQgcmV0dXJucyB3aXRoIDAuDQoNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBsaWFvd2Vp
eGlvbmcgPGxpYW93ZWl4aW9uZ0BhbGx3aW5uZXJ0ZWNoLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2
ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMgfCAyICstDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210
ZC9uYW5kL3NwaS9jb3JlLmMgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMNCj4+IGluZGV4
IDU1NmJmZGIuLjZiOTM4OGQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9j
b3JlLmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYw0KPj4gQEAgLTUxMSwx
MiArNTExLDEyIEBAIHN0YXRpYyBpbnQgc3BpbmFuZF9tdGRfcmVhZChzdHJ1Y3QgbXRkX2luZm8g
Km10ZCwgbG9mZl90IGZyb20sDQo+PiAgIAkJaWYgKHJldCA9PSAtRUJBRE1TRykgew0KPj4gICAJ
CQllY2NfZmFpbGVkID0gdHJ1ZTsNCj4+ICAgCQkJbXRkLT5lY2Nfc3RhdHMuZmFpbGVkKys7DQo+
PiAtCQkJcmV0ID0gMDsNCj4+ICAgCQl9IGVsc2Ugew0KPj4gICAJCQltdGQtPmVjY19zdGF0cy5j
b3JyZWN0ZWQgKz0gcmV0Ow0KPj4gICAJCQltYXhfYml0ZmxpcHMgPSBtYXhfdCh1bnNpZ25lZCBp
bnQsIG1heF9iaXRmbGlwcywgcmV0KTsNCj4+ICAgCQl9DQo+PiAgIA0KPj4gKwkJcmV0ID0gMDsN
Cj4+ICAgCQlvcHMtPnJldGxlbiArPSBpdGVyLnJlcS5kYXRhbGVuOw0KPj4gICAJCW9wcy0+b29i
cmV0bGVuICs9IGl0ZXIucmVxLm9vYmxlbjsNCj4+ICAgCX0NCj4gDQo+IFsxXWh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvZHJpdmVycy9tdGQvbXRkY29yZS5j
I0wxMjA5DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0DQo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbXRkLw0KPiA=
