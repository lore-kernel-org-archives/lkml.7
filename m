Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE80BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C492082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ZtbvpoNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbfDJPCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:02:00 -0400
Received: from mail-eopbgr790074.outbound.protection.outlook.com ([40.107.79.74]:23958
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732968AbfDJPCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQ8Kk2N+TL4xKSWoAAfCVirjmuD7R7tCVz4/9fUB+bM=;
 b=ZtbvpoNs5ohc8OW2NNUtUzn+24XMKipsS+XVB1vPnCJsYnjK6FhO3XgAMw1xrM//4cf4m7IdWf5BKlUD0357yq+aY/7p6lMDYn76ZfKmSHyIwA3VLKxg6X1xaChGzrRpEn2Uxoj+QW3MR1KhJ7+MY/KqURuFE5wvXwOeo37QuT4=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6527.namprd05.prod.outlook.com (20.178.246.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.7; Wed, 10 Apr 2019 15:01:14 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::91e:292d:e304:78ad%7]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 15:01:14 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Deepak Singh Rawat <drawat@vmware.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: revert dma direct internals abuse
Thread-Topic: revert dma direct internals abuse
Thread-Index: AQHU7fmi7IV/x30l7UexE5gP02MWCKYymy+AgAD+MwCAADQ1gIAAB6sAgAAMwgCAABMAAIAAIUkAgADfTYCAAIrrAA==
Date:   Wed, 10 Apr 2019 15:01:14 +0000
Message-ID: <0c897b24b234f8d42ef597dbe31fa8293519a4b2.camel@vmware.com>
References: <20190408105525.5493-1-hch@lst.de>
         <7d5f35da4a6b58639519f0764c7edbfe4dd1ba02.camel@vmware.com>
         <20190409095740.GE6827@lst.de>
         <5f0837ffc135560c764c38849eead40269cebb48.camel@vmware.com>
         <20190409133157.GA10876@lst.de>
         <466e658c73607fca5112d718972e87c0b78653ad.camel@vmware.com>
         <20190409152538.GA12816@lst.de>
         <da06614b308500392c179651ef9c6fb835ee4045.camel@vmware.com>
         <20190410064359.GC5543@lst.de>
In-Reply-To: <20190410064359.GC5543@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2942fa3b-3597-4de4-c523-08d6bdc56063
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:MN2PR05MB6527;
x-ms-traffictypediagnostic: MN2PR05MB6527:
x-microsoft-antispam-prvs: <MN2PR05MB65272E3B60EBE20B20AFA8F7A12E0@MN2PR05MB6527.namprd05.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39860400002)(366004)(376002)(199004)(189003)(8936002)(316002)(97736004)(486006)(14454004)(6486002)(4326008)(36756003)(6512007)(86362001)(99286004)(2616005)(3846002)(6116002)(2501003)(6246003)(305945005)(5660300002)(7736002)(2906002)(93886005)(53936002)(6916009)(54906003)(229853002)(446003)(76176011)(26005)(68736007)(105586002)(81156014)(118296001)(102836004)(5640700003)(81166006)(71200400001)(6506007)(66066001)(476003)(71190400001)(6436002)(186003)(256004)(478600001)(1730700003)(2351001)(5024004)(14444005)(11346002)(25786009)(8676002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6527;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DOjKWTlKRhmf269CIiqftcX1gpcqKTd/SWebAGDp9ELF8WmYEspzrDNeiXZkNWw0mEVlEaIUeBwovxEVYSb9AMuPAyLQ/GprYjGWJ4WWoYvAs6knKH8u1wojvNqgTDLKVhum3marQrbl5kaXzoICraxkgOUEwle6UcKUtMZbzB41eZmoVGgD8dDPj3tNLFwOwMbyWnzm9muTSNM44SvZsfBTZf5WERTN9zm2ERDUvGJGE/Z9b2tQPKFHt1saahkGcA3aXFfw2gAbvOgQuLgTE6VP76bwu23Quk6JDfOhOMvlXj7XUkP7lYnFlBfQtJmOe0u/8lrmyKKFcVhU2PEM6dI1mitiW/ZDr2ymhjCiaWqpsv8SMPoYMZqdytJO1gBFAHZhl7NUiQ4Jyn6WEXJKUwTPtuPt09W+A3XyXR/Syqs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D2AB352DE7A2F4BB71CA19FEF5367B8@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2942fa3b-3597-4de4-c523-08d6bdc56063
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 15:01:14.1931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6527
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA0LTEwIGF0IDA4OjQzICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBUdWUsIEFwciAwOSwgMjAxOSBhdCAwNToyNDo0OFBNICswMDAwLCBUaG9tYXMgSGVsbHN0cm9t
IHdyb3RlOg0KPiA+ID4gTm90ZSB0aGF0IHRoaXMgb25seSBhZmZlY3RzIGV4dGVybmFsLCB1bnRy
dXN0ZWQgZGV2aWNlcy4gIEJ1dA0KPiA+ID4gdGhhdA0KPiA+ID4gbWF5IGluY2x1ZGUgZUdQVSwN
Cj4gPiANCj4gPiBXaGF0IGFib3V0IGRpc2NyZXRlIGdyYXBoaWNzIGNhcmRzLCBsaWtlIFJhZGVv
biBhbmQgTnZpZGlhPyBXaG8NCj4gPiBnZXRzIHRvDQo+ID4gZGV0ZXJtaW5lIHdoYXQncyB0cnVz
dGVkPw0KPiANCj4gQmFzZWQgb24gZmlybXdhcmUgdGFibGVzLiAgZGlzY3JldGUgZ3JhcGhpY3Mg
d291bGQgbm90IHF1YWxpZnkgdW5sZXNzDQo+IHRoZXkgYXJlIGF0dGFjaGVkIHRocm91Z2ggdGh1
bmRlcmJvbHQgYnJpZGdlcyBvciBleHRlcm5hbCBQQ0llIHBvcnRzLg0KPiANCj4gPiBHUFUgbGli
cmFyaWVzIHRyYWRpdGlvbmFsbHkgaGF2ZSBiZWVuIHRha2luZyBjYXJlIG9mIHRoZSBDUFUNCj4g
PiBtYXBwaW5nDQo+ID4gY2FjaGluZyBtb2RlcyBzaW5jZSB0aGUgZmlyc3QgQUdQIGRyaXZlcnMu
IEdQVSBNTVUgcHRlcyBjb21tb25seQ0KPiA+IHN1cHBvcnQgdmFyaW91cyBjYWNoaW5nIG9wdGlv
bnMgYW5kIHBhZ2VzIGFyZSBjaGFuZ2luZyBjYWNoaW5nIG1vZGUNCj4gPiBkeW5hbWljYWxseS4N
Cj4gPiBTbyBldmVuIGlmIHRoZSBETUEgbGF5ZXIgbmVlZHMgdG8gZG8gdGhlIHJlbWFwcGluZywg
Y291bGRuJ3Qgd2UgZG8NCj4gPiB0aGF0DQo+ID4gb24tZGVtYW5kIHdoZW4gbmVlZGVkIHdpdGgg
YSBzaW1wbGUgaW50ZXJmYWNlPw0KPiANCj4gVGhlIHByb2JsZW0gaXMgdGhhdCB0aGVyZSBpcyBu
byAic2ltcGxlIiBpbnRlcmZhY2UgYXMgdGhlIGRldGFpbHMNCj4gZGVwZW5kIG9uIHRoZSBhcmNo
aXRlY3R1cmUuICBXZSBoYXZlIHRoZSBmb2xsb3dpbmcgYmFzZSB2YXJpYW50cw0KPiB0byBjcmVh
dGUgY29oZXJlbnQgbWVtb3J5Og0KPiANCj4gICAxKSBkbyBub3RoaW5nIC0gdGhpcyB3b3JrcyBv
biB4ODYtbGlrZSBwbGF0Zm9ybXMgd2hlcmUgSS9PIGlzDQo+IGFsd2F5cw0KPiAgICAgIGNvaGVy
ZW50DQo+ICAgMikgdXNlIGEgc3BlY2lhbCBrZXJuZWwgc2VnbWVudCwgYWZ0ZXIgZmx1c2hpbmcg
dGhlIGNhY2hlcyBmb3IgdGhlDQo+ICAgICAgbm9ybWFsIHNlZ21lbnQsIGRvbmUgb24gcGxhdGZv
cm1zIGxpa2UgbWlwcyB0aGF0IGhhdmUgdGhpcw0KPiAgICAgIHNwZWNpYWwgc2VnbWVudA0KPiAg
IDMpIHJlbWFwIHRoZSBleGlzdGluZyBrZXJuZWwgZGlyZWN0IG1hcHBpbmcsIGFmdGVyIGZsdXNo
aW5nIHRoZQ0KPiAgICAgIGNhY2hlcywgZG9uZSBieSBvcGVucmlzYyBhbmQgaW4gc29tZSBjYXNl
cyBhcm0zMg0KPiAgIDQpIGNyZWF0ZSBhIG5ldyBtYXBwaW5nIGluIHZtYXAgb3IgaW9yZW1hcCBz
cGFjZSBhZnRlciBmbHVzaGluZyB0aGUNCj4gICAgICBjYWNoZXMgLSBkb25lIGJ5IG1vc3QgYXJj
aGl0ZWN0dXJlcyB3aXRoIGFuIE1NVSBhbmQgbm9uLWNvaGVyZW50DQo+ICAgICAgZGV2aWNlcw0K
PiAgIDUpIHVzZSBhIHNwZWNpYWwgcG9vbCBvZiB1bmNhY2hlZCBtZW1vcnkgc2V0IGFzaWRlIGJ5
IHRoZSBoYXJkd2FyZQ0KPiAgICAgIG9yIGZpcm13YXJlIC0gZG9uZSBieSBtb3N0IGFyY2hpdGVj
dHVyZXMgd2l0aG91dCBhbiBNTVUgYnV0IHdpdGgNCj4gICAgICBub24tY29oZXJlbnQgZGV2aWNl
cw0KPiANCg0KVW5kZXJzdG9vZC4gVW5mb3J0dW5hdGVseSBJTU8gdGhpcyBzZXZlcmx5IGxpbWl0
cyB0aGUgdXNlIG9mIHRoZQ0KZG1hX2FsbG9jX2NvaGVyZW50KCkgbWV0aG9kLg0KDQo+IFNvIHRo
YXQgaXMganVzdCBmaXZlIG1ham9yIHZhcmlhbnRzIHdpdGggYSBsb3Qgb2YgZGV0YWlscyBvbiBo
b3cNCj4gaXQgaXMgZG9uZSBpbiBwcmFjdGljZS4gIEFkZCB0byB0aGF0IHRoYXQgbWFueSBvZiB0
aGUgb3BlcmF0aW9ucw0KPiBhcmUgZmFpcmx5IGV4cGVuc2l2ZSBhbmQgbmVlZCB0byBiZSBwcmUt
bG9hZGVkLg0KPiANCj4gPiA+IFRoYXQgYmVpbmcgc2FpZDogeW91ciBkcml2ZXIgYWxyZWFkeSB1
c2VzIHRoZSBkbWEgY29oZXJlbnQgQVBJDQo+ID4gPiB1bmRlciB2YXJpb3VzIGNpcmN1bXN0YW5j
ZXMsIHNvIHlvdSBhbHJlYWR5IGhhdmUgdGhlIGFib3ZlDQo+ID4gPiBpc3N1ZXMuDQo+ID4gDQo+
ID4gWWVzLCBidXQgdGhleSBhcmUgaGlkZGVuIGJlaGluZCBkcml2ZXIgb3B0aW9ucy4gV2UgY2Fu
J3QgaGF2ZQ0KPiA+IHNvbWVvbmUNCj4gPiB1cGdyYWRlIHRoZWlyIGtlcm5lbCBhbmQgc3VkZGVu
bHkgdGhpbmdzIGRvbid0IHdvcmsgYW55bW9yZSwgVGhhdA0KPiA+IHNhaWQsDQo+ID4gSSB0aGlu
ayB0aGUgU1dJT1RMQiBjYXNlIGlzIHJhcmUgZW5vdWdoIGZvciB0aGUgYmVsb3cgc29sdXRpb24g
dG8NCj4gPiBiZQ0KPiA+IGFjY2VwdGFibGUsIGFsdGhvdWdoIHRoZSBUVE0gY2hlY2sgZm9yIHRo
ZSBjb2hlcmVudCBwYWdlIHBvb2wgYmVpbmcNCj4gPiBhdmFpbGFibGUgc3RpbGwgbmVlZHMgdG8g
cmVtYWluLg0KPiANCj4gU28gY2FuIHlvdSBwbGVhc2UgcmVzcGluIGEgdmVyc2lvbiBhY2NlcHRh
YmxlIHRvIHlvdSBhbmQgc3VibWl0IGl0DQo+IGZvciA1LjEgQVNBUD8gIE90aGVyd2lzZSBJJ2xs
IG5lZWQgdG8gbW92ZSBhaGVhZCB3aXRoIHRoZSBzaW1wbGUNCj4gcmV2ZXJ0Lg0KDQpJIHdpbGwu
IA0KSSBuZWVkIHRvIGRvIHNvbWUgdGVzdGluZyB0byBpbnZlc3RpZ2F0ZSBob3cgdG8gYmVzdCBj
aG9vc2UgYmV0d2VlbiB0aGUNCm9wdGlvbnMsIGJ1dCB3aWxsIGhhdmUgc29tZXRoaW5nIHJlYWR5
IGZvciA1LjEuDQoNCi9UaG9tYXMNCg0K
