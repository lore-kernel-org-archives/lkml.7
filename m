Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235BC20835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Edeopl6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCSQ5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:57:55 -0400
Received: from mail-eopbgr130071.outbound.protection.outlook.com ([40.107.13.71]:65006
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726778AbfCSQ5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI8qnMBpSrEUPQycO4f2/4r1PKRryw3hNNqJvuLgYoE=;
 b=Edeopl6ikM0lvKAGdJy7uearu1jonwyge3EEFaAuhDD/j8kMjGHNj6fBf2AydaYmS0S/OOZgSkXt8XSYZ0auMJhFpR9FsdSdtktbNTJMAWf2SzWskHwesJGw8NaLDD8a+mGwr8vGiZyg466qlJzWJkVNfkF3LH0gCQXH3GWZVBI=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB5964.eurprd05.prod.outlook.com (20.179.9.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 16:57:47 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::28ed:92cd:4075:b660%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 16:57:47 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "pakki001@umn.edu" <pakki001@umn.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Boris Pismenny <borisp@mellanox.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v3] net: mlx5: Add a missing check on idr_find, free buf
Thread-Topic: [PATCH v3] net: mlx5: Add a missing check on idr_find, free buf
Thread-Index: AQHU3mwu5Tvmra2r5kC9JK5INJWvzaYTLOUA
Date:   Tue, 19 Mar 2019 16:57:47 +0000
Message-ID: <010498dc10890e09c18ab6941fa2abcde6a7b28e.camel@mellanox.com>
References: <20190319155524.6978-1-pakki001@umn.edu>
In-Reply-To: <20190319155524.6978-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [73.15.39.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06b277d9-8270-45ef-d8df-08d6ac8c03d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB8PR05MB5964;
x-ms-traffictypediagnostic: DB8PR05MB5964:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-microsoft-antispam-prvs: <DB8PR05MB596495140EB6BF460FFF9068BE400@DB8PR05MB5964.eurprd05.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(118296001)(8676002)(26005)(106356001)(68736007)(86362001)(105586002)(229853002)(2171002)(36756003)(186003)(53936002)(486006)(5640700003)(8936002)(6512007)(2351001)(316002)(446003)(2616005)(476003)(11346002)(7736002)(6436002)(256004)(305945005)(71200400001)(71190400001)(81156014)(81166006)(2906002)(54906003)(58126008)(6916009)(14444005)(6116002)(14454004)(5660300002)(478600001)(3846002)(66066001)(97736004)(102836004)(4326008)(6246003)(99286004)(25786009)(6506007)(2501003)(6486002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB5964;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SMmyWT3DdN0+dfwMlGlnDKDXBH4vvLcaFtbFIbJTE1ZVwCz8alpNmLFbq4kU4NDDqY9FVDQ9lINA2Mxr6pUaprkVrK97hXcKfPCd8g+lx+r6BP6a3aLsbXDcR9XOn2IJP0+87QGKM3vsxHUu451SnoVNdwxkg+xeQUmgpdxWqEzORXkjLLg58gt9s1LmbXGmG6fH76xrqd/wLCSQc5c48EaiIQe7dy8XUVtuD4Du58co9hwlH5rUeBR2+uIuY6Z9srkLpVJXn0TLfGujcIhFsJNOd/oUgToj86AAFq4Ogaj+2fnHsjt9PflV6tgkpzWhsYILyywpXG0vb7DM/nB1qgNz0Q1ylLqUs+PeH6UtCZfGGEggsGGXqKt5qhIAbHa1DZrcx4ONkc8CZxmRt0acoZBZbOkRThe0HeMNFar/Llk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <252F3ABE701D5744BFB0FF6E3863C8A9@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b277d9-8270-45ef-d8df-08d6ac8c03d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 16:57:47.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB5964
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTE5IGF0IDEwOjU1IC0wNTAwLCBBZGl0eWEgUGFra2kgd3JvdGU6DQo+
IGlkcl9maW5kKCkgY2FuIHJldHVybiBhIE5VTEwgdmFsdWUgdG8gJ2Zsb3cnIHdoaWNoIGlzIHVz
ZWQgd2l0aG91dCBhDQo+IGNoZWNrLg0KPiBUaGUgcGF0Y2ggYWRkcyBhIGNoZWNrIHRvIGF2b2lk
IHBvdGVudGlhbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UuDQo+IEluIGNhc2Ugb2YgbWx4NV9m
cGdhX3NidV9jb25uX3NlbmRtc2coKSBmYWlsdXJlLCBmcmVlIGJ1ZiBhbGxvY2F0ZWQNCj4gdXNp
bmcga3phbGxvYy4NCj4gDQo+IC0tLQ0KPiB2MjogZmFpbHVyZSB0byByZXR1cm4gaW4gY2FzZSBv
ZiBmbG93IGZhaWx1cmUuDQo+IHYxOiBGYWlsZWQgdG8gZnJlZSBidWYgaW4gY2FzZSBvZiBmbG93
IGZhaWx1cmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgUGFra2kgPHBha2tpMDAxQHVt
bi5lZHU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3Jl
L2ZwZ2EvdGxzLmMgfCA3ICsrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZnBnYS90bHMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUv
Y29yZS9mcGdhL3Rscy5jDQo+IGluZGV4IDVjZjVmMmE5ZDUxZi4uMjI0ZTBkN2Y2NDg5IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnBnYS90
bHMuYw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnBn
YS90bHMuYw0KPiBAQCAtMjI2LDYgKzIyNiwxMSBAQCBpbnQgbWx4NV9mcGdhX3Rsc19yZXN5bmNf
cngoc3RydWN0IG1seDVfY29yZV9kZXYNCj4gKm1kZXYsIHUzMiBoYW5kbGUsIHUzMiBzZXEsDQo+
ICAJcmN1X3JlYWRfbG9jaygpOw0KPiAgCWZsb3cgPSBpZHJfZmluZCgmbWRldi0+ZnBnYS0+dGxz
LT5yeF9pZHIsIG50b2hsKGhhbmRsZSkpOw0KPiAgCXJjdV9yZWFkX3VubG9jaygpOw0KPiArCWlm
ICghZmxvdykgew0KPiArCQlXQVJOX09OQ0UoMSwgIlJlY2VpdmVkIE5VTEwgcG9pbnRlciBmb3Ig
aGFuZGxlXG4iKTsNCj4gKwkJa2ZyZWUoYnVmKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJ
fQ0KDQpKdXN0IGEgc21hbGwgbml0LCBpdCB3b3VsZCBoYXZlIGJlZW4gc2ltcGxlciBpZiB5b3Ug
anVzdCBjaGFuZ2VkIHRoZQ0Kb3JkZXIgYmV0d2VlbiBidWYgPSBremFsbG9jKC4uLikgYW5kIGZs
b3cgPSBpZHJfZmluZCwgdG8gYXZvaWQNCmtmcmVlKGJ1Zikgb24gZXJyIGZsb3cuDQoNClBsZWFz
ZSBhZGQgdGhlIGZpeGVzIHRhZyBhcyBFcmljIHN1Z2dlc3RlZC4NCg0KPiAgCW1seDVfZnBnYV90
bHNfZmxvd190b19jbWQoZmxvdywgY21kKTsNCj4gIA0KPiAgCU1MWDVfU0VUKHRsc19jbWQsIGNt
ZCwgc3dpZCwgbnRvaGwoaGFuZGxlKSk7DQo+IEBAIC0yMzgsNiArMjQzLDggQEAgaW50IG1seDVf
ZnBnYV90bHNfcmVzeW5jX3J4KHN0cnVjdCBtbHg1X2NvcmVfZGV2DQo+ICptZGV2LCB1MzIgaGFu
ZGxlLCB1MzIgc2VxLA0KPiAgCWJ1Zi0+Y29tcGxldGUgPSBtbHhfdGxzX2tmcmVlX2NvbXBsZXRl
Ow0KPiAgDQo+ICAJcmV0ID0gbWx4NV9mcGdhX3NidV9jb25uX3NlbmRtc2cobWRldi0+ZnBnYS0+
dGxzLT5jb25uLCBidWYpOw0KPiArCWlmIChyZXQgPCAwKQ0KPiArCQlrZnJlZShidWYpOw0KPiAg
DQo+ICAJcmV0dXJuIHJldDsNCj4gIH0NCg==
