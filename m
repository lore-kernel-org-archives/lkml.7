Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB5C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 026242089E
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 06:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="x0PEiNfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfGaGXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 02:23:52 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:56340 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaGXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:23:52 -0400
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
IronPort-SDR: 8nz04m9gb8aaaZnyUEy8GhI02CaS109T6xmL0jLTWPi6ewtaTK/jNLA99DMmsAzhUENKSsdDcy
 hBUUbochF7U2JYwQN3nWiQxGTX0jCgtYl4Du4/DjtB5SMNjuzBg6thR7cMJDSm18MIUOJbuxNi
 myg0iUGVEhSfOj0l13oagsooZeHmlYdiDnGiikBnenrMDgdi1uoqQZFS+VtJeXQlNVf8K5/sNm
 B8eBVdTFxO7ZhStKO2rP0Ah6ygSnXuHQsgvdsvAiyZ//If8o+TQl8PlC+vHs2FnE7d+8wACr3p
 R8A=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="43360245"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jul 2019 23:19:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 30 Jul 2019 23:19:29 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 30 Jul 2019 23:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vo1NI4MlykcYEtzxTmrkG9PRYG/ZoEIHsBFxMP0NtdolH7LmA/iKdWEp8TjUl5a9pt9t9fWEh8VVD43K6pesx/C128pZNvyBPYLPDEpnVuohwKiWK0mb7hb6fI1u1RZ2cAPkIGXk3XX472/KqBKVKlK3ndG/KA0Ixx8OJoR2VNbxtoByogNnyV1wMLLDyuNvTYGeCz+ty4sUS7ZIZVMXgNvM/zPc+Cell0uAWR78/z6k8XJT4f//8jrocXEoZiMJiSB8v0pRVTZe5d53dpsMplGFFfBAtbdJ5parJXm4au7+WutXkEZdTvp5/Y/OT1joe9U6FcNQwLgJq4EJIrOW8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsJgwlz+s8DLNvT4pgU9bbSNJm0s59ZDG8SP2ao7gRc=;
 b=ESzohpW2u2ysiYQ1o2uF2Ho6ROWPtxbjk5MdiKQZQ7Up8TTCwIs3hZn1BKt63zdfXysvVPjLeDaMPyhSkptkFD+osKYDft7M4mzrB8YQqwt27QdGKdmyJ6zwIE1eYrtVdvna2TNidQ4hzb3db2xcd2NzKnJwZvjTIlGpq4TMdHPvK+Z1uh53F4CYnKgEnE4LbriYmmMgxIB67cO4KQ2erWYt7b40F2HDMjl7pnqbazQcnd5SLmbkpYn46Iq+2ZlvHKneKcG7nfQtfjFYbfkVK6iwrsPpC546xnJtuvd74M7iVGPBtK/JT097Ldw669UDkdOSXYAqFD8cyRYufEnhYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsJgwlz+s8DLNvT4pgU9bbSNJm0s59ZDG8SP2ao7gRc=;
 b=x0PEiNflsgSZMWtIT3o3QKqLv002iiWo/d8fmhJRNwvOXVGbpGe29rZZuw+S01sPiQUnIzA6YXPBpzeu3mglabDS0ZLxkRYYyX/Z/UPYghnz/8jhTxYykkAajrcXBNvLw/qx2EyoU0dJ7VISsTUWSG7B8DPc4lHu91RHEwh21Yo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3679.namprd11.prod.outlook.com (20.178.252.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Wed, 31 Jul 2019 06:19:26 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 06:19:26 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <marek.vasut@gmail.com>
CC:     <yogeshnarayan.gaur@nxp.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: Move m25p80 code in spi-nor.c
Thread-Index: AQHVPtFNjfEG9DN44ESnRp+H/g0b8qbbN92AgAhM6wCAAM1SAA==
Date:   Wed, 31 Jul 2019 06:19:26 +0000
Message-ID: <a7dca16d-c20a-da4d-6a33-ecf043b241cb@microchip.com>
References: <20190720080023.5279-1-vigneshr@ti.com>
 <20190720080023.5279-2-vigneshr@ti.com>
 <f6410e21-18c3-9733-4ea5-13eb26ad6169@microchip.com>
 <512b5fac-b1e4-0350-a07c-184008f67341@ti.com>
In-Reply-To: <512b5fac-b1e4-0350-a07c-184008f67341@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0119.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::21) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54dd0d3d-27f5-42d4-cc3e-08d7157f0976
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3679;
x-ms-traffictypediagnostic: MN2PR11MB3679:
x-microsoft-antispam-prvs: <MN2PR11MB3679BE205E483C46A0316CFDF0DF0@MN2PR11MB3679.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(199004)(189003)(6486002)(7736002)(478600001)(52116002)(53546011)(229853002)(6116002)(71200400001)(76176011)(66446008)(6246003)(99286004)(54906003)(2201001)(4326008)(5660300002)(36756003)(110136005)(31696002)(6512007)(3846002)(53936002)(6436002)(25786009)(26005)(2616005)(102836004)(8936002)(316002)(8676002)(81166006)(186003)(486006)(14454004)(2906002)(446003)(66066001)(81156014)(66946007)(68736007)(476003)(31686004)(66556008)(66476007)(11346002)(256004)(305945005)(64756008)(6506007)(386003)(2501003)(71190400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3679;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: D24/DDehBybxuJ0usVbfhW9smOIm/HNGgHQC2co+4lYz1AnEEgfFnYEmc8ci1wwrjKDWDTmxN8rAH5dm7MN9/O/iYJvsJJI5crp7TdcUkwD9aSs77goh0MzvaxIvHCGD9VubW43fjbofjOn5GUVty9uzD+jUzzr50H9qOqwstRa0i5r1DQgwXF0p5ZDLdeNbO2w2gkAHLzfE560YMB/1h+eAW9y/uDnFbauBFZ1mVbHxgJrtGgWms2rPYyTJwXLr3t2TdW/QlXpvMS3ZHEtUSVeLuNx32Dl/KpE2INHeSUP2UAKDqxvHn8AS0AdLQV1mp25Mxmfd5epFUf5amFUhZrtw8cYiwab7z64rsT06z7RypjzLJQfk8Hcr6sfHNFkAZJLNaZ7LB8h+Tr7eWe15zArMhpm7c+WtfgoleeZNbMQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A5B0585C89CFC41836C8FEE1C6A3CC2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54dd0d3d-27f5-42d4-cc3e-08d7157f0976
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 06:19:26.3537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA3LzMwLzIwMTkgMDk6MDQgUE0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
Pj4gKyAqLw0KPj4+ICtzdGF0aWMgaW50IHNwaV9ub3JfZXhlY19vcChzdHJ1Y3Qgc3BpX25vciAq
bm9yLCBzdHJ1Y3Qgc3BpX21lbV9vcCAqb3AsDQo+Pj4gKwkJCSAgIHU2NCAqYWRkciwgdm9pZCAq
YnVmLCBzaXplX3QgbGVuKQ0KPj4+ICt7DQo+Pj4gKwlpbnQgcmV0Ow0KPj4+ICsJYm9vbCB1c2Vi
b3VuY2VidWYgPSBmYWxzZTsNCj4+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhIGJvdW5jZSBidWZm
ZXIgZm9yIHJlZ3MuIFdoYXQgaXMgdGhlIG1heGltdW0gc2l6ZSB0aGF0IHdlDQo+PiByZWFkL3dy
aXRlIHJlZ3MsIFNQSV9OT1JfTUFYX0NNRF9TSVpFKDgpPw0KPj4NCj4+IEluIHNwaS1ub3IuYyB0
aGUgbWF4aW11bSBsZW5ndGggdGhhdCB3ZSBwYXNzIHRvIG5vci0+cmVhZF9yZWcoKS93cml0ZV9y
ZWcoKSBpcw0KPj4gU1BJX05PUl9NQVhfSURfTEVOKDYpLg0KPj4NCj4+IEkgY2FuIHByb3ZpZGUg
YSBwYXRjaCB0byBhbHdheXMgdXNlIG5vci0+Y21kX2J1ZiB3aGVuIHJlYWRpbmcvd3JpdGluZyBy
ZWdzIHNvDQo+PiB5b3UgcmVzcGluIHRoZSBzZXJpZXMgb24gdG9wIG9mIGl0LCBpZiB5b3UgZmVl
bCB0aGUgc2FtZS4NCj4+DQo+IA0KPj4gV2l0aCBub3ItPmNtZF9idWYgdGhpcyBmdW5jdGlvbiB3
aWxsIGJlIHJlZHVjZWQgdG8gdGhlIGZvbGxvd2luZzoNCj4+DQo+IEkgd2lsbCBtb3ZlIHRoZSBj
b2RlIGludHJvZHVjaW5nIGJvdW5jZSBidWZmZXIgaW50byBzZXBhcmF0ZSBwYXRjaCBhdA0KPiB0
aGUgYmVnaW5uaW5nIG9mIHRoaXMgc2VyaWVzIGFuZCBzd2l0Y2ggb3ZlciBhbGwgcmVhZC93cml0
ZSByZWdzDQo+IGZ1bmN0aW9ucyB0byB1c2UgYm91bmNlIGJ1ZmZlciBpbnN0ZWFkIG9mIGNtZF9i
dWYuIGNtZF9idWYgd2lsbCBiZSBkcm9wcGVkLg0KPiBBbmQgdGhlbiBzaW1wbGlmeSB0aGlzIHBh
dGNoIHRvIHNwaV9ub3Jfc3BpbWVtX3hmZXJfcmVnKCkgdG8geW91IHBvaW50ZWQNCj4gb3V0IGJl
bG93LiBEb2VzIHRoYXQgc291bmQgZ29vZD8NCj4gDQoNClBsZWFzZSBkby4gUHJvYmFibHkgd2Ug
Y2FuIGdldCByaWQgb2Ygc3BpX25vcl9zcGltZW1feGZlcl9yZWcgZW50aXJlbHkgYW5kIHVzZQ0K
c3BpX21lbV9leGVjX29wKCkgZGlyZWN0bHkgd2hlbiBpbnRlcmFjdGluZyB3aXRoIHJlZ2lzdGVy
cy4gSSdsbCB3YWl0IGZvciB5b3VyIHYzLg0KDQpDaGVlcnMsDQp0YQ0KDQo+PiBzdGF0aWMgaW50
IHNwaV9ub3Jfc3BpbWVtX3hmZXJfcmVnKHN0cnVjdCBzcGlfbm9yICpub3IsIHN0cnVjdCBzcGlf
bWVtX29wICpvcCkNCj4+IHsNCj4+IAlpZiAoIW9wIHx8IChvcC0+ZGF0YS5uYnl0ZXMgJiYgIW5v
ci0+Y21kX2J1ZikpDQo+PiAJCXJldHVybiAtRUlOVkFMOw0KPj4NCj4+IAlyZXR1cm4gc3BpX21l
bV9leGVjX29wKG5vci0+c3BpbWVtLCBvcCk7DQo+PiB9DQo+Pg0KPj4gc3BpX25vcl9leGVjX29w
KCkgYWx3YXlzIHJlY2VpdmVkIGEgTlVMTCBhZGRyLCBsZXQncyBnZXQgcmlkIG9mIGl0LiBXZSB3
b24ndA0KPj4gbmVlZCBidWYgYW55bW9yZSBhbmQgeW91IGNhbiByZXRyaWV2ZSB0aGUgbGVuZ3Ro
IGZyb20gb3AtPmRhdGEubmJ5dGVzLiBOb3cgdGhhdA0KPj4gd2UgdHJpbW1lZCB0aGUgYXJndW1l
bnRzLCBJIHRoaW5rIEkgd291bGQgZ2V0IHJpZCBvZiB0aGUNCj4+IHNwaV9ub3JfZGF0YS9ub2Rh
dGFfb3AoKSB3cmFwcGVycyBhbmQgdXNlIHNwaV9ub3Jfc3BpbWVtX3hmZXJfcmVnKCkgZGlyZWN0
bHkuDQo=
