Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E154AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A996D206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="T3PM/Ooh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436611AbfHWPxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:53:37 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:37628 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436601AbfHWPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:53:37 -0400
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
IronPort-SDR: uMyZW3iL4Y3RzzX03C2t6BCNWekDYKcZ8f4X9vUx1mfBmfZe9ahrK5Wf/wzwLXXtqAZNBakt3f
 PI77dORceWaCSdRTXIJtZUgO/fmImQDDg8WQb+8z0SWWlT+tLJIuXQncF2KzEheIk2lGpLnehj
 aanx9otowpf1DvIOL9WnNlEHzPkGc4mtCfogKZQmB/4ST71BfvHZBw9Jg5I7WBj7fnYe21AqUz
 yUgsrYzjNajKwM5u+iGDrAxetG5WF3WEFFDqkiK9q1h5PGDOrwV0PTz6voPEwn3zAwkcF6sJPI
 t18=
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="46398668"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 08:53:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 08:53:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 23 Aug 2019 08:53:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDZ6aDBLhtk0bEtdPPASk/SldBsAglESJi/BUqMxwAwOqOmjnD/Ns9ouaq89egZEgVUS3E1dCW9b4c6JJEC7hL7FQsKCx41wLsTRO+PSSG2Mrk91J6atsAxUYt9Qv93hDy3tU0EeTZFIXzLMajHUTMfqVmPZozPHtrIe/zeVdzih3cWV6Ezkn1GtM4Mdc5TVvCI7DK8Js+nYOxNk+Bp3JIOrIJgQ+oi0rocn4tbLd1k7CNyk48tUEeaCEcjxcwReglRB/jBH/BLxxa4EL/meYuIPY83ysMUi/5aS6nTNlHZXiAOROdfpSQszx2vw52Z2ZDQpFVzraiNogfLAIQdywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpOBdOeuYK2cdQnTmcb/ntG1dOjYqZoz0fad7TsJEwA=;
 b=kaEX2uUfH3RDEususdzbKJWsbbnIsd5tDF2N+mTnMTYtJkMzJgIHCKTC5XV3i2zooUDc5T+VNV/Uymfnp8UPrKtV6YNlyjszEmInQZI0M0rVIGNVgs9g4D2FM/ZZQRegbWcZ6p35jfIFgtl7NmLP3ECLVmD+I8Vz8W0PqD2RSrQ1MmY36p7xF9pPBm2SpOERMNW2MuK+Y5BLAZFHgShpeq9v9F3of8jGp7suDl5fv9TGSac4FEdmBRcuxTvCDioDIZT6F8A4Cy/Ppghx3L6giw5fU5v4P3+DrQAzyUK1UGNsBzbZjIrmNOG0RgfJzjn4O0uhkxN1O3XJtjlYl2e9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpOBdOeuYK2cdQnTmcb/ntG1dOjYqZoz0fad7TsJEwA=;
 b=T3PM/OohvamERkNdaDiInecd9n2E4n0oZ0OXzGdg5UxeQ1rhoaqknrYelmhVTgpAd8Eg5eax8MJmICwgHtl7ywsrWIgb4EwpBnpoHkdBFNP1zF8QS97BMxKa/mftOHfAhS6zFHnagOdJlZgqL4Joc3rjLoCQejbeL9oEm6sz/Wo=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3567.namprd11.prod.outlook.com (20.178.251.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Fri, 23 Aug 2019 15:53:34 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 15:53:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH 0/5] mtd: spi-nor: move manuf out of the core - batch 0
