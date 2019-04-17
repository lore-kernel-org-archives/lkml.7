Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C090C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6139E2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="NzsG7M4z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfDQIst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:48:49 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:9820 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQIst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:48:49 -0400
X-IronPort-AV: E=Sophos;i="5.60,361,1549954800"; 
   d="scan'208";a="30291093"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Apr 2019 01:48:48 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.38) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Wed, 17 Apr 2019 01:48:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSLXiXdfrDILnn1Qpe7796FrY+4nrK2YlCGuzQINbO0=;
 b=NzsG7M4z3cY/OQ9eX4BiIvHuSSExPash5YTgkGQLppQ4fn3zGmvP+n8nNiNLBxiTI034VJyrDy5xmwqoxH+AX8NNa++z+DsdhdamXeXzOzY44LgiNhiEmEnJFLAsEFIxw3WRF5t1e5tqb77XUfVk+ffZcwGiBQYX/LfVJTdLX2w=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1858.namprd11.prod.outlook.com (10.175.98.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 08:48:45 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e4c0:24a5:9a32:46e3]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e4c0:24a5:9a32:46e3%9]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 08:48:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dinguyen@kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <marex@denx.de>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <tien.fong.chee@intel.com>
Subject: Re: [PATCHv2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Topic: [PATCHv2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Index: AQHU7upgLv3qbRICSEeB0GbHGt7DDKZAFt4A
Date:   Wed, 17 Apr 2019 08:48:45 +0000
Message-ID: <5e058af4-17d8-9db9-5bc5-2122d3af4c9f@microchip.com>
References: <20190409153801.6941-1-dinguyen@kernel.org>
In-Reply-To: <20190409153801.6941-1-dinguyen@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VE1PR08CA0010.eurprd08.prod.outlook.com
 (2603:10a6:803:104::23) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f287dc9-c983-496c-6909-08d6c3118021
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR11MB1858;
x-ms-traffictypediagnostic: BN6PR11MB1858:
x-microsoft-antispam-prvs: <BN6PR11MB1858E83D29404D331098FC58F0250@BN6PR11MB1858.namprd11.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(105586002)(14444005)(53936002)(99286004)(71190400001)(7736002)(2501003)(31686004)(5660300002)(97736004)(110136005)(316002)(81156014)(66066001)(478600001)(81166006)(8936002)(54906003)(36756003)(6512007)(31696002)(229853002)(86362001)(305945005)(71200400001)(68736007)(6436002)(6116002)(6486002)(14454004)(53546011)(3846002)(106356001)(256004)(486006)(2616005)(6506007)(446003)(11346002)(6246003)(8676002)(52116002)(2906002)(25786009)(72206003)(476003)(76176011)(4326008)(386003)(102836004)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1858;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fStDp0zYr4X9djgE3PrzL/iYjRUvbNd1i+EMxsDGZvsfQzm9YVOfBmAdhqbeeVaUyHN3fWyA2rgEX7CxWwzngCi8WqhAb0vSrN7lCiSND7uhnSQYrMZeLh3wKrp5HCdpZfBzvhIOYCtDfydAsKK0mKOnZnMqLX55P6BEad1+xwZ/L+O+DWXL7xlnOXJBsq/4KjWH/ahHn3rTEb6JSmOKdHpLi7weCmZDAd5vNa5xR+XmXdlg12waWl4LkfhEw0FuNFXSwNWiBcEPdOKGpJzBlTiDbMwWhOkdmqcrK8EHCpG8rnuyXV3v97RAFDtay0MhFBy4Nk8RliqtS8clDYCm7PI5+N/L1EHhNHLCXMLIY4MRVKouOabiJDFD9ryv6hfAmad5HPkHZbDYgGIao6v+AKOcvSX8GjlhsYHGBA7Fjhk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2323B7239B1B547A1242E4310880CA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f287dc9-c983-496c-6909-08d6c3118021
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 08:48:45.4029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1858
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERpbmgsDQoNCk9uIDA0LzA5LzIwMTkgMDY6MzggUE0sIERpbmggTmd1eWVuIHdyb3RlOg0K
PiBHZXQgdGhlIHJlc2V0IGNvbnRyb2wgZm9yIHRoZSBRU1BJIGNvbnRyb2xsZXIgYW5kIGJyaW5n
IGl0IG91dCBvZiByZXNldC4NCg0KSXMgdGhlcmUgYSBwdWJsaWMgZGF0YXNoZWV0IHdoZXJlIEkg
Y2FuIGNoZWNrIHRoaXM/DQo+IA0KPiBTdWdnZXN0ZWQtYnk6IFRpZW4tRm9uZyBDaGVlIDx0aWVu
LmZvbmcuY2hlZUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERpbmggTmd1eWVuIDxkaW5n
dXllbkBrZXJuZWwub3JnPg0KPiAtLS0NCj4gdjI6IHVzZSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0
X29wdGlvbmFsX2V4Y2x1c2l2ZQ0KPiAgICAgcHJpbnQgYW4gZXJyb3IgbWVzc2FnZQ0KPiAgICAg
cmV0dXJuIC1FUFJPQkVfREVGRVINCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NhZGVu
Y2UtcXVhZHNwaS5jIHwgMTQgKysrKysrKysrKysrKysNCg0Kd291bGQgeW91IHVwZGF0ZSB0aGUg
YmluZGluZ3MgYXMgd2VsbD8NCg0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5j
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYw0KPiBpbmRleCA3OTI2Mjg3
NTBlZWMuLmM1NDg1NjdhZGNmMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9j
YWRlbmNlLXF1YWRzcGkuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVh
ZHNwaS5jDQo+IEBAIC0zNCw2ICszNCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9w
bV9ydW50aW1lLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC9zY2hlZC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NwaS9zcGkuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC90aW1lci5oPg0KPiBAQCAtMTMzNiw2ICsxMzM3LDcgQEAgc3RhdGljIGludCBjcXNw
aV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXN0cnVjdCBjcXNwaV9z
dCAqY3FzcGk7DQo+ICAJc3RydWN0IHJlc291cmNlICpyZXM7DQo+ICAJc3RydWN0IHJlc291cmNl
ICpyZXNfYWhiOw0KPiArCXN0cnVjdCByZXNldF9jb250cm9sICpyc3RjOw0KPiAgCWNvbnN0IHN0
cnVjdCBjcXNwaV9kcml2ZXJfcGxhdGRhdGEgKmRkYXRhOw0KPiAgCWludCByZXQ7DQo+ICAJaW50
IGlycTsNCj4gQEAgLTEzNjIsNiArMTM2NCwxOCBAQCBzdGF0aWMgaW50IGNxc3BpX3Byb2JlKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCXJldHVybiBQVFJfRVJSKGNxc3BpLT5j
bGspOw0KPiAgCX0NCj4gIA0KPiArCS8qIE9idGFpbiBRU1BJIHJlc2V0IGNvbnRyb2wgKi8NCg0K
T1NQSSB2ZXJzaW9uIG9mIHRoZSBJUCBoYXMgYmVlbiBhZGRlZCByZWNlbnRseS4gSXMgdGhpcyBh
dmFpbGFibGUganVzdCBmb3IgUVNQST8NCg0KPiArCXJzdGMgPSBkZXZtX3Jlc2V0X2NvbnRyb2xf
Z2V0X29wdGlvbmFsX2V4Y2x1c2l2ZShkZXYsIE5VTEwpOw0KPiArCWlmIChJU19FUlIocnN0Yykp
IHsNCj4gKwkJZGV2X2VycihkZXYsICJDYW5ub3QgZ2V0IFFTUEkgcmVzZXQuXG4iKTsNCj4gKwkJ
aWYgKFBUUl9FUlIocnN0YykgPT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCXJldHVybiAtRVBST0JF
X0RFRkVSOw0KDQp3aHkgaWdub3JpbmcgYWxsIHRoZSBvdGhlciBwb3NzaWJsZSBlcnJvcnM/IE1h
eWJlIHJldHVybiBQVFJfRVJSKHJzdGMpOyA/DQoNCj4gKwl9IGVsc2Ugew0KPiArCQlyZXNldF9j
b250cm9sX2Fzc2VydChyc3RjKTsNCg0KU2hvdWxkbid0IHRoZSBjbG9jayBiZSBlbmFibGVkIGJl
Zm9yZSBhc3NlcnRpbmcgcmVzZXQ/DQoNCkRvZXMgaXQgbWF0dGVyIGlmIHJlc2V0X2NvbnRyb2xf
YXNzZXJ0KCkgaXMgcmV0dXJuaW5nIGFueSBlcnJvcj8NCg0KPiArCQl1ZGVsYXkoMSk7DQoNCklz
IHRoZXJlIGEgcmFuZ2Ugb3IgMSB1cyBpcyB0aGUgbWF4aW11bSB0aW1lIHRoYXQgd2Ugc2hvdWxk
IHdhaXQ/DQoNCj4gKwkJcmVzZXRfY29udHJvbF9kZWFzc2VydChyc3RjKTsNCg0KU2hvdWxkIHdl
IGNoZWNrIGlmIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoKSBpcyByZXR1cm5pbmcgYW55IGVycm9y
Pw0KDQpDaGVlcnMsDQp0YQ0KDQo+ICsJfQ0KPiArDQo+ICAJLyogT2J0YWluIGFuZCByZW1hcCBj
b250cm9sbGVyIGFkZHJlc3MuICovDQo+ICAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBk
ZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCj4gIAljcXNwaS0+aW9iYXNlID0gZGV2bV9pb3JlbWFw
X3Jlc291cmNlKGRldiwgcmVzKTsNCj4gDQo=
