Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE8EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCB320863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 10:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=micron.com header.i=@micron.com header.b="hylVb4Gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZKwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:52:37 -0400
Received: from mailout.micron.com ([137.201.242.129]:55846 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730804AbfCZKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 06:52:37 -0400
Received: from mail.micron.com (bowex36e.micron.com [137.201.85.221])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x2QAq5Nw001032;
        Tue, 26 Mar 2019 04:52:05 -0600
Received: from BOWEX17H.micron.com (137.201.20.32) by bowex36e.micron.com
 (137.201.85.221) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 Mar
 2019 04:52:05 -0600
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (137.201.20.7) by
 BOWEX17H.micron.com (137.201.20.32) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 26 Mar 2019 04:52:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN3tLBKUoMu+JZ2j4Ko/ZNOfQvIR738ht3zxVwtgbl4=;
 b=hylVb4GyFy2/+OZLdHHykTlJUeoICr2Emuk1bjkaYsOqLUfsbSovHdW/zn+/O0pDVPTWvn9clwmdwLTXa0b3V1iwPhfBRhk2Ezo/B8kqhPLv4DP7QcyagWkUc7Nh+03l8MxUbQfow+DMi3RMSVBrdl1fbBw2qqmrfeaqKhCRF4s=
Received: from MN2PR08MB5951.namprd08.prod.outlook.com (20.179.85.220) by
 MN2PR08MB5856.namprd08.prod.outlook.com (20.179.87.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 26 Mar 2019 10:52:01 +0000
Received: from MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af]) by MN2PR08MB5951.namprd08.prod.outlook.com
 ([fe80::c561:284f:9768:a4af%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 10:52:01 +0000
From:   "Shivamurthy Shastri (sshivamurthy)" <sshivamurthy@micron.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH 3/4] mtd: spinand: Enabled support to detect parameter page
Thread-Topic: [PATCH 3/4] mtd: spinand: Enabled support to detect parameter
 page
Thread-Index: AdTjwSAFDW7WB7gARZuMWrsA2XWYYg==
Date:   Tue, 26 Mar 2019 10:52:00 +0000
Message-ID: <MN2PR08MB5951E8D99AA1FBD972131388B85F0@MN2PR08MB5951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sshivamurthy@micron.com; 
x-originating-ip: [165.225.81.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e28bbcd-3bb5-4fc5-ca1b-08d6b1d91364
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MN2PR08MB5856;
x-ms-traffictypediagnostic: MN2PR08MB5856:|MN2PR08MB5856:
x-microsoft-antispam-prvs: <MN2PR08MB58569F569A83CEFCBBBDE0D9B85F0@MN2PR08MB5856.namprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(346002)(376002)(199004)(189003)(486006)(476003)(186003)(52536014)(5660300002)(2501003)(26005)(53936002)(25786009)(102836004)(55236004)(66066001)(6436002)(97736004)(9686003)(478600001)(55016002)(2201001)(33656002)(86362001)(14454004)(2906002)(6116002)(3846002)(14444005)(305945005)(99286004)(71190400001)(71200400001)(8676002)(105586002)(81156014)(81166006)(106356001)(7736002)(68736007)(316002)(256004)(7696005)(74316002)(110136005)(54906003)(6506007)(8936002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR08MB5856;H:MN2PR08MB5951.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Qv8po5J3CmliLiYRAOnSevKeTfHH7hyMLsnf9Aizz0RBUuxy3wJ8mes59t+Vz6gkwTABhBMYyQtnGsDgANaQ/ph6T5w/7WZ2lArBbzI7CPDnRe/zit0Jep9UZJUTPQoZyp+m6fkvgWtKi+uypP4kUX/0VpjgXemD0f+jgIkGiknyVfIWHFBwrxpQhRS+qWFfl8HgSoorfYIV+v6D6F0YKjVTXhQF7cgKwfyJ+jNq+yknHCjoFSdNwz1XSwWYNO8pUV9bEGX6llgmvZJkdwk7Jia+wj9ULPLlai+UpuzSshOotmFzoVuRoeXQjZSjmDb6yPD6adbLNp/WjW6CvA1emMBQlijXOVQSDYovdeme2dMF8fFiVTiDzLkEV7YcqHWBm9oqm0jtudt/Kty0EGFJdVnhYQ9/dXrQZecAbeCU3o=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e28bbcd-3bb5-4fc5-ca1b-08d6b1d91364
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 10:52:00.8844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR08MB5856
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24512.005
X-TM-AS-Result: No--5.858500-0.000000-31
X-TM-AS-MatchedID: 700038-704156-702762-708797-701618-700251-700648-700016-7
        00270-188019-706290-708712-700398-300010-701594-780052-851458-702911-701604
        -702426-847298-701384-707663-702898-709908-700811-105250-706561-702037-7000
        23-700059-148004-148007-148020-148050-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the SPI NAND devices has parameter page which is similar to ONFI
table.

But, it may not be self sufficient to propagate all the required
parameters. Fixup function has been added in struct manufacturer to
accommodate this.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/mtd/nand/spi/core.c | 113 +++++++++++++++++++++++++++++++++++-
 include/linux/mtd/spinand.h |   5 ++
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 985ad52cdaa7..40882a1d2bc1 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -574,6 +574,108 @@ static int spinand_lock_block(struct spinand_device *=
spinand, u8 lock)
 	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
 }
=20
+/**
+ * spinand_read_param_page_op - Read parameter page operation
+ * @spinand: the spinand device
+ * @page: page number where parameter page tables can be found
+ * @parameters: buffer used to store the parameter page
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
+	return 1;
+}
+
+static int check_version(struct nand_device *base,
+			 struct nand_onfi_params *p, int *onfi_version)
+{
+	/**
+	 * SPI NAND do not support ONFI standard
+	 * But, parameter page looks same as ONFI table
+	 */
+	if (!le16_to_cpu(p->revision))
+		*onfi_version =3D 0;
+
+	return 1;
+}
+
+static int spinand_intf_data(struct nand_device *base,
+			     struct nand_onfi_params *p)
+{
+	struct spinand_device *spinand =3D nand_to_spinand(base);
+
+	/**
+	 *	Manufacturers may interpret the parameter page differently
+	 */
+	if (spinand->manufacturer->ops->fixup_param_page)
+		spinand->manufacturer->ops->fixup_param_page(spinand, p);
+
+	return 1;
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
 static int spinand_read_page(struct spinand_device *spinand,
 			     const struct nand_page_io_req *req)
 {
@@ -896,7 +998,7 @@ static void spinand_manufacturer_cleanup(struct spinand=
_device *spinand)
 		return spinand->manufacturer->ops->cleanup(spinand);
 }
=20
-static const struct spi_mem_op *
+const struct spi_mem_op *
 spinand_select_op_variant(struct spinand_device *spinand,
 			  const struct spinand_op_variants *variants)
 {
@@ -1012,6 +1114,15 @@ static int spinand_detect(struct spinand_device *spi=
nand)
 		return ret;
 	}
=20
+	if (!spinand->base.memorg.pagesize) {
+		ret =3D spinand_param_page_detect(spinand);
+		if (ret < 0) {
+			dev_err(dev, "no parameter page for %*phN\n",
+				SPINAND_MAX_ID_LEN, spinand->id.data);
+			return ret;
+		}
+	}
+
 	if (nand->memorg.ntargets > 1 && !spinand->select_target) {
 		dev_err(dev,
 			"SPI NANDs with more than one die must implement ->select_target()\n");
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index d093d237fba8..57b3b5b075f2 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -179,6 +179,8 @@ struct spinand_manufacturer_ops {
 	int (*detect)(struct spinand_device *spinand);
 	int (*init)(struct spinand_device *spinand);
 	void (*cleanup)(struct spinand_device *spinand);
+	void (*fixup_param_page)(struct spinand_device *spinand,
+				 struct nand_onfi_params *p);
 };
=20
 /**
@@ -429,4 +431,7 @@ int spinand_match_and_init(struct spinand_device *dev,
 int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
 int spinand_select_target(struct spinand_device *spinand, unsigned int tar=
get);
=20
+const struct spi_mem_op *spinand_select_op_variant(struct spinand_device *=
spinand,
+	   const struct spinand_op_variants *variants);
+
 #endif /* __LINUX_MTD_SPINAND_H */
--=20
2.17.1

