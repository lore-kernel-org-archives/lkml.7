Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E4EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38BA22183E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="uoGFjfLY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733286AbfDXV1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:27:13 -0400
Received: from mail-eopbgr130094.outbound.protection.outlook.com ([40.107.13.94]:52854
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731185AbfDXV1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46QVaWZTSJjUBx0dVq5ZYUSQSt6HiARVwajE/PBQcj0=;
 b=uoGFjfLYBRKw7XdOw40RJKtms2C6o60UVfURutvzKimG9TxL0Lx1XcPpzk6P8KriqsaYbtk54w2KyM9pu7Nu8T3NEiV5ofb6hl9cIsepIoyrxWd2CT8W5101Jb2cCwnU2bO1E3OA8/uJs5dwnwDDA+FxaAyfPZtqL5l31xMIMJ4=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3901.eurprd02.prod.outlook.com (20.177.58.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 21:27:05 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:27:05 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>
CC:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] i2c-mux-gpio: Create of-based GPIOs request method
Thread-Topic: [PATCH 5/5] i2c-mux-gpio: Create of-based GPIOs request method
Thread-Index: AQHU+poTLAESzsYGb0qLzQnMMc8VK6ZL07SA
Date:   Wed, 24 Apr 2019 21:27:05 +0000
Message-ID: <32d6a836-144a-a677-225f-a90d30a5c427@axentia.se>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-6-fancer.lancer@gmail.com>
In-Reply-To: <20190424123414.25311-6-fancer.lancer@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0901CA0060.eurprd09.prod.outlook.com
 (2603:10a6:3:45::28) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7fa03b8-af9d-4117-abd5-08d6c8fb991d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB3901;
x-ms-traffictypediagnostic: VI1PR02MB3901:
x-microsoft-antispam-prvs: <VI1PR02MB3901BFDFC848E64296AF5AD7BC3C0@VI1PR02MB3901.eurprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(366004)(376002)(199004)(189003)(25786009)(68736007)(52116002)(256004)(14444005)(486006)(76176011)(8936002)(110136005)(81156014)(6246003)(81166006)(54906003)(74482002)(64126003)(14454004)(4326008)(8676002)(316002)(6512007)(99286004)(508600001)(5660300002)(66556008)(66446008)(26005)(64756008)(86362001)(6486002)(3846002)(102836004)(2906002)(6116002)(58126008)(66946007)(66476007)(65826007)(36756003)(6436002)(305945005)(31696002)(186003)(73956011)(31686004)(11346002)(476003)(97736004)(2616005)(65956001)(71190400001)(6506007)(65806001)(71200400001)(446003)(53546011)(7736002)(386003)(66066001)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3901;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4SnuOLVo/xvZa31J/z8cCAU3Q+o+vyNd/TTvhk+6gABua13jbVXg5ruRjk4OJQCNnM81xVxFyOITDmEie3+1C5XnZagxVh9fS/KBr36nCuj6wIzqmuA1LMSpVC5bwTuoLwZe/cfQ4pQtTXUvgiqxKGbLAyNk7TcvLGtj3qptOt1r+gNJIF12AOaPKWK/2g76OaR3VDARrbLNzb7YSqe+0wQYtVlYnO3XufTxpwUrvj4CMgrm177fVhgyGmrGoG7gG+GYs+Yhe/QKKfPad4IJZXeDvGnqqZmTKS67GUhFETIuGwEjrN4z6xgELiZNNBe2Y+FyHM3f/hdJfyaZy9IaHLMwuKjkpdy3puMzFfjZOIzHIdhQzsKrtar7xPwnXwA0JeAxEtJzKaQKPKkXyq7GCI9ha7Pn23pWUmSQDU9NNKg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9E98BDD57F35B4283EEA154CE442876@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fa03b8-af9d-4117-abd5-08d6c8fb991d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:27:05.3410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNCAxNDozNCwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE1vc3QgbW9kZXJuIHBs
YXRmb3JtcyBwcm92aWRlIGEgZHRzIHdpdGggZGVzY3JpcHRpb24gb2YgdGhlIGRldmljZXMNCj4g
YXZhaWxhYmxlIGluIHRoZSBzeXN0ZW0uIEl0IG1heSBhbHNvIGluY2x1ZGUgaTJjLWdwaW8tbXV4
J2VzLg0KPiBVcCB1bnRpbCBub3cgdGhlIGkyYy1tdXgtZ3BpbyBkcml2ZXIgc3VwcG9ydGVkIGl0
JyBkdHMgbm9kZXMsIGJ1dA0KPiBwZXJmb3JtZWQgdGhlIEdQSU9zIHJlcXVlc3QgYnkgbWVhbnMg
b2YgbGVnYWN5IEdQSU8gQVBJLCB3aGljaCBieSBkZXNpZ24NCj4gYW5kIGR1ZSB0byBiZWluZyBs
ZWdhY3kgZG9lc24ndCBrbm93IGFueXRoaW5nIGFib3V0IG9mL2R0Yi9mZHQvZHRzIHN0dWZmLg0K
PiBJdCBtZWFucyBldmVuIHRob3VnaCB0aGUgaTJjLWdwaW8tbXV4IGR0cyBub2RlcyBhcmUgc3Vj
Y2Vzc2Z1bGx5IG1hcHBlZA0KPiB0byB0aGUga2VybmVsIGkyYy1tdXggZGV2aWNlcywgdGhlIEdQ
SU9zIHVzZWQgZm9yIGluaXRpYWxpemF0aW9uIGFyZQ0KPiByZXF1ZXN0ZWQgd2l0aG91dCBPRl9H
UElPXyogZmxhZ3Mgc2V0dXAuIEl0IGNhdXNlcyBwcm9ibGVtcyBvbiB0aGUNCj4gcGxhdGZvcm1z
IHdoaWNoIGZ1bGx5IHJlbHkgb24gZHRzIGFuZCByZXNpZGUsIGZvciBpbnN0YW5jZSwNCj4gaTJj
LWdwaW8tbXV4ZXMgd2l0aCBhY3RpdmUgbG93IG9yIG9wZW4gZHJhaW4gR1BJT3MgY29ubmVjdGVk
Lg0KPiANCj4gSXQgaXMgZml4ZWQgYnkgaW1wbGVtZW50aW5nIGEgZGVkaWNhdGVkIG1ldGhvZCBm
b3IgZnVsbCBkdHMtYmFzZWQNCj4gR1BJT3MgcmVxdWVzdHMuIEl0IGlzIG1vc3RseSBzaW1pbGFy
IHRvIHRoZSBwbGF0Zm9ybSBvbmUsIGJ1dA0KPiB1dGlsaXplcyB0aGUgZ3Bpb2RfZ2V0X2Zyb21f
b2Zfbm9kZSgpIG1ldGhvZCB0byByZXF1ZXN0IHRoZSBHUElPcy4NCj4gDQo+IEZpbmFsbHkgdGhl
IHBsYXRmb3JtIGNvZGUgaTJjLWdwaW8tbXV4IGRldmljZXMgYXJlIGFsc28gc3VwcG9ydGVkLg0K
PiBTbyB0aGUgZmFsbGJhY2sgdG8gZHRiIGlzIHBlcmZvcm1lZCBvbmx5IGlmIGFycmF5IHdpdGgg
R1BJT3MgaXNuJ3QNCj4gZGV0ZWN0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZXJnZSBTZW1p
biA8ZmFuY2VyLmxhbmNlckBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pMmMvbXV4ZXMv
aTJjLW11eC1ncGlvLmMgfCA2NSArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtZ3Bpby5jIGIvZHJpdmVycy9p
MmMvbXV4ZXMvaTJjLW11eC1ncGlvLmMNCj4gaW5kZXggMzE3YzAxOWUxNDE1Li5lNWUxMGJhMzVh
ZDkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtZ3Bpby5jDQo+ICsr
KyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtZ3Bpby5jDQo+IEBAIC02NSw4ICs2NSw4IEBA
IHN0YXRpYyBpbnQgaTJjX211eF9ncGlvX3Byb2JlX2R0KHN0cnVjdCBncGlvbXV4ICptdXgsDQo+
ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiAgCXN0cnVj
dCBkZXZpY2Vfbm9kZSAqYWRhcHRlcl9ucCwgKmNoaWxkOw0KPiAgCXN0cnVjdCBpMmNfYWRhcHRl
ciAqYWRhcHRlcjsNCj4gLQl1bnNpZ25lZCAqdmFsdWVzLCAqZ3Bpb3M7DQo+IC0JaW50IGkgPSAw
LCByZXQ7DQo+ICsJdW5zaWduZWQgaW50ICp2YWx1ZXM7DQo+ICsJaW50IGkgPSAwOw0KPiAgDQo+
ICAJaWYgKCFucCkNCj4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+IEBAIC0xMDksMjQgKzEwOSw0OCBA
QCBzdGF0aWMgaW50IGkyY19tdXhfZ3Bpb19wcm9iZV9kdChzdHJ1Y3QgZ3Bpb211eCAqbXV4LA0K
PiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gIAl9DQo+ICANCj4gLQlncGlvcyA9IGRldm1fa2NhbGxv
YygmcGRldi0+ZGV2LA0KPiAtCQkJICAgICBtdXgtPmRhdGEubl9ncGlvcywgc2l6ZW9mKCptdXgt
PmRhdGEuZ3Bpb3MpLA0KPiAtCQkJICAgICBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoIWdwaW9zKSB7
DQo+IC0JCWRldl9lcnIoJnBkZXYtPmRldiwgIkNhbm5vdCBhbGxvY2F0ZSBncGlvcyBhcnJheSIp
Ow0KPiAtCQlyZXR1cm4gLUVOT01FTTsNCj4gLQl9DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgaTJjX211eF9ncGlvX3JlcXVlc3RfZHQoc3RydWN0IGdwaW9tdXggKm11
eCwNCj4gKwkJCQkJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKwlzdHJ1
Y3QgaTJjX211eF9jb3JlICptdXhjID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICsJ
c3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiArCXN0cnVjdCBp
MmNfYWRhcHRlciAqcm9vdDsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpncGlvX2RldjsNCj4gKwllbnVt
IGdwaW9kX2ZsYWdzIGRmbGFnczsNCj4gKwlpbnQgaSwgcmV0Ow0KPiArDQo+ICsJcm9vdCA9IGky
Y19yb290X2FkYXB0ZXIoJm11eGMtPnBhcmVudC0+ZGV2KTsNCj4gIA0KPiAgCWZvciAoaSA9IDA7
IGkgPCBtdXgtPmRhdGEubl9ncGlvczsgaSsrKSB7DQo+IC0JCXJldCA9IG9mX2dldF9uYW1lZF9n
cGlvKG5wLCAibXV4LWdwaW9zIiwgaSk7DQo+IC0JCWlmIChyZXQgPCAwKQ0KPiAtCQkJcmV0dXJu
IHJldDsNCj4gLQkJZ3Bpb3NbaV0gPSByZXQ7DQo+IC0JfQ0KPiArCQlpZiAobXV4LT5kYXRhLmlk
bGUgJiAoMSA8PCBpKSkNCj4gKwkJCWRmbGFncyA9IEdQSU9EX09VVF9ISUdIOw0KPiArCQllbHNl
DQo+ICsJCQlkZmxhZ3MgPSBHUElPRF9PVVRfTE9XOw0KPiArDQo+ICsJCW11eC0+Z3Bpb3NbaV0g
PSBncGlvZF9nZXRfZnJvbV9vZl9ub2RlKG5wLCAibXV4LWdwaW9zIiwgaSwNCj4gKwkJCQkJCSAg
ICAgICBkZmxhZ3MsICJpMmMtbXV4LWdwaW8iKTsNCj4gKwkJaWYgKElTX0VSUihtdXgtPmdwaW9z
W2ldKSkgew0KPiArCQkJcmV0ID0gUFRSX0VSUihtdXgtPmdwaW9zW2ldKTsNCj4gKwkJCWdvdG8g
ZXJyX3JlcXVlc3RfZ3BpbzsNCj4gKwkJfQ0KPiAgDQo+IC0JbXV4LT5kYXRhLmdwaW9zID0gZ3Bp
b3M7DQo+ICsJCWlmICghbXV4Yy0+bXV4X2xvY2tlZCkNCj4gKwkJCWNvbnRpbnVlOw0KPiArDQo+
ICsJCWdwaW9fZGV2ID0gJm11eC0+Z3Bpb3NbaV0tPmdkZXYtPmRldjsNCj4gKwkJbXV4Yy0+bXV4
X2xvY2tlZCA9IGkyY19yb290X2FkYXB0ZXIoZ3Bpb19kZXYpID09IHJvb3Q7DQo+ICsJfQ0KPiAg
DQo+ICAJcmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9yZXF1ZXN0X2dwaW86DQo+ICsJZm9yIChpLS07
IGkgPj0gMDsgaS0tKQ0KPiArCQlncGlvZF9mcmVlKG11eC0+Z3Bpb3NbaV0pOw0KPiArDQo+ICsJ
cmV0dXJuIHJldDsNCj4gIH0NCj4gICNlbHNlDQo+ICBzdGF0aWMgaW50IGkyY19tdXhfZ3Bpb19w
cm9iZV9kdChzdHJ1Y3QgZ3Bpb211eCAqbXV4LA0KPiBAQCAtMTM0LDYgKzE1OCwxMiBAQCBzdGF0
aWMgaW50IGkyY19tdXhfZ3Bpb19wcm9iZV9kdChzdHJ1Y3QgZ3Bpb211eCAqbXV4LA0KPiAgew0K
PiAgCXJldHVybiAtRUlOVkFMOw0KPiAgfQ0KPiArDQo+ICtzdGF0aWMgaW50IGkyY19tdXhfZ3Bp
b19yZXF1ZXN0X2R0KHN0cnVjdCBncGlvbXV4ICptdXgsDQo+ICsJCQkJCXN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpDQo+ICt7DQo+ICsJcmV0dXJuIC1FSU5WQUw7DQo+ICt9DQo+ICAjZW5k
aWYNCj4gIA0KPiAgc3RhdGljIGludCBpMmNfbXV4X2dwaW9fcHJvYmVfcGxhdChzdHJ1Y3QgZ3Bp
b211eCAqbXV4LA0KPiBAQCAtMTc0LDYgKzIwNCw5IEBAIHN0YXRpYyBpbnQgaTJjX211eF9ncGlv
X3JlcXVlc3RfcGxhdChzdHJ1Y3QgZ3Bpb211eCAqbXV4LA0KPiAgCXN0cnVjdCBkZXZpY2UgKmdw
aW9fZGV2Ow0KPiAgCWludCBpLCByZXQ7DQo+ICANCj4gKwlpZiAoIW11eC0+ZGF0YS5ncGlvcykN
Cj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gIAlyb290ID0gaTJjX3Jvb3RfYWRhcHRlcigm
bXV4Yy0+cGFyZW50LT5kZXYpOw0KPiAgDQo+ICAJZm9yIChpID0gMDsgaSA8IG11eC0+ZGF0YS5u
X2dwaW9zOyBpKyspIHsNCj4gQEAgLTI2Nyw2ICszMDAsOCBAQCBzdGF0aWMgaW50IGkyY19tdXhf
Z3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQltdXgtPmRhdGEu
aWRsZSA9IG11eC0+ZGF0YS52YWx1ZXNbMF07DQo+ICANCj4gIAlyZXQgPSBpMmNfbXV4X2dwaW9f
cmVxdWVzdF9wbGF0KG11eCwgcGRldik7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0ID0gaTJjX211
eF9ncGlvX3JlcXVlc3RfZHQobXV4LCBwZGV2KTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIGFs
bG9jX2ZhaWxlZDsNCg0KU2FtZSBwYXR0ZXJuIGFzIGZvciAyLzU7IGFueSBhbmQgYWxsIGVycm9y
cyBmcm9tIGkyY19tdXhfZ3Bpb19yZXF1ZXN0X3BsYXQNCmFyZSBub3cgbG9zdC4NCg0KQ2hlZXJz
LA0KUGV0ZXINCg0KPiAgDQo+IA0KDQo=
