Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A091206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mcH+Lqg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfDLMNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:13:51 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:62129 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:13:50 -0400
X-IronPort-AV: E=Sophos;i="5.60,341,1549954800"; 
   d="scan'208";a="30001217"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Apr 2019 05:13:49 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 12 Apr 2019 05:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdh3Pj03um+xFx4zE198+EAn99wPCI+5Hck2lZtmIQQ=;
 b=mcH+Lqg+aeRpfZ/bSHyyHI7ZvzyWO49V5rBqnJQIXktredAcc7WkZJMHvH6ydRa0kFT28cMexsnf5jghvbBmwIF6KERu59NJF6PrqFXs6LwFmShVQbmlFR0Rz9Deeot8eiM8xxR/g7woOLLRR5XiftWWXBZZ32dfFGk/Yq6Yh+Q=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1434.namprd11.prod.outlook.com (10.172.36.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 12:13:46 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 12:13:46 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksloat@aampglobal.com>, <mchehab@kernel.org>
Subject: Re: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Topic: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Index: AQHU8Rk9Y6GORtaCfE+2SknPF+34OqY4ab0AgAACCACAAAJZAIAAAMgA
Date:   Fri, 12 Apr 2019 12:13:46 +0000
Message-ID: <9205d6e8-70b8-fda9-17be-7db8219eaf06@microchip.com>
References: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
 <1555064098-19310-2-git-send-email-eugen.hristev@microchip.com>
 <7978caee-9ae1-a428-af14-34bfa12ad223@xs4all.nl>
 <7461deba-eca0-24cb-f232-3dbade95c297@microchip.com>
 <48dc0a0e-85ba-0a77-effe-cb4fc17c74c5@xs4all.nl>
In-Reply-To: <48dc0a0e-85ba-0a77-effe-cb4fc17c74c5@xs4all.nl>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0192.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::16) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190412150916086
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c9816ec-b0da-4fdc-8882-08d6bf404fdb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1434;
x-ms-traffictypediagnostic: DM5PR11MB1434:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DM5PR11MB14349722B2399894AE4B519FE8280@DM5PR11MB1434.namprd11.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(39860400002)(346002)(199004)(189003)(68736007)(72206003)(25786009)(478600001)(5660300002)(966005)(14454004)(14444005)(6486002)(97736004)(105586002)(256004)(106356001)(6436002)(7736002)(305945005)(8676002)(81156014)(66066001)(81166006)(86362001)(31696002)(2201001)(316002)(110136005)(54906003)(31686004)(6512007)(6306002)(229853002)(4326008)(6246003)(76176011)(53936002)(52116002)(8936002)(53546011)(386003)(6506007)(3846002)(6116002)(36756003)(71200400001)(71190400001)(99286004)(2616005)(476003)(486006)(93886005)(11346002)(446003)(102836004)(26005)(186003)(2501003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1434;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A9JYtazQfS6CGeYlUwYq/9Zx1cNHoW0KGu3QNnyMZeaNDKd0LY90DzdY8wvuaa105+OFNyLqUME1SMEB8zZGZjRYkzbeCUsi25AAUKeKMLsmjtCpiqN9lBMJA7GpoO+Clro49p//fpMNfkHiv9Wxw4IvXkm1bErKT4CjZfxEi+lXYIzI9hYmVatNRi41eZCLU/ySH7TtAn81qcBnTXVnwF3Rys8zaqiTeeFELxx7Iuc7tHsYlRHuja1MvpjZaamE1sJtQ6t+JXo90in5oQwBYgQQq3DF5tdDjLuXx5O8s5zbOGU7hrNUHAH4WO8uufEyYTCirvWLZotBlClqe8UJjtZSnrDUS2zpJsdAjku5VNf1uQ2+REDvUiVNa7bSfaAEQi8qOnIoG9C7HA5nutGCZV2EKs+EeAkm8xP4xQ/5BcY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5735ED535AC9D44791065E96BAEB5AAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9816ec-b0da-4fdc-8882-08d6bf404fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 12:13:46.0625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLjA0LjIwMTkgMTU6MDYsIEhhbnMgVmVya3VpbCB3cm90ZToNCj4gRXh0ZXJuYWwg
RS1NYWlsDQo+IA0KPiANCj4gT24gNC8xMi8xOSAyOjAyIFBNLCBFdWdlbi5IcmlzdGV2QG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+Pg0KPj4NCj4+IE9uIDEyLjA0LjIwMTkgMTQ6NTAsIEhhbnMgVmVy
a3VpbCB3cm90ZToNCj4+DQo+Pj4NCj4+PiBPbiA0LzEyLzE5IDEyOjE5IFBNLCBFdWdlbi5Icmlz
dGV2QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+IEZyb206IEV1Z2VuIEhyaXN0ZXYgPGV1Z2Vu
LmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+Pj4NCj4+Pj4gVGhpcyB3aWxsIGxpbWl0IHRoZSBp
bmNvbWluZyBwaXhlbHMgcGVyIGZyYW1lIGZyb20gdGhlIHNlbnNvci4NCj4+Pj4gQ3VycmVudGx5
LCB0aGUgSVNDIHdpbGwgc3RvcCBzYW1wbGluZyB0aGUgZnJhbWUgb25seSB3aGVuIHRoZSB2c3lu
Yy9oc3luYw0KPj4+PiBhcmUgZGV0ZWN0ZWQuDQo+Pj4+IElmIHdlIG1pc2NvbmZpZ3VyZSB0aGUg
cmVzb2x1dGlvbiBpbiB0aGUgc2Vuc29yIHcuci50LiByZXNvbHV0aW9uIGluIHRoZSBJU0MsDQo+
Pj4+IHRoZSBidWZmZXIgdXNlZCBmb3IgRE1BIGluIHRoZSBJU0Mgd2lsbCBiZSBzbWFsbGVyIHRo
YW4gdGhlIG51bWJlciBvZiBwaXhlbHMNCj4+Pj4gdGhhdCB0aGUgSVNDIERNQSBlbmdpbmUgd2ls
bCBjb3B5Lg0KPj4+PiBJbiB0aGlzIGNhc2UgaXQgaGFwcGVucyB0aGF0IHRoZSBETUEgd2lsbCBv
dmVyd3JpdGUgcGFydHMgb2YgdGhlIG1lbW9yeSB3aGljaA0KPj4+PiBzaG91bGQgbm90IGJlIHdy
aXR0ZW4sIGxlYWRpbmcgdG8gbWVtb3J5IGNvcnJ1cHRpb24uDQo+Pj4+IFRvIGF2b2lkIHRoaXMg
c2l0dWF0aW9uLCB1c2UgdGhlIFBGRSBDRkcxIGFuZCBQRkUgQ0ZHMiByZWdpc3RlcnMsIHdoaWNo
IGNyb3ANCj4+Pj4gdGhlIGluY29taW5nIGZyYW1lIHRvIHRoZSByZXNvbHV0aW9uIHRoYXQgd2Ug
Y29uZmlndXJlLg0KPj4+PiBUaGlzIHdheSB0aGUgRE1BIGVuZ2luZSB3aWxsIG5ldmVyIHdyaXRl
IG1vcmUgZGF0YSB0aGFuIHdlIGV4cGVjdCBpdCB0by4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4+PiAtLS0N
Cj4+Pj4gICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MtcmVncy5oIHwg
MTkgKysrKysrKysrKysrKysrDQo+Pj4+ICAgIGRyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwv
YXRtZWwtaXNjLmMgICAgICB8IDM0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAg
ICAyIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXJlZ3MuaCBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXJlZ3MuaA0KPj4+PiBpbmRleCAyYWFk
YzE5Li43NjhhNWFkIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0
bWVsL2F0bWVsLWlzYy1yZWdzLmgNCj4+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9h
dG1lbC9hdG1lbC1pc2MtcmVncy5oDQo+Pj4+IEBAIC0zNSw2ICszNSwyNSBAQA0KPj4+PiAgICAj
ZGVmaW5lIElTQ19QRkdfQ0ZHMF9CUFNfVFdFTFZFICgweDAgPDwgMjgpDQo+Pj4+ICAgICNkZWZp
bmUgSVNDX1BGRV9DRkcwX0JQU19NQVNLICAgR0VOTUFTSygzMCwgMjgpDQo+Pj4+ICAgIA0KPj4+
PiArI2RlZmluZSBJU0NfUEZFX0NGRzBfQ09MRU4JQklUKDEyKQ0KPj4+PiArI2RlZmluZSBJU0Nf
UEZFX0NGRzBfUk9XRU4JQklUKDEzKQ0KPj4+PiArDQo+Pj4+ICsvKiBJU0MgUGFyYWxsZWwgRnJv
bnQgRW5kIENvbmZpZ3VyYXRpb24gMSBSZWdpc3RlciAqLw0KPj4+PiArI2RlZmluZSBJU0NfUEZF
X0NGRzEgICAgMHgwMDAwMDAxMA0KPj4+PiArDQo+Pj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMV9D
T0xNSU4odikJCSgodikpDQo+Pj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMV9DT0xNSU5fTUFTSwlH
RU5NQVNLKDE1LCAwKQ0KPj4+PiArI2RlZmluZSBJU0NfUEZFX0NGRzFfQ09MTUFYKHYpCQkoKHYp
IDw8IDE2KQ0KPj4+PiArI2RlZmluZSBJU0NfUEZFX0NGRzFfQ09MTUFYX01BU0sJR0VOTUFTSygz
MSwgMTYpDQo+Pj4+ICsNCj4+Pj4gKy8qIElTQyBQYXJhbGxlbCBGcm9udCBFbmQgQ29uZmlndXJh
dGlvbiAyIFJlZ2lzdGVyICovDQo+Pj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMiAgICAweDAwMDAw
MDE0DQo+Pj4+ICsNCj4+Pj4gKyNkZWZpbmUgSVNDX1BGRV9DRkcyX1JPV01JTih2KQkJKCh2KSkN
Cj4+Pj4gKyNkZWZpbmUgSVNDX1BGRV9DRkcyX1JPV01JTl9NQVNLCUdFTk1BU0soMTUsIDApDQo+
Pj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMl9ST1dNQVgodikJCSgodikgPDwgMTYpDQo+Pj4+ICsj
ZGVmaW5lIElTQ19QRkVfQ0ZHMl9ST1dNQVhfTUFTSwlHRU5NQVNLKDMxLCAxNikNCj4+Pj4gKw0K
Pj4+PiAgICAvKiBJU0MgQ2xvY2sgRW5hYmxlIFJlZ2lzdGVyICovDQo+Pj4+ICAgICNkZWZpbmUg
SVNDX0NMS0VOICAgICAgICAgICAgICAgMHgwMDAwMDAxOA0KPj4+PiAgICANCj4+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMgYi9kcml2ZXJz
L21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jDQo+Pj4+IGluZGV4IGExMGRiMTYuLmVh
NzUyMGEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRt
ZWwtaXNjLmMNCj4+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1p
c2MuYw0KPj4+PiBAQCAtNzIxLDYgKzcyMSw0MCBAQCBzdGF0aWMgdm9pZCBpc2Nfc3RhcnRfZG1h
KHN0cnVjdCBpc2NfZGV2aWNlICppc2MpDQo+Pj4+ICAgIAl1MzIgc2l6ZWltYWdlID0gaXNjLT5m
bXQuZm10LnBpeC5zaXplaW1hZ2U7DQo+Pj4+ICAgIAl1MzIgZGN0cmxfZHZpZXc7DQo+Pj4+ICAg
IAlkbWFfYWRkcl90IGFkZHIwOw0KPj4+PiArCXUzMiBoLCB3Ow0KPj4+PiArDQo+Pj4+ICsJaCA9
IGlzYy0+Zm10LmZtdC5waXguaGVpZ2h0Ow0KPj4+PiArCXcgPSBpc2MtPmZtdC5mbXQucGl4Lndp
ZHRoOw0KPj4+PiArDQo+Pj4+ICsJLyoNCj4+Pj4gKwkgKiBJbiBjYXNlIHRoZSBzZW5zb3IgaXMg
bm90IFJBVywgaXQgd2lsbCBvdXRwdXQgYSBwaXhlbCAoMTItMTYgYml0cykNCj4+Pj4gKwkgKiB3
aXRoIHR3byBzYW1wbGVzIG9uIHRoZSBJU0MgRGF0YSBidXMgKHdoaWNoIGlzIDgtMTIpDQo+Pj4+
ICsJICogSVNDIHdpbGwgY291bnQgZWFjaCBzYW1wbGUsIHNvLCB3ZSBuZWVkIHRvIG11bHRpcGx5
IHRoZXNlIHZhbHVlcw0KPj4+PiArCSAqIGJ5IHR3bywgdG8gZ2V0IHRoZSByZWFsIG51bWJlciBv
ZiBzYW1wbGVzIGZvciB0aGUgcmVxdWlyZWQgcGl4ZWxzLg0KPj4+PiArCSAqLw0KPj4+PiArCWlm
ICghSVNDX0lTX0ZPUk1BVF9SQVcoaXNjLT5jb25maWcuc2RfZm9ybWF0LT5tYnVzX2NvZGUpKSB7
DQo+Pj4NCj4+PiBUaGUgSVNDX0lTX0ZPUk1BVF9SQVcgZGVmaW5lIGRvZXNuJ3QgZXhpc3Q/IQ0K
Pj4+DQo+Pj4gU29tZXRoaW5nIGNsZWFybHkgd2VudCB3cm9uZy4uLg0KPj4+DQo+Pj4gUmVnYXJk
cywNCj4+Pg0KPj4+IAlIYW5zDQo+Pg0KPj4gSGVsbG8gSGFucywNCj4+DQo+PiBTb3JyeSAsIEkg
Zm9yZ290IHRvIGNvcHkgdGhpcyBmcm9tIHRoZSBwcmV2aW91cyBzZXJpZXMNCj4+IChodHRwczov
L3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1tZWRpYS9tc2cxNDk1MDEuaHRtbCBmb3IgcmVm
ZXJlbmNlKToNCj4+DQo+PiBJdCBhcHBsaWVzIG9ubHkgb24gdG9wIG9mIG15IHByZXZpb3VzIHBh
dGNoc2V0Og0KPj4gbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IHJlbW92ZWQgQVJHQjMyIGFkZGVk
IEFCR1IzMiBhbmQgWEJHUjMyDQo+PiBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogcmV3b3JrZWQg
ZHJpdmVyIGFuZCBmb3JtYXRzDQo+PiBhdmFpbGFibGUgYXQ6DQo+PiBodHRwczovL2dpdC5saW51
eHR2Lm9yZy9odmVya3VpbC9tZWRpYV90cmVlLmdpdC9jb21taXQvP2g9Zm9yLXY1LjJiJmlkPTAz
ZWYxYjU2Y2JhNmFkMTdmNmVhZDEzYzg1YTgxZTBlODBmYmM5ZDENCj4+DQo+PiBTbyBpdCBzaG91
bGQgd29yayBvbiB0b3Agb2YgdGhvc2UgcGF0Y2hlcy4uLg0KPiANCj4gQWgsIG5vdyBJIHNlZS4g
SSdsbCBwYXJrIHRoaXMgcGF0Y2ggc2VyaWVzIHVudGlsIHRoZSBwdWxsIHJlcXVlc3QgY29udGFp
bmluZw0KPiB0aG9zZSB0d28gcGF0Y2hlcyBpcyBtZXJnZWQuIEZlZWwgZnJlZSB0byByZW1pbmQg
bWUgb2YgdGhpcyBzZXJpZXMgb25jZSBNYXVybw0KPiBtZXJnZWQgdGhhdCBwdWxsIHJlcXVlc3Qu
DQoNClRoYW5rIHlvdS4NCg0KSSBtb3N0bHkgc2VudCB0aGlzIHNlcmllcyB0byBnZXQgeW91ciBl
YXJseSByZXZpZXcuIEl0IHdvdWxkIGJlIA0KaW1wb3J0YW50IHRvIGdldCB0aGUgbmV3IGZlYXR1
cmUgc2V0IGludGVncmF0ZWQsIHNvLCB0aGFuayB5b3UgZm9yIHRoYXQsIA0KYW5kIEkgd2lsbCBz
ZW5kIHRoZSB2MiBvbiB0aGUgbmV3IGZlYXR1cmUgc2V0LCBzbyBJIGNhbiB3b3JrIG9uIGl0IHVu
dGlsIA0KdGhlIGZpcnN0IHBhdGNoZXMgYXJlIG1lcmdlZC4NCg0KRXVnZW4NCg0KPiANCj4gUmVn
YXJkcywNCj4gDQo+IAlIYW5zDQo+IA0KPj4NCj4+IEV1Z2VuDQo+Pg0KPj4NCj4+Pg0KPj4+DQo+
Pj4+ICsJCWggPDw9IDE7DQo+Pj4+ICsJCXcgPDw9IDE7DQo+Pj4+ICsJfQ0KPj4+PiArDQo+Pj4+
ICsJLyoNCj4+Pj4gKwkgKiBXZSBsaW1pdCB0aGUgY29sdW1uL3JvdyBjb3VudCB0aGF0IHRoZSBJ
U0Mgd2lsbCBvdXRwdXQgYWNjb3JkaW5nDQo+Pj4+ICsJICogdG8gdGhlIGNvbmZpZ3VyZWQgcmVz
b2x1dGlvbiB0aGF0IHdlIHdhbnQuDQo+Pj4+ICsJICogVGhpcyB3aWxsIGF2b2lkIHRoZSBzaXR1
YXRpb24gd2hlcmUgdGhlIHNlbnNvciBpcyBtaXNjb25maWd1cmVkLA0KPj4+PiArCSAqIHNlbmRp
bmcgbW9yZSBkYXRhLCBhbmQgdGhlIElTQyB3aWxsIGp1c3QgdGFrZSBpdCBhbmQgRE1BIHRvIG1l
bW9yeSwNCj4+Pj4gKwkgKiBjYXVzaW5nIGNvcnJ1cHRpb24uDQo+Pj4+ICsJICovDQo+Pj4+ICsJ
cmVnbWFwX3dyaXRlKHJlZ21hcCwgSVNDX1BGRV9DRkcxLA0KPj4+PiArCQkgICAgIChJU0NfUEZF
X0NGRzFfQ09MTUlOKDApICYgSVNDX1BGRV9DRkcxX0NPTE1JTl9NQVNLKSB8DQo+Pj4+ICsJCSAg
ICAgKElTQ19QRkVfQ0ZHMV9DT0xNQVgodyAtIDEpICYgSVNDX1BGRV9DRkcxX0NPTE1BWF9NQVNL
KSk7DQo+Pj4+ICsNCj4+Pj4gKwlyZWdtYXBfd3JpdGUocmVnbWFwLCBJU0NfUEZFX0NGRzIsDQo+
Pj4+ICsJCSAgICAgKElTQ19QRkVfQ0ZHMl9ST1dNSU4oMCkgJiBJU0NfUEZFX0NGRzJfUk9XTUlO
X01BU0spIHwNCj4+Pj4gKwkJICAgICAoSVNDX1BGRV9DRkcyX1JPV01BWChoIC0gMSkgJiBJU0Nf
UEZFX0NGRzJfUk9XTUFYX01BU0spKTsNCj4+Pj4gKw0KPj4+PiArCXJlZ21hcF91cGRhdGVfYml0
cyhyZWdtYXAsIElTQ19QRkVfQ0ZHMCwNCj4+Pj4gKwkJCSAgIElTQ19QRkVfQ0ZHMF9DT0xFTiB8
IElTQ19QRkVfQ0ZHMF9ST1dFTiwNCj4+Pj4gKwkJCSAgIElTQ19QRkVfQ0ZHMF9DT0xFTiB8IElT
Q19QRkVfQ0ZHMF9ST1dFTik7DQo+Pj4+ICAgIA0KPj4+PiAgICAJYWRkcjAgPSB2YjJfZG1hX2Nv
bnRpZ19wbGFuZV9kbWFfYWRkcigmaXNjLT5jdXJfZnJtLT52Yi52YjJfYnVmLCAwKTsNCj4+Pj4g
ICAgCXJlZ21hcF93cml0ZShyZWdtYXAsIElTQ19EQUQwLCBhZGRyMCk7DQo+Pj4+DQo+Pj4NCj4+
Pg0KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
Pj4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4+PiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCj4+Pg0KPj4+DQo+IA0K
