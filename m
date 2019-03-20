Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA208C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966EA2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="E86h7Snk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfCTFCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:02:10 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:9390
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfCTFCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN2S4xwKCFGbKgCnAUdQejuBQOq/M0X6QvMF1IsNhD8=;
 b=E86h7SnkRyR3NyY+0mbwJecFytkJ26XZ5iBACmh4xCWVt5C7jpPFFG3J6bpJnM7J9QSVD7w3UJ4VtOy/zcAv5BVj+LIx27DI9tpoFev36msLY00ezC8e0V0fte0r6WH2UmHDLnzteZAipCF6ujS+8gFb66mI3TQCgQO+vWH9P54=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB5850.eurprd05.prod.outlook.com (20.179.8.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 05:02:00 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 05:02:00 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "pakki001@umn.edu" <pakki001@umn.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
Thread-Topic: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
Thread-Index: AQHU3py0/Q+8rPAh+0G/hpfTLlAQ7KYT9K8AgAACLYA=
Date:   Wed, 20 Mar 2019 05:02:00 +0000
Message-ID: <c44f3a3f0d74e65b1db9544cf50555f76c8daab4.camel@mellanox.com>
References: <20190319214244.20212-1-pakki001@umn.edu>
         <d65ddd7e-6553-00a4-c261-bd88b7476626@gmail.com>
In-Reply-To: <d65ddd7e-6553-00a4-c261-bd88b7476626@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [73.15.39.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a2f6691-a9d6-4f79-a6cd-08d6acf12f83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB5850;
x-ms-traffictypediagnostic: DB8PR05MB5850:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <DB8PR05MB58509FE69C38F890B6151122BE410@DB8PR05MB5850.eurprd05.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(366004)(189003)(199004)(71190400001)(5660300002)(2906002)(81156014)(71200400001)(58126008)(8676002)(26005)(66066001)(53936002)(110136005)(2501003)(316002)(6512007)(186003)(54906003)(305945005)(81166006)(102836004)(4326008)(14444005)(6246003)(97736004)(105586002)(99286004)(6506007)(106356001)(6116002)(68736007)(446003)(3846002)(14454004)(7736002)(229853002)(53546011)(6486002)(36756003)(6436002)(478600001)(86362001)(486006)(8936002)(256004)(25786009)(11346002)(2616005)(476003)(118296001)(2171002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5850;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: h628XENRIFHc0hBbNKiSP6w9IaL8jKtGHMYgiX79v052nA+7x7f3btBYCTHbG7hVIkRQIVPtTLGsvmkZq5cQm7Oh5lR8Oo5ceaEAKDKVR0GOE5SP/1IIcZKHs6I77X4vD6KwrdP2LGwm55V0RLpOi31sklV9FJajOjdDWVvbgp5VhUZ7PuB6Z/pNdSHDGZ6UdtJm8LgI9/DRIaRq0soOkQSjkXzYG2u30j33Jbevyq9fjN+uPY/cL08g+F8OCLmmZ3CAiI9fAQNgrYZf+1/AoxhbYvU9WuxMresLSAhyMwRDyYgEAkBdBhOr6Ojo9cy0gb3nnywCakq8GHbF4csthsGq9I+8XzCUFfgpSMmumKL/oUG93IUeejXBPXib8njc8kD5j14wO2ud2I4f2B0M4U6VNv5nVT4gSp0t7TDME04=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2254E96E98CAB14C92D91125D030440E@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2f6691-a9d6-4f79-a6cd-08d6acf12f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 05:02:00.2575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTE5IGF0IDIxOjU0IC0wNzAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+
IA0KPiBPbiAwMy8xOS8yMDE5IDAyOjQyIFBNLCBBZGl0eWEgUGFra2kgd3JvdGU6DQo+ID4gaWRy
X2ZpbmQoKSBjYW4gcmV0dXJuIGEgTlVMTCB2YWx1ZSB0byAnZmxvdycgd2hpY2ggaXMgdXNlZCB3
aXRob3V0DQo+ID4gYQ0KPiA+IGNoZWNrLiBUaGUgcGF0Y2ggYWRkcyBhIGNoZWNrIHRvIGF2b2lk
IHBvdGVudGlhbCBOVUxMIHBvaW50ZXINCj4gPiBkZXJlZmVyZW5jZS4NCj4gPiANCj4gPiBJbiBj
YXNlIG9mIG1seDVfZnBnYV9zYnVfY29ubl9zZW5kbXNnKCkgZmFpbHVyZSwgZnJlZSBidWYgYWxs
b2NhdGVkDQo+ID4gdXNpbmcga3phbGxvYy4NCj4gPiANCj4gPiBGaXhlczogYWI0MTJlMWRkN2Ri
ICgibmV0L21seDU6IEFjY2VsLCBhZGQgVExTIHJ4IG9mZmxvYWQNCj4gPiByb3V0aW5lcyIpDQo+
ID4gLS0tDQo+ID4gdjM6IFJlb3JkZXIgYnVmIGFsbG9jYXRpb25zIGFuZCBmbG93IGNoZWNrLg0K
PiA+IHYyOiBmYWlsdXJlIHRvIHJldHVybiBpbiBjYXNlIG9mIGZsb3cgZmFpbHVyZS4NCj4gPiB2
MTogRmFpbGVkIHRvIGZyZWUgYnVmIGluIGNhc2Ugb2YgZmxvdyBmYWlsdXJlLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IEFkaXR5YSBQYWtraSA8cGFra2kwMDFAdW1uLmVkdT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2ZwZ2EvdGxzLmMg
fCAxNA0KPiA+ICsrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnBnYS90bHMuYw0KPiA+IGIvZHJpdmVycy9u
ZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2ZwZ2EvdGxzLmMNCj4gPiBpbmRleCA1Y2Y1
ZjJhOWQ1MWYuLjhkZTY0ZTg4YzY3MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnBnYS90bHMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0
L2V0aGVybmV0L21lbGxhbm94L21seDUvY29yZS9mcGdhL3Rscy5jDQo+ID4gQEAgLTIxNywxNSAr
MjE3LDIxIEBAIGludCBtbHg1X2ZwZ2FfdGxzX3Jlc3luY19yeChzdHJ1Y3QNCj4gPiBtbHg1X2Nv
cmVfZGV2ICptZGV2LCB1MzIgaGFuZGxlLCB1MzIgc2VxLA0KPiA+ICAJdm9pZCAqY21kOw0KPiA+
ICAJaW50IHJldDsNCj4gPiAgDQo+ID4gKwlyY3VfcmVhZF9sb2NrKCk7DQo+ID4gKwlmbG93ID0g
aWRyX2ZpbmQoJm1kZXYtPmZwZ2EtPnRscy0+cnhfaWRyLCBudG9obChoYW5kbGUpKTsNCj4gPiAr
CXJjdV9yZWFkX3VubG9jaygpOw0KPiANCj4gVGhpcyBsb29rcyBzdXNwZWN0IChldmVuIGJlZm9y
ZSB5b3VyIHBhdGNoKQ0KPiANCj4gV2hhdCBwcmV2ZW50cyBmbG93IGZyb20gZGlzYXBwZWFyaW5n
IGFmdGVyIHRoaXMgcmN1X3JlYWRfbG9jaygpID8NCj4gDQo+IElNTyB5b3VyIHBhdGNoIG1pZ2h0
IHByZXZlbnQgYSBOVUxMIGRlcmVmLCBidXQgbm90IHVzZS1hZnRlci1mcmVlLg0KDQpUaGF0IGNy
b3NzZWQgbXkgbWluZCB3aGVuIGkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBidXQgc2luY2UgdGhpcyBp
cyBhbg0Kb2xkIGlzc3VlIGkganVzdCBwdXQgYSB0b2RvIGFzaWRlIHRvIGhhbmRsZSBpdCBsYXRl
cg0KDQppIHRoaW5rIHRoZSBhdXRob3IgZGlkbid0IHdhbnQgdG8gZGVhbCB3aXRoIHVzZS1hZnRl
ci1mcmVlIGhlcmUsIGJ1dA0Kb25seSB3YW50ZWQgdG8ga2VlcCB0aGUgZGF0YSBzdHJ1Y3R1cmUg
c2FmZSBhZ2FpbnN0IGFkZC9yZW1vdmUNCm9wZXJhdGlvbnMuDQoNCkFueXdheSBhbGwgd2UgbmVl
ZCBoZXJlIGlzDQogDQpyY3VfcmVhZF9sb2NrKCkNCmZsb3cgPSBpZHJfZmluZCguLikNCm1seDVf
ZnBnYV90bHNfZmxvd190b19jbWQoZmxvdywgY21kKTsgDQpyY3VfcmVhZF91bmxvY2soKQ0KDQpX
aWxsIGZpeCBpdCB1cCBpbiBhIGZvbGxvdyB1cCBwYXRjaCwNCg0KVGhhbmsgeW91IEVyaWMgISEN
Cg0KDQo+IA0KPiA+ICsNCj4gPiArCWlmICghZmxvdykgew0KPiA+ICsJCVdBUk5fT05DRSgxLCAi
UmVjZWl2ZWQgTlVMTCBwb2ludGVyIGZvciBoYW5kbGVcbiIpOw0KPiA+ICsJCXJldHVybiAtRUlO
VkFMOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCWJ1ZiA9IGt6YWxsb2Moc2l6ZSwgR0ZQX0FUT01J
Qyk7DQo+ID4gIAlpZiAoIWJ1ZikNCj4gPiAgCQlyZXR1cm4gLUVOT01FTTsNCj4gPiAgDQo+ID4g
IAljbWQgPSAoYnVmICsgMSk7DQo+ID4gIA0KPiA+IC0JcmN1X3JlYWRfbG9jaygpOw0KPiA+IC0J
ZmxvdyA9IGlkcl9maW5kKCZtZGV2LT5mcGdhLT50bHMtPnJ4X2lkciwgbnRvaGwoaGFuZGxlKSk7
DQo+ID4gLQlyY3VfcmVhZF91bmxvY2soKTsNCj4gPiAgCW1seDVfZnBnYV90bHNfZmxvd190b19j
bWQoZmxvdywgY21kKTsNCj4gPiAgDQo+ID4gIAlNTFg1X1NFVCh0bHNfY21kLCBjbWQsIHN3aWQs
IG50b2hsKGhhbmRsZSkpOw0KPiA+IEBAIC0yMzgsNiArMjQ0LDggQEAgaW50IG1seDVfZnBnYV90
bHNfcmVzeW5jX3J4KHN0cnVjdA0KPiA+IG1seDVfY29yZV9kZXYgKm1kZXYsIHUzMiBoYW5kbGUs
IHUzMiBzZXEsDQo+ID4gIAlidWYtPmNvbXBsZXRlID0gbWx4X3Rsc19rZnJlZV9jb21wbGV0ZTsN
Cj4gPiAgDQo+ID4gIAlyZXQgPSBtbHg1X2ZwZ2Ffc2J1X2Nvbm5fc2VuZG1zZyhtZGV2LT5mcGdh
LT50bHMtPmNvbm4sIGJ1Zik7DQo+ID4gKwlpZiAocmV0IDwgMCkNCj4gPiArCQlrZnJlZShidWYp
Ow0KPiA+ICANCj4gPiAgCXJldHVybiByZXQ7DQo+ID4gIH0NCj4gPiANCg==
