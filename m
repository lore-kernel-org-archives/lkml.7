Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100C1C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2048A20685
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="W5AIr5ai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfDYT3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:29:10 -0400
Received: from mail-eopbgr140117.outbound.protection.outlook.com ([40.107.14.117]:65514
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727486AbfDYT3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gjg2BH7Cd/uGjLihsALaSVv8l3J5sR7j1zmuMFdmIRs=;
 b=W5AIr5aiUbCRCEm21DtOku3SWFUhk1zAvUwPO+ulrbScugIjzXwoNv+GlK/zZDR63JA4hPOOPcbLujjlzBNQrrjiNkywdoUK2QhaOT5Lf87p/gySipZSNTzxIB/NwJuI2oxHkEslky2u8NRGFiD4cLTb/ZfKDnjCRX8JOv4IgIE=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB4096.eurprd02.prod.outlook.com (20.177.58.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Thu, 25 Apr 2019 19:28:52 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::2891:d814:7bff:fbc7%4]) with mapi id 15.20.1813.017; Thu, 25 Apr 2019
 19:28:52 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Peter Korsgaard <peter.korsgaard@barco.com>,
        Serge Semin <Sergey.Semin@t-platforms.ru>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data found
Thread-Topic: [PATCH 2/5] i2c-mux-gpio: Return an error if no config data
 found
Thread-Index: AQHU+poQ7vY8I41EDUarM1AN7cQUWqZL01oAgAEz6ACAAD3AgA==
Date:   Thu, 25 Apr 2019 19:28:52 +0000
Message-ID: <3366ab5c-ced5-cfe1-c93e-d50ce795c2aa@axentia.se>
References: <20190424123414.25311-1-fancer.lancer@gmail.com>
 <20190424123414.25311-3-fancer.lancer@gmail.com>
 <4e7c9184-03a2-f1d3-2ed0-a761d76b9654@axentia.se>
 <20190425154736.emjumxqimzgvzrla@mobilestation>
