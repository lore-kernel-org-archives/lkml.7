Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA56C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA0E2206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 07:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="aIBw1moh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfHEHcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 03:32:33 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:17915 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:32:33 -0400
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
IronPort-SDR: g46tughlXUBJNyBZKVe17P/z0VOcNvqyLm3fMsl3f/bd8RGKFO/Pyfcmk57O4hxVkvli1ZP51S
 p5XKZfrr+7wYPXLn31yWaNB8wdny+eYDqoKZrxLTI1i9t5+DKWPVE1MsBVy0YwQtVhsp4LKtWD
 HIjOJqBj61uyM/CrdGCM+vyxLwwbQjax4y/QXuQS/rywuGee6qpKiSXOhGjHyVVoIdTo50d71E
 8CoS9p4oL1Vk5NZ1K2krM8vF7ZH1qXIWdk/tMigxsToO2DFTklXeGsPolHdT1e3MrMSEKnwL8h
 m30=
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="43922944"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2019 00:32:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Aug 2019 00:32:13 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Aug 2019 00:32:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1/sySa+2dsTfS3gHZCRSvsuYJVUa5LdKPW3rqpPssidQLJPxoPErnPBfx0s+mj37OR4khW/Mcphi1UAPQ/jn5Jyy3g7GkEuTtIMQCPhFg5OGqcKXC0Am5+58QO5s/VFpavOvsfP+JSwqFmTKbDQ/ryZWkqs0P06QzwQI52d5WJXrF46bs8HNY7VktjSuwmxjfqMGb0GKoeG1/fJV3AcC9K5f5vmHBZiW9tmwAoLhfmBNiXBVE7HS3D6yeFw7bPhyrcPsgThJL1z1G0nZ4oxJCbdzNzTT05a5vwE4rRAUx8aiIhIIdatJEbH5B7L7O6uxZJbaM4mfJSHfsNDd0lbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHAOT+yeiuVdF7L/3Cnn1RZrgiB9FR1DwxR3eWVMAlg=;
 b=FUsyGHFkyouFvXSBXcrUYj3Ul/Rm2Us65LU/UnpRwachhMCcGna7zZK+EDqg/X1CPY+NzbjnbYOPEl/9ndqL4ffTp+v6ieMyebLE7K4Q6cRofzhRSNwDgVYc6f0ppB8pjUdZA9mpg0RIl7vhLiJTdo05AgmXr2Hqxf0th41HhBBRKh9D3H+NOb3IpoQEVdY/jcuKpHkzhjM79IGs4rsox8PkwcdKWumfwc+FoVolNB+pUc3lIwWv9vwbgBGNbP4DU1VrAOWTDQW8zI6QLw36VJvN7Pghr7EvCHdBBkZf77j+5qn7U5AU/FlAlxCgkTG3Yh4JyqYFgNTlYvXvIWG4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHAOT+yeiuVdF7L/3Cnn1RZrgiB9FR1DwxR3eWVMAlg=;
 b=aIBw1mohLRO7i8ghgRGTH0TubXyzmN0NcZ4AFny20F3sGU6qxgWAXbObRcnCe0/d6+p4h5QD/TeBIjXu7UckHGJCjK84Q+Ta11up0e4GjCwcZ02T/m/pnVk3XnZBv3+ndWm44jTeIML83wpYkM6JdbPrciJK2qA6dMUOZw/jLu8=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4205.namprd11.prod.outlook.com (52.135.39.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Mon, 5 Aug 2019 07:32:09 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 07:32:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 6/6] mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
Thread-Topic: [PATCH 6/6] mtd: spi-nor: Add the SPI_NOR_XSR_RDY flag
Thread-Index: AQHVR4ANBFbmyZuDXEi4qln0HD1tDabsCj2AgAAmgQA=
Date:   Mon, 5 Aug 2019 07:32:09 +0000
Message-ID: <d87bf780-f728-e2e0-be6a-1731fddd32c9@microchip.com>
References: <20190731091145.27374-1-tudor.ambarus@microchip.com>
 <20190731091145.27374-7-tudor.ambarus@microchip.com>
 <93dc5a5d-3a72-c80e-0b0d-7fd758a1ea5e@ti.com>
