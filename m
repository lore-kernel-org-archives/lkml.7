Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F221C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 11:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1387620657
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="CE5P4Vew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfFVLta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 07:49:30 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:29268 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVLt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 07:49:29 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,404,1557212400"; 
   d="scan'208";a="37969140"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2019 04:49:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 22 Jun 2019 04:49:26 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 22 Jun 2019 04:49:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGMzP4NIhKHYOQskA5N/aQBSc8PRYGkAM7AV7HMVgTA=;
 b=CE5P4Vew1V9icQ3C0kVcuXaNJZ4hYPa81I3OtXu0m6Y6ykXuJ9Otgb29/P0/keufftay2qDdv0/zA1PE9EYeR1r6vUHBMZCyr33GyU+0cDJg7SJWpmVUlYjidnr2UfxKuvCZkuuycGsYZOb2xkEPKszr/ZkYwe5w16bDA1U/HPc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1489.namprd11.prod.outlook.com (10.172.22.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13; Sat, 22 Jun 2019 11:49:26 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1987.017; Sat, 22 Jun 2019
 11:49:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <liu.xiang6@zte.com.cn>, <linux-mtd@lists.infradead.org>
CC:     <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <marek.vasut@gmail.com>,
        <liuxiang_1999@126.com>, <computersforpeace@gmail.com>,
        <dwmw2@infradead.org>, <nagasure@xilinx.com>, <vigneshr@ti.com>
Subject: Re: [PATCH v3] mtd: spi-nor: fix nor->addr_width when its value
 configured from SFDP does not match the actual width
Thread-Topic: [PATCH v3] mtd: spi-nor: fix nor->addr_width when its value
 configured from SFDP does not match the actual width
Thread-Index: AQHU55VmKdhoFdZiLUGlGE6PYVpZk6aoEd+A
Date:   Sat, 22 Jun 2019 11:49:25 +0000
Message-ID: <5ffc9e32-ff69-9819-7bfd-ad9f793bb629@microchip.com>
References: <1554018157-10860-1-git-send-email-liu.xiang6@zte.com.cn>
In-Reply-To: <1554018157-10860-1-git-send-email-liu.xiang6@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:d0::20) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.138.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66b1799c-ef32-402f-78f9-08d6f707acb1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR11MB1489;
x-ms-traffictypediagnostic: BN6PR11MB1489:
x-microsoft-antispam-prvs: <BN6PR11MB14899215CA39D616AD987004F0E60@BN6PR11MB1489.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0076F48C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(199004)(189003)(31686004)(8936002)(68736007)(52116002)(25786009)(186003)(6486002)(7736002)(76176011)(2906002)(305945005)(81166006)(54906003)(72206003)(110136005)(71200400001)(81156014)(8676002)(71190400001)(486006)(14454004)(2501003)(478600001)(476003)(11346002)(99286004)(36756003)(6116002)(2616005)(3846002)(446003)(53546011)(6506007)(53936002)(31696002)(386003)(256004)(86362001)(316002)(14444005)(6512007)(26005)(6246003)(5660300002)(73956011)(66446008)(4326008)(7416002)(66946007)(6436002)(66066001)(102836004)(229853002)(64756008)(66556008)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1489;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8gxXBSRGsc1knDZNI4QcvRwVhHF5T6+x+QlxH5TSj5zGmlarszO8H5mF3+nqYvQsuRoE3enoLUDOOuPfPk1znQ8hwe0nmuBJCh7FEVJdwLYY59G+3nTl77JOm6ZOYWJAQEJivm9VaIlrb7O8L4Sdk3+RARa7TNvQYXfiUOwnxcGTKYMl/0m1O6yR+T6EewBIjNVSfDYZxIRwV0aPV40sJ0tuPQYh9ETxjuGSPA1C0hw3OUZgWC/lvzRxzPJD0JAKZmmy4mD8aNuQgSEcDDbl357O/b+I+eG/ktJd210A6Ky1EqdGeaRpOYyo+1luzHULi7oZEoa97EOcUxTdnDfulePRsbsz0GAmuolZFKKrkpaNC9FFU4NxBDx3OcOxGDoIx9NPp/BBQNOhqoENgiXFbZNpTf0F3IsrIflVFMDsPDQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C823C2096139CB458DB5A047284C88F3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b1799c-ef32-402f-78f9-08d6f707acb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2019 11:49:25.7430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1489
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExpdSwNCg0KT24gMDMvMzEvMjAxOSAxMDo0MiBBTSwgTGl1IFhpYW5nIHdyb3RlOg0KDQo+
IFNvbWUgaXMyNWxwMjU2IGdldCBCRlBUX0RXT1JEMV9BRERSRVNTX0JZVEVTXzNfT05MWSBmcm9t
IEJGUFQgdGFibGUgZm9yDQo+IGFkZHJlc3Mgd2lkdGguIEJ1dCBpbiBhY3R1YWwgZmFjdCB0aGUg
Zmxhc2ggY2FuIHN1cHBvcnQgNC1ieXRlIGFkZHJlc3MuDQo+IFNvIHdlIHNob3VsZCBmaXggaXQu
DQoNCkl0J3MgYmV0dGVyIHRvIGJlIGltcGVyYXRpdmUuIFN1YnN0aXR1dGUgIlNvIHdlIHNob3Vs
ZCBmaXggaXQiIHdpdGggc29tZXRoaW5nDQpsaWtlICJVc2UgYSBwb3N0IGJmcHQgZml4dXAgaG9v
ayB0byBvdmVyd3JpdGUgdGhlIGFkZHJlc3Mgd2lkdGggYWR2ZXJ0aXNlZCBieQ0KdGhlIEJGUFQi
Lg0KDQo+DQoNCldlJ2xsIG5lZWQgYSBmaXhlcyB0YWcgaGVyZS4+IFN1Z2dlc3RlZC1ieTogQm9y
aXMgQnJlemlsbG9uIDxiYnJlemlsbG9uQGtlcm5lbC5vcmc+DQo+IFN1Z2dlc3RlZC1ieTogVmln
bmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPg0KDQpXaGVuPyBJZiB0aGV5IGRpZG4n
dCBleHBsaWNpdGx5IHN1Z2dlc3RlZCB0aGlzIGFwcHJvYWNoLCBsZXRzIGRyb3AgdGhlIFMtYiB0
YWdzLg0KDQo+IFNpZ25lZC1vZmYtYnk6IExpdSBYaWFuZyA8bGl1LnhpYW5nNkB6dGUuY29tLmNu
Pg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+ICBhZGQgYSBmaXh1cCBmb3IgaXMyNWxw
MjU2IHRvIHNvbHZlIHRoZSBhZGRyZXNzIHdpZHRoIHByb2JsZW0uDQo+IA0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9zcGktbm9yLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKystDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9zcGktbm9yLmMNCj4gaW5kZXggNmUxM2JiZC4uZDI1MmE2NiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9zcGktbm9yLmMNCj4gQEAgLTE2ODIsNiArMTY4MiwyOCBAQCBzdGF0aWMgaW50IHNyMl9iaXQ3
X3F1YWRfZW5hYmxlKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICAJCS5mbGFncyA9IFNQSV9OT1Jf
Tk9fRlIgfCBTUElfUzNBTiwNCj4gIA0KPiAgc3RhdGljIGludA0KPiAraXMyNWxwMjU2X3Bvc3Rf
YmZwdF9maXh1cHMoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gKwkJCSAgIGNvbnN0IHN0cnVjdCBz
ZmRwX3BhcmFtZXRlcl9oZWFkZXIgKmJmcHRfaGVhZGVyLA0KPiArCQkJICAgY29uc3Qgc3RydWN0
IHNmZHBfYmZwdCAqYmZwdCwNCj4gKwkJCSAgIHN0cnVjdCBzcGlfbm9yX2ZsYXNoX3BhcmFtZXRl
ciAqcGFyYW1zKQ0KPiArew0KPiArCS8qDQo+ICsJICogSVMyNUxQMjU2IHN1cHBvcnRzIDRCIG9w
Y29kZXMuDQo+ICsJICogVW5mb3J0dW5hdGVseSwgc29tZSBkZXZpY2VzIGdldCBCRlBUX0RXT1JE
MV9BRERSRVNTX0JZVEVTXzNfT05MWQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4gd2hp
Y2ggZGV2aWNlcywgZGlkIHlvdSBnZXQgYSBsaXN0IGZyb20gaXNzaT8NCg0KPiArCSAqIGZyb20g
QkZQVCB0YWJsZSBmb3IgYWRkcmVzcyB3aWR0aC4gV2Ugc2hvdWxkIGZpeCBpdC4NCg0KSG93IGFi
b3V0ICJJUzI1TFAyNTYgc3VwcG9ydHMgNEIgb3Bjb2RlcywgYnV0IHRoZSBCRlBUIGFkdmVydGlz
ZXMgYQ0KQkZQVF9EV09SRDFfQUREUkVTU19CWVRFU18zX09OTFkgYWRkcmVzcyB3aWR0aC4gT3Zl
cndyaXRlIHRoZSBhZGRyZXNzIHdpZHRoDQphZHZlcnRpc2VkIGJ5IHRoZSBCRlBULiINCg0KPiAr
CSAqLw0KPiArCWlmICgoYmZwdC0+ZHdvcmRzW0JGUFRfRFdPUkQoMSldICYgQkZQVF9EV09SRDFf
QUREUkVTU19CWVRFU19NQVNLKSA9PQ0KPiArCQlCRlBUX0RXT1JEMV9BRERSRVNTX0JZVEVTXzNf
T05MWSkNCj4gKwkJbm9yLT5hZGRyX3dpZHRoID0gNDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiAr
fQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHNwaV9ub3JfZml4dXBzIGlzMjVscDI1Nl9maXh1cHMg
PSB7DQoNCk5hZ2Egd2lsbCB1c2UgImlzMjVscDI1Nl9maXh1cHMiIGZvciB0aGUgaXMyNXdwMjU2
IHRvbywgYnV0IGl0J3Mgbm90IHRoZSBjYXNlIHRvDQpjaGFuZ2UgdGhlIG5hbWUgeWV0LiBBbGwg
Z29vZCBoZXJlLg0KDQpJIHJlYWxseSB3YW50IHRvIGhhdmUgdGhpcyBpbiBuZXh0LCBjYW4gSSBo
YXZlIGFuIHVwZGF0ZSBpbiB0aGUgbmV4dCBmZXcgZGF5cz8NCg0KQ2hlZXJzLA0KdGENCg==
