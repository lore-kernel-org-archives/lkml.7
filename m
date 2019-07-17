Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7A5C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6322173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="xFZwS0Bb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfGQIsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:48:03 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:12569 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:48:02 -0400
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
IronPort-SDR: QzGdowYLA48+27nPZvfRV38mTblXx42mexgA5wRTiFfWmC22XBYDNFj+kEYC2cK9q6IcaM21TV
 ur8P+iwkBb1dg/NctKT/9/Ntvko9jPnI4MU7GxdRdXXdr106ivVxHADw9RAmYdFXcQ1BHK63Uj
 2faB5aXbICwrqvo1zcSi9NTeUOa7k268vJQOymqTVYwG2z/xNcCAexPGrSk8iY6BdoFLlH8ymI
 h2h+IUuU7xtq7MaFPopf5TP8iIB6Mzkxzit1CphoYnMpf+KDz4Os5j3K0AyWMI27898+oJtWgv
 cjg=
X-IronPort-AV: E=Sophos;i="5.64,273,1559545200"; 
   d="scan'208";a="41633726"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jul 2019 01:47:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex01.mchp-main.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 17 Jul 2019 01:47:58 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Jul 2019 01:47:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiPmWpZYKZzUYrqH+owOXtQr5UDL0zetXHLDHMDe+kpErRVhwoEucYllgLp+M4R10Vy9ussxy+0QCwX76VYZ+oJWs1hpqghH1sUfuYshdm7zu3DYWbU1kQ/NDL1HQMREOjCa40P9A4kffmH0O4q7h3aJf0wiuJv992CjfJnQkB6mZtyg9raPaFGuQMO/6sdccirOdVv8jWOonH7z7NPdKw0Hee6fJWlQJyTek4CSBJKMo8epc2+Hw99mBecnrq3L/+OtBwoN6flI7KhNyaLpS8e2j295TqNN4cJiwc7h4HYMLjYCxDVXWoHxc9/byBh9nDeJNdTneJV/vvmpQbJRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xu84YWtk/lS9JfP69/HC4gSO8nxDAxKE2idXbpKK3M=;
 b=KHYqzAO/IfcP5PJi8jSQfqZfZMsyDgUTDlwj1mEUHc9X+10Y8nvr+sHM77oRQzAHZo8mEPKNZHWk7ufzs2n11+WO5oYWhCWm+L0Ws0lx29FqKzXonYDxThwa9gftYHMraGDb6ooj3liwOSp3uZjOb731WCycoiqLIZ7EwNwLan5l3s5wIokXe5idVmHGQpRmTwsUB6XblUJVYFVA20ctWqO1CoX4L7BVwEI3N+nSYgfmTUnT1xaTk7nWyNZP4Ce6ML2I5wdIXzamZgJUs7NhtvBjvP7JjM1lmatjrpIlxl9rGw8OHhAXxESUzb4E9hO8nwnUlJf6SlGwGwudXHhszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Xu84YWtk/lS9JfP69/HC4gSO8nxDAxKE2idXbpKK3M=;
 b=xFZwS0BbvT3f3dOcqujCWiqJK1qOQJ6ZOuLVtHUmzJ+QkItYGmVeAVr+nWXgKHc6snl124xECvqqSYF/cK51egQKuQI3pY+NnOYIjxZBWHoaXHt7plKIzdf+do4L1Fjaue/ukFLpUgBke4mBKpGURzzgQtGdGAADd+p2QQDuLdc=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6SPR00MB254.namprd11.prod.outlook.com (10.173.236.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Wed, 17 Jul 2019 08:47:57 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::6515:912a:d113:5102%12]) with mapi id 15.20.2073.012; Wed, 17 Jul
 2019 08:47:57 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/5] mtd: spi-nor: write protection at power-up
Thread-Topic: [PATCH 0/5] mtd: spi-nor: write protection at power-up
Thread-Index: AQHVPHxUB6tYOD3eaEWmYluw6fwWCA==
Date:   Wed, 17 Jul 2019 08:47:56 +0000
Message-ID: <20190717084745.19322-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0085.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::38) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0806800c-877d-4cb4-08f9-08d70a9376d4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6SPR00MB254;
x-ms-traffictypediagnostic: BN6SPR00MB254:
x-microsoft-antispam-prvs: <BN6SPR00MB254CB352AC9F444228CEC92F0C90@BN6SPR00MB254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01018CB5B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(66066001)(102836004)(186003)(4326008)(99286004)(52116002)(2616005)(486006)(386003)(6436002)(256004)(26005)(476003)(86362001)(53936002)(107886003)(6506007)(6486002)(66446008)(14454004)(14444005)(6512007)(71190400001)(64756008)(71200400001)(25786009)(81156014)(110136005)(2501003)(478600001)(305945005)(7736002)(54906003)(1076003)(2906002)(5660300002)(36756003)(66476007)(81166006)(66556008)(6116002)(8676002)(50226002)(8936002)(316002)(3846002)(66946007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6SPR00MB254;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mCfwQ3Uhhm8K7Uox/0erWQQFjhkMefzpXL6y0FhI20caKGsejUMP0CSbnh84Dhnv1NF2+MiLt3J3oegq1AOgCr0ztLSmSR5M8PJ+723BfQSw8kMWPe3oVLd6UWxMSe7vxbhBBMO5QBJCe9dCa+XHg+EtkNSzWufxOx7Q1cuI6PrQROYk7NlElox6/GbgPyqhtxVO93NcGKe0N5cIN1CnGNnE4Mf/FTZss0ke9cvJ0tSX38F2hF9GfE3Lx9CytfVvpkrkozXxmyUxnrJTtBO4LECFAD3lSwarQr9liiQpMPbhikrkPQM96WeGEvSPRAN6aTaidrzXi7G663PifbvD+t84xU9gyNbtdq7S7JjNK5Q6hfc3/JxFum/KO/HZkdNyt19GHxgwF57bUpfsYjPxluHbUVBGI+B0qp/J5iWd5Yo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0806800c-877d-4cb4-08f9-08d70a9376d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2019 08:47:56.9200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR00MB254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

There is no functional change intended for the first 2 patches.

Patch 3 adds support for the Global Block Unlock command: a single
command cycle that unlocks the entire memory array.

Patch 4 unlocks the global block protection on sst26vf064b. This is
identical with what other nor flashes are doing by clearing the
block protection bits from the status register: disable the write
protection after a power-on reset cycle.

Patch 5 adds a Kconfig option to disable the write protection at
power-up. This permits users to choose if they want the write
protection at power-up enabled or not. Backward compatibility imposes
to disable the write protection at power-up, so the Kconfig option is
selected by default.

Tudor Ambarus (5):
  mtd: spi-nor: fix description for int (*flash_is_locked)()
  mtd: spi-nor: group the code about the write protection at power-up
  mtd: spi-nor: add Global Block Unlock support
  mtd: spi-nor: unlock global block protection on sst26vf064b
  mtd: spi-nor: add Kconfig option to disable write protection at
    power-up

 drivers/mtd/spi-nor/Kconfig   |  8 ++++++
 drivers/mtd/spi-nor/spi-nor.c | 66 ++++++++++++++++++++++++++++++++-------=
----
 include/linux/mtd/spi-nor.h   |  9 +++---
 3 files changed, 62 insertions(+), 21 deletions(-)

--=20
2.9.5

