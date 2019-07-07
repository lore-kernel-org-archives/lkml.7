Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B331C0650E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 06:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278242083B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 06:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HyU6xCWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfGGGpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 02:45:55 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:54757
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfGGGpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 02:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W90KICyB3rwD4ZsKpdefCAtWljpF/ewH+MPOnFtNB+k=;
 b=HyU6xCWl97qf6ngBvXZOkBY1A+QfR0mpOHJBqgDpO8w4JMjFEjPhvwS/kJCT9+/3BX0wRndiA0t9aY39gMGc7QdGU/wOlmzyoGk1hFdqdj1a3vcH1KDUld8MP/SwTinmBeg8vLJdwPPY8FyeKdwHVZsc8b6I7c+uEVvtQ0qvwGk=
Received: from DBBPR05MB6283.eurprd05.prod.outlook.com (20.179.40.84) by
 DBBPR05MB6490.eurprd05.prod.outlook.com (20.179.43.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Sun, 7 Jul 2019 06:45:48 +0000
Received: from DBBPR05MB6283.eurprd05.prod.outlook.com
 ([fe80::2833:939d:2b5c:4a2d]) by DBBPR05MB6283.eurprd05.prod.outlook.com
 ([fe80::2833:939d:2b5c:4a2d%6]) with mapi id 15.20.2052.019; Sun, 7 Jul 2019
 06:45:48 +0000
From:   Tariq Toukan <tariqt@mellanox.com>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 15/27] net: use zeroing allocator rather than allocator
 followed by memset zero
Thread-Topic: [PATCH v3 15/27] net: use zeroing allocator rather than
 allocator followed by memset zero
