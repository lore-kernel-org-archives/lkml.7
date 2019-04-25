Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A1E9C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA4D20685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="dMETGq7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfDYTcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:32:14 -0400
Received: from mail-eopbgr140122.outbound.protection.outlook.com ([40.107.14.122]:16846
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbfDYTcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlDhDYT/8+2r2ZSZanpQBX3ylEdM0qgkMBlkHaV9nGM=;
 b=dMETGq7VutrP/Xluiu4r/w3KooNxb7Xh3Uaoa5wWlvLSGFTiloF6ZodudbhgSsBpk/v79SOy6jPgOUDJ7dC4w+fdMDI7t0vsX9TqIeXditE5aHEerKMMOmlzI8Ydlc5pdBWPN85Dht4RLF8PGmM2ZLS14cxeqvx1Br40Dj1uuwM=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4096.eurprd02.prod.outlook.com (20.177.58.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 19:32:10 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 19:32:10 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] i2c-mux-gpio: Save initial channel number to the idle
 data field
Thread-Topic: [PATCH 3/5] i2c-mux-gpio: Save initial channel number to the
 idle data field
Thread-Index: AQHU+poRXbeqxvDL/0m7jXZwdC2k26ZL04EAgAE1VACAAD0YAA==
Date:   Thu, 25 Apr 2019 19:32:10 +0000
Message-ID: <c30abb31-f6f1-f789-7735-8b11b5d8d4fc@axentia.se>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-4-fancer.lancer@gmail.com>
 <7c8d4751-f5f7-ee2a-c411-a985b81d61a3@axentia.se>
 <20190425155325.voqlrmbdblo7xhtx@mobilestation>
In-Reply-To: <20190425155325.voqlrmbdblo7xhtx@mobilestation>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0231.eurprd05.prod.outlook.com
 (2603:10a6:3:fa::31) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fddad7e8-0b75-4885-fcf7-08d6c9b4b5aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB4096;
x-ms-traffictypediagnostic: VI1PR02MB4096:
x-microsoft-antispam-prvs: <VI1PR02MB40966A8EAD3F894ABBD598E1BC3D0@VI1PR02MB4096.eurprd02.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(2616005)(11346002)(446003)(476003)(486006)(71190400001)(31686004)(6246003)(97736004)(186003)(26005)(25786009)(76176011)(52116002)(386003)(6506007)(102836004)(53546011)(4326008)(66556008)(66476007)(81166006)(81156014)(66446008)(73956011)(66066001)(64756008)(65806001)(65956001)(6916009)(64126003)(93886005)(8936002)(256004)(8676002)(14444005)(74482002)(6486002)(229853002)(6436002)(65826007)(66946007)(31696002)(86362001)(71200400001)(99286004)(316002)(2906002)(58126008)(54906003)(36756003)(5660300002)(7736002)(305945005)(68736007)(508600001)(14454004)(6512007)(53936002)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4096;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fZMu0wM8BYWyX2ERRQinxtHZzT+Mbq83FQ9GwS3Y0PQQ7MVtvf1XVuUSkBNPlU8b5YwGmuGk8wi8M65l7GjVBnfOXN+6Z7ftoLtj8R3LAyp9KCpuC+B175nDtuqfHaL7Y3YtjqnEFcAdrETfpBJZNAZ51R3nKgOhADq6+/KjK9rb9e7ny1B+m9Syvxt7Jfri7DVKSPEEbPBolwYSHFmBHT03z7Y7Xeh1FEM4PG1X0HETCryBC/l6Uk4PYy5jbzdJvp8YXc//PZl3vIvdI+iOsUWutqiKEkMUvSzxgj0rVf75bdCqhWMH7knVSXjEjwsjBlJoUhNCxYlNww9QYOTkmAp7tUP1RT6WPx/bvUfEAyqWNrvAm12ynx+nfObrluEHDkGeqVy/4SlZhGP95UTOcIQXKOPGfOMKVS8Dex7K0hE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EF4F2A1BFB4F943BB45A3A65C0244C1@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: fddad7e8-0b75-4885-fcf7-08d6c9b4b5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 19:32:10.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNSAxNzo1MywgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIFdlZCwgQXByIDI0
LCAyMDE5IGF0IDA5OjI2OjIyUE0gKzAwMDAsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4gT24gMjAx
OS0wNC0yNCAxNDozNCwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+Pj4gSW4gY2FzZSBpZiB0aGUgaWRs
ZSBzdGF0ZSBoYXMgYmVlbiBzcGVjaWZpZWQgaW4gdGhlIGRhdGEgc3RydWN0dXJlLA0KPj4+IHRo
ZSBpZGxlIHZhcmlhYmxlIGlzIGxlZnQgdW50b3VjaGVkIGFzIGJlZm9yZSwgc28gdG8ga2VlcCBh
IGRlZmF1bHQNCj4+PiBjaGFubmVsIG51bWJlciBlbmFibGVkIGluIHRoZSBtdXggaWRsZSBzdGF0
ZS4gQnV0IGlmIGEgcGxhdGZvcm0gZG9lc24ndA0KPj4+IHNwZWNpZnkgd2hpY2ggY2hhbm5lbCBp
cyBnb2luZyB0byBiZSBlbmFibGVkIGJ5IGRlZmF1bHQsIHdlIGFzIGJlZm9yZQ0KPj4+IGRvbid0
IHNldHVwIHRoZSBkZXNlbGVjdCBjYWxsYmFjaywgYnV0IHRoZSBpbml0aWFsIHN0YXRlIGlzIHNh
dmVkIGluIHRoZQ0KPj4+IGlkbGUgdmFyaWFibGUgZm9yIGZ1cnRoZXIgaW5pdGlhbGl6YXRpb24u
IFdlIGNhbiBzYWZlbHkgZG8gdGhpcyBoZXJlDQo+Pj4gc2luY2UgdGhhdCB2YXJpYWJsZSBpcyB1
c2VkIGZvciBpbml0aWFsIHN0YXRlIHNldHRpbmcgb25seSwgd2hlbiBubw0KPj4+IGlkbGluZyBs
YW5lIGlzIHNwZWNpZmllZC4NCj4+DQo+PiBXaGlsZSB0aGlzIHN1YnRsZXR5IGlzICptYXliZSog
b2ssIGEgY29tbWVudCBhYm91dCBpdCBiZWxvbmdzIGluIHRoZQ0KPj4gKmNvZGUqIHdoZXJlIGl0
IHdpbGwgYmUgc2VlbiB3aGVuIHRoZSBuZXh0IHBlcnNvbiBtYWtlcyBjaGFuZ2VzLg0KPj4NCj4+
IEJ1dCB3aHkgbm90IGV4dGVuZCB0aGUgc3RydWN0IHdpdGggdGhlIGluaXRpYWwgc3RhdGU/IEhv
dyBtYW55IG9mDQo+PiB0aGVzZSBtdXhlcyBkbyB5b3UgZXhwZWN0IHRvIGV4aXN0IGluIGEgc3lz
dGVtPyBNdWx0aXBsaWVkIGJ5IGENCj4+IGNvdXBsZSBvZiBieXRlcy4gV2hvIGNhcmVzPw0KPj4N
Cj4gDQo+IEkgYWN0dWFsbHkgdGhvdWdodCBhYm91dCB0aGlzIHdoZW4gc3RhcnRlZCB3b3JraW5n
IG9uIHRoZSBwYXRjaHNldC4NCj4gVGhhdCB0aW1lIHNhdmluZyB0aGUgaW5pdGlhbCB2YWx1ZSBp
biB0aGUgaWRsZSB2YXJpYWJsZSBzZWVtZWQgbGlrZSBhDQo+IGdvb2QgaWRlYS4gSSBldmVuIHB1
dCBhIHNtYWxsIGNvbW1lbnQgaW4gdGhlIGNvZGUgYWJvdXQgdGhpcy4NCg0KT2gsIEkgbWlzc2Vk
IHRoYXQuIENyYXAsIGFuZCBzb3JyeSENCg0KPiBBbnl3YXkgbGV0cyBhZGQgYSBuZXcgZmllbGQg
dG8gInN0cnVjdCBncGlvbXV4IiBzdHJ1Y3R1cmUgYW5kIHVzZQ0KPiBpdCBhcyBhIGNvbnRhaW5l
ciBmb3IgaW5pdGlhbCB2YWx1ZS4gSXQgaXMgYWxzbyBhIGdvb2QgYWx0ZXJuYXRpdmUuDQo+IEkn
bGwgZG8gdGhpcyBpbiBhIHYyIHBhdGNoc2V0Lg0KDQpHb29kLiBUaGFua3MhDQoNCkNoZWVycywN
ClBldGVyDQoNCj4gLVNlcmdleQ0KPiANCj4+IENoZWVycywNCj4+IFBldGVyDQo+Pg0KPj4+DQo+
Pj4gVGhlIHJlYXNvbiBvZiB0aGlzIGNoYW5nZSBpcyB0byBwcmVwYXJlIHRoZSBjb2RlIGZvciBm
dXR1cmUgR1BJT3MgcmVxdWVzdA0KPj4+IHBhdGggYmVpbmcgc3BsaXQgdXAgaW50byBvZi0gYW5k
IHBsYXQtIGJhc2VkIG1ldGhvZHMuIFRoZSBpZGxlIHZhcmlhYmxlDQo+Pj4gaGVyZSBpcyB1c2Vk
IGFzIGEgY29udGFpbmVyIG9mIHRoZSBpbml0aWFsIHN0YXRlIGZvciBib3RoIG9mIHRoZSBwYXRo
cyBpbg0KPj4+IGNhc2Ugb2YgaWRsZS1jaGFubmVsIGlzbid0IHNwZWNpZmllZC4NCj4+Pg0KPj4+
IFNpZ25lZC1vZmYtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCj4+
PiAtLS0NCj4+PiAgZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1ncGlvLmMgfCAxNSArKysrKysr
Ky0tLS0tLS0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdw
aW8uYyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtZ3Bpby5jDQo+Pj4gaW5kZXggYTE0ZmUx
MzJiMGMzLi41MzVjODNjNDMzNzEgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9pMmMvbXV4ZXMv
aTJjLW11eC1ncGlvLmMNCj4+PiArKysgYi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4LWdwaW8u
Yw0KPj4+IEBAIC0xNzEsNyArMTcxLDYgQEAgc3RhdGljIGludCBpMmNfbXV4X2dwaW9fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+PiAgCXN0cnVjdCBncGlvbXV4ICptdXg7
DQo+Pj4gIAlzdHJ1Y3QgaTJjX2FkYXB0ZXIgKnBhcmVudDsNCj4+PiAgCXN0cnVjdCBpMmNfYWRh
cHRlciAqcm9vdDsNCj4+PiAtCXVuc2lnbmVkIGluaXRpYWxfc3RhdGU7DQo+Pj4gIAlpbnQgaSwg
cmV0Ow0KPj4+ICANCj4+PiAgCW11eCA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBzaXplb2Yo
Km11eCksIEdGUF9LRVJORUwpOw0KPj4+IEBAIC0yMDQsMTIgKzIwMywxNCBAQCBzdGF0aWMgaW50
IGkyY19tdXhfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAN
Cj4+PiAgCW11eGMtPm11eF9sb2NrZWQgPSB0cnVlOw0KPj4+ICANCj4+PiAtCWlmIChtdXgtPmRh
dGEuaWRsZSAhPSBJMkNfTVVYX0dQSU9fTk9fSURMRSkgew0KPj4+IC0JCWluaXRpYWxfc3RhdGUg
PSBtdXgtPmRhdGEuaWRsZTsNCj4+PiArCS8qDQo+Pj4gKwkgKiBTZXQgZGVzY2VsZWN0IGNhbGxi
YWNrIGlmIGlkbGUgc3RhdGUgaGFzIGJlZW4gc2V0dXAgb3RoZXJ3aXNlIGp1c3QNCg0KU3BlbGxp
bmcgImRlc2VsZWN0Ig0KDQo+Pj4gKwkgKiB1c2UgdGhlIGlkbGUgdmFyaWFibGUgdG8gc3RvcmUg
dGhlIGluaXRpYWwgbXV4ZXIgdmFsdWUuDQo+Pj4gKwkgKi8NCj4+PiArCWlmIChtdXgtPmRhdGEu
aWRsZSAhPSBJMkNfTVVYX0dQSU9fTk9fSURMRSkNCj4+PiAgCQltdXhjLT5kZXNlbGVjdCA9IGky
Y19tdXhfZ3Bpb19kZXNlbGVjdDsNCj4+PiAtCX0gZWxzZSB7DQo+Pj4gLQkJaW5pdGlhbF9zdGF0
ZSA9IG11eC0+ZGF0YS52YWx1ZXNbMF07DQo+Pj4gLQl9DQo+Pj4gKwllbHNlDQo+Pj4gKwkJbXV4
LT5kYXRhLmlkbGUgPSBtdXgtPmRhdGEudmFsdWVzWzBdOw0KPj4+ICANCj4+PiAgCWZvciAoaSA9
IDA7IGkgPCBtdXgtPmRhdGEubl9ncGlvczsgaSsrKSB7DQo+Pj4gIAkJc3RydWN0IGRldmljZSAq
Z3Bpb19kZXY7DQo+Pj4gQEAgLTIyNCw3ICsyMjUsNyBAQCBzdGF0aWMgaW50IGkyY19tdXhfZ3Bp
b19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAJCX0NCj4+PiAgDQo+
Pj4gIAkJcmV0ID0gZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KG11eC0+Z3Bpb19iYXNlICsgbXV4LT5k
YXRhLmdwaW9zW2ldLA0KPj4+IC0JCQkJCSAgICBpbml0aWFsX3N0YXRlICYgKDEgPDwgaSkpOw0K
Pj4+ICsJCQkJCSAgICBtdXgtPmRhdGEuaWRsZSAmICgxIDw8IGkpKTsNCj4+PiAgCQlpZiAocmV0
KSB7DQo+Pj4gIAkJCWRldl9lcnIoJnBkZXYtPmRldiwNCj4+PiAgCQkJCSJGYWlsZWQgdG8gc2V0
IGRpcmVjdGlvbiBvZiBHUElPICVkIHRvIG91dHB1dFxuIiwNCj4+Pg0KPj4NCg0K
