Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7C0C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C5F82087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M9Lragko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfEPJfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:35:33 -0400
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:28227
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfEPJfd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvo5TcoxtKsrr+jgblm8ThGwIsfGMBVrVHMH7gTZVrE=;
 b=M9LragkoVsk5lwOwD7cbqvwFbN38K1nDM7m/WE8KYuMEQMoA+xAJp8vOgKtmD9KUe41vDWQa6X5s1+VlnbS2gPFT9wuxIvDgyqC7/PV50wlW5gtii2vT1/wKhwRB7vfZmRJXUsJKuz/76CLpg6eEKiJiWXzSVfbnT8r9eRUSocs=
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com (20.176.235.28) by
 DB7PR04MB4362.eurprd04.prod.outlook.com (52.135.131.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Thu, 16 May 2019 09:35:27 +0000
Received: from DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::3cde:1777:e184:52ac]) by DB7PR04MB5132.eurprd04.prod.outlook.com
 ([fe80::3cde:1777:e184:52ac%4]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 09:35:27 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Topic: [RFC PATCH v2 0/3] prerequisites for device reserved local mem
 rework
Thread-Index: AQHVCmKoDp6AVawLEEugEGZuSLgHU6Zqu4uAgAA1oICAAQ5TAIAAYlQAgAEezIA=
Date:   Thu, 16 May 2019 09:35:27 +0000
Message-ID: <0fea5fa7-e2b0-b34d-3bf8-976007df2dc2@nxp.com>
References: <20190514143807.7745-1-laurentiu.tudor@nxp.com>
 <9d34015d-c219-179b-3141-4b0de3530ac3@arm.com> <20190514182931.GA2559@sx9>
 <0e5f3b86-7a80-eec7-691b-34a123194208@nxp.com> <20190515162858.GB17162@sx9>
In-Reply-To: <20190515162858.GB17162@sx9>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cc2bbb3-c465-4b3b-167c-08d6d9e1d4af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4362;
x-ms-traffictypediagnostic: DB7PR04MB4362:
x-microsoft-antispam-prvs: <DB7PR04MB4362FE24463754E8D7BE11A4EC0A0@DB7PR04MB4362.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(51444003)(199004)(189003)(66946007)(66446008)(64756008)(73956011)(66476007)(66556008)(76116006)(91956017)(316002)(68736007)(5660300002)(76176011)(6512007)(99286004)(54906003)(7736002)(229853002)(6436002)(6486002)(2906002)(66066001)(31686004)(256004)(14444005)(8676002)(81156014)(81166006)(11346002)(6916009)(8936002)(4326008)(486006)(31696002)(53546011)(44832011)(6246003)(2616005)(36756003)(71190400001)(476003)(71200400001)(25786009)(478600001)(102836004)(26005)(305945005)(6506007)(86362001)(53936002)(446003)(3846002)(14454004)(6116002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4362;H:DB7PR04MB5132.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xrcOF2dWCbeHIeqt3YVFLJKm2XDttthrObmrZDXcPMu72ccOe4E+Mlk2ojgnzT/RqHUbaTAWtcmNyragjbW7ZQYRgEI+cIpUxxgzvHaDmCuUmekpQKlx+ZsqsuanNy7XVs0aTn/DWQZFHrCR+A11HWErh2f8eN/g2PWAN1n1lQ2nk4tpgD2X88kPqZTfhU/Ch8RNMufsonDgPUvXe25y/yhJ7DSDE+NiCBLZ+TgJwg4OaMXr8H0h57csP7e+pl9NT9nAUdeq0wyvchowIWviHbt/Aojdm5t9rX30MGVuRwxJr3otlbyAECFEEEyg2qieD5ok96Yc649aRZxwtQ0K2Pal2xyShwiOBRj3Pj1yYWBp3hXNa2mrX8cbi13EFex/qtaRzYKsE6YWYdVzo11UD3wCJ30tFLd6lnso1gjaLNg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFBE18303F803245807D4C8C7EE71589@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc2bbb3-c465-4b3b-167c-08d6d9e1d4af
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 09:35:27.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4362
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJlZHJpaywNCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgdGFraW5nIHRoZSB0aW1lIHRvIGxv
b2sgaW50byB0aGlzLiBQbGVhc2Ugc2VlIA0KY29tbWVudHMgaW5saW5lLg0KDQpPbiAxNS4wNS4y
MDE5IDE5OjI4LCBGcmVkcmlrIE5vcmluZyB3cm90ZToNCj4gSGkgTGF1cmV0bml1LA0KPiANCj4+
IEkgdGhpbmsgdGhhdCBhbnkgcmVjZW50IGtlcm5lbCB3aWxsIGRvLCBzbyBJJ2Qgc2F5IHlvdXIg
Y3VycmVudCBicmFuY2gNCj4+IHNob3VsZCBiZSBmaW5lLg0KPiANCj4gVGhlIGtlcm5lbCBvb3Bz
ZXMgd2l0aCAidW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVh
bA0KPiBhZGRyZXNzIDAwMGFiYTBiIiBpbiBoY2RfYWxsb2NfY29oZXJlbnQgdmlhIHVzYl9oY2Rf
bWFwX3VyYl9mb3JfZG1hLiANCg0KQnkgYW55IGNoYW5jZSwgZG9lcyB0aGlzIGFkZHJlc3MgbG9v
a3MgbGlrZSB0aGUgZG1hX2FkZHIgdGhhdCB0aGUgZGV2aWNlIA0Kc2hvdWxkIHRhcmdldD8NCg0K
PiBUaGlzIHJlbGF0ZXMgdG8gcGF0Y2ggMi8zIHRoYXQgSSBkaWRuJ3QgcXVpdGUgdW5kZXJzdGFu
ZCwgd2hlcmUNCj4gDQo+IC0JcmV0dmFsID0gZG1hX2RlY2xhcmVfY29oZXJlbnRfbWVtb3J5KGRl
diwgbWVtLT5zdGFydCwNCj4gLQkJCQkJIG1lbS0+c3RhcnQgLSBtZW0tPnBhcmVudC0+c3RhcnQs
DQo+IC0JCQkJCSByZXNvdXJjZV9zaXplKG1lbSkpOw0KPiANCj4gYmVjb21lcw0KPiANCj4gKwly
ZXR2YWwgPSBnZW5fcG9vbF9hZGRfdmlydChoY2QtPmxvY2FsbWVtX3Bvb2wsDQo+ICsJCQkJICAg
KHVuc2lnbmVkIGxvbmcpbWVtLT5zdGFydCAtDQo+ICsJCQkJCW1lbS0+cGFyZW50LT5zdGFydCwN
Cj4gKwkJCQkgICBtZW0tPnN0YXJ0LCByZXNvdXJjZV9zaXplKG1lbSksDQo+IA0KPiBzbyB0aGF0
IGFyZ3VtZW50cyB0d28gYW5kIHRocmVlIHN3aXRjaCBwbGFjZXMuIEdpdmVuDQo+IA0KPiBpbnQg
ZG1hX2RlY2xhcmVfY29oZXJlbnRfbWVtb3J5KHN0cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRy
X3QgcGh5c19hZGRyLA0KPiAJCQkJZG1hX2FkZHJfdCBkZXZpY2VfYWRkciwgc2l6ZV90IHNpemUp
Ow0KPiANCj4gYW5kDQo+IA0KPiBpbnQgZ2VuX3Bvb2xfYWRkX3ZpcnQoc3RydWN0IGdlbl9wb29s
ICpwb29sLCB1bnNpZ25lZCBsb25nIHZpcnQsIHBoeXNfYWRkcl90IHBoeXMNCj4gCQkgc2l6ZV90
IHNpemUsIGludCBuaWQpDQo+IA0KPiBpdCBzZWVtcyB0aGF0IHRoZSBkZXZpY2UgYWRkcmVzcyAo
ZG1hX2FkZHJfdCBkZXZpY2VfYWRkcikgbm93IGJlY29tZXMgYQ0KPiB2aXJ0dWFsIGFkZHJlc3Mg
KHVuc2lnbmVkIGxvbmcgdmlydCkuIElzIHRoYXQgaW50ZW5kZWQ/DQoNCkFjdHVhbGx5LCBJIHRo
aW5rIEknbSBtaXN1c2luZyBnZW5hbGxvYyBhbmQgYWxzbyBpdCBhcHBlYXJzIHRoYXQgaSBuZWVk
IA0KdG8gYWRkIGEgbWFwcGluZyBvbiB0aGUgcGh5cyBhZGRyZXNzLiBTbyBteSBwbGFuIGlzIHRv
IGNoYW5nZSB0aGUgDQoidW5zaWduZWQgbG9uZyB2aXJ0IiB0byBiZSB0aGUgdm9pZCAqIHJldHVy
bmVkIGJ5IHRoZSBtYXBwaW5nIG9wZXJhdGlvbiANCmFuZCB0aGUgcGh5c19hZGRyX3QgYmUgdGhl
IGRtYV9hZGRyX3QuIEknbGwgcmV0dXJuIHdpdGggYSBwYXRjaC4NCg0KUmVnYXJkaW5nIHRoZSB1
c2FnZSBvZiB1bnNpZ25lZCBsb25nIGluIGdlbmFsbG9jLCB5ZWFoIHNlZW1zIGEgYml0IA0Kc3Ry
YW5nZSBidXQgYnkgbG9va2luZyBhdCBvdGhlciB1c2VycyBpbiB0aGUga2VybmVsIGl0IGFwcGVh
cnMgdGhhdCANCnRoYXQncyB0aGUgZGVzaWduLg0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVu
dGl1DQoNCj4gTXkgY29ycmVzcG9uZGluZyBwYXRjaCBpcyBiZWxvdyBmb3IgcmVmZXJlbmNlLiBJ
IGFwcGxpZWQgeW91ciAxLzMgcGF0Y2gNCj4gdG8gdGVzdCBpdC4NCj4gDQo+IEZyZWRyaWsNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L29oY2ktcHMyLmMgYi9kcml2ZXJzL3Vz
Yi9ob3N0L29oY2ktcHMyLmMNCj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC9vaGNpLXBzMi5jDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1wczIuYw0KPiBAQCAtNyw2ICs3LDcgQEANCj4g
ICAgKi8NCj4gICANCj4gICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9nZW5hbGxvYy5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L3VzYi5oPg0KPiBAQCAtOTIsMTIgKzkzLDEyIEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBvaGNpX3Bz
Ml9pcnEoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4gICAJcmV0dXJuIG9oY2lfaXJxKGhjZCk7IC8q
IENhbGwgbm9ybWFsIElSUSBoYW5kbGVyLiAqLw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBpbnQg
aW9waGVhcF9hbGxvY19jb2hlcmVudChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAt
CXNpemVfdCBzaXplLCBpbnQgZmxhZ3MpDQo+ICtzdGF0aWMgaW50IGlvcGhlYXBfYWxsb2NfY29o
ZXJlbnQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc2l6ZV90IHNpemUpDQo+ICAgew0K
PiAgIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgIAlzdHJ1Y3QgdXNiX2hj
ZCAqaGNkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAgCXN0cnVjdCBwczJfaGNk
ICpwczJwcml2ID0gaGNkX3RvX3ByaXYoaGNkKTsNCj4gKwlpbnQgZXJyOw0KPiAgIA0KPiAgIAlp
ZiAocHMycHJpdi0+aW9wX2RtYV9hZGRyICE9IDApDQo+ICAgCQlyZXR1cm4gMDsNCj4gQEAgLTEx
MiwyOCArMTEzLDM3IEBAIHN0YXRpYyBpbnQgaW9waGVhcF9hbGxvY19jb2hlcmVudChzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgCX0NCj4g
ICANCj4gLQlpZiAoZG1hX2RlY2xhcmVfY29oZXJlbnRfbWVtb3J5KGRldiwNCj4gLQkJCWlvcF9i
dXNfdG9fcGh5cyhwczJwcml2LT5pb3BfZG1hX2FkZHIpLA0KPiAtCQkJcHMycHJpdi0+aW9wX2Rt
YV9hZGRyLCBzaXplLCBmbGFncykpIHsNCj4gLQkJZGV2X2VycihkZXYsICJkbWFfZGVjbGFyZV9j
b2hlcmVudF9tZW1vcnkgZmFpbGVkXG4iKTsNCj4gLQkJaW9wX2ZyZWUocHMycHJpdi0+aW9wX2Rt
YV9hZGRyKTsNCj4gLQkJcHMycHJpdi0+aW9wX2RtYV9hZGRyID0gMDsNCj4gLQkJcmV0dXJuIC1F
Tk9NRU07DQo+ICsJaGNkLT5sb2NhbG1lbV9wb29sID0gZGV2bV9nZW5fcG9vbF9jcmVhdGUoZGV2
LA0KPiArCQlQQUdFX1NISUZULCBkZXZfdG9fbm9kZShkZXYpLCBEUlZfTkFNRSk7DQo+ICsJaWYg
KElTX0VSUihoY2QtPmxvY2FsbWVtX3Bvb2wpKSB7DQo+ICsJCWVyciA9IFBUUl9FUlIoaGNkLT5s
b2NhbG1lbV9wb29sKTsNCj4gKwkJZ290byBvdXRfZXJyOw0KPiArCX0NCj4gKw0KPiArCWVyciA9
IGdlbl9wb29sX2FkZF92aXJ0KGhjZC0+bG9jYWxtZW1fcG9vbCwgcHMycHJpdi0+aW9wX2RtYV9h
ZGRyLA0KPiArCQlpb3BfYnVzX3RvX3BoeXMocHMycHJpdi0+aW9wX2RtYV9hZGRyKSwgc2l6ZSwg
ZGV2X3RvX25vZGUoZGV2KSk7DQo+ICsJaWYgKGVyciA8IDApIHsNCj4gKwkJZGV2X2VycihkZXYs
ICJnZW5fcG9vbF9hZGRfdmlydCBmYWlsZWQgd2l0aCAlZFxuIiwgZXJyKTsNCj4gKwkJZ290byBv
dXRfZXJyOw0KPiAgIAl9DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KPiArDQo+ICtvdXRfZXJyOg0K
PiArCWlvcF9mcmVlKHBzMnByaXYtPmlvcF9kbWFfYWRkcik7DQo+ICsJcHMycHJpdi0+aW9wX2Rt
YV9hZGRyID0gMDsNCj4gKw0KPiArCXJldHVybiBlcnI7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRp
YyB2b2lkIGlvcGhlYXBfZnJlZV9jb2hlcmVudChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgIHsNCj4gLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgIAlzdHJ1
Y3QgdXNiX2hjZCAqaGNkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7DQo+ICAgCXN0cnVj
dCBwczJfaGNkICpwczJwcml2ID0gaGNkX3RvX3ByaXYoaGNkKTsNCj4gICANCj4gICAJaWYgKHBz
MnByaXYtPmlvcF9kbWFfYWRkciA9PSAwKQ0KPiAgIAkJcmV0dXJuOw0KPiAgIA0KPiAtCWRtYV9y
ZWxlYXNlX2RlY2xhcmVkX21lbW9yeShkZXYpOw0KPiAgIAlpb3BfZnJlZShwczJwcml2LT5pb3Bf
ZG1hX2FkZHIpOw0KPiAgIAlwczJwcml2LT5pb3BfZG1hX2FkZHIgPSAwOw0KPiAgIH0NCj4gQEAg
LTE3Nyw4ICsxODcsNyBAQCBzdGF0aWMgaW50IG9oY2lfaGNkX3BzMl9wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAkJZ290byBlcnI7DQo+ICAgCX0NCj4gICANCj4gLQly
ZXQgPSBpb3BoZWFwX2FsbG9jX2NvaGVyZW50KHBkZXYsDQo+IC0JCURNQV9CVUZGRVJfU0laRSwg
RE1BX01FTU9SWV9FWENMVVNJVkUpOw0KPiArCXJldCA9IGlvcGhlYXBfYWxsb2NfY29oZXJlbnQo
cGRldiwgRE1BX0JVRkZFUl9TSVpFKTsNCj4gICAJaWYgKHJldCAhPSAwKQ0KPiAgIAkJZ290byBl
cnJfYWxsb2NfY29oZXJlbnQ7DQo+ICAgDQo+IA==
