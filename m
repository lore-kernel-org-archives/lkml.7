Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D65C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF1420675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FM11/1BP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfCFGbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:31:25 -0500
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:43681
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728923AbfCFGao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:30:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7h3YHptgT41jH4vhALSVvw+nmZsWyQfFs7bzY5bUTY=;
 b=FM11/1BPFYhbUpX+TcszZS5LZvM+sdhqTtrupUBp2FqS7eiFFjIz+XWGYUDuWeOopUSUjbH74Q5HOiRFDJq4yizr/gAocmZI4KcMgV12jj77EsRH8VfCnggvH+IlfMBAKfkvHLoXKnF2pIpKIeBjN7RGTm9M1a4sQrwCdPNOyuw=
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com (20.177.34.88) by
 AM6PR04MB4373.eurprd04.prod.outlook.com (20.177.38.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Wed, 6 Mar 2019 06:30:39 +0000
Received: from AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb]) by AM6PR04MB5016.eurprd04.prod.outlook.com
 ([fe80::5841:afe:53fd:42bb%6]) with mapi id 15.20.1665.020; Wed, 6 Mar 2019
 06:30:39 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 3/8] spi: lpspi: enable runtime pm for lpspi
Thread-Topic: [PATCH V2 3/8] spi: lpspi: enable runtime pm for lpspi
Thread-Index: AQHU0+YdkcfLuiZbykin5q3vWUwfTA==
Date:   Wed, 6 Mar 2019 06:30:39 +0000
Message-ID: <20190306063020.793-4-xiaoning.wang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 566b5697-8151-4525-b8a8-08d6a1fd3fa6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4373;
x-ms-traffictypediagnostic: AM6PR04MB4373:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM6PR04MB4373;23:CNbFCH5QkGLFDGzWPWpNeAuAQ0N0Ed6M6IUzaAU?=
 =?iso-8859-1?Q?YI3QJWdIlE5ZTsGhpn3KnLG3tZM99nSheJ4W4PKGGlW7t6kx98R3xQFQnv?=
 =?iso-8859-1?Q?0BIeoPlm0t/bgf4tT36Jzffihc2R4WZWPwRzKV//Ml2frAMMz3CM8R4brz?=
 =?iso-8859-1?Q?7K76quzqV1M7l6UYVB09Y8TDPopUVorWKe0G/fXGqcJelbJj21gNClPohG?=
 =?iso-8859-1?Q?VkSxgOhv5Zwpb/Jv+PM1LUlvhySCjf8KEVDCqbngtcb2Qw4/nwq5j+csNt?=
 =?iso-8859-1?Q?vMNxHXwsRNOxuMnp2cK7/PPOCvZMwm2+d30GMmuWJwo4MvJwgPXr6TmhY1?=
 =?iso-8859-1?Q?FiTolcewtry3oVS+I6cEoMvca2gYKSDPTbbtTDsAoe2m/DCfr8rwfELvS7?=
 =?iso-8859-1?Q?Q7msJH28DIzkpv5UyV/XXjYmTs25jtSqaHyUp3TdT/bs0LYZJZxREBJtgE?=
 =?iso-8859-1?Q?cXsD0vzNH4Ori/3VMKfa+uRFsFID8vTv/W5kwn8V/O1/ZBf+P/tnCds+Bb?=
 =?iso-8859-1?Q?adOc8FOH50Gca8bL2Am5rn6G6Php/18NzLur8vxMLzyWPd3y8zwtRLkdqo?=
 =?iso-8859-1?Q?8gV8JXHorG4XNaE/nx9Dt+Vm1fISzmJUI2WS/HqJgYXibELMT1q6u3aCnz?=
 =?iso-8859-1?Q?0hf4Ev5oWKjn0GrO8pc5Dfxtf6U3N6Kz3SItHuekISl7h5Vm9xsImyUNN7?=
 =?iso-8859-1?Q?iBHPqRmpCJsWSHYIBXkPjgtH0eugACIbg1hamD/wyxa/m/eW/fxP11m6H4?=
 =?iso-8859-1?Q?AIEFOjid7oDVllruCZ5qxJSzvJnelK6Az6wAntTN4xr4eWlhQhyrNy7vJD?=
 =?iso-8859-1?Q?JUw6BJPRqIUrMDMWj7Bj91DgsIP770uhEOPuhC7ERWUFSU0x+hpSQrVjUj?=
 =?iso-8859-1?Q?9AeGpwKY/xU8vBBN17/y53nXpXOaMpAuuISyAxVBWKw1L/VzNKR7t4J0aV?=
 =?iso-8859-1?Q?iXczfvPUi9EPs/3+C7nqDM2M0wopxZ5Tc10HkqwstnDSO94sZ+DsGZVozN?=
 =?iso-8859-1?Q?ledRaemcvDUPT3O0ZA1yyuHKYjkxOoN7IDNNwZegSsqNgRr0mP1RfiT9AP?=
 =?iso-8859-1?Q?0Ik0Rb5wWGCzZRKMD6DErJ1ygoY5i/AR1A29F1z4KLhGniCpAvBHrO67O3?=
 =?iso-8859-1?Q?+aBnafvd2HyezM0PJQbN7rHjphw5Ji+arnMTEhZUEPjZ6IzFcuuHsrslYs?=
 =?iso-8859-1?Q?tHI1Fm+1eyv+mZOhJgKMUd0xr5opG18Rx2zLPEnJYsCLQf1bZjgacAI6A4?=
 =?iso-8859-1?Q?8IxkZ6sc2SQi8b8fBQcR9qbDgms6dW7yi/j3l5Gb18ra2kZNp5abDrFRyZ?=
 =?iso-8859-1?Q?t91Y2hWr3NSoesiBrgxIbY7DF/3PsymTKDqeZCS/GITt7cTYGYMH9V55wQ?=
 =?iso-8859-1?Q?hgM5KmI4=3D?=