Thread-Index: AQHVMKwDHcmxh450fEGB9jiwsXIZ3Ka+vdyA
Date:   Sun, 7 Jul 2019 06:45:47 +0000
Message-ID: <35de71f0-5307-d831-8d1c-f7948523b97d@mellanox.com>
References: <20190702075842.24212-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190702075842.24212-1-huangfq.daxian@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0217.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::13) To DBBPR05MB6283.eurprd05.prod.outlook.com
 (2603:10a6:10:c1::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87b241f7-1f4c-42af-36e0-08d702a6be5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DBBPR05MB6490;
x-ms-traffictypediagnostic: DBBPR05MB6490:
x-microsoft-antispam-prvs: <DBBPR05MB6490DAFCDF798977802B7002AEF70@DBBPR05MB6490.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:76;
x-forefront-prvs: 0091C8F1EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(4326008)(229853002)(2906002)(5660300002)(25786009)(64756008)(66476007)(14454004)(66446008)(66556008)(256004)(73956011)(6916009)(476003)(486006)(446003)(11346002)(66946007)(2616005)(316002)(68736007)(14444005)(3846002)(6116002)(8936002)(66066001)(36756003)(478600001)(99286004)(31686004)(6436002)(6246003)(86362001)(52116002)(76176011)(305945005)(6486002)(31696002)(71190400001)(71200400001)(6512007)(186003)(26005)(8676002)(53546011)(6506007)(386003)(7736002)(53936002)(81156014)(102836004)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6490;H:DBBPR05MB6283.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: T8HmgeMRbs6NEFPs2v8K0LjCjjopRvh863yaMNUlXTpuaPfO/EZGfm9qHrHklwlr2XMzqUSQqJ/Egq6M+6no46vZUeuRtWR2YkF/FQXSTU2IY7UWfH+AH7UUXwY+AnqoTexxUsoZEUA07Czrx8IkSL1EyqDKGtjNNNZ8ZE0CYW2Sfllns+1da1aVDrE3LdPPnbqCm2/TufEToN6/Z9IBO17sBx1IB9JtBkP7v/5lA8xNH8d5OdHQMnBvefAqOPrc4JFpgqGHR38nbkFjO7c714EOK261b0YWSfXf7EZg0tn8el8R9TmP8NmSSw5cwi5Qea5N0h7CUyPSrvHrMGo2BHCN0lHJu9F/tbIFqBVXM6RPv2eJ9BogOI7FwBXV2KznEh0LdOrB4zoXfwiYxhwT8l95pk2nUq3kLy+C/dhWtnU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12EB7193AB211D468D76CF23CB936D26@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b241f7-1f4c-42af-36e0-08d702a6be5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2019 06:45:47.9323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tariqt@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6490
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMi8yMDE5IDEwOjU4IEFNLCBGdXFpYW4gSHVhbmcgd3JvdGU6DQo+IFJlcGxhY2Ug
YWxsb2NhdG9yIGZvbGxvd2VkIGJ5IG1lbXNldCB3aXRoIDAgd2l0aCB6ZXJvaW5nIGFsbG9jYXRv
ci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZ1cWlhbiBIdWFuZyA8aHVhbmdmcS5kYXhpYW5AZ21h
aWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gICAgLSBSZXNlbmQNCj4gDQo+ICAg
ZHJpdmVycy9uZXQvZXFsLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDMgKy0tDQo+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL2xpcXVpZGlvL2NuMjN4eF9w
Zl9kZXZpY2UuYyB8IDQgKy0tLQ0KPiAgIGRyaXZlcnMvbmV0L2V0aGVybmV0L2Nhdml1bS9saXF1
aWRpby9jbjIzeHhfdmZfZGV2aWNlLmMgfCA0ICstLS0NCj4gICBkcml2ZXJzL25ldC9ldGhlcm5l
dC9tZWxsYW5veC9tbHg0L2VuX3J4LmMgICAgICAgICAgICAgIHwgMyArLS0NCj4gICA0IGZpbGVz
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvZXFsLmMgYi9kcml2ZXJzL25ldC9lcWwuYw0KPiBpbmRleCA3NDI2
M2Y4ZWZlMWEuLjJmMTAxYTYwMzZlNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvZXFsLmMN
Cj4gKysrIGIvZHJpdmVycy9uZXQvZXFsLmMNCj4gQEAgLTQxOSwxNCArNDE5LDEzIEBAIHN0YXRp
YyBpbnQgZXFsX2Vuc2xhdmUoc3RydWN0IG5ldF9kZXZpY2UgKm1hc3Rlcl9kZXYsIHNsYXZpbmdf
cmVxdWVzdF90IF9fdXNlciAqDQo+ICAgCWlmICgobWFzdGVyX2Rldi0+ZmxhZ3MgJiBJRkZfVVAp
ID09IElGRl9VUCkgew0KPiAgIAkJLyogc2xhdmUgaXMgbm90IGEgbWFzdGVyICYgbm90IGFscmVh
ZHkgYSBzbGF2ZTogKi8NCj4gICAJCWlmICghZXFsX2lzX21hc3RlcihzbGF2ZV9kZXYpICYmICFl
cWxfaXNfc2xhdmUoc2xhdmVfZGV2KSkgew0KPiAtCQkJc2xhdmVfdCAqcyA9IGttYWxsb2Moc2l6
ZW9mKCpzKSwgR0ZQX0tFUk5FTCk7DQo+ICsJCQlzbGF2ZV90ICpzID0ga3phbGxvYyhzaXplb2Yo
KnMpLCBHRlBfS0VSTkVMKTsNCj4gICAJCQllcXVhbGl6ZXJfdCAqZXFsID0gbmV0ZGV2X3ByaXYo
bWFzdGVyX2Rldik7DQo+ICAgCQkJaW50IHJldDsNCj4gICANCj4gICAJCQlpZiAoIXMpDQo+ICAg
CQkJCXJldHVybiAtRU5PTUVNOw0KPiAgIA0KPiAtCQkJbWVtc2V0KHMsIDAsIHNpemVvZigqcykp
Ow0KPiAgIAkJCXMtPmRldiA9IHNsYXZlX2RldjsNCj4gICAJCQlzLT5wcmlvcml0eSA9IHNycS5w
cmlvcml0eTsNCj4gICAJCQlzLT5wcmlvcml0eV9icHMgPSBzcnEucHJpb3JpdHk7DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYXZpdW0vbGlxdWlkaW8vY24yM3h4X3BmX2Rl
dmljZS5jIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL2xpcXVpZGlvL2NuMjN4eF9wZl9k
ZXZpY2UuYw0KPiBpbmRleCA0M2QxMWMzOGIzOGEuLmNmMzgzNWRhMzJjOCAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvY2F2aXVtL2xpcXVpZGlvL2NuMjN4eF9wZl9kZXZpY2Uu
Yw0KPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYXZpdW0vbGlxdWlkaW8vY24yM3h4X3Bm
X2RldmljZS5jDQo+IEBAIC03MTksMTIgKzcxOSwxMCBAQCBzdGF0aWMgaW50IGNuMjN4eF9zZXR1
cF9wZl9tYm94KHN0cnVjdCBvY3Rlb25fZGV2aWNlICpvY3QpDQo+ICAgCWZvciAoaSA9IDA7IGkg
PCBvY3QtPnNyaW92X2luZm8ubWF4X3ZmczsgaSsrKSB7DQo+ICAgCQlxX25vID0gaSAqIG9jdC0+
c3Jpb3ZfaW5mby5yaW5nc19wZXJfdmY7DQo+ICAgDQo+IC0JCW1ib3ggPSB2bWFsbG9jKHNpemVv
ZigqbWJveCkpOw0KPiArCQltYm94ID0gdnphbGxvYyhzaXplb2YoKm1ib3gpKTsNCj4gICAJCWlm
ICghbWJveCkNCj4gICAJCQlnb3RvIGZyZWVfbWJveDsNCj4gICANCj4gLQkJbWVtc2V0KG1ib3gs
IDAsIHNpemVvZihzdHJ1Y3Qgb2N0ZW9uX21ib3gpKTsNCj4gLQ0KPiAgIAkJc3Bpbl9sb2NrX2lu
aXQoJm1ib3gtPmxvY2spOw0KPiAgIA0KPiAgIAkJbWJveC0+b2N0X2RldiA9IG9jdDsNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Nhdml1bS9saXF1aWRpby9jbjIzeHhfdmZf
ZGV2aWNlLmMgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYXZpdW0vbGlxdWlkaW8vY24yM3h4X3Zm
X2RldmljZS5jDQo+IGluZGV4IGZkYTQ5NDA0OTY4Yy4uYjNiZDI3NjdkM2RkIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9jYXZpdW0vbGlxdWlkaW8vY24yM3h4X3ZmX2Rldmlj
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Nhdml1bS9saXF1aWRpby9jbjIzeHhf
dmZfZGV2aWNlLmMNCj4gQEAgLTI3OSwxMiArMjc5LDEwIEBAIHN0YXRpYyBpbnQgY24yM3h4X3Nl
dHVwX3ZmX21ib3goc3RydWN0IG9jdGVvbl9kZXZpY2UgKm9jdCkNCj4gICB7DQo+ICAgCXN0cnVj
dCBvY3Rlb25fbWJveCAqbWJveCA9IE5VTEw7DQo+ICAgDQo+IC0JbWJveCA9IHZtYWxsb2Moc2l6
ZW9mKCptYm94KSk7DQo+ICsJbWJveCA9IHZ6YWxsb2Moc2l6ZW9mKCptYm94KSk7DQo+ICAgCWlm
ICghbWJveCkNCj4gICAJCXJldHVybiAxOw0KPiAgIA0KPiAtCW1lbXNldChtYm94LCAwLCBzaXpl
b2Yoc3RydWN0IG9jdGVvbl9tYm94KSk7DQo+IC0NCj4gICAJc3Bpbl9sb2NrX2luaXQoJm1ib3gt
PmxvY2spOw0KPiAgIA0KPiAgIAltYm94LT5vY3RfZGV2ID0gb2N0Ow0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9yeC5jIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9lbl9yeC5jDQo+IGluZGV4IDZjMDEzMTRlODdiMC4uZjFk
ZmY1YzQ3Njc2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9t
bHg0L2VuX3J4LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NC9l
bl9yeC5jDQo+IEBAIC0xMDYyLDcgKzEwNjIsNyBAQCBzdGF0aWMgaW50IG1seDRfZW5fY29uZmln
X3Jzc19xcChzdHJ1Y3QgbWx4NF9lbl9wcml2ICpwcml2LCBpbnQgcXBuLA0KPiAgIAlzdHJ1Y3Qg
bWx4NF9xcF9jb250ZXh0ICpjb250ZXh0Ow0KPiAgIAlpbnQgZXJyID0gMDsNCj4gICANCj4gLQlj
b250ZXh0ID0ga21hbGxvYyhzaXplb2YoKmNvbnRleHQpLCBHRlBfS0VSTkVMKTsNCj4gKwljb250
ZXh0ID0ga3phbGxvYyhzaXplb2YoKmNvbnRleHQpLCBHRlBfS0VSTkVMKTsNCj4gICAJaWYgKCFj
b250ZXh0KQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+IEBAIC0xMDczLDcgKzEwNzMs
NiBAQCBzdGF0aWMgaW50IG1seDRfZW5fY29uZmlnX3Jzc19xcChzdHJ1Y3QgbWx4NF9lbl9wcml2
ICpwcml2LCBpbnQgcXBuLA0KPiAgIAl9DQo+ICAgCXFwLT5ldmVudCA9IG1seDRfZW5fc3FwX2V2
ZW50Ow0KPiAgIA0KPiAtCW1lbXNldChjb250ZXh0LCAwLCBzaXplb2YoKmNvbnRleHQpKTsNCj4g
ICAJbWx4NF9lbl9maWxsX3FwX2NvbnRleHQocHJpdiwgcmluZy0+YWN0dWFsX3NpemUsIHJpbmct
PnN0cmlkZSwgMCwgMCwNCj4gICAJCQkJcXBuLCByaW5nLT5jcW4sIC0xLCBjb250ZXh0KTsNCj4g
ICAJY29udGV4dC0+ZGJfcmVjX2FkZHIgPSBjcHVfdG9fYmU2NChyaW5nLT53cXJlcy5kYi5kbWEp
Ow0KPiANCg0KUmV2aWV3ZWQtYnk6IFRhcmlxIFRvdWthbiA8dGFyaXF0QG1lbGxhbm94LmNvbT4N
Cg==
