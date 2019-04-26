Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BB5C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B35206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 01:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="uNzRRxWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfDZBmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 21:42:40 -0400
Received: from mail-eopbgr30043.outbound.protection.outlook.com ([40.107.3.43]:52384
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbfDZBmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 21:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1elhcdJVnYzsFwDLQKHmNAFfpRR/2fv3gyEqF4WwnE=;
 b=uNzRRxWTEMiPDUnf2IoQm77l5fFb4PudYb5QJL3E5eHOaJ5cpPe+zoXwCkhJ019nFGj0MHVKYZwfKmUab8XKrR86P6Hp7p6unUUgg1bUuG2QoUCKbEpRLxg8QHTQRbaahkEsBUNS61v5ZGcfF0pg13oQqx3U065w+AFg6LvErhc=
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com (20.179.9.32) by
 DB8PR05MB6042.eurprd05.prod.outlook.com (20.179.12.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Fri, 26 Apr 2019 01:42:34 +0000
Received: from DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::ed24:8317:76e4:1a07]) by DB8PR05MB5898.eurprd05.prod.outlook.com
 ([fe80::ed24:8317:76e4:1a07%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 01:42:34 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        Moshe Shemesh <moshe@mellanox.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Topic: [PATCH net-next] devlink: Execute devlink health recover as a
 work
Thread-Index: AQHU+1W97FRfJKyEkEyPDy2xvgcLIKZNZ9uAgABEGgA=
Date:   Fri, 26 Apr 2019 01:42:34 +0000
Message-ID: <e540b1c192632dfcf4c0367be133c9ca51f33b43.camel@mellanox.com>
References: <1556189823-5368-1-git-send-email-moshe@mellanox.com>
         <20190425143847.417033ab@cakuba.netronome.com>
In-Reply-To: <20190425143847.417033ab@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e83379f-f8f1-4d03-9b3e-08d6c9e87489
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB8PR05MB6042;
x-ms-traffictypediagnostic: DB8PR05MB6042:
x-microsoft-antispam-prvs: <DB8PR05MB6042B5333F69A0C53E66096CBE3E0@DB8PR05MB6042.eurprd05.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(366004)(199004)(189003)(86362001)(7736002)(118296001)(6512007)(316002)(6436002)(229853002)(478600001)(305945005)(486006)(91956017)(14454004)(76116006)(73956011)(2616005)(6246003)(476003)(446003)(11346002)(66476007)(25786009)(6486002)(186003)(66946007)(66556008)(64756008)(66446008)(5660300002)(99286004)(53936002)(4326008)(76176011)(66066001)(6506007)(71190400001)(71200400001)(102836004)(36756003)(2501003)(26005)(68736007)(58126008)(6636002)(81166006)(81156014)(97736004)(8936002)(110136005)(2906002)(8676002)(54906003)(6116002)(14444005)(256004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR05MB6042;H:DB8PR05MB5898.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4oFrSeTLFaA02vkvPDyAnbPZ5tgvwGUvTP5qveqmmqF8AwCKDEcQ7Sis1wOYrZYqThUP+DBkWQBuIt7chvK54TAhr9KhIgtSxUulSt6bZiS9mbpaxQ5ABgZssd1C/uGz/rmqJBcN1zPJmvynXQv/W9aNk7lYed/a5FqXkuoRrrLQutMWHN2114FT4+rolfuYxqzGyrvmo5Ut3l0xyVSqTf9zQOJdPShb708/DwM9tQRXxwaupyYD+RVliH4gAhV0qQr4i90LcOXcnBlKubZcy7+HD+bjYxhhmopSwaDDkRB9vTCIUuBnUdGpmIcoz+G+MoucrCkmn4dwyLQMYBmPUzib3+7momeEbwWhgxHj74DRTP8ClOzO0peKzaruDEJC445LiWxDrBgtZiUzk460KtCcqel5FYE9k1tPiSqQKTA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E06E755B5E72444E9AC2BBA708248D62@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e83379f-f8f1-4d03-9b3e-08d6c9e87489
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 01:42:34.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA0LTI1IGF0IDE0OjM4IC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4gT24gVGh1LCAyNSBBcHIgMjAxOSAxMzo1NzowMyArMDMwMCwgTW9zaGUgU2hlbWVzaCB3cm90
ZToNCj4gPiBEaWZmZXJlbnQgcmVwb3J0ZXJzIGhhdmUgZGlmZmVyZW50IHJ1bGVzIGluIHRoZSBk
cml2ZXIgYW5kIGFyZQ0KPiA+IGJlaW5nDQo+ID4gY3JlYXRlZC9kZXN0cm95ZWQgZHVyaW5nIGRp
ZmZlcmVudCBzdGFnZXMgb2YgZHJpdmVyDQo+ID4gbG9hZC91bmxvYWQvcnVubmluZy4NCj4gPiBT
byBkdXJpbmcgZXhlY3V0aW9uIG9mIGEgcmVwb3J0ZXIgcmVjb3ZlciB0aGUgZmxvdyBjYW4gZ28g
dGhyb3VnaA0KPiA+IGFub3RoZXIgcmVwb3J0ZXIncyBkZXN0cm95IGFuZCBjcmVhdGUuIFN1Y2gg
ZmxvdyBsZWFkcyB0byBkZWFkbG9jaw0KPiA+IHRyeWluZyB0byBsb2NrIGEgbXV0ZXggYWxyZWFk
eSBoZWxkIGlmIHRoZSBmbG93IHdhcyB0cmlnZ2VyZWQgYnkNCj4gPiBkZXZsaW5rDQo+ID4gcmVj
b3ZlciBjb21tYW5kLg0KPiA+IFRvIGF2b2lkIHN1Y2ggZGVhZGxvY2ssIHdlIGV4ZWN1dGUgdGhl
IHJlY292ZXIgZmxvdyBmcm9tIGENCj4gPiB3b3JrcXVldWUuDQo+ID4gT25jZSB0aGUgcmVjb3Zl
ciB3b3JrIGlzIGRvbmUgc3VjY2Vzc2Z1bGx5IHRoZSByZXBvcnRlciBoZWFsdGgNCj4gPiBzdGF0
ZSBhbmQNCj4gPiByZWNvdmVyIGNvdW50ZXIgYXJlIGJlaW5nIHVwZGF0ZWQuDQo+IA0KPiBOYWl2
ZSBxdWVzdGlvbiwgd2h5IG5vdCBqdXN0IHJ1biB0aGUgZG9pdCB1bmxvY2tlZD8gIFdoeSB0aGUg
YXN5bmM/DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1vc2hlIFNoZW1lc2ggPG1vc2hlQG1lbGxh
bm94LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaXJpIFBpcmtvIDxqaXJpQG1lbGxhbm94LmNv
bT4NCj4gDQo+IE9uZSBkYXkgd2UgcmVhbGx5IGdvdHRhIHN0YXJ0IGRvY3VtZW50aW5nIHRoZSBj
b250ZXh0IGZyb20gd2hpY2ggDQo+IHRoaW5ncyBhcmUgY2FsbGVkIGFuZCBsb2NrcyBjYWxsZWQg
d2hlbiBvcHMgYXJlIGludm9rZWQuLiA6KQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2NvcmUv
ZGV2bGluay5jIGIvbmV0L2NvcmUvZGV2bGluay5jDQo+ID4gaW5kZXggN2I5MTYwNS4uOGVlMzgw
ZSAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvY29yZS9kZXZsaW5rLmMNCj4gPiArKysgYi9uZXQvY29y
ZS9kZXZsaW5rLmMNCj4gPiBAQCAtNDQ0Myw2ICs0NDQ0LDQwIEBAIHN0cnVjdCBkZXZsaW5rX2hl
YWx0aF9yZXBvcnRlciB7DQo+ID4gIAlyZXR1cm4gTlVMTDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAr
c3RhdGljIGludA0KPiA+ICtkZXZsaW5rX2hlYWx0aF9yZXBvcnRlcl9yZWNvdmVyKHN0cnVjdCBk
ZXZsaW5rX2hlYWx0aF9yZXBvcnRlcg0KPiA+ICpyZXBvcnRlciwNCj4gPiArCQkJCXZvaWQgKnBy
aXZfY3R4KQ0KPiA+ICt7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCWlmICghcmVwb3J0
ZXItPm9wcy0+cmVjb3ZlcikNCj4gPiArCQlyZXR1cm4gLUVPUE5PVFNVUFA7DQo+ID4gKw0KPiA+
ICsJZXJyID0gcmVwb3J0ZXItPm9wcy0+cmVjb3ZlcihyZXBvcnRlciwgcHJpdl9jdHgpOw0KPiA+
ICsJaWYgKGVycikNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCXJlcG9ydGVyLT5y
ZWNvdmVyeV9jb3VudCsrOw0KPiA+ICsJcmVwb3J0ZXItPmhlYWx0aF9zdGF0ZSA9IERFVkxJTktf
SEVBTFRIX1JFUE9SVEVSX1NUQVRFX0hFQUxUSFk7DQo+ID4gKwlyZXBvcnRlci0+bGFzdF9yZWNv
dmVyeV90cyA9IGppZmZpZXM7DQo+IA0KPiBXZWxsLCB0aGUgZHVtcCBsb29rcyBhdCB0aGVzZSB3
aXRob3V0IHRha2luZyBhbnkgbG9ja3MuLg0KPiANCj4gPiArCXRyYWNlX2RldmxpbmtfaGVhbHRo
X3JlcG9ydGVyX3N0YXRlX3VwZGF0ZShyZXBvcnRlci0+ZGV2bGluaywNCj4gPiArCQkJCQkJICAg
cmVwb3J0ZXItPm9wcy0+bmFtZSwNCj4gPiArCQkJCQkJICAgcmVwb3J0ZXItDQo+ID4gPmhlYWx0
aF9zdGF0ZSk7DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZv
aWQNCj4gPiArZGV2bGlua19oZWFsdGhfcmVwb3J0ZXJfcmVjb3Zlcl93b3JrKHN0cnVjdCB3b3Jr
X3N0cnVjdCAqd29yaykNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmxpbmtfaGVhbHRoX3JlcG9y
dGVyICpyZXBvcnRlcjsNCj4gPiArDQo+ID4gKwlyZXBvcnRlciA9IGNvbnRhaW5lcl9vZih3b3Jr
LCBzdHJ1Y3QgZGV2bGlua19oZWFsdGhfcmVwb3J0ZXIsDQo+ID4gKwkJCQlyZWNvdmVyX3dvcmsp
Ow0KPiA+ICsNCj4gPiArCWRldmxpbmtfaGVhbHRoX3JlcG9ydGVyX3JlY292ZXIocmVwb3J0ZXIs
IE5VTEwpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICoJZGV2bGlua19oZWFsdGhf
cmVwb3J0ZXJfY3JlYXRlIC0gY3JlYXRlIGRldmxpbmsgaGVhbHRoIHJlcG9ydGVyDQo+ID4gICAq
DQo+ID4gQEAgLTQ0ODMsNiArNDUxOCw4IEBAIHN0cnVjdCBkZXZsaW5rX2hlYWx0aF9yZXBvcnRl
ciAqDQo+ID4gIAlyZXBvcnRlci0+ZGV2bGluayA9IGRldmxpbms7DQo+ID4gIAlyZXBvcnRlci0+
Z3JhY2VmdWxfcGVyaW9kID0gZ3JhY2VmdWxfcGVyaW9kOw0KPiA+ICAJcmVwb3J0ZXItPmF1dG9f
cmVjb3ZlciA9IGF1dG9fcmVjb3ZlcjsNCj4gPiArCUlOSVRfV09SSygmcmVwb3J0ZXItPnJlY292
ZXJfd29yaywNCj4gPiArCQkgIGRldmxpbmtfaGVhbHRoX3JlcG9ydGVyX3JlY292ZXJfd29yayk7
DQo+ID4gIAltdXRleF9pbml0KCZyZXBvcnRlci0+ZHVtcF9sb2NrKTsNCj4gPiAgCWxpc3RfYWRk
X3RhaWwoJnJlcG9ydGVyLT5saXN0LCAmZGV2bGluay0+cmVwb3J0ZXJfbGlzdCk7DQo+ID4gIHVu
bG9jazoNCj4gPiBAQCAtNDUwNSw2ICs0NTQyLDcgQEAgc3RydWN0IGRldmxpbmtfaGVhbHRoX3Jl
cG9ydGVyICoNCj4gPiAgCW11dGV4X3VubG9jaygmcmVwb3J0ZXItPmRldmxpbmstPmxvY2spOw0K
PiA+ICAJaWYgKHJlcG9ydGVyLT5kdW1wX2Ztc2cpDQo+ID4gIAkJZGV2bGlua19mbXNnX2ZyZWUo
cmVwb3J0ZXItPmR1bXBfZm1zZyk7DQo+ID4gKwljYW5jZWxfd29ya19zeW5jKCZyZXBvcnRlci0+
cmVjb3Zlcl93b3JrKTsNCj4gPiAgCWtmcmVlKHJlcG9ydGVyKTsNCj4gPiAgfQ0KPiA+ICBFWFBP
UlRfU1lNQk9MX0dQTChkZXZsaW5rX2hlYWx0aF9yZXBvcnRlcl9kZXN0cm95KTsNCj4gPiBAQCAt
NDUyNiwyNiArNDU2NCw2IEBAIHN0cnVjdCBkZXZsaW5rX2hlYWx0aF9yZXBvcnRlciAqDQo+ID4g
IH0NCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoZGV2bGlua19oZWFsdGhfcmVwb3J0ZXJfc3RhdGVf
dXBkYXRlKTsNCj4gPiAgDQo+ID4gLXN0YXRpYyBpbnQNCj4gPiAtZGV2bGlua19oZWFsdGhfcmVw
b3J0ZXJfcmVjb3ZlcihzdHJ1Y3QgZGV2bGlua19oZWFsdGhfcmVwb3J0ZXINCj4gPiAqcmVwb3J0
ZXIsDQo+ID4gLQkJCQl2b2lkICpwcml2X2N0eCkNCj4gPiAtew0KPiA+IC0JaW50IGVycjsNCj4g
PiAtDQo+ID4gLQlpZiAoIXJlcG9ydGVyLT5vcHMtPnJlY292ZXIpDQo+ID4gLQkJcmV0dXJuIC1F
T1BOT1RTVVBQOw0KPiA+IC0NCj4gPiAtCWVyciA9IHJlcG9ydGVyLT5vcHMtPnJlY292ZXIocmVw
b3J0ZXIsIHByaXZfY3R4KTsNCj4gPiAtCWlmIChlcnIpDQo+ID4gLQkJcmV0dXJuIGVycjsNCj4g
PiAtDQo+ID4gLQlyZXBvcnRlci0+cmVjb3ZlcnlfY291bnQrKzsNCj4gPiAtCXJlcG9ydGVyLT5o
ZWFsdGhfc3RhdGUgPSBERVZMSU5LX0hFQUxUSF9SRVBPUlRFUl9TVEFURV9IRUFMVEhZOw0KPiA+
IC0JcmVwb3J0ZXItPmxhc3RfcmVjb3ZlcnlfdHMgPSBqaWZmaWVzOw0KPiA+IC0NCj4gPiAtCXJl
dHVybiAwOw0KPiA+IC19DQo+ID4gLQ0KPiA+ICBzdGF0aWMgdm9pZA0KPiA+ICBkZXZsaW5rX2hl
YWx0aF9kdW1wX2NsZWFyKHN0cnVjdCBkZXZsaW5rX2hlYWx0aF9yZXBvcnRlcg0KPiA+ICpyZXBv
cnRlcikNCj4gPiAgew0KPiA+IEBAIC00ODEzLDcgKzQ4MzEsMTEgQEAgc3RhdGljIGludA0KPiA+
IGRldmxpbmtfbmxfY21kX2hlYWx0aF9yZXBvcnRlcl9yZWNvdmVyX2RvaXQoc3RydWN0IHNrX2J1
ZmYgKnNrYiwNCj4gPiAgCWlmICghcmVwb3J0ZXIpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4gIA0KPiA+IC0JcmV0dXJuIGRldmxpbmtfaGVhbHRoX3JlcG9ydGVyX3JlY292ZXIocmVwb3J0
ZXIsIE5VTEwpOw0KPiA+ICsJaWYgKCFyZXBvcnRlci0+b3BzLT5yZWNvdmVyKQ0KPiA+ICsJCXJl
dHVybiAtRU9QTk9UU1VQUDsNCj4gPiArDQo+ID4gKwlxdWV1ZV93b3JrKGRldmxpbmstPnJlcG9y
dGVyc193cSwgJnJlcG9ydGVyLT5yZWNvdmVyX3dvcmspOw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
IH0NCj4gDQo+IFNvIHRoZSByZWNvdmVyIHVzZXIgc3BhY2UgcmVxdWVzdCB3aWxsIG5vIGxvbmdl
ciByZXR1cm4gdGhlIHN0YXR1cywNCj4gYW5kDQo+IGl0IHdpbGwgbm90IGFjdHVhbGx5IHdhaXQg
Zm9yIHRoZSByZWNvdmVyIHRvIGhhcHBlbi4gIExlYXZpbmcgdXNlcg0KPiBwb25kZXJpbmcgLSBk
aWQgdGhlIHJlY292ZXIgcnVuIGFuZCBmYWlsLCBvciBkaWQgaXQgbm9yIGdldCBydW4NCj4geWV0
Li4uDQo+IA0KDQp3YWl0X2Zvcl9jb21wbGV0aW9uX2ludGVycnVwdGlibGVfdGltZW91dCBpcyBt
aXNzaW5nIGZyb20gdGhlIGRlc2lnbiA/DQoNCj4gPiAgc3RhdGljIGludCBkZXZsaW5rX25sX2Nt
ZF9oZWFsdGhfcmVwb3J0ZXJfZGlhZ25vc2VfZG9pdChzdHJ1Y3QNCj4gPiBza19idWZmICpza2Is
DQo+ID4gQEAgLTUyMzQsNiArNTI1NiwxMSBAQCBzdHJ1Y3QgZGV2bGluayAqZGV2bGlua19hbGxv
Yyhjb25zdCBzdHJ1Y3QNCj4gPiBkZXZsaW5rX29wcyAqb3BzLCBzaXplX3QgcHJpdl9zaXplKQ0K
PiA+ICAJSU5JVF9MSVNUX0hFQUQoJmRldmxpbmstPnBhcmFtX2xpc3QpOw0KPiA+ICAJSU5JVF9M
SVNUX0hFQUQoJmRldmxpbmstPnJlZ2lvbl9saXN0KTsNCj4gPiAgCUlOSVRfTElTVF9IRUFEKCZk
ZXZsaW5rLT5yZXBvcnRlcl9saXN0KTsNCj4gPiArCWRldmxpbmstPnJlcG9ydGVyc193cSA9DQo+
ID4gY3JlYXRlX3NpbmdsZXRocmVhZF93b3JrcXVldWUoImRldmxpbmtfcmVwb3J0ZXJzIik7DQo+
IA0KPiBXaHkgaXMgaXQgc2luZ2xlIHRocmVhZGVkPw0KPiANCj4gPiArCWlmICghZGV2bGluay0+
cmVwb3J0ZXJzX3dxKSB7DQo+ID4gKwkJa2ZyZWUoZGV2bGluayk7DQo+ID4gKwkJcmV0dXJuIE5V
TEw7DQo+ID4gKwl9DQo+ID4gIAltdXRleF9pbml0KCZkZXZsaW5rLT5sb2NrKTsNCj4gPiAgCXJl
dHVybiBkZXZsaW5rOw0KPiA+ICB9DQo+ID4gQEAgLTUyNzgsNiArNTMwNSw3IEBAIHZvaWQgZGV2
bGlua191bnJlZ2lzdGVyKHN0cnVjdCBkZXZsaW5rDQo+ID4gKmRldmxpbmspDQo+ID4gIHZvaWQg
ZGV2bGlua19mcmVlKHN0cnVjdCBkZXZsaW5rICpkZXZsaW5rKQ0KPiA+ICB7DQo+ID4gIAltdXRl
eF9kZXN0cm95KCZkZXZsaW5rLT5sb2NrKTsNCj4gPiArCWRlc3Ryb3lfd29ya3F1ZXVlKGRldmxp
bmstPnJlcG9ydGVyc193cSk7DQo+ID4gIAlXQVJOX09OKCFsaXN0X2VtcHR5KCZkZXZsaW5rLT5y
ZXBvcnRlcl9saXN0KSk7DQo+ID4gIAlXQVJOX09OKCFsaXN0X2VtcHR5KCZkZXZsaW5rLT5yZWdp
b25fbGlzdCkpOw0KPiA+ICAJV0FSTl9PTighbGlzdF9lbXB0eSgmZGV2bGluay0+cGFyYW1fbGlz
dCkpOw0K
