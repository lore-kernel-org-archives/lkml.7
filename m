Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0241C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11C221871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kQQaoS3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCTJtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:49:32 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:28388
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725996AbfCTJtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnWnC4Pd01FAayZmQ8CekbKfunW3SyKnvIgUOrCnjk8=;
 b=kQQaoS3/UFMxrctyG8x5WqSSj/2bcs/lXmjbsse+PyyIxEBfvepDKkZDrtT5h8EENqwRt2/2m7BTTaYAuchkpR4UwcY9Y+OHhaBS6m2AAVMpk0c1B3+b6TSoezVdyH5VygNFf762NzuuQQTPWFwxWkmQMkREEycDQJmrYkUDzeg=
Received: from VI1PR05MB5469.eurprd05.prod.outlook.com (20.177.201.28) by
 VI1PR05MB4925.eurprd05.prod.outlook.com (20.177.51.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 09:49:26 +0000
Received: from VI1PR05MB5469.eurprd05.prod.outlook.com
 ([fe80::b556:82e3:2a4c:2884]) by VI1PR05MB5469.eurprd05.prod.outlook.com
 ([fe80::b556:82e3:2a4c:2884%3]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 09:49:26 +0000
From:   Boris Pismenny <borisp@mellanox.com>
To:     Saeed Mahameed <saeedm@mellanox.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "pakki001@umn.edu" <pakki001@umn.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "leon@kernel.org" <leon@kernel.org>
Subject: Re: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
Thread-Topic: [PATCH v4] net: mlx5: Add a missing check on idr_find, free buf
Thread-Index: AQHU3py0TTZ/XQVr9kq8NLLpeG/iNaYT9K8AgAACMQCAAFBJgA==
Date:   Wed, 20 Mar 2019 09:49:25 +0000
Message-ID: <3549f722-bf9b-087b-b4d5-8d588f675eaa@mellanox.com>
References: <20190319214244.20212-1-pakki001@umn.edu>
 <d65ddd7e-6553-00a4-c261-bd88b7476626@gmail.com>
 <c44f3a3f0d74e65b1db9544cf50555f76c8daab4.camel@mellanox.com>
In-Reply-To: <c44f3a3f0d74e65b1db9544cf50555f76c8daab4.camel@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0049.eurprd07.prod.outlook.com
 (2603:10a6:203:2::11) To VI1PR05MB5469.eurprd05.prod.outlook.com
 (2603:10a6:803:94::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=borisp@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3dd14ac-23f1-48bc-aec9-08d6ad19564f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4925;
x-ms-traffictypediagnostic: VI1PR05MB4925:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr
x-microsoft-antispam-prvs: <VI1PR05MB492567B94324567487C23DFDB0410@VI1PR05MB4925.eurprd05.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(81156014)(31696002)(6116002)(5660300002)(2201001)(26005)(102836004)(316002)(36756003)(53546011)(31686004)(71190400001)(186003)(14444005)(256004)(97736004)(3846002)(229853002)(386003)(71200400001)(52116002)(86362001)(99286004)(76176011)(6486002)(6506007)(478600001)(66066001)(6436002)(6246003)(486006)(7736002)(25786009)(476003)(2616005)(446003)(110136005)(11346002)(4326008)(2501003)(54906003)(14454004)(2906002)(53936002)(305945005)(68736007)(8936002)(2171002)(106356001)(8676002)(81166006)(105586002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4925;H:VI1PR05MB5469.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DrT2eka6TJijhf5idneHwqXk5eoe+C9FESfd5tt/tYfLrTSy4jLmn5O0/QZBsPQcleStOyOsxpCrIXX1q4jBBKoGsCgV5GyNFRUsE0XK8V15Ngx+XIBqcQrJ0se26WEU63+mhecDx4MWs2eHdVJnWNKjhjh6W9fg+aw58GGV2oP01U/jy1oF47v1VkI3DBuzpkbtt1IOISqTveyYTQ3JEGDloqkZqmi4+sYFSTXSmoBZihexFAUEW2MEMVgAQ6e+W2TknKSPmIjvaJGHKcHhnEq9xqhYOLxuGIligs1ZeD71OI/01UvOj8i04lku6YVAQGK6ksJ4o1iH4x9Qn570i549S2owFQeRT0iQUxnCQk/jFYvvWtm3135j9Y82RHIGlk4DXmBs8KX3i0N06USpLtE8+jx6WdLCpm5dZPpKa3c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4579C8FE50862A4AB5173FA496BB6BB8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3dd14ac-23f1-48bc-aec9-08d6ad19564f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 09:49:26.0329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4925
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMjAvMjAxOSA3OjAyIEFNLCBTYWVlZCBNYWhhbWVlZCB3cm90ZToNCj4gT24gVHVl
LCAyMDE5LTAzLTE5IGF0IDIxOjU0IC0wNzAwLCBFcmljIER1bWF6ZXQgd3JvdGU6DQo+Pg0KPj4g
T24gMDMvMTkvMjAxOSAwMjo0MiBQTSwgQWRpdHlhIFBha2tpIHdyb3RlOg0KPj4+IGlkcl9maW5k
KCkgY2FuIHJldHVybiBhIE5VTEwgdmFsdWUgdG8gJ2Zsb3cnIHdoaWNoIGlzIHVzZWQgd2l0aG91
dA0KPj4+IGENCj4+PiBjaGVjay4gVGhlIHBhdGNoIGFkZHMgYSBjaGVjayB0byBhdm9pZCBwb3Rl
bnRpYWwgTlVMTCBwb2ludGVyDQo+Pj4gZGVyZWZlcmVuY2UuDQo+Pj4NCj4+PiBJbiBjYXNlIG9m
IG1seDVfZnBnYV9zYnVfY29ubl9zZW5kbXNnKCkgZmFpbHVyZSwgZnJlZSBidWYgYWxsb2NhdGVk
DQo+Pj4gdXNpbmcga3phbGxvYy4NCj4+Pg0KPj4+IEZpeGVzOiBhYjQxMmUxZGQ3ZGIgKCJuZXQv
bWx4NTogQWNjZWwsIGFkZCBUTFMgcnggb2ZmbG9hZA0KPj4+IHJvdXRpbmVzIikNCj4+PiAtLS0N
Cj4+PiB2MzogUmVvcmRlciBidWYgYWxsb2NhdGlvbnMgYW5kIGZsb3cgY2hlY2suDQo+Pj4gdjI6
IGZhaWx1cmUgdG8gcmV0dXJuIGluIGNhc2Ugb2YgZmxvdyBmYWlsdXJlLg0KPj4+IHYxOiBGYWls
ZWQgdG8gZnJlZSBidWYgaW4gY2FzZSBvZiBmbG93IGZhaWx1cmUuDQo+Pj4NCj4+PiBTaWduZWQt
b2ZmLWJ5OiBBZGl0eWEgUGFra2kgPHBha2tpMDAxQHVtbi5lZHU+DQo+Pj4gLS0tDQo+Pj4gICBk
cml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnBnYS90bHMuYyB8IDE0DQo+
Pj4gKysrKysrKysrKystLS0NCj4+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L21lbGxhbm94L21seDUvY29yZS9mcGdhL3Rscy5jDQo+Pj4gYi9kcml2ZXJzL25ldC9ldGhl
cm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZnBnYS90bHMuYw0KPj4+IGluZGV4IDVjZjVmMmE5ZDUx
Zi4uOGRlNjRlODhjNjcwIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L21l
bGxhbm94L21seDUvY29yZS9mcGdhL3Rscy5jDQo+Pj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvbWVsbGFub3gvbWx4NS9jb3JlL2ZwZ2EvdGxzLmMNCj4+PiBAQCAtMjE3LDE1ICsyMTcsMjEg
QEAgaW50IG1seDVfZnBnYV90bHNfcmVzeW5jX3J4KHN0cnVjdA0KPj4+IG1seDVfY29yZV9kZXYg
Km1kZXYsIHUzMiBoYW5kbGUsIHUzMiBzZXEsDQo+Pj4gICAJdm9pZCAqY21kOw0KPj4+ICAgCWlu
dCByZXQ7DQo+Pj4gICANCj4+PiArCXJjdV9yZWFkX2xvY2soKTsNCj4+PiArCWZsb3cgPSBpZHJf
ZmluZCgmbWRldi0+ZnBnYS0+dGxzLT5yeF9pZHIsIG50b2hsKGhhbmRsZSkpOw0KPj4+ICsJcmN1
X3JlYWRfdW5sb2NrKCk7DQo+Pg0KPj4gVGhpcyBsb29rcyBzdXNwZWN0IChldmVuIGJlZm9yZSB5
b3VyIHBhdGNoKQ0KPj4NCj4+IFdoYXQgcHJldmVudHMgZmxvdyBmcm9tIGRpc2FwcGVhcmluZyBh
ZnRlciB0aGlzIHJjdV9yZWFkX2xvY2soKSA/DQo+Pg0KPj4gSU1PIHlvdXIgcGF0Y2ggbWlnaHQg
cHJldmVudCBhIE5VTEwgZGVyZWYsIGJ1dCBub3QgdXNlLWFmdGVyLWZyZWUuDQo+IA0KPiBUaGF0
IGNyb3NzZWQgbXkgbWluZCB3aGVuIGkgcmV2aWV3ZWQgdGhpcyBwYXRjaCBidXQgc2luY2UgdGhp
cyBpcyBhbg0KPiBvbGQgaXNzdWUgaSBqdXN0IHB1dCBhIHRvZG8gYXNpZGUgdG8gaGFuZGxlIGl0
IGxhdGVyDQo+IA0KPiBpIHRoaW5rIHRoZSBhdXRob3IgZGlkbid0IHdhbnQgdG8gZGVhbCB3aXRo
IHVzZS1hZnRlci1mcmVlIGhlcmUsIGJ1dA0KPiBvbmx5IHdhbnRlZCB0byBrZWVwIHRoZSBkYXRh
IHN0cnVjdHVyZSBzYWZlIGFnYWluc3QgYWRkL3JlbW92ZQ0KPiBvcGVyYXRpb25zLg0KPiANCj4g
QW55d2F5IGFsbCB3ZSBuZWVkIGhlcmUgaXMNCj4gICANCj4gcmN1X3JlYWRfbG9jaygpDQo+IGZs
b3cgPSBpZHJfZmluZCguLikNCj4gbWx4NV9mcGdhX3Rsc19mbG93X3RvX2NtZChmbG93LCBjbWQp
Ow0KPiByY3VfcmVhZF91bmxvY2soKQ0KPiANCj4gV2lsbCBmaXggaXQgdXAgaW4gYSBmb2xsb3cg
dXAgcGF0Y2gsDQo+IA0KPiBUaGFuayB5b3UgRXJpYyAhIQ0KPiANCg0KVGhpcyBmbG93IHdvbid0
IGJlIHJlbW92ZWQgdW5sZXNzIHRoZSB0Y3AgY29ubmVjdGlvbiBjYWxsIHNrX2Rlc3RydWN0IG9y
IA0KdGhlIG5ldGRldiBpcyByZW1vdmVkLg0KDQpUaHVzLCB0aGlzIGxvb2t1cCBzaG91bGQgKmFs
d2F5cyogc3VjY2VlZC4NCg0KVGhpcywgaXMgYWxzbyB3aHkgSSB3YW50ZWQgdG8gYXNrIEFkaXR5
YSBpZiB0aGlzIGZsb3cgd2FzIGFjdHVhbGx5IA0KZW5jb3VudGVyZWQgaW4gcHJhY3RpY2UuIEkn
bSBzdXJlIHRoYXQgaWYgb3VyIGFzc3VtcHRpb24gYWJvdXQgdGhlIA0Kc2FmZXR5IG9mIHRoaXMg
ZmxvdyBicmVha3MsIHRoZW4gb3RoZXIgcGFydHMgb2YgdGhlIFRMUyBkcml2ZXIgd2lsbCBmYWls
IA0KYXMgd2VsbC4NCg0KPiANCj4+DQo+Pj4gKw0KPj4+ICsJaWYgKCFmbG93KSB7DQo+Pj4gKwkJ
V0FSTl9PTkNFKDEsICJSZWNlaXZlZCBOVUxMIHBvaW50ZXIgZm9yIGhhbmRsZVxuIik7DQo+Pj4g
KwkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICAgCWJ1ZiA9IGt6YWxsb2Mo
c2l6ZSwgR0ZQX0FUT01JQyk7DQo+Pj4gICAJaWYgKCFidWYpDQo+Pj4gICAJCXJldHVybiAtRU5P
TUVNOw0KPj4+ICAgDQo+Pj4gICAJY21kID0gKGJ1ZiArIDEpOw0KPj4+ICAgDQo+Pj4gLQlyY3Vf
cmVhZF9sb2NrKCk7DQo+Pj4gLQlmbG93ID0gaWRyX2ZpbmQoJm1kZXYtPmZwZ2EtPnRscy0+cnhf
aWRyLCBudG9obChoYW5kbGUpKTsNCj4+PiAtCXJjdV9yZWFkX3VubG9jaygpOw0KPj4+ICAgCW1s
eDVfZnBnYV90bHNfZmxvd190b19jbWQoZmxvdywgY21kKTsNCj4+PiAgIA0KPj4+ICAgCU1MWDVf
U0VUKHRsc19jbWQsIGNtZCwgc3dpZCwgbnRvaGwoaGFuZGxlKSk7DQo+Pj4gQEAgLTIzOCw2ICsy
NDQsOCBAQCBpbnQgbWx4NV9mcGdhX3Rsc19yZXN5bmNfcngoc3RydWN0DQo+Pj4gbWx4NV9jb3Jl
X2RldiAqbWRldiwgdTMyIGhhbmRsZSwgdTMyIHNlcSwNCj4+PiAgIAlidWYtPmNvbXBsZXRlID0g
bWx4X3Rsc19rZnJlZV9jb21wbGV0ZTsNCj4+PiAgIA0KPj4+ICAgCXJldCA9IG1seDVfZnBnYV9z
YnVfY29ubl9zZW5kbXNnKG1kZXYtPmZwZ2EtPnRscy0+Y29ubiwgYnVmKTsNCj4+PiArCWlmIChy
ZXQgPCAwKQ0KPj4+ICsJCWtmcmVlKGJ1Zik7DQo+Pj4gICANCj4+PiAgIAlyZXR1cm4gcmV0Ow0K
Pj4+ICAgfQ0KPj4+DQo=
