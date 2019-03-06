Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B96C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302B920675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="arOp9k7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfCFGa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:30:57 -0500
Received: from mail-eopbgr50080.outbound.protection.outlook.com ([40.107.5.80]:11489
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729063AbfCFGaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC3JqbsctjR9Zfq8KvrJNyIX0h08B5bpWFDR9qTyfVw=;
 b=arOp9k7wywqBQDDyemY/HF+FHtYZS4eWLZpOjZirWJkxjMjabT9gdR+EFoQZxEs3rZsmD0XmgU2e4U9oPM2IzqbL1cozcKnkjEpBsrBJ9bYYLM28u6TDvcSUmatI/oCgUZElnCwsFqCjq6srVAPMfNhQCWL+8Vw3HghWtoFd8Ew=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:45 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:45 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 6/8] spi: lpspi: add dma mode support
Thread-Topic: [PATCH V2 6/8] spi: lpspi: add dma mode support
Thread-Index: AQHU0+Yh6Oh4Uxb7nEmgG98iwvig9g==
Date:   Wed, 6 Mar 2019 06:30:45 +0000
Message-ID: <20190306063020.793-7-xiaoning.wang@nxp.com>
References: <20190306063020.793-1-xiaoning.wang@nxp.com>
In-Reply-To: <20190306063020.793-1-xiaoning.wang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To AM6PR04MB5016.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::24)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaoning.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4e305fb-8209-4fcc-634b-08d6a1fd4354
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:lx8TP3XXymNTEnyC8VNYKt159PUy4eRW1+97542?=
 =?iso-8859-1?Q?DgW3MHsjdRAQvDy5mhLJSs8ap2liNJKipP7tQR/dIa8kbcyKV2tZMvFbeN?=
 =?iso-8859-1?Q?I2j1AcLY0EeJVHK/9x1XtNdBWISpu4YKgdQVjOC1Mg5QHNiThsi0yKH7tI?=
 =?iso-8859-1?Q?ZN+96gIDtwwd0QojRFC+D4sPgWM/HaJiC/72js3OzvAZA2j0t4MVnSFQbb?=
 =?iso-8859-1?Q?CXOqWPWZxsaw6GjbAvX96o7R/2SVusfhPuFcFa1yQF8sTt9haRzJBlGMFd?=
 =?iso-8859-1?Q?k8ViDb+PZut7j+g7eFh/Y/13wdLx8Gtqd7UxOF9Q3PyIHdMsMfGO+VmfGI?=
 =?iso-8859-1?Q?XiHamzegifXk/iS3tloiS9wOyIx8xOh0frWibV73UoUrABKAkkmehCb8yI?=
 =?iso-8859-1?Q?/zmFxetubBIdA467/LdG6lK3ZXoLdxUo58D4YmviwwsJvH75paDlIlieq0?=
 =?iso-8859-1?Q?QHb751AdnTb8RjxxzgPj/vAWexqR+0wWkD4FrD8IbX92Y+OpBL9XKb//Ze?=
 =?iso-8859-1?Q?SKfC/BzZD2iuP+nrFm+HlP3nIIOTY2FZ8u6s1lL7HCJzWwf9CSIcbp7iI+?=
 =?iso-8859-1?Q?RA8+WHX0RXhKHeb0WRKUzcWG+haVb7H3rEiJ3eh1r+pDhGtkRwfvPhcubN?=
 =?iso-8859-1?Q?uNgFCJQsytI68ImF/37ffjRl3ChwFN/fgWTdYKljA26TZRoXZQI84RUY2z?=
 =?iso-8859-1?Q?XuLTZCadglpoACdFDnL6eT9wg3VoSn+t6AVIZ1Ob5FIibc+Xs5mqAjTfdV?=
 =?iso-8859-1?Q?rtjxc1Iyj+BTBu8iPUVaht27t9nUeCR8HUCSeISaIamU+plETt0eC8zsSB?=
 =?iso-8859-1?Q?V+7tZGAEe22OrSVl0xTvqowgBq1alyAJl3ON2AS5IEkOFXksImgZJhkNAJ?=
 =?iso-8859-1?Q?QBJ6uU5znRe3h0lxl6nXia6y+cz0qO/GTEpWnBM1BxJ3Acbeq8VUD9epLF?=
 =?iso-8859-1?Q?7yS54MrULz0uiPCBFjJ452HjTxr0MnxMPRzWpxmoqxRja5hmTE4QPy4tiO?=
 =?iso-8859-1?Q?WYq2jiV1e+tiWIgnFOAPhk8fpdY0D5OK85/8x3xbiqq44CT+VRgeZxc9R2?=
 =?iso-8859-1?Q?zvGErrtZGK0fb58hW6zpwBjQk3wrM6hwuXqpIdaxZmuUTISkIZqVFqO3tF?=
 =?iso-8859-1?Q?MkpuG1xcO3o46q98O+VocNcO3F42KWlX56DgAEp/72ouXcJlNlesg/I3e9?=
 =?iso-8859-1?Q?OchaJINVcHDEaZvxe24SzIQNMu4eKt05GNGQfZaAgV+06hD9GZKQnG/6y2?=
 =?iso-8859-1?Q?btA2mCjITOgOzKxtfHzbgKHHuq+BYCVB91990cuNhjt/a3rqRAKTr8NnAB?=
 =?iso-8859-1?Q?emXWSkdzuiKtDqsEL35J/fzzCio8EQY6PKq1rpVXdRob849YhkyJp0Zrck?=
 =?iso-8859-1?Q?kD87BQATr+I5PuiUb3hmnYZjW/uvu?=
