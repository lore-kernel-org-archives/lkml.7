Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADEEC47E49
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5475521906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="QRF8CXm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392674AbfJWVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:34:43 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:9793 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392570AbfJWVem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:34:42 -0400
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
IronPort-SDR: RXIQWnLDqFb3ySxP0Uh6QIgT3q5zoWZnRQ49Ty80o5ZiKrmB2wZC9QSwi2s+unwgnqPPVQT2QK
 7E0JypWGLZuW213tsFRMppYG0bVOLLtjusPGOjwxdBUmqY7o92I4hN+VhEnR9B1h42SobcSxcX
 d3qfFXDl7KsoFGHc9gfvAuErotyi98fGA9vDAduDXunvepb8b/SGc852JLOiGUeI1IoR1XzTwT
 Y6o7aVf7sDci9Op8U/xB9VLg04GJktZjl5OBV3cqw4KjbXXE1ULDP9zP58MLyIyy/vK6bRFC66
 KVg=
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="54153317"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Oct 2019 14:34:41 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 14:34:41 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 23 Oct 2019 14:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BY4RMO/TH1U9vTNU2iEjWp/oeSpAxUaGrHnDuaoaVvnaRxDlK7f6fmtArZ4eK2T4k1ayCzUzeV2+YS2B720uURK93V/ZVbYVxMdNh76U55qYLmCRh21/w5gGY0tVXH2z3RoLzHd4Twd/BmMBWLq+gFyCx2P/lnG3zXScroE/EuregzzRjDocxAcaNILuYcDgvtS0JwtxH7a0wNudNjED3snqPAOBVb9dGv9wOR4z9z2V3INpaeqCpwTDEQAeInMnqWTu+kRGN6xHSSCsHn5Qayi7tIrKxSYUAU+b2ScbfLzKqby6d5Dv9ok25PwXR8wb1MiZrPRS+motJkBFVfo3JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u3BoCkh77DId5p67q6c8hRXr1GXo5iZCI63ao1rXak=;
 b=mm50fXbSvXbnfMDqdBj2TZIAocTLARGHuuXa9sg0rkY6PZ42YpP0VqJR2k9enOCBN4AbwAOq2/VeXd3F2GNqOeeF7T0H1B9HJF4ZwzPsWIQvo3OMAYJT8b42Gce0lKNrgH/a05equN2pBECKePeuQOgRaJkTSjDO7W0OUtlE4I8fgf4hOr7YMbMzDU2XL9/vgRGizCxS6o/6yDBf9/1JTcUXE5HP9SmAyYxSRDSTajNjBEPOQJS0D8fVny7ei2NH/D616OOoHuAPcoXHKyjZIUgnPgnILbTAjb69qlWxVuT3scMY5aeqkhD7ZFBz03kqNlRGcv2/eaFuH/wkt73Ywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u3BoCkh77DId5p67q6c8hRXr1GXo5iZCI63ao1rXak=;
 b=QRF8CXm7nJLOaJeGEtmw/Yp0zt/jK5ED1o6y1oiVZKwAkLP0FeejFEpoBvZ6vgT0ARPZhIMMtJex+ExZ70lzbUMGJmdlXzKbNk4sXvxpFbAqWd+4H06TUtby1F+vz8r9tlIVxJGrEBEKedSGTNeOcRuypJA1byJleie+SEw6dAs=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4127.namprd11.prod.outlook.com (10.255.181.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Wed, 23 Oct 2019 21:34:39 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 21:34:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>
CC:     <vigneshr@ti.com>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <geert+renesas@glider.be>,
        <jonas@norrbonn.se>, <linux-aspeed@lists.ozlabs.org>,
        <andrew@aj.id.au>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <vz@mleia.com>,
        <linux-mediatek@lists.infradead.org>, <joel@jms.id.au>,
        <miquel.raynal@bootlin.com>, <matthias.bgg@gmail.com>,
        <computersforpeace@gmail.com>, <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 04/22] mtd: spi-nor: Rename nor->params to nor->flash
Thread-Topic: [PATCH v2 04/22] mtd: spi-nor: Rename nor->params to nor->flash
Thread-Index: AQHVcqwd6l0dKwpZgkWeyuipcOeMgadTjNQAgBVhDAA=
Date:   Wed, 23 Oct 2019 21:34:39 +0000
Message-ID: <9c57cd8b-d797-f2a9-0235-792a0e730090@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-5-tudor.ambarus@microchip.com>
 <20191010090524.6de7e746@dhcp-172-31-174-146.wireless.concordia.ca>
In-Reply-To: <20191010090524.6de7e746@dhcp-172-31-174-146.wireless.concordia.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0149.eurprd07.prod.outlook.com
 (2603:10a6:802:16::36) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 709f8e70-dad7-4ca8-de16-08d75800cf38
