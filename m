Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB10EC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9893C214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="AENjBH9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfIQPzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:55:02 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23052 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729907AbfIQPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:55:02 -0400
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
IronPort-SDR: /RvD3GpP3Xfx8cxKqn8deYK4TLH4ffwB8dlD8pMSyPEQx4pyaKUJZGiBAPkOUhlEl5Etu32VQ9
 ESyOiuVeUBfaxRlPCYyDwhPsfnnRZVExyD/RWvXjUEX3XVoR8wGFUVTy9keYDGkfbiKWWPtoeu
 6AUxJMdUdwq5tNLBwUYnhI05BY6Dip7QOm4Tz4UkxJnPMq5Cf7dYiANG2qEjFg22Y4U20aDGnj
 ZEvuzXvN/6efluOMEAF180zrhvP6ysi4AeW0P+PSssMPRm1yGzuQ1TfCIdYtELOsg/Mz/X6dkf
 6GU=
X-IronPort-AV: E=Sophos;i="5.64,517,1559545200"; 
   d="scan'208";a="49417066"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2019 08:54:59 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Sep 2019 08:54:51 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Sep 2019 08:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XT0+uGKxogCeHdu9D3YFKZ+qMMGvv9qW1LUCYWf1Hyx8fD7TuwV26bkqFHQVm4AMBcMsCFoGAUycAPCkjudC5J6EyBLcjJAN/qOhZPZQlHgJLDE1zfDDV4PtHl+jOq+2w50lGx1xolcTdGFJ0slp8Im+ZOyXh+tNHNJRgcaswCE5xt01mtzwOcrhqQAaILLj/eD1eiNcje2KuXahI1rp9ZMVVwCYUFScjN69bLxcR67jz9SVBT2SuOB3WEQF+cOP66x0E9L9REyBZjJALAXwbTw9Ko/5xNerOrpCAwcaHrHoGw3jT0UIOgSOxZ7/g2HbD772PXOmjOjtO7W03rszGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUnI9G+jAP6wYWzRUmHCiHV/8SdWFcWs90zq4tIEEaQ=;
 b=RSi7X3kPypu6EEZK/InN/ieFD8Y+Pte7/7VwIbQSOcStjkO92kylUXZGREr15EWs1y9rFtockajSZLDSvThC6S4dd8p+MEqW2p3jqcvfjzh+1iy6f3emCAISX6Ms+IdOw8oxAVYZ+YM+3bPDGMs1pUuYv9l4/aSS8x9bJFuJhNbyJ0l6uSfX/BbIOKmmmT5vYA9OCmAps4LX6hB2J54tEIkT/TnM6AGgFbX7AcbiyMrkhPMxbf7skUgLZd/MAro/CTfnPvg+AUoBCoDZETleEMoq4UQ+sDmdyg7bEh8zqBYTp45Unc85TLu5wZ6fdrA+Y5dQWIQ2mXJSiv56NRU6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUnI9G+jAP6wYWzRUmHCiHV/8SdWFcWs90zq4tIEEaQ=;
 b=AENjBH9CLwdIw0XZBFpGWL69nL3Ju/JZG1KphDk9IaJyv9+PKDBi4Cf9Ha1PIscLBbyI9Zn6Mw0ooBeduy00A+xah4L4Yvu9TU8YcpM3tgoJs9W2SnwYQag5S+AJjxbTCZ8lKwjIFybQwOFySCCNwIFROlIKZfdcLBv6/8TYYWc=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3984.namprd11.prod.outlook.com (10.255.181.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.21; Tue, 17 Sep 2019 15:54:50 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2263.023; Tue, 17 Sep 2019
 15:54:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <matthias.bgg@gmail.com>,
        <vz@mleia.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH 03/23] mtd: spi-nor: cadence-quadspi: Fix cqspi_command_read()
 definition
Thread-Topic: [PATCH 03/23] mtd: spi-nor: cadence-quadspi: Fix
 cqspi_command_read() definition
Thread-Index: AQHVbXA9hfYbZR5ivU2ka2qtYlUz9g==
Date:   Tue, 17 Sep 2019 15:54:50 +0000
Message-ID: <20190917155426.7432-4-tudor.ambarus@microchip.com>
References: <20190917155426.7432-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190917155426.7432-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0302CA0007.eurprd03.prod.outlook.com
 (2603:10a6:800:e9::17) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5479ccf3-56e8-41f2-fb60-08d73b875f55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3984;