x-microsoft-antispam-prvs: <AM6PR04MB4373D1B7E352F7E5626712B7F3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(14444005)(256004)(105586002)(102836004)(30864003)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZNxMxpSHcrjuuE6iXhcnfu6Xlc+YAjwY20UuP699UTTHovPkxEwkPLrnoPdIhjYaPvEnyzmJoHRmUieczyLQRoU6SiLXQndxBmAaCb0RkaKW0S8Vq66XDmV3G1FYb55vQfJWTMAGkhixTH1jPWV6ODUdnFQXtKqXNB6YPzA8bMTW2Esb/Mj38kmPe/CsSymCGRegqyjNBzLokwquqHqWO6Xtah3UK55etBkVS84uqaZXG9KOJuxU8qG8zCUNIsvGHNG9vHIiXt9TXMFokd9mNtKueY0dChuZZ5o092fE8ztImUMtYTFl7YRCiSnArtTvnNYeSDcYDYe7+tA7IgI5NIZup4Im9linIK8I9BAOO+OH4uBV+lmm6V51a1Ah6B5Fatcy3nwPbVI+yNqV/z3f1s7cg6Bqdgfgkdmx68U5HQ8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e305fb-8209-4fcc-634b-08d6a1fd4354
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:45.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dma mode support for LPSPI. Any frame longer than half txfifosize will
be sent by dma mode.

For now, there are some limits:
1. The maximum transfer speed in master mode depends on the slave device,
   at least 40MHz(tested by spi-nor on 8qm-lpddr4-arm2 base board);
2. The maximum transfer speed in slave mode is 15MHz(imx7ulp),
   22MHz(8qm/qxp). In order to reach the maximum speed which is mentioned
   in datasheet, the load of connect wires between master and slave
   should be less than 15pF.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
---
V2:
 - replace a if judgement by switch statement
 - seperate a Debug print fix into next patch
---
 drivers/spi/spi-fsl-lpspi.c | 312 ++++++++++++++++++++++++++++++++++--
 1 file changed, 301 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a25e0e03f058..9ff32fb67a29 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -8,6 +8,8 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
@@ -20,6 +22,7 @@
 #include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/dma-imx.h>
 #include <linux/platform_data/spi-imx.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -31,6 +34,9 @@
=20
 #define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
=20
+/* The maximum bytes that edma can transfer once.*/
+#define FSL_LPSPI_MAX_EDMA_BYTES  ((1 << 15) - 1)
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -64,6 +70,8 @@
 #define IER_FCIE	BIT(9)
 #define IER_RDIE	BIT(1)
 #define IER_TDIE	BIT(0)
+#define DER_RDDE	BIT(1)
+#define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
 #define CFGR1_PCSPOL	BIT(8)