x-microsoft-antispam-prvs: <AM6PR04MB43736493CB1F08261DAA199BF3730@AM6PR04MB4373.eurprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(97736004)(6116002)(386003)(8936002)(6506007)(106356001)(52116002)(1730700003)(8676002)(26005)(81156014)(81166006)(14444005)(256004)(105586002)(102836004)(50226002)(2501003)(76176011)(99286004)(6512007)(305945005)(71200400001)(6436002)(5640700003)(6486002)(4326008)(53936002)(71190400001)(476003)(25786009)(486006)(66066001)(2616005)(7736002)(186003)(68736007)(446003)(1076003)(11346002)(54906003)(478600001)(316002)(36756003)(6916009)(2351001)(14454004)(86362001)(2906002)(5660300002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4373;H:AM6PR04MB5016.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zouIrKcvWt6ouoWj7MNa4Xzc0kyXsLC8+y6g+37we3Jtil6x0C89spxmhSgieMxz8HqWDH2sGpi3L6fRYqaeW5RSpTWg4S4OZMvvE1a0T6kBERB3YRK93E4M+smLOQ9+/Kr8jvAQCEbdwgyxZDCfQ0g9cfAk8TfNHnh3iKPnrQAI4V2EoeWr9FhVS5nfCu4NR3BAze9nsSsy48D4qxKKaP14HmYl6YiP9ctTezV0yiPgNF/CscsNlrl5ZPfsfGFf2Z/a1SSqpDBx7sPSI2bpPrbSLbeCjX/fGP9zaMM5+nhCzMUDb/e3zDd5GuAD4AlMVO49Bm//EXJf+CE6ZK7VuqMCKm2CNF0a3yugg3lIPxnQ4L99SCMC73zRDTbNCVtGoy4vctWjrHPSnhw0AaWyJRYidxHxYj3wvN8+QUWHhlg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566b5697-8151-4525-b8a8-08d6a1fd3fa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 06:30:39.0165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

Enable the runtime power management for lpspi module.

Do some adaptation work from kernel 4.9 to 4.14.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>
---
V2:
 - Fix the comment format.
---
 drivers/spi/spi-fsl-lpspi.c | 117 ++++++++++++++++++++++++++++--------
 1 file changed, 92 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index f363c000d24a..84dcb9e176b8 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -16,7 +16,9 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -24,6 +26,8 @@
=20
 #define DRIVER_NAME "fsl_lpspi"
=20
+#define FSL_LPSPI_RPM_TIMEOUT 50 /* 50ms */
+
 /* i.MX7ULP LPSPI registers */
 #define IMX7ULP_VERID	0x0
 #define IMX7ULP_PARAM	0x4
@@ -154,13 +158,9 @@ static int lpspi_prepare_xfer_hardware(struct spi_cont=
roller *controller)
 				spi_controller_get_devdata(controller);
 	int ret;
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
-	if (ret)
-		return ret;
-
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
-	if (ret) {
-		clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	ret =3D pm_runtime_get_sync(fsl_lpspi->dev);
+	if (ret < 0) {
+		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
 		return ret;
 	}
=20
@@ -172,8 +172,8 @@ static int lpspi_unprepare_xfer_hardware(struct spi_con=
troller *controller)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
-	clk_disable_unprepare(fsl_lpspi->clk_per);
+	pm_runtime_mark_last_busy(fsl_lpspi->dev);
+	pm_runtime_put_autosuspend(fsl_lpspi->dev);
=20
 	return 0;
 }
@@ -480,6 +480,45 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id=
)
 	return IRQ_NONE;
 }
