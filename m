Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8086C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FB1207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ysQ4rtfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFFI0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:26:18 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:25847 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfFFI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:26:18 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.63,558,1557212400"; 
   d="scan'208";a="37793596"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jun 2019 01:26:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 01:26:17 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 6 Jun 2019 01:26:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odeFWaFpZNwa5JZJNwP5azheMwlbXo60RP5RHJq7i54=;
 b=ysQ4rtfO8uobkYXHoRzkJq+nZ/L3AiIzl7d5+zDL7jJHTyeqEqgdVsFzIj5zwpYKRVIrmI/eXEvWB+lRr6Oa1/b/VfQHwlpGnfXcW0/sxQvbqzHzPFV7FQWOFbYJEuCXl0Q1AuSONJuoU9G28MCf0HLMK8ir9rNZwwjpSs9OLrU=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1282.namprd11.prod.outlook.com (10.173.33.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 08:26:15 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e581:f807:acdc:cb36%9]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 08:26:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <dinguyen@kernel.org>, <linux-mtd@lists.infradead.org>
CC:     <marex@denx.de>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <bbrezillon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tien.fong.chee@intel.com>
Subject: Re: [PATCHv4 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Topic: [PATCHv4 2/2] mtd: spi-nor: cadence-quadspi: add reset control
Thread-Index: AQHVBaRFi6wbqwZTWkWm4oxToh2HuaaOd6yA
Date:   Thu, 6 Jun 2019 08:26:14 +0000
Message-ID: <73c8c69a-0756-811f-7a75-dd2255db7d7b@microchip.com>
References: <20190508134338.20565-1-dinguyen@kernel.org>
 <20190508134338.20565-2-dinguyen@kernel.org>
In-Reply-To: <20190508134338.20565-2-dinguyen@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0154.eurprd08.prod.outlook.com
 (2603:10a6:800:d5::32) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e3e5938-5646-4929-24ce-08d6ea58a3b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR11MB1282;
x-ms-traffictypediagnostic: BN6PR11MB1282:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN6PR11MB1282A76AA767FBD2692BE4E2F0170@BN6PR11MB1282.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(366004)(376002)(199004)(189003)(6306002)(36756003)(186003)(6436002)(486006)(2616005)(476003)(26005)(446003)(76176011)(53546011)(52116002)(102836004)(316002)(229853002)(86362001)(386003)(99286004)(6506007)(256004)(2501003)(6486002)(14444005)(110136005)(71200400001)(54906003)(66066001)(71190400001)(31696002)(8676002)(8936002)(81166006)(81156014)(11346002)(6512007)(5660300002)(6246003)(72206003)(305945005)(4326008)(7736002)(25786009)(53936002)(66476007)(66556008)(64756008)(478600001)(68736007)(66446008)(966005)(66946007)(6116002)(73956011)(2906002)(14454004)(31686004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1282;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IaP4CEjGn62ajzgjJzXwxHWK6LQhXnWbPC5YGL36wab/zjgzmeHG/Z5FhyBd4/zfs05scqwpsolmrrZd1Tvu3x0OEUYxPccykuu/urzNJzs3J0QNBb7h1Ah2ClXAIm3Bt5mhaSfnjB9KTf1ETj0SjH4y+hQrnTKQKGeHKRnkKIOmnn5IG6BYPXPMU3Ux8AOCWk8jNWbg8VSzode81BnklW7Dgq3dVE+19ls7iR4H16Qvl0C3KiA47lGrZQdN7PShLBmOU0nwONQeHLeUmD70ffJj8mAIPAZhhnRuLw0rZs5dUiq5cbJhDv0Htcf35LuxW1zj+08D2c8weciuraoDo35HU/5FVsdfMadeOd3BD53J/I56rc2q3ws7dez4CJDg10kT/tauSrXlIwOVEeIYILPUurZE2rrwOFNwIaLbFVU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE9381236212B2468C06D51844F00A69@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3e5938-5646-4929-24ce-08d6ea58a3b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 08:26:14.9699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1282
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA1LzA4LzIwMTkgMDQ6NDMgUE0sIERpbmggTmd1eWVuIHdyb3RlOg0KPiBHZXQgdGhl
IHJlc2V0IGNvbnRyb2wgcHJvcGVydGllcyBmb3IgdGhlIFFTUEkgY29udHJvbGxlciBhbmQgYnJp
bmcgdGhlbQ0KPiBvdXQgb2YgcmVzZXQuIE1vc3Qgd2lsbCBoYXZlIGp1c3Qgb25lIHJlc2V0IGJp
dCwgYnV0IHRoZXJlIGlzIGFuIGFkZGl0aW9uYWwNCj4gT0NQIHJlc2V0IGJpdCB0aGF0IGlzIHVz
ZWQgRUNDLiBUaGUgT0NQIHJlc2V0IGJpdCB3aWxsIGFsc28gbmVlZCB0byBnZXQNCj4gZGUtYXNz
ZXJ0ZWQgYXMgd2VsbC4gWzFdDQo+IA0KDQpJdCdzIGFsd2F5cyBnb29kIHRvIHNheSB3aHkgdGhl
IGNoYW5nZSBpcyBuZWVkZWQsIGUuZy4gcmVzZXQgdGhlIGNvbnRyb2xsZXIgYXQNCmluaXQgdG8g
aGF2ZSBpdCBpbiBhIGNsZWFuIHN0YXRlIGluIGNhc2UgdGhlIGJvb3Rsb2FkZXIgbWVzc2VkIHdp
dGggaXQuDQoNCj4gWzFdIGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3dy91cy9lbi9w
cm9ncmFtbWFibGUvaHBzL2FycmlhLTEwL2hwcy5odG1sI3JlZ19zb2NfdG9wL3NmbzE0Mjk4OTA1
NzU5NTUuaHRtbA0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUaWVuLUZvbmcgQ2hlZSA8dGllbi5mb25n
LmNoZWVAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEaW5oIE5ndXllbiA8ZGluZ3V5ZW5A
a2VybmVsLm9yZz4NCj4gLS0tDQo+IHY0OiBmaXggY29tcGlsZSBlcnJvcg0KPiB2MzogcmV0dXJu
IGZ1bGwgZXJyb3IgYnkgdXNpbmcgUFRSX0VSUihydHNjKQ0KPiAgICAgbW92ZSByZXNldCBjb250
cm9sIGNhbGxzIHVudGlsIGFmdGVyIHRoZSBjbG9jayBlbmFibGVzDQo+ICAgICB1c2UgdWRlbGF5
KDIpIHRvIGJlIHNhZmUNCj4gICAgIEFkZCBvcHRpb25hbCBPQ1AoT3BlbiBDb3JlIFByb3RvY29s
KSByZXNldCBzaWduYWwNCj4gdjI6IHVzZSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFs
X2V4Y2x1c2l2ZQ0KPiAgICAgcHJpbnQgYW4gZXJyb3IgbWVzc2FnZQ0KPiAgICAgcmV0dXJuIC1F
UFJPQkVfREVGRVINCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNw
aS5jIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MzAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y2FkZW5jZS1xdWFkc3BpLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5j
DQo+IGluZGV4IDc5MjYyODc1MGVlYy4uZDM5MDZlNWExZDQ0IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NhZGVuY2UtcXVhZHNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY2FkZW5jZS1xdWFkc3BpLmMNCj4gQEAgLTM0LDYgKzM0LDcgQEANCj4gICNpbmNsdWRl
IDxsaW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZXNldC5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NjaGVkLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvc3BpL3Nw
aS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3RpbWVyLmg+DQo+IEBAIC0xMzM2LDYgKzEzMzcsOCBA
QCBzdGF0aWMgaW50IGNxc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJc3RydWN0IGNxc3BpX3N0ICpjcXNwaTsNCj4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4g
IAlzdHJ1Y3QgcmVzb3VyY2UgKnJlc19haGI7DQo+ICsJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJz
dGM7DQo+ICsJc3RydWN0IHJlc2V0X2NvbnRyb2wgKnJzdGNfb2NwOw0KPiAgCWNvbnN0IHN0cnVj
dCBjcXNwaV9kcml2ZXJfcGxhdGRhdGEgKmRkYXRhOw0KPiAgCWludCByZXQ7DQo+ICAJaW50IGly
cTsNCj4gQEAgLTE0MDIsNiArMTQwNSwzMyBAQCBzdGF0aWMgaW50IGNxc3BpX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJCWdvdG8gcHJvYmVfY2xrX2ZhaWxlZDsNCj4g
IAl9DQo+ICANCj4gKwkvKiBPYnRhaW4gUVNQSSByZXNldCBjb250cm9sICovDQo+ICsJcnN0YyA9
IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRldiwgInFzcGkiKTsN
Cj4gKwlpZiAoSVNfRVJSKHJzdGMpKSB7DQo+ICsJCWRldl9lcnIoZGV2LCAiQ2Fubm90IGdldCBR
U1BJIHJlc2V0LlxuIik7DQo+ICsJCWlmIChQVFJfRVJSKHJzdGMpID09IC1FUFJPQkVfREVGRVIp
DQoNCndoYXQgSSBtZWFudCB3YXMgdG8gZ2V0IHJpZCBvZiB0aGlzIGlmIGFuZCByZXR1cm4gUFRS
X0VSUihyc3RjKSBkaXJlY3RseS4NCg0KPiArCQkJcmV0dXJuIFBUUl9FUlIocnN0Yyk7DQo+ICsJ
fQ0KPiArDQo+ICsJcnN0Y19vY3AgPSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4
Y2x1c2l2ZShkZXYsICJxc3BpLW9jcCIpOw0KPiArCWlmIChJU19FUlIocnN0Y19vY3ApKSB7DQo+
ICsJCWRldl9lcnIoZGV2LCAiQ2Fubm90IGdldCBRU1BJIE9DUCByZXNldC5cbiIpOw0KPiArCQlp
ZiAoUFRSX0VSUihyc3RjX29jcCkgPT0gLUVQUk9CRV9ERUZFUikNCj4gKwkJCXJldHVybiBQVFJf
RVJSKHJzdGNfb2NwKTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAocnN0Yykgez4gKwkJcmVzZXRfY29u
dHJvbF9hc3NlcnQocnN0Yyk7DQo+ICsJCXVkZWxheSgyKTsNCg0Kd2h5IDJ1cz8gd2hhdCdzIHRo
ZSBhcHByb3ByaWF0ZSBsZW5ndGggb2YgdGltZSB0aGF0IHdlIHNob3VsZCB3YWl0IGJldHdlZW4N
CmFzc2VydCBhbmQgZGVhc3NlcnQ/DQoNCj4gKwkJcmVzZXRfY29udHJvbF9kZWFzc2VydChyc3Rj
KTsNCj4gKwl9DQo+ICsNCj4gKwlpZiAocnN0Y19vY3ApIHsNCj4gKwkJcmVzZXRfY29udHJvbF9h
c3NlcnQocnN0Y19vY3ApOw0KDQpEb2VzIGl0IG1hdGVyIHRoZSBvcmRlciBpbiB3aGljaCB5b3Ug
YXNzZXJ0IHRoZXNlIHNpZ25hbHM/IGNhbiB3ZSBncm91cCB0aGVzZQ0KbW9kdWxlIHJlc2V0cyBh
c3NlcnRzLCBpLmUuIGZpcnN0IGRvIHRoZSBhc3NlcnQgZm9yIGJvdGggcnN0YyBhbmQgcnN0Y3Ag
YW5kIHRoZW4NCnRoZSBkZWFzc2VydD8NCg0KPiArCQl1ZGVsYXkoMik7DQo+ICsJCXJlc2V0X2Nv
bnRyb2xfZGVhc3NlcnQocnN0Y19vY3ApOw0KSXMgc29mdHdhcmUgZGVhc3NlcnQgbmVlZGVkPyBJ
J20gbG9va2luZyBhdCBbMl0sIFRhYmxlIDQ2LiBQRVIxIEdyb3VwLCBHZW5lcmF0ZWQNCk1vZHVs
ZSBSZXNldHMsIGFuZCBpdCBzZWVtcyB0aGF0IHNvZnR3YXJlIGRlYXNzZXJ0IGlzIG5vdCBhbiBv
cHRpb24gZm9yDQpxc3BpX2ZsYXNoX2VjY19yc3Rfbg0KDQpbMl1odHRwczovL3d3dy5pbnRlbC5j
b20vY29udGVudC9kYW0vd3d3L3Byb2dyYW1tYWJsZS91cy9lbi9wZGZzL2xpdGVyYXR1cmUvaGIv
YXJyaWEtMTAvYTEwXzV2NC5wZGYNCg0KPiArCX0NCj4gKw0KPiAgCWNxc3BpLT5tYXN0ZXJfcmVm
X2Nsa19oeiA9IGNsa19nZXRfcmF0ZShjcXNwaS0+Y2xrKTsNCj4gIAlkZGF0YSAgPSBvZl9kZXZp
Y2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gIAlpZiAoZGRhdGEgJiYgKGRkYXRhLT5xdWlya3Mg
JiBDUVNQSV9ORUVEU19XUl9ERUxBWSkpDQo+IA0K
