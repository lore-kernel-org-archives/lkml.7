Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC111C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D88221D71
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 10:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="mkalME+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfJDKr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:47:59 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:51351 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 06:47:58 -0400
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
IronPort-SDR: bDwSf4rWSyNhVjwAXToIjsJqs0ym4D+KIFrpeAUuK8LQyn/0a+OwkoRtU9BLVn5EoGQq8gFANM
 kcQKMf3WATuDDFwh6MsoBNAmq0hI4tpxyxziJTOO6fNcEhOcLoYItQosABWWMT8TskXJyFO9KV
 8Oye/kczGWNgXC6Lwdan9ShOYXd28fjphN4LreKKp4csJCvP6IZJJ7TsUh3j/bfpqwvmLsIb5P
 uq9sqLLwK/I2kd0jjL4fWlJB/24LuCAyXgdxTo1gzu+tZ+omFTuRjQYvDaODQCI57dVkx39Pit
 c4w=
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="50431718"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2019 03:47:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 4 Oct 2019 03:47:57 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 4 Oct 2019 03:47:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXQYkrw+pFj48SYdhajPSKp9UiG2xajLpmjsmBQ8nUcgKPKOXVf0+vt8h/cDDxOLCYcqrrGlDSAcu4eTkE2F3Jylfk8rXtYux8ADFyWcVizNVA5QvmLE84TN6MPIgJON7zuKcJ4l3y71S77SzTWdahmbmqpzZtwro9FDNYG7UIkuusY+HNdJjpaUtOcN6lKpjkIcciI3GlCwMWDFdPNhLyS86TaDds8TZ5EdjVNT0j30YKZvE/WxR0bOn8kcKPBaFjWPub92KolfImSCa6i6SZYDoO4kDY4S5nGql4CAtwVmEHa4uNeA80JPdgsQBU+egY0ncZvXxQHZ+hHnCxAbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3N+1ONN0C6PCwu5lkKoyxCgyyGrhju5iXcM6z5SYTY=;
 b=TgKMEZKlHKykDpDHIzgD7u2qf/uJKmMmOJ5ssl9MIUzOMf5r48XNnxWjSgLRiGvppHsDuibVtqxzmct62gprxRjXH+YRqhyuSb0TEmGJPb9htQdLTbnNXaFNKKtpNPEu2AfE+Eo20EuygmTqL3jcH68HUT++r1j9rsdUxhh5ciYXDgHCSQx+u35nRhQb8a9fvbnT8BvEuk568ejv4dNhKOBk+Is5aRm33eV9L7Jf9gudjCc5gVs7ZCEfcBbWwfooBS/Q0DoQXvaIMWppJSUQVudRtB4NNBw/POzJ28H0vUlpinspyVxqY66hcXSXF9XgiFuDvpsx0ekJGDgqQ4Zljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3N+1ONN0C6PCwu5lkKoyxCgyyGrhju5iXcM6z5SYTY=;
 b=mkalME+CRwza/KTFyFk9XctROd9u8oqw+1Cxec9vPMGOuy9xM1iLDkvdn+um82Q4tPWW9TnDBTSWteCxQT8Fin5rZiCSuF855fnVRnTQBaFVeWFjWg8nRQL5ItPz6Q3hHSYnjwcYGvxNPgsh7x6YijlL/vuq6CzTBNrnIRwLqDk=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4222.namprd11.prod.outlook.com (52.135.36.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Fri, 4 Oct 2019 10:47:55 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::340d:5a33:dc79:1184]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::340d:5a33:dc79:1184%5]) with mapi id 15.20.2305.023; Fri, 4 Oct 2019
 10:47:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: Fix direction of the write_sr() transfer
Thread-Topic: [PATCH] mtd: spi-nor: Fix direction of the write_sr() transfer
Thread-Index: AQHVeqEtwNvmmNlG50ubt70oQPwmWQ==
Date:   Fri, 4 Oct 2019 10:47:55 +0000
Message-ID: <20191004104746.23537-1-tudor.ambarus@microchip.com>
References: <c703dec2-dd11-5898-83ad-fb06127b6575@huawei.com>
In-Reply-To: <c703dec2-dd11-5898-83ad-fb06127b6575@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR03CA0058.eurprd03.prod.outlook.com
 (2603:10a6:803:50::29) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67290a1c-4263-43e2-7d05-08d748b85052
x-ms-traffictypediagnostic: MN2PR11MB4222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4222CD8E9F43BFD76284A4C4F09E0@MN2PR11MB4222.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 018093A9B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(366004)(136003)(199004)(189003)(446003)(2501003)(11346002)(4326008)(316002)(478600001)(99286004)(6506007)(386003)(14454004)(102836004)(107886003)(25786009)(64756008)(71200400001)(71190400001)(66476007)(66556008)(66946007)(66446008)(86362001)(486006)(2616005)(476003)(66066001)(52116002)(2906002)(305945005)(7736002)(1076003)(4744005)(256004)(6512007)(6436002)(6116002)(3846002)(14444005)(8676002)(81166006)(76176011)(8936002)(26005)(2201001)(50226002)(81156014)(186003)(6486002)(110136005)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4222;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WoVx6LKd25yjMX7ip7cE5bzmqOjSNcBMW1Ng1p58J+0BFLYh2/pKv5s39CYk2klNdcXmqUc9ptlsW2J1U59WvDPe7A6wa2v3Vam6sQSXcI7RluNF0TmMGgjvbOkMIphP6oxYgMQ734D97pov5PJW5d/GbFNTCzh8dGc1V/W8/2fMht5LyJn6Y+xhe9ObRO2HgktNzComH6LyqupCVytAjoMWJ+oeH7IKs+5wbxX0FGsYf2FR53QWhh4hwFdLJovMt1YbAF5reKGw4DGodKFuc7zH90cXGl06Y7jrxSlS/i09eFNPSbrLbz/BXb8zVvzqxMQgzfiqWVpJoTl+bb7XJ6VmZsdjy5lqbbvPMbIFdPQ9IqLaavroHLk2em9J5eirOkt/+XXNfoPmlqrqXWjQlLIFXvgZWH+NzQ670DbHqvA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 67290a1c-4263-43e2-7d05-08d748b85052
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2019 10:47:55.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sD3F9/JmS1RJfdbl9m0e09SGSWYd1DNsqL1Uvv2f4wWQIh20lJ2YBvdk/tCIoTO3jTEhnSLqiTDJw5TlOP12rGQWB+oTOtIireZdyDjxpr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

write_sr() sends data to the SPI memory, fix the direction.

Fixes: b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 1d8621d43160..7acf4a93b592 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -487,7 +487,7 @@ static int write_sr(struct spi_nor *nor, u8 val)
 			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
 				   SPI_MEM_OP_NO_ADDR,
 				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 1));
+				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
=20
 		return spi_mem_exec_op(nor->spimem, &op);
 	}
--=20
2.9.5

