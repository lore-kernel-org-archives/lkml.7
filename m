Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE02C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2BCB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="h7M4IPQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733174AbfDXV1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:27:09 -0400
Received: from mail-eopbgr130094.outbound.protection.outlook.com ([40.107.13.94]:52854
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731185AbfDXV1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIpsVbmu18BrAHCqzUBR2lu/CjYRIegDXXfl6xfSNa8=;
 b=h7M4IPQONKFFh1tIvtKEgj8rtSj/m0wi7eyerb82JqqKwW9Z9/c30e7hzaxZ1d4xe6HpHgtTHuUXMTzdhDyXIYkn+GRRie7Lr5ZD8lIC/uYigTmY8Ih94V7Ug8Aqo+YPlM0iE5SGY6rD8FyjJ3YSV+niwzTx901mp7dlsQPvuFM=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3901.eurprd02.prod.outlook.com (20.177.58.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 24 Apr 2019 21:26:23 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:26:23 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>
CC:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] i2c-mux-gpio: Save initial channel number to the idle
 data field
Thread-Topic: [PATCH 3/5] i2c-mux-gpio: Save initial channel number to the
 idle data field
Thread-Index: AQHU+poRXbeqxvDL/0m7jXZwdC2k26ZL04EA
Date:   Wed, 24 Apr 2019 21:26:22 +0000
Message-ID: <7c8d4751-f5f7-ee2a-c411-a985b81d61a3@axentia.se>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-4-fancer.lancer@gmail.com>
In-Reply-To: <20190424123414.25311-4-fancer.lancer@gmail.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0901CA0044.eurprd09.prod.outlook.com
 (2603:10a6:3:45::12) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 531353d6-c8a7-4689-3d41-08d6c8fb7fb5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB3901;
x-ms-traffictypediagnostic: VI1PR02MB3901:
x-microsoft-antispam-prvs: <VI1PR02MB3901B5189D8C8B555C6B0477BC3C0@VI1PR02MB3901.eurprd02.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39830400003)(366004)(376002)(199004)(189003)(25786009)(68736007)(52116002)(256004)(14444005)(486006)(76176011)(8936002)(110136005)(81156014)(6246003)(81166006)(54906003)(74482002)(64126003)(14454004)(4326008)(8676002)(316002)(6512007)(99286004)(508600001)(5660300002)(66556008)(66446008)(26005)(64756008)(86362001)(6486002)(3846002)(102836004)(2906002)(6116002)(58126008)(66946007)(66476007)(65826007)(36756003)(6436002)(305945005)(31696002)(186003)(73956011)(31686004)(11346002)(476003)(97736004)(2616005)(65956001)(71190400001)(6506007)(65806001)(71200400001)(446003)(53546011)(7736002)(386003)(66066001)(229853002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3901;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BEBH2vnlAbNYDiHFNpSw+EDjR3SZscZLzKgYOw4POd6rn27t8JO6s8mV+L9DTuZvPLIaO1/nQ38J8TGPtBJgxlr/Hzk18sVbDaXv7kCValX8HbFw/pFxWVKiv6TStjHty1xrcT1fg7n2hrQq9wk7bz4RJ09LsVAPWnAdQG6R+bK/IcZewNgfs7ZbeE1nyLbaCYZAQBOrzCJiRN9UyOjpdynDB02OSfe1W+fyXYW/W1WKnJweoz3SQwDfSN1JGnMn7lRV/+hqwWFl4NMu5QAfsSaFs3hJv0yYu/UYyyEyssjkgjmL6ec7OBX+Kqcl+vkbh7YYcJNOBOXRIXskAdiPEeBUwbhjSvVELlK0dfIKhMzDlyIL/qwbrMYpMTybIxIn775zJxn1T3S5IP45b81aoadyPXRL5fqGDwxf4CA/wbw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67676E233A9AFD4995D4FE9580058B3C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 531353d6-c8a7-4689-3d41-08d6c8fb7fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:26:23.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3901
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNCAxNDozNCwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IEluIGNhc2UgaWYgdGhl
IGlkbGUgc3RhdGUgaGFzIGJlZW4gc3BlY2lmaWVkIGluIHRoZSBkYXRhIHN0cnVjdHVyZSwNCj4g
dGhlIGlkbGUgdmFyaWFibGUgaXMgbGVmdCB1bnRvdWNoZWQgYXMgYmVmb3JlLCBzbyB0byBrZWVw
IGEgZGVmYXVsdA0KPiBjaGFubmVsIG51bWJlciBlbmFibGVkIGluIHRoZSBtdXggaWRsZSBzdGF0
ZS4gQnV0IGlmIGEgcGxhdGZvcm0gZG9lc24ndA0KPiBzcGVjaWZ5IHdoaWNoIGNoYW5uZWwgaXMg
Z29pbmcgdG8gYmUgZW5hYmxlZCBieSBkZWZhdWx0LCB3ZSBhcyBiZWZvcmUNCj4gZG9uJ3Qgc2V0
dXAgdGhlIGRlc2VsZWN0IGNhbGxiYWNrLCBidXQgdGhlIGluaXRpYWwgc3RhdGUgaXMgc2F2ZWQg
aW4gdGhlDQo+IGlkbGUgdmFyaWFibGUgZm9yIGZ1cnRoZXIgaW5pdGlhbGl6YXRpb24uIFdlIGNh
biBzYWZlbHkgZG8gdGhpcyBoZXJlDQo+IHNpbmNlIHRoYXQgdmFyaWFibGUgaXMgdXNlZCBmb3Ig
aW5pdGlhbCBzdGF0ZSBzZXR0aW5nIG9ubHksIHdoZW4gbm8NCj4gaWRsaW5nIGxhbmUgaXMgc3Bl
Y2lmaWVkLg0KDQpXaGlsZSB0aGlzIHN1YnRsZXR5IGlzICptYXliZSogb2ssIGEgY29tbWVudCBh
Ym91dCBpdCBiZWxvbmdzIGluIHRoZQ0KKmNvZGUqIHdoZXJlIGl0IHdpbGwgYmUgc2VlbiB3aGVu
IHRoZSBuZXh0IHBlcnNvbiBtYWtlcyBjaGFuZ2VzLg0KDQpCdXQgd2h5IG5vdCBleHRlbmQgdGhl
IHN0cnVjdCB3aXRoIHRoZSBpbml0aWFsIHN0YXRlPyBIb3cgbWFueSBvZg0KdGhlc2UgbXV4ZXMg
ZG8geW91IGV4cGVjdCB0byBleGlzdCBpbiBhIHN5c3RlbT8gTXVsdGlwbGllZCBieSBhDQpjb3Vw
bGUgb2YgYnl0ZXMuIFdobyBjYXJlcz8NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiANCj4gVGhlIHJl
YXNvbiBvZiB0aGlzIGNoYW5nZSBpcyB0byBwcmVwYXJlIHRoZSBjb2RlIGZvciBmdXR1cmUgR1BJ
T3MgcmVxdWVzdA0KPiBwYXRoIGJlaW5nIHNwbGl0IHVwIGludG8gb2YtIGFuZCBwbGF0LSBiYXNl
ZCBtZXRob2RzLiBUaGUgaWRsZSB2YXJpYWJsZQ0KPiBoZXJlIGlzIHVzZWQgYXMgYSBjb250YWlu
ZXIgb2YgdGhlIGluaXRpYWwgc3RhdGUgZm9yIGJvdGggb2YgdGhlIHBhdGhzIGluDQo+IGNhc2Ug
b2YgaWRsZS1jaGFubmVsIGlzbid0IHNwZWNpZmllZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNl
cmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2ky
Yy9tdXhlcy9pMmMtbXV4LWdwaW8uYyB8IDE1ICsrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8uYyBiL2RyaXZlcnMvaTJjL211eGVzL2ky
Yy1tdXgtZ3Bpby5jDQo+IGluZGV4IGExNGZlMTMyYjBjMy4uNTM1YzgzYzQzMzcxIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8uYw0KPiArKysgYi9kcml2ZXJz
L2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8uYw0KPiBAQCAtMTcxLDcgKzE3MSw2IEBAIHN0YXRpYyBp
bnQgaTJjX211eF9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJ
c3RydWN0IGdwaW9tdXggKm11eDsNCj4gIAlzdHJ1Y3QgaTJjX2FkYXB0ZXIgKnBhcmVudDsNCj4g
IAlzdHJ1Y3QgaTJjX2FkYXB0ZXIgKnJvb3Q7DQo+IC0JdW5zaWduZWQgaW5pdGlhbF9zdGF0ZTsN
Cj4gIAlpbnQgaSwgcmV0Ow0KPiAgDQo+ICAJbXV4ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYs
IHNpemVvZigqbXV4KSwgR0ZQX0tFUk5FTCk7DQo+IEBAIC0yMDQsMTIgKzIwMywxNCBAQCBzdGF0
aWMgaW50IGkyY19tdXhfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
PiAgDQo+ICAJbXV4Yy0+bXV4X2xvY2tlZCA9IHRydWU7DQo+ICANCj4gLQlpZiAobXV4LT5kYXRh
LmlkbGUgIT0gSTJDX01VWF9HUElPX05PX0lETEUpIHsNCj4gLQkJaW5pdGlhbF9zdGF0ZSA9IG11
eC0+ZGF0YS5pZGxlOw0KPiArCS8qDQo+ICsJICogU2V0IGRlc2NlbGVjdCBjYWxsYmFjayBpZiBp
ZGxlIHN0YXRlIGhhcyBiZWVuIHNldHVwIG90aGVyd2lzZSBqdXN0DQo+ICsJICogdXNlIHRoZSBp
ZGxlIHZhcmlhYmxlIHRvIHN0b3JlIHRoZSBpbml0aWFsIG11eGVyIHZhbHVlLg0KPiArCSAqLw0K
PiArCWlmIChtdXgtPmRhdGEuaWRsZSAhPSBJMkNfTVVYX0dQSU9fTk9fSURMRSkNCj4gIAkJbXV4
Yy0+ZGVzZWxlY3QgPSBpMmNfbXV4X2dwaW9fZGVzZWxlY3Q7DQo+IC0JfSBlbHNlIHsNCj4gLQkJ
aW5pdGlhbF9zdGF0ZSA9IG11eC0+ZGF0YS52YWx1ZXNbMF07DQo+IC0JfQ0KPiArCWVsc2UNCj4g
KwkJbXV4LT5kYXRhLmlkbGUgPSBtdXgtPmRhdGEudmFsdWVzWzBdOw0KPiAgDQo+ICAJZm9yIChp
ID0gMDsgaSA8IG11eC0+ZGF0YS5uX2dwaW9zOyBpKyspIHsNCj4gIAkJc3RydWN0IGRldmljZSAq
Z3Bpb19kZXY7DQo+IEBAIC0yMjQsNyArMjI1LDcgQEAgc3RhdGljIGludCBpMmNfbXV4X2dwaW9f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJfQ0KPiAgDQo+ICAJCXJl
dCA9IGdwaW9fZGlyZWN0aW9uX291dHB1dChtdXgtPmdwaW9fYmFzZSArIG11eC0+ZGF0YS5ncGlv
c1tpXSwNCj4gLQkJCQkJICAgIGluaXRpYWxfc3RhdGUgJiAoMSA8PCBpKSk7DQo+ICsJCQkJCSAg
ICBtdXgtPmRhdGEuaWRsZSAmICgxIDw8IGkpKTsNCj4gIAkJaWYgKHJldCkgew0KPiAgCQkJZGV2
X2VycigmcGRldi0+ZGV2LA0KPiAgCQkJCSJGYWlsZWQgdG8gc2V0IGRpcmVjdGlvbiBvZiBHUElP
ICVkIHRvIG91dHB1dFxuIiwNCj4gDQoNCg==