In-Reply-To: <20190425154736.emjumxqimzgvzrla@mobilestation>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [213.112.138.100]
x-clientproxiedby: HE1PR05CA0280.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::32) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c40934bb-68ca-4f2e-fc72-08d6c9b43fd1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR02MB4096;
x-ms-traffictypediagnostic: VI1PR02MB4096:
x-microsoft-antispam-prvs: <VI1PR02MB40962F353CF2E3E25BFA9516BC3D0@VI1PR02MB4096.eurprd02.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(376002)(396003)(366004)(346002)(136003)(199004)(189003)(37524003)(2616005)(11346002)(446003)(476003)(486006)(71190400001)(31686004)(6246003)(97736004)(186003)(26005)(25786009)(76176011)(52116002)(386003)(6506007)(102836004)(53546011)(4326008)(66556008)(66476007)(81166006)(81156014)(66446008)(73956011)(66066001)(64756008)(65806001)(65956001)(6916009)(64126003)(93886005)(8936002)(256004)(8676002)(14444005)(74482002)(6486002)(229853002)(6436002)(65826007)(66946007)(31696002)(86362001)(71200400001)(99286004)(316002)(2906002)(58126008)(54906003)(36756003)(5660300002)(7736002)(305945005)(68736007)(508600001)(14454004)(6512007)(53936002)(3846002)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4096;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Llgz+eoKAFL6Dr0UFSNSpvhvQaxrrJ/EGtCohbH0GtP0W4I5rcEqICW7qatR+xCW2piqJ9aM8QqSLmn7bzftaIC543Ukt7njBoojya6XmejT+f19t0T2MniFjmRFX4jRgh2aga7HvlW/e+1YPJ7X9cNgRlov0Pyn7Jq3qzDneC7UpaSc+IkSXsJh9XbEX3ugafSqRhtFlXma4Bu3zSZzUQ6oJit9ZghjffwUXzcFNR+p67TGXe9bAPvOmNAwz2hA5Nct158IlKoWdKeZj5lzbVydq3hU+8gn9bXqAJUTCw108Dq0GVhEEPY8NqRAOyJT9KLA5MnDl7WD36qQTXGHmgvlxthkGu4a+Edh3n83CE7CuarrpN0dMICgabw7qqONmU0W3PfrG5fU3vebjJZMCs0LrT4WT1atBDiEs/tV5C0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5060146B60927F4EBAC7006A547E3E62@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: c40934bb-68ca-4f2e-fc72-08d6c9b43fd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 19:28:52.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wNC0yNSAxNzo0NywgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+IE9uIFdlZCwgQXByIDI0
LCAyMDE5IGF0IDA5OjI1OjUwUE0gKzAwMDAsIFBldGVyIFJvc2luIHdyb3RlOg0KPj4gT24gMjAx
OS0wNC0yNCAxNDozNCwgU2VyZ2UgU2VtaW4gd3JvdGU6DQo+Pj4gSXQncyBwb2ludGxlc3MgYW5k
IG1pZ2h0IGJlIGV2ZW4gZXJyb3JzIHByb25lIHRvIHByb2NlZWQgd2l0aCBmdXJ0aGVyDQo+Pj4g
aW5pdGlhbGl6YXRpb24gaWYgbmVpdGhlciBvZi0gbm8gcGxhdGZvcm0tYmFzZWQgc2V0dGluZ3Mg
d2VyZSBkaXNjb3ZlcmVkLg0KPj4+IEp1c3QgcmV0dXJuIGFuIGVycm9yIGluIHRoaXMgY2FzZS4N
Cj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWls
LmNvbT4NCj4+PiAtLS0NCj4+PiAgZHJpdmVycy9pMmMvbXV4ZXMvaTJjLW11eC1ncGlvLmMgfCAx
MiArKysrKysrLS0tLS0NCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9tdXhlcy9pMmMt
bXV4LWdwaW8uYyBiL2RyaXZlcnMvaTJjL211eGVzL2kyYy1tdXgtZ3Bpby5jDQo+Pj4gaW5kZXgg
MjRjZjZlYzAyZTc1Li5hMTRmZTEzMmIwYzMgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9pMmMv
bXV4ZXMvaTJjLW11eC1ncGlvLmMNCj4+PiArKysgYi9kcml2ZXJzL2kyYy9tdXhlcy9pMmMtbXV4
LWdwaW8uYw0KPj4+IEBAIC0xMzIsNyArMTMyLDcgQEAgc3RhdGljIGludCBpMmNfbXV4X2dwaW9f
cHJvYmVfZHQoc3RydWN0IGdwaW9tdXggKm11eCwNCj4+PiAgc3RhdGljIGludCBpMmNfbXV4X2dw
aW9fcHJvYmVfZHQoc3RydWN0IGdwaW9tdXggKm11eCwNCj4+PiAgCQkJCQlzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPj4+ICB7DQo+Pj4gLQlyZXR1cm4gMDsNCj4+PiArCXJldHVybiAt
RUlOVkFMOw0KPj4+ICB9DQo+Pj4gICNlbmRpZg0KPj4+ICANCj4+PiBAQCAtMTQyLDYgKzE0Miw5
IEBAIHN0YXRpYyBpbnQgaTJjX211eF9ncGlvX3Byb2JlX3BsYXQoc3RydWN0IGdwaW9tdXggKm11
eCwNCj4+PiAgCXN0cnVjdCBpMmNfbXV4X2dwaW9fcGxhdGZvcm1fZGF0YSAqZGF0YSA9IGRldl9n
ZXRfcGxhdGRhdGEoJnBkZXYtPmRldik7DQo+Pj4gIAlzdHJ1Y3QgZ3Bpb19jaGlwICpncGlvOw0K
Pj4+ICANCj4+PiArCWlmICghZGF0YSkNCj4+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+PiArDQo+
Pj4gIAkvKg0KPj4+ICAJICogSWYgYSBHUElPIGNoaXAgbmFtZSBpcyBwcm92aWRlZCwgdGhlIEdQ
SU8gcGluIG51bWJlcnMgcHJvdmlkZWQgYXJlDQo+Pj4gIAkgKiByZWxhdGl2ZSB0byBpdHMgYmFz
ZSBHUElPIG51bWJlci4gT3RoZXJ3aXNlIHRoZXkgYXJlIGFic29sdXRlLg0KPj4+IEBAIC0xNzUs
MTEgKzE3OCwxMCBAQCBzdGF0aWMgaW50IGkyY19tdXhfZ3Bpb19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPj4+ICAJaWYgKCFtdXgpDQo+Pj4gIAkJcmV0dXJuIC1FTk9NRU07
DQo+Pj4gIA0KPj4+IC0JaWYgKCFkZXZfZ2V0X3BsYXRkYXRhKCZwZGV2LT5kZXYpKQ0KPj4+ICsJ
cmV0ID0gaTJjX211eF9ncGlvX3Byb2JlX3BsYXQobXV4LCBwZGV2KTsNCj4+PiArCWlmIChyZXQp
DQo+Pj4gIAkJcmV0ID0gaTJjX211eF9ncGlvX3Byb2JlX2R0KG11eCwgcGRldik7DQo+Pj4gLQll
bHNlDQo+Pj4gLQkJcmV0ID0gaTJjX211eF9ncGlvX3Byb2JlX3BsYXQobXV4LCBwZGV2KTsNCj4+
PiAtCWlmIChyZXQgPCAwKQ0KPj4+ICsJaWYgKHJldCkNCj4+PiAgCQlyZXR1cm4gcmV0Ow0KPj4N
Cj4+IEkgbm90aWNlIHRoYXQgYWZ0ZXIgdGhpcyBwYXRjaCwgYWxsIHByb2JlIGZhaWx1cmVzIGZy
b20gbm9uLWR0IGNvbmZpZ3MNCj4+IHdpbGwgcmV0dXJuIC1FSU5WQUwgZnJvbSB0aGUgZHVtbXkg
aTJjX211eF9ncGlvX3Byb2JlX2R0IHRoYXQgZ2V0cw0KPj4gY2FsbGVkIG9uIGkyY19tdXhfZ3Bp
b19wcm9iZV9wbGF0IGZhaWx1cmUuDQo+Pg0KPj4gU28sIGFueSAtRVBST0JFX0RFRkVSIGlzIG5v
dyBsb3N0LiBUaGF0IHByb2JhYmx5IGRvZXNuJ3QgZmx5Lg0KPj4NCj4gDQo+IFNvIHdoYXQgZG8g
eW91IHN1Z2dlc3QgdGhlbj8NCg0KSSBkb24ndCBrbm93LCBJJ20ganVzdCBwb2ludGluZyBvdXQg
dGhhdCB5b3UgYXJlIGJyZWFraW5nIHByb2JlLWRlZmVyLg0KDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgV2UgY2FuIHJldHVybiB0byBzb21ldGhpbmcgbGlrZToNCj4gaWYgKGRldl9n
ZXRfcGxhdGRhdGEoJnBkZXYtPmRldikpDQo+ICAgICByZXQgPSBpMmNfbXV4X2dwaW9fcHJvYmVf
cGxhdChtdXgsIHBkZXYpOw0KPiBlbHNlDQo+ICAgICByZXQgPSBpMmNfbXV4X2dwaW9fcHJvYmVf
ZHQobXV4LCBwZGV2KTsNCj4gDQo+IEluIHRoaXMgY2FzZSB0aGVyZSBpcyBubyBmYWxsaW5nIGJh
Y2sgdG8gZHQuIEp1c3QgZWl0aGVyIHBsYXQtIG9yIG9mLWJhc2VkDQo+IGluaXRpYWxpemF0aW9u
LiBUaGUgc2FtZSBjYW4gYmUgZG9uZSBmb3IgaTJjX211eF9ncGlvX3JlcXVlc3RfKigpIG1ldGhv
ZHMuDQoNCldvcmtzIGZvciBtZSwgSSBmYWlsIHRvIHNlZSB3aHkgaXQgaXMgaW50ZXJlc3Rpbmcg
d2l0aCBhIGZhbGxiYWNrDQphbnl3YXk/IElmIHlvdSBzdXBwbHkgcGxhdGZvcm0gZGF0YSwgdGhh
dCBpcyBzdXBwb3NlZCB0byB0YWtlDQpwcmVjZWRlbmNlLiBObz8NCg0KSWYgdGhlIHBsYXRmb3Jt
IGRhdGEgZmFpbHMsIEknZCByYXRoZXIgbm90IGhhdmUgdGhlIGNvZGUgcnVuIGludG8gdGhlDQp3
ZWVkcyBhdHRlbXB0aW5nIHN0dWZmIHRoYXQncyBub3QgZXZlbiBzdXBwb3NlZCB0byB3b3JrLi4u
DQoNCkNoZWVycywNClBldGVyDQoNCj4gLVNlcmdleQ0KPiANCj4+IENoZWVycywNCj4+IFBldGVy
DQo+Pg0KPj4+ICANCj4+PiAgCXBhcmVudCA9IGkyY19nZXRfYWRhcHRlcihtdXgtPmRhdGEucGFy
ZW50KTsNCj4+Pg0KPj4NCg0K
