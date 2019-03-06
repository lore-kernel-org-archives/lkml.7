Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A5BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43FD20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EBAnLgo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfCFGal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:30:41 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:43681
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728923AbfCFGaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxDxsdQeT5aC+/2+/YEUhX2Mb+70RNqGVC+cejgDHzo=;
 b=EBAnLgo6yyKUwjNpDBw6x9WN05aDA8Qd2gvFnw2xE/awq1YTGN2FBMoPQLrnybeyRsr2Yu8G5fOfBMZJ5pPbal45TcCjUsHP7y9Rn1nK8V4hBCcGAvamD0USXXeyq5S+zIS2G6pVTznGD26OBQm94sC3RX5IiF/QlEaKcgEt6WI=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:35 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:35 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/8] spi: lpspi: Add i.MX8 boards support for lpspi
Thread-Topic: [PATCH V2 1/8] spi: lpspi: Add i.MX8 boards support for lpspi
Thread-Index: AQHU0+YaqWPlOUU3tkq25lvThGZA1Q==
Date:   Wed, 6 Mar 2019 06:30:34 +0000
Message-ID: <20190306063020.793-2-xiaoning.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: baef5eca-80c8-4544-db68-08d6a1fd3d30
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:UdLk+kn3A4mwPjpGmBtdAoEoALOvVq2ysPxIEP2?=
 =?iso-8859-1?Q?yxU5T5+rT964PFjk/YhVsTtXCEpjr/4FTaf+5dzXa0VDvodUt2Q0EsSlOh?=
 =?iso-8859-1?Q?8wMRWIkbwG/bRZTDzzvHmCOCtnhWQAk6ZizUa2Q95Rwl0/iLsvhbXzHQI3?=
 =?iso-8859-1?Q?vB7x5VgQZgTvGE2ee6qnqXXS+YMn+xSoWR8xBftp2GHeGBfQddHh7N3fdB?=
 =?iso-8859-1?Q?S33obK0F4LAkveYldqx6iMYBmb34tJ4xmwG7kmnPiqGzWeJCKnyBRYl1pr?=
 =?iso-8859-1?Q?L4RaYV2yUHXMtJgMn/oVp3ZBaB9nrnOS8rTVNTCh3LaobAhl9yTJVXmsJj?=
 =?iso-8859-1?Q?CM7LWqi0iWN1VZZvIHfb6jdcuw28rfP7mF4+U8XvKjlOevxGZVqHO5Rq7K?=
 =?iso-8859-1?Q?P5Byoir1PBSbAwqniqLSL2N8xz+EUYEeU5mlHXJ4Bjn/vc5mIXVP3tiECV?=
 =?iso-8859-1?Q?RcyyMKeS0eOf+cuiyrYd5fTjTPf8uiJy0ps9lEwjdNFBIOLnM/N2WeiOBz?=
 =?iso-8859-1?Q?vTi92RpL9gctp1TibmajNmeXrpZ0/50te2ky2r9bC/V5YUAy60bTUk/yer?=
 =?iso-8859-1?Q?w4dsSSo+1FZGQY2WBkUJp0M4XWiu/+SzRxIV+5C0w8vLCOSMz5+wdfl6XM?=
 =?iso-8859-1?Q?tiL5afnrEWGbP2ACQFZsp1DmTbrMb/nXfzzYOwY0LRd2BmO7agnM8qAbxX?=
 =?iso-8859-1?Q?LFhGoOYQicNG2ZUmzemYfvqsBWqy7choQo1PkRULmkEnXsKyg5KMa0w3xG?=
 =?iso-8859-1?Q?rMuBdgOlI3aZvnPsG7cXXLx1z4GndnwWddiIuDCtBQm5yjRcWotepj6M+5?=
 =?iso-8859-1?Q?kEx/Tw4dtsrd27uzHCNvlcV2567l4f0X+fZd6AnEo5UHc0iFFZfOgDvVhO?=
 =?iso-8859-1?Q?3BEdWyxMNDQfm9BWBitA4u/6AGssK2MJA7bU3FUpEK89MtPhRRPN99DPX2?=
 =?iso-8859-1?Q?U9bh+OtpEgHOHxhvQxrrR0diNz+r2lFnzQCSA2Q7PFrRsV9MZXVSAbjZaW?=
 =?iso-8859-1?Q?PQnrX2J2ISGZSwISZ1/ZB+AtzCpXv4pb1JLYQmeboj87Ke8dj9aSSIJUwv?=
 =?iso-8859-1?Q?jDq6fm+wtNCBc91BMIC+hb3A/rQGlpQbdNbU/OOsllNt73nYTtk4iT1M17?=
 =?iso-8859-1?Q?vOp9nDp8cAN+yK6uLidGh9qfambLhkJiMd4Xowd8m0kWdNTOKMmfbEIoCC?=
 =?iso-8859-1?Q?tFMI+Y2OQa1aDgr6oNajnD+f9Op4gtR5Uu7QILWbIm/LY2+eNXoNOKTwdR?=
 =?iso-8859-1?Q?lebAd+xO+Q6eWbQ0RmmfKLoFdWQE7kGSCtoPlozKYlcAg1VklnXZUaKfjc?=
 =?iso-8859-1?Q?OJXgLNrtfrDOJp9gnrw24YeOQBZJmxuomHfs9uyvSlLdA=3D=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB4373AF5E2E3EA286FF7A6DD6F3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(256004)(105586002)(102836004)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: p0OLTq+XfshWZ/b1rT0Iyk92bTR0RNOGhPZZwsUNiadehp2d+KfhAeSMcJPujgVqVE5S409WYNNTZVsF9IB85grL4cBYEQsUHjno55+h4dbDtVdf5+7kji+W/rGmv7A6cdy3SAACkEXAFRIo/hcEYJHli9PJsFAWpW7IHWJWRYCUKB5WQSiYYOMZqSxG7qI2l5o/zpqaJ9qFAGAJwGT5wqBFV9wGq483PcIeH0oC8E26SitLbnWq1mFE4f8YbR6JJvRojHQx6Wnv9UdrqtmLTH3vTgU+iuc6JNr7UsPraT8g13uAjxwbFyUZ1ZXtOCtZMp9vuD8+quUEGIf4Q7S1IJ3wDx0dAmNl2Tx48CeIvwnImiO4ROzy9otH5HB493HOen4Hh/3zb11uu7TqfuAJXeYkw6KRcy9w+MGFo+ZAxmI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baef5eca-80c8-4544-db68-08d6a1fd3d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:34.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add both ipg and per clock for lpspi to support i.MX8QM/QXP boards.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
