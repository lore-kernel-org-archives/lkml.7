Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03191C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B280D20857
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AeVo3cG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfDIKIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:08:17 -0400
Received: from mail-eopbgr720066.outbound.protection.outlook.com ([40.107.72.66]:15854
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbfDIKHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KG6tPgbFXqsNx0PbtL/51rJKF6iU6ts7qJXoIywukE=;
 b=AeVo3cG0aRE6fs1rbY6sFCxk9VUeuKfC9eWtiCYxy3GwNAKMZe5IIclB6vW6fjFuZaJ9LWbbYoXB9ycGXg1QDBaxlll2ul40DTvcLs92lnJTdbEdUDZCqHfTUWER3c8kHeDm2L0mn2l3RaEb6Bxzl91laZMqqdjf8V60cZqe1wk=
Received: from BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25)
 by BLUPR02MB146.namprd02.prod.outlook.com (2a01:111:e400:849::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1771.21; Tue, 9
 Apr 2019 10:07:12 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN7PR02CA0012.outlook.office365.com
 (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:05 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:05 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 9 Apr 2019 11:07:04 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 9 Apr 2019 11:07:04 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=57788 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hDnei-0007SJ-JR; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 03/12] misc: xilinx_sdfec: Add CCF support
Date:   Tue, 9 Apr 2019 11:06:45 +0100
Message-ID: <1554804414-206099-4-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(2980300002)(189003)(199004)(14444005)(28376004)(2616005)(126002)(476003)(246002)(956004)(51416003)(7696005)(26005)(305945005)(486006)(446003)(2906002)(76176011)(426003)(7636002)(336012)(50466002)(5660300002)(2201001)(186003)(107886003)(11346002)(106466001)(48376002)(93146003)(36756003)(76130400001)(4326008)(8936002)(9786002)(50226002)(478600001)(47776003)(54906003)(106002)(110136005)(16586007)(356004)(316002)(36906005)(71366001)(8676002)(6666004)(44832011)(60926002)(26826003)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB146;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70798c14-3a3d-45f1-a20e-08d6bcd31ea6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR02MB146;
X-MS-TrafficTypeDiagnostic: BLUPR02MB146:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB146552E6188887DA2E5001FCB2D0@BLUPR02MB146.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wQ+0okuGGpNC6wO17BL9aIiFqTjVk9/BjyBYC8br6AnZ1HFowKM/chhYgzdBVEgr/4Qs/9M/OHpN5G+h8owhSaoyx14A5Zpit+BFf/ZnbY2EwLRKv57Z4IrRe/CLtLxDR/rd+4tht/aAVu9xeFXtK+Bm5o4omhNu8yG5g93ZSQX8WP3MZqgxxJj3IcSIlrBj9EbQ2ktli6mPGV+LJo0KcZUpf3qKooPhGRVSF09ZgspLEkVz2Zt+BcKo3jklq1sJFvIb8dERtd/obejuZhP6qXLCuaFbnByhZ/2V2kmxwsLyRNQiBHPVP1lShLak56RcPJdAICDvHEcnRc1C5xAmujSWrGCzx+CBjRPrdx9Op1WLhBhAfr1uthVMYx7Z6Grw2tjQYPoSpvlQo7oQJDVFnKeGUpEGZaQ5mDIZEL9PLn8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:05.6250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70798c14-3a3d-45f1-a20e-08d6bcd31ea6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for Linux Clock Control Framework (CCF).
Registers and enables clocks with the Clock Control
Framework (CCF), to prevent shared clocks from been
disabled.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c | 154 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 278754b..a52a5c6 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -37,6 +37,28 @@ static atomic_t xsdfec_ndevs = ATOMIC_INIT(0);
 static dev_t xsdfec_devt;
 
 /**
+ * struct xsdfec_clks - For managing SD-FEC clocks
+ * @core_clk: Main processing clock for core
+ * @axi_clk: AXI4-Lite memory-mapped clock
+ * @din_words_clk: DIN Words AXI4-Stream Slave clock
+ * @din_clk: DIN AXI4-Stream Slave clock
+ * @dout_clk: DOUT Words AXI4-Stream Slave clock
+ * @dout_words_clk: DOUT AXI4-Stream Slave clock
+ * @ctrl_clk: Control AXI4-Stream Slave clock
+ * @status_clk: Status AXI4-Stream Slave clock
+ */
+struct xsdfec_clks {
+	struct clk *core_clk;
+	struct clk *axi_clk;
+	struct clk *din_words_clk;
+	struct clk *din_clk;
+	struct clk *dout_clk;
+	struct clk *dout_words_clk;
+	struct clk *ctrl_clk;
+	struct clk *status_clk;
+};
+
+/**
  * struct xsdfec_dev - Driver data for SDFEC
  * @regs: device physical base address
  * @dev: pointer to device struct
@@ -44,6 +66,7 @@ static dev_t xsdfec_devt;
  * @open_count: Count of char device being opened
  * @xsdfec_cdev: Character device handle
  * @irq_lock: Driver spinlock
+ * @clks: Clocks managed by the SDFEC driver
  *
  * This structure contains necessary state for SDFEC driver to operate
  */
@@ -55,12 +78,136 @@ struct xsdfec_dev {
 	struct cdev xsdfec_cdev;
 	/* Spinlock to protect state_updated and stats_updated */
 	spinlock_t irq_lock;
+	struct xsdfec_clks clks;
 };
 
 static const struct file_operations xsdfec_fops = {
 	.owner = THIS_MODULE,
 };
 
+static int xsdfec_clk_init(struct platform_device *pdev,
+			   struct xsdfec_clks *clks)
+{
+	int err;
+
+	clks->core_clk = devm_clk_get(&pdev->dev, "core_clk");
+	if (IS_ERR(clks->core_clk)) {
+		dev_err(&pdev->dev, "failed to get core_clk");
+		return PTR_ERR(clks->core_clk);
+	}
+
+	clks->axi_clk = devm_clk_get(&pdev->dev, "s_axi_aclk");
+	if (IS_ERR(clks->axi_clk)) {
+		dev_err(&pdev->dev, "failed to get axi_clk");
+		return PTR_ERR(clks->axi_clk);
+	}
+
+	clks->din_words_clk = devm_clk_get(&pdev->dev, "s_axis_din_words_aclk");
+	if (IS_ERR(clks->din_words_clk))
+		clks->din_words_clk = NULL;
+
+	clks->din_clk = devm_clk_get(&pdev->dev, "s_axis_din_aclk");
+	if (IS_ERR(clks->din_clk))
+		clks->din_clk = NULL;
+
+	clks->dout_clk = devm_clk_get(&pdev->dev, "m_axis_dout_aclk");
+	if (IS_ERR(clks->dout_clk))
+		clks->dout_clk = NULL;
+
+	clks->dout_words_clk =
+		devm_clk_get(&pdev->dev, "s_axis_dout_words_aclk");
+	if (IS_ERR(clks->dout_words_clk))
+		clks->dout_words_clk = NULL;
+
+	clks->ctrl_clk = devm_clk_get(&pdev->dev, "s_axis_ctrl_aclk");
+	if (IS_ERR(clks->ctrl_clk))
+		clks->ctrl_clk = NULL;
+
+	clks->status_clk = devm_clk_get(&pdev->dev, "m_axis_status_aclk");
+	if (IS_ERR(clks->status_clk))
+		clks->status_clk = NULL;
+
+	err = clk_prepare_enable(clks->core_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable core_clk (%d)", err);
+		return err;
+	}
+
+	err = clk_prepare_enable(clks->axi_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable axi_clk (%d)", err);
+		goto err_disable_core_clk;
+	}
+
+	err = clk_prepare_enable(clks->din_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable din_clk (%d)", err);
+		goto err_disable_axi_clk;
+	}
+
+	err = clk_prepare_enable(clks->din_words_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable din_words_clk (%d)", err);
+		goto err_disable_din_clk;
+	}
+
+	err = clk_prepare_enable(clks->dout_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable dout_clk (%d)", err);
+		goto err_disable_din_words_clk;
+	}
+
+	err = clk_prepare_enable(clks->dout_words_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable dout_words_clk (%d)",
+			err);
+		goto err_disable_dout_clk;
+	}
+
+	err = clk_prepare_enable(clks->ctrl_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable ctrl_clk (%d)", err);
+		goto err_disable_dout_words_clk;
+	}
+
+	err = clk_prepare_enable(clks->status_clk);
+	if (err) {
+		dev_err(&pdev->dev, "failed to enable status_clk (%d)\n", err);
+		goto err_disable_ctrl_clk;
+	}
+
+	return err;
+
+err_disable_ctrl_clk:
+	clk_disable_unprepare(clks->ctrl_clk);
+err_disable_dout_words_clk:
+	clk_disable_unprepare(clks->dout_words_clk);
+err_disable_dout_clk:
+	clk_disable_unprepare(clks->dout_clk);
+err_disable_din_words_clk:
+	clk_disable_unprepare(clks->din_words_clk);
+err_disable_din_clk:
+	clk_disable_unprepare(clks->din_clk);
+err_disable_axi_clk:
+	clk_disable_unprepare(clks->axi_clk);
+err_disable_core_clk:
+	clk_disable_unprepare(clks->core_clk);
+
+	return err;
+}
+
+static void xsdfec_disable_all_clks(struct xsdfec_clks *clks)
+{
+	clk_disable_unprepare(clks->status_clk);
+	clk_disable_unprepare(clks->ctrl_clk);
+	clk_disable_unprepare(clks->dout_words_clk);
+	clk_disable_unprepare(clks->dout_clk);
+	clk_disable_unprepare(clks->din_words_clk);
+	clk_disable_unprepare(clks->din_clk);
+	clk_disable_unprepare(clks->core_clk);
+	clk_disable_unprepare(clks->axi_clk);
+}
+
 static int xsdfec_probe(struct platform_device *pdev)
 {
 	struct xsdfec_dev *xsdfec;
@@ -77,6 +224,10 @@ static int xsdfec_probe(struct platform_device *pdev)
 	xsdfec->config.fec_id = atomic_read(&xsdfec_ndevs);
 	spin_lock_init(&xsdfec->irq_lock);
 
+	err = xsdfec_clk_init(pdev, &xsdfec->clks);
+	if (err)
+		return err;
+
 	dev = xsdfec->dev;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	xsdfec->regs = devm_ioremap_resource(dev, res);
@@ -124,6 +275,7 @@ static int xsdfec_probe(struct platform_device *pdev)
 err_xsdfec_cdev:
 	cdev_del(&xsdfec->xsdfec_cdev);
 err_xsdfec_dev:
+	xsdfec_disable_all_clks(&xsdfec->clks);
 	return err;
 }
 
@@ -141,6 +293,8 @@ static int xsdfec_remove(struct platform_device *pdev)
 		return -EIO;
 	}
 
+	xsdfec_disable_all_clks(&xsdfec->clks);
+
 	device_destroy(xsdfec_class,
 		       MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_id));
 	cdev_del(&xsdfec->xsdfec_cdev);
-- 
2.7.4

