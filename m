Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBC8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C2420867
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I5U5hBDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407023AbfJYHei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:34:38 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:47627 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406004AbfJYHeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:34:37 -0400
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
IronPort-SDR: V2hd1pyqxd38PXeH2BqNkK+m6yZ+PUGOz56BXfR5aMrTIWdjtIl/RvupeW6KMbRLY5/0p/G8Qy
 8Wj5AWyu0/A+rs6AN1TWAqRGp5E8uhyG1HAnO9BJ5k4/h0OUg3pzyoiQI0v3zx7Rds9ZrcWidG
 joySauTyVhZIkqgoVTsDk1UTRE5DZHT5tds3JYcYlJhw23TEkDZaNxsHNmDcDSulndSUp/9VKY
 teA1GOfJn5G5OBlOKu/VBBb/rysPiqTSdwIZHFBFsOOvDzGnLmmAI8nUV9bsZDjff5AQGk2SWg
 uCY=
X-IronPort-AV: E=Sophos;i="5.68,227,1569308400"; 
   d="scan'208";a="52932564"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2019 00:34:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Oct 2019 00:34:34 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 25 Oct 2019 00:34:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2cW8FYUTCnpA6dGrL6B0q9pKpndta0q8//kpWpnic9cS461AKd7JOlIs1n1XYunVQydiGZ6v9GGhoeOcltzCgrguUx/C1ejoubhLd0Q7PMWxKpIJNEN+QVimMpMJsBOd4llTrvQmXgZ4K5sA4rau9W974xN2r2aXpRU6gF95DBAtTdhJ7Nata8ZqYu/0bQ2d+WrvaxwxFL0+xW4HpG0/5DY+JZ03BJDWOEn4mxRCQuHVSwWvHXDRKk9olueCsxPYVnrrhMXLcufa+Pn+XQyW2jmJaJlHTyz4xZTNy4T2ECV9dKMHtO9dRPt8DUNlKUht/7gOyqvkiEaUVIJ61HZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7SC8mMStlHEDZ5ri/e02ClS1jNHuD60CFazcfME7+s=;
 b=aPEqzsgK3ZTO40zDbbLLjF2Bqjep1SVcMXnrELOrffr+iGyssdHJyxt1ScVO0S2qzwuGviQ8RF3MuFAgcXbZKvGtFtvAARuV5CR/9p1HhMzZJycgLZu9eLQsjXAmxPxANwGyBi9S6PMJPjg/IYNIKsD1Q7YxE3qh42W7B63KteuwSnvkJ0koDS2QcFLLleACf6fyl6akw1nRaGId5mhbYJ7HCr8xe66a2ReHUIul635YTCpUPVJa3n3esYHpxguS6IqhBE4GLDRyArNZ44V1KhVcnegIs3VGAH6tby0LQfBnJUM5PEmAtwoJC1/c7xrVK27MKcG2B9eOnjMj3qCvYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7SC8mMStlHEDZ5ri/e02ClS1jNHuD60CFazcfME7+s=;
 b=I5U5hBDvg19coXtfiIjLbyN5UkOngSBuQCQR6xjAk2dNwE79yz4nNcs5rySPRuJoqdA2S2ELKVEyug8RslLQzJOvK1cjFU5+BDXrYaxo6bQV9REFqmCfWxzwhlMtBuIw3iTH5SimCAP7NI3xCLc0cGYi0lW1uig9jR3mw/lXB7M=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3583.namprd11.prod.outlook.com (20.178.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Fri, 25 Oct 2019 07:34:30 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.030; Fri, 25 Oct 2019
 07:34:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <geert+renesas@glider.be>, <andrew@aj.id.au>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <vz@mleia.com>,
        <marek.vasut@gmail.com>, <jonas@norrbonn.se>,
        <linux-mtd@lists.infradead.org>, <joel@jms.id.au>,
        <miquel.raynal@bootlin.com>, <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH v2 09/22] mtd: spi-nor: Fix retlen handling in sst_write()
Thread-Topic: [PATCH v2 09/22] mtd: spi-nor: Fix retlen handling in
 sst_write()
Thread-Index: AQHVcqwocr2G1vTqBEOgTu/C0BezHKdTlJMAgBeTUIA=
Date:   Fri, 25 Oct 2019 07:34:30 +0000
Message-ID: <7f23e9c0-0e9c-e365-e103-75ead47000a3@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-10-tudor.ambarus@microchip.com>
 <20191010093308.2fe94974@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20191010093308.2fe94974@dhcp-172-31-174-146.wireless.concordia.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: PR0P264CA0192.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::36) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83b8bfcc-5d3a-4947-9a7b-08d7591dc5af
