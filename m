Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87244CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D7B20679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="RPTyTB2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfKBKen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 06:34:43 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:9272 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKBKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 06:34:42 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: eZFV9Z7cC5N77olVT2vaTFMlpYSIYt+CUhS7uQcnChYQz+8GAPRIpv1M8opK+PSyQrmC8vGhUI
 aDkz9v03jpiqlpfFkje7+vCh+YbtI8+uPVu3s+cvHgHTnVOdBZ/BqAQdYt5Tc/ZI5D70tD8i01
 bnpm9Fex3dfRerX60vI13/sJ2OctHI79XwtNzryPl5YZqY90iW1e6WZYly0bp+/znt06lVPPUW
 RAHsT59d6EOPj4dt5BF3bQV1R27fGUS88K28pjyQHbwbVX3/NoxZgYj0s9ivFLMv5QMWPsZMA1
 MpI=
X-IronPort-AV: E=Sophos;i="5.68,259,1569308400"; 
   d="scan'208";a="53867316"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2019 03:34:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 2 Nov 2019 03:34:41 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 2 Nov 2019 03:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB21Nvp5azl0E/e4GCZ0dMOtFUHs1c6YYy5l2OE46OXbpVb90qLkjoPqoH136uVDP4KxRPuxhHoL8x7VE690DbbeHeEFVO5s71E+zDkumzFBiyBYUOalPN6sH97AsqHWvJXvzYJZjlvCUgB8+I/CrOw0zrzyk8qw1pceyA1C+zBXAjeqUbxhoUNCyExahD9M9bA1PBoYeVbUM5AyS+OaGrKDwettEW+KYN6JUsJeUjjG9i3+iM7gqhF1Uf8YOvAYbtcGbUsIrB4CuqBPm5UKBSDTQvQaGoI1O59HvXLAGJx2ZsfnT1JDVF5L2aB9dr6AX9OPd9ZIETtLa2fYaMHpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slCIrUVzIjgmcOfZwx8hOmzpvLn2RwE2SyARnryqe6o=;
 b=LlngQiHbd/PZEv1UL2mOL3q1CojAHBE/CxQJ0NSgO8s5mJ8xL91bqvcfFM4nJGoFZLn1YkhhmE9I4KK9e8Zq7PlglKo6q595iAeP4jFIatZHPSWKRXBvMgdQqlwjIyJRCJ6t/tboa7Hz3lqVxR1Bh+vctTv2p4J5pMVVR+ESemLYs77NcbJk+7PMYwCq5nJbJYj9Fv5isbbdUZcEbqztk78EyZD1VfkHSwdogf+l3NCdJ+7xDym5PyVnNVuYwVUJJQfqVyPekKjo11d+VJ4GLC/GTPH5+JTc/5iROSW6qBCMHb4P9XhgcLEYEd+GULQVR3veAegr9oM4GcNwAQnRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slCIrUVzIjgmcOfZwx8hOmzpvLn2RwE2SyARnryqe6o=;
 b=RPTyTB2ly7Z92rU7Cxg/b7wisXa6s/2YD7PzAKgWu3s+v/KI4Qp+CASArCiH+gu86iw52ON9UXQD/ZDC3Ctn1bzea80YXQL3I2N20Sf3F1E72ZQ9suVFmLm4hjeZdP9G2VdxZRRKtBdpJ1Zdii+K009ePGldKC69oV6w/vuKrMg=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4223.namprd11.prod.outlook.com (52.135.37.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.25; Sat, 2 Nov 2019 10:34:39 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c09c:36c8:3301:4457%5]) with mapi id 15.20.2408.018; Sat, 2 Nov 2019
 10:34:39 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/32] mtd: spi-nor: Drop duplicated new line
Thread-Topic: [PATCH v3 02/32] mtd: spi-nor: Drop duplicated new line
Thread-Index: AQHVjkpcVF6t47BCbkObuhpxXRw/Nad3taOA
Date:   Sat, 2 Nov 2019 10:34:39 +0000
Message-ID: <444e0646-6593-be04-3c28-3f2e6f00caab@microchip.com>
References: <20191029111615.3706-1-tudor.ambarus@microchip.com>
 <20191029111615.3706-3-tudor.ambarus@microchip.com>
In-Reply-To: <20191029111615.3706-3-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.120.239.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f02fc4ab-51e4-47c1-a56e-08d75f804399
x-ms-traffictypediagnostic: MN2PR11MB4223:
x-microsoft-antispam-prvs: <MN2PR11MB4223CC388FEDA5B23B43D154F07D0@MN2PR11MB4223.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-forefront-prvs: 0209425D0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(199004)(189003)(8676002)(6436002)(5660300002)(52116002)(36756003)(81166006)(81156014)(486006)(14444005)(71200400001)(256004)(7736002)(229853002)(71190400001)(25786009)(476003)(99286004)(6486002)(2616005)(54906003)(558084003)(31686004)(478600001)(3846002)(6116002)(2501003)(11346002)(305945005)(2906002)(26005)(446003)(14454004)(186003)(64756008)(4326008)(6246003)(66066001)(6512007)(31696002)(110136005)(53546011)(6506007)(76176011)(66446008)(86362001)(8936002)(386003)(2201001)(66946007)(66476007)(66556008)(102836004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4223;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3m5XzzfBHk/r9hcTuN1hGNlz1xR8h97IokxneCZ9VZdYELaBSax33b4T0DsZsULuWVJzHRWV+qS8TGsqJbOHvR7SjxfQXyg5jV2ettjEDpmWQO+I93Fm56rwfNDq6ntnf45pAsUAHLFr4XesHcFYkKYG7CFOLjrZAT99ihBjQQM8Yhdx0kp1aM38coclzErXCczuoATMHc/8rjSCaYJBbuhNty7jg/9VTNCkyjYjI5VqfpXw8NcAokG0QIvx4l6rXdkzWPB2OZIOeflroj6XSu9t+4YoZjXeZ1msqPzAclbQfMce4qleSUZT5xK79WEacEQFUbR4Usyk2Rr7z69Qi8agZ7oIogTduEI8iR5qqUPLsceN1vNF0vY6KoUJmws/zjoSG8V1WWq4swxndW92herSYoE8M9rjJwa+1Xosie8zkkPmXigOMcf8T4FhGfTJ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F01F6B5BE3A214CBEAC0A053B746C58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f02fc4ab-51e4-47c1-a56e-08d75f804399
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2019 10:34:39.3238
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwyaU/oFdAgAraGjWzsXSOiJrOxz5lkWtrxczkaS4tOpaNdckni6wTXmpVpqEmexRXRJiFQssGNXyZNRL7TxGqkaEz5vMmWvBa9UAXwMjZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEwLzI5LzIwMTkgMDE6MTYgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+IEZyb206IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IFR3byBuZXcgbGluZXMsIG9uZSBhZnRlciBhbm90aGVyLCBkcm9wIG9uZS4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDEgLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCg0KQXBwbGllZCB0byBzcGktbm9yL25leHQuIFRoYW5r
cy4NCg==
