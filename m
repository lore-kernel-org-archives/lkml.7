Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D909C18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3B120856
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L1RS/QPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfEVKps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:45:48 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:62528
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVKpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLc/HeO2V1FK+dmbc9RMmsuQNwyYjAXzWs6MkksZ2Uc=;
 b=L1RS/QPTJQat+vV7lZ4BiFLbYqAvhkDoQJ524RNGv5tzWF036m4J+gH3frKhS4g7QpMqSEoZMqdQo1IJUuPhMfs8ho8iS6FQjWX44pa+PKHJRz6KgDTJm5xyo7807p3bDlKQUkw1qa5uxBw+z1AsesxTzX0Bx204U1Kq9nBn8fs=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.50.159) by
 VI1PR04MB4895.eurprd04.prod.outlook.com (20.177.49.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 22 May 2019 10:45:36 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::8d0e:de86:9b49:b40%7]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:45:36 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     "hch@lst.de" <hch@lst.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v5 2/5] USB: use genalloc for USB HCs with local memory
Thread-Topic: [PATCH v5 2/5] USB: use genalloc for USB HCs with local memory
Thread-Index: AQHVD96XE7hyjPzMhU2tA8mX94cqtKZ10zeAgAEkBIA=
Date:   Wed, 22 May 2019 10:45:35 +0000
Message-ID: <cb0612c3-4429-7ac9-e885-64407f8a406b@nxp.com>
References: <Pine.LNX.4.44L0.1905211309270.1634-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1905211309270.1634-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29a75ad3-713f-4f45-c954-08d6dea29f68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4895;
x-ms-traffictypediagnostic: VI1PR04MB4895:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB4895A273513FF6BA216FE203EC000@VI1PR04MB4895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(189003)(199004)(8936002)(256004)(81156014)(81166006)(54906003)(486006)(8676002)(14444005)(31686004)(11346002)(966005)(446003)(14454004)(68736007)(71200400001)(71190400001)(66946007)(66476007)(73956011)(4326008)(76116006)(66446008)(64756008)(66556008)(229853002)(476003)(25786009)(5660300002)(6116002)(2616005)(86362001)(6486002)(45080400002)(498600001)(6506007)(6436002)(66066001)(53546011)(31696002)(53936002)(76176011)(7736002)(44832011)(26005)(99286004)(36756003)(186003)(6512007)(305945005)(2906002)(102836004)(6306002)(2171002)(6916009)(6246003)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4895;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QvPwOB5FJvC/Im4Eyj3G2UB7J8f4NR1RmlB6CA8kQPBUFroG2N8iv1OmiE2DKayMy2SEgsfPhyP+movg3GYezzIa7HJfdeaThJMwQ1YYzzRWOhmwt8xTUjx4ECzkE4ZPX4q33bRCxwAdW5pzUy4FAAmMBO/59mBu4MVho8HXZGxy29whLxZ2OZlz8RYvqf65+1F8NoTnmYY+CUmMhKjiJtYljRXacMNyZbCpJclVEpVhPI8ix1hNhuzTYIxoVX0S889NJp2AiX4jU5ZvUnsGsYHwDmfMiMaK+aEi5iTgMPli+jgCySEQE0KfDBZrfaLDc8TLs9KJJXls07KDqCKz7ACsrpCeXNIA9q+5rdOWt0iVx3jREZt4bXJ/iNO4+1mfLW5mEKMzhSX50QRq6ET5YqGt4GUY/6+0rJzbz2nZIaw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <489EE7882392F046AE8D9C8A45104BA8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a75ad3-713f-4f45-c954-08d6dea29f68
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:45:35.8637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQWxhbiwNCg0KT24gMjEuMDUuMjAxOSAyMDoyMCwgQWxhbiBTdGVybiB3cm90ZToNCj4g
T24gVHVlLCAyMSBNYXkgMjAxOSBsYXVyZW50aXUudHVkb3JAbnhwLmNvbSB3cm90ZToNCj4gDQo+
PiBGcm9tOiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPj4NCj4+
IEZvciBIQ3MgdGhhdCBoYXZlIGxvY2FsIG1lbW9yeSwgcmVwbGFjZSB0aGUgY3VycmVudCBETUEg
QVBJIHVzYWdlDQo+PiB3aXRoIGEgZ2VuYWxsb2MgZ2VuZXJpYyBhbGxvY2F0b3IgdG8gbWFuYWdl
IHRoZSBtYXBwaW5ncyBmb3IgdGhlc2UNCj4+IGRldmljZXMuIFRvIGhlbHAgdXNlcnMsIGludHJv
ZHVjZSBhIG5ldyBIQ0QgQVBJLA0KPj4gdXNiX2hjZF9zZXR1cF9sb2NhbF9tZW0oKSB0aGF0IHdp
bGwgc2V0dXAgdXAgdGhlIGdlbmFsbG9jIGJhY2tpbmcNCj4+IHVwIHRoZSBkZXZpY2UgbG9jYWwg
bWVtb3J5LiBJdCB3aWxsIGJlIHVzZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVzLg0KPj4gVGhpcyBp
cyBpbiBwcmVwYXJhdGlvbiBmb3IgZHJvcHBpbmcgdGhlIGV4aXN0aW5nICJjb2hlcmVudCIgZG1h
DQo+PiBtZW0gZGVjbGFyYXRpb24gQVBJcy4gQ3VycmVudCBpbXBsZW1lbnRhdGlvbiB3YXMgcmVs
eWluZyBvbiBhIHNob3J0DQo+PiBjaXJjdWl0IGluIHRoZSBETUEgQVBJIHRoYXQgaW4gdGhlIGVu
ZCwgd2FzIGFjdGluZyBhcyBhbiBhbGxvY2F0b3INCj4+IGZvciB0aGVzZSB0eXBlIG9mIGRldmlj
ZXMuDQo+Pg0KPj4gRm9yIGNvbnRleHQsIHNlZSB0aHJlYWQgaGVyZTogaHR0cHM6Ly9ldXIwMS5z
YWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbGttbC5v
cmclMkZsa21sJTJGMjAxOSUyRjQlMkYyMiUyRjM1NyZhbXA7ZGF0YT0wMiU3QzAxJTdDbGF1cmVu
dGl1LnR1ZG9yJTQwbnhwLmNvbSU3Q2RjNGE3NmIwNGI4NzRiNzViZDU0MDhkNmRlMTA5ZDg2JTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjk0MDU2MDI4MTk1
NzIwNyZhbXA7c2RhdGE9SlExaUpjJTJGdyUyQndIZFRGdmFPVCUyRllIQnglMkJWUWxwSFdsZjM0
NnE3c2NsZmNnJTNEJmFtcDtyZXNlcnZlZD0wDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGF1cmVu
dGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IEZy
ZWRyaWsgTm9yaW5nIDxub3JpbmdAbm9jcmV3Lm9yZz4NCj4+IC0tLQ0KPiANCj4+IC0tLSBhL2Ry
aXZlcnMvdXNiL2NvcmUvaGNkLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NvcmUvaGNkLmMNCj4+
IEBAIC0yOSw2ICsyOSw4IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC93b3JrcXVldWUuaD4NCj4+
ICAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3R5
cGVzLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L2dlbmFsbG9jLmg+DQo+PiArI2luY2x1ZGUgPGxp
bnV4L2lvLmg+DQo+PiAgIA0KPj4gICAjaW5jbHVkZSA8bGludXgvcGh5L3BoeS5oPg0KPj4gICAj
aW5jbHVkZSA8bGludXgvdXNiLmg+DQo+PiBAQCAtMzAzOSw2ICszMDQxLDQwIEBAIHVzYl9oY2Rf
cGxhdGZvcm1fc2h1dGRvd24oc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KPj4gICB9DQo+
PiAgIEVYUE9SVF9TWU1CT0xfR1BMKHVzYl9oY2RfcGxhdGZvcm1fc2h1dGRvd24pOw0KPj4gICAN
Cj4+ICtpbnQgdXNiX2hjZF9zZXR1cF9sb2NhbF9tZW0oc3RydWN0IHVzYl9oY2QgKmhjZCwgcGh5
c19hZGRyX3QgcGh5c19hZGRyLA0KPj4gKwkJCSAgICBkbWFfYWRkcl90IGRtYSwgc2l6ZV90IHNp
emUpDQo+PiArew0KPj4gKwlpbnQgZXJyOw0KPj4gKwl2b2lkIF9faW9tZW0gKmxvY2FsX21lbTsN
Cj4+ICsNCj4+ICsJaGNkLT5sb2NhbG1lbV9wb29sID0gZGV2bV9nZW5fcG9vbF9jcmVhdGUoaGNk
LT5zZWxmLnN5c2RldiwgUEFHRV9TSElGVCwNCj4+ICsJCQkJCQkgIGRldl90b19ub2RlKGhjZC0+
c2VsZi5zeXNkZXYpLA0KPj4gKwkJCQkJCSAgIm9oY2ktaGNkIik7DQo+IA0KPiBTdXJlbHkgdGhh
dCBzdHJpbmcgaXMgYSBtaXN0YWtlLiAgWW91IGNvdWxkIHVzZQ0KPiBkZXZfbmFtZShoY2QtPnNl
bGYuc3lzZGV2KSBvciBhIG5hbWUgcGFzc2VkIGJ5IHRoZSBjYWxsZXIuDQoNClNvcnJ5LCBtaXNz
ZWQgdGhhdC4gV2lsbCBnbyB3aXRoIGRldl9uYW1lKCkgaWYgdGhhdCdzIG9rIHdpdGggeW91Lg0K
DQo+PiArCWlmIChJU19FUlIoaGNkLT5sb2NhbG1lbV9wb29sKSkNCj4+ICsJCXJldHVybiBQVFJf
RVJSKGhjZC0+bG9jYWxtZW1fcG9vbCk7DQo+PiArDQo+PiArCWxvY2FsX21lbSA9IGRldm1fbWVt
cmVtYXAoaGNkLT5zZWxmLnN5c2RldiwgcGh5c19hZGRyLA0KPj4gKwkJCQkgIHNpemUsIE1FTVJF
TUFQX1dDKTsNCj4+ICsJaWYgKCFsb2NhbF9tZW0pDQo+PiArCQlyZXR1cm4gLUVOT01FTTsNCj4+
ICsNCj4+ICsJLyoNCj4+ICsJICogSGVyZSB3ZSBwYXNzIGEgZG1hX2FkZHJfdCBidXQgdGhlIGFy
ZyB0eXBlIGlzIGEgcGh5c19hZGRyX3QuDQo+PiArCSAqIEl0J3Mgbm90IGJhY2tlZCBieSBzeXN0
ZW0gbWVtb3J5IGFuZCB0aHVzIHRoZXJlJ3Mgbm8ga2VybmVsIG1hcHBpbmcNCj4+ICsJICogZm9y
IGl0Lg0KPj4gKwkgKi8NCj4+ICsJZXJyID0gZ2VuX3Bvb2xfYWRkX3ZpcnQoaGNkLT5sb2NhbG1l
bV9wb29sLCAodW5zaWduZWQgbG9uZylsb2NhbF9tZW0sDQo+PiArCQkJCWRtYSwgc2l6ZSwgZGV2
X3RvX25vZGUoaGNkLT5zZWxmLnN5c2RldikpOw0KPj4gKwlpZiAoZXJyIDwgMCkgew0KPj4gKwkJ
ZGV2X2VycihoY2QtPnNlbGYuc3lzZGV2LCAiZ2VuX3Bvb2xfYWRkX3ZpcnQgZmFpbGVkIHdpdGgg
JWRcbiIsDQo+PiArCQkJZXJyKTsNCj4+ICsJCXJldHVybiBlcnI7DQo+PiArCX0NCj4+ICsNCj4+
ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1CT0xfR1BMKHVzYl9oY2Rfc2V0dXBf
bG9jYWxfbWVtKTsNCj4gDQo+IElmIHlvdSBoYXZlIGEgdXNiX2hjZF9zZXR1cF9sb2NhbF9tZW0o
KSBmdW5jdGlvbiB0aGVuIHlvdSBzaG91bGQgYWxzbw0KPiBoYXZlIGEgdXNiX2hjZF9yZW1vdmVf
bG9jYWxfbWVtKCkgZnVuY3Rpb24uDQoNCkV2ZW4gaWYgYWxsIHJlc291cmNlcyB0aGF0IGFyZSBh
bGxvY2F0ZWQgYXJlIGRldmljZSBtYW5hZ2VkPw0KDQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0
L29oY2ktbWVtLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1tZW0uYw0KPj4gQEAg
LTM2LDYgKzM2LDEyIEBAIHN0YXRpYyB2b2lkIG9oY2lfaGNkX2luaXQgKHN0cnVjdCBvaGNpX2hj
ZCAqb2hjaSkNCj4+ICAgDQo+PiAgIHN0YXRpYyBpbnQgb2hjaV9tZW1faW5pdCAoc3RydWN0IG9o
Y2lfaGNkICpvaGNpKQ0KPj4gICB7DQo+PiArCWlmIChvaGNpX3RvX2hjZChvaGNpKS0+bG9jYWxt
ZW1fcG9vbCkgew0KPj4gKwkJb2hjaS0+dGRfY2FjaGUgPSBOVUxMOw0KPj4gKwkJb2hjaS0+ZWRf
Y2FjaGUgPSBOVUxMOw0KPj4gKwkJcmV0dXJuIDA7DQo+PiArCX0NCj4gDQo+IFRoaXMgcmVhbGx5
IGlzbid0IG5lY2Vzc2FyeS4gIFRoZSBlbnRpcmUgb2hjaV9oY2Qgc3RydWN0dXJlIGlzDQo+IGlu
aXRpYWxpemVkIHRvIDAgd2hlbiBpdCBpcyBmaXJzdCBhbGxvY2F0ZWQuDQoNCldpbGwgZHJvcC4N
Cg0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC91c2IvaGNkLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGlu
dXgvdXNiL2hjZC5oDQo+PiBAQCAtMjE2LDYgKzIxNiw5IEBAIHN0cnVjdCB1c2JfaGNkIHsNCj4+
ICAgI2RlZmluZQlIQ19JU19SVU5OSU5HKHN0YXRlKSAoKHN0YXRlKSAmIF9fQUNUSVZFKQ0KPj4g
ICAjZGVmaW5lCUhDX0lTX1NVU1BFTkRFRChzdGF0ZSkgKChzdGF0ZSkgJiBfX1NVU1BFTkQpDQo+
PiAgIA0KPj4gKwkvKiBhbGxvY2F0b3IgZm9yIEhDcyBoYXZpbmcgbG9jYWwgbWVtb3J5ICovDQo+
IA0KPiAiYWxsb2NhdG9yIiBpcyB0aGUgd3Jvbmcgd29yZCAtLSBhbiBhbGxvY2F0b3IgaXMgc29t
ZXRoaW5nIHRoYXQNCj4gYWxsb2NhdGVzLiAgUGVyaGFwcyAibWVtb3J5IGFyZWEiIG9yIHNvbWV0
aGluZyBhbG9uZyB0aG9zZSBsaW5lcy4NCg0KQWxyaWdodCwgSSB3aWxsIHJld29yay4NCg0KLS0t
DQpUaGFua3MgJiBCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ0K
