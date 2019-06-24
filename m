Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE892C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5DE2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfFXHhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:37:50 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:44648 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfFXHht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:37:49 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 55C2A67A866;
        Mon, 24 Jun 2019 09:37:45 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 24 Jun
 2019 09:37:44 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 24 Jun 2019 09:37:44 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Peter Pan <peterpandong@micron.com>,
        "Jeff Kletsky" <git-commits@allycomm.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spinand: read return badly if the last page has
 bitflips
Thread-Topic: [PATCH v2] mtd: spinand: read return badly if the last page has
 bitflips
Thread-Index: AQHVJwOfUanKNwqMXUOnQCnAkBatBqaqT90A
Date:   Mon, 24 Jun 2019 07:37:44 +0000
Message-ID: <d406a968-a489-f457-2bde-1912618879fa@kontron.de>
References: <1560992416-5753-1-git-send-email-liaoweixiong@allwinnertech.com>
In-Reply-To: <1560992416-5753-1-git-send-email-liaoweixiong@allwinnertech.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <44B2B8BBC59D1345937FB8A85C0FB59B@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 55C2A67A866.AE508
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, frieder.schrempf@exceet.de,
        git-commits@allycomm.com, liaoweixiong@allwinnertech.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com,
        peterpandong@micron.com, richard@nod.at, vigneshr@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAuMDYuMTkgMDM6MDAsIGxpYW93ZWl4aW9uZyB3cm90ZToNCj4gSW4gY2FzZSBvZiB0aGUg
bGFzdCBwYWdlIGNvbnRhaW5pbmcgYml0ZmxpcHMgKHJldCA+IDApLA0KPiBzcGluYW5kX210ZF9y
ZWFkKCkgd2lsbCByZXR1cm4gdGhhdCBudW1iZXIgb2YgYml0ZmxpcHMgZm9yIHRoZSBsYXN0DQo+
IHBhZ2UuIEJ1dCB0byBtZSBpdCBsb29rcyBsaWtlIGl0IHNob3VsZCBpbnN0ZWFkIHJldHVybiBt
YXhfYml0ZmxpcHMgbGlrZQ0KPiBpdCBkb2VzIHdoZW4gdGhlIGxhc3QgcGFnZSByZWFkIHJldHVy
bnMgd2l0aCAwLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogbGlhb3dlaXhpb25nIDxsaWFvd2VpeGlv
bmdAYWxsd2lubmVydGVjaC5jb20+DQoNClJldmlld2VkLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxm
cmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+DQoNClRoaXMgc2hvdWxkIHByb2JhYmx5IGJlIHJl
c2VudCB3aXRoIHRoZSBmb2xsb3dpbmcgdGFnczoNCg0KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcNCkZpeGVzOiA3NTI5ZGY0NjUyNDggKCJtdGQ6IG5hbmQ6IEFkZCBjb3JlIGluZnJhc3RydWN0
dXJlIHRvIHN1cHBvcnQgU1BJIA0KTkFORHMiKQ0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvbXRkL25h
bmQvc3BpL2NvcmUuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9j
b3JlLmMgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMNCj4gaW5kZXggNTU2YmZkYi4uNmI5
Mzg4ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9zcGkvY29yZS5jDQo+ICsrKyBi
L2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYw0KPiBAQCAtNTExLDEyICs1MTEsMTIgQEAgc3Rh
dGljIGludCBzcGluYW5kX210ZF9yZWFkKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3QgZnJv
bSwNCj4gICAJCWlmIChyZXQgPT0gLUVCQURNU0cpIHsNCj4gICAJCQllY2NfZmFpbGVkID0gdHJ1
ZTsNCj4gICAJCQltdGQtPmVjY19zdGF0cy5mYWlsZWQrKzsNCj4gLQkJCXJldCA9IDA7DQo+ICAg
CQl9IGVsc2Ugew0KPiAgIAkJCW10ZC0+ZWNjX3N0YXRzLmNvcnJlY3RlZCArPSByZXQ7DQo+ICAg
CQkJbWF4X2JpdGZsaXBzID0gbWF4X3QodW5zaWduZWQgaW50LCBtYXhfYml0ZmxpcHMsIHJldCk7
DQo+ICAgCQl9DQo+ICAgDQo+ICsJCXJldCA9IDA7DQo+ICAgCQlvcHMtPnJldGxlbiArPSBpdGVy
LnJlcS5kYXRhbGVuOw0KPiAgIAkJb3BzLT5vb2JyZXRsZW4gKz0gaXRlci5yZXEub29ibGVuOw0K
PiAgIAl9DQo+IA==