V2:
 - No change. But add DT-bindings string at the next patch.
---
 drivers/spi/spi-fsl-lpspi.c | 52 +++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 391863914043..f363c000d24a 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -84,7 +84,8 @@ struct lpspi_config {
 struct fsl_lpspi_data {
 	struct device *dev;
 	void __iomem *base;
-	struct clk *clk;
+	struct clk *clk_ipg;
+	struct clk *clk_per;
 	bool is_slave;
=20
 	void *rx_buf;
@@ -151,8 +152,19 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
roller *controller)
 {
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
+	int ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+		return ret;
+	}
=20
-	return clk_prepare_enable(fsl_lpspi->clk);
+	return 0;
 }
=20
 static int lpspi_unprepare_xfer_hardware(struct spi_controller *controller=
)
@@ -160,7 +172,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
troller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
=20
 	return 0;
 }
@@ -241,7 +254,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data =
*fsl_lpspi)
 	unsigned int perclk_rate, scldiv;
 	u8 prescale;
=20
-	perclk_rate =3D clk_get_rate(fsl_lpspi->clk);
+	perclk_rate =3D clk_get_rate(fsl_lpspi->clk_per);
 	for (prescale =3D 0; prescale < 8; prescale++) {
 		scldiv =3D perclk_rate /
 			 (clkdivs[prescale] * config.speed_hz) - 2;
@@ -526,15 +539,30 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 		goto out_controller_put;
 	}
=20
-	fsl_lpspi->clk =3D devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(fsl_lpspi->clk)) {
-		ret =3D PTR_ERR(fsl_lpspi->clk);
+	fsl_lpspi->clk_per =3D devm_clk_get(&pdev->dev, "per");
+	if (IS_ERR(fsl_lpspi->clk_per)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_per);
+		goto out_controller_put;
+	}
+
+	fsl_lpspi->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
+	if (IS_ERR(fsl_lpspi->clk_ipg)) {
+		ret =3D PTR_ERR(fsl_lpspi->clk_ipg);
+		goto out_controller_put;
+	}
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"can't enable lpspi ipg clock, ret=3D%d\n", ret);
 		goto out_controller_put;
 	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk);
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
 	if (ret) {
-		dev_err(&pdev->dev, "can't enable lpspi clock, ret=3D%d\n", ret);
+		dev_err(&pdev->dev,
+			"can't enable lpspi per clock, ret=3D%d\n", ret);
+		clk_disable_unprepare(fsl_lpspi->clk_ipg);
 		goto out_controller_put;
 	}
=20
@@ -542,7 +570,8 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
@@ -564,7 +593,8 @@ static int fsl_lpspi_remove(struct platform_device *pde=
v)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk);
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
=20
 	return 0;
 }
--=20
2.17.1

