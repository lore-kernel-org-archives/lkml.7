Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5864C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D4E206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="lb3ti/Ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfH0HB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:01:26 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:41744 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfH0HBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:01:25 -0400
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
IronPort-SDR: CoUl2YsqhnZ+bKqT5y50wMX+3jbSv5PCSuLb6wwKAMbJk0STnQsfrV8Hu3gFV4K9tTKgliHCtv
 YjvGuu3vpIQtjSiSwf4whJ/3G+ZtePegX7KqmTGGbvFPRTyfAhioqw8mB6exnVIfep9LCSpfAO
 2pk0KQaK475TrKWJE8jHOzresGCKfTz/0NfPp1EDpJK8BXmWm3kHiuwdxBH2E4nqy8xdW3s8QT
 U3cHR3Qfnef3NYkhKbK8754UaMLfpXQm9PTbtq3n01R393QpYctpQCGGAaF2Bbx0qaxanvB7XF
 ERw=
X-IronPort-AV: E=Sophos;i="5.64,436,1559545200"; 
   d="scan'208";a="46635894"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Aug 2019 00:01:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Aug 2019 00:01:24 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 27 Aug 2019 00:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjJUtuWv5s6otDLRnjSnNmywamW6PmWliaxLOQSW2qsHC5NfgvLTgUdN5xRzea3sH8bV+96i+mPC+RPMfYeTNwrrvUeuHwAkmnYVRaK+13Xx+mK/TD/AYMHf80iFrkSXOxkPSahBB4WhDzZujKD3TG73U4J6xObm5escQOypkxsUylBcPP7yGJpdSGb9e5sUxhI5GP8KnXQZ7Lx+aPxKWH5KORmALZnUoSmT0HAy2hqcWdya6NJlJbpFlW7wuI57CCLad58KqP8yZMhdyxPuYdgoEY9J7fh8nUFp5YV2ShmlbK9SkFRe9IPvNtO4fwhOkrV92t4K03Giv5o3sdppKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GrkCp5+FQ7R6Q5sa7xHUnpngqHXF6IVB8ek4lfOsCw=;
 b=G3Citt2UW1QMF9hwjC8uYU5gM/7NZC0sGqR5/PRuYqIDCt1q2jj9q4EbPGWLKgVnj8CquC8KIQKA4oH2mX6t66jHC0e2fGKHJKc0ybLoQWI5TE173BB66OOK+yhxDb+BFw4679bknpSF76Wp4gM7tiHa/iepaKClTonYj1XvOeUa6qf7ia76U6o0Xbhs9LzwgK52SeZaE2is08oV8FaXUGJkYsraXMT+/sDXCkXRhkvCskIS53ca9fa/KjE4PvV/kueLXI2pSL128cc+GcbwA5yXGoCVLvWFbvCwxXBq+dRiuL4ZYs6meX76L/ZI55s3TxxVUTPUgyFngjmMMOO7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GrkCp5+FQ7R6Q5sa7xHUnpngqHXF6IVB8ek4lfOsCw=;
 b=lb3ti/AyA4FNWAeG4POq/eMjrDoJvG36A/hGbQ86nBuww0UoPjXJfihwfrxlBJCQ+t4l3jzLRV4y3FTV9jI1pyy+haf2hIfowyXgqovtN6uAbVkR2142yGXvUAgxgeomVnFbk/g/oB/81r/Q5UZM7vS6wVsUkX24mhSHTeNSJl4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4269.namprd11.prod.outlook.com (52.135.38.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 07:01:21 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 07:01:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH v3 08/20] mtd: spi-nor: Split spi_nor_init_params()
Thread-Topic: [RESEND PATCH v3 08/20] mtd: spi-nor: Split
 spi_nor_init_params()
Thread-Index: AQHVXAcDwaG7sE2Oh0OnT95bpkTmoacOgUYAgAARG4A=
Date:   Tue, 27 Aug 2019 07:01:21 +0000
Message-ID: <8130623f-c0cd-bcf1-5dba-0a31a367c90b@microchip.com>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-9-tudor.ambarus@microchip.com>
 <db529e35-801c-efb2-1f05-922fbcb98aef@ti.com>
In-Reply-To: <db529e35-801c-efb2-1f05-922fbcb98aef@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::32) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 624f08d7-80fa-4f27-64d7-08d72abc5e00
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4269;
x-ms-traffictypediagnostic: MN2PR11MB4269:
x-microsoft-antispam-prvs: <MN2PR11MB4269584B6613C9C44FD1005AF0A00@MN2PR11MB4269.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(8936002)(66066001)(186003)(305945005)(102836004)(110136005)(26005)(99286004)(7736002)(36756003)(52116002)(2616005)(81166006)(229853002)(386003)(3846002)(53546011)(8676002)(2501003)(256004)(81156014)(486006)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(6436002)(6246003)(6116002)(76176011)(476003)(2906002)(71190400001)(14444005)(11346002)(86362001)(31696002)(31686004)(25786009)(478600001)(6486002)(2201001)(6512007)(14454004)(71200400001)(6506007)(558084003)(446003)(316002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4269;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rm61Z47U8Xxfo/GxWO1d0vI/wAMjyyB6eCYHKfDZYTnWX81YPhGAX3dXsFb5KvIhpG1dnio7ZlRdLSlewVZ7TDH5gA/E67phL3aFAP8fyZ3zoq5cXGuEas6GlMFLBxI/On8rozlqZ0rNZnjC0ZjakyjsJ8KlG9WKHF3vTTTOnn5cwPmvquKCFnRIBkXlsZF8Q+C4ykpwKWqYcPHdcGfrki1GwawguCb0WFiSbVtXCJi/cMFiQ6fvIIqXV1aburNjsiB+U8Kh7Zwn/BzDIT74agCdUqoxxImiGcnfm50wlx2fvuRkt4RCOHO7TztdKlUWGrJDHGSpeOEKp8H4MK1SDrEZR3xpBGzQk/6CGodLdg4etdSg3VwsHOULsZw0WExUELcRamYpkqD4JSregbZSYgxvs2jaMJYQ69xiUcXAB/8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADDB29CFF4B5F244B00E887033FB1842@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 624f08d7-80fa-4f27-64d7-08d72abc5e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 07:01:21.7605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCwRRN6TLHLy4jsWrNOQr0DXrVvUCxhPn3TUgzceg0CHxnAzfQWMe9n3DNZ3pME7RZKvn26IHPN2s+s6OELiPC1YUu+SknsbSz9S4QFEKeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4269
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzI3LzIwMTkgMDk6MDAgQU0sIFZpZ25lc2ggUmFnaGF2ZW5kcmEgd3JvdGU6DQo+
PiArICogICAgUGxlYXNlIG5vdCB0aGF0IHRoZXJlIGlzIGEgLT5wb3N0X2JmcHQoKSBmaXh1cCBo
b29rIHRoYXQgY2FuIG92ZXJ3cml0ZSB0aGUNCj4gcy9ub3Qvbm90ZQ0KPiANCj4+ICsgKiAgICBm
bGFzaCBwYXJhbWV0ZXJzIGFuZCBzZXR0aW5ncyBpbWVkaWF0ZWx5IGFmdGVyIHBhcnNpbmcgdGhl
IEJhc2ljIEZsYXNoDQo+IHMvaW1lZGlhdGVseS9pbW1lZGlhdGVseQ0KPiANCg0Kd2lsbCB1cGRh
dGUsIHRoYW5rcyENCg==
