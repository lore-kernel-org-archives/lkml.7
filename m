Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2536C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6300922BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="2oHVYr0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfGYOgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:36:20 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4051 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfGYOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:36:20 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: STe+EqR4tjGsKO3ciSI1tN40a7ghv45PRkZn1j6z+lYUTLJE/9mC3eaSejWH0MATMJ8hHMEjsE
 Kp+ZoiRS6QGlxTMXSnjUVRndvZtqqG2UCjTS+4HhdxviASTvEfK85e0HtVUTuOf2kWPtvf7TFI
 pJneUtzPTZ/tCgpgGSaIC0MKWyidl0fQq0JzPiYO+JW71Nm078v6KWythpCFySSxIoKcrJhcBh
 Ik0GClxTJs9Ol/uT65T/UCM8/kkCQpjXnSNaa213pmUHq7s2vZNrpZQZzT79ycFhtYZtF5K2Aw
 thQ=
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="42759783"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 07:36:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 07:36:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 07:36:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G32GolzXEOQJJCW8CVsH1Q6KBxUD2VqUhsoTWyY9CzNH8vxMZ0VFEe+gFc1DRYkRk8EAju+R27uCPkjKiDZxwLlDZ3KGWBTfnusGwb22azzb3t/VxO0bTE1FkxzNblo5NzgVjb93o46iCVBTmFdoP3MtYKuOOdoH+qnYMh3qVeEyaMIJJ4oSENoqYrHvmucgSkkmbhWGvCoT0I5fzIuHZFUo8dD/LQavp/tIYDj1mjnRxIFktlZMpgDbf6WQoq/Wg1IzpjssKmTHFZdOQb74/8nl6BbGf0sbRtcS6fip1+AbepGiP5tOG7b2uq1PYOJMKKJcALeSwzote5hQ+/0VeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVDg29X+TOMsPl9jT4p6XeudCzr2b9o+A7IclwhEJZs=;
 b=J5z9z3pVKE9oXJ6hufo66qU9akL3zGcW/2tc8xq2wPNiA4U3pvb4OejoMA6yWUlcwmOo2g+9w9E+Ur1202v07XFuyzWUjjk8ltFYqTCDjqUbuq1TZBtNhTpuNurh3fX4I2VT4ewFP0YgMOQ8+ATDw8eEg0x8fRt25sj+Xe7CIzkr8PW8D+1RQfbXbdBtXEHl1N0cUJkYCYzoBEFuuHQo4B0tXt2gEw2xoNgURfb0mkX6OE6EMV5/bjPFHunkX+p8WH45XLJzZTggYTMAJufAdSLT1Yq5AUWelW/0MjJ7eTVCAasL35fLMrcuQ9qxmGcpflzU2NEX9TMXyuBG/wmEZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVDg29X+TOMsPl9jT4p6XeudCzr2b9o+A7IclwhEJZs=;
 b=2oHVYr0aIBHazqSOeI9fERt67F2mgfQhjDMWbbE+qDDe+kQWbhLbdlsscnyOcBnOKYIVxpxanAuZ7UzdT/NgRCzLSbnY/k7NOq8RkPu0HeDh4MCrqnr7piHx3n6/mBgmm8S6i9OeIqc9pF3BvDgU9Ca2sqDnZT9FEXTjeC5FcRY=