In-Reply-To: <93dc5a5d-3a72-c80e-0b0d-7fd758a1ea5e@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:802:2::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df3af668-ae51-49da-2eab-08d71977064f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4205;
x-ms-traffictypediagnostic: MN2PR11MB4205:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR11MB4205BA29339A2239EF1891ABF0DA0@MN2PR11MB4205.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 01208B1E18
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(26005)(36756003)(110136005)(186003)(81156014)(6512007)(54906003)(486006)(3846002)(4326008)(66476007)(66556008)(64756008)(66446008)(6116002)(66946007)(966005)(2906002)(5660300002)(25786009)(31696002)(2616005)(11346002)(476003)(446003)(6486002)(86362001)(71200400001)(14454004)(66066001)(102836004)(68736007)(305945005)(229853002)(14444005)(256004)(478600001)(71190400001)(7416002)(2501003)(6246003)(31686004)(316002)(2201001)(53936002)(53546011)(386003)(6306002)(8676002)(6506007)(52116002)(6436002)(99286004)(8936002)(7736002)(81166006)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4205;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8i5/7GjppMrceN2Jvo8QzFsliltPIcgIvEBpyKJ65flXcpoeovpGfxmOASp2hV9D++/KV79IEfUeQjy+87hcQbS6lzAWf0HbrgpPnxdbISY4OKucX/9tnOgMcsASwoYLEOUYd7wiO3fIMzW2qLHZjvUv7j+UIn72roM826MZGgn7mZ4a2o3y15zPUPbNiRksrhY9HzUmr7AFhkwR5mtLpag/QlQMSlRhhdpqxPEB6Cfs5wJYnUtqEGrJPJvyxycaw8sG/Uwxt9Ac+biu7VjbeMHoBOlnzFfk1+40Ov/TvZRLz63pFDV+kf74weExl5arz0w4wxjCtIaXhxsjF4G0M22BYEDw/a1bbXql/kYHgJ2yz4boGvu+JwYpOCEjLmO7fbXwlWeefd2Y05Qw6v+W5lDTzvCPBZa+Ogd0o8hK+AE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2CC753D0DFAE04C926EF3F91C5BB4BA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: df3af668-ae51-49da-2eab-08d71977064f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 07:32:09.5288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzA1LzIwMTkgMDg6MTQgQU0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
IEV4dGVybmFsIEUtTWFpbA0KPiANCj4gDQo+IA0KPiBPbiAzMS8wNy8xOSAyOjQyIFBNLCBUdWRv
ci5BbWJhcnVzQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBCb3JpcyBCcmV6aWxsb24g
PGJvcmlzLmJyZXppbGxvbkBib290bGluLmNvbT4NCj4+DQo+PiBTM0FOIGZsYXNoZXMgdXNlIGEg
c3BlY2lmaWMgb3Bjb2RlIHRvIHJlYWQgdGhlIHN0YXR1cyByZWdpc3Rlci4NCj4+IFdlIGN1cnJl
bnRseSB1c2UgdGhlIFNQSV9TM0FOIGZsYWcgdG8gZGVjaWRlIHdoZXRoZXIgdGhpcyBzcGVjaWZp
Yw0KPj4gU1IgcmVhZCBvcGNvZGUgc2hvdWxkIGJlIHVzZWQsIGJ1dCBTUElfUzNBTiBpcyBhYm91
dCB0byBkaXNhcHBlYXIsIHNvDQo+PiBsZXQncyBhZGQgYSBuZXcgZmxhZy4NCj4+DQo+IA0KPiBJ
IHRoaW5rIHlvdSBjYW4gZHJvcCBTUElfUzNBTiByaWdodCBhd2F5IGVpdGhlciBhcyBzZXBhcmF0
ZSBwYXRjaCBpbg0KPiB0aGlzIHNlcmllcyBvciBhcyBwYXJ0IG9mIHRoaXMgcGF0Y2ggaXRzZWxm
Lg0KPiANCg0KU1BJX05PUl9YU1JfUkRZIGlzIG1vcmUgZ2VuZXJpYyB0aGFuIFNQSV9TM0FOLCBh
bmQgbGV0cyBvdGhlciBmbGFzaGVzIHVzZQ0KU1BJTk9SX09QX1hSRFNSIFNSIHJlYWQgb3Bjb2Rl
IGlmIG5lZWRlZC4NCg0KSWYgSSBkcm9wIFNQSV9TM0FOIG5vdywgSSdsbCBoYXZlIHRvIHNlbGVj
dCB0aGUgczNhbl9ub3Jfc2V0dXAoKSBtZXRob2QgYmFzZWQgb24NClNQSV9OT1JfWFNSX1JEWS9T
Tk9SX0ZfUkVBRFlfWFNSX1JEWSB3aGljaCBtaWdodCBub3QgYmUgY29ycmVjdC4gVGhlcmUgbWln
aHQgYmUNCmZsYXNoZXMgdGhhdCB1c2UgU1BJTk9SX09QX1hSRFNSIGJ1dCBoYXZlIGEgZGlmZmVy
ZW50IHNldHVwIGNhbGwuDQoNCk9mIGNvdXJzZSB0aGVyZSBhcmUgYSBsb3Qgb2YgIm1pZ2h0IiBo
ZXJlIChiZWNhdXNlIEkgY291bGRuJ3QgZmluZCBzb21lIG90aGVyDQpOT1JzIHRoYXQgdXNlIHRo
aXMgb3Bjb2RlKSwgYW5kIGlmIHlvdSBoYXZlIGEgc3Ryb25nIG9waW5pb24gSSBjYW4gY2hhbmdl
IGFzIHlvdQ0Kc3VnZ2VzdGVkLiBJIHByZWZlciB0byBkcm9wIFNQSV9TM0FOIHdoZW4gbW92aW5n
IHRoZSB4aWxsaW54IGJpdHMgb3V0IG9mIHRoZQ0KY29yZSwgYXMgaW4gaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wYXRjaC8xMDA5Mjk1Ly4NCg0KQ2hlZXJzLA0KdGENCg==
