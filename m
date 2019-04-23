Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2958BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D008A21773
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="menY5NOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfDWNrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:47:14 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45561 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfDWNrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:47:14 -0400
X-IronPort-AV: E=Sophos;i="5.60,386,1549954800"; 
   d="scan'208";a="30871785"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Apr 2019 06:47:12 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.107) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 23 Apr 2019 06:47:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlBBGc+tsUT87kzGPHYkSSuV3xYy9gMIzvWNyimj1Gs=;
 b=menY5NOylVpk28AJAinRxNjeJ8lomYyXtcWnmM1fEp6kZbcg7BsTFY3d0FurvB9TjdM4qhgAybxFtTgrJxRCCACy8LCQS8X+Dc+F/ryS3VqSnSCD9QdvOiz2DEWtiqKbfJVwwzkuy32h3GHyT0wEmq1JHzFaFP57oYAMc605wFQ=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1372.namprd11.prod.outlook.com (10.168.106.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 23 Apr 2019 13:47:10 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1835.010; Tue, 23 Apr 2019
 13:47:10 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksloat@aampglobal.com>, <mchehab@kernel.org>
Subject: Re: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Topic: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Index: AQHU8Rk9Y6GORtaCfE+2SknPF+34OqY4ab0AgAACCACAAAJZAIAAAMgAgBFjvgA=
Date:   Tue, 23 Apr 2019 13:47:10 +0000
Message-ID: <b7610881-e7e7-5c34-3dc8-c2f5ffe417d3@microchip.com>
References: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
 <1555064098-19310-2-git-send-email-eugen.hristev@microchip.com>
 <7978caee-9ae1-a428-af14-34bfa12ad223@xs4all.nl>
 <7461deba-eca0-24cb-f232-3dbade95c297@microchip.com>
 <48dc0a0e-85ba-0a77-effe-cb4fc17c74c5@xs4all.nl>
 <9205d6e8-70b8-fda9-17be-7db8219eaf06@microchip.com>
In-Reply-To: <9205d6e8-70b8-fda9-17be-7db8219eaf06@microchip.com>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0023.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::33) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190423164240525
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ea69c2b-7558-4a9e-9a20-08d6c7f22e9d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1372;
x-ms-traffictypediagnostic: DM5PR11MB1372:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM5PR11MB1372AECBD0199B1A5B1604DEE8230@DM5PR11MB1372.namprd11.prod.outlook.com>
x-forefront-prvs: 0016DEFF96
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(52116002)(99286004)(5660300002)(2201001)(81156014)(476003)(4326008)(110136005)(25786009)(6246003)(53936002)(31686004)(6306002)(316002)(305945005)(7736002)(6512007)(81166006)(54906003)(6506007)(386003)(53546011)(186003)(26005)(102836004)(486006)(8936002)(36756003)(2616005)(446003)(11346002)(66066001)(8676002)(86362001)(31696002)(76176011)(14454004)(72206003)(2906002)(68736007)(6116002)(3846002)(966005)(229853002)(71200400001)(478600001)(6436002)(66476007)(73956011)(66446008)(66556008)(64756008)(2501003)(66946007)(256004)(14444005)(97736004)(71190400001)(93886005)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1372;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KT33FMO/P1NupZ7ruqyMTuE0/T7gfx3QsaaNs7Gd32K7Whb3DXA9hP2ukKXvSX4C+yGQ1Hcg/5rqdAYreL4TuqePEt3z7P/FAiOek3JtrFHMABT4JTzSeEIJpZJg9v/15rDwd9ggnQuQQDrfecNoHNVy7xyknRwTmq/ktKcqh60X7Nm7xTC57yUs+DuiGdzDggfccJsNFhsojIYhTHTanrWWinUSL3szqXBSZHXAbfiPHZL+mqFqTDTNui812sMIMOCuvaXDW75ZuIEdHOHDk8u9GZh/3ltQZYEwQmTtnzVVSvH8iaU1drCgiWzMBnnZ5GIDlsVmqqHDgnRqw4qcJemkNUHMDuvNEVaxvgH5kZ0oMG8oYLy8MVHahBLxhkgpYfltz6dn6mFqxCboK9Hj9XW2bstZ5scpxEDw92SMn+w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B4581B79EE19B418B9441C627E8649D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea69c2b-7558-4a9e-9a20-08d6c7f22e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2019 13:47:10.4293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1372
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLjA0LjIwMTkgMTU6MDksIEV1Z2VuIEhyaXN0ZXYgd3JvdGU6DQo+IA0KPiANCj4g
T24gMTIuMDQuMjAxOSAxNTowNiwgSGFucyBWZXJrdWlsIHdyb3RlOg0KPj4gRXh0ZXJuYWwgRS1N
YWlsDQo+Pg0KPj4NCj4+IE9uIDQvMTIvMTkgMjowMiBQTSwgRXVnZW4uSHJpc3RldkBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPj4+DQo+Pj4NCj4+PiBPbiAxMi4wNC4yMDE5IDE0OjUwLCBIYW5zIFZl
cmt1aWwgd3JvdGU6DQo+Pj4NCj4+Pj4NCj4+Pj4gT24gNC8xMi8xOSAxMjoxOSBQTSwgRXVnZW4u
SHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+Pj4gRnJvbTogRXVnZW4gSHJpc3RldiA8
ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4+Pj4NCj4+Pj4+IFRoaXMgd2lsbCBsaW1p
dCB0aGUgaW5jb21pbmcgcGl4ZWxzIHBlciBmcmFtZSBmcm9tIHRoZSBzZW5zb3IuDQo+Pj4+PiBD
dXJyZW50bHksIHRoZSBJU0Mgd2lsbCBzdG9wIHNhbXBsaW5nIHRoZSBmcmFtZSBvbmx5IHdoZW4g
dGhlIA0KPj4+Pj4gdnN5bmMvaHN5bmMNCj4+Pj4+IGFyZSBkZXRlY3RlZC4NCj4+Pj4+IElmIHdl
IG1pc2NvbmZpZ3VyZSB0aGUgcmVzb2x1dGlvbiBpbiB0aGUgc2Vuc29yIHcuci50LiByZXNvbHV0
aW9uIA0KPj4+Pj4gaW4gdGhlIElTQywNCj4+Pj4+IHRoZSBidWZmZXIgdXNlZCBmb3IgRE1BIGlu
IHRoZSBJU0Mgd2lsbCBiZSBzbWFsbGVyIHRoYW4gdGhlIG51bWJlciANCj4+Pj4+IG9mIHBpeGVs
cw0KPj4+Pj4gdGhhdCB0aGUgSVNDIERNQSBlbmdpbmUgd2lsbCBjb3B5Lg0KPj4+Pj4gSW4gdGhp
cyBjYXNlIGl0IGhhcHBlbnMgdGhhdCB0aGUgRE1BIHdpbGwgb3ZlcndyaXRlIHBhcnRzIG9mIHRo
ZSANCj4+Pj4+IG1lbW9yeSB3aGljaA0KPj4+Pj4gc2hvdWxkIG5vdCBiZSB3cml0dGVuLCBsZWFk
aW5nIHRvIG1lbW9yeSBjb3JydXB0aW9uLg0KPj4+Pj4gVG8gYXZvaWQgdGhpcyBzaXR1YXRpb24s
IHVzZSB0aGUgUEZFIENGRzEgYW5kIFBGRSBDRkcyIHJlZ2lzdGVycywgDQo+Pj4+PiB3aGljaCBj
cm9wDQo+Pj4+PiB0aGUgaW5jb21pbmcgZnJhbWUgdG8gdGhlIHJlc29sdXRpb24gdGhhdCB3ZSBj
b25maWd1cmUuDQo+Pj4+PiBUaGlzIHdheSB0aGUgRE1BIGVuZ2luZSB3aWxsIG5ldmVyIHdyaXRl
IG1vcmUgZGF0YSB0aGFuIHdlIGV4cGVjdCANCj4+Pj4+IGl0IHRvLg0KPj4+Pj4NCj4+Pj4+IFNp
Z25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4N
Cj4+Pj4+IC0tLQ0KPj4+Pj4gwqDCoCBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVs
LWlzYy1yZWdzLmggfCAxOSArKysrKysrKysrKysrKysNCj4+Pj4+IMKgwqAgZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2MuY8KgwqDCoMKgwqAgfCAzNCANCj4+Pj4+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4gwqDCoCAyIGZpbGVzIGNoYW5nZWQsIDUzIGlu
c2VydGlvbnMoKykNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9hdG1lbC9hdG1lbC1pc2MtcmVncy5oIA0KPj4+Pj4gYi9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmgNCj4+Pj4+IGluZGV4IDJhYWRjMTkuLjc2OGE1YWQg
MTAwNjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlz
Yy1yZWdzLmgNCj4+Pj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwt
aXNjLXJlZ3MuaA0KPj4+Pj4gQEAgLTM1LDYgKzM1LDI1IEBADQo+Pj4+PiDCoMKgICNkZWZpbmUg
SVNDX1BGR19DRkcwX0JQU19UV0VMVkUgKDB4MCA8PCAyOCkNCj4+Pj4+IMKgwqAgI2RlZmluZSBJ
U0NfUEZFX0NGRzBfQlBTX01BU0vCoMKgIEdFTk1BU0soMzAsIDI4KQ0KPj4+Pj4gKyNkZWZpbmUg
SVNDX1BGRV9DRkcwX0NPTEVOwqDCoMKgIEJJVCgxMikNCj4+Pj4+ICsjZGVmaW5lIElTQ19QRkVf
Q0ZHMF9ST1dFTsKgwqDCoCBCSVQoMTMpDQo+Pj4+PiArDQo+Pj4+PiArLyogSVNDIFBhcmFsbGVs
IEZyb250IEVuZCBDb25maWd1cmF0aW9uIDEgUmVnaXN0ZXIgKi8NCj4+Pj4+ICsjZGVmaW5lIElT
Q19QRkVfQ0ZHMcKgwqDCoCAweDAwMDAwMDEwDQo+Pj4+PiArDQo+Pj4+PiArI2RlZmluZSBJU0Nf
UEZFX0NGRzFfQ09MTUlOKHYpwqDCoMKgwqDCoMKgwqAgKCh2KSkNCj4+Pj4+ICsjZGVmaW5lIElT
Q19QRkVfQ0ZHMV9DT0xNSU5fTUFTS8KgwqDCoCBHRU5NQVNLKDE1LCAwKQ0KPj4+Pj4gKyNkZWZp
bmUgSVNDX1BGRV9DRkcxX0NPTE1BWCh2KcKgwqDCoMKgwqDCoMKgICgodikgPDwgMTYpDQo+Pj4+
PiArI2RlZmluZSBJU0NfUEZFX0NGRzFfQ09MTUFYX01BU0vCoMKgwqAgR0VOTUFTSygzMSwgMTYp
DQo+Pj4+PiArDQo+Pj4+PiArLyogSVNDIFBhcmFsbGVsIEZyb250IEVuZCBDb25maWd1cmF0aW9u
IDIgUmVnaXN0ZXIgKi8NCj4+Pj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMsKgwqDCoCAweDAwMDAw
MDE0DQo+Pj4+PiArDQo+Pj4+PiArI2RlZmluZSBJU0NfUEZFX0NGRzJfUk9XTUlOKHYpwqDCoMKg
wqDCoMKgwqAgKCh2KSkNCj4+Pj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMl9ST1dNSU5fTUFTS8Kg
wqDCoCBHRU5NQVNLKDE1LCAwKQ0KPj4+Pj4gKyNkZWZpbmUgSVNDX1BGRV9DRkcyX1JPV01BWCh2
KcKgwqDCoMKgwqDCoMKgICgodikgPDwgMTYpDQo+Pj4+PiArI2RlZmluZSBJU0NfUEZFX0NGRzJf
Uk9XTUFYX01BU0vCoMKgwqAgR0VOTUFTSygzMSwgMTYpDQo+Pj4+PiArDQo+Pj4+PiDCoMKgIC8q
IElTQyBDbG9jayBFbmFibGUgUmVnaXN0ZXIgKi8NCj4+Pj4+IMKgwqAgI2RlZmluZSBJU0NfQ0xL
RU7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MDAwMDAwMTgNCj4+Pj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jIA0KPj4+Pj4gYi9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy5jDQo+Pj4+PiBpbmRleCBhMTBk
YjE2Li5lYTc1MjBhIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9h
dG1lbC9hdG1lbC1pc2MuYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1l
bC9hdG1lbC1pc2MuYw0KPj4+Pj4gQEAgLTcyMSw2ICs3MjEsNDAgQEAgc3RhdGljIHZvaWQgaXNj
X3N0YXJ0X2RtYShzdHJ1Y3QgaXNjX2RldmljZSAqaXNjKQ0KPj4+Pj4gwqDCoMKgwqDCoMKgIHUz
MiBzaXplaW1hZ2UgPSBpc2MtPmZtdC5mbXQucGl4LnNpemVpbWFnZTsNCj4+Pj4+IMKgwqDCoMKg
wqDCoCB1MzIgZGN0cmxfZHZpZXc7DQo+Pj4+PiDCoMKgwqDCoMKgwqAgZG1hX2FkZHJfdCBhZGRy
MDsNCj4+Pj4+ICvCoMKgwqAgdTMyIGgsIHc7DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgIGggPSBp
c2MtPmZtdC5mbXQucGl4LmhlaWdodDsNCj4+Pj4+ICvCoMKgwqAgdyA9IGlzYy0+Zm10LmZtdC5w
aXgud2lkdGg7DQo+Pj4+PiArDQo+Pj4+PiArwqDCoMKgIC8qDQo+Pj4+PiArwqDCoMKgwqAgKiBJ
biBjYXNlIHRoZSBzZW5zb3IgaXMgbm90IFJBVywgaXQgd2lsbCBvdXRwdXQgYSBwaXhlbCANCj4+
Pj4+ICgxMi0xNiBiaXRzKQ0KPj4+Pj4gK8KgwqDCoMKgICogd2l0aCB0d28gc2FtcGxlcyBvbiB0
aGUgSVNDIERhdGEgYnVzICh3aGljaCBpcyA4LTEyKQ0KPj4+Pj4gK8KgwqDCoMKgICogSVNDIHdp
bGwgY291bnQgZWFjaCBzYW1wbGUsIHNvLCB3ZSBuZWVkIHRvIG11bHRpcGx5IHRoZXNlIA0KPj4+
Pj4gdmFsdWVzDQo+Pj4+PiArwqDCoMKgwqAgKiBieSB0d28sIHRvIGdldCB0aGUgcmVhbCBudW1i
ZXIgb2Ygc2FtcGxlcyBmb3IgdGhlIHJlcXVpcmVkIA0KPj4+Pj4gcGl4ZWxzLg0KPj4+Pj4gK8Kg
wqDCoMKgICovDQo+Pj4+PiArwqDCoMKgIGlmICghSVNDX0lTX0ZPUk1BVF9SQVcoaXNjLT5jb25m
aWcuc2RfZm9ybWF0LT5tYnVzX2NvZGUpKSB7DQo+Pj4+DQo+Pj4+IFRoZSBJU0NfSVNfRk9STUFU
X1JBVyBkZWZpbmUgZG9lc24ndCBleGlzdD8hDQo+Pj4+DQo+Pj4+IFNvbWV0aGluZyBjbGVhcmx5
IHdlbnQgd3JvbmcuLi4NCj4+Pj4NCj4+Pj4gUmVnYXJkcywNCj4+Pj4NCj4+Pj4gwqDCoMKgwqBI
YW5zDQo+Pj4NCj4+PiBIZWxsbyBIYW5zLA0KPj4+DQo+Pj4gU29ycnkgLCBJIGZvcmdvdCB0byBj
b3B5IHRoaXMgZnJvbSB0aGUgcHJldmlvdXMgc2VyaWVzDQo+Pj4gKGh0dHBzOi8vd3d3LnNwaW5p
Y3MubmV0L2xpc3RzL2xpbnV4LW1lZGlhL21zZzE0OTUwMS5odG1sIGZvciANCj4+PiByZWZlcmVu
Y2UpOg0KPj4+DQo+Pj4gSXQgYXBwbGllcyBvbmx5IG9uIHRvcCBvZiBteSBwcmV2aW91cyBwYXRj
aHNldDoNCj4+PiBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogcmVtb3ZlZCBBUkdCMzIgYWRkZWQg
QUJHUjMyIGFuZCBYQkdSMzINCj4+PiBtZWRpYTogYXRtZWw6IGF0bWVsLWlzYzogcmV3b3JrZWQg
ZHJpdmVyIGFuZCBmb3JtYXRzDQo+Pj4gYXZhaWxhYmxlIGF0Og0KPj4+IGh0dHBzOi8vZ2l0Lmxp
bnV4dHYub3JnL2h2ZXJrdWlsL21lZGlhX3RyZWUuZ2l0L2NvbW1pdC8/aD1mb3ItdjUuMmImaWQ9
MDNlZjFiNTZjYmE2YWQxN2Y2ZWFkMTNjODVhODFlMGU4MGZiYzlkMSANCj4+Pg0KPj4+DQo+Pj4g
U28gaXQgc2hvdWxkIHdvcmsgb24gdG9wIG9mIHRob3NlIHBhdGNoZXMuLi4NCj4+DQo+PiBBaCwg
bm93IEkgc2VlLiBJJ2xsIHBhcmsgdGhpcyBwYXRjaCBzZXJpZXMgdW50aWwgdGhlIHB1bGwgcmVx
dWVzdCANCj4+IGNvbnRhaW5pbmcNCj4+IHRob3NlIHR3byBwYXRjaGVzIGlzIG1lcmdlZC4gRmVl
bCBmcmVlIHRvIHJlbWluZCBtZSBvZiB0aGlzIHNlcmllcyANCj4+IG9uY2UgTWF1cm8NCj4+IG1l
cmdlZCB0aGF0IHB1bGwgcmVxdWVzdC4NCg0KSGVsbG8gSGFucywNCg0KVGhpcyBzZXJpZXMgc2hv
dWxkIGFwcGx5IE9LIG5vdyBvbiBsYXRlc3QgbWVkaWFfdHJlZS5naXQNCg0KRXVnZW4NCg0KPiAN
Cj4gVGhhbmsgeW91Lg0KPiANCj4gSSBtb3N0bHkgc2VudCB0aGlzIHNlcmllcyB0byBnZXQgeW91
ciBlYXJseSByZXZpZXcuIEl0IHdvdWxkIGJlIA0KPiBpbXBvcnRhbnQgdG8gZ2V0IHRoZSBuZXcg
ZmVhdHVyZSBzZXQgaW50ZWdyYXRlZCwgc28sIHRoYW5rIHlvdSBmb3IgdGhhdCwgDQo+IGFuZCBJ
IHdpbGwgc2VuZCB0aGUgdjIgb24gdGhlIG5ldyBmZWF0dXJlIHNldCwgc28gSSBjYW4gd29yayBv
biBpdCB1bnRpbCANCj4gdGhlIGZpcnN0IHBhdGNoZXMgYXJlIG1lcmdlZC4NCj4gDQo+IEV1Z2Vu
DQo+IA0KPj4NCj4+IFJlZ2FyZHMsDQo+Pg0KPj4gwqDCoMKgwqBIYW5zDQo+Pg0KPj4+DQo+Pj4g
RXVnZW4NCj4+Pg0KPj4+DQo+Pj4+DQoNCg0KW3NuaXBdDQo=
