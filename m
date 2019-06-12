Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E041C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2452082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="LlIO+4BV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439991AbfFLPHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:07:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:6516 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436492AbfFLPHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:07:38 -0400
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
X-IronPort-AV: E=Sophos;i="5.63,366,1557212400"; 
   d="scan'208";a="36659531"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jun 2019 08:07:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 12 Jun 2019 08:07:36 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 12 Jun 2019 08:07:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SFUN4teCBT5pyrNrsmMfUd4knm3MgtGo4sy4L6I3TQ=;
 b=LlIO+4BVi9NLKelPSbjs6nofh7n+Aq8QYBZi2a1SwI58wt+ERo9W/snIisnpYKQ2jwm6vbfuBKVUNfnojTMNemGqjUcFX7YLuuaCikzotOdDJjPsFzVdb2d+whgBbRxyWedw9Z1dfRpNiLLzAi3vVMtSkLIo1wF3JfdV7GhYmxY=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB3922.namprd11.prod.outlook.com (10.255.129.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 12 Jun 2019 15:07:35 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1965.017; Wed, 12 Jun 2019
 15:07:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dinguyen@kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <marex@denx.de>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <tien.fong.chee@intel.com>
Subject: Re: [PATCHv5 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Topic: [PATCHv5 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Index: AQHVISx/nxExbj8ViUqf7roc85XDN6aYHryA
Date:   Wed, 12 Jun 2019 15:07:35 +0000
Message-ID: <2ee32a0d-7523-0b23-072e-e68af4977db7@microchip.com>
References: <20190612143744.30718-1-dinguyen@kernel.org>
 <20190612143744.30718-2-dinguyen@kernel.org>
In-Reply-To: <20190612143744.30718-2-dinguyen@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::19) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28e68c79-39a1-4a27-f318-08d6ef47b310
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB3922;
x-ms-traffictypediagnostic: BN6PR11MB3922:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN6PR11MB392245949C03441130221B0BF0EC0@BN6PR11MB3922.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0066D63CE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(366004)(376002)(189003)(199004)(6486002)(186003)(14454004)(66476007)(4326008)(73956011)(229853002)(316002)(66556008)(6436002)(102836004)(66946007)(31686004)(2906002)(6246003)(26005)(53546011)(6506007)(36756003)(11346002)(54906003)(68736007)(66446008)(64756008)(2501003)(3846002)(110136005)(5660300002)(386003)(6116002)(8676002)(71190400001)(71200400001)(6512007)(66066001)(486006)(446003)(81166006)(14444005)(31696002)(8936002)(52116002)(6306002)(81156014)(7736002)(256004)(99286004)(2616005)(476003)(305945005)(72206003)(966005)(478600001)(86362001)(53936002)(25786009)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB3922;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EwhDRmlhhGO3jRxJ/5h7PytHMD7O6va+7yoxN/i8Gsuc//PIYOksvo5v0WyT8HUn2TNqKeb4ZAIxSSI/mHev6NIC6oOhCxtn/N2XctM/Wj+8JX7wYIBsrBrDYOjiZO5vQT/lGOavr4geLvxwtzeyLC1M8K6yVASs82szZpFu2Vb7qCXcqbSdXtCrb1AZTzTKZWFtGIZfU6OXrhD6rEfEFgYwh/peMrzg1ot/TOpVM9+7Mf6tv63QR03jctkqVdHo+qwxbamoCwem4yASxL0GTvRcPsSetqdO5PJsKCryb/Lw90YmuVeeICJpUKDHuOnxQozWFon5iy4NWqRFRwFzWNNdVdU1cN27NB4pny8+PtnR2kfMUD4dTYFo5/vJ2CLMlWVN+T373HYxT8bxvRltJzJA+lhzrdfQSLBBsijuMtU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3F3C960F554DE449E5E524682FCB736@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e68c79-39a1-4a27-f318-08d6ef47b310
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2019 15:07:35.0397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3922
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA2LzEyLzIwMTkgMDU6MzcgUE0sIERpbmggTmd1eWVuIHdyb3RlOg0KPiBFeHRlcm5h
bCBFLU1haWwNCj4gDQo+IA0KPiBHZXQgdGhlIHJlc2V0IGNvbnRyb2wgcHJvcGVydGllcyBmb3Ig
dGhlIFFTUEkgY29udHJvbGxlciBhbmQgYnJpbmcgdGhlbQ0KPiBvdXQgb2YgcmVzZXQuIE1vc3Qg
d2lsbCBoYXZlIGp1c3Qgb25lIHJlc2V0IGJpdCwgYnV0IHRoZXJlIGlzIGFuIGFkZGl0aW9uYWwN
Cj4gT0NQIHJlc2V0IGJpdCB0aGF0IGlzIHVzZWQgRUNDLiBUaGUgT0NQIHJlc2V0IGJpdCB3aWxs
IGFsc28gbmVlZCB0byBnZXQNCj4gZGUtYXNzZXJ0ZWQgYXMgd2VsbC4gWzFdDQo+IA0KPiBUaGUg
cmVhc29uIHRoaXMgcGF0Y2ggaXMgbmVlZGVkIGlzIGluIHRoZSBjYXNlIHdoZXJlIGEgYm9vdGxv
YWRlciBsZWF2ZXMNCj4gdGhlIFFTUEkgY29udHJvbGxlciBpbiBhIHJlc2V0IHN0YXRlLCBvciBh
IHN0YXRlIHdoZXJlIGluaXQgY2Fubm90IG9jY3VyDQo+IHN1Y2Nlc3NmdWxseSwgdGhpcyBwYXRj
aCB3aWxsIHB1dCB0aGUgUVNQSSBjb250cm9sbGVyIGludG8gYSBjbGVhbiBzdGF0ZS4NCj4gDQo+
IFsxXSBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vcHJvZ3JhbW1hYmxl
L2hwcy9hcnJpYS0xMC9ocHMuaHRtbCNyZWdfc29jX3RvcC9zZm8xNDI5ODkwNTc1OTU1Lmh0bWwN
Cj4gDQo+IFN1Z2dlc3RlZC1ieTogVGllbi1Gb25nIENoZWUgPHRpZW4uZm9uZy5jaGVlQGludGVs
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGluaCBOZ3V5ZW4gPGRpbmd1eWVuQGtlcm5lbC5vcmc+
DQo+IC0tLQ0KPiB2NTogcmVtb3ZlIHVkZWxheShub3QgbmVlZGVkKSBvbiB0ZXN0ZWQgaGFyZHdh
cmUNCj4gICAgIGdyb3VwIHJlc2V0IGFzc2VydC9kZWFzc2VydCB0b2dldGhlcg0KPiAgICAgdXBk
YXRlIGNvbW1pdCBtZXNzYWdlIHdpdGggcmVhc29uaW5nIGZvciBwYXRjaA0KPiB2NDogZml4IGNv
bXBpbGUgZXJyb3INCj4gdjM6IHJldHVybiBmdWxsIGVycm9yIGJ5IHVzaW5nIFBUUl9FUlIocnRz
YykNCj4gICAgIG1vdmUgcmVzZXQgY29udHJvbCBjYWxscyB1bnRpbCBhZnRlciB0aGUgY2xvY2sg
ZW5hYmxlcw0KPiAgICAgdXNlIHVkZWxheSgyKSB0byBiZSBzYWZlDQo+ICAgICBBZGQgb3B0aW9u
YWwgT0NQKE9wZW4gQ29yZSBQcm90b2NvbCkgcmVzZXQgc2lnbmFsDQo+IHYyOiB1c2UgZGV2bV9y
ZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUNCj4gICAgIHByaW50IGFuIGVycm9y
IG1lc3NhZ2UNCj4gICAgIHJldHVybiAtRVBST0JFX0RFRkVSDQo+IC0tLQ0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9jYWRlbmNlLXF1YWRzcGkuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jDQo+IGluZGV4IDc5MjYyODc1MGVlYy4uZjhiMTAwOWU0
ODhjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5j
DQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMNCj4gQEAgLTM0
LDYgKzM0LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4g
KyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+
ICAjaW5jbHVkZSA8bGludXgvc3BpL3NwaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3RpbWVyLmg+
DQo+IEBAIC0xMzM2LDYgKzEzMzcsOCBAQCBzdGF0aWMgaW50IGNxc3BpX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJc3RydWN0IGNxc3BpX3N0ICpjcXNwaTsNCj4gIAlz
dHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlc19haGI7DQo+ICsJ
c3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdGM7DQo+ICsJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJz
dGNfb2NwOw0KPiAgCWNvbnN0IHN0cnVjdCBjcXNwaV9kcml2ZXJfcGxhdGRhdGEgKmRkYXRhOw0K
PiAgCWludCByZXQ7DQo+ICAJaW50IGlycTsNCj4gQEAgLTE0MDIsNiArMTQwNSwyOSBAQCBzdGF0
aWMgaW50IGNxc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWdv
dG8gcHJvYmVfY2xrX2ZhaWxlZDsNCj4gIAl9DQo+ICANCj4gKwkvKiBPYnRhaW4gUVNQSSByZXNl
dCBjb250cm9sICovDQo+ICsJcnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxf
ZXhjbHVzaXZlKGRldiwgInFzcGkiKTsNCj4gKwlpZiAoSVNfRVJSKHJzdGMpKSB7DQo+ICsJCWRl
dl9lcnIoZGV2LCAiQ2Fubm90IGdldCBRU1BJIHJlc2V0LlxuIik7DQo+ICsJCXJldHVybiBQVFJf
RVJSKHJzdGMpOw0KPiArCX0NCj4gKw0KPiArCXJzdGNfb2NwID0gZGV2bV9yZXNldF9jb250cm9s
X2dldF9vcHRpb25hbF9leGNsdXNpdmUoZGV2LCAicXNwaS1vY3AiKTsNCj4gKwlpZiAoSVNfRVJS
KHJzdGNfb2NwKSkgew0KPiArCQlkZXZfZXJyKGRldiwgIkNhbm5vdCBnZXQgUVNQSSBPQ1AgcmVz
ZXQuXG4iKTsNCj4gKwkJcmV0dXJuIFBUUl9FUlIocnN0Y19vY3ApOw0KPiArCX0NCj4gKw0KPiAr
CWlmIChyc3RjKSB7DQoNCkhpLCBEaW5oLA0KDQpyZXNldF9jb250cm9sX2Fzc2VydC9kZWFzc2Vy
dCgpIGFscmVhZHkgaGF2ZSBjaGVja3MgZm9yIG51bGwsIHlvdSBjYW4gY2FsbCB0aGVtDQpkaXJl
Y3RseSB3aXRob3V0IGNoZWNraW5nIGZvciBudWxsLg0KDQo+ICsJCXJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KHJzdGMpOw0KPiArCQlyZXNldF9jb250cm9sX2RlYXNzZXJ0KHJzdGMpOw0KDQpJcyB0aGVy
ZSBhbnkgZGlmZmVyZW5jZSBiZXR3ZWVuOg0KcmVzZXRfY29udHJvbF9hc3NlcnQocnN0Yyk7DQpy
ZXNldF9jb250cm9sX2Fzc2VydChyc3RjX29jcCk7DQoNCnJlc2V0X2NvbnRyb2xfZGVhc3NlcnQo
cnN0Yyk7DQpyZXNldF9jb250cm9sX2RlYXNzZXJ0KHJzdGNfb2NwKTsNCg0KYW5kOg0KDQpyZXNl
dF9jb250cm9sX2Fzc2VydChyc3RjKTsNCnJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocnN0Yyk7DQoN
CnJlc2V0X2NvbnRyb2xfYXNzZXJ0KHJzdGNfb2NwKTsNCnJlc2V0X2NvbnRyb2xfZGVhc3NlcnQo
cnN0Y19vY3ApOw0KDQpXaGljaCBvbmUgd291bGQgeW91IGNob29zZT8NCg0KVGhhbmtzLCBEaW5o
LA0KdGENCg0KPiArDQo+ICsJCWlmIChyc3RjX29jcCkgew0KPiArCQkJcmVzZXRfY29udHJvbF9h
c3NlcnQocnN0Y19vY3ApOw0KPiArCQkJcmVzZXRfY29udHJvbF9kZWFzc2VydChyc3RjX29jcCk7
DQo+ICsJCX0NCj4gKwl9DQo+ICsNCj4gIAljcXNwaS0+bWFzdGVyX3JlZl9jbGtfaHogPSBjbGtf
Z2V0X3JhdGUoY3FzcGktPmNsayk7DQo+ICAJZGRhdGEgID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9k
YXRhKGRldik7DQo+ICAJaWYgKGRkYXRhICYmIChkZGF0YS0+cXVpcmtzICYgQ1FTUElfTkVFRFNf
V1JfREVMQVkpKQ0KPiANCg==
