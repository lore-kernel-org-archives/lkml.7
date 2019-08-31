Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B14C3A59F
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0D22343A
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 05:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="g6Ebjgib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfHaFui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 01:50:38 -0400
Received: from mail-eopbgr760119.outbound.protection.outlook.com ([40.107.76.119]:52806
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfHaFui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 01:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fF+MiKQtyH4rITM6qeRyiUfaUL95P1DznapwSZ5mySq1R8cIw5gpFW0qBiaIcCpyux+e7Ma3Z81daRBomwCaZcILkzEroQK8tYEXzGZ5i0JEvxl6tYf/oeAf2I+TgS7fpuIMrTdvbL/demSozR3R/hUHnbuQOwGhBGPMdCGpYGiSBbevGf0ZfbLKMx8b3UKW4XxOemD2vTvER5p+sEmlzaNOEEqzKXEzxZgrY9rEsTbWXmGMH9kP+G0NJCAS3xj5otMn/rkMGEFhJzUIY4Ro2O9vB6lRs3D8yWl+qWadO7cV24hd1LglNkUXRBiL35sKNM6wLB5C65vFypCS5CltlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovZhOu55lB2/kMUqmAO1jArpp9kM7kP/hz0S3EI7XcM=;
 b=LZ9TX3fUsizUjk6Qg57uriO1Ts//KfpZLRt0k3sO5WdVTfO/owPmN9YldTXal2W6GR7mTgnwmIR6FNP0trpw/Vtmf8NBq3ZB52G7VHTILgyDkx3/jO1XUS05wXgGnqYKISqzJgYOBv+ZvHHctyxoOgZ/ZWWkO+Jdz7IjJ2IS5MXolxoOhkszYet4/NQa532LVFaSGMu8COZsJm3D9EdfdklKwEViwXw3DJRp6KAR/quWf0Nu91pfQ3ZWeg7gjKbTW05UFxkUH6WdLjXoU2xjHor6rfmwlar/+fZad2iK6h0rLZ5e9nv9ptKS9k+3W7h8XpM+DPvI5ymGT3GpBbnWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovZhOu55lB2/kMUqmAO1jArpp9kM7kP/hz0S3EI7XcM=;
 b=g6Ebjgibp1KoPUwiIl96kpIQJPuSRmhURNAPke+vE5K8wXR6lZQKgBBflCggctPtmJ/TKHqnNC5NuPLu2ntkc+Bfk1W2yD4JEkVEbBNwZHSohQAz6r2lz3PGk82GuLFgCPGGwGUkr5Wb5HBsHzi7DYbXuAnVXgnvdvckPkb2VqA=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2155.namprd11.prod.outlook.com (10.174.109.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Sat, 31 Aug 2019 05:50:35 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::101c:56a0:673b:6410%6]) with mapi id 15.20.2199.021; Sat, 31 Aug 2019
 05:50:34 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jethro Beekman <jethro@fortanix.com>,
        Enrico Weigelt <info@metux.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jethro Beekman <jethro@fortanix.com>
Subject: [PATCH 2/2] mtd: spi-nor: intel-spi: add support for Intel Cannon
 Lake SPI flash
Thread-Topic: [PATCH 2/2] mtd: spi-nor: intel-spi: add support for Intel
 Cannon Lake SPI flash
