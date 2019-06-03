Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0494C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00CD280AB
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="vIeTvY32"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfFCMnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:43:46 -0400
Received: from mail-eopbgr750085.outbound.protection.outlook.com ([40.107.75.85]:39902
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727911AbfFCMnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbHAcf+LHBvnC1NtHAHv5kNYrvHSrh0Evik85s8nSIg=;
 b=vIeTvY32HQd0Cdoj4uiSIp5xmwQa6r2LB1Q7uErmFtCWyxDSrtaKme3Y4SppUWoIsO+VtdKfnE0Ge+cxHv15cToscv+wQasPRlpyMyoEqz5IgYlghY74XUloMnfUD1M0slBA3LDy5XR1ShANBSxDR3r+2iLgtBVEZsnUaL4sYYU=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5872.namprd08.prod.outlook.com (20.179.86.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 12:43:35 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::f0f7:f262:a3c6:ce23%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 12:43:35 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Lucas Stach <dev@lynxeye.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chuanhong Guo <gch981213@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 07/12] mtd: spinand: turn SPI NAND to support parameter
 page detection
Thread-Topic: [PATCH v3 07/12] mtd: spinand: turn SPI NAND to support
 parameter page detection
Thread-Index: AdUaBZEnl1jU+7xBQUOxHRT5yHw9jA==
Date:   Mon, 3 Jun 2019 12:43:35 +0000
Message-ID: <MN2PR08MB5951A490A0252C9DD038EA00B8140@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2782c52c-a4df-4d26-833e-08d6e82117e8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR08MB5872;
x-ms-traffictypediagnostic: MN2PR08MB5872:|MN2PR08MB5872:
x-microsoft-antispam-prvs: <MN2PR08MB5872A154232BD58BC451D1AAB8140@MN2PR08MB5872.namprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(376002)(136003)(346002)(39860400002)(366004)(189003)(199004)(76116006)(14454004)(99286004)(7696005)(71200400001)(71190400001)(66446008)(5660300002)(9686003)(52536014)(73956011)(66946007)(66476007)(66066001)(66556008)(64756008)(2201001)(55236004)(6116002)(478600001)(316002)(102836004)(110136005)(2906002)(3846002)(6506007)(86362001)(7416002)(53936002)(486006)(26005)(2501003)(8936002)(476003)(33656002)(14444005)(256004)(8676002)(74316002)(81166006)(81156014)(6436002)(68736007)(7736002)(305945005)(186003)(25786009)(55016002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5872;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IYA2IUj11LscvEmTBtAB6haVhhrx/N+zI3UOSmiRFAr94YQK+85APY1J6blKEVErXQcAC8awetpdKNczsYH8Bao4fW9QgTw2PylhbJ+D4BoYAc+cL4RXD891Ni+PnCCtO2h4tRuM730sGy2+HG1pUYHEcyrETqKoVPkBj/YeahTE2yW8U1ESCYTmk+rINuEUtpmTrh63Sl/o9nHZ0am85MPcLL2Ka6HCRHn1D5wfShJHqzhlKH2BefDqT6r/aQy2fgjJONAKaSM4NhOi0nAKTQu+JIOF3i9WPMoDEeTf6b7/rv9STi9OmrKOEynpttH37iAqVa6O5Pxqp1JfFuStj9q1ujcH5BvIivk74F2ytZmwF7tvSeHG+0WZ3jPH1q3Kb9IcsYeAV9msdvuLtgWTfWUa+0qMHWl4F3xjRTyEP44=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2782c52c-a4df-4d26-833e-08d6e82117e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 12:43:35.0483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sshivamurthy@micron.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instantiate onfi_helper object for SPI NAND.
Enable SPI NAND core to detect SPI NANDs with parameter page.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/core.c | 103 ++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 4c15bb58c623..b031c4a2cdf9 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -400,6 +400,100 @@ static int spinand_lock_block(struct spinand_device *=
spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
=20
+/**
+ * spinand_read_param_page_op - Read parameter page operation
+ * @base: the nand device
+ * @page: page number where parameter page tables can be found
+ * @buf: buffer used to store the parameter page
+ * @len: length of the buffer
+ *
+ * Read parameter page
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int spinand_parameter_page_read(struct nand_device *base,
+				       u8 page, void *buf, unsigned int len)
+{
+	struct spinand_device *spinand =3D nand_to_spinand(base);
+	struct spi_mem_op pread_op =3D SPINAND_PAGE_READ_OP(page);
+	struct spi_mem_op pread_cache_op =3D
+				SPINAND_PAGE_READ_FROM_CACHE_OP(false,
+								0,
+								1,
+								buf,
+								len);
+	u8 feature;
+	u8 status;
+	int ret;
+
+	if (len && !buf)
+		return -EINVAL;
+
+	ret =3D spinand_read_reg_op(spinand, REG_CFG,
+				  &feature);
+	if (ret)
+		return ret;
+
+	/* CFG_OTP_ENABLE is used to enable parameter page access */
+	feature |=3D CFG_OTP_ENABLE;
+
+	spinand_write_reg_op(spinand, REG_CFG, feature);
+
+	ret =3D spi_mem_exec_op(spinand->spimem, &pread_op);
+	if (ret)
+		return ret;
+
+	ret =3D spinand_wait(spinand, &status);
+	if (ret < 0)
+		return ret;
+
+	ret =3D spi_mem_exec_op(spinand->spimem, &pread_cache_op);
+	if (ret)
+		return ret;
+
+	ret =3D spinand_read_reg_op(spinand, REG_CFG,
+				  &feature);
+	if (ret)
+		return ret;
+
+	feature &=3D ~CFG_OTP_ENABLE;
+
+	spinand_write_reg_op(spinand, REG_CFG, feature);
+
+	return 0;
+}
+
+static int check_version(struct nand_device *base,
+			 struct nand_onfi_params *p, int *onfi_version)
+{
+	/*
+	 * SPI NANDs do not necessarily support ONFI standard,
+	 * but, parameter page looks the same as an ONFI table.
+	 */
+	if (!le16_to_cpu(p->revision))
+		*onfi_version =3D 0;
+
+	return 0;
+}
+
+static int spinand_intf_data(struct nand_device *base,
+			     struct nand_onfi_params *p)
+{
+	return 0;
+}
+
+static int spinand_param_page_detect(struct spinand_device *spinand)
+{
+	struct nand_device *base =3D spinand_to_nand(spinand);
+
+	base->helper.page =3D 0x01;
+	base->helper.check_revision =3D check_version;
+	base->helper.parameter_page_read =3D spinand_parameter_page_read;
+	base->helper.init_intf_data =3D spinand_intf_data;
+
+	return nand_onfi_detect(base);
+}
+
 static int spinand_check_ecc_status(struct spinand_device *spinand, u8 sta=
tus)
 {
 	struct nand_device *nand =3D spinand_to_nand(spinand);
@@ -910,6 +1004,15 @@ static int spinand_detect(struct spinand_device *spin=
and)
 		return ret;
 	}
=20
+	if (!spinand->base.memorg.pagesize) {
+		ret =3D spinand_param_page_detect(spinand);
+		if (ret <=3D 0) {
+			dev_err(dev, "no parameter page for %*phN\n",
+				SPINAND_MAX_ID_LEN, spinand->id.data);
+			return -ENODEV;
+		}
+	}
+
 	if (nand->memorg.ntargets > 1 && !spinand->select_target) {
 		dev_err(dev,
 			"SPI NANDs with more than one die must implement ->select_target()\n");
--=20
2.17.1

