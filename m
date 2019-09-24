Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09179C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00CD205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ILWZj6uJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440661AbfIXHqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:46:05 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:28011 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408088AbfIXHqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:46:03 -0400
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
IronPort-SDR: qjXoCz4bVuTgiV927izXG7s9mf0pn7zSumoxg6IMG5qoCNq3v3AONDP8RU7SuJFc1Ii6pB2GFH
 WzeFnLzVCvq/wCrKtZhpOAh+ErWon+qPmONevXFauV6llwpEaDQroSJjLp/B5QCaZW/ZEOq1Sg
 ma/5Gy/SxBiXMz6ejFtiutoyBWQswp+sd8CUE+L5qDVy1/6idbTSYp5WWszeBEkjVCxI7skWDB
 gHdHkcYFX9R/pkwo+r6BShs7/UVm+u+zwg0bTR3Bsha2g7za2aKIZwrAW3mDT+VtMoIDBRkv05
 wXY=
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="50281710"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2019 00:46:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Sep 2019 00:46:00 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Sep 2019 00:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKuIkUyJErl8Rn/7ejbNn6KwjgiFaYZr46xfL6Hoy6aCBAzAphzj7ijHC9ZEpS25hK7DlBb4xSTy9DSbVhK8VGyLMiJbbtGY4aNAwJmRCd4z4zdB08p3UtltX+yC5RWGwQCEWtwsyetZZsD287cr/SYdVDVTjsvsu6O+Ho09KW8oMspNxMM2zfVrPMZyDvQAWosasx8Pmv+uHbRTiU70t4Fa5U7tQzAZjYaOKN8GWWPv+NYAnG8psrD6MmgTMMbL3xXyoNa6+5NB3IT+iujf0OKYOOb0tIieEFgt+WuHmqz/fkYjSubcEAUiNyPX//oazklvINZvOJBM9oHhqBbqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUnI9G+jAP6wYWzRUmHCiHV/8SdWFcWs90zq4tIEEaQ=;
 b=DrW0dO1dzoQZxJI3OpkpUXBTrFzJZJ39nRMl9ftiVfJLrFIiBIRZjlGVq1duYHDxjXHOnvnZYFi1U1i8knwYR2NJIX8D1BClv+6B5XLg25nC1SkgZIvm4GRBsjlEPbxfN6GJfYpCpcf+D6m/sGjnNltC7RcL4qEbgSqLGgWGPf6MVEaByVpJAuq2AgUqHq7lwjaE+jKL0CzAwNHJzx3wyJdDAph5PtE5gp8ESYi9a7BkrtMGfc0x7aT5lL046yO1+f806vZv74OISubWfvT30GlIysUXIIDyPIHOBtDOevh9xXNE2tzJHzPqa6GztIVepT9RVWxwkO1SnuUdNgYZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUnI9G+jAP6wYWzRUmHCiHV/8SdWFcWs90zq4tIEEaQ=;
 b=ILWZj6uJqx8Y+wP/OxGiHaGPyjVFwDjDkIWeT9KiltbESCuUlP/UH8Y2dF9WdNUVidqTb57Sf24+U7eGFcSzlXb3Byjm5iDveWLtcCx8L3jmqaE6jsCyIP/kNihi6SiytozSHHFKFnMx4qLhnXDUnLrMwXC5Q3U1e7uyRMgoJvI=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB4319.namprd11.prod.outlook.com (52.135.39.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.26; Tue, 24 Sep 2019 07:45:59 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::c951:b15a:e4b3:30f7%7]) with mapi id 15.20.2284.023; Tue, 24 Sep 2019
 07:45:59 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <boris.brezillon@collabora.com>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <geert+renesas@glider.be>, <jonas@norrbonn.se>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <matthias.bgg@gmail.com>, <vz@mleia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 03/22] mtd: spi-nor: cadence-quadspi: Fix
 cqspi_command_read() definition
Thread-Topic: [PATCH v2 03/22] mtd: spi-nor: cadence-quadspi: Fix
 cqspi_command_read() definition
Thread-Index: AQHVcqwajFKyuDqBQky8we7iWaMUrA==
Date:   Tue, 24 Sep 2019 07:45:58 +0000
Message-ID: <20190924074533.6618-4-tudor.ambarus@microchip.com>
References: <20190924074533.6618-1-tudor.ambarus@microchip.com>
In-Reply-To: <20190924074533.6618-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0101CA0082.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::50) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb5ea043-b5b6-4318-055c-08d740c33d2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR11MB4319;
x-ms-traffictypediagnostic: MN2PR11MB4319:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4319FC51E7D96777F0694F3DF0840@MN2PR11MB4319.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0170DAF08C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(39860400002)(376002)(189003)(199004)(5660300002)(2201001)(6436002)(256004)(86362001)(11346002)(14454004)(476003)(2501003)(305945005)(186003)(2616005)(26005)(386003)(102836004)(6506007)(25786009)(6486002)(8936002)(81156014)(2906002)(3846002)(81166006)(107886003)(7736002)(8676002)(6512007)(486006)(36756003)(52116002)(71200400001)(71190400001)(50226002)(446003)(66446008)(76176011)(99286004)(66946007)(4326008)(66476007)(64756008)(66556008)(6116002)(54906003)(110136005)(66066001)(316002)(1076003)(7416002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4319;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mfcLSubC3cL40yqzYsb1w/t09QCo9XoiQuXZ0bJt/UWB+pErvP8dEMndEaxHGW5+rZCTOvBp9x+Nr6XO3yxzxIPDJg8rsMcNGSTs3WpNDYwpusCJAA7nLGINo552INxiO51xbzMCB8h++uB7AofcBr+uHmaV+I3SGs1Q2sHquEUkW8JQhYNy3sAaQIDXI2OXLJJSGlb1IVgE6WTJ1OJXWwMoxwJWZiw2I9/GOyrRZ6tZQJpLZtRd+8U+iEmQmNd/nLXI3/UMI12HwyTwzgPrQWlLwHV7hEKGa5JFRrCZQr0h5e3tQFzveGKPiimfnylhTsskAGjbP8QdM7RbSOCB4Y+my+yoaTw6qnOmIWuNcIy0NR/dcMI7IIykKBG4Pe9uvJN3p1LT17QFOC4dMyrSVY1UkoTx9JSPCusgClxa+8g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5ea043-b5b6-4318-055c-08d740c33d2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2019 07:45:58.9801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pFJvQOlhBqAqfTMPNi4O79Y9+nmKtdZmyHLrXDnBXz1B7I4v/A1UVEIWQ8LE/s0AuexV4bP0Antg0Od4zUSjtH4TrZsqhgl+rzfkTeLzAmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4319
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