x-ms-traffictypediagnostic: MN2PR11MB3984:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3984BAF5A5C7B7384B634C77F08F0@MN2PR11MB3984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01630974C0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(199004)(189003)(478600001)(2616005)(64756008)(66476007)(3846002)(6486002)(107886003)(25786009)(6512007)(50226002)(6436002)(305945005)(99286004)(71200400001)(476003)(7416002)(486006)(256004)(66066001)(71190400001)(7736002)(76176011)(102836004)(36756003)(26005)(386003)(66446008)(14454004)(66946007)(1076003)(86362001)(6506007)(186003)(6116002)(5660300002)(66556008)(110136005)(81156014)(81166006)(2501003)(8676002)(54906003)(316002)(4326008)(8936002)(11346002)(2906002)(446003)(52116002)(2201001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3984;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6d2lI961zrbF0OLuLwMsayae6gaa7lcFz9ldKGl8WWvvgvLANfZdj4BmQhS8t9AJvzgmVx2a3UlOaetl940pmnTrbU7mdfi/lkh3ESWw1b2pOfXgUHdgWAUXu0GvvEz+Jsz98R7TndAF5xYR02kIQF3giLItceHEz9u14pC5SW8QQDjbIEDFpqIjNx6BpGlTNOiMppa5Ta5SMwW+buYDMi2NvhgCYy2PkqRiZozOiMWm9eSLSUedY+pdUpv3VO2oTxlhCTe5gbVFAMBsz+R6m6cT4DmyXu+jObfOO0u1CodQq16P0/R1dY7bXjcSdsFA6Aw+eviJjnywBCq1Vxi2gCJdOpJJXN6vUZrFrwYlJy/SSBje27huwUnQq7UPP9MM1XTbR8e/HzcR60bAHtiZd4bwLhghId+ewJk60HBTjK4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5479ccf3-56e8-41f2-fb60-08d73b875f55
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2019 15:54:50.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3OMKr2Y7P/ak7kRUAmS12CA8gaARH1Q4/YqdrSLLklgH+IMSOb5rA8Plc1QufzwQYIK/t/ADR3SCDA2Jq03zeYytvskszmyab0GiOtSSGuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

n_tx was never used, drop it. Replace 'const u8 *txbuf' with 'u8 opcode',
to comply with the SPI NOR int (*read_reg)() method. The 'const'
qualifier has no meaning for parameters passed by value, drop it.
Going furher, the opcode was passed to cqspi_calc_rdreg() and never used,
drop it.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/cadence-quadspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/ca=
dence-quadspi.c
index ebda612641a4..22008fecd326 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -285,7 +285,7 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void=
 *dev)
 	return IRQ_HANDLED;
 }
=20
-static unsigned int cqspi_calc_rdreg(struct spi_nor *nor, const u8 opcode)
+static unsigned int cqspi_calc_rdreg(struct spi_nor *nor)
 {
 	struct cqspi_flash_pdata *f_pdata =3D nor->priv;
 	u32 rdreg =3D 0;
@@ -354,8 +354,7 @@ static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi,=
 unsigned int reg)
 	return cqspi_wait_idle(cqspi);
 }
=20
-static int cqspi_command_read(struct spi_nor *nor,
-			      const u8 *txbuf, const unsigned n_tx,
+static int cqspi_command_read(struct spi_nor *nor, u8 opcode,
 			      u8 *rxbuf, size_t n_rx)
 {
 	struct cqspi_flash_pdata *f_pdata =3D nor->priv;
@@ -373,9 +372,9 @@ static int cqspi_command_read(struct spi_nor *nor,
 		return -EINVAL;
 	}
=20
-	reg =3D txbuf[0] << CQSPI_REG_CMDCTRL_OPCODE_LSB;
+	reg =3D opcode << CQSPI_REG_CMDCTRL_OPCODE_LSB;
=20
-	rdreg =3D cqspi_calc_rdreg(nor, txbuf[0]);
+	rdreg =3D cqspi_calc_rdreg(nor);
 	writel(rdreg, reg_base + CQSPI_REG_RD_INSTR);
=20
 	reg |=3D (0x1 << CQSPI_REG_CMDCTRL_RD_EN_LSB);
@@ -471,7 +470,7 @@ static int cqspi_read_setup(struct spi_nor *nor)
 	unsigned int reg;
=20
 	reg =3D nor->read_opcode << CQSPI_REG_RD_INSTR_OPCODE_LSB;
-	reg |=3D cqspi_calc_rdreg(nor, nor->read_opcode);
+	reg |=3D cqspi_calc_rdreg(nor);
=20
 	/* Setup dummy clock cycles */
 	dummy_clk =3D nor->read_dummy;
@@ -604,7 +603,7 @@ static int cqspi_write_setup(struct spi_nor *nor)
 	/* Set opcode. */
 	reg =3D nor->program_opcode << CQSPI_REG_WR_INSTR_OPCODE_LSB;
 	writel(reg, reg_base + CQSPI_REG_WR_INSTR);
-	reg =3D cqspi_calc_rdreg(nor, nor->program_opcode);
+	reg =3D cqspi_calc_rdreg(nor);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
=20
 	reg =3D readl(reg_base + CQSPI_REG_SIZE);
@@ -1087,7 +1086,7 @@ static int cqspi_read_reg(struct spi_nor *nor, u8 opc=
ode, u8 *buf, size_t len)
=20
 	ret =3D cqspi_set_protocol(nor, 0);
 	if (!ret)
-		ret =3D cqspi_command_read(nor, &opcode, 1, buf, len);
+		ret =3D cqspi_command_read(nor, opcode, buf, len);
=20
 	return ret;
 }
--=20
2.9.5