=20
+int fsl_lpspi_runtime_resume(struct device *dev)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D dev_get_drvdata(dev);
+	int ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
+	if (ret)
+		return ret;
+
+	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
+	if (ret) {
+		clk_disable_unprepare(fsl_lpspi->clk_per);
+		return ret;
+	}
+
+	return 0;
+}
+
+int fsl_lpspi_runtime_suspend(struct device *dev)
+{
+	struct fsl_lpspi_data *fsl_lpspi =3D dev_get_drvdata(dev);
+
+	clk_disable_unprepare(fsl_lpspi->clk_per);
+	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+
+	return 0;
+}
+
+static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
+{
+	struct device *dev =3D fsl_lpspi->dev;
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FSL_LPSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	return 0;
+}
+
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
 	struct fsl_lpspi_data *fsl_lpspi;
@@ -505,6 +544,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev=
)
=20
 	fsl_lpspi =3D spi_controller_get_devdata(controller);
 	fsl_lpspi->dev =3D &pdev->dev;
+	dev_set_drvdata(&pdev->dev, fsl_lpspi);
 	fsl_lpspi->is_slave =3D of_property_read_bool((&pdev->dev)->of_node,
 						    "spi-slave");
=20
@@ -551,28 +591,21 @@ static int fsl_lpspi_probe(struct platform_device *pd=
ev)
 		goto out_controller_put;
 	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_ipg);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"can't enable lpspi ipg clock, ret=3D%d\n", ret);
+	/* enable the clock */
+	ret =3D fsl_lpspi_init_rpm(fsl_lpspi);
+	if (ret)
 		goto out_controller_put;
-	}
=20
-	ret =3D clk_prepare_enable(fsl_lpspi->clk_per);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"can't enable lpspi per clock, ret=3D%d\n", ret);
-		clk_disable_unprepare(fsl_lpspi->clk_ipg);
-		goto out_controller_put;
+	ret =3D pm_runtime_get_sync(fsl_lpspi->dev);
+	if (ret < 0) {
+		dev_err(fsl_lpspi->dev, "failed to enable clock\n");
+		return ret;
 	}
=20
 	temp =3D readl(fsl_lpspi->base + IMX7ULP_PARAM);
 	fsl_lpspi->txfifosize =3D 1 << (temp & 0x0f);
 	fsl_lpspi->rxfifosize =3D 1 << ((temp >> 8) & 0x0f);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_per);
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
-
 	ret =3D devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_controller error.\n");
@@ -593,16 +626,50 @@ static int fsl_lpspi_remove(struct platform_device *p=
dev)
 	struct fsl_lpspi_data *fsl_lpspi =3D
 				spi_controller_get_devdata(controller);
=20
-	clk_disable_unprepare(fsl_lpspi->clk_per);
-	clk_disable_unprepare(fsl_lpspi->clk_ipg);
+	pm_runtime_disable(fsl_lpspi->dev);
+
+	spi_master_put(controller);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int fsl_lpspi_suspend(struct device *dev)
+{
+	int ret;
+
+	pinctrl_pm_select_sleep_state(dev);
+	ret =3D pm_runtime_force_suspend(dev);
+	return ret;
+}
+
+static int fsl_lpspi_resume(struct device *dev)
+{
+	int ret;
+
+	ret =3D pm_runtime_force_resume(dev);
+	if (ret) {
+		dev_err(dev, "Error in resume: %d\n", ret);
+		return ret;
+	}
+
+	pinctrl_pm_select_default_state(dev);
=20
 	return 0;
 }
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops fsl_lpspi_pm_ops =3D {
+	SET_RUNTIME_PM_OPS(fsl_lpspi_runtime_suspend,
+				fsl_lpspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(fsl_lpspi_suspend, fsl_lpspi_resume)
+};
=20
 static struct platform_driver fsl_lpspi_driver =3D {
 	.driver =3D {
 		.name =3D DRIVER_NAME,
 		.of_match_table =3D fsl_lpspi_dt_ids,
+		.pm =3D &fsl_lpspi_pm_ops,
 	},
 	.probe =3D fsl_lpspi_probe,
 	.remove =3D fsl_lpspi_remove,
--=20
2.17.1

