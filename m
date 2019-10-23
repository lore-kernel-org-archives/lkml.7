Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A6BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE002084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iVKvUl8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392122AbfJWVZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:25:42 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:59011 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392012AbfJWVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:25:42 -0400
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
IronPort-SDR: 9THn2kmwp5J212zXQahLtbWMyrI35OIdW+awRSDMAx84zgHN3jfsYF2t4Ki3yeSK5zmmp/0XvP
 D1NEeJYWR3BbSfqLC1UeE32pe0PvzVd17abx72A333UF+J3OMGe95CzVu/r33OQyoMsGkrGcwG
 qOlfvwSChVQSXDuDY1wrzNRf6L5cu6NsHbWMkCaDlWOKUf/5rKE6M94uWhjhBFXgtnWN6riTqD
 pZF4ngSHUFFFaf6iPbitP1uVQibiDt5YhfxhaAGlWlkhJum/o0RIhtrnhd3Qq2l0hLJAlzx4Ck
 zn8=
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="52725911"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Oct 2019 14:25:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 23 Oct 2019 14:25:40 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 23 Oct 2019 14:25:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRQw5tFtIUIrjcWuQ15by+I9mPYvtpgJg80qbJhdUN+tKtjJszfC2Rms3tdal9zKqVAx5wCcqnb9P53Rg594NG9T/uHZQbdXJaxjNFaIvZTnlFo9F//Imd4ZAJVP90yTyKCQckcAF9kBBLBTRIi/jjUHXgfXue3F1cAjn8pShPvQxuKXlw85vU3jxOWJQ8aJlXvRyMLr3X3uIEzgcR/QOQLF4mWbtvpYdE3smV2wmDkzVIGA40Wy4msYeivQz4mmzBSM4kyGY1IrYcJ7t5sTY8apNMLhaxitwo8RT8A6+iio7QMKcmeq6CvQfKo+Aw062j2kCm9H0fWD7sr+mJnx8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VblfyDx2y1jXOJcoC29e6DXPe1HvRb+PV61Z83yJrIA=;
 b=K89ulAd2nCV3oX3LgznlrX4SSo8iRCa7DFYEIqni5wh+nEa244zRyceFfe75d42gJkKLbp7hHxPrFrB8ee28LPce+HnnKk+BgUxuuBywliRi8asl+opW55WBEIzPyIse4qPunSlXk1GA1WD+UPKeYWlAYiaqouSh/XGmEL53957UAvsO+GAd/2sbC6VsKRdbsKLjdeKt+orRY/O/dbMvBwqYyySV9gE/Xe3mEZ/nGz3Zh2H14XOOo+QRxNqF1r50ZkHCxSO23WBkpmtD9lt9tjQvS8/vNuQBnQPLJXDHPNTn8HA4W4o2kKBMOB83VSkR1k0+J5aeihS6WOFlXNu0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VblfyDx2y1jXOJcoC29e6DXPe1HvRb+PV61Z83yJrIA=;
 b=iVKvUl8OGu6wWD/xkMb75zVru817vEPOPeQJtt1HX/4Dep7rwttrYlobELHyUwLAMG03cX6NqePa+CyrAFvxGfi6lFMKeKz4aMnZEz1tbBkvixjowopYZQE/vdY/N9+5aoX8zgqjpSQ/+0+dLWCeCAyDBv3ivi2eedieLh53PsE=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4349.namprd11.prod.outlook.com (10.255.90.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Wed, 23 Oct 2019 21:25:37 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2347.029; Wed, 23 Oct 2019
 21:25:36 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 03/22] mtd: spi-nor: cadence-quadspi: Fix
 cqspi_command_read() definition
Thread-Topic: [PATCH v2 03/22] mtd: spi-nor: cadence-quadspi: Fix
 cqspi_command_read() definition
