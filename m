Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217ECC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07492082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2nsrRJBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfDLMCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:02:37 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:61716 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLMCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:02:36 -0400
X-IronPort-AV: E=Sophos;i="5.60,341,1549954800"; 
   d="scan'208";a="30000561"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Apr 2019 05:02:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.105) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 12 Apr 2019 05:02:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ+DKUEoJQYTNBMijKuMVJdx/Pd3hLYWvdqvQ7oCGeE=;
 b=2nsrRJBOQoOeRhaXPlddF3cHFJ12Je8OC/s953ujQC0T8bE3oEUu7uzN23ayow3SFoaSiK3hroX7tLhRuzctOCxL7c4GJsTnAlWtSozjHtS4Gm/dbd616MruU02h++Dlv5/WXxDDJpeF/TXdpxtn5p2jathXP8APRNf24XnGuX8=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1513.namprd11.prod.outlook.com (10.172.36.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Fri, 12 Apr 2019 12:02:33 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::e0e3:1d51:9e3e:6dc%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 12:02:33 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <hverkuil@xs4all.nl>, <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ksloat@aampglobal.com>, <mchehab@kernel.org>
Subject: Re: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Topic: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
Thread-Index: AQHU8Rk9Y6GORtaCfE+2SknPF+34OqY4ab0AgAACCAA=
Date:   Fri, 12 Apr 2019 12:02:33 +0000
Message-ID: <7461deba-eca0-24cb-f232-3dbade95c297@microchip.com>
References: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
 <1555064098-19310-2-git-send-email-eugen.hristev@microchip.com>
 <7978caee-9ae1-a428-af14-34bfa12ad223@xs4all.nl>
In-Reply-To: <7978caee-9ae1-a428-af14-34bfa12ad223@xs4all.nl>
Accept-Language: ro-RO, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:803:104::25) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eugen.Hristev@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190412145804005
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6f9aed9-b3de-40fd-1050-08d6bf3ebefc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR11MB1513;
x-ms-traffictypediagnostic: DM5PR11MB1513:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DM5PR11MB1513627FE954257B8B5326D8E8280@DM5PR11MB1513.namprd11.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(81166006)(102836004)(256004)(14444005)(8936002)(8676002)(81156014)(110136005)(97736004)(2501003)(99286004)(54906003)(53546011)(6506007)(386003)(26005)(68736007)(53936002)(6512007)(2906002)(186003)(14454004)(2201001)(5660300002)(478600001)(476003)(71190400001)(6246003)(72206003)(446003)(486006)(11346002)(66066001)(316002)(52116002)(6306002)(6116002)(86362001)(305945005)(966005)(2616005)(3846002)(6486002)(4326008)(71200400001)(105586002)(31686004)(6436002)(7736002)(36756003)(76176011)(25786009)(106356001)(31696002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1513;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2VkA3YuwYjimMt0tmd77YLlyT9RjhgdCcuNsq87IcKu1y1Rx4a2Zwo4vgvireDc06IKnP2lReRm3HUgbzrnch1+DpizwYKvWWVozGlFR7JkuHobpcOrMA5xpmyzCCVYPkTdkyyFGbTr2co9eEZowIrBHH+nC+6Fmjd8Gdk2XavAmSmpA8fGOpM2Ox9gv++lIrtsxWIUso9idFFMyOTYIj9DpMX1Z7HpDYOOdD171Es2R9yAxY21jXBS9Jmo5QpSeZiwmzTZKbOvWCrJWVWKCxsupf2mdJAcZ7H+DvtZPkHzTJI/+t/Vwxd2YrocozUnSZ3MHeJVO9ipfC+a/Ic3Ntk1qPJAzdZXksgTBKxZ0xNUBslIXzV/upteZ3soIyJgyL8zIG1UkU+OW5i+OI3c3eU7Msl1yKov4j1ch78k5Nlw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5936B7C1D2DB84087015B2A16E8D8F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f6f9aed9-b3de-40fd-1050-08d6bf3ebefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 12:02:33.5223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1513
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLjA0LjIwMTkgMTQ6NTAsIEhhbnMgVmVya3VpbCB3cm90ZToNCg0KPiANCj4gT24g
NC8xMi8xOSAxMjoxOSBQTSwgRXVnZW4uSHJpc3RldkBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4g
RnJvbTogRXVnZW4gSHJpc3RldiA8ZXVnZW4uaHJpc3RldkBtaWNyb2NoaXAuY29tPg0KPj4NCj4+
IFRoaXMgd2lsbCBsaW1pdCB0aGUgaW5jb21pbmcgcGl4ZWxzIHBlciBmcmFtZSBmcm9tIHRoZSBz
ZW5zb3IuDQo+PiBDdXJyZW50bHksIHRoZSBJU0Mgd2lsbCBzdG9wIHNhbXBsaW5nIHRoZSBmcmFt
ZSBvbmx5IHdoZW4gdGhlIHZzeW5jL2hzeW5jDQo+PiBhcmUgZGV0ZWN0ZWQuDQo+PiBJZiB3ZSBt
aXNjb25maWd1cmUgdGhlIHJlc29sdXRpb24gaW4gdGhlIHNlbnNvciB3LnIudC4gcmVzb2x1dGlv
biBpbiB0aGUgSVNDLA0KPj4gdGhlIGJ1ZmZlciB1c2VkIGZvciBETUEgaW4gdGhlIElTQyB3aWxs
IGJlIHNtYWxsZXIgdGhhbiB0aGUgbnVtYmVyIG9mIHBpeGVscw0KPj4gdGhhdCB0aGUgSVNDIERN
QSBlbmdpbmUgd2lsbCBjb3B5Lg0KPj4gSW4gdGhpcyBjYXNlIGl0IGhhcHBlbnMgdGhhdCB0aGUg
RE1BIHdpbGwgb3ZlcndyaXRlIHBhcnRzIG9mIHRoZSBtZW1vcnkgd2hpY2gNCj4+IHNob3VsZCBu
b3QgYmUgd3JpdHRlbiwgbGVhZGluZyB0byBtZW1vcnkgY29ycnVwdGlvbi4NCj4+IFRvIGF2b2lk
IHRoaXMgc2l0dWF0aW9uLCB1c2UgdGhlIFBGRSBDRkcxIGFuZCBQRkUgQ0ZHMiByZWdpc3RlcnMs
IHdoaWNoIGNyb3ANCj4+IHRoZSBpbmNvbWluZyBmcmFtZSB0byB0aGUgcmVzb2x1dGlvbiB0aGF0
IHdlIGNvbmZpZ3VyZS4NCj4+IFRoaXMgd2F5IHRoZSBETUEgZW5naW5lIHdpbGwgbmV2ZXIgd3Jp
dGUgbW9yZSBkYXRhIHRoYW4gd2UgZXhwZWN0IGl0IHRvLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuIEhyaXN0ZXYgPGV1Z2VuLmhyaXN0ZXZAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4g
ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmggfCAxOSArKysr
KysrKysrKysrKysNCj4+ICAgZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1lbC1pc2Mu
YyAgICAgIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlh
L3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmggYi9kcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L2F0bWVsL2F0bWVsLWlzYy1yZWdzLmgNCj4+IGluZGV4IDJhYWRjMTkuLjc2OGE1YWQgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL2F0bWVsL2F0bWVsLWlzYy1yZWdzLmgN
Cj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLXJlZ3MuaA0K
Pj4gQEAgLTM1LDYgKzM1LDI1IEBADQo+PiAgICNkZWZpbmUgSVNDX1BGR19DRkcwX0JQU19UV0VM
VkUgKDB4MCA8PCAyOCkNCj4+ICAgI2RlZmluZSBJU0NfUEZFX0NGRzBfQlBTX01BU0sgICBHRU5N
QVNLKDMwLCAyOCkNCj4+ICAgDQo+PiArI2RlZmluZSBJU0NfUEZFX0NGRzBfQ09MRU4JQklUKDEy
KQ0KPj4gKyNkZWZpbmUgSVNDX1BGRV9DRkcwX1JPV0VOCUJJVCgxMykNCj4+ICsNCj4+ICsvKiBJ
U0MgUGFyYWxsZWwgRnJvbnQgRW5kIENvbmZpZ3VyYXRpb24gMSBSZWdpc3RlciAqLw0KPj4gKyNk
ZWZpbmUgSVNDX1BGRV9DRkcxICAgIDB4MDAwMDAwMTANCj4+ICsNCj4+ICsjZGVmaW5lIElTQ19Q
RkVfQ0ZHMV9DT0xNSU4odikJCSgodikpDQo+PiArI2RlZmluZSBJU0NfUEZFX0NGRzFfQ09MTUlO
X01BU0sJR0VOTUFTSygxNSwgMCkNCj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMV9DT0xNQVgodikJ
CSgodikgPDwgMTYpDQo+PiArI2RlZmluZSBJU0NfUEZFX0NGRzFfQ09MTUFYX01BU0sJR0VOTUFT
SygzMSwgMTYpDQo+PiArDQo+PiArLyogSVNDIFBhcmFsbGVsIEZyb250IEVuZCBDb25maWd1cmF0
aW9uIDIgUmVnaXN0ZXIgKi8NCj4+ICsjZGVmaW5lIElTQ19QRkVfQ0ZHMiAgICAweDAwMDAwMDE0
DQo+PiArDQo+PiArI2RlZmluZSBJU0NfUEZFX0NGRzJfUk9XTUlOKHYpCQkoKHYpKQ0KPj4gKyNk
ZWZpbmUgSVNDX1BGRV9DRkcyX1JPV01JTl9NQVNLCUdFTk1BU0soMTUsIDApDQo+PiArI2RlZmlu
ZSBJU0NfUEZFX0NGRzJfUk9XTUFYKHYpCQkoKHYpIDw8IDE2KQ0KPj4gKyNkZWZpbmUgSVNDX1BG
RV9DRkcyX1JPV01BWF9NQVNLCUdFTk1BU0soMzEsIDE2KQ0KPj4gKw0KPj4gICAvKiBJU0MgQ2xv
Y2sgRW5hYmxlIFJlZ2lzdGVyICovDQo+PiAgICNkZWZpbmUgSVNDX0NMS0VOICAgICAgICAgICAg
ICAgMHgwMDAwMDAxOA0KPj4gICANCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL2F0bWVsL2F0bWVsLWlzYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9hdG1lbC9hdG1l
bC1pc2MuYw0KPj4gaW5kZXggYTEwZGIxNi4uZWE3NTIwYSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWVk
aWEvcGxhdGZvcm0vYXRtZWwvYXRtZWwtaXNjLmMNCj4+IEBAIC03MjEsNiArNzIxLDQwIEBAIHN0
YXRpYyB2b2lkIGlzY19zdGFydF9kbWEoc3RydWN0IGlzY19kZXZpY2UgKmlzYykNCj4+ICAgCXUz
MiBzaXplaW1hZ2UgPSBpc2MtPmZtdC5mbXQucGl4LnNpemVpbWFnZTsNCj4+ICAgCXUzMiBkY3Ry
bF9kdmlldzsNCj4+ICAgCWRtYV9hZGRyX3QgYWRkcjA7DQo+PiArCXUzMiBoLCB3Ow0KPj4gKw0K
Pj4gKwloID0gaXNjLT5mbXQuZm10LnBpeC5oZWlnaHQ7DQo+PiArCXcgPSBpc2MtPmZtdC5mbXQu
cGl4LndpZHRoOw0KPj4gKw0KPj4gKwkvKg0KPj4gKwkgKiBJbiBjYXNlIHRoZSBzZW5zb3IgaXMg
bm90IFJBVywgaXQgd2lsbCBvdXRwdXQgYSBwaXhlbCAoMTItMTYgYml0cykNCj4+ICsJICogd2l0
aCB0d28gc2FtcGxlcyBvbiB0aGUgSVNDIERhdGEgYnVzICh3aGljaCBpcyA4LTEyKQ0KPj4gKwkg
KiBJU0Mgd2lsbCBjb3VudCBlYWNoIHNhbXBsZSwgc28sIHdlIG5lZWQgdG8gbXVsdGlwbHkgdGhl
c2UgdmFsdWVzDQo+PiArCSAqIGJ5IHR3bywgdG8gZ2V0IHRoZSByZWFsIG51bWJlciBvZiBzYW1w
bGVzIGZvciB0aGUgcmVxdWlyZWQgcGl4ZWxzLg0KPj4gKwkgKi8NCj4+ICsJaWYgKCFJU0NfSVNf
Rk9STUFUX1JBVyhpc2MtPmNvbmZpZy5zZF9mb3JtYXQtPm1idXNfY29kZSkpIHsNCj4gDQo+IFRo
ZSBJU0NfSVNfRk9STUFUX1JBVyBkZWZpbmUgZG9lc24ndCBleGlzdD8hDQo+IA0KPiBTb21ldGhp
bmcgY2xlYXJseSB3ZW50IHdyb25nLi4uDQo+IA0KPiBSZWdhcmRzLA0KPiANCj4gCUhhbnMNCg0K
SGVsbG8gSGFucywNCg0KU29ycnkgLCBJIGZvcmdvdCB0byBjb3B5IHRoaXMgZnJvbSB0aGUgcHJl
dmlvdXMgc2VyaWVzIA0KKGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LW1lZGlh
L21zZzE0OTUwMS5odG1sIGZvciByZWZlcmVuY2UpOg0KDQpJdCBhcHBsaWVzIG9ubHkgb24gdG9w
IG9mIG15IHByZXZpb3VzIHBhdGNoc2V0Og0KbWVkaWE6IGF0bWVsOiBhdG1lbC1pc2M6IHJlbW92
ZWQgQVJHQjMyIGFkZGVkIEFCR1IzMiBhbmQgWEJHUjMyDQptZWRpYTogYXRtZWw6IGF0bWVsLWlz
YzogcmV3b3JrZWQgZHJpdmVyIGFuZCBmb3JtYXRzDQphdmFpbGFibGUgYXQ6DQpodHRwczovL2dp
dC5saW51eHR2Lm9yZy9odmVya3VpbC9tZWRpYV90cmVlLmdpdC9jb21taXQvP2g9Zm9yLXY1LjJi
JmlkPTAzZWYxYjU2Y2JhNmFkMTdmNmVhZDEzYzg1YTgxZTBlODBmYmM5ZDENCg0KU28gaXQgc2hv
dWxkIHdvcmsgb24gdG9wIG9mIHRob3NlIHBhdGNoZXMuLi4NCg0KRXVnZW4NCg0KDQo+IA0KPiAN
Cj4+ICsJCWggPDw9IDE7DQo+PiArCQl3IDw8PSAxOw0KPj4gKwl9DQo+PiArDQo+PiArCS8qDQo+
PiArCSAqIFdlIGxpbWl0IHRoZSBjb2x1bW4vcm93IGNvdW50IHRoYXQgdGhlIElTQyB3aWxsIG91
dHB1dCBhY2NvcmRpbmcNCj4+ICsJICogdG8gdGhlIGNvbmZpZ3VyZWQgcmVzb2x1dGlvbiB0aGF0
IHdlIHdhbnQuDQo+PiArCSAqIFRoaXMgd2lsbCBhdm9pZCB0aGUgc2l0dWF0aW9uIHdoZXJlIHRo
ZSBzZW5zb3IgaXMgbWlzY29uZmlndXJlZCwNCj4+ICsJICogc2VuZGluZyBtb3JlIGRhdGEsIGFu
ZCB0aGUgSVNDIHdpbGwganVzdCB0YWtlIGl0IGFuZCBETUEgdG8gbWVtb3J5LA0KPj4gKwkgKiBj
YXVzaW5nIGNvcnJ1cHRpb24uDQo+PiArCSAqLw0KPj4gKwlyZWdtYXBfd3JpdGUocmVnbWFwLCBJ
U0NfUEZFX0NGRzEsDQo+PiArCQkgICAgIChJU0NfUEZFX0NGRzFfQ09MTUlOKDApICYgSVNDX1BG
RV9DRkcxX0NPTE1JTl9NQVNLKSB8DQo+PiArCQkgICAgIChJU0NfUEZFX0NGRzFfQ09MTUFYKHcg
LSAxKSAmIElTQ19QRkVfQ0ZHMV9DT0xNQVhfTUFTSykpOw0KPj4gKw0KPj4gKwlyZWdtYXBfd3Jp
dGUocmVnbWFwLCBJU0NfUEZFX0NGRzIsDQo+PiArCQkgICAgIChJU0NfUEZFX0NGRzJfUk9XTUlO
KDApICYgSVNDX1BGRV9DRkcyX1JPV01JTl9NQVNLKSB8DQo+PiArCQkgICAgIChJU0NfUEZFX0NG
RzJfUk9XTUFYKGggLSAxKSAmIElTQ19QRkVfQ0ZHMl9ST1dNQVhfTUFTSykpOw0KPj4gKw0KPj4g
KwlyZWdtYXBfdXBkYXRlX2JpdHMocmVnbWFwLCBJU0NfUEZFX0NGRzAsDQo+PiArCQkJICAgSVND
X1BGRV9DRkcwX0NPTEVOIHwgSVNDX1BGRV9DRkcwX1JPV0VOLA0KPj4gKwkJCSAgIElTQ19QRkVf
Q0ZHMF9DT0xFTiB8IElTQ19QRkVfQ0ZHMF9ST1dFTik7DQo+PiAgIA0KPj4gICAJYWRkcjAgPSB2
YjJfZG1hX2NvbnRpZ19wbGFuZV9kbWFfYWRkcigmaXNjLT5jdXJfZnJtLT52Yi52YjJfYnVmLCAw
KTsNCj4+ICAgCXJlZ21hcF93cml0ZShyZWdtYXAsIElTQ19EQUQwLCBhZGRyMCk7DQo+Pg0KPiAN
Cj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwNCj4gDQo+IA0K