@@ -91,6 +99,7 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
+	unsigned long base_phys;
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
@@ -111,6 +120,11 @@ struct fsl_lpspi_data {
=20
 	bool slave_aborted;
=20
+	/* DMA */
+	bool usedma;
+	struct completion dma_rx_completion;
+	struct completion dma_tx_completion;
+
 	int chipselect[0];
 };
=20
@@ -158,6 +172,35 @@ static void fsl_lpspi_intctrl(struct fsl_lpspi_data *f=
sl_lpspi,
 	writel(enable, fsl_lpspi->base + IMX7ULP_IER);
 }
=20
+static int fsl_lpspi_bytes_per_word(const int bpw)
+{
+	return DIV_ROUND_UP(bpw, BITS_PER_BYTE);
+}
+
+static bool fsl_lpspi_can_dma(struct spi_controller *controller,
+			      struct spi_device *spi,
+			      struct spi_transfer *transfer)
+{
+	unsigned int bytes_per_word;
+
+	if (!controller->dma_rx)
+		return false;
+
+	bytes_per_word =3D fsl_lpspi_bytes_per_word(transfer->bits_per_word);
+
+	switch (bytes_per_word)
+	{
+		case 1:
+		case 2:
+		case 4:
+			break;
+		default:
+			return false;
+	}
+
+	return true;
+}
+
 static int lpspi_prepare_xfer_hardware(struct spi_controller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -245,11 +288,13 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *=
fsl_lpspi)
 		 * For the first transfer, clear TCR_CONTC to assert SS.
 		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
 		 */
-		temp |=3D TCR_CONT;
-		if (fsl_lpspi->is_first_byte)
-			temp &=3D ~TCR_CONTC;
-		else
-			temp |=3D TCR_CONTC;
+		if (!fsl_lpspi->usedma) {
+			temp |=3D TCR_CONT;
+			if (fsl_lpspi->is_first_byte)
+				temp &=3D ~TCR_CONTC;
+			else
+				temp |=3D TCR_CONTC;
+		}
 	}
 	writel(temp, fsl_lpspi->base + IMX7ULP_TCR);
=20
@@ -260,7 +305,11 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_d=
ata *fsl_lpspi)
 {
 	u32 temp;
=20
-	temp =3D fsl_lpspi->watermark >> 1 | (fsl_lpspi->watermark >> 1) << 16;
+	if (!fsl_lpspi->usedma)
+		temp =3D fsl_lpspi->watermark >> 1 |
+		       (fsl_lpspi->watermark >> 1) << 16;
+	else
+		temp =3D fsl_lpspi->watermark >> 1;
=20
 	writel(temp, fsl_lpspi->base + IMX7ULP_FCR);
=20
@@ -302,6 +351,53 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data=
 *fsl_lpspi)
 	return 0;
 }