Received: from CH2PR11MB4438.namprd11.prod.outlook.com (10.186.149.223) by
 CH2PR11MB4406.namprd11.prod.outlook.com (10.186.148.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 14:36:15 +0000
Received: from CH2PR11MB4438.namprd11.prod.outlook.com
 ([fe80::a9cc:45df:96cb:4b81]) by CH2PR11MB4438.namprd11.prod.outlook.com
 ([fe80::a9cc:45df:96cb:4b81%4]) with mapi id 15.20.2073.017; Thu, 25 Jul 2019
 14:36:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Index: AQHVPtFNjfEG9DN44ESnRp+H/g0b8qbbN92AgAAWBICAAAr8AIAADB2AgAAJ/oA=
Date:   Thu, 25 Jul 2019 14:36:15 +0000
Message-ID: <c914178b-cf81-4be2-044e-67d1ab8aebf7@microchip.com>
References: <20190720080023.5279-1-vigneshr@ti.com>
 <20190720080023.5279-2-vigneshr@ti.com>
 <f6410e21-18c3-9733-4ea5-13eb26ad6169@microchip.com>
 <20190725143745.634efcd6@collabora.com>
 <dbb33973-bb6f-9a01-b821-693387aff98a@microchip.com>
 <20190725160025.2d8e24f8@collabora.com>
In-Reply-To: <20190725160025.2d8e24f8@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0342.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::18) To CH2PR11MB4438.namprd11.prod.outlook.com
 (2603:10b6:610:4a::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7ce33c0-7fa0-478a-3b9b-08d7110d7281
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:CH2PR11MB4406;
x-ms-traffictypediagnostic: CH2PR11MB4406:
x-microsoft-antispam-prvs: <CH2PR11MB4406DDB09C368C44B7B6302BF0C10@CH2PR11MB4406.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(366004)(376002)(136003)(199004)(189003)(3846002)(486006)(6436002)(99286004)(478600001)(25786009)(14444005)(6512007)(305945005)(2616005)(53936002)(6486002)(6116002)(8936002)(66066001)(14454004)(316002)(11346002)(52116002)(7736002)(86362001)(446003)(256004)(26005)(31696002)(102836004)(36756003)(71190400001)(6506007)(5660300002)(76176011)(66556008)(4326008)(68736007)(71200400001)(66946007)(31686004)(66476007)(53546011)(229853002)(386003)(81156014)(54906003)(81166006)(186003)(6246003)(2906002)(8676002)(476003)(66446008)(6916009)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR11MB4406;H:CH2PR11MB4438.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LLrYEtsyadIEI3JqhgoB0L7hmxlnJ9We/zKINDCQGjCiE4W/W38DBABe06uVqYfmeqnOBpdgy0Z8fNDpoqEoKIPYRbHh8f9B5SjV2QmP4sxH3ZPh2GxuFvAYwFyCPCCC9NMENy7V09gAx8qH4r1qEg2eBvK8UNcHsEZC4g1vkeImExFz67Hn/plsWCO85P1aX98vuZHiBfOwt9kWvYTC+5dhAYDBoGSfUhsvanCurwgcYSiqtR6Vej3+W4trKoRGABdQms3O/rBjAkneJi/7uKkpOPkFuNZiRbotWFQl3poaqeok1qYs9oiNamKph+Br1FuoQRSf0f5RiFwwOi+VczFP/e2jtbMA1VgcNKbWDrGYHUCfGRpP7Sc3YsA9FUsRuaQvqt0vk/HZB2u2UweMT/m302ud69A2HxLGL1TgffE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A992AA3DB7E764085110CE1E8E9F327@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ce33c0-7fa0-478a-3b9b-08d7110d7281
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 14:36:15.0824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LzI1LzIwMTkgMDU6MDAgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gVGh1LCAyNSBKdWwgMjAxOSAxMzoxNzowNyArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBIaSwgQm9y
aXMsDQo+Pg0KPj4gT24gMDcvMjUvMjAxOSAwMzozNyBQTSwgQm9yaXMgQnJlemlsbG9uIHdyb3Rl
Og0KPj4+IEV4dGVybmFsIEUtTWFpbA0KPj4+DQo+Pj4NCj4+PiBPbiBUaHUsIDI1IEp1bCAyMDE5
IDExOjE5OjA2ICswMDAwDQo+Pj4gPFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbT4gd3JvdGU6
DQo+Pj4gICANCj4+Pj4+ICsgKi8NCj4+Pj4+ICtzdGF0aWMgaW50IHNwaV9ub3JfZXhlY19vcChz
dHJ1Y3Qgc3BpX25vciAqbm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+Pj4+PiArCQkJICAg
dTY0ICphZGRyLCB2b2lkICpidWYsIHNpemVfdCBsZW4pDQo+Pj4+PiArew0KPj4+Pj4gKwlpbnQg
cmV0Ow0KPj4+Pj4gKwlib29sIHVzZWJvdW5jZWJ1ZiA9IGZhbHNlOyAgICANCj4+Pj4NCj4+Pj4g
SSBkb24ndCB0aGluayB3ZSBuZWVkIGEgYm91bmNlIGJ1ZmZlciBmb3IgcmVncy4gV2hhdCBpcyB0
aGUgbWF4aW11bSBzaXplIHRoYXQgd2UNCj4+Pj4gcmVhZC93cml0ZSByZWdzLCBTUElfTk9SX01B
WF9DTURfU0laRSg4KT8NCj4+Pj4NCj4+Pj4gSW4gc3BpLW5vci5jIHRoZSBtYXhpbXVtIGxlbmd0
aCB0aGF0IHdlIHBhc3MgdG8gbm9yLT5yZWFkX3JlZygpL3dyaXRlX3JlZygpIGlzDQo+Pj4+IFNQ
SV9OT1JfTUFYX0lEX0xFTig2KS4NCj4+Pj4NCj4+Pj4gSSBjYW4gcHJvdmlkZSBhIHBhdGNoIHRv
IGFsd2F5cyB1c2Ugbm9yLT5jbWRfYnVmIHdoZW4gcmVhZGluZy93cml0aW5nIHJlZ3Mgc28NCj4+
Pj4geW91IHJlc3BpbiB0aGUgc2VyaWVzIG9uIHRvcCBvZiBpdCwgaWYgeW91IGZlZWwgdGhlIHNh
bWUuDQo+Pj4+DQo+Pj4+IFdpdGggbm9yLT5jbWRfYnVmIHRoaXMgZnVuY3Rpb24gd2lsbCBiZSBy
ZWR1Y2VkIHRvIHRoZSBmb2xsb3dpbmc6DQo+Pj4+DQo+Pj4+IHN0YXRpYyBpbnQgc3BpX25vcl9z
cGltZW1feGZlcl9yZWcoc3RydWN0IHNwaV9ub3IgKm5vciwgc3RydWN0IHNwaV9tZW1fb3AgKm9w
KQ0KPj4+PiB7DQo+Pj4+IAlpZiAoIW9wIHx8IChvcC0+ZGF0YS5uYnl0ZXMgJiYgIW5vci0+Y21k
X2J1ZikpDQo+Pj4+IAkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4+DQo+Pj4+IAlyZXR1cm4gc3BpX21l
bV9leGVjX29wKG5vci0+c3BpbWVtLCBvcCk7DQo+Pj4+IH0gIA0KPj4+DQo+Pj4gV2VsbCwgSSBk
b24ndCB0aGluayB0aGF0J3MgYSBnb29kIGlkZWEuIC0+Y21kX2J1ZiBpcyBhbiBhcnJheSBpbiB0
aGUNCj4+PiBtaWRkbGUgb2YgdGhlIHNwaV9ub3Igc3RydWN0LCB3aGljaCBtZWFucyBpdCB3b24n
dCBiZSBhbGlnbmVkIG9uIGENCj4+PiBjYWNoZSBsaW5lIGFuZCB5b3UnbGwgaGF2ZSB0byBiZSBl
eHRyYSBjYXJlZnVsIG5vdCB0byB0b3VjaCB0aGUgc3BpX25vcg0KPj4+IGZpZWxkcyB3aGVuIGNh
bGxpbmcgc3BpX21lbV9leGVjX29wKCkuIE1pZ2h0IHdvcmssIGJ1dCBJIHdvdWxkbid0IHRha2UN
Cj4+PiB0aGUgcmlzayBpZiBJIHdlcmUgeW91Lg0KPj4+ICAgDQo+Pg0KPj4gdTggY21kX2J1ZltT
UElfTk9SX01BWF9DTURfU0laRV0gX19fX2NhY2hlbGluZV9hbGlnbmVkOw0KPj4NCj4+IERvZXMg
dGhpcyBoZWxwPw0KPiANCj4gSSBndWVzcyB5b3UnbGwgYWxzbyBuZWVkIG9uZSBvbiB0aGUgZm9s
bG93aW5nIGZpZWxkIHRvIGd1YXJhbnRlZSB0aGF0DQo+IGNtZF9idWYgaXMgY292ZXJpbmcgdGhl
IHdob2xlIGNhY2hlIGxpbmUuIFRCSCwgSSByZWFsbHkgcHJlZmVyIHRoZQ0KPiBvcHRpb24gb2Yg
YWxsb2NhdGluZyAtPmNtZF9idWYuDQoNCmFncmVlZC4NCg0KPiANCj4+DQo+Pj4gQW5vdGhlciBv
cHRpb24gd291bGQgYmUgdG8gYWxsb2NhdGUgLT5jbWRfYnVmIHdpdGgga21hbGxvYygpIGluc3Rl
YWQgb2YNCj4+PiBoYXZpbmcgaXQgZGVmaW5lZCBhcyBhIHN0YXRpYyBhcnJheS4NCj4+PiAgIA0K
Pj4+Pg0KPj4+PiBzcGlfbm9yX2V4ZWNfb3AoKSBhbHdheXMgcmVjZWl2ZWQgYSBOVUxMIGFkZHIs
IGxldCdzIGdldCByaWQgb2YgaXQuIFdlIHdvbid0DQo+Pj4+IG5lZWQgYnVmIGFueW1vcmUgYW5k
IHlvdSBjYW4gcmV0cmlldmUgdGhlIGxlbmd0aCBmcm9tIG9wLT5kYXRhLm5ieXRlcy4gTm93IHRo
YXQNCj4+Pj4gd2UgdHJpbW1lZCB0aGUgYXJndW1lbnRzLCBJIHRoaW5rIEkgd291bGQgZ2V0IHJp
ZCBvZiB0aGUNCj4+Pj4gc3BpX25vcl9kYXRhL25vZGF0YV9vcCgpIHdyYXBwZXJzIGFuZCB1c2Ug
c3BpX25vcl9zcGltZW1feGZlcl9yZWcoKSBkaXJlY3RseS4gIA0KPj4+DQo+Pj4gSSB0aGluayBJ
IGFkZGVkIHRoZSBhZGRyIHBhcmFtIGZvciBhIGdvb2QgcmVhc29uIChwcm9iYWJseSB0byBzdXBw
b3J0DQo+Pj4gT2N0byBtb2RlIGNtZHMgdGhhdCB0YWtlIGFuIGFkZHJlc3MgcGFyYW1ldGVyKS4g
VGhpcyBiZWluZyBzYWlkLCBJDQo+Pj4gYWdyZWUgd2l0aCB5b3UsIHdlIHNob3VsZCBqdXN0IHBh
c3MgZXZlcnl0aGluZyB0aHJvdWdoIHRoZSBvcCBwYXJhbWV0ZXINCj4+PiAoaW5jbHVkaW5nIHRo
ZSBhZGRyZXNzIGlmIHdlIGV2ZXIgbmVlZCB0byBhZGQgb25lKS4NCj4+Pg0KPj4+ICAgDQo+Pj4+
PiArDQo+Pj4+PiArLyoqDQo+Pj4+PiArICogc3BpX25vcl9zcGltZW1feGZlcl9kYXRhKCkgLSBo
ZWxwZXIgZnVuY3Rpb24gdG8gcmVhZC93cml0ZSBkYXRhIHRvDQo+Pj4+PiArICogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBmbGFzaCdzIG1lbW9yeSByZWdpb24NCj4+Pj4+ICsgKiBAbm9y
OiAgICAgICAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InDQo+Pj4+PiArICogQG9wOiAgICAg
ICAgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbWVtX29wJyB0ZW1wbGF0ZSBmb3IgdHJhbnNmZXIN
Cj4+Pj4+ICsgKiBAcHJvdG86ICAgICAgcHJvdG9jb2wgdG8gYmUgdXNlZCBmb3IgdHJhbnNmZXIN
Cj4+Pj4+ICsgKg0KPj4+Pj4gKyAqIFJldHVybjogbnVtYmVyIG9mIGJ5dGVzIHRyYW5zZmVycmVk
IG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+Pj4+ICsgKi8NCj4+Pj4+ICtzdGF0aWMg
c3NpemVfdCBzcGlfbm9yX3NwaW1lbV94ZmVyX2RhdGEoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4+
Pj4+ICsJCQkJCXN0cnVjdCBzcGlfbWVtX29wICpvcCwNCj4+Pj4+ICsJCQkJCWVudW0gc3BpX25v
cl9wcm90b2NvbCBwcm90bykNCj4+Pj4+ICt7DQo+Pj4+PiArCWJvb2wgdXNlYm91bmNlYnVmID0g
ZmFsc2U7ICAgIA0KPj4+Pg0KPj4+PiBkZWNsYXJlIGJvb2wgYXQgdGhlIGVuZCB0byBhdm9pZCBz
dGFjayBwYWRkaW5nLiAgDQo+Pj4NCj4+PiBCdXQgaXQgYnJlYWtzIHRoZSByZXZlcnNlLXhtYXMt
dHJlZSBmb3JtYXR0aW5nIDotKS4NCj4+PiAgIA0KPj4+PiAgDQo+Pj4+PiArCXZvaWQgKnJkYnVm
ID0gTlVMTDsNCj4+Pj4+ICsJY29uc3Qgdm9pZCAqYnVmOyAgICANCj4+Pj4NCj4+Pj4geW91IGNh
biBnZXQgcmlkIG9mIHJkYnVmIGFuZCBidWYgaWYgeW91IHBhc3MgYnVmIGFzIGFyZ3VtZW50LiAg
DQo+Pj4NCj4+PiBIbSwgcGFzc2luZyB0aGUgYnVmZmVyIHRvIHNlbmQgZGF0YSBmcm9tL3JlY2Vp
dmUgZGF0YSBpbnRvIGlzIGFscmVhZHkNCj4+PiBwYXJ0IG9mIHRoZSBzcGlfbWVtX29wIGRlZmlu
aXRpb24gcHJvY2VzcyAod2hpY2ggaXMgZG9uZSBpbiB0aGUgY2FsbGVyDQo+Pj4gb2YgdGhpcyBm
dW5jKSBzbyB3aHkgYm90aGVyIHBhc3NpbmcgYW4gZXh0cmEgYXJnIHRvIHRoZSBmdW5jdGlvbi4N
Cj4+PiBOb3RlIHRoYXQgeW91IGhhZCB0aGUgZXhhY3Qgb3Bwb3NpdGUgYXJndW1lbnQgZm9yIHRo
ZQ0KPj4+IHNwaV9ub3Jfc3BpbWVtX3hmZXJfcmVnKCkgcHJvdG90eXBlIHlvdSBzdWdnZXN0ZWQg
YWJvdmUgKHdoaWNoIEkNCj4+PiBhZ3JlZSB3aXRoIEJUVykgOlAuICANCj4+DQo+PiBJbiBvcmRl
ciB0byBhdm9pZCBpZiBjbGF1c2VzIGxpa2UgImlmIChvcC0+ZGF0YS5kaXIgPT0gU1BJX01FTV9E
QVRBX0lOKSIuIFlvdQ0KPj4gY2FuJ3QgdXNlIG9wLT5kYXRhLmJ1ZiBkaXJlY3RseSwgdGhlICpv
dXQgY29uc3QgcXVhbGlmaWVyIGNhbiBiZSBkaXNjYXJkZWQuDQo+IA0KPiBOb3QgZW50aXJlbHkg
c3VyZSB3aHkgeW91IHRoaW5rIHRoaXMgaXMgaW1wb3J0YW50IHRvIGF2b2lkIHRoYXQNCj4gdGVz
dCAobG9va3MgbGlrZSBhIG1pY3JvLW9wdGltaXphdGlvbiB0byBtZSksIGJ1dCBpZiB5b3UgcmVh
bGx5IHdhbnQgdG8NCj4gaGF2ZSBhIG5vbi1jb25zdCBidWZmZXIsIGp1c3QgdXNlIHRoZSBvbmUg
cG9pbnRlZCBieSBvcC0+ZGF0YS5idWYuaW4NCj4gKGJ1ZiBpcyBhIHVuaW9uIHNvIGJvdGggaW4g
YW5kIG91dCBwb2ludCB0byB0aGUgc2FtZSB0aGluZykuIE5vdGUgdGhhdA0KPiB3ZSdkIG5lZWQg
YSBjb21tZW50IGV4cGxhaW5pbmcgd2h5IHRoaXMgaXMgc2FmZSB0byBkbyB0aGF0LCBiZWNhdXNl
DQo+IGJ5cGFzc2luZyBjb25zdG5lc3MgY29uc3RyYWludHMgaXMgdXN1YWxseSBhIGJhZCB0aGlu
Zy4NCg0KTm8gbmVlZCBmb3IgYSBidWYgYXJndW1lbnQsIEkgbWlzc2VkIHRoYXQgdGhlIGNvbnN0
IHF1YWxpZmllciB3aWxsIGJlIGRpc2NhcmRlZA0Kd2hlbiBwYXNzaW5nIHRoZSBwb2ludGVyLiBX
ZSdsbCBrZWVwIHRoZSBmdW5jdGlvbiBhcyBpdCBpcywgd2l0aCB0aGUgYW1lbmQgdGhhdA0KdGhl
ICJlbnVtIHNwaV9ub3JfcHJvdG9jb2wgcHJvdG8iIHdpbGwgYmUgcmVtb3ZlZCBmcm9tIHRoZSBh
cmd1bWVudHMuDQoNClRoYW5rcyBmb3IganVtcGluZyBpbiwNCnRhDQo=
