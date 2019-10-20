Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AEFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 20:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5449218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfJTUXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 16:23:37 -0400
Received: from mail-oln040092070083.outbound.protection.outlook.com ([40.92.70.83]:9715
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfJTUXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 16:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htGaKUJ8oab7F3a+7xcIN9GpepPzM0l++VT6AoejAz8+mghDRPR/eOrdn5bmFS1WiX4lN8sBctzDRAK2aFWN8NB7gKr/bbOaZ4o8aqcf9TSAcxedDy6Ugi8S2Fm28znRmzI7aEQLQKMpm5dL7tfBVO+ehQLax9CPoZeFfv1KaFYPR5znkQYnfV1EdNLGYePQWefir5c1F9SWTvBXMNy5ywpsLSrhuPVOoGD2X+ijRLXtY9vKetGBhEGb+B37XSpOfqPvyFDNIq2SoHr0S/nfMvDI5wbeUmsw+yj1NgUzg8SM8s5pxbIZu5gfLPSriaIyAQjujrNI473oN94lS86lMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lz+TMnmUGMarum9ItTfxzrHokevgysuXa1RM3jnIiM=;
 b=jjFUZcxeYXSzeC7nZzccS0axYyn91leflEWw2nTgWb5fwV+hVMpQWSrFkzILyE+n1WPqPII+eOQjYE5jG97IYZtg2z89/0NM/A2UrzJZOp56ZiyPh1iNW7pSP62ebLGzR1wwLqA8ng/0TsDmIpH7J39e2COn0VD06PlwgWZerrfcT4pIE2Xkhgq8yqnJMKWDTkwzz7UZ46BqVKZJQkqPTrxdgrsN1IxWoPvB3dTuJjULOh2Kf8kB4WUW797jCMzNIeiSHe5qGf5/zsyNuKBhIeYdR9ueYO1NjCqQJS4+aihU40LM59WqUm1IaH1vaGx5aHdO3t3xfjMPMinl80IQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (10.152.16.55) by AM5EUR03HT195.eop-EUR03.prod.protection.outlook.com
 (10.152.16.192) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2305.15; Sun, 20 Oct
 2019 20:23:33 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com (10.152.16.55) by
 AM5EUR03FT045.mail.protection.outlook.com (10.152.17.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2305.15 via Frontend Transport; Sun, 20 Oct 2019 20:23:33 +0000
Received: from AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247]) by AM0PR0502MB3668.eurprd05.prod.outlook.com
 ([fe80::b1e4:568d:bbc:8247%6]) with mapi id 15.20.2347.028; Sun, 20 Oct 2019
 20:23:33 +0000
From:   Anatol Belski <weltling@outlook.de>
To:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
Thread-Topic: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
Thread-Index: AQHVh3kRz65p1edy+E6pOH2HIjxbDqdj6jkAgAADSgCAAAwEAA==
Date:   Sun, 20 Oct 2019 20:23:33 +0000
Message-ID: <AM0PR0502MB366879157E871B1E757E491ABA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
References: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
         <AM0PR0502MB3668C7B77C05918FF96EF10DBA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
         <0f7518736a2508371fecf91db6e28d50494360b3.camel@perches.com>
In-Reply-To: <0f7518736a2508371fecf91db6e28d50494360b3.camel@perches.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-clientproxiedby: AM4PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:205:1::33) To AM0PR0502MB3668.eurprd05.prod.outlook.com
 (2603:10a6:208:19::11)
