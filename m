Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB06C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C8B206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="TrqlOUjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfIPJMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:12:55 -0400
Received: from mail-eopbgr750128.outbound.protection.outlook.com ([40.107.75.128]:21477
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbfIPJMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSLEdNW7NZu/IklVfeym9ewSC8hfZqG2/9gNVBac0G441xzVLJ2GrDgs17Q9sjCIyr4qlJeW1qN4tIWx+7wjgQ8MIB/r2+iHhS5Rm1z/NQsquw+dGLL7lwQYtqv9R6+5ZLXkFwKivb5N+HKYk/7ua/XK7tdBh0J7tikXC0G5lGbNvNBBq/Teesll8YCXfIxzN/IVn1WgrzPaU7wG2mCazJKt6j7HHxB8qLrgFd/FgM9GOziSNWMfJUjK5x7EUkbN90g6PgmlqZCMoPwNuAfNaW+fScd1nHPm64Zd+/NEXWkGUBhQVk2GckduUewkIbSa8LYLAhfDdHK6OC3n86cpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djPj4eaSZoknIPAxYNMg0GMn5trin2E7v//61gSgeAo=;
 b=QXUu83mzMmTx00MWfxl1odbj7LZPk3cJEVxuUA9RvkULVNnsd3vyjIZxpLfwtz0j75+J84MFIKxfE3drXWumN69V41msOxz+nFE5c5qtWZrGh/mms+ZGd4f8bSXIVy7nN1N2GYgkdxkYSd3t6mIllzW6JQrrIDrTZJEJKQH33Dp1wT2SYK9lb1y6CZYRxE2YVEHe1Ez2PO+Jxf4g5mZRdKL13BR98ZrbedRgxTPeTbRLONIvitC64UpdazDACIjXfID8EA9f1y1dTSaFpJeaWsOCxwcJbM+85wA4l62wGmxb3BNRmu39/RLJbJWHneqqsv+kiJD6UL6ICc/GjCngng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fortanix.com; dmarc=pass action=none header.from=fortanix.com;
 dkim=pass header.d=fortanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector2-fortanix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djPj4eaSZoknIPAxYNMg0GMn5trin2E7v//61gSgeAo=;
 b=TrqlOUjRLR5NwBoEKF89QZH4JypmM80iQxYNr4cAY129b3fGn117ZgpORMhuMPyFfCC3lLYBgK1R4qZHMucrrYGGVZBS/auAI2aCLWWW6BTcI9+7VdXh6PTndKrrjDuY8VbJupdPIqSCI/9FxQkFIKFWcQi8I97Pyd0H70DNLNg=
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com (10.173.174.144) by
 DM5PR1101MB2347.namprd11.prod.outlook.com (10.173.171.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.26; Mon, 16 Sep 2019 09:12:50 +0000
Received: from DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42]) by DM5PR1101MB2348.namprd11.prod.outlook.com
 ([fe80::798a:dabe:a59f:bb42%6]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:12:50 +0000
From:   Jethro Beekman <jethro@fortanix.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Topic: [PATCH v2 1/2] mtd: spi-nor: intel-spi: support chips without
 software sequencer
Thread-Index: AQHVYr406/tKUl7vTUifobCqeM8uGactRn4AgADRmYCAAAA5gA==
Date:   Mon, 16 Sep 2019 09:12:50 +0000
Message-ID: <e284a2a8-1d4c-2b57-642c-c91f39a5ee99@fortanix.com>
References: <69f4a8e8-7889-8b00-0adc-7faaef6b42e4@fortanix.com>
 <32ab6570-c3b7-4eec-7a0b-69bc2f7f76dc@fortanix.com>
 <20190916091157.GR28281@lahna.fi.intel.com>
In-Reply-To: <20190916091157.GR28281@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR07CA0126.eurprd07.prod.outlook.com
 (2603:10a6:207:8::12) To DM5PR1101MB2348.namprd11.prod.outlook.com
 (2603:10b6:3:a8::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.15.248.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bbcd751-3cc4-48d7-cfe9-08d73a860c7e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7193020);SRVR:DM5PR1101MB2347;
x-ms-traffictypediagnostic: DM5PR1101MB2347:
x-microsoft-antispam-prvs: <DM5PR1101MB234715258A2DE80ED75737E6AA8C0@DM5PR1101MB2347.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(376002)(39830400003)(366004)(189003)(199004)(36756003)(8676002)(6436002)(6486002)(229853002)(53936002)(7736002)(305945005)(6116002)(486006)(2906002)(6246003)(256004)(81166006)(8936002)(3846002)(6916009)(446003)(11346002)(2616005)(476003)(25786009)(4326008)(186003)(316002)(6512007)(81156014)(71200400001)(54906003)(14454004)(71190400001)(66066001)(7416002)(31696002)(86362001)(52116002)(5660300002)(4744005)(66446008)(64756008)(66556008)(66476007)(508600001)(26005)(6506007)(386003)(76176011)(102836004)(99286004)(53546011)(31686004)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1101MB2347;H:DM5PR1101MB2348.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jF6zhgujQH7wBviIwi7y0LzD1kmKq62OLokSdUXs57wq162BmQAW9SAGQn6ViCkC2a+9G0C8Fi5+d4XRIPq72KWay6Dn8n/ML7jIIOmcC/bdJeUZfce+iUT7cIWgoZ09DxXNU8M6579GPBN0uA88m7fTazSZZMiMjQo5Xf8zZ2I7eeaO4Y3iRLw6oGDg21Dl/AxNMdo0qenay4wGi/vnpYuM+fT5gspvFEDPo+WoGYAYFBMRVB3oZEV652CiDv4hn2Gjpuu81pe4lE6Vs4RkrEFrE0UJKzGAWnuddUuqyEdz2JCub22yPynhZmusMdGFnMcNMRqSW/fp3OghnbbElaHQhNOvdgVQ6x4uoVwzEOxUp/cuR//6LEms7qLK9c1CzO2X05h+zAxDHpZVBlDOAM+IXBAHYtaFTS0kLotX0fM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0450FFE4B2247F4290F6FAC38CCBCD2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bbcd751-3cc4-48d7-cfe9-08d73a860c7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:12:50.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F2sPyKaPCHBqSujPfwLwyulNXfZy/12LHbG/8LshVxOCiN8HTqWqBHjC6Mr0n7px6Wpp1LRJdq7wpLT1Pd637Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2347
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wOS0xNiAxMToxMSwgTWlrYSBXZXN0ZXJiZXJnIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IE9uIFN1biwgU2VwIDE1LCAyMDE5IGF0IDA4OjQxOjU1UE0gKzAwMDAsIEpldGhybyBCZWVrbWFu
IHdyb3RlOg0KPj4gQ291bGQgc29tZW9uZSBwbGVhc2UgcmV2aWV3IHRoaXM/DQo+Pg0KPj4gT24g
MjAxOS0wOS0wNCAwMzoxNSwgSmV0aHJvIEJlZWttYW4gd3JvdGU6DQo+Pj4gU29tZSBmbGFzaCBj
b250cm9sbGVycyBkb24ndCBoYXZlIGEgc29mdHdhcmUgc2VxdWVuY2VyLiBBdm9pZA0KPj4+IGNv
bmZpZ3VyaW5nIHRoZSByZWdpc3RlciBhZGRyZXNzZXMgZm9yIGl0LCBhbmQgZG91YmxlIGNoZWNr
DQo+Pj4gZXZlcnl3aGVyZSB0aGF0IGl0cyBub3QgYWNjaWRlbnRhbGx5IHRyeWluZyB0byBiZSB1
c2VkLg0KPiANCj4gQWxsIHRoZSBzdXBwb3J0ZWQgdHlwZXMgaW4gaW50ZWxfc3BpX2luaXQoKSBz
ZXQgLT5zcmVncyBzbyBJIGRvbid0IHNlZQ0KPiBob3cgd2UgY291bGQgZW5kIHVwIGNhbGxpbmcg
ZnVuY3Rpb25zIHdpdGggdGhhdCBub3Qgc2V0IHByb3Blcmx5LiBXaGljaA0KPiBjb250cm9sbGVy
IHdlIGFyZSB0YWxraW5nIGFib3V0IGhlcmU/IENOTD8NCj4gDQoNClllcywgc2VlIDIvMi4NCg0K
LS0NCkpldGhybyBCZWVrbWFuIHwgRm9ydGFuaXgNCg==
