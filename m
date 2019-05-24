Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86213C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4071E20675
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="hF0drGG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389458AbfEXIZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:25:10 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61966 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbfEXIZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:25:10 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Christian.Gromm@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Christian.Gromm@microchip.com";
  x-sender="Christian.Gromm@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Christian.Gromm@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Christian.Gromm@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
X-IronPort-AV: E=Sophos;i="5.60,506,1549954800"; 
   d="scan'208";a="31717829"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 24 May 2019 01:25:08 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 24 May 2019 01:24:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=910sBUMNOeiRYrEi/8qul1gdfUYT1LJTpz1JjvM3BcI=;
 b=hF0drGG2JPYFYOyQFMJhtw3DvSXNCP7Rs858631LDdE2DZZK+NIBMDIf8JXHnqKRvhdaUP5JuNTeuA1MkR7nV1BG4m5QNcPSa4Z1/Yd1jFHtj5XsseyqTXIDlF1y+gPSQD53fiFk9+DNfSITLD3IURlODesb9s2PxdzEgaMyRTE=
Received: from DM6PR11MB3705.namprd11.prod.outlook.com (20.178.231.155) by
 DM6PR11MB4138.namprd11.prod.outlook.com (20.176.126.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Fri, 24 May 2019 08:03:26 +0000
Received: from DM6PR11MB3705.namprd11.prod.outlook.com
 ([fe80::489a:6dfb:8f5a:4e32]) by DM6PR11MB3705.namprd11.prod.outlook.com
 ([fe80::489a:6dfb:8f5a:4e32%2]) with mapi id 15.20.1922.018; Fri, 24 May 2019
 08:03:26 +0000
From:   <Christian.Gromm@microchip.com>
To:     <gregkh@linuxfoundation.org>, <nishkadg.linux@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: most: usb: Remove variable frame_size
Thread-Topic: [PATCH] staging: most: usb: Remove variable frame_size
Thread-Index: AQHVEWru4bAmJ43IiUKRHTPXdpRoOqZ47NSAgAD/r4A=
Date:   Fri, 24 May 2019 08:03:26 +0000
Message-ID: <1558685225.16425.13.camel@microchip.com>
References: <20190523132334.29611-1-nishkadg.linux@gmail.com>
         <20190523165157.GA19908@kroah.com>
In-Reply-To: <20190523165157.GA19908@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.154.213.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db1ed035-ca1d-4b94-1360-08d6e01e4cfc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM6PR11MB4138;
x-ms-traffictypediagnostic: DM6PR11MB4138:
x-microsoft-antispam-prvs: <DM6PR11MB41386FC18B8B9550E96EB0B2F8020@DM6PR11MB4138.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(66556008)(6486002)(2906002)(86362001)(229853002)(6116002)(71200400001)(71190400001)(3846002)(6436002)(14454004)(256004)(103116003)(2501003)(66066001)(64756008)(66446008)(91956017)(14444005)(36756003)(478600001)(73956011)(76116006)(66946007)(316002)(72206003)(54906003)(8676002)(446003)(99286004)(11346002)(2616005)(476003)(486006)(6512007)(68736007)(102836004)(6506007)(66476007)(76176011)(110136005)(4326008)(25786009)(5660300002)(26005)(186003)(305945005)(6246003)(8936002)(53936002)(7736002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4138;H:DM6PR11MB3705.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5wqA1aKxo/gHCNzPjEM3+Icw+/AmkzFik94Y87QWgVCZryW6MYy/E7bbizPSkACUomE/QESgRta0yOw/FXoSNRUFvXIvpuUidke6Tzfhzw7UXIzFBvqoYAWVzjqY3Pd7IaJVU5n+aRmEERDRpvpnd5iMonJvx9225dGcm1hHoG3T43k/DRseXf2Futy86nf+11A99Fyxy791gcbUTc3b+Ng5RZo7Vq0VAoE4GWn80qniLfnMc87atwn9bgTDKObpp+RwT8UfsRiqbxXgggL7DRpOs4sRAclD48JV9qbkxFX86NpbYJ5fNCU7J5uxWTl8k6tnoyzGmOuaIPQARg1FhnJkBSlR255GiS83ZzHv3qO/Q9Z41e2iAIHPFnD3Q7bIXKYkSps7InOjuuuZSQZiy4qPrZ+Gqc9HzMxFAoxoR9g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <79D1F5B6A03DE34491133BA6CD2C2C74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db1ed035-ca1d-4b94-1360-08d6e01e4cfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 08:03:26.3873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: christian.gromm@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4138
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRG8sIDIwMTktMDUtMjMgYXQgMTg6NTEgKzAyMDAsIEdyZWcgS0ggd3JvdGU6DQo+IEV4dGVy
bmFsIEUtTWFpbA0KPiANCj4gDQo+IE9uIFRodSwgTWF5IDIzLCAyMDE5IGF0IDA2OjUzOjM0UE0g
KzA1MzAsIE5pc2hrYSBEYXNndXB0YSB3cm90ZToNCj4gPiANCj4gPiBSZW1vdmUgdmFyaWFibGUg
ZnJhbWVfc2l6ZSBhcyBpdHMgbXVsdGlwbGUgdXNhZ2VzIGFyZSBhbGwNCj4gPiBpbmRlcGVuZGVu
dCBvZg0KPiA+IGVhY2ggb3RoZXIgYW5kIHNvIGNhbiBiZSByZXR1cm5lZCBzZXBhcmF0ZWx5Lg0K
PiA+IElzc3VlIGZvdW5kIHdpdGggQ29jY2luZWxsZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBOaXNoa2EgRGFzZ3VwdGEgPG5pc2hrYWRnLmxpbnV4QGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4g
PiDCoGRyaXZlcnMvc3RhZ2luZy9tb3N0L3VzYi91c2IuYyB8IDE2ICsrKysrKy0tLS0tLS0tLS0N
Cj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvbW9zdC91c2IvdXNiLmMNCj4g
PiBiL2RyaXZlcnMvc3RhZ2luZy9tb3N0L3VzYi91c2IuYw0KPiA+IGluZGV4IDM2MGNiNWI3YTEw
Yi4uNzUxZTgyY2Y2NmM1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9tb3N0L3Vz
Yi91c2IuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9tb3N0L3VzYi91c2IuYw0KPiA+IEBA
IC0xODYsMzIgKzE4NiwyOCBAQCBzdGF0aWMgaW5saW5lIGludCBzdGFydF9zeW5jX2VwKHN0cnVj
dA0KPiA+IHVzYl9kZXZpY2UgKnVzYl9kZXYsIHUxNiBlcCkNCj4gPiDCoCAqLw0KPiA+IMKgc3Rh
dGljIHVuc2lnbmVkIGludCBnZXRfc3RyZWFtX2ZyYW1lX3NpemUoc3RydWN0DQo+ID4gbW9zdF9j
aGFubmVsX2NvbmZpZyAqY2ZnKQ0KPiA+IMKgew0KPiA+IC0JdW5zaWduZWQgaW50IGZyYW1lX3Np
emUgPSAwOw0KPiA+IMKgCXVuc2lnbmVkIGludCBzdWJfc2l6ZSA9IGNmZy0+c3ViYnVmZmVyX3Np
emU7DQo+ID4gwqANCj4gPiDCoAlpZiAoIXN1Yl9zaXplKSB7DQo+ID4gwqAJCXByX3dhcm4oIk1p
c2NvbmZpZzogU3ViYnVmZmVyIHNpemUgemVyby5cbiIpOw0KPiA+IC0JCXJldHVybiBmcmFtZV9z
aXplOw0KPiA+ICsJCXJldHVybiAwOw0KPiA+IMKgCX0NCj4gPiDCoAlzd2l0Y2ggKGNmZy0+ZGF0
YV90eXBlKSB7DQo+ID4gwqAJY2FzZSBNT1NUX0NIX0lTT0M6DQo+ID4gLQkJZnJhbWVfc2l6ZSA9
IEFWX1BBQ0tFVFNfUEVSX1hBQ1QgKiBzdWJfc2l6ZTsNCj4gPiAtCQlicmVhazsNCj4gPiArCQly
ZXR1cm4gQVZfUEFDS0VUU19QRVJfWEFDVCAqIHN1Yl9zaXplOw0KPiA+IMKgCWNhc2UgTU9TVF9D
SF9TWU5DOg0KPiA+IMKgCQlpZiAoY2ZnLT5wYWNrZXRzX3Blcl94YWN0ID09IDApIHsNCj4gPiDC
oAkJCXByX3dhcm4oIk1pc2NvbmZpZzogUGFja2V0cyBwZXIgWEFDVA0KPiA+IHplcm9cbiIpOw0K
PiA+IC0JCQlmcmFtZV9zaXplID0gMDsNCj4gPiArCQkJcmV0dXJuIDA7DQo+ID4gwqAJCX0gZWxz
ZSBpZiAoY2ZnLT5wYWNrZXRzX3Blcl94YWN0ID09IDB4RkYpIHsNCj4gPiAtCQkJZnJhbWVfc2l6
ZSA9IChVU0JfTVRVIC8gc3ViX3NpemUpICoNCj4gPiBzdWJfc2l6ZTsNCj4gPiArCQkJcmV0dXJu
IChVU0JfTVRVIC8gc3ViX3NpemUpICogc3ViX3NpemU7DQo+ID4gwqAJCX0gZWxzZSB7DQo+ID4g
LQkJCWZyYW1lX3NpemUgPSBjZmctPnBhY2tldHNfcGVyX3hhY3QgKg0KPiA+IHN1Yl9zaXplOw0K
PiA+ICsJCQlyZXR1cm4gY2ZnLT5wYWNrZXRzX3Blcl94YWN0ICogc3ViX3NpemU7DQo+ID4gwqAJ
CX0NCj4gPiAtCQlicmVhazsNCj4gPiDCoAlkZWZhdWx0Og0KPiA+IMKgCQlwcl93YXJuKCJRdWVy
eSBmcmFtZSBzaXplIG9mIG5vbi1zdHJlYW1pbmcNCj4gPiBjaGFubmVsXG4iKTsNCj4gPiAtCQli
cmVhazsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiDCoAl9DQo+ID4gLQlyZXR1cm4gZnJhbWVfc2l6
ZTsNCj4gPiDCoH0NCj4gTm93IGl0IGp1c3QgZmVlbHMgbGlrZSB5b3UgYXJlIGRvaW5nICJidXN5
IHdvcmsiIDooDQo+IA0KPiBmcmFtZV9zaXplIG1ha2VzIHNlbnNlIGhlcmUsIHJpZ2h0P8KgwqBX
aHkgY2hhbmdlIHRoaXMgY29kZT8NCj4gDQo+IFJlbWVtYmVyLCBjb2RlIGlzIHdyaXR0ZW4gZm9y
IGRldmVsb3BlcnMgZmlyc3QsIHRoZSBjb21waWxlciBzZWNvbmQuDQo+IFJlYWRpbmcgdGhpcyB3
aXRoIGZyYW1lX3NpemUgbWFrZXMgaXQgbXVjaCBtb3JlIG9idmlvdXMgd2hhdCB0aGlzDQo+IGNv
ZGUNCj4gZG9lcyB3aGVuIHlvdSByZWFkIGl0IGFnYWluIGluIDUtMTAgeWVhcnMuwqDCoFdoeSBj
aGFuZ2UgdGhpcywgeW91IGhhdmUNCj4gbm90IG1hZGUgaXQgZmFzdGVyLCBvciBzbWFsbGVyIGF0
IGFsbC4NCj4gDQo+IFNvIG5vLCBJIHdvdWxkIG5vdCBhY2NlcHQgdGhpcywgc29ycnkuDQoNCkkg
aGF2ZW4ndCBzZWVuIHRoaXMgb24gdGltZS4gU28gcGxlYXNlIGlnbm9yZSBteSBhY2tub3dsZWRn
ZSBJJ3ZlIHNlbnQuDQpHb29kIHRvIGtub3cgdGhhdCB5b3UgZmF2b3IgcmVhZGFiaWxpdHkgb3Zl
ciBjb21wYWN0bmVzcy4NCg0KU29ycnkgZm9yIHRoZSBub2lzZSwNCkNocmlzDQoNCj4gDQo+IFdl
IGhhdmUgc28gbWFueSBfcmVhbF8gdGhpbmdzIHRvIGRvIGluIHRoZSBkcml2ZXJzL3N0YWdpbmcv
IGRpcmVjdG9yeQ0KPiBpZg0KPiB5b3UgYXJlIGxvb2tpbmcgZm9yIHN0dWZmIHRvIGNsZWFuIHVw
LsKgwqBEb24ndCB0cnkgdG8gbWljcm8tb3B0aW1pemUNCj4gdGhpbmdzIHRoYXQgZG8gbm90IG1h
dHRlciBhdCB0aGUgZXhwZW5zZSBvZiB1bmRlcnN0YW5kaW5nLg0KPiANCj4gdGhhbmtzLA0KPiAN
Cj4gZ3JlZyBrLWgNCj4g
