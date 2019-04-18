Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1172C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528B72184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="WGaJUsG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbfDRGVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:21:45 -0400
Received: from mail-eopbgr70124.outbound.protection.outlook.com ([40.107.7.124]:13378
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfDRGVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X++eWkeRc1WUFlSovPoIE8f8hksn3AclA2Cil8Qi+pE=;
 b=WGaJUsG+REj3IPZXHtWSLbnz5deeA1JKp+qDF/nVStFh/ZFpk1B2VSWhdEFaG6nqihXCcvMgCQu9thd5i8YyfoDGi6eHBJJqiDYocG7CzpdGcrIxjYolkj7sCTTeQvYI6z19ZXNyV0as47WLdIjnRSC6SiAvLxV7bdioNMJTRkE=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4799.eurprd02.prod.outlook.com (20.177.200.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 06:21:37 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1792.018; Thu, 18 Apr 2019
 06:21:37 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Ray Jui <ray.jui@broadcom.com>, Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Topic: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
Thread-Index: AQHU6mEE3VBQWFg3OEO4UFCMK2X3RqY5U5QAgAOpzgCABB38AIAAbdAA
Date:   Thu, 18 Apr 2019 06:21:37 +0000
Message-ID: <497d0668-3065-a357-72ca-a7e79fc9cfb0@axentia.se>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
 <f28f604a-55a4-7542-0e13-a92a83ab2144@axentia.se>
 <c47c6ec2-6d6f-8885-932c-35390783f55b@axentia.se>
 <bd0c7b0f-1936-dd1e-b8f3-ebafebdea252@broadcom.com>
In-Reply-To: <bd0c7b0f-1936-dd1e-b8f3-ebafebdea252@broadcom.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR0902CA0024.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::34) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa7b9f30-cdaa-4d56-7681-08d6c3c61caf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB4799;
x-ms-traffictypediagnostic: VI1PR02MB4799:
x-microsoft-antispam-prvs: <VI1PR02MB47998A8C191AB93F3A3F4B8CBC260@VI1PR02MB4799.eurprd02.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(136003)(396003)(346002)(376002)(199004)(189003)(51444003)(52314003)(97736004)(74482002)(256004)(14444005)(65806001)(66066001)(65956001)(31686004)(3846002)(6116002)(76176011)(52116002)(305945005)(64126003)(2906002)(102836004)(6246003)(36756003)(53936002)(6512007)(186003)(4326008)(26005)(65826007)(7736002)(386003)(6506007)(6436002)(53546011)(6486002)(229853002)(54906003)(31696002)(11346002)(446003)(508600001)(2616005)(58126008)(71200400001)(25786009)(71190400001)(476003)(5660300002)(486006)(110136005)(86362001)(81156014)(81166006)(8676002)(8936002)(93886005)(14454004)(68736007)(99286004)(316002)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4799;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6lnL3j960FOT6ZvpUSJvGpYhd2O+wN9Y8Ipm04BXn2ZmvECo+WLIoBa0aaYew9P+3SYSMEgxQeliLZvPm75mw9tZL4CaicdVQdtMKSrGvA3eqzTs06nINr1+r2fR0bBSqPlUB8/8MacPPXzJUdmX3poSNwFs3D25Li7SprhR1XFeccn1u+4uJQ6Vq0P/Cj19MJ3L3wss/UOHGp4g71KMNNd+hRe8jOyFDJLb/dz6wJJuCOsKwp0bualDICLO8H/Rs0+8L3u14Bcz4eEqqgsOLqUo4BG142muPZAkk2YQPI5MVjWqAfD/PQySbncvlzlXS/EzmOL2pmZZAccGQGNXDGdvRngIs4DnfBPGH2Sl6jBPtgry2uw7Nj6CiC5owAxNxtoIRZ88wSTDEYDvmquVqqN4IqiFdg99kzM/MS+k+QI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A97424730BC9D46BA6D1E24285AF823@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: aa7b9f30-cdaa-4d56-7681-08d6c3c61caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 06:21:37.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0xOCAwMTo0OCwgUmF5IEp1aSB3cm90ZToNCj4gDQo+IA0KPiBPbiA0LzE0LzIw
MTkgMTE6NTYgUE0sIFBldGVyIFJvc2luIHdyb3RlOg0KPj4gT24gMjAxOS0wNC0xMyAwMDo1OSwg
UGV0ZXIgUm9zaW4gd3JvdGU6DQo+Pj4gT24gMjAxOS0wNC0wMyAyMzowNSwgUmF5IEp1aSB3cm90
ZToNCj4+Pj4gQ2hhbmdlIHRoZSBpUHJvYyBJMkMgZHJpdmVyIHRvIHVzZSB0aGUgJ0JJVCcgbWFj
cm8gZnJvbSBhbGwgJzEgPDwgWFhYJw0KPj4+PiBiaXQgb3BlcmF0aW9ucyB0byBnZXQgcmlkIG9m
IGNvbXBpbGVyIHdhcm5pbmcgYW5kIGltcHJvdmUgcmVhZGFiaWxpdHkgb2YNCj4+Pj4gdGhlIGNv
ZGUNCj4+Pg0KPj4+IEFsbD8gSSBzZWUgbG90cyBtb3JlICcxIDw8IFhYWF9TSElGVCcgbWF0Y2hl
cy4gSSBtaWdodCBiZSBiZWhpbmQgdGhvdWdoPw0KPj4NCj4+IEkgdmVyaWZpZWQgdGhhdCwgYW5k
IHllcyBpbmRlZWQsIEkgd2FzIGJlaGluZC4gVGhhdCBzYWlkLCBzZWUgYmVsb3cuLi4NCj4+DQo+
IA0KPiBSaWdodC4gUHJldmlvdXMgY2hhbmdlIHRoYXQgdGhpcyBjaGFuZ2UgZGVwZW5kcyBvbiBp
cyBhbHJlYWR5IHF1ZXVlZCBpbg0KPiBpMmMvZm9yLW5leHQuDQo+IA0KPj4+IEFueXdheSwgaWYg
eW91IGFyZSBjbGVhbmluZyB1cCwgSSdtIGp1c3QgZmxhZ2dpbmcgdGhhdCBCSVQoWFhYX1NISUZU
KSBsb29rcw0KPj4+IGEgYml0IGNsdW5reSB0byBtZS4gWW91IG1pZ2h0IGNvbnNpZGVyIHJlbmFt
aW5nIGFsbCB0aG9zZSBzaW5nbGUtYml0DQo+Pj4gWFhYX1NISUZUIG1hY3JvcyB0byBzaW1wbGUg
YmUNCj4+Pg0KPj4+ICNkZWZpbmUgWFhYIEJJVCg8eHh4PikNCj4+Pg0KPj4+IGluc3RlYWQgb2YN
Cj4+Pg0KPj4+ICNkZWZpbmUgWFhYX1NISUZUIDx4eHg+DQo+Pj4NCj4+PiBidXQgdGhhdCB0cmln
Z2VycyBtb3JlIGNodXJuLCBzbyBpcyBvYnZpb3VzbHkgbW9yZSBlcnJvciBwcm9uZS4gWW91IG1p
Z2h0DQo+Pj4gbm90IGRhcmUgaXQ/DQo+Pj4NCj4gDQo+IFdpdGggdGhlIGN1cnJlbnQgY29kZSwg
SSBkb24ndCBzZWUgaG93IHRoYXQgaXMgY2xlYW5lci4gV2l0aCBYWFhfU0hJRlQNCj4gc3BlY2lm
aWVkLCBpdCBtYWtlcyBpdCB2ZXJ5IGNsZWFyIHRvIHRoZSB1c2VyIHRoYXQgdGhlIGRlZmluZSBh
IGZvciBhDQo+IGJpdCBsb2NhdGlvbiB3aXRoaW4gYSByZWdpc3Rlci4gWW91IGNhbiBhcmd1ZSBh
bmQgc2F5IGl0IG1ha2VzIHRoZQ0KPiBkZWZpbmUgbG9uZ2VyLCBidXQgbm90IGxlc3MgY2xlYXIu
DQo+IA0KPj4+IENoZWVycywNCj4+PiBQZXRlcg0KPj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFJh
eSBKdWkgPHJheS5qdWlAYnJvYWRjb20uY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGRyaXZlcnMvaTJj
L2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMgfCA2ICsrKy0tLQ0KPj4+PiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMgYi9kcml2ZXJzL2kyYy9idXNzZXMv
aTJjLWJjbS1pcHJvYy5jDQo+Pj4+IGluZGV4IDU2Mjk0MmQwYzA1Yy4uYTg0NWI4ZGVjYWM4IDEw
MDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLWJjbS1pcHJvYy5jDQo+Pj4+
ICsrKyBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtYmNtLWlwcm9jLmMNCj4+Pj4gQEAgLTcxNyw3
ICs3MTcsNyBAQCBzdGF0aWMgaW50IGJjbV9pcHJvY19pMmNfeGZlcl9zaW5nbGVfbXNnKHN0cnVj
dCBiY21faXByb2NfaTJjX2RldiAqaXByb2NfaTJjLA0KPj4+PiAgDQo+Pj4+ICAJCQkvKiBtYXJr
IHRoZSBsYXN0IGJ5dGUgKi8NCj4+Pj4gIAkJCWlmIChpID09IG1zZy0+bGVuIC0gMSkNCj4+Pj4g
LQkJCQl2YWwgfD0gMSA8PCBNX1RYX1dSX1NUQVRVU19TSElGVDsNCj4+Pj4gKwkJCQl2YWwgfD0g
QklUKE1fVFhfV1JfU1RBVFVTX1NISUZUKTsNCj4+Pj4gIA0KPj4+PiAgCQkJaXByb2NfaTJjX3dy
X3JlZyhpcHJvY19pMmMsIE1fVFhfT0ZGU0VULCB2YWwpOw0KPj4+PiAgCQl9DQo+Pj4+IEBAIC04
NDQsNyArODQ0LDcgQEAgc3RhdGljIGludCBiY21faXByb2NfaTJjX2NmZ19zcGVlZChzdHJ1Y3Qg
YmNtX2lwcm9jX2kyY19kZXYgKmlwcm9jX2kyYykNCj4+Pj4gIA0KPj4+PiAgCWlwcm9jX2kyYy0+
YnVzX3NwZWVkID0gYnVzX3NwZWVkOw0KPj4+PiAgCXZhbCA9IGlwcm9jX2kyY19yZF9yZWcoaXBy
b2NfaTJjLCBUSU1fQ0ZHX09GRlNFVCk7DQo+Pj4+IC0JdmFsICY9IH4oMSA8PCBUSU1fQ0ZHX01P
REVfNDAwX1NISUZUKTsNCj4+Pj4gKwl2YWwgJj0gfkJJVChUSU1fQ0ZHX01PREVfNDAwX1NISUZU
KTsNCj4+Pj4gIAl2YWwgfD0gKGJ1c19zcGVlZCA9PSA0MDAwMDApIDw8IFRJTV9DRkdfTU9ERV80
MDBfU0hJRlQ7DQo+Pg0KPj4gVGhlc2UgdHdvIHN0YXRlbWVudHMgbm93IG5vIGxvbmdlciAibWF0
Y2giLiBPbmUgdXNlcyBCSVQgYW5kIHRoZSBvdGhlciBvcGVuDQo+PiBjb2RlcyB0aGUgc2hpZnQu
IEkgdGhpbmsgdGhhdCdzIGJhZC4gTG9zaW5nIHRoZSBfU0hJRlQgc3VmZml4IGFuZCBpbmNsdWRp
bmcNCj4+IEJJVCBpbiB0aGUgbWFjcm8gZXhwYW5zaW9uLCBhcyBzdWdnZXN0ZWQgYWJvdmUsIHlp
ZWxkczoNCj4+DQo+PiAJdmFsICY9IH5USU1fQ0ZHX01PREVfNDAwOw0KPj4gCWlmIChidXNfc3Bl
ZWQgPT0gNDAwMDAwKQ0KPj4gCQl2YWwgfD0gVElNX0NGR19NT0RFXzQwMDsNCj4+DQo+PiB3aGlj
aCBpcyBwZXJoYXBzIG9uZSBtb3JlIGxpbmUsIGJ1dCBhbHNvIG1vcmUgcmVhZGFibGUgSU1PLg0K
Pj4NCj4gDQo+IEEgc2luZ2xlIGxpbmUgd2l0aCBldmFsdWF0aW9uIGVtYmVkZGVkIGlzIG5pY2Ug
YW5kIGNsZWFuIHRvIG1lLiBJIGd1ZXNzDQo+IHRoaXMgaXMgc3ViamVjdGl2ZS4NCg0KVGhlICJw
cm9ibGVtIiBJIGhhZCB3aGVuIEkgbG9va2VkIGF0IHRoZSBkcml2ZXIgd2FzIG5vdCBhbnkgb25l
IHNwZWNpZmljDQppbnN0YW5jZS4gSXQgd2FzIGp1c3QgdGhhdCwgZm9yIG15IHRhc3RlLCB0aGUg
Y29kZSBoYWQgdG9vIG1hbnkgc2hpZnRzDQpldGMgaW5saW5lIHdpdGggdGhlIHJlYWwgY29kZS4g
UmVwbGFjaW5nIDEgPDwgeHl6X1NISUZUIHdpdGggQklUKHh5el9TSElGVCkNCmlzIG5vdCBhIHJl
YWwgaW1wcm92ZW1lbnQsIHRoZXkgYXJlIGp1c3QgYWJvdXQgZXF1YWwgdG8gbWUsIGl0J3MganVz
dCB0aGF0DQp0aGVyZSBhcmUgc3RpbGwgdG9vIG1hbnkgbWVjaGFuaWNhbCB0aGluZ3MgaGFwcGVu
aW5nIHRoYXQgY291bGQgZWFzaWx5IGJlDQp0dWNrZWQgYXdheSB3aXRoIHRoZSBzdWdnZXN0ZWQg
YXBwcm9hY2guDQoNCj4gSSdsbCBsZWF2ZSB0aGUgZGVjaXNpb24gdG8gV29sZnJhbS4gSWYgaGUg
YWxzbyBwcmVmZXJzIHRoZSBhYm92ZSBjaGFuZ2UNCj4gdG8gYmUgbWFkZSwgc3VyZS4gT3RoZXJ3
aXNlLCBJJ2xsIGxlYXZlIGl0IGFzIGl0IGlzLg0KDQpCdXQgaWYgeW91IHNlZSBubyB2YWx1ZSBp
biBteSBzdWdnZXN0aW9uIGFuZC9vciBkb24ndCB3aGF0IHRvIHRha2UgdGhlDQpjbGVhbnVwIG9u
ZSBzdGVwIGZ1cnRoZXIsIHRoZW4ganVzdCBsZWF2ZSBpdCBhcy1pcy4NCg0KPj4gQnV0IGFsbCB0
aGlzIGlzIG9mIGNvdXJzZSBpbiBkZWVwIG5pdC1waWNrLXRlcnJpdG9yeS4uLg0KPj4NCj4+IENo
ZWVycywNCj4+IFBldGVyDQo+Pg0KPiANCj4gVGhhbmtzLA0KPiANCj4gUmF5DQo+IA0KDQo=
