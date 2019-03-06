Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C88C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00EE206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f7aA5nT+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfCFGaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:30:52 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:43681
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729052AbfCFGat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxA5U5MVsfsm3lW7LN7xp2DkbqIjvZA2xazTALkP7V8=;
 b=f7aA5nT+sC37GwOLja4lIoTEkCqJPngspRGqU8cNivrFGQAlfwZ7RzwQraB7RKrVmUo3errV96S6MJs+l5gdyjTUf8eRuUhQeqDe8P/e4/RQ+jnXNc9faE0jpuK1S5O+8hCqo+X3+s0rTE88yzrhjBcY+8qTcko0xNmxlEpODSY=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:43 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:43 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 5/8] spi: lpspi: use the core way to implement cs-gpio
 function
Thread-Topic: [PATCH V2 5/8] spi: lpspi: use the core way to implement cs-gpio
 function
Thread-Index: AQHU0+YfHXSSQ+2wq020IOJyOSoR1w==
Date:   Wed, 6 Mar 2019 06:30:43 +0000
Message-ID: <20190306063020.793-6-xiaoning.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 35d5a628-3ee0-4bb8-c103-08d6a1fd421a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:20bLht99nuDOF94PM91smTBvIFEt9UUD/rqbhFh?=
 =?iso-8859-1?Q?yuUtkPZ3apguLx/pXM2WOA6AmWPUUdgZVcPxQ/th+ZlQaHlLgqaJUP6e9w?=
 =?iso-8859-1?Q?tc6RkM1q5HSZMh2UWO1DQQVyiGEv4Ws/v4eaf2RjYyATWTwBkhzb9nfY0p?=
 =?iso-8859-1?Q?iqOR2BFNk8jolY/bWvYjzf1urZRL8x4VC7tq1AyORuLSz4MipaoBjswld6?=
 =?iso-8859-1?Q?wXM2oD+j83Z+3pzZTjcDNSBOY27PtQ8SggF1KsZbEu1BGj+8w3jmARogVP?=
 =?iso-8859-1?Q?xRpZl0E0aAZthluTDrp7vHj+W0IUWX5i7twcqrpFJRtydiZj0a9sbsfOU8?=
 =?iso-8859-1?Q?QLB5sCySqWDLSlOL67hD7rqM2ufs/UVyGtEpv+OL0RYMRopxvkNvAuiIcR?=
 =?iso-8859-1?Q?8jx+c147ERAc3top2SU/Xdyg70dGNyIWveQodukQc47V31/CZQ+PPn5spx?=
 =?iso-8859-1?Q?zt3Xl+kHV7DccTNQFjG51uOJ73UghJh+FTqlkdvFAR2XqDCCQgkw9EoX0E?=
 =?iso-8859-1?Q?3sa6EzcXnTUXiKjEwn26x6SVRBaLbrPgAtzySeIZEqGQeBdz0O/XzOqoJk?=
 =?iso-8859-1?Q?yhHUgWr7ntX2gbZw0QZRX/8G1TWdyp0gw73qUSoVll2ioJSHAvqisQBqk7?=
 =?iso-8859-1?Q?cW8G0QpSyW2Y17KcLvhXfZK8ZCXx0itUnEt9iylPjQLB48WZZ0uoeZht0m?=
 =?iso-8859-1?Q?vnTrGQw45v6pwbb2AGz+5rb6oPDmvz/QbFkv3c5ozaIqDII3zIgSRRtOLW?=
 =?iso-8859-1?Q?5SQOxJirAMcJidH4GvAHMu08vYVQsbYGvk04Eph2I1YgahsdpE8nN/V/6l?=
 =?iso-8859-1?Q?9JJKlMzDZvqJGOb4TNgY4+ZeO3SXdVqkcnRenC+rA7Niz62cHYcWBRJwpd?=
 =?iso-8859-1?Q?ZBkStKOLvw9MpuqehJFl5u2UOtiyHTQBGXmzE/1+7rZjW0bH+OprvMom92?=
 =?iso-8859-1?Q?UFh+Aoan7oxg5js9DbARQUX+To7SaxmHQflfmtIreV4EEWSwY5E+Tg9SKv?=
 =?iso-8859-1?Q?QHj3rVrwL0ySK7sV6naY/rS5IW7UdYmoKzunWotroYy9OmjaK4yWsEmB3I?=
 =?iso-8859-1?Q?0fHXmpBKXnUkxHEfiJRQxAQVeSsKsdqog/cupVgxYL1W8W/yGH75BKU6hM?=
 =?iso-8859-1?Q?m/7VBVcWvTkNOyJM/i91xMlWFYOqbetkXL/sjJYHYA9ITiwwXjeTPRjLZj?=
 =?iso-8859-1?Q?b+f8nw9mwD4K29NWGjnBbNln5/9f2Djc16y6Y4oDS/7ZTlFFWFhGdqlQC7?=
 =?iso-8859-1?Q?pqxbGggYEqwcqHlVpISiQLyvj3uD22MxjB8xcwFM63NbwQr8j8cyJ1Rl1d?=
 =?iso-8859-1?Q?NGi4B/RffHH5eUIu7EJ/ThPdAtY0ksZMqm+aCz8BH89gGzhi1o1F+JPLsZ?=
 =?iso-8859-1?Q?Xc+7bQCAbpg4+YLxhcTCCH+JKNSCJ?=