x-incomingtopheadermarker: OriginalChecksum:C212CD6C0F6523458FB01F68D871A91273E55A615686BA5AADF67B8AECC802D6;UpperCasedChecksum:96BA9D3DA80B151A7FA26BD0FFF820D7D156ED90A87AE9C9F928C0FD36C99873;SizeAsReceived:8069;Count:52
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [miQCISB8R8n599jnoH6IKQ/56hh/ql6xiuk8wGsnu8vfWJexl5R6TWF+IVndJXO1UaI7cSwzack=]
x-microsoft-original-message-id: <03c051c042a88fc291ea9c39048080b55e7bd1a9.camel@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 52
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: AM5EUR03HT195:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: psYP4rq8smeDtCtQOdz9Y4+JRMIjmYIJDEvqkqCCO6Eca0F4SopnfY8UXudAfBMEx2w5GXYXUsux5wK8t/ulCz1pm6YdOyVUINcp0WLKQzH4qEdICk8iQTUPFE597/AbRG35NPCMa6Rld+p6s/WJMc85kZSIWGTOo9oW7tYER7gzB88IHaMW7HJfHPDQIUtt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <888600FBB359F84D903F3645E3F38BF9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: abd39370-176c-4102-b5dd-08d7559b6072
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2019 20:23:33.2061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTIwIGF0IDEyOjQwIC0wNzAwLCBKb2UgUGVyY2hlcyB3cm90ZToNCj4g
T24gU3VuLCAyMDE5LTEwLTIwIGF0IDE5OjI4ICswMDAwLCBBbmF0b2wgQmVsc2tpIHdyb3RlOg0K
PiA+IEhpLA0KPiANCj4gSGVsbG8uDQo+IA0KPiA+IE9uIFN1biwgMjAxOS0xMC0yMCBhdCAxMjow
MiAtMDcwMCwgSm9lIFBlcmNoZXMgd3JvdGU6DQo+ID4gPiBUaGVyZSdzIGFuIGFyZ3VtZW50IGlu
Y29uc2lzdGVuY3kgYmV0d2VlbiB0aGVzZSA0IGZ1bmN0aW9ucw0KPiA+ID4gaW4gaW5jbHVkZS9s
aW51eC9ieXRlb3JkZXIvZ2VuZXJpYy5oDQo+ID4gPiANCj4gPiA+IEl0J2QgYmUgbW9yZSBhIGNv
bnNpc3RlbnQgQVBJIHdpdGggb25lIGZvcm0gYW5kIG5vdCB0d28uDQo+ID4gPiANCj4gPiA+ICAg
IHN0YXRpYyBpbmxpbmUgdm9pZCBsZTMyX3RvX2NwdV9hcnJheSh1MzIgKmJ1ZiwgdW5zaWduZWQg
aW50DQo+ID4gPiB3b3JkcykNCj4gPiA+ICAgIHsNCj4gPiA+ICAgIAl3aGlsZSAod29yZHMtLSkg
ew0KPiA+ID4gICAgCQlfX2xlMzJfdG9fY3B1cyhidWYpOw0KPiA+ID4gICAgCQlidWYrKzsNCj4g
PiA+ICAgIAl9DQo+ID4gPiAgICB9DQo+ID4gPiANCj4gPiA+ICAgIHN0YXRpYyBpbmxpbmUgdm9p
ZCBjcHVfdG9fbGUzMl9hcnJheSh1MzIgKmJ1ZiwgdW5zaWduZWQgaW50DQo+ID4gPiB3b3JkcykN
Cj4gPiA+ICAgIHsNCj4gPiA+ICAgIAl3aGlsZSAod29yZHMtLSkgew0KPiA+ID4gICAgCQlfX2Nw
dV90b19sZTMycyhidWYpOw0KPiA+ID4gICAgCQlidWYrKzsNCj4gPiA+ICAgIAl9DQo+ID4gPiAg
ICB9DQo+ID4gPiANCj4gPiA+IHZzDQo+ID4gPiANCj4gPiA+ICAgIHN0YXRpYyBpbmxpbmUgdm9p
ZCBjcHVfdG9fYmUzMl9hcnJheShfX2JlMzIgKmRzdCwgY29uc3QgdTMyDQo+ID4gPiAqc3JjLA0K
PiA+ID4gc2l6ZV90IGxlbikNCj4gPiA+ICAgIHsNCj4gPiA+ICAgIAlpbnQgaTsNCj4gPiA+IA0K
PiA+ID4gICAgCWZvciAoaSA9IDA7IGkgPCBsZW47IGkrKykNCj4gPiA+ICAgIAkJZHN0W2ldID0g
Y3B1X3RvX2JlMzIoc3JjW2ldKTsNCj4gPiA+ICAgIH0NCj4gPiA+IA0KPiA+ID4gICAgc3RhdGlj
IGlubGluZSB2b2lkIGJlMzJfdG9fY3B1X2FycmF5KHUzMiAqZHN0LCBjb25zdCBfX2JlMzINCj4g
PiA+ICpzcmMsDQo+ID4gPiBzaXplX3QgbGVuKQ0KPiA+ID4gICAgew0KPiA+ID4gICAgCWludCBp
Ow0KPiA+ID4gDQo+ID4gPiAgICAJZm9yIChpID0gMDsgaSA8IGxlbjsgaSsrKQ0KPiA+ID4gICAg
CQlkc3RbaV0gPSBiZTMyX3RvX2NwdShzcmNbaV0pOw0KPiA+ID4gICAgfQ0KPiA+ID4gDQo+ID4g
PiANCj4gPiANCj4gPiBzaXplX3QgaXMgdGhlIHJpZ2h0IGNob2ljZSBmb3IgdGhpcywgYXMgaXQn
bGwgZ2VuZXJhdGUgbW9yZSBjb3JyZWN0DQo+ID4gYmluYXJ5IGRlcGVuZGluZyBvbiAzMi82NCBi
aXQuIEkndmUgc2VudCBhIHBhdGNoIGluDQo+ID4gJ2luY2x1ZGUvbGludXgvYnl0ZW9yZGVyL2dl
bmVyaWMuaDogZml4IHNpZ25lZC91bnNpZ25lZCB3YXJuaW5ncycNCj4gPiBiZWZvcmUsIGJ1dCBv
bmx5IHRvdWNoZWQgdGhlIHBsYWNlIHdoZXJlIGkndmUgc2VlbiB3YXJuaW5ncy4gTXkNCj4gPiB2
ZXJ5DQo+ID4gYmV0IGlzLCB0aGF0IGNoYW5naW5nIGJldHdlZW4gc2l6ZV90L3Vuc2lnbmVkLCB3
aGlsZSBpdCB3b3VsZCBiZQ0KPiA+IGNvbnNpc3RlbnQsIHdvdWxkbid0IGNoYW5nZSB0aGUgZnVu
Y3Rpb25hbGl0eS4gSXQnZCBwcm9iYWJseSBtYWtlDQo+ID4gc2Vuc2UNCj4gPiB0byBleHRlbmQg
dGhlIGFmb3JlbWVudGlvbmVkIHBhdGNoIHRvIG1vdmUgdW5zaWduZWQgLT4gc2l6ZV90Lg0KPiAN
Cj4gVHJ1ZSwgYnV0IG15IHBvaW50IHdhcyB0aGUgbGUgdmVyc2lvbnMgaGF2ZSAyIGFyZ3VtZW50
cyBhbmQNCj4gY29udmVydCB0aGUgYnVmIGlucHV0LCBhbmQgdGhlIGJlIHZlcnNpb25zIGhhdmUg
MyBhcmd1bWVudHMNCj4gYW5kIGNvbnZlcnQgc3JjIHRvIGRzdC4NCg0KVGhhbmtzIGZvciBjaGVj
a2luZy4gWWVzLCB0aGF0J3MgYW5vdGhlciBwb2ludCBvZiB0aGUgaW5jb25zaXN0ZW5jeS4gSQ0K
Y291bGQgaW1hZ2luZSBmaXhpbmcgaXQgYnkgYWRhcHRpbmcgYWxsIHRoZSBzaWduYXR1cmVzIHRv
IGJlDQoNCg0Kc3RhdGljIGlubGluZSB2b2lkIF9jcHVfdG9fbGUzMl9hcnJheShfX2xlMzIgKmRz
dCwgY29uc3QgdTMyICpzcmMsDQpzaXplX3QgbGVuKQ0Kc3RhdGljIGlubGluZSB2b2lkIF9sZTMy
X3RvX2NwdV9hcnJheSh1MzIgKmRzdCwgY29uc3QgX19sZTMyICpzcmMsDQpzaXplX3QgbGVuKQ0K
c3RhdGljIGlubGluZSB2b2lkIGNwdV90b19iZTMyX2FycmF5KF9fYmUzMiAqZHN0LCBjb25zdCB1
MzIgKnNyYywNCnNpemVfdCBsZW4pDQpzdGF0aWMgaW5saW5lIHZvaWQgYmUzMl90b19jcHVfYXJy
YXkodTMyICpkc3QsIGNvbnN0IF9fYmUzMiAqc3JjLA0Kc2l6ZV90IGxlbikNCg0KYW5kIGRvIHRo
ZSBuZWNlc3NhcnkgaW1wbGVtZW50YXRpb24gY2hhbmdlIGluIHRoZSBsZSB2YXJpYW50cywgcGx1
cw0KaW50cm9kdWNlIHNvbWUgbWFjcm9zIHRvIGVuc3VyZSB0aGUgYmFja3dhcmQgY29tcGF0aWJp
bGl0eS4NCg0KI2RlZmluZSBsZTMyX3RvX2NwdV9hcnJheShkc3QsIGxlbikgX2NwdV90b19sZTMy
X2FycmF5KGRzdCwgZHN0LCBsZW4pDQojZGVmaW5lIGNwdV90b19sZTMyX2FycmF5KGRzdCwgbGVu
KSBfbGUzMl90b19jcHVfYXJyYXkoZHN0LCBkc3QsIGxlbikNCg0KQnV0IGl0IGlzIGEgYmFkIHNp
dHVhdGlvbiBmb3IgdGhlIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkgaW4gYW55IGNhc2UsDQphcyB0
aGUgbmV3IEFQSSB3b3VsZCBoYXZlIHRvIGJlIG5hbWVkIHNvbWVob3cuIFRoYXQgd291bGQgYmUg
YmFkIGZvcg0KdGhlIGJhY2twb3J0LiBJZiBicmVhY2hpbmcgdGhpcyBpcyBvayBmb3IgbWFzdGVy
LCB0aGVuIHRoZSBmaXggd291bGQgYmUNCmFzIGVhc3kgYXMgY2hhbmdpbmcgdGhlIHNpZ25hdHVy
ZXMgYW5kIGFkYXB0aW5nIHRoZSBpbXBsZW1lbnRhdGlvbi4NCg0KDQpUaGFua3MNCg0KQW5hdG9s
DQoNCg0K
