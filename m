Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8670C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0F220685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="OBis0MVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfDYSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:13:55 -0400
Received: from mail-eopbgr10071.outbound.protection.outlook.com ([40.107.1.71]:1470
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbfDYSLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/aiA55Pxjrk+I1cYrzGLR4sJ4F6Q97ZnPN5+4xaxC4=;
 b=OBis0MVt0bwOXbIwvmc613rjmdRTKyyMWJAmDk4oOIM1g6eMTy36AbRSYgOXErqT1cRdB1GEGdJGxWMTFr2I+rqGloSPIojwhGKO3AqHTzXX6Cv93glvuP1EaR9WNWjtf4g7g9xnKEmf2teo2zvt5f9BjdhooIHTWIuC5/VUx7A=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6043.eurprd05.prod.outlook.com (20.179.11.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Thu, 25 Apr 2019 18:11:50 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::ed24:8317:76e4:1a07]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::ed24:8317:76e4:1a07%4]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 18:11:50 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        Moshe Shemesh <moshe@mellanox.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Topic: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Index: AQHU+1W97FRfJKyEkEyPDy2xvgcLIKZNLgYA
Date:   Thu, 25 Apr 2019 18:11:50 +0000
Message-ID: <59ae0f783aebe76ae0643438c15c0c7d2ea74145.camel@mellanox.com>
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
In-Reply-To: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 239c54bd-1cfa-40e9-ab42-08d6c9a97d5c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB8PR05MB6043;
x-ms-traffictypediagnostic: DB8PR05MB6043:
x-microsoft-antispam-prvs: <DB8PR05MB6043916DEDA8A18D8A65E44FBE3D0@DB8PR05MB6043.eurprd05.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(366004)(39860400002)(136003)(199004)(189003)(66946007)(6116002)(2906002)(54906003)(6636002)(102836004)(5660300002)(86362001)(76176011)(2501003)(3846002)(97736004)(66066001)(8936002)(81156014)(8676002)(478600001)(81166006)(58126008)(316002)(6246003)(14454004)(110136005)(66476007)(71190400001)(99286004)(6506007)(476003)(66556008)(64756008)(66446008)(68736007)(229853002)(25786009)(26005)(486006)(71200400001)(6512007)(4326008)(305945005)(186003)(446003)(6486002)(36756003)(11346002)(53936002)(76116006)(6436002)(91956017)(2616005)(118296001)(7736002)(256004)(14444005)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6043;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NH1aTbVKYazE2hJEsFmKJA/XsUK0rSFWDJHGceKKa/gUEN8AIYyf/v2PoS6dtXM2D075H5n6TvVujBIl7zt19xrBq7yOIn56uSRa/XMN7LVka8PUuz6J+Nk1y/z3iNVItmeGMIuhOtEBSBSFomZu3EQCs36OpqFvC8g3lJDXB667i6PwETcAGPYScShUjc1fOYZNe+egS5AxUPTTy7IML+DcJAH/dfjXgaR+6O5kk/636NKiFohGH3ATOwF1JoBq1pxwrRvfCJOC4TIjaJBU9aQGDMGN146s304FNWAsygM15Y4S/y+BnzG1GGXXUAeOeyGvfdpdoMzWu0ofSfGwGW4g0JUbJP7KHEdMOtTUcpQ+jciy4k++N2UpwgL4q2q9fSNtmYpptDuSEQuBboFp9xGECozwwus9ceFIihnb4W8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A094D119AC956438D4B9FFDBB332DAA@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239c54bd-1cfa-40e9-ab42-08d6c9a97d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 18:11:50.8054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA0LTI1IGF0IDEzOjU3ICswMzAwLCBNb3NoZSBTaGVtZXNoIHdyb3RlOg0K
PiBEaWZmZXJlbnQgcmVwb3J0ZXJzIGhhdmUgZGlmZmVyZW50IHJ1bGVzIGluIHRoZSBkcml2ZXIg
YW5kIGFyZSBiZWluZw0KPiBjcmVhdGVkL2Rlc3Ryb3llZCBkdXJpbmcgZGlmZmVyZW50IHN0YWdl
cyBvZiBkcml2ZXINCj4gbG9hZC91bmxvYWQvcnVubmluZy4NCj4gU28gZHVyaW5nIGV4ZWN1dGlv
biBvZiBhIHJlcG9ydGVyIHJlY292ZXIgdGhlIGZsb3cgY2FuIGdvIHRocm91Z2gNCj4gYW5vdGhl
ciByZXBvcnRlcidzIGRlc3Ryb3kgYW5kIGNyZWF0ZS4gU3VjaCBmbG93IGxlYWRzIHRvIGRlYWRs
b2NrDQo+IHRyeWluZyB0byBsb2NrIGEgbXV0ZXggYWxyZWFkeSBoZWxkIGlmIHRoZSBmbG93IHdh
cyB0cmlnZ2VyZWQgYnkNCj4gZGV2bGluaw0KPiByZWNvdmVyIGNvbW1hbmQuDQo+IFRvIGF2b2lk
IHN1Y2ggZGVhZGxvY2ssIHdlIGV4ZWN1dGUgdGhlIHJlY292ZXIgZmxvdyBmcm9tIGEgd29ya3F1
ZXVlLg0KPiBPbmNlIHRoZSByZWNvdmVyIHdvcmsgaXMgZG9uZSBzdWNjZXNzZnVsbHkgdGhlIHJl
cG9ydGVyIGhlYWx0aCBzdGF0ZQ0KPiBhbmQNCj4gcmVjb3ZlciBjb3VudGVyIGFyZSBiZWluZyB1
cGRhdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTW9zaGUgU2hlbWVzaCA8bW9zaGVAbWVsbGFu
b3guY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG1lbGxhbm94LmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IFNhZWVkIE1haGFtZWVkIDxzYWVlZG1AbWVsbGFub3guY29tPg0KDQo+
IC0tLQ0KPiAgaW5jbHVkZS9uZXQvZGV2bGluay5oIHwgIDEgKw0KPiAgbmV0L2NvcmUvZGV2bGlu
ay5jICAgIHwgNzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+IC0t
LS0tLS0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAyMSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9kZXZsaW5rLmggYi9pbmNs
dWRlL25ldC9kZXZsaW5rLmgNCj4gaW5kZXggNGY1ZTQxNi4uODIwYjMyNyAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9uZXQvZGV2bGluay5oDQo+ICsrKyBiL2luY2x1ZGUvbmV0L2RldmxpbmsuaA0K
PiBAQCAtMzIsNiArMzIsNyBAQCBzdHJ1Y3QgZGV2bGluayB7DQo+ICAJc3RydWN0IGxpc3RfaGVh
ZCByZWdpb25fbGlzdDsNCj4gIAl1MzIgc25hcHNob3RfaWQ7DQo+ICAJc3RydWN0IGxpc3RfaGVh
ZCByZXBvcnRlcl9saXN0Ow0KPiArCXN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICpyZXBvcnRlcnNf
d3E7DQo+ICAJc3RydWN0IGRldmxpbmtfZHBpcGVfaGVhZGVycyAqZHBpcGVfaGVhZGVyczsNCj4g
IAljb25zdCBzdHJ1Y3QgZGV2bGlua19vcHMgKm9wczsNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXY7
DQo+IGRpZmYgLS1naXQgYS9uZXQvY29yZS9kZXZsaW5rLmMgYi9uZXQvY29yZS9kZXZsaW5rLmMN
Cj4gaW5kZXggN2I5MTYwNS4uOGVlMzgwZSAxMDA2NDQNCj4gLS0tIGEvbmV0L2NvcmUvZGV2bGlu
ay5jDQo+ICsrKyBiL25ldC9jb3JlL2RldmxpbmsuYw0KPiBAQCAtNDQyMiw2ICs0NDIyLDcgQEAg
c3RydWN0IGRldmxpbmtfaGVhbHRoX3JlcG9ydGVyIHsNCj4gIAl1NjQgZXJyb3JfY291bnQ7DQo+
ICAJdTY0IHJlY292ZXJ5X2NvdW50Ow0KPiAgCXU2NCBsYXN0X3JlY292ZXJ5X3RzOw0KPiArCXN0
cnVjdCB3b3JrX3N0cnVjdCByZWNvdmVyX3dvcms7DQo+ICB9Ow0KPiAgDQo+ICB2b2lkICoNCj4g
QEAgLTQ0NDMsNiArNDQ0NCw0MCBAQCBzdHJ1Y3QgZGV2bGlua19oZWFsdGhfcmVwb3J0ZXIgew0K
PiAgCXJldHVybiBOVUxMOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgaW50DQo+ICtkZXZsaW5rX2hl
YWx0aF9yZXBvcnRlcl9yZWNvdmVyKHN0cnVjdCBkZXZsaW5rX2hlYWx0aF9yZXBvcnRlcg0KPiAq
cmVwb3J0ZXIsDQo+ICsJCQkJdm9pZCAqcHJpdl9jdHgpDQo+ICt7DQo+ICsJaW50IGVycjsNCj4g
Kw0KPiArCWlmICghcmVwb3J0ZXItPm9wcy0+cmVjb3ZlcikNCj4gKwkJcmV0dXJuIC1FT1BOT1RT
VVBQOw0KPiArDQo+ICsJZXJyID0gcmVwb3J0ZXItPm9wcy0+cmVjb3ZlcihyZXBvcnRlciwgcHJp
dl9jdHgpOw0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwlyZXBvcnRl
ci0+cmVjb3ZlcnlfY291bnQrKzsNCj4gKwlyZXBvcnRlci0+aGVhbHRoX3N0YXRlID0gREVWTElO
S19IRUFMVEhfUkVQT1JURVJfU1RBVEVfSEVBTFRIWTsNCj4gKwlyZXBvcnRlci0+bGFzdF9yZWNv
dmVyeV90cyA9IGppZmZpZXM7DQo+ICsNCj4gKwl0cmFjZV9kZXZsaW5rX2hlYWx0aF9yZXBvcnRl
cl9zdGF0ZV91cGRhdGUocmVwb3J0ZXItPmRldmxpbmssDQo+ICsJCQkJCQkgICByZXBvcnRlci0+
b3BzLT5uYW1lLA0KPiArCQkJCQkJICAgcmVwb3J0ZXItDQo+ID5oZWFsdGhfc3RhdGUpOw0KPiAr
CXJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZA0KPiArZGV2bGlua19oZWFsdGhf
cmVwb3J0ZXJfcmVjb3Zlcl93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gK3sNCj4g
KwlzdHJ1Y3QgZGV2bGlua19oZWFsdGhfcmVwb3J0ZXIgKnJlcG9ydGVyOw0KPiArDQo+ICsJcmVw
b3J0ZXIgPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGRldmxpbmtfaGVhbHRoX3JlcG9ydGVy
LA0KPiArCQkJCXJlY292ZXJfd29yayk7DQo+ICsNCj4gKwlkZXZsaW5rX2hlYWx0aF9yZXBvcnRl
cl9yZWNvdmVyKHJlcG9ydGVyLCBOVUxMKTsNCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAgKglkZXZs
aW5rX2hlYWx0aF9yZXBvcnRlcl9jcmVhdGUgLSBjcmVhdGUgZGV2bGluayBoZWFsdGggcmVwb3J0
ZXINCj4gICAqDQo+IEBAIC00NDgzLDYgKzQ1MTgsOCBAQCBzdHJ1Y3QgZGV2bGlua19oZWFsdGhf
cmVwb3J0ZXIgKg0KPiAgCXJlcG9ydGVyLT5kZXZsaW5rID0gZGV2bGluazsNCj4gIAlyZXBvcnRl
ci0+Z3JhY2VmdWxfcGVyaW9kID0gZ3JhY2VmdWxfcGVyaW9kOw0KPiAgCXJlcG9ydGVyLT5hdXRv
X3JlY292ZXIgPSBhdXRvX3JlY292ZXI7DQo+ICsJSU5JVF9XT1JLKCZyZXBvcnRlci0+cmVjb3Zl
cl93b3JrLA0KPiArCQkgIGRldmxpbmtfaGVhbHRoX3JlcG9ydGVyX3JlY292ZXJfd29yayk7DQo+
ICAJbXV0ZXhfaW5pdCgmcmVwb3J0ZXItPmR1bXBfbG9jayk7DQo+ICAJbGlzdF9hZGRfdGFpbCgm
cmVwb3J0ZXItPmxpc3QsICZkZXZsaW5rLT5yZXBvcnRlcl9saXN0KTsNCj4gIHVubG9jazoNCj4g
QEAgLTQ1MDUsNiArNDU0Miw3IEBAIHN0cnVjdCBkZXZsaW5rX2hlYWx0aF9yZXBvcnRlciAqDQo+
ICAJbXV0ZXhfdW5sb2NrKCZyZXBvcnRlci0+ZGV2bGluay0+bG9jayk7DQo+ICAJaWYgKHJlcG9y
dGVyLT5kdW1wX2Ztc2cpDQo+ICAJCWRldmxpbmtfZm1zZ19mcmVlKHJlcG9ydGVyLT5kdW1wX2Zt
c2cpOw0KPiArCWNhbmNlbF93b3JrX3N5bmMoJnJlcG9ydGVyLT5yZWNvdmVyX3dvcmspOw0KPiAg
CWtmcmVlKHJlcG9ydGVyKTsNCj4gIH0NCj4gIEVYUE9SVF9TWU1CT0xfR1BMKGRldmxpbmtfaGVh
bHRoX3JlcG9ydGVyX2Rlc3Ryb3kpOw0KPiBAQCAtNDUyNiwyNiArNDU2NCw2IEBAIHN0cnVjdCBk
ZXZsaW5rX2hlYWx0aF9yZXBvcnRlciAqDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MX0dQTChkZXZs
aW5rX2hlYWx0aF9yZXBvcnRlcl9zdGF0ZV91cGRhdGUpOw0KPiAgDQo+IC1zdGF0aWMgaW50DQo+
IC1kZXZsaW5rX2hlYWx0aF9yZXBvcnRlcl9yZWNvdmVyKHN0cnVjdCBkZXZsaW5rX2hlYWx0aF9y
ZXBvcnRlcg0KPiAqcmVwb3J0ZXIsDQo+IC0JCQkJdm9pZCAqcHJpdl9jdHgpDQo+IC17DQo+IC0J
aW50IGVycjsNCj4gLQ0KPiAtCWlmICghcmVwb3J0ZXItPm9wcy0+cmVjb3ZlcikNCj4gLQkJcmV0
dXJuIC1FT1BOT1RTVVBQOw0KPiAtDQo+IC0JZXJyID0gcmVwb3J0ZXItPm9wcy0+cmVjb3Zlcihy
ZXBvcnRlciwgcHJpdl9jdHgpOw0KPiAtCWlmIChlcnIpDQo+IC0JCXJldHVybiBlcnI7DQo+IC0N
Cj4gLQlyZXBvcnRlci0+cmVjb3ZlcnlfY291bnQrKzsNCj4gLQlyZXBvcnRlci0+aGVhbHRoX3N0
YXRlID0gREVWTElOS19IRUFMVEhfUkVQT1JURVJfU1RBVEVfSEVBTFRIWTsNCj4gLQlyZXBvcnRl
ci0+bGFzdF9yZWNvdmVyeV90cyA9IGppZmZpZXM7DQo+IC0NCj4gLQlyZXR1cm4gMDsNCj4gLX0N
Cj4gLQ0KPiAgc3RhdGljIHZvaWQNCj4gIGRldmxpbmtfaGVhbHRoX2R1bXBfY2xlYXIoc3RydWN0
IGRldmxpbmtfaGVhbHRoX3JlcG9ydGVyICpyZXBvcnRlcikNCj4gIHsNCj4gQEAgLTQ4MTMsNyAr
NDgzMSwxMSBAQCBzdGF0aWMgaW50DQo+IGRldmxpbmtfbmxfY21kX2hlYWx0aF9yZXBvcnRlcl9y
ZWNvdmVyX2RvaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gIAlpZiAoIXJlcG9ydGVyKQ0KPiAg
CQlyZXR1cm4gLUVJTlZBTDsNCj4gIA0KPiAtCXJldHVybiBkZXZsaW5rX2hlYWx0aF9yZXBvcnRl
cl9yZWNvdmVyKHJlcG9ydGVyLCBOVUxMKTsNCj4gKwlpZiAoIXJlcG9ydGVyLT5vcHMtPnJlY292
ZXIpDQo+ICsJCXJldHVybiAtRU9QTk9UU1VQUDsNCj4gKw0KPiArCXF1ZXVlX3dvcmsoZGV2bGlu
ay0+cmVwb3J0ZXJzX3dxLCAmcmVwb3J0ZXItPnJlY292ZXJfd29yayk7DQo+ICsJcmV0dXJuIDA7
DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgZGV2bGlua19ubF9jbWRfaGVhbHRoX3JlcG9ydGVy
X2RpYWdub3NlX2RvaXQoc3RydWN0DQo+IHNrX2J1ZmYgKnNrYiwNCj4gQEAgLTUyMzQsNiArNTI1
NiwxMSBAQCBzdHJ1Y3QgZGV2bGluayAqZGV2bGlua19hbGxvYyhjb25zdCBzdHJ1Y3QNCj4gZGV2
bGlua19vcHMgKm9wcywgc2l6ZV90IHByaXZfc2l6ZSkNCj4gIAlJTklUX0xJU1RfSEVBRCgmZGV2
bGluay0+cGFyYW1fbGlzdCk7DQo+ICAJSU5JVF9MSVNUX0hFQUQoJmRldmxpbmstPnJlZ2lvbl9s
aXN0KTsNCj4gIAlJTklUX0xJU1RfSEVBRCgmZGV2bGluay0+cmVwb3J0ZXJfbGlzdCk7DQo+ICsJ
ZGV2bGluay0+cmVwb3J0ZXJzX3dxID0NCj4gY3JlYXRlX3NpbmdsZXRocmVhZF93b3JrcXVldWUo
ImRldmxpbmtfcmVwb3J0ZXJzIik7DQo+ICsJaWYgKCFkZXZsaW5rLT5yZXBvcnRlcnNfd3EpIHsN
Cj4gKwkJa2ZyZWUoZGV2bGluayk7DQo+ICsJCXJldHVybiBOVUxMOw0KPiArCX0NCj4gIAltdXRl
eF9pbml0KCZkZXZsaW5rLT5sb2NrKTsNCj4gIAlyZXR1cm4gZGV2bGluazsNCj4gIH0NCj4gQEAg
LTUyNzgsNiArNTMwNSw3IEBAIHZvaWQgZGV2bGlua191bnJlZ2lzdGVyKHN0cnVjdCBkZXZsaW5r
DQo+ICpkZXZsaW5rKQ0KPiAgdm9pZCBkZXZsaW5rX2ZyZWUoc3RydWN0IGRldmxpbmsgKmRldmxp
bmspDQo+ICB7DQo+ICAJbXV0ZXhfZGVzdHJveSgmZGV2bGluay0+bG9jayk7DQo+ICsJZGVzdHJv
eV93b3JrcXVldWUoZGV2bGluay0+cmVwb3J0ZXJzX3dxKTsNCj4gIAlXQVJOX09OKCFsaXN0X2Vt
cHR5KCZkZXZsaW5rLT5yZXBvcnRlcl9saXN0KSk7DQo+ICAJV0FSTl9PTighbGlzdF9lbXB0eSgm
ZGV2bGluay0+cmVnaW9uX2xpc3QpKTsNCj4gIAlXQVJOX09OKCFsaXN0X2VtcHR5KCZkZXZsaW5r
LT5wYXJhbV9saXN0KSk7DQo=
