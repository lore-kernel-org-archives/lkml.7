Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E0CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A1F208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lU8DoV05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391493AbfISPyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:54:55 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:26007 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390161AbfISPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:54:55 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: uG3XXq3hZkH/QxyvTJBYqH0W9vM6Is/CidOWH92hUE+R+IKWq+qXmj+qNRsM7OYWriMl+U0Dkl
 rj+hpwtqBNpzS9yFbfkVpi61eIhxXE57wk+oN47+6jRT3qLlvXCQaYnRROwkKlsxMv0ZN3t1cO
 TotMPXazP+N48Th/NKYZJqRbM2O1SyA6USjHzcP4JQ9NoMpGIIxRsF0zHb8k4Er8dsgLYhEzsV
 Dn1D1gEP5alO3EcW5EPS9I7e19PdHnGHsmpyDy2N5YDdRYhdQkZFwu355GKEKVbVdUpIrKzoUP
 q7U=
X-IronPort-AV: E=Sophos;i="5.64,524,1559545200"; 
   d="scan'208";a="49559752"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Sep 2019 08:54:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 19 Sep 2019 08:54:53 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 19 Sep 2019 08:54:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMbXIbZSDM5/o3m4JYCJ85rAk+CGGZDsfh84YSst+5kOJrp45C485fYNtpRIL6Cg9LVeagH8QW/duzQNnfnSyjraKP6176TyscvHWskKCHS3eJj+Ol7QuMkrv4M12nWdFNI5dJXxFLO5acTxYBobeBwP/xlImmUwucTIUv9GMvjLk3UQYKZjlm6Ij3vuJdSmviErbY5Hx+Omowzsh6OBqLrJ1xzLr4+2JvTNW7Btr823TGNAhDZEU4xWYp0YbbZ5b9PCYQWJtzy+sCYdRHqFmGCOrwwjF4Z6OFjxq83s6fTQ3XP8QCbBN1zIrq7bXcWqSq1yi0oNMYKM5XhY3RfLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvBqlTjjUjcU2RJnUhN/ybdRGZUNSe6dRYQbGHmm1aY=;
 b=HyWeNvoHEHMMRIbpx3MkfLvX49yUzTS835y1cp5Bk3W6bMerISaZfAeD86FMh3ooRfdu9U4+1Y83px6otdYLCENH+5+VKhkhFsGdQWbp4blZ0DAFlhTxq2GGnCvweCNfP+gJX3f6X569wbWNTDMB390AdEXASZEp7Dae03EficO2qC39TvzdSHjUIAyHDdmCJt4PiNJEZHfm+fkBQSBvOqaz/UHdBImx8tmg3fIXiWY1s3uQOE8DjBpzvlKO/7IV3zXN56BE3ZBq7H5WYoHAz05Vo6SHnIfb+JF58fWAS5exIvk652mZItZHnlj08mUd6migzU/0zHp1tBxWYeQbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvBqlTjjUjcU2RJnUhN/ybdRGZUNSe6dRYQbGHmm1aY=;
 b=lU8DoV05xdX1C/i3lEOzAbVBvzkzx9rJYizP0nL53y0OsdBHR2zC6mYwDLWPp6/1mEyJxEigrexeY1ZzYvZwpQxqhWqlCKWmPcS+1eJk7k6CQzMk0+v1oz9NS+9mMAczZqSFAT+BXrWDsVOpbycV0yzXw2hB5fIQtv43brnrP+s=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3565.namprd11.prod.outlook.com (20.178.250.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Thu, 19 Sep 2019 15:54:52 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 15:54:52 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Topic: [PATCH 17/23] mtd: spi-nor: Fix clearing of QE bit on
 lock()/unlock()
Thread-Index: AQHVbXBXffWwZrBoIkKrGGyrhA4/GaczE40AgAAWrYA=
Date:   Thu, 19 Sep 2019 15:54:52 +0000
Message-ID: <b44e398a-037a-8f32-58dd-15b7f714a8a3@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
 <20190917155426.7432-18-tudor.ambarus@microchip.com>
 <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
In-Reply-To: <dceca616-2b98-9bc8-73e4-32fb06fc753d@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0601CA0032.eurprd06.prod.outlook.com
 (2603:10a6:800:1e::42) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.240.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d864dd75-6ef7-43f1-b1eb-08d73d19b529
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3565;
x-ms-traffictypediagnostic: MN2PR11MB3565:
x-microsoft-antispam-prvs: <MN2PR11MB35653728F4E9B9C744509A04F0890@MN2PR11MB3565.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(396003)(346002)(366004)(189003)(199004)(2201001)(316002)(7736002)(66066001)(386003)(6116002)(53546011)(102836004)(36756003)(305945005)(7416002)(52116002)(54906003)(14454004)(2906002)(6486002)(5660300002)(6506007)(99286004)(86362001)(76176011)(31696002)(81166006)(256004)(8676002)(66476007)(66446008)(66946007)(81156014)(71200400001)(478600001)(25786009)(6436002)(26005)(110136005)(229853002)(486006)(64756008)(2501003)(3846002)(11346002)(66556008)(186003)(31686004)(6512007)(8936002)(2616005)(6246003)(4326008)(476003)(446003)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3565;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZM4OLvXnRBoH4hsXSleSV5Pms57QMkr/UZmqCE/g8If+16KIv/YovGT9jA+bXC1/2BpK+AhyxQ5F2jGSGSwGFkvfbqapvy2+ZcZmG1hJ1knOXWdt0tKa94GTQREwppdw2XrJDxIM19d+qi68cprp3rA1xDLhiZpRUaABWwfDfcLSuKpVf2DsL95zYI/ywqEX/66HqhdxuGJ8P2q728TLOxHJdnlh5/7HquCiI2hFjWA+DGWT9YNeiOBA2EAym8cZmPbC+Gm9Grtd/QjF4ikAE8UbZvJgnALaWw6FkWFNo2MHVOxICi5Um495hV+0vkErpzCihluETRE2Uxwl27P0khWcnw03QuNT1OZgCSykRr0WFUOB8xbIlsRKnkVS7E8zs31DvBiSGdu8NAoc09zSEfyH+pGECbV8aci3shgWvg8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3CB4932602AE44EB0B07313F1DB679F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d864dd75-6ef7-43f1-b1eb-08d73d19b529
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 15:54:52.1538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jpQtW4wR+cplVTj5uECnldbPOZpTn4Pb+uJ3vkyn4Lwni9tOZBCiMcArC+xk3XNSYhSjEVsPGk/90UgoAlqnxJMMlmzCUMOSXV1bnCRYPgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzE5LzIwMTkgMDU6MzMgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEhpIFR1ZG9yDQo+IA0KDQpIaSwgVmlnbmVzaCwNCg0KPiBbLi4uXQ0KPiANCj4gT24gMTctU2Vw
LTE5IDk6MjUgUE0sIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+ICtzdGF0
aWMgaW50IHNwaV9ub3Jfd3JpdGVfMTZiaXRfc3JfYW5kX2NoZWNrKHN0cnVjdCBzcGlfbm9yICpu
b3IsIHU4IHN0YXR1c19uZXcsDQo+PiArCQkJCQkgICAgdTggbWFzaykNCj4+ICt7DQo+PiArCWlu
dCByZXQ7DQo+PiArCXU4ICpzcl9jciA9IG5vci0+Ym91bmNlYnVmOw0KPj4gKwl1OCBjcl93cml0
dGVuOw0KPj4gKw0KPj4gKwkvKiBNYWtlIHN1cmUgd2UgZG9uJ3Qgb3ZlcndyaXRlIHRoZSBjb250
ZW50cyBvZiBTdGF0dXMgUmVnaXN0ZXIgMi4gKi8NCj4+ICsJaWYgKCEobm9yLT5mbGFncyAmIFNO
T1JfRl9OT19SRUFEX0NSKSkgew0KPiBBc3N1bWluZyBTTk9SX0ZfTk9fUkVBRF9DUiBpcyBub3Qg
c2V0Li4uDQo+IA0Kd2hlbiBTTk9SX0ZfTk9fUkVBRF9DUiBpcyBub3Qgc2V0LCBJIHJlYWQgdGhl
IFN0YXR1cyBSZWdpc3RlciAyIG9uIHRoZSBuZXh0IGxpbmU6DQoNCj4+ICsJCXJldCA9IHNwaV9u
b3JfcmVhZF9jcihub3IsICZzcl9jclsxXSk7DQo+PiArCQlpZiAocmV0KQ0KPj4gKwkJCXJldHVy
biByZXQ7DQo+PiArCX0gZWxzZSBpZiAobm9yLT5mbGFzaC5xdWFkX2VuYWJsZSkgew0KPj4gKwkJ
LyoNCj4+ICsJCSAqIElmIHRoZSBTdGF0dXMgUmVnaXN0ZXIgMiBSZWFkIGNvbW1hbmQgKDM1aCkg
aXMgbm90DQo+PiArCQkgKiBzdXBwb3J0ZWQsIHdlIHNob3VsZCBhdCBsZWFzdCBiZSBzdXJlIHdl
IGRvbid0DQo+PiArCQkgKiBjaGFuZ2UgdGhlIHZhbHVlIG9mIHRoZSBTUjIgUXVhZCBFbmFibGUg
Yml0Lg0KPj4gKwkJICoNCj4+ICsJCSAqIFdlIGNhbiBzYWZlbHkgYXNzdW1lIHRoYXQgd2hlbiB0
aGUgUXVhZCBFbmFibGUgbWV0aG9kIGlzDQo+PiArCQkgKiBzZXQsIHRoZSB2YWx1ZSBvZiB0aGUg
UUUgYml0IGlzIG9uZSwgYXMgYSBjb25zZXF1ZW5jZSBvZiB0aGUNCj4+ICsJCSAqIG5vci0+Zmxh
c2gucXVhZF9lbmFibGUoKSBjYWxsLg0KPj4gKwkJICoNCj4+ICsJCSAqIFdlIGNhbiBzYWZlbHkg
YXNzdW1lIHRoYXQgdGhlIFF1YWQgRW5hYmxlIGJpdCBpcyBwcmVzZW50IGluDQo+PiArCQkgKiB0
aGUgU3RhdHVzIFJlZ2lzdGVyIDIgYXQgQklUKDEpLiBBY2NvcmRpbmcgdG8gdGhlIEpFU0QyMTYN
Cj4+ICsJCSAqIHJldkIgc3RhbmRhcmQsIEJGUFQgRFdPUkRTWzE1XSwgYml0cyAyMjoyMCwgdGhl
IDE2LWJpdA0KPj4gKwkJICogV3JpdGUgU3RhdHVzICgwMWgpIGNvbW1hbmQgaXMgYXZhaWxhYmxl
IGp1c3QgZm9yIHRoZSBjYXNlcw0KPj4gKwkJICogaW4gd2hpY2ggdGhlIFFFIGJpdCBpcyBkZXNj
cmliZWQgaW4gU1IyIGF0IEJJVCgxKS4NCj4+ICsJCSAqLw0KDQp3aGVuIFNOT1JfRl9OT19SRUFE
X0NSIGlzIHNldCBhbmQgbm9yLT5mbGFzaC5xdWFkX2VuYWJsZSAhPSBOVUxMLCBTdGF0dXMNClJl
Z2lzdGVyIDIgKENSKSBpcyBlcXVhbCB0byBDUl9RVUFEX0VOX1NQQU4uDQoNCj4+ICsJCXNyX2Ny
WzFdID0gQ1JfUVVBRF9FTl9TUEFOOw0KPj4gKwl9IGVsc2Ugew0KDQppZiBTTk9SX0ZfTk9fUkVB
RF9DUiBpcyBzZXQgYW5kIG5vci0+Zmxhc2gucXVhZF9lbmFibGUgPT0gTlVMTCB3ZSBkb24ndCBu
ZWVkIHRvDQplbmFibGUgUXVhZCBNb2RlLCBzbyBTdGF0dXMgUmVnaXN0ZXIgMiBpcyAwLg0KDQo+
PiArCQlzcl9jclsxXSA9IDA7DQo+PiArCX0NCj4+ICsNCj4gQ1JfUVVBRF9FTl9TUEFOIHdpbGwg
bm90IGJlIGluIHNyX2NyWzFdIHdoZW4gd2UgcmVhY2ggaGVyZS4gU28gY29kZQ0KPiB3b24ndCBl
bmFibGUgcXVhZCBtb2RlLg0KPiANCj4gDQo=
