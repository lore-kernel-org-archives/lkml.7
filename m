Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D6AC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7652173E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="EGY6JNTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfHXMTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:19:36 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:28713 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHXMT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:19:26 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cstALZmcKShFHx7nWAmw5vIZdJlHTnbhfXpC0QwIkFlYw9GD7+vGSAPZdgiEFREhuUKHJugwhD
 F/Qxx0ccBtxqaU0LsJAgKkSrgHMMBsMV8Q48O5EgpH3Jadh0dQwCqsY9jU/wySGUv9fqFyBOlj
 ClF0QsDUmv6/8JZRazppC9iNyOarePjwc0E8kuWyu+ZpVzxt49IGcRWey4x9Pg1kYb8q3RsMpI
 SH6wBE2Jdy5bqLeJUAIBBQwGAbDf84SS5MXtZY/8Ma6wbHqbLEa2dp7dAXeVlMwBELDqTajVxU
 IVg=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="47840268"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:19:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:19:24 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 24 Aug 2019 05:19:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3mjDZe81YzA985qmj/KrGOK0EgJn19gXbtTzLyR0dpe1O0XT1jzLaFMVRmASI6I8yvlcgp4D3ZZkqt5p4vPfYaVkjSFUEPS9y3/M2yLUsLqWTDSc2OjU66FaDz891sedBXElOpIxTm42AwH9H1C+zRsJBZwmMiZRrrsWvO6RuFKao1K/L675Zj7jfOI55nCgtadcU8t29QGtJ8AbhUjaKIwhTi4Ts7tTd/K70HJM7uRynG57GOmBtzlXQ1vaBIt1vZ8K60QCG4M3wMkzKfuqS7E2jIZgyG0QhL2Tz5eWn5wLEEPLl4j4+5StkXtZyngLbGTmqXFKliswn493+ZDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G/GT0UzfqigAX9pnCO9NcyKkzat22E3yCpNLW/EyGQ=;
 b=jKcbpw+Dt9IRIJTcvXGSF2GMqO+aPeDcKwQZxAjs4YWzCPgau0z4RYDiGZGsYttemmlZcivMK8Wl+kfAglGC+uglKGYo8Q+9E2rXyDOW+NpG1igd/UmuHqg93JL/90q4PzbHFwKmsLrKNsa9D1sYmL7vH/g9XwLukF3WRbgdu7mnUva0clDORiHn1Ntqs1vulQ5sSBm3Ee9KcBCzTRieep1wt98bpDAdhJHIDrn6OkJZg+ktDObM7X/rVq73iviww034hIq88J0GT9vD/tUfMqP9sVQDS6jBZOe7btmEZr196hTWBaW6StPMrNELBFg53l/oZWZV8zzKdJWV4KNmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7G/GT0UzfqigAX9pnCO9NcyKkzat22E3yCpNLW/EyGQ=;
 b=EGY6JNTUWpv3srFZOXkMHOFTUsxtusqEJ1e+h6soi13GB2cSaV50mFlD8yo5qUWboXUkVuZi1EsAWHYDLkC8W1on++IYfADUxt7zrUgf0gmOQKeTgPuHeunJeCaCSYuIp0ZFK4NhnTbBXZNnI+Zimdh2hyGBqOOSnXSaDTx7q0E=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4317.namprd11.prod.outlook.com (52.135.36.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.19; Sat, 24 Aug 2019 12:19:19 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:19:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 0/3] mtd: spi-nor: move manuf out of the core - batch 3
Thread-Topic: [PATCH v2 0/3] mtd: spi-nor: move manuf out of the core - batch
 3
Thread-Index: AQHVWnYn5mOHtk7pzUijfzFDYNIN7Q==
Date:   Sat, 24 Aug 2019 12:19:18 +0000
Message-ID: <20190824121910.15267-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0602CA0013.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::23) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7063776-3fa3-4f41-6bb9-08d7288d499e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4317;
x-ms-traffictypediagnostic: MN2PR11MB4317:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4317249DC5DBB7F725863BA4F0A70@MN2PR11MB4317.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(39860400002)(376002)(189003)(199004)(81156014)(110136005)(6436002)(3846002)(8936002)(8676002)(6306002)(6512007)(50226002)(305945005)(25786009)(7736002)(478600001)(53936002)(2906002)(316002)(66066001)(81166006)(99286004)(36756003)(6486002)(107886003)(386003)(6506007)(102836004)(476003)(2616005)(52116002)(486006)(26005)(186003)(6116002)(2501003)(4326008)(71190400001)(71200400001)(2201001)(4744005)(66946007)(66476007)(66556008)(64756008)(14454004)(966005)(1076003)(256004)(66446008)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4317;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KlAPaNIImIXr0JTK1/Cy4l+F0/ElALTLOpSm1qipdfxSFQJwWwh19qgJkKj/7uqGC7umUfusztlCnNr2fSyrOuYmUJ1+YIKp+IwdDIElINkfdkaXr3cbN99tkp59n8mUZ/WzbaOBTtUJ0BV/n7fj4sSELV8ZBADd5emLxQwCa4/rrQNddDNps4OthPMhc94sPEInnXBcByuQAzDC+9gtJKnljOVGS1988fBDLyCsc88Cutz7P6VftyFF87hvg3gtAW7BhFBuSZyL5kSftJd2g6wf7WfQfstQHflkl2vMLnOQiwdAwvLvXb1uDqyiAFW+yUdIlwWo/KaxDaFmXmwGJS7zxl3cIwLTxp3zQQZ1GAM9StJLdjX5ShODPPz+DPsTx3fh848p5Apo5s6ujhyFQqm7w/lSQWezTZFvbyBe4m8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b7063776-3fa3-4f41-6bb9-08d7288d499e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:19:18.9781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBSLgtaEG0uXROtaGovOCnYBoEPAqPpybl1WdwWf6Ga+GEj28z19QpBz//NIiy7QdH19ss1Vv4LillErIQAQqsxcoXyIE2HzGBFEodwQiD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Trim spi_nor_scan() huge function.

Depends on 'mtd: spi-nor: move manuf out of the core - batch 2' series:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D127122
which depends on:

Depends on 'mtd: spi-nor: move manuf out of the core - batch 1' series:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D127121
which depends on:

Depends on 'mtd: spi-nor: move manuf out of the core - batch 0' series:
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D127030

All batches can be found at:
https://github.com/ambarus/linux-0day/tree/spi-nor/manuf-drv

Tudor Ambarus (3):
  mtd: spi-nor: Bring flash params init together
  mtd: spi_nor: Introduce spi_nor_set_addr_width()
  mtd: spi-nor: Introduce spi_nor_get_flash_info()

 drivers/mtd/spi-nor/spi-nor.c | 155 +++++++++++++++++++++++---------------=
----
 1 file changed, 85 insertions(+), 70 deletions(-)

--=20
2.9.5