Thread-Topic: [PATCH 0/5] mtd: spi-nor: move manuf out of the core - batch 0
Thread-Index: AQHVWcrqkdBlY7ZNLEeSbvjl5RDoUg==
Date:   Fri, 23 Aug 2019 15:53:33 +0000
Message-ID: <20190823155325.13459-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0247.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::14) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9e8f4db-0c09-47ec-b294-08d727e20d50
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3567;
x-ms-traffictypediagnostic: MN2PR11MB3567:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB356703D4D90DA4D69A964D7CF0A40@MN2PR11MB3567.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(39860400002)(366004)(396003)(199004)(189003)(1076003)(102836004)(5660300002)(2616005)(476003)(71190400001)(71200400001)(6486002)(66066001)(256004)(386003)(486006)(53936002)(6436002)(2501003)(36756003)(6506007)(8936002)(86362001)(6116002)(4326008)(14444005)(3846002)(2201001)(6512007)(66946007)(26005)(186003)(25786009)(52116002)(99286004)(305945005)(81156014)(81166006)(7736002)(14454004)(66446008)(66476007)(316002)(107886003)(110136005)(2906002)(50226002)(8676002)(478600001)(66556008)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3567;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XbiOKoeJuKfytl4k/o5m96UZETog3JKga4sWVjOAXBULMDvTjAThxdG21JSJzLtSYpR99AktLTtgFBinUiTYPD1fZnlND69+Dn5U2mlUTbDcXctiIk6Z2H2x3jJGb8aPkWcD58vL20mWAcc3Uwi8HEUl0nljurTBNBmvLEAIzE0ZQgZIBWmg51y3DzEYAvQSz+VQUfGF46Fx+jPUi2Li706y9mvHG21E0RdonfPyV6buUW8VLHNYoroUYz3R7rNgCoRBA7V15aagqsgM9M5+0UDc8IHusaUOUScw8OEJtt9Eiv9Rj9xgWAqOpRbLnfVhCjf8kXzwQUMKH+FtS2gmMn3TF4BoR8DAp4nZrprsbx7PzuXT6i+DHLPc3gnEmBvPvglbiJYNW0ptk+5kbcCwG9fJkrMd+JH6sYagkBBrHQo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e8f4db-0c09-47ec-b294-08d727e20d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 15:53:33.7937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TkRkRv1ok4kH4gDjOV0laUWGG2kw8Ed8qm7RM61TpSi7YzCjoYJ3X1T0J7BfLs4Q/E0GovP6oz/4nlf9ey3dgmCKYKX8+wkw2zX1UcfNYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

This series is a prerequisite for the effort of moving the
manufacturer specific code out of the SPI NOR core.

The scope is to move all [FLASH-SPECIFIC] parameters and settings
from 'struct spi_nor' to 'struct spi_nor_flash_parameter'. We will
have a clear separation between the SPI NOR layer and the flash
parameters and settings.

'struct spi_nor_flash_parameter' describes the hardware capabilities
and associated settings of the SPI NOR flash memory. It includes
legacy flash parameters and settings that can be overwritten by the
spi_nor_fixups hooks, or dynamically when parsing the JESD216
Serial Flash Discoverable Parameters (SFDP) tables. All SFDP params
and settings will fit inside 'struct spi_nor_flash_parameter'.

Tested uniform and non-uniform erase on sst26vf064b flash using the
atmel-quadspi driver.

In order to test this, you'll have to merge v5.3-rc5 in spi-nor/next.
This patch depends on
'commit 834de5c1aa76 ("mtd: spi-nor: Fix the disabling of write protection =
at init")

Tudor Ambarus (5):
  mtd: spi-nor: Regroup flash parameter and settings
  mtd: spi-nor: Use nor->params
  mtd: spi-nor: Drop quad_enable() from 'struct spi-nor'
  mtd: spi-nor: Move clear_sr_bp() to 'struct spi_nor_flash_parameter'
  mtd: spi-nor: Move erase_map to 'struct spi_nor_flash_parameter'

 drivers/mtd/spi-nor/spi-nor.c | 236 ++++++++++++++++----------------------=
-
 include/linux/mtd/spi-nor.h   | 254 ++++++++++++++++++++++++++++----------=
----
 2 files changed, 269 insertions(+), 221 deletions(-)

--=20
2.9.5