Thread-Index: AQHVX8ABRdU28yqEZUSYr3dEEhcW0Q==
Date:   Sat, 31 Aug 2019 05:50:34 +0000
Message-ID: <6cc18e41-82a6-942b-6d91-6297f73a33da@fortanix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::23) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [76.236.28.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dca365f-662b-4005-82fb-08d72dd72458
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR1101MB2155;
x-ms-traffictypediagnostic: DM5PR1101MB2155:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB2155A7676AE8E21302D410F7AABC0@DM5PR1101MB2155.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 014617085B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39840400004)(136003)(199004)(189003)(186003)(1250700005)(476003)(5660300002)(6486002)(53936002)(8936002)(316002)(7736002)(25786009)(4326008)(7416002)(26005)(66556008)(14454004)(99286004)(6116002)(8676002)(52116002)(71190400001)(66946007)(3846002)(81166006)(81156014)(71200400001)(36756003)(66476007)(64756008)(66446008)(102836004)(31686004)(2906002)(2501003)(110136005)(2616005)(6506007)(386003)(2201001)(478600001)(6512007)(305945005)(86362001)(107886003)(256004)(6436002)(486006)(31696002)(66066001)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2155;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xM1rE8cEKaedHFR3E0Nv7YGn0xDyDZ14e8pqhoWmMwyFXfSdOA/cM0ye35AFKRd75Vbwi++DWxOp6/2VOLc/7G9FQHlqqVVLDGtvRX1OoAWNcEvEBH2N14mF4bZb2AMy/zeGM2dXjh4QL3QysC8zhCYh8f2/ZtiLHNNHrp6u5VtZPDe6ehH5GHsqS7+7sk/3/lkyPBmRM1DPaYFwlFHVR69phjLhiLXNGkYOKHD+YyODCtMTMvTrIqGk9fEY6D6nj2U3GfxDBHcH63MsL9cEO1ZC+oiLEalKq7Ad4PVZtui4lpLodNqUMpZqkBGqjOLKy3F/b4yCsJvKgLo0W/nuNt2UZsLUCVnwVU5KsmlNlIQ9WWgclnYwRMsCotvIm/Q/4whuG24tlbHs+8+O2xDnGNwwSZG65NLHxpBRjuH0Xes=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91B75CAE7173B94599DAEA4F3218C962@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dca365f-662b-4005-82fb-08d72dd72458
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2019 05:50:34.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YdT5YdkkNSboNxfgXP1FnHcvRJKiRMkJ6kdOMCCwbT2k3LYEP+qX2wj9/c2Iuclsy8Foh0aE7Ly84LagEPQiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KGFwb2xvZ2llcywgcmVzZW5kaW5nIHdpdGhvdXQgUy9NSU1FIHNpZ25hdHVyZSkNCg0KTm93IHRo
YXQgU1BJIGZsYXNoIGNvbnRyb2xsZXJzIHdpdGhvdXQgYSBzb2Z0d2FyZSBzZXF1ZW5jZXIgYXJl
DQpzdXBwb3J0ZWQsIGl0J3MgdHJpdmlhbCB0byBhZGQgc3VwcG9ydCBmb3IgQ05MIGFuZCBpdHMg
UENJIElELg0KDQpTaWduZWQtb2ZmLWJ5OiBKZXRocm8gQmVla21hbiA8amV0aHJvQGZvcnRhbml4
LmNvbT4NCi0tLQ0KICAgZHJpdmVycy9tdGQvc3BpLW5vci9pbnRlbC1zcGktcGNpLmMgICAgIHwg
IDUgKysrKysNCiAgIGRyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwtc3BpLmMgICAgICAgICB8IDEx
ICsrKysrKysrKysrDQogICBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvaW50ZWwtc3BpLmgg
fCAgMSArDQogICAzIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvaW50ZWwtc3BpLXBjaS5jIA0KYi9kcml2ZXJzL210ZC9z
cGktbm9yL2ludGVsLXNwaS1wY2kuYw0KaW5kZXggYjgzYzRhYjYuLjE5NWEwOWQgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS1wY2kuYw0KKysrIGIvZHJpdmVycy9t
dGQvc3BpLW5vci9pbnRlbC1zcGktcGNpLmMNCkBAIC0yMCw2ICsyMCwxMCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IGludGVsX3NwaV9ib2FyZGluZm8gYnh0X2luZm8gPSB7DQogICAJLnR5cGUgPSBJ
TlRFTF9TUElfQlhULA0KICAgfTsNCiAgICtzdGF0aWMgY29uc3Qgc3RydWN0IGludGVsX3NwaV9i
b2FyZGluZm8gY25sX2luZm8gPSB7DQorCS50eXBlID0gSU5URUxfU1BJX0NOTCwNCit9Ow0KKw0K
ICAgc3RhdGljIGludCBpbnRlbF9zcGlfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LA0K
ICAgCQkJICAgICAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkNCiAgIHsNCkBAIC02
Nyw2ICs3MSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBpbnRlbF9zcGlf
cGNpX2lkc1tdID0gew0KICAgCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4NGIyNCksICh1bnNpZ25l
ZCBsb25nKSZieHRfaW5mbyB9LA0KICAgCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4YTFhNCksICh1
bnNpZ25lZCBsb25nKSZieHRfaW5mbyB9LA0KICAgCXsgUENJX1ZERVZJQ0UoSU5URUwsIDB4YTIy
NCksICh1bnNpZ25lZCBsb25nKSZieHRfaW5mbyB9LA0KKwl7IFBDSV9WREVWSUNFKElOVEVMLCAw
eGEzMjQpLCAodW5zaWduZWQgbG9uZykmY25sX2luZm8gfSwNCiAgIAl7IH0sDQogICB9Ow0KICAg
TU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGludGVsX3NwaV9wY2lfaWRzKTsNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLXNwaS5jIA0KYi9kcml2ZXJzL210ZC9zcGktbm9y
L2ludGVsLXNwaS5jDQppbmRleCAxOTVjZGNhLi45MWI3ODUxIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9pbnRlbC1zcGkuYw0KKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9pbnRl
bC1zcGkuYw0KQEAgLTEwOCw2ICsxMDgsMTAgQEANCiAgICNkZWZpbmUgQlhUX0ZSRUdfTlVNCQkJ
MTINCiAgICNkZWZpbmUgQlhUX1BSX05VTQkJCTYNCiAgICsjZGVmaW5lIENOTF9QUgkJCQkweDg0
DQorI2RlZmluZSBDTkxfRlJFR19OVU0JCQk2DQorI2RlZmluZSBDTkxfUFJfTlVNCQkJNQ0KKw0K
ICAgI2RlZmluZSBMVlNDQwkJCQkweGM0DQogICAjZGVmaW5lIFVWU0NDCQkJCTB4YzgNCiAgICNk
ZWZpbmUgRVJBU0VfT1BDT0RFX1NISUZUCQk4DQpAQCAtMzQ0LDYgKzM0OCwxMyBAQCBzdGF0aWMg
aW50IGludGVsX3NwaV9pbml0KHN0cnVjdCBpbnRlbF9zcGkgKmlzcGkpDQogICAJCWlzcGktPmVy
YXNlXzY0ayA9IHRydWU7DQogICAJCWJyZWFrOw0KICAgKwljYXNlIElOVEVMX1NQSV9DTkw6DQor
CQlpc3BpLT5zcmVncyA9IE5VTEw7DQorCQlpc3BpLT5wcmVncyA9IGlzcGktPmJhc2UgKyBDTkxf
UFI7DQorCQlpc3BpLT5ucmVnaW9ucyA9IENOTF9GUkVHX05VTTsNCisJCWlzcGktPnByX251bSA9
IENOTF9QUl9OVU07DQorCQlicmVhazsNCisNCiAgIAlkZWZhdWx0Og0KICAgCQlyZXR1cm4gLUVJ
TlZBTDsNCiAgIAl9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2lu
dGVsLXNwaS5oIA0KYi9pbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2RhdGEvaW50ZWwtc3BpLmgNCmlu
ZGV4IGViYjRmMzMuLjdmNTNhNWMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3BsYXRmb3Jt
X2RhdGEvaW50ZWwtc3BpLmgNCisrKyBiL2luY2x1ZGUvbGludXgvcGxhdGZvcm1fZGF0YS9pbnRl
bC1zcGkuaA0KQEAgLTEzLDYgKzEzLDcgQEAgZW51bSBpbnRlbF9zcGlfdHlwZSB7DQogICAJSU5U
RUxfU1BJX0JZVCA9IDEsDQogICAJSU5URUxfU1BJX0xQVCwNCiAgIAlJTlRFTF9TUElfQlhULA0K
KwlJTlRFTF9TUElfQ05MLA0KICAgfTsNCiAgICAvKioNCi0tIA0KMi43LjQNCg0KDQo=
