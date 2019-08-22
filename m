Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF075C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC0821743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=towerbridgetechnology.onmicrosoft.com header.i=@towerbridgetechnology.onmicrosoft.com header.b="QkdieT4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbfHVQQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:16:28 -0400
Received: from mail-eopbgr780110.outbound.protection.outlook.com ([40.107.78.110]:23904
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729718AbfHVQQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fab3S1PzyILLDiWDe+EQfH77iDI6vTcKRXK0skFKdGKPInE8MBYk0E9pQqb7SLgptHfzMzVD8TRabD7BlYT7ohOlu9imWbhqQBom2vXz3c0a4jK4EJutqGLBVCy0V92xM+wdmtiNfBwMHb56SpwBXUWgpO+JXiGYcWYw1oPg98rfr3HPiTSlt7/Wur17VSlithyzlKPtgR7eiRo2GfpklP0gsgJLvBahBMiUMfN4WR+RPOg5ME9TTI2ECgdXGxyHA0sBVeOlPf2Dt6rPqePMATH7qs/WAj+IslpxaM5QvZBVzzLjTbhT0ch7Q9gqS+ADG3OY4Tgf3j8Lmlg5YmRhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiUaNT0SQiVWpzTI51umm7v8/bNwxVaNF/brOJ21vfI=;
 b=GpVzoprWjMwyUtCeE0yKJvCBqt0BlmfioLcSAbrCgfiiNXct8ifJs/pWhCL4mG/auJjDFg4hVHQ9E07Y0iE5EOGratZQfpmPNSZoHUNdEdEgheFs8KUAU5VhvMj4eE23UBkz8jBS8ioyNd8acxNwjvEraElYRzO3GXBM7cIk8oQsvFY8xT3GWIFYUNHZRgkMCYkHV+Ii3MAXjzXuOfIWqadRRnjYSkETb5Pp1tyUTE/JRRVUAxs4lWebEl4cxX2Hezt706pBGyFHZw4gpjhUX3Xk3BSBa1fa0hH0gUKcP/zjN8aFc95MU/9xJUt+7s5LNCp9ZRIBxGT2QF9jCJinFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PiUaNT0SQiVWpzTI51umm7v8/bNwxVaNF/brOJ21vfI=;
 b=QkdieT4Nz+4JEkTqGuH0G8pu3KTQ1Valg4A76ZMTboSDTO/MmJkPUWB9XgQTDsc/SlOi2ldVZ0/Yn3crld4Pj4w79vcZURsL+Bs3qq1yavQFNGRYdRyaQbMqwk0Qu17Ey4DIEsp5yzQaNxTnFgxhAkghfV2cMsTNH6prQkOm/Uc=
Received: from MWHPR16MB1455.namprd16.prod.outlook.com (10.175.5.21) by
 MWHPR16MB1871.namprd16.prod.outlook.com (10.172.61.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 16:16:18 +0000
Received: from MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd]) by MWHPR16MB1455.namprd16.prod.outlook.com
 ([fe80::48f4:c6d9:3a8:e7dd%4]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 16:16:18 +0000
From:   "Shirley Her (SC)" <shirley.her@bayhubtech.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Louis Lu (TP)" <louis.lu@bayhubtech.com>,
        "Max Huang (SC)" <max.huang@bayhubtech.com>
Subject: RE: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and DLL
 register name
Thread-Topic: [PATCH V8 1/3] mmc: sdhci-pci-o2micro: Change O2 Host PLL and
 DLL register name
Thread-Index: AQHVWE+hFDk0c1SojEGAt3evjZxCYqcG2GuAgAB/0iA=
Date:   Thu, 22 Aug 2019 16:16:18 +0000
Message-ID: <MWHPR16MB14555AB570D340E138FDAB1E8BA50@MWHPR16MB1455.namprd16.prod.outlook.com>
References: <1566412708-6130-1-git-send-email-shirley.her@bayhubtech.com>
 <CAPDyKFoyvT-nvU+rng7y=MitzuPfd3HdJ+SZNm4tPhkb-ER=nA@mail.gmail.com>
In-Reply-To: <CAPDyKFoyvT-nvU+rng7y=MitzuPfd3HdJ+SZNm4tPhkb-ER=nA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shirley.her@bayhubtech.com; 
x-originating-ip: [209.36.105.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27447d58-9493-4c07-6dd4-08d7271c1085
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:MWHPR16MB1871;
x-ms-traffictypediagnostic: MWHPR16MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR16MB1871CE2807B5622DF6308A108BA50@MWHPR16MB1871.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39840400004)(346002)(396003)(376002)(199004)(189003)(13464003)(40764003)(26005)(76116006)(74316002)(66946007)(305945005)(7736002)(508600001)(8936002)(71200400001)(6116002)(81156014)(8676002)(66066001)(81166006)(66446008)(66476007)(316002)(14454004)(64756008)(54906003)(6916009)(229853002)(3846002)(71190400001)(6436002)(5660300002)(66556008)(55016002)(9686003)(52536014)(486006)(186003)(6246003)(14444005)(256004)(86362001)(33656002)(107886003)(476003)(99286004)(446003)(11346002)(2906002)(7696005)(53936002)(76176011)(6506007)(102836004)(4326008)(25786009)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR16MB1871;H:MWHPR16MB1455.namprd16.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bayhubtech.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QqyKMbvUGy3PNiCN0hjWrAPEJHD36zzT9ivXXtwJJJCRmM+//uRQ3x6M22eZMyVZKKspCP2t8IukWjBABk0/4W7IwWH8mMjMnzutyL2QcOoO59Nzc/ncIs+r+CwiUofou/SHEQWhI2mvLLH3d2wLJtejwjGdhZCzsaSieMG5FzjjJ5vImaindpHi/fhC7opiwyxT0HAnJ5Lb9QHZ9nbeHCXgupJvxBE0cKkKZ525dEqAtl97FeWaaUEcOLEZS4fGLD08P0SD8cUWE7U6xDBU4XeUzFr6hzXUbOr1kfcqbRbPap0o+yyIRz9dm4u6g3PcjC6h05GtYb2iqMoqZOObJccdeeklm/JkNdrRlZoZnK/GiPacQvQ6LDt2vBVUx8eGaGZGIYzrw7WdVdxPmaWaIfTAIrwATK1GKsRHj5dxs4A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27447d58-9493-4c07-6dd4-08d7271c1085
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 16:16:18.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89yLRioQ5HApRnnq/VACrt107wxESJQqiMvBpgJVT2Pp4NKYW8zybo7LTa5XPWVdh1rRu1lEEbSYRfIq112ueSWzMH6n91KQK+qmApe7laM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR16MB1871
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgYWJvdXQgdGhlIGNvbmZ1c2lvbiBhbmQgdGhleSBhcmUgdGhlIHNhbWUsIHBsZWFzZSBy
ZXZpZXcgdGhlIDJuZCBvbmUuIE9uZSBvZiB0aGUgZW1haWwgYWRkcmVzcyBpcyB3cm9uZyB3aGVu
IEkgc2VuZCB0aGUgMXN0IG9uZS4NCg0KVGhhbmtzIGZvciB5b3VyIGhlbHAsDQpTaGlybGV5DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRvOnVs
Zi5oYW5zc29uQGxpbmFyby5vcmddIA0KU2VudDogVGh1cnNkYXksIEF1Z3VzdCAyMiwgMjAxOSAx
OjM1IEFNDQpUbzogU2hpcmxleSBIZXIgKFNDKSA8c2hpcmxleS5oZXJAYmF5aHVidGVjaC5jb20+
DQpDYzogYWRyaWFuLmh1bnRlckBpbnRlbC5jb207IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IENoZXZyb24gTGkgKFdIKSA8Y2hldnJvbi5s
aUBiYXlodWJ0ZWNoLmNvbT47IFNoYXBlciBMaXUgKFdIKSA8c2hhcGVyLmxpdUBiYXlodWJ0ZWNo
LmNvbT47IExvdWlzIEx1IChUUCkgPGxvdWlzLmx1QGJheWh1YnRlY2guY29tPjsgTWF4IEh1YW5n
IChTQykgPG1heC5odWFuZ0BiYXlodWJ0ZWNoLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjgg
MS8zXSBtbWM6IHNkaGNpLXBjaS1vMm1pY3JvOiBDaGFuZ2UgTzIgSG9zdCBQTEwgYW5kIERMTCBy
ZWdpc3RlciBuYW1lDQoNCk9uIFdlZCwgMjEgQXVnIDIwMTkgYXQgMjA6MzgsIFNoaXJsZXkgSGVy
IChTQykgPHNoaXJsZXkuaGVyQGJheWh1YnRlY2guY29tPiB3cm90ZToNCj4NCj4gQ2hhbmdlIE8y
IEhvc3QgUExMIGFuZCBETEwgcmVnaXN0ZXIgbmFtZQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGly
bGV5IEhlciA8c2hpcmxleS5oZXJAYmF5aHVidGVjaC5jb20+DQoNCkl0IHNlZW1zIGxpa2UgeW91
IG1hbmFnZWQgdG8gcG9zdCB0aGUgdmVyc2lvbiA4LCB0d28gdGltZXMuIElzIHRoZXJlIGFueSBk
aWZmZXJlbmNlPyBXaGljaCBvbmUgc2hvdWxkIHdlIHJldmlldz8NCg0KS2luZCByZWdhcmRzDQpV
ZmZlDQoNCj4gLS0tDQo+IGNoYW5nZSBpbiBWODoNCj4gIDEuIGZpeCBwYXRjaCBmb3JtYXQgZXJy
b3INCj4NCj4gY2hhbmdlIGluIFY3Og0KPiAgMS4gY2hhbmdlIHN1YmplY3QNCj4NCj4gY2hhbmdl
IGluIFY2Og0KPiAgMS4gY2hhbmdlIHN1YmplY3QgYW5kIGNvbW1pdCBtZXNzYWdlIHRvIG1hdGNo
IHRoZSBwYXRjaCAgMi4gY2hhbmdlIA0KPiByZWdpc3RlciBuYW1lIE8yX1BMTF9XRFRfQ09OVFJP
TDEgdG8gTzJfUExMX0RMTF9XRFRfQ09OVFJPTDENCj4NCj4gY2hhbmdlIGluIFY1Og0KPiAgMS4g
c3BsaXQgMiBwYXRjaGVzIGludG8gMyBwYXRjaGVzDQo+ICAyLiBtYWtlIGRsbF9hZGp1c3RfY291
bnQgc3RhcnQgZnJvbSAwICAzLiBmaXggcmV0IG92ZXJ3cml0dGVuIGlzc3VlICANCj4gNC4gdXNl
IGJyZWFrIGluc3RlYWQgb2YgZ290bw0KPg0KPiBjaGFuZ2UgaW4gVjQ6DQo+ICAxLiBhZGQgYSBi
dWcgZml4IGZvciBWMw0KPg0KPiBjaGFuZ2UgaW4gVjM6DQo+ICAxLiBhZGQgbW9yZSBleHBsYW5h
dGlvbiBpbiBkbGxfcmVjb3ZlcnkgYW5kIGV4ZWN1dGVfdHVuaW5nIGZ1bmN0aW9uICANCj4gMi4g
bW92ZSBkbGxfYWRqdXN0X2NvdW50IHRvIE8yX2hvc3Qgc3RydWN0ICAzLiBmaXggc29tZSBjb2Rp
bmcgc3R5bGUgDQo+IGVycm9yICA0LiByZW5hbWluZyBPMl9QTExfV0RUX0NPTlRST0wxIFRPIE8y
X1BMTF9ETExfV0RUX0NPTlRST0wxDQo+DQo+IGNoYW5nZSBpbiBWMjoNCj4gIDEuIHVzZSB1c2xl
ZXBfcmFuZ2UgaW5zdGVhZCBvZiB1ZGVsYXkgIDIuIG1vdmUgZGxsX2FkanVzdF9jb3VudCB0byAN
Cj4gc2RoY2ktcGNpLW8ybWljcm8uYw0KPg0KPiBjaGFnbmUgaW4gVjE6DQo+ICAxLiBhZGQgZXJy
b3IgcmVjb3ZlcnkgZnVuY3Rpb24gdG8gcmVsb2NrIERMTCB3aXRoIGNvcnJlY3QgcGhhc2UgIDIu
IA0KPiByZXR1bmluZyBIUzIwMCBhZnRlciBETEwgbG9ja2VkDQo+IC0tLQ0KPiAgZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jIHwgMTYgKysrKysrKystLS0tLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYyANCj4gYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLXBjaS1vMm1pY3JvLmMNCj4gaW5kZXggOWRjNDU0OC4uYjNhMzNkOSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQo+ICsr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KPiBAQCAtNTEsNyArNTEs
NyBAQA0KPiAgI2RlZmluZSBPMl9TRF9WRU5ET1JfU0VUVElORzIgIDB4MUM4DQo+ICAjZGVmaW5l
IE8yX1NEX0hXX1RVTklOR19ESVNBQkxFICAgICAgICBCSVQoNCkNCj4NCj4gLSNkZWZpbmUgTzJf
UExMX1dEVF9DT05UUk9MMSAgICAweDFDQw0KPiArI2RlZmluZSBPMl9QTExfRExMX1dEVF9DT05U
Uk9MMSAgICAgICAgMHgxQ0MNCj4gICNkZWZpbmUgIE8yX1BMTF9GT1JDRV9BQ1RJVkUgICBCSVQo
MTgpDQo+ICAjZGVmaW5lICBPMl9QTExfTE9DS19TVEFUVVMgICAgQklUKDE0KQ0KPiAgI2RlZmlu
ZSAgTzJfUExMX1NPRlRfUkVTRVQgICAgIEJJVCgxMikNCj4gQEAgLTMxNiwyMyArMzE2LDIzIEBA
IHN0YXRpYyB2b2lkIHNkaGNpX28yX2VuYWJsZV9pbnRlcm5hbF9jbG9jayhzdHJ1Y3Qgc2RoY2lf
aG9zdCAqaG9zdCkNCj4gICAgICAgICB1MzIgc2NyYXRjaDMyOw0KPg0KPiAgICAgICAgIC8qIFBM
TCBzb2Z0d2FyZSByZXNldCAqLw0KPiAtICAgICAgIHNjcmF0Y2gzMiA9IHNkaGNpX3JlYWRsKGhv
c3QsIE8yX1BMTF9XRFRfQ09OVFJPTDEpOw0KPiArICAgICAgIHNjcmF0Y2gzMiA9IHNkaGNpX3Jl
YWRsKGhvc3QsIE8yX1BMTF9ETExfV0RUX0NPTlRST0wxKTsNCj4gICAgICAgICBzY3JhdGNoMzIg
fD0gTzJfUExMX1NPRlRfUkVTRVQ7DQo+IC0gICAgICAgc2RoY2lfd3JpdGVsKGhvc3QsIHNjcmF0
Y2gzMiwgTzJfUExMX1dEVF9DT05UUk9MMSk7DQo+ICsgICAgICAgc2RoY2lfd3JpdGVsKGhvc3Qs
IHNjcmF0Y2gzMiwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0KPiAgICAgICAgIHVkZWxheSgx
KTsNCj4gICAgICAgICBzY3JhdGNoMzIgJj0gfihPMl9QTExfU09GVF9SRVNFVCk7DQo+IC0gICAg
ICAgc2RoY2lfd3JpdGVsKGhvc3QsIHNjcmF0Y2gzMiwgTzJfUExMX1dEVF9DT05UUk9MMSk7DQo+
ICsgICAgICAgc2RoY2lfd3JpdGVsKGhvc3QsIHNjcmF0Y2gzMiwgTzJfUExMX0RMTF9XRFRfQ09O
VFJPTDEpOw0KPg0KPiAgICAgICAgIC8qIFBMTCBmb3JjZSBhY3RpdmUgKi8NCj4gICAgICAgICBz
Y3JhdGNoMzIgfD0gTzJfUExMX0ZPUkNFX0FDVElWRTsNCj4gLSAgICAgICBzZGhjaV93cml0ZWwo
aG9zdCwgc2NyYXRjaDMyLCBPMl9QTExfV0RUX0NPTlRST0wxKTsNCj4gKyAgICAgICBzZGhjaV93
cml0ZWwoaG9zdCwgc2NyYXRjaDMyLCBPMl9QTExfRExMX1dEVF9DT05UUk9MMSk7DQo+DQo+ICAg
ICAgICAgLyogV2FpdCBtYXggMjAgbXMgKi8NCj4gICAgICAgICB0aW1lb3V0ID0ga3RpbWVfYWRk
X21zKGt0aW1lX2dldCgpLCAyMCk7DQo+ICAgICAgICAgd2hpbGUgKDEpIHsNCj4gICAgICAgICAg
ICAgICAgIGJvb2wgdGltZWRvdXQgPSBrdGltZV9hZnRlcihrdGltZV9nZXQoKSwgdGltZW91dCk7
DQo+DQo+IC0gICAgICAgICAgICAgICBzY3JhdGNoID0gc2RoY2lfcmVhZHcoaG9zdCwgTzJfUExM
X1dEVF9DT05UUk9MMSk7DQo+ICsgICAgICAgICAgICAgICBzY3JhdGNoID0gc2RoY2lfcmVhZHco
aG9zdCwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHNj
cmF0Y2ggJiBPMl9QTExfTE9DS19TVEFUVVMpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiAgICAgICAgICAgICAgICAgaWYgKHRpbWVkb3V0KSB7DQo+IEBAIC0zNTAsOSArMzUw
LDkgQEAgc3RhdGljIHZvaWQgc2RoY2lfbzJfZW5hYmxlX2ludGVybmFsX2Nsb2NrKHN0cnVjdCAN
Cj4gc2RoY2lfaG9zdCAqaG9zdCkNCj4NCj4gIG91dDoNCj4gICAgICAgICAvKiBDYW5jZWwgUExM
IGZvcmNlIGFjdGl2ZSAqLw0KPiAtICAgICAgIHNjcmF0Y2gzMiA9IHNkaGNpX3JlYWRsKGhvc3Qs
IE8yX1BMTF9XRFRfQ09OVFJPTDEpOw0KPiArICAgICAgIHNjcmF0Y2gzMiA9IHNkaGNpX3JlYWRs
KGhvc3QsIE8yX1BMTF9ETExfV0RUX0NPTlRST0wxKTsNCj4gICAgICAgICBzY3JhdGNoMzIgJj0g
fk8yX1BMTF9GT1JDRV9BQ1RJVkU7DQo+IC0gICAgICAgc2RoY2lfd3JpdGVsKGhvc3QsIHNjcmF0
Y2gzMiwgTzJfUExMX1dEVF9DT05UUk9MMSk7DQo+ICsgICAgICAgc2RoY2lfd3JpdGVsKGhvc3Qs
IHNjcmF0Y2gzMiwgTzJfUExMX0RMTF9XRFRfQ09OVFJPTDEpOw0KPiAgfQ0KPg0KPiAgc3RhdGlj
IGludCBzZGhjaV9vMl9nZXRfY2Qoc3RydWN0IG1tY19ob3N0ICptbWMpDQo+IC0tDQo+IDIuNy40
DQo+DQo=
