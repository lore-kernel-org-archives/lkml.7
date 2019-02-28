Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A187A2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 11:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731576AbfB1LuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 06:50:01 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:57271 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfB1LuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 06:50:00 -0500
X-IronPort-AV: E=Sophos;i="5.58,423,1544486400"; 
   d="scan'208";a="86583885"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     Igor Druzhinin <igor.druzhinin@citrix.com>,
        Wei Liu <wei.liu2@citrix.com>
CC:     "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH] xen-netback: fix occasional leak of grant ref mappings
 under memory pressure
Thread-Topic: [PATCH] xen-netback: fix occasional leak of grant ref mappings
 under memory pressure
Thread-Index: AQHUzwnalyGnLUhGt0OYo7x3WDkwmKX09AIQgAAHGACAABYNsP//9bsAgAAR2wA=
Date:   Thu, 28 Feb 2019 11:49:15 +0000
Message-ID: <271c9beb91a74ded8e62d1cfc540976c@AMSPEX02CL02.citrite.net>
References: <1551319382-32595-1-git-send-email-igor.druzhinin@citrix.com>
 <8424fba34a1f43908a6dae3a9308863b@AMSPEX02CL02.citrite.net>
 <20190228110136.somjads2f5ivqhju@zion.uk.xensource.com>
 <e5ef3c0291854b67841b6c532f7651b9@AMSPEX02CL02.citrite.net>
 <447cd231-3ea4-e56d-29b0-6528804c9e9a@citrix.com>
In-Reply-To: <447cd231-3ea4-e56d-29b0-6528804c9e9a@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJZ29yIERydXpoaW5pbiBbbWFp
bHRvOmlnb3IuZHJ1emhpbmluQGNpdHJpeC5jb21dDQo+IFNlbnQ6IDI4IEZlYnJ1YXJ5IDIwMTkg
MTE6NDQNCj4gVG86IFBhdWwgRHVycmFudCA8UGF1bC5EdXJyYW50QGNpdHJpeC5jb20+OyBXZWkg
TGl1IDx3ZWkubGl1MkBjaXRyaXguY29tPg0KPiBDYzogeGVuLWRldmVsQGxpc3RzLnhlbnByb2pl
Y3Qub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHhlbi1u
ZXRiYWNrOiBmaXggb2NjYXNpb25hbCBsZWFrIG9mIGdyYW50IHJlZiBtYXBwaW5ncyB1bmRlciBt
ZW1vcnkgcHJlc3N1cmUNCj4gDQo+IE9uIDI4LzAyLzIwMTkgMTE6MjEsIFBhdWwgRHVycmFudCB3
cm90ZToNCj4gPj4+IEBAIC0xMTUzLDYgKzExNTIsMTAgQEAgc3RhdGljIGludCB4ZW52aWZfdHhf
c3VibWl0KHN0cnVjdCB4ZW52aWZfcXVldWUgKnF1ZXVlKQ0KPiA+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBrZnJlZV9za2Ioc2tiKTsNCj4gPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICB9
DQo+ID4+PiArDQo+ID4+PiArICAgICAgICAgICAgICAgICAgICAgICAvKiBDb3BpZWQgYWxsIHRo
ZSBiaXRzIGZyb20gdGhlIGZyYWcgbGlzdC4gKi8NCj4gPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHNrYl9mcmFnX2xpc3RfaW5pdChza2IpOw0KPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAg
ICAga2ZyZWUobnNrYik7DQo+ID4+DQo+ID4+IEkgdGhpbmsgeW91IHdhbnQga2ZyZWVfc2tiIGhl
cmU/DQo+ID4NCj4gPiBOby4gbnNrYiBpcyB0aGUgZnJhZyBsaXN0Li4uIGl0IGlzIHVubGlua2Vk
IGZyb20gc2tiIGJ5IHRoZSBjYWxsIHRvIHNrYl9mcmFnX2xpc3RfaW5pdCgpIGFuZCB0aGVuIGl0
DQo+IGNhbiBiZSBmcmVlZCBvbiBpdHMgb3duLiBUaGUgc2tiIGlzIHdoYXQgd2UgbmVlZCB0byBy
ZXRhaW4sIGJlY2F1c2UgdGhhdCBub3cgY29udGFpbnMgYWxsIHRoZSBkYXRhLg0KPiA+DQo+IA0K
PiBBcmUgeW91IHNheWluZyBwcmV2aW91cyBjb2RlIGluIHhlbnZpZl9oYW5kbGVfZnJhZ19saXN0
KCkgaW5jb3JyZWN0bHkNCj4gY2FsbGVkIGtmcmVlX3NrYigpPw0KDQpObywgaXQgY29ycmVjdGx5
IGNhbGxlZCBrZnJlZV9za2IoKSBvbiBuc2tiIGluIHRoZSBzdWNjZXNzIGNhc2UuIFdoYXQgV2Vp
IGFuZCBteXNlbGYgd291bGQgcHJlZmVyIGlzIHRoYXQgd2UgaGF2ZSBhIHNpbmdsZSBwbGFjZSB0
aGF0IHRoZSBmcmFnIGxpc3QgaXMgZnJlZWQgaW4gYm90aCB0aGUgc3VjY2VzcyBhbmQgZXJyb3Ig
Y2FzZXMuDQoNCiAgUGF1bA0KDQo+IA0KPiBJZ29yDQo=