x-ms-traffictypediagnostic: MN2PR11MB4127:
x-microsoft-antispam-prvs: <MN2PR11MB412737CE278F3D7861412CB5F06B0@MN2PR11MB4127.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39860400002)(396003)(346002)(52314003)(199004)(189003)(5660300002)(53546011)(6916009)(26005)(66066001)(76176011)(6246003)(4326008)(102836004)(6512007)(11346002)(6506007)(446003)(386003)(186003)(81166006)(36756003)(8936002)(6436002)(8676002)(81156014)(2616005)(31686004)(25786009)(52116002)(14454004)(71200400001)(486006)(71190400001)(14444005)(256004)(476003)(99286004)(316002)(54906003)(66446008)(64756008)(66556008)(66476007)(7736002)(229853002)(2906002)(305945005)(6486002)(7416002)(4744005)(3846002)(86362001)(31696002)(6116002)(66946007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4127;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Zb5qDw7w0JBjAZCu3P0npNh+5e4BH8IN2AWJFXZbkRG7ESyK0ReMSvV7am1Fo/vR4dY17ECnWY8OKXitWXOxgocS/kLfPfvliqH/I7KpCE/A256zKu3FmREFzzAHVpOFVSERnjm5fzfM3OSFG3Pxj6JdYd2JJ/0f0453B8ygL9QpHtRzUHHt1DBvBAXhDl4cXuChHYbPfs6XiRONqeLwe5K/QOHD2iDyc+jsBC5DLPnGkbB8K+yScwYSiHQoE8fL8EaR6V0Mt9P05f8ZOtYoPnyEIcRfNypunFeF7n/IMWNa7IK/OckG/hAvbe+DWoNeHJhw/piyFFmeW+YcrC9BprPURc5OyVZldC2abvjwdpElg64IhRNiJvm8g+WhE/fF6tsMBIIJGzL4l3fwmzL1tHrFLelARr11Yux0yQrDaCDNncp2o/DxQfp/6m2F3Iz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C4258172A4C5145A4A905D2EC178465@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 709f8e70-dad7-4ca8-de16-08d75800cf38
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 21:34:39.7778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FgA10NcBtqav19IyzDyM7mka++xTq4mo9P8Zc8zU7GfLXMfqLSZGKeXOaiB8oW5WQ5I7RnquuY02KPeT9xbJF6BVd4gLBePQkD/UHwAd/fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzEwLzIwMTkgMTA6MDUgQU0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gRXh0
ZXJuYWwgRS1NYWlsDQo+IA0KPiANCj4gT24gVHVlLCAyNCBTZXAgMjAxOSAwNzo0NjowMyArMDAw
MA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3cm90ZToNCj4gDQo+PiBGcm9tOiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gUmVuYW1l
IG5vci0+cGFyYW1zIHRvIG5vci0+Zmxhc2ggZm9yIGEgY2xlYXJlciBzZXBhcmF0aW9uDQo+PiBi
ZXR3ZWVuIHRoZSBjb250cm9sbGVyIGFuZCBmbGFzaCBvcGVyYXRpb25zLg0KPiANCj4gSG0sIEkn
bSBub3Qgc3VyZSAnZmxhc2gnIGlzIGNsZWFyZXIgdGhhbiAncGFyYW1zJywgYW5kIHRoZSBzcGlf
bm9yDQo+IG9iamVjdCBpcyBzdXBwb3NlZCB0byByZXByZXNlbnQgdGhlIE5PUiBjaGlwIGFueXdh
eSwgc28gaXQgd2FzIHByZXR0eQ0KPiBjbGVhciB0byBtZSB0aGF0IG5vci0+cGFyYW1zIHdlcmUg
dGhlIE5PUiBmbGFzaCBwYXJhbWV0ZXJzIG5vdCB0aGUNCj4gTk9SIGNvbnRyb2xsZXIgb25lcy4N
Cj4gSWYgSSBoYWQgYW55dGhpbmcgdG8gY2hhbmdlIGl0IHdvdWxkIGJlIHMvcGFyYW1zL3Byb3Bl
cnRpZXMvIChhbmQNCj4gcy9zcGlfbm9yX2ZsYXNoX3BhcmFtZXRlci9zcGlfbm9yX3Byb3BlcnRp
ZXMvKSBzaW5jZSB0aG9zZSBwYXJhbWV0ZXJzDQo+IGxvb2sgbGlrZSBpbW11dGFibGUgaW5mb3Jt
YXRpb24gZGlzY292ZXJlZCBkdXJpbmcgdGhlIE5PUiBkZXRlY3Rpb24sDQo+IGJ1dCBJJ20gbml0
cGlja2luZyBoZXJlLg0KPg0KDQpJJ2xsIGRyb3AgdGhpcyBmb3Igbm93Lg0K