Thread-Index: AQHVcqwajFKyuDqBQky8we7iWaMUrKdo620A
Date:   Wed, 23 Oct 2019 21:25:36 +0000
Message-ID: <fd618129-2844-290a-64a2-b68e7d03ee1f@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
 <20190924074533.6618-4-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-4-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9431ddd9-a31d-41dd-65d4-08d757ff8ba7
x-ms-traffictypediagnostic: MN2PR11MB4349:
x-microsoft-antispam-prvs: <MN2PR11MB4349CC2F1216DB84D2C2515BF06B0@MN2PR11MB4349.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(71190400001)(446003)(11346002)(71200400001)(486006)(476003)(7416002)(8936002)(2616005)(66066001)(66946007)(66556008)(66476007)(81166006)(8676002)(66446008)(64756008)(81156014)(7736002)(229853002)(25786009)(53546011)(186003)(31686004)(3846002)(6116002)(36756003)(54906003)(110136005)(76176011)(316002)(99286004)(26005)(6506007)(386003)(102836004)(52116002)(2201001)(6486002)(4744005)(2501003)(14454004)(4326008)(6512007)(6246003)(86362001)(478600001)(31696002)(256004)(2906002)(305945005)(5660300002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4349;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiuJS9HHMS/K79RB4/0xrK8ighm42U3YVRqPQoUTGNktaZFxkSA1uWaQOIdAhW3nLKMfJLv/y5lrw0/SCvHfz5MfuvEzgRy+FBQGH0vh+wHZ8TqyRDoqABzVgTFAQlXEG/Q5rT+iPJtBlZ+As6+P+jlNGqnJXUVKAck+98aQkmJuuxcgv6FlH59Y9H+Rn+4zCpSAYrfwFpSjvrsxbWxXrq+W//cnLSd2I2ZgvucEw8f4aFhP9Aq6DGdXWJ9RjML8qMJeNlWuY7Bn3MfFYCtkIlZYfGTyiDEHEpUlrAwRZw97EPZt8esXheTbH6nGa62PEPCARyfSJwtmd5k7VmGUCiHBvXhVDuLFKG6sLNu9eftwPQKGTTFciTMefBUbigQM/lMelp6CnElMFA+4tFArRLGxgxuCl4UmKbraQGSh6ChHsiDjtKoLl+LLovFkJTRy
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <58C8278D6223884D915B224D264B1FE7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9431ddd9-a31d-41dd-65d4-08d757ff8ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 21:25:36.9244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: om4XFLf+l23tcWCbc4oUqwAtDiSN4YmR1u5pK1ECuM292x2ZngMGdSiPRIm92jHyp5AUVwaBL1hDNT2pJ7PrAgPjShG3qa2kbLjtrVN0JiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzI0LzIwMTkgMTA6NDUgQU0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IG5fdHggd2FzIG5ldmVyIHVzZWQsIGRyb3AgaXQuIFJlcGxhY2UgJ2NvbnN0IHU4ICp0eGJ1
Zicgd2l0aCAndTggb3Bjb2RlJywNCj4gdG8gY29tcGx5IHdpdGggdGhlIFNQSSBOT1IgaW50ICgq
cmVhZF9yZWcpKCkgbWV0aG9kLiBUaGUgJ2NvbnN0Jw0KPiBxdWFsaWZpZXIgaGFzIG5vIG1lYW5p
bmcgZm9yIHBhcmFtZXRlcnMgcGFzc2VkIGJ5IHZhbHVlLCBkcm9wIGl0Lg0KPiBHb2luZyBmdXJo
ZXIsIHRoZSBvcGNvZGUgd2FzIHBhc3NlZCB0byBjcXNwaV9jYWxjX3JkcmVnKCkgYW5kIG5ldmVy
IHVzZWQsDQo+IGRyb3AgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0
dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5v
ci9jYWRlbmNlLXF1YWRzcGkuYyB8IDE1ICsrKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCg0KQXBwbGllZCB0byBzcGktbm9y
L25leHQuDQo=
