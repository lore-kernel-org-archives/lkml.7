Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF99AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779892238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="B+P558ps"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbfGYNRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:17:24 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:55110 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGYNRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:17:21 -0400
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
IronPort-SDR: plo3Lj8MazJ4guJ4NFcRGKBp4+rYb7FQA68/v4oA5hn4Km4/Dmvwvwy+ixmpuNg5PwUsgWjnS2
 USihOoj92JRhmygI6UloQSdJUAA4wvZKY6It7BOyvdYbZHK5FmzPQwjKaprq18DnBEmQV8YvLM
 gPzIOctSitVIFYlu4Dvs3SIw5XSBght3HPt5rQnd2slHoJ7zRYTNDErmtjzVRWOIw8VWz//Wod
 UCF4x06fq9YNm+pXP4/yf4+kpXAZK0DMhTjpO/cdCwJOUzN6H8GfDOPEefOOwKuYC89zwzpeOd
 wI4=
X-IronPort-AV: E=Sophos;i="5.64,306,1559545200"; 
   d="scan'208";a="44117967"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 06:17:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 06:17:11 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 25 Jul 2019 06:17:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhcFHCxof1dYAEFIL5YEDOUCMjEPpLWibrc7nj34i+n6AzOY7xuyE1Gspp61mGkI2GEVemRdw1z775HW2Fg3+j7kAXZGQt0zCZgUIc7PqdfX3/iTn9mFJm8kcjGHotdLS6BWEjtz7vB+YlTRRqzFGI6HKmOiGGA2gXA2b+ih4FxfqixseI0sSGdCASebGp4NvNz29LrhEf5OQnj6xUzzOvbiI4U8/lTONTwSAtyCO+/Q9XUqV5X2FTSzn7mKJIPwL9dXiK5RUuj9xOBourL0jgiKaxgRsxi81FHbzk1Ry+SFpSLAE3EeZ+j3MJzr/ybZeZ6VuyOHQTk3jx2S0XwcGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ePatnRnuOgsVTPfbzNLFcZ66DrMF4D7r5ahieMaY6c=;
 b=R6rlJYbb/0cA+UgNO84BRkLnOSEi6kMzzBLRnndlaaRrZznIEJ1jIvTeEp85xieKGK/uTld+xrqM7hjUJTc54ZwS74J0Lwg6i9tfrHswYiOw65LyHym9d4YR/QPvHYhpE6IZULnQI5HucPrSwTQu/f8ct1NpsKGpd7+OCCOPKTVQaceeYFgMHMmuHYSCMvObrUXZS/TgeFLDuC/Ju9x8rmOzZcIl211El1fIRP/t67CLBCybcgrTje0cADrz5sNRzIPOol/IgYdLG3jhNmObSR2ojpzwPfHGoQLiwCRSFCXolDbBjGbTBCi/QLVKbx5eMtVnrziEo1lbk/8SXT6Pow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ePatnRnuOgsVTPfbzNLFcZ66DrMF4D7r5ahieMaY6c=;
 b=B+P558psmzuncmf+B6OVz77D7XN+USO3ZteQl14SKd/0RGnCFLCYHwyamcHF3uAUyjmaS5PxACajWZnDCJvG0yrWygwqbJLhaxAfhdQSpfH4RqyT3D+ogif7nQJlQm2xopjFXAPyoNcKYfIcYAEKGiQpjbdq2nw2nBeVBOZr+nc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1859.namprd11.prod.outlook.com (10.175.100.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Thu, 25 Jul 2019 13:17:07 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::3161:92ff:d26c:8b66]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::3161:92ff:d26c:8b66%7]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 13:17:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>, <bbrezillon@kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Index: AQHVPtFNjfEG9DN44ESnRp+H/g0b8qbbN92AgAAWBICAAAr8AA==
Date:   Thu, 25 Jul 2019 13:17:07 +0000
Message-ID: <dbb33973-bb6f-9a01-b821-693387aff98a@microchip.com>
References: <20190720080023.5279-1-vigneshr@ti.com>
 <20190720080023.5279-2-vigneshr@ti.com>
 <f6410e21-18c3-9733-4ea5-13eb26ad6169@microchip.com>
 <20190725143745.634efcd6@collabora.com>