=20
+static int fsl_lpspi_dma_configure(struct spi_controller *controller)
+{
+	int ret;
+	enum dma_slave_buswidth buswidth;
+	struct dma_slave_config rx =3D {}, tx =3D {};
+	struct fsl_lpspi_data *fsl_lpspi =3D
+				spi_controller_get_devdata(controller);
+
+	switch (fsl_lpspi_bytes_per_word(fsl_lpspi->config.bpw)) {
+	case 4:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	case 2:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_2_BYTES;
+		break;
+	case 1:
+		buswidth =3D DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tx.direction =3D DMA_MEM_TO_DEV;
+	tx.dst_addr =3D fsl_lpspi->base_phys + IMX7ULP_TDR;
+	tx.dst_addr_width =3D buswidth;
+	tx.dst_maxburst =3D 1;
+	ret =3D dmaengine_slave_config(controller->dma_tx, &tx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "TX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	rx.direction =3D DMA_DEV_TO_MEM;
+	rx.src_addr =3D fsl_lpspi->base_phys + IMX7ULP_RDR;
+	rx.src_addr_width =3D buswidth;
+	rx.src_maxburst =3D 1;
+	ret =3D dmaengine_slave_config(controller->dma_rx, &rx);
+	if (ret) {
+		dev_err(fsl_lpspi->dev, "RX dma configuration failed with %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp;
@@ -327,10 +423,16 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fs=
l_lpspi)
 	temp |=3D CR_RRF | CR_RTF | CR_MEN;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
=20
+	temp =3D 0;
+	if (fsl_lpspi->usedma)
+		temp =3D DER_TDDE | DER_RDDE;
+	writel(temp, fsl_lpspi->base + IMX7ULP_DER);
+
 	return 0;
 }
=20
-static int fsl_lpspi_setup_transfer(struct spi_device *spi,
+static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
+				     struct spi_device *spi,
 				     struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -363,6 +465,11 @@ static int fsl_lpspi_setup_transfer(struct spi_device =
*spi,
 	else
 		fsl_lpspi->watermark =3D fsl_lpspi->txfifosize;
=20
+	if (fsl_lpspi_can_dma(controller, spi, t))
+		fsl_lpspi->usedma =3D 1;
+	else
+		fsl_lpspi->usedma =3D 0;
+
 	return fsl_lpspi_config(fsl_lpspi);
 }
=20
@@ -401,8 +508,10 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_=
lpspi)
 {
 	u32 temp;
=20
-	/* Disable all interrupt */
-	fsl_lpspi_intctrl(fsl_lpspi, 0);
+	if (!fsl_lpspi->usedma) {
+		/* Disable all interrupt */
+		fsl_lpspi_intctrl(fsl_lpspi, 0);
+	}
=20
 	/* W1C for all flags in SR */
 	temp =3D 0x3F << 8;
@@ -415,6 +524,176 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl=
_lpspi)
 	return 0;
 }
=20
+static void fsl_lpspi_dma_rx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_rx_completion);
+}
+
+static void fsl_lpspi_dma_tx_callback(void *cookie)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D (struct fsl_lpspi_data *)cookie;
+
+	complete(&fsl_lpspi->dma_tx_completion);
+}
+
+static int fsl_lpspi_calculate_timeout(struct fsl_lpspi_data *fsl_lpspi,
+				       int size)
+{
+	unsigned long timeout =3D 0;
+
+	/* Time with actual data transfer and CS change delay related to HW */
+	timeout =3D (8 + 4) * size / fsl_lpspi->config.speed_hz;
+
+	/* Add extra second for scheduler related activities */
+	timeout +=3D 1;
+
+	/* Double calculated timeout */
+	return msecs_to_jiffies(2 * timeout * MSEC_PER_SEC);
+}
+
+static int fsl_lpspi_dma_transfer(struct spi_controller *controller,
+				struct fsl_lpspi_data *fsl_lpspi,
+				struct spi_transfer *transfer)
+{
+	struct dma_async_tx_descriptor *desc_tx, *desc_rx;
+	unsigned long transfer_timeout;
+	unsigned long timeout;
+	struct sg_table *tx =3D &transfer->tx_sg, *rx =3D &transfer->rx_sg;
+	int ret;
+
+	ret =3D fsl_lpspi_dma_configure(controller);
+	if (ret)
+		return ret;
+
+	desc_rx =3D dmaengine_prep_slave_sg(controller->dma_rx,
+				rx->sgl, rx->nents, DMA_DEV_TO_MEM,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_rx)
+		return -EINVAL;
+
+	desc_rx->callback =3D fsl_lpspi_dma_rx_callback;
+	desc_rx->callback_param =3D (void *)fsl_lpspi;
+	dmaengine_submit(desc_rx);
+	reinit_completion(&fsl_lpspi->dma_rx_completion);
+	dma_async_issue_pending(controller->dma_rx);
+
+	desc_tx =3D dmaengine_prep_slave_sg(controller->dma_tx,
+				tx->sgl, tx->nents, DMA_MEM_TO_DEV,
+				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc_tx) {
+		dmaengine_terminate_all(controller->dma_tx);
+		return -EINVAL;
+	}
+
+	desc_tx->callback =3D fsl_lpspi_dma_tx_callback;
+	desc_tx->callback_param =3D (void *)fsl_lpspi;
+	dmaengine_submit(desc_tx);
+	reinit_completion(&fsl_lpspi->dma_tx_completion);
+	dma_async_issue_pending(controller->dma_tx);
+
+	fsl_lpspi->slave_aborted =3D false;
+
+	if (!fsl_lpspi->is_slave) {
+		transfer_timeout =3D fsl_lpspi_calculate_timeout(fsl_lpspi,
+							       transfer->len);
+
+		/* Wait eDMA to finish the data transfer.*/
+		timeout =3D wait_for_completion_timeout(&fsl_lpspi->dma_tx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA TX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+
+		timeout =3D wait_for_completion_timeout(&fsl_lpspi->dma_rx_completion,
+						      transfer_timeout);
+		if (!timeout) {
+			dev_err(fsl_lpspi->dev, "I/O Error in DMA RX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -ETIMEDOUT;
+		}
+	} else {
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_tx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA TX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+
+		if (wait_for_completion_interruptible(&fsl_lpspi->dma_rx_completion) ||
+			fsl_lpspi->slave_aborted) {
+			dev_dbg(fsl_lpspi->dev,
+				"I/O Error in DMA RX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			fsl_lpspi_reset(fsl_lpspi);
+			return -EINTR;
+		}
+	}
+
+	fsl_lpspi_reset(fsl_lpspi);
+
+	return 0;
+}
+
+static void fsl_lpspi_dma_exit(struct spi_controller *controller)
+{
+	if (controller->dma_rx) {
+		dma_release_channel(controller->dma_rx);
+		controller->dma_rx =3D NULL;
+	}
+
+	if (controller->dma_tx) {
+		dma_release_channel(controller->dma_tx);
+		controller->dma_tx =3D NULL;
+	}
+}
+
+static int fsl_lpspi_dma_init(struct device *dev,
+			      struct fsl_lpspi_data *fsl_lpspi,
+			      struct spi_controller *controller)
+{
+	int ret;
+
+	/* Prepare for TX DMA: */
+	controller->dma_tx =3D dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(controller->dma_tx)) {
+		ret =3D PTR_ERR(controller->dma_tx);
+		dev_dbg(dev, "can't get the TX DMA channel, error %d!\n", ret);
+		controller->dma_tx =3D NULL;
+		goto err;
+	}
+
+	/* Prepare for RX DMA: */
+	controller->dma_rx =3D dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(controller->dma_rx)) {
+		ret =3D PTR_ERR(controller->dma_rx);
+		dev_dbg(dev, "can't get the RX DMA channel, error %d\n", ret);
+		controller->dma_rx =3D NULL;
+		goto err;
+	}
+
+	init_completion(&fsl_lpspi->dma_rx_completion);
+	init_completion(&fsl_lpspi->dma_tx_completion);
+	controller->can_dma =3D fsl_lpspi_can_dma;
+	controller->max_dma_len =3D FSL_LPSPI_MAX_EDMA_BYTES;
+
+	return 0;
+err:
+	fsl_lpspi_dma_exit(controller);
+	return ret;
+}
+
 static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 				  struct spi_transfer *t)
 {
@@ -449,14 +728,17 @@ static int fsl_lpspi_transfer_one(struct spi_controll=
er *controller,
 	int ret;
=20
 	fsl_lpspi->is_first_byte =3D true;
-	ret =3D fsl_lpspi_setup_transfer(spi, t);
+	ret =3D fsl_lpspi_setup_transfer(controller, spi, t);
 	if (ret < 0)
 		return ret;
=20
 	fsl_lpspi_set_cmd(fsl_lpspi);
 	fsl_lpspi->is_first_byte =3D false;
=20
-	ret =3D fsl_lpspi_pio_transfer(controller, t);
+	if (fsl_lpspi->usedma)
+		ret =3D fsl_lpspi_dma_transfer(controller, fsl_lpspi, t);
+	else
+		ret =3D fsl_lpspi_pio_transfer(controller, t);
 	if (ret < 0)
 		return ret;
=20
@@ -606,6 +888,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 		ret =3D PTR_ERR(fsl_lpspi->base);
 		goto out_controller_put;
 	}
+	fsl_lpspi->base_phys =3D res->start;
=20
 	irq =3D platform_get_irq(pdev, 0);
 	if (irq < 0) {
@@ -647,6 +930,13 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
+	ret =3D fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
+	if (ret =3D=3D -EPROBE_DEFER)
+		goto out_controller_put;
+
+	if (ret < 0)
+		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_controller error.\n");
--=20
2.17.1

