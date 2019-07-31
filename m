Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30934C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B0A2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="tznrjo8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfGaJSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:18:47 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:59231 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaJSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:18:47 -0400
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
IronPort-SDR: rFdZd/Ccc4x/EpAcMEw/IW6VuSszbYbBbTQaVu0veAR7K08o4+4wu/WUA+w0qxGEoFs0nKgf8E
 S9hqK52CJCU6k8cGRV6MD0KKh4ztrV3ujtZVr+hTkVy56pWyqM3UU/2ji/eo9Qy5fg8PaQYdzB
 Q0cGWuS6sd5XuOeWmm1Bc5uTXtxRqbx7MiThtF0aGRYcjw4t2U6/lBhf9DwLh4KbqOY+aiMHDT
 4GtmkXJ5PfJ2NAmLIVik/Z0wW5nq4qL2y/OVJ+0OVV3T+3OhNLRPbT8dhAmiuHMUQq7AvLGiQ3
 4nk=
X-IronPort-AV: E=Sophos;i="5.64,329,1559545200"; 
   d="scan'208";a="43421638"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 02:18:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 02:18:45 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 02:18:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl5IP+tmojPsH9liMvYFC4d+MjStyyOceOYI0RK6OlbyTiGpiMABSh9vCBe4qfdLhAIDS41v8GRY1nL6hC815Sk8fSyg28RbSqMWOy0pDULELnl0IduGY9bEkj0Hk9WYggcohoYjXJSF7wKrF/Bc1U/n/1IHoFy2PnyxBOnQ4KhLfjyVbzWn1RiCIViC3XRhpN45bXIrJKZSvbQzPrjVBzL97mgMc2ro3lOZTVTptAk+pScrM0OKZHSJxJpY77MMJsJp03Tqo5j4lt9i4KD4dIH1NcNNPpODE1kqw8VVOA/jUWBPe6eSIh9x2ybFk7D0H/2ikqpelHLcRy8xGdoBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIuV1y0Ok4qaGA/Xv7524QfFmmvYGI9fBa0jqdwSb3c=;
 b=DhHO0+0wQBmMPSh+949nlpREt/jttCnQRFWXWcC5P/2Bsy6DEFUiqN6Y8D/0unJf7L6irRQNyqQuI8iOvQ6V57VtgAYouBZ/AS23pwb2FTyzxYoPB3pyyKRo3rTImMv/PCT1plVkhL99GelUidPwiAn/9DrNOrHRV2PEfX8O2QSCjBEZTdQaYVDebUNUdQ1XG5OpEVnNZx2n28G3dwHO28oOQYGlGinWWphVrZC3BiRA/0x0t3THp6fEgT7hV4sYUJ772H0b9dzQgh+1MgUXcs6KzfTq3Pyi2OMZFuieGHXKZkNL32HOgb1GqX89mCm7zyhjFRCgNyIMa6n+yKiNsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIuV1y0Ok4qaGA/Xv7524QfFmmvYGI9fBa0jqdwSb3c=;
 b=tznrjo8lpcJvuQFx+5Qik+xqFfjZDiBFfvh8AoX4gei8Khv08tPYMSUstdi6ngvPojDDusELK1dsHWxXQFnlhNTSwT/hBGL3w58TjklYNTYixefaf6aRsLnaew/lVquQNfnBJfBzBGKnBXT3l3IIRCj7PgAqeoMzLiljje9zmWc=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3680.namprd11.prod.outlook.com (20.178.252.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 09:18:44 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::61d1:6408:89a2:8de5%2]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 09:18:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/3] mtd: spi-nor: move manuf out of the core - batch 3
Thread-Topic: [PATCH 0/3] mtd: spi-nor: move manuf out of the core - batch 3
Thread-Index: AQHVR4DzkdnDBHM51E28yzlxVcnvaw==
Date:   Wed, 31 Jul 2019 09:18:43 +0000
Message-ID: <20190731091835.27766-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0079.eurprd04.prod.outlook.com
 (2603:10a6:803:64::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bceef638-0a9e-4005-4168-08d71598157b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB3680;
x-ms-traffictypediagnostic: MN2PR11MB3680:
x-microsoft-antispam-prvs: <MN2PR11MB3680CE1304FDE857C3DDCBA8F0DF0@MN2PR11MB3680.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(8676002)(81166006)(4326008)(81156014)(53936002)(7736002)(256004)(25786009)(68736007)(8936002)(50226002)(478600001)(6486002)(2906002)(107886003)(14454004)(2501003)(102836004)(86362001)(6436002)(71190400001)(71200400001)(476003)(1076003)(305945005)(5660300002)(66556008)(66476007)(64756008)(66946007)(2201001)(66446008)(36756003)(486006)(3846002)(99286004)(6512007)(6506007)(66066001)(386003)(4744005)(316002)(6116002)(26005)(54906003)(186003)(110136005)(52116002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3680;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WgLz3X6OELVvUTS6sS3TgoVzgysMoyKomWYWVC0f8tsKs9Xp/Zp0iwI1rHNEtXnOkV7e4pvImCkiqiNMv57gj51JBCT5Z/7tcIxBtmcmvtoBxcmEhowLJXS7BIx530O8lZAejn3H/1t7cjiJpmVRRMgR6v8ntUAOatNN//1p3EE2+Xtw0+3K85X/Q5HyBKtpcGoxGQwJ2kedB/g3aQZz+O70Ew4lZT8JmYWglNRnKImj4HvahzUL2xarxnuQsgvrcUFGoUrXZ9eMCPqG3JqCvc00TX3LflHvCsWGv6iUTgJOU/j3/0L3BXhLxL6w0EtKw7OElG5+mIiCXWUBArL3y69I/rlAchDSzAnAizAUfL/7A7iuWxLjAzaFwIESSQ70jpbsqU+IcvrwAQFJHBedeUgPxmDtPeNFsOEy8cQolpU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bceef638-0a9e-4005-4168-08d71598157b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 09:18:43.8057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tudor.ambarus@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Trim spi_nor_scan() huge function.

Tudor Ambarus (3):
  mtd: spi-nor: Bring flash params init together
  mtd: spi_nor: Introduce spi_nor_set_addr_width()
  mtd: spi-nor: Introduce spi_nor_get_flash_info()

 drivers/mtd/spi-nor/spi-nor.c | 129 +++++++++++++++++++++++---------------=
----
 1 file changed, 72 insertions(+), 57 deletions(-)

--=20
2.9.5