x-ms-traffictypediagnostic: MN2PR11MB3583:
x-microsoft-antispam-prvs: <MN2PR11MB35834DD9781A0747FDA5270DF0650@MN2PR11MB3583.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(366004)(396003)(376002)(199004)(189003)(7416002)(31696002)(14454004)(316002)(6506007)(66066001)(256004)(6246003)(386003)(6916009)(478600001)(25786009)(2906002)(71200400001)(6512007)(71190400001)(31686004)(8936002)(11346002)(3846002)(76176011)(26005)(476003)(6116002)(6486002)(81156014)(53546011)(99286004)(81166006)(229853002)(8676002)(52116002)(446003)(102836004)(66946007)(66556008)(86362001)(4326008)(7736002)(54906003)(66476007)(305945005)(2616005)(486006)(36756003)(5660300002)(66446008)(64756008)(6436002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3583;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoNcVBwx12ZaXfjSPsx3bnGWP9gMMSTKHyCo69kG0wbkt8GkHyE+i9LzNHtStmI8KMM1JUJHqFMRCAOm2UdcDyu5dYqctFgYIV1IJHkNZ6gpxs1FaG8grWSE1xPS7OAtCWpVjy9m26nLFd/XLAI1F9pc6t7dFBJL+RKGKnZeVDWWJb47YGbjFKLLPkf983xGP/dqd+n9gwMuxqKbG9xOi8ITxKkbECJR1lWB7f3rBHpSBxOagSjlLCSLu/C3Je47VyVvAqdG9Z5tkU8iguawX9xx2oAFdoQAim2h3klfyeYqkk/ynu8o4V6fTBnzKIFBAqDRzvAbd4U2P51XwjeUyZoXlVhmMI8/i4X/7WDtx4px5PR8LmZKcVQhV5vN8AtLWKKUDx5atXm2250hM+8GV4S+pgWj0Dm9WzrYi62SqPWOJ6Jn/6s8Bscwwn331JRK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45DA9D045FD26A47B1E5C2B4A28D6DC7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b8bfcc-5d3a-4947-9a7b-08d7591dc5af
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 07:34:30.4346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akEJHOa8RD9C1ExePW1kvGmqf61Wi7oIbXkZAbTVcoN+PFzurYaIDppZ21O1QXT7TTwBQzmumnC/4or90AhR7PgTQnyeIiHCMKsV02XzvNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzEwLzIwMTkgMTA6MzMgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCg0KPj4g
IGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0t
LQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gaW5kZXggMGFlZTA2OGE1ODM1Li5iZTVkZWU2
MjJkNTEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+IEBAIC0yNjY1LDEyICsyNjY1
LDEyIEBAIHN0YXRpYyBpbnQgc3N0X3dyaXRlKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3Qg
dG8sIHNpemVfdCBsZW4sDQo+PiAgCQkvKiB3cml0ZSBvbmUgYnl0ZS4gKi8NCj4+ICAJCXJldCA9
IHNwaV9ub3Jfd3JpdGVfZGF0YShub3IsIHRvLCAxLCBidWYpOw0KPj4gIAkJaWYgKHJldCA8IDAp
DQo+PiAtCQkJZ290byBzc3Rfd3JpdGVfZXJyOw0KPj4gKwkJCWdvdG8gdW5sb2NrX2FuZF91bnBy
ZXA7DQo+PiAgCQlXQVJOKHJldCAhPSAxLCAiV2hpbGUgd3JpdGluZyAxIGJ5dGUgd3JpdHRlbiAl
aSBieXRlc1xuIiwNCj4+ICAJCSAgICAgKGludClyZXQpOw0KPj4gIAkJcmV0ID0gc3BpX25vcl93
YWl0X3RpbGxfcmVhZHkobm9yKTsNCj4+ICAJCWlmIChyZXQpDQo+PiAtCQkJZ290byBzc3Rfd3Jp
dGVfZXJyOw0KPj4gKwkJCWdvdG8gdW5sb2NrX2FuZF91bnByZXA7DQo+PiAgCX0NCj4+ICAJdG8g
Kz0gYWN0dWFsOw0KPiBOb3Qgc3VyZSB3ZSBuZWVkIHRoaXMgbmV3IGxhYmVsLCB3ZSBjYW4ganVz
dCBoYXZlOg0KPiANCj4gCWFjdHVhbCA9IDA7DQo+IAkvKiBTdGFydCB3cml0ZSBmcm9tIG9kZCBh
ZGRyZXNzLiAqLw0KPiAJaWYgKHRvICUgMikgew0KPiAJCW5vci0+cHJvZ3JhbV9vcGNvZGUgPSBT
UElOT1JfT1BfQlA7DQo+IA0KPiAJCS8qIHdyaXRlIG9uZSBieXRlLiAqLw0KPiAJCXJldCA9IHNw
aV9ub3Jfd3JpdGVfZGF0YShub3IsIHRvLCAxLCBidWYpOw0KPiAJCWlmIChyZXQgPCAwKQ0KPiAJ
CQlnb3RvIG91dDsNCj4gCQlXQVJOKHJldCAhPSAxLCAiV2hpbGUgd3JpdGluZyAxIGJ5dGUgd3Jp
dHRlbiAlaQ0KPiAJCWJ5dGVzXG4iLCAoaW50KXJldCk7DQo+IAkJcmV0ID0gc3BpX25vcl93YWl0
X3RpbGxfcmVhZHkobm9yKTsNCj4gCQlpZiAocmV0KQ0KPiAJCQlnb3RvIG91dDsNCj4gDQo+IAkJ
dG8rKzsNCj4gCQlhY3R1YWwrKzsNCj4gCX0NCj4gDQoNCm5pY2UsIHRoYW5rcyENCg==