x-microsoft-antispam-prvs: <AM6PR04MB43733CFFCAFAEF8D698A543CF3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(14444005)(256004)(105586002)(102836004)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002)(43043002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GVEpmaAdILzt0ehTyE/GqqnYm75HyjmM/JyVZJEzWYQfctD4cHUwckUtdsD92yr1ItReyi/oG7IBN0ihZVGH7/iFsy89Jtiq0JRgi0vQKBmvTVuyRc5ukVBfpa+9PMuBFuTteKcUDTSn5SPOhr6bS0Bm1pFq5vqaH3vdFiMUaaREXsESK2X1Lzj+LMlngmu2Qk+EWE/DklHat6MGIM5JddCQWfxvjdeYV9kwdwgamTpwXVBo1IPv9qh/C9/wFtM47OjeORIEAZHwaAH/gTPu4jgkI14DgCPWwK2eAYibvTijYe4laU9Mkn2L/ZlOCHpWvXYyGrTfMRQeEDpdWJM8R4MpSzAzYaiUvUZ05grYYfJdZsr1UmnEyKXPzjd8LVEY8vPsN0Q6uYyA4XdUGqNHJ+GDbI1eqhv6PIZ+VroA8i8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d5a628-3ee0-4bb8-c103-08d6a1fd421a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:43.1384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the default implementation of transfer_one_msg/chipselect/setup
functions in spi core to implement cs-gpio control.
Use fsl_lpspi_prepare_message to init the cs_gpio pin.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Acked-by: Fugang Duan <Fugang.duan@nxp.com>
---
V2:
 - use core way to implement cs-gpio control. Removed the redundant code
   in the driver.
---
 drivers/spi/spi-fsl-lpspi.c | 101 +++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 69635cde0e22..a25e0e03f058 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -9,6 +9,7 @@
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -16,8 +17,10 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/spi-imx.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -91,6 +94,7 @@ struct fsl_lpspi_data {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	bool is_slave;
+	bool is_first_byte;
=20
 	void *rx_buf;
 	const void *tx_buf;
@@ -106,6 +110,8 @@ struct fsl_lpspi_data {
 	struct completion xfer_done;
=20
 	bool slave_aborted;
+
+	int chipselect[0];
 };
=20
 static const struct of_device_id fsl_lpspi_dt_ids[] =3D {
@@ -178,6 +184,20 @@ static int lpspi_unprepare_xfer_hardware(struct spi_co=
ntroller *controller)
 	return 0;
 }
=20
+static int fsl_lpspi_prepare_message(struct spi_controller *controller,
+				     struct spi_message *msg)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D
+					spi_controller_get_devdata(controller);
+	struct spi_device *spi =3D msg->spi;
+	int gpio =3D fsl_lpspi->chipselect[spi->chip_select];
+
+	if (gpio_is_valid(gpio))
+		gpio_direction_output(gpio, spi->mode & SPI_CS_HIGH ? 0 : 1);
+
+	return 0;
+}
+
 static void fsl_lpspi_write_tx_fifo(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u8 txfifo_cnt;
@@ -210,8 +230,7 @@ static void fsl_lpspi_read_rx_fifo(struct fsl_lpspi_dat=
a *fsl_lpspi)
 		fsl_lpspi->rx(fsl_lpspi);
 }
=20
-static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi,
-			      bool is_first_xfer)
+static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fsl_lpspi)
 {
 	u32 temp =3D 0;
=20
@@ -227,7 +246,7 @@ static void fsl_lpspi_set_cmd(struct fsl_lpspi_data *fs=
l_lpspi,
 		 * For subsequent transfer, set TCR_CONTC to keep SS asserted.
 		 */
 		temp |=3D TCR_CONT;
-		if (is_first_xfer)
+		if (fsl_lpspi->is_first_byte)
 			temp &=3D ~TCR_CONTC;
 		else
 			temp |=3D TCR_CONTC;
@@ -396,8 +415,7 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_l=
pspi)
 	return 0;
 }