In-Reply-To: <20190725143745.634efcd6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0801CA0083.eurprd08.prod.outlook.com
 (2603:10a6:800:7d::27) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f647d79f-793f-4132-7a58-08d71102648f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1859;
x-ms-traffictypediagnostic: BN6PR11MB1859:
x-microsoft-antispam-prvs: <BN6PR11MB18590558889801CE20041B8AF0C10@BN6PR11MB1859.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(7736002)(81156014)(86362001)(256004)(5660300002)(25786009)(316002)(305945005)(53936002)(14454004)(8676002)(11346002)(6512007)(31686004)(68736007)(71200400001)(71190400001)(14444005)(66446008)(8936002)(81166006)(6486002)(2616005)(446003)(6436002)(99286004)(36756003)(6246003)(476003)(186003)(6116002)(486006)(4326008)(3846002)(53546011)(6916009)(229853002)(26005)(66066001)(6506007)(386003)(64756008)(66556008)(54906003)(2906002)(52116002)(76176011)(66476007)(31696002)(478600001)(102836004)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1859;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5AkjtPV/nh0XigMxVj+zVFnZzf+xDH/SbVIOY2aFv//79frrYDp9IiaqArlvoaacwwudts8jcDyzlpwZU2qBEN6drTRdDx7W5wDbLlfQC2JM8jUC4d2sPZc96acolLwqTB/Sl2asHevmFxajLuOZG/cEN6OdKwmfKMgh9uC7kh5x+1yWFVXKJNc1lBLdIMVRkQLbyj0rSNrJlB6v/nk4+dAZCo6DD/gxZEXEiQ5wp9QKfGCJKbJRCZVk0aW4FPP6fRl0YsbYaC8QdA3HvrYUWSGElJMiqF5IdhHrQmKjl3qMDMxx2SLBaqu0ohmnEZO+glbG9oOS9SutQ4ZrHyX7rxuRGDK2wCRQyNBS46GQWj5TaxlQrliB3vml4GCEtE+d9/C6GnGIXuisr3nl5RCwGaJ/DEwGE2VlPOtwxU+xtdg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34675E6787204C46BA007C05FBD382FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f647d79f-793f-4132-7a58-08d71102648f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 13:17:07.4594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1859
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJvcmlzLA0KDQpPbiAwNy8yNS8yMDE5IDAzOjM3IFBNLCBCb3JpcyBCcmV6aWxsb24gd3Jv
dGU6DQo+IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IE9uIFRodSwgMjUgSnVsIDIwMTkgMTE6
MTk6MDYgKzAwMDANCj4gPFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+IA0K
Pj4+ICsgKi8NCj4+PiArc3RhdGljIGludCBzcGlfbm9yX2V4ZWNfb3Aoc3RydWN0IHNwaV9ub3Ig
Km5vciwgc3RydWN0IHNwaV9tZW1fb3AgKm9wLA0KPj4+ICsJCQkgICB1NjQgKmFkZHIsIHZvaWQg
KmJ1Ziwgc2l6ZV90IGxlbikNCj4+PiArew0KPj4+ICsJaW50IHJldDsNCj4+PiArCWJvb2wgdXNl
Ym91bmNlYnVmID0gZmFsc2U7ICANCj4+DQo+PiBJIGRvbid0IHRoaW5rIHdlIG5lZWQgYSBib3Vu
Y2UgYnVmZmVyIGZvciByZWdzLiBXaGF0IGlzIHRoZSBtYXhpbXVtIHNpemUgdGhhdCB3ZQ0KPj4g
cmVhZC93cml0ZSByZWdzLCBTUElfTk9SX01BWF9DTURfU0laRSg4KT8NCj4+DQo+PiBJbiBzcGkt
bm9yLmMgdGhlIG1heGltdW0gbGVuZ3RoIHRoYXQgd2UgcGFzcyB0byBub3ItPnJlYWRfcmVnKCkv
d3JpdGVfcmVnKCkgaXMNCj4+IFNQSV9OT1JfTUFYX0lEX0xFTig2KS4NCj4+DQo+PiBJIGNhbiBw
cm92aWRlIGEgcGF0Y2ggdG8gYWx3YXlzIHVzZSBub3ItPmNtZF9idWYgd2hlbiByZWFkaW5nL3dy
aXRpbmcgcmVncyBzbw0KPj4geW91IHJlc3BpbiB0aGUgc2VyaWVzIG9uIHRvcCBvZiBpdCwgaWYg
eW91IGZlZWwgdGhlIHNhbWUuDQo+Pg0KPj4gV2l0aCBub3ItPmNtZF9idWYgdGhpcyBmdW5jdGlv
biB3aWxsIGJlIHJlZHVjZWQgdG8gdGhlIGZvbGxvd2luZzoNCj4+DQo+PiBzdGF0aWMgaW50IHNw
aV9ub3Jfc3BpbWVtX3hmZXJfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHN0cnVjdCBzcGlfbWVt
X29wICpvcCkNCj4+IHsNCj4+IAlpZiAoIW9wIHx8IChvcC0+ZGF0YS5uYnl0ZXMgJiYgIW5vci0+
Y21kX2J1ZikpDQo+PiAJCXJldHVybiAtRUlOVkFMOw0KPj4NCj4+IAlyZXR1cm4gc3BpX21lbV9l
eGVjX29wKG5vci0+c3BpbWVtLCBvcCk7DQo+PiB9DQo+IA0KPiBXZWxsLCBJIGRvbid0IHRoaW5r
IHRoYXQncyBhIGdvb2QgaWRlYS4gLT5jbWRfYnVmIGlzIGFuIGFycmF5IGluIHRoZQ0KPiBtaWRk
bGUgb2YgdGhlIHNwaV9ub3Igc3RydWN0LCB3aGljaCBtZWFucyBpdCB3b24ndCBiZSBhbGlnbmVk
IG9uIGENCj4gY2FjaGUgbGluZSBhbmQgeW91J2xsIGhhdmUgdG8gYmUgZXh0cmEgY2FyZWZ1bCBu
b3QgdG8gdG91Y2ggdGhlIHNwaV9ub3INCj4gZmllbGRzIHdoZW4gY2FsbGluZyBzcGlfbWVtX2V4
ZWNfb3AoKS4gTWlnaHQgd29yaywgYnV0IEkgd291bGRuJ3QgdGFrZQ0KPiB0aGUgcmlzayBpZiBJ
IHdlcmUgeW91Lg0KPiANCg0KdTggY21kX2J1ZltTUElfTk9SX01BWF9DTURfU0laRV0gX19fX2Nh
Y2hlbGluZV9hbGlnbmVkOw0KDQpEb2VzIHRoaXMgaGVscD8NCg0KPiBBbm90aGVyIG9wdGlvbiB3
b3VsZCBiZSB0byBhbGxvY2F0ZSAtPmNtZF9idWYgd2l0aCBrbWFsbG9jKCkgaW5zdGVhZCBvZg0K
PiBoYXZpbmcgaXQgZGVmaW5lZCBhcyBhIHN0YXRpYyBhcnJheS4NCj4gDQo+Pg0KPj4gc3BpX25v
cl9leGVjX29wKCkgYWx3YXlzIHJlY2VpdmVkIGEgTlVMTCBhZGRyLCBsZXQncyBnZXQgcmlkIG9m
IGl0LiBXZSB3b24ndA0KPj4gbmVlZCBidWYgYW55bW9yZSBhbmQgeW91IGNhbiByZXRyaWV2ZSB0
aGUgbGVuZ3RoIGZyb20gb3AtPmRhdGEubmJ5dGVzLiBOb3cgdGhhdA0KPj4gd2UgdHJpbW1lZCB0
aGUgYXJndW1lbnRzLCBJIHRoaW5rIEkgd291bGQgZ2V0IHJpZCBvZiB0aGUNCj4+IHNwaV9ub3Jf
ZGF0YS9ub2RhdGFfb3AoKSB3cmFwcGVycyBhbmQgdXNlIHNwaV9ub3Jfc3BpbWVtX3hmZXJfcmVn
KCkgZGlyZWN0bHkuDQo+IA0KPiBJIHRoaW5rIEkgYWRkZWQgdGhlIGFkZHIgcGFyYW0gZm9yIGEg
Z29vZCByZWFzb24gKHByb2JhYmx5IHRvIHN1cHBvcnQNCj4gT2N0byBtb2RlIGNtZHMgdGhhdCB0
YWtlIGFuIGFkZHJlc3MgcGFyYW1ldGVyKS4gVGhpcyBiZWluZyBzYWlkLCBJDQo+IGFncmVlIHdp
dGggeW91LCB3ZSBzaG91bGQganVzdCBwYXNzIGV2ZXJ5dGhpbmcgdGhyb3VnaCB0aGUgb3AgcGFy
YW1ldGVyDQo+IChpbmNsdWRpbmcgdGhlIGFkZHJlc3MgaWYgd2UgZXZlciBuZWVkIHRvIGFkZCBv
bmUpLg0KPiANCj4gDQo+Pj4gKw0KPj4+ICsvKioNCj4+PiArICogc3BpX25vcl9zcGltZW1feGZl
cl9kYXRhKCkgLSBoZWxwZXIgZnVuY3Rpb24gdG8gcmVhZC93cml0ZSBkYXRhIHRvDQo+Pj4gKyAq
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmxhc2gncyBtZW1vcnkgcmVnaW9uDQo+Pj4g
KyAqIEBub3I6ICAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicNCj4+PiArICogQG9w
OiAgICAgICAgIHBvaW50ZXIgdG8gJ3N0cnVjdCBzcGlfbWVtX29wJyB0ZW1wbGF0ZSBmb3IgdHJh
bnNmZXINCj4+PiArICogQHByb3RvOiAgICAgIHByb3RvY29sIHRvIGJlIHVzZWQgZm9yIHRyYW5z
ZmVyDQo+Pj4gKyAqDQo+Pj4gKyAqIFJldHVybjogbnVtYmVyIG9mIGJ5dGVzIHRyYW5zZmVycmVk
IG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndpc2UNCj4+PiArICovDQo+Pj4gK3N0YXRpYyBzc2l6
ZV90IHNwaV9ub3Jfc3BpbWVtX3hmZXJfZGF0YShzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4+ICsJ
CQkJCXN0cnVjdCBzcGlfbWVtX29wICpvcCwNCj4+PiArCQkJCQllbnVtIHNwaV9ub3JfcHJvdG9j
b2wgcHJvdG8pDQo+Pj4gK3sNCj4+PiArCWJvb2wgdXNlYm91bmNlYnVmID0gZmFsc2U7ICANCj4+
DQo+PiBkZWNsYXJlIGJvb2wgYXQgdGhlIGVuZCB0byBhdm9pZCBzdGFjayBwYWRkaW5nLg0KPiAN
Cj4gQnV0IGl0IGJyZWFrcyB0aGUgcmV2ZXJzZS14bWFzLXRyZWUgZm9ybWF0dGluZyA6LSkuDQo+
IA0KPj4NCj4+PiArCXZvaWQgKnJkYnVmID0gTlVMTDsNCj4+PiArCWNvbnN0IHZvaWQgKmJ1Zjsg
IA0KPj4NCj4+IHlvdSBjYW4gZ2V0IHJpZCBvZiByZGJ1ZiBhbmQgYnVmIGlmIHlvdSBwYXNzIGJ1
ZiBhcyBhcmd1bWVudC4NCj4gDQo+IEhtLCBwYXNzaW5nIHRoZSBidWZmZXIgdG8gc2VuZCBkYXRh
IGZyb20vcmVjZWl2ZSBkYXRhIGludG8gaXMgYWxyZWFkeQ0KPiBwYXJ0IG9mIHRoZSBzcGlfbWVt
X29wIGRlZmluaXRpb24gcHJvY2VzcyAod2hpY2ggaXMgZG9uZSBpbiB0aGUgY2FsbGVyDQo+IG9m
IHRoaXMgZnVuYykgc28gd2h5IGJvdGhlciBwYXNzaW5nIGFuIGV4dHJhIGFyZyB0byB0aGUgZnVu
Y3Rpb24uDQo+IE5vdGUgdGhhdCB5b3UgaGFkIHRoZSBleGFjdCBvcHBvc2l0ZSBhcmd1bWVudCBm
b3IgdGhlDQo+IHNwaV9ub3Jfc3BpbWVtX3hmZXJfcmVnKCkgcHJvdG90eXBlIHlvdSBzdWdnZXN0
ZWQgYWJvdmUgKHdoaWNoIEkNCj4gYWdyZWUgd2l0aCBCVFcpIDpQLg0KDQpJbiBvcmRlciB0byBh
dm9pZCBpZiBjbGF1c2VzIGxpa2UgImlmIChvcC0+ZGF0YS5kaXIgPT0gU1BJX01FTV9EQVRBX0lO
KSIuIFlvdQ0KY2FuJ3QgdXNlIG9wLT5kYXRhLmJ1ZiBkaXJlY3RseSwgdGhlICpvdXQgY29uc3Qg
cXVhbGlmaWVyIGNhbiBiZSBkaXNjYXJkZWQuDQoNCnBvaW50ZXIgdG8gYnVmIHdhcyBub3QgbmVl
ZGVkIGluIHNwaV9ub3Jfc3BpbWVtX3hmZXJfcmVnKCksIHdlIGNvdWxkIHVzZQ0Kbm9yLT5jbWRf
YnVmLg0KDQo+IA0KPj4NCj4+PiArCWludCByZXQ7DQo+Pj4gKw0KPj4+ICsJLyogZ2V0IHRyYW5z
ZmVyIHByb3RvY29scy4gKi8NCj4+PiArCW9wLT5jbWQuYnVzd2lkdGggPSBzcGlfbm9yX2dldF9w
cm90b2NvbF9pbnN0X25iaXRzKHByb3RvKTsNCj4+PiArCW9wLT5hZGRyLmJ1c3dpZHRoID0gc3Bp
X25vcl9nZXRfcHJvdG9jb2xfYWRkcl9uYml0cyhwcm90byk7DQo+Pj4gKwlvcC0+ZGF0YS5idXN3
aWR0aCA9IHNwaV9ub3JfZ2V0X3Byb3RvY29sX2RhdGFfbmJpdHMocHJvdG8pOw0KPj4+ICsNCj4+
PiArCWlmIChvcC0+ZGF0YS5kaXIgPT0gU1BJX01FTV9EQVRBX0lOKQ0KPj4+ICsJCWJ1ZiA9IG9w
LT5kYXRhLmJ1Zi5pbjsNCj4+PiArCWVsc2UNCj4+PiArCQlidWYgPSBvcC0+ZGF0YS5idWYub3V0
Ow0KPj4+ICsNCj4+PiArCWlmIChvYmplY3RfaXNfb25fc3RhY2soYnVmKSB8fCAhdmlydF9hZGRy
X3ZhbGlkKGJ1ZikpDQo+Pj4gKwkJdXNlYm91bmNlYnVmID0gdHJ1ZTsNCj4+PiArDQo+Pj4gKwlp
ZiAodXNlYm91bmNlYnVmKSB7DQo+Pj4gKwkJaWYgKG9wLT5kYXRhLm5ieXRlcyA+IG5vci0+Ym91
bmNlYnVmX3NpemUpDQo+Pj4gKwkJCW9wLT5kYXRhLm5ieXRlcyA9IG5vci0+Ym91bmNlYnVmX3Np
emU7DQo+Pj4gKw0KPj4+ICsJCWlmIChvcC0+ZGF0YS5kaXIgPT0gU1BJX01FTV9EQVRBX0lOKSB7
DQo+Pj4gKwkJCXJkYnVmID0gb3AtPmRhdGEuYnVmLmluOw0KPj4+ICsJCQlvcC0+ZGF0YS5idWYu
aW4gPSBub3ItPmJvdW5jZWJ1ZjsNCj4+PiArCQl9IGVsc2Ugew0KPj4+ICsJCQlvcC0+ZGF0YS5i
dWYub3V0ID0gbm9yLT5ib3VuY2VidWY7DQo+Pj4gKwkJCW1lbWNweShub3ItPmJvdW5jZWJ1Ziwg
YnVmLA0KPj4+ICsJCQkgICAgICAgb3AtPmRhdGEubmJ5dGVzKTsNCj4+PiArCQl9DQo+Pj4gKwl9
DQo+Pj4gKw0KPj4+ICsJcmV0ID0gc3BpX21lbV9hZGp1c3Rfb3Bfc2l6ZShub3ItPnNwaW1lbSwg
b3ApOw0KPj4+ICsJaWYgKHJldCkNCj4+PiArCQlyZXR1cm4gcmV0Ow0KPj4+ICsNCj4+PiArCXJl
dCA9IHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgb3ApOw0KPj4+ICsJaWYgKHJldCkNCj4+
PiArCQlyZXR1cm4gcmV0Ow0KPj4+ICsNCj4+PiArCWlmICh1c2Vib3VuY2VidWYgJiYgb3AtPmRh
dGEuZGlyID09IFNQSV9NRU1fREFUQV9JTikNCj4+PiArCQltZW1jcHkocmRidWYsIG5vci0+Ym91
bmNlYnVmLCBvcC0+ZGF0YS5uYnl0ZXMpOw0KPj4+ICsNCj4+PiArCXJldHVybiBvcC0+ZGF0YS5u
Ynl0ZXM7DQo+Pj4gK30NCj4+PiArDQo+Pj4gKy8qKg0KPj4+ICsgKiBzcGlfbm9yX3NwaW1lbV9y
ZWFkX2RhdGEoKSAtIHJlYWQgZGF0YSBmcm9tIGZsYXNoJ3MgbWVtb3J5IHJlZ2lvbiB2aWENCj4+
PiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzcGktbWVtDQo+Pj4gKyAqIEBub3I6
ICAgICAgICBwb2ludGVyIHRvICdzdHJ1Y3Qgc3BpX25vcicNCj4+PiArICogQG9mczogICAgICAg
IG9mZnNldCB0byByZWFkIGZyb20NCj4+PiArICogQGxlbjogICAgICAgIG51bWJlciBvZiBieXRl
cyB0byByZWFkDQo+Pj4gKyAqIEBidWY6ICAgICAgICBwb2ludGVyIHRvIGRzdCBidWZmZXINCj4+
PiArICoNCj4+PiArICogUmV0dXJuOiBudW1iZXIgb2YgYnl0ZXMgcmVhZCBzdWNjZXNzZnVsbHks
IC1lcnJubyBvdGhlcndpc2UNCj4+PiArICovDQo+Pj4gK3N0YXRpYyBzc2l6ZV90IHNwaV9ub3Jf
c3BpbWVtX3JlYWRfZGF0YShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qgb2ZzLCAgDQo+Pg0K
Pj4gcy9vZnMvZnJvbT8gYm90aCBmbGFzaCBhbmQgYnVmIG1heSBoYXZlIG9mZnNldHMsICJmcm9t
IiBiZXR0ZXIgaW5kaWNhdGVzIHRoYXQNCj4+IHRoZSBvZmZzZXQgaXMgYXNzb2NpYXRlZCB3aXRo
IHRoZSBmbGFzaC4NCj4gDQo+IFRoZSBzZW1hbnRpYyBpcyB3ZWxsIGRvY3VtZW50ZWQgaW4gdGhl
IGRvYyBqdXN0IGFib3ZlIHRoZSBmdW5jdGlvbiwgYnV0DQo+IEkgaGF2ZSB0aGUgZmVlbGluZyB0
aGF0IHlvdSdyZSBpbiAnbml0cGljaycgbW9kZSwgc28gSSdsbCBqdXN0IGxldCB5b3UNCj4gcGlj
ayB0aGUgb25lIHlvdSBwcmVmZXIgOikuDQoNCk5vdCBteSBpbnRlbnRpb24uIHN0cnVjdCBtdGRf
aW5mbyBhbmQgc3RydWN0IHNwaV9ub3IgdXNlICJmcm9tIiB3aGVuIHJlZmVycmluZw0KdG8gdGhl
IG9mZnNldCBmcm9tIHdoZXJlIHRvIHJlYWQgaW4gdGhlIHJlYWQoKSBjYWxscy4gSnVzdCBjb25z
aXN0ZW5jeSByZWFzb25zLg0KDQpDaGVlcnMsDQp0YQ0K