=20
-static int fsl_lpspi_transfer_one(struct spi_controller *controller,
-				  struct spi_device *spi,
+static int fsl_lpspi_pio_transfer(struct spi_controller *controller,
 				  struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
@@ -422,40 +440,27 @@ static int fsl_lpspi_transfer_one(struct spi_controll=
er *controller,
 	return 0;
 }
=20
-static int fsl_lpspi_transfer_one_msg(struct spi_controller *controller,
-				      struct spi_message *msg)
+static int fsl_lpspi_transfer_one(struct spi_controller *controller,
+				  struct spi_device *spi,
+				  struct spi_transfer *t)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
-				spi_controller_get_devdata(controller);
-	struct spi_device *spi =3D msg->spi;
-	struct spi_transfer *xfer;
-	bool is_first_xfer =3D true;
-	int ret =3D 0;
-
-	msg->status =3D 0;
-	msg->actual_length =3D 0;
-
-	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		ret =3D fsl_lpspi_setup_transfer(spi, xfer);
-		if (ret < 0)
-			goto complete;
-
-		fsl_lpspi_set_cmd(fsl_lpspi, is_first_xfer);
-
-		is_first_xfer =3D false;
+					spi_controller_get_devdata(controller);
+	int ret;
=20
-		ret =3D fsl_lpspi_transfer_one(controller, spi, xfer);
-		if (ret < 0)
-			goto complete;
+	fsl_lpspi->is_first_byte =3D true;
+	ret =3D fsl_lpspi_setup_transfer(spi, t);
+	if (ret < 0)
+		return ret;
=20
-		msg->actual_length +=3D xfer->len;
-	}
+	fsl_lpspi_set_cmd(fsl_lpspi);
+	fsl_lpspi->is_first_byte =3D false;
=20
-complete:
-	msg->status =3D ret;
-	spi_finalize_current_message(controller);
+	ret =3D fsl_lpspi_pio_transfer(controller, t);
+	if (ret < 0)
+		return ret;
=20
-	return ret;
+	return 0;
 }
=20
 static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
@@ -531,10 +536,13 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *=
fsl_lpspi)
=20
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
+	struct device_node *np =3D pdev->dev.of_node;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
+	struct spi_imx_master *lpspi_platform_info =3D
+		dev_get_platdata(&pdev->dev);
 	struct resource *res;
-	int ret, irq;
+	int i, ret, irq;
 	u32 temp;
=20
 	if (of_property_read_bool((&pdev->dev)->of_node, "spi-slave"))
@@ -558,7 +566,30 @@ static int fsl_lpspi_probe(struct platform_device *pde=
v)
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
-	controller->transfer_one_message =3D fsl_lpspi_transfer_one_msg;
+	if (!fsl_lpspi->is_slave) {
+		for (i =3D 0; i < controller->num_chipselect; i++) {
+			int cs_gpio =3D of_get_named_gpio(np, "cs-gpios", i);
+
+			if (!gpio_is_valid(cs_gpio) && lpspi_platform_info)
+				cs_gpio =3D lpspi_platform_info->chipselect[i];
+
+			fsl_lpspi->chipselect[i] =3D cs_gpio;
+			if (!gpio_is_valid(cs_gpio))
+				continue;
+
+			ret =3D devm_gpio_request(&pdev->dev,
+						fsl_lpspi->chipselect[i],
+						DRIVER_NAME);
+			if (ret) {
+				dev_err(&pdev->dev, "can't get cs gpios\n");
+				goto out_controller_put;
+			}
+		}
+		controller->cs_gpios =3D fsl_lpspi->chipselect;
+		controller->prepare_message =3D fsl_lpspi_prepare_message;
+	}
+
+	controller->transfer_one =3D fsl_lpspi_transfer_one;
 	controller->prepare_transfer_hardware =3D lpspi_prepare_xfer_hardware;
 	controller->unprepare_transfer_hardware =3D lpspi_unprepare_xfer_hardware=
;
 	controller->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
--=20
2.17.1

