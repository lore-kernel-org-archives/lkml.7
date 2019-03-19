Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24D7C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D7F2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="2yhd05Ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCSMEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:04:41 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:34022
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfCSMEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXZkRCJpLrGqaYiSoHiR0+/D0SZCYbpLw4HTThGUP0w=;
 b=2yhd05CafJUQx7WHSYXkeUmc+mqsc40h0UZx6KB5MNR3mUcO61dU9aqa3XqGdJj7gcmP2+uNR8+8mKrwfGa7zL5jkl/SZ2LRaLeWd73azjpUiY+GP1Y5RxU+pQNwH91ZRXcVrTUYO25hjJvkU/snP3cG+ZfTehfWd4sz1tBVEZg=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by BYAPR02MB5911.namprd02.prod.outlook.com (2603:10b6:a03:122::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 12:04:37 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:37 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:36 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:34 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:34 +0000
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=43674 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1h6DTu-0003Ch-5F; Tue, 19 Mar 2019 12:04:34 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 03/12] misc: xilinx_sdfec: Add CCF support
Date:   Tue, 19 Mar 2019 12:04:15 +0000
Message-ID: <1552997064-432700-4-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(189003)(199004)(93146003)(106466001)(107886003)(28376004)(26826003)(48376002)(50466002)(106002)(54906003)(4326008)(356004)(110136005)(6666004)(7696005)(51416003)(5660300002)(5024004)(14444005)(305945005)(76176011)(8746002)(26005)(126002)(8936002)(60926002)(486006)(2906002)(186003)(956004)(2616005)(476003)(446003)(246002)(2201001)(36756003)(44832011)(426003)(8676002)(11346002)(36906005)(316002)(50226002)(71366001)(336012)(478600001)(9786002)(7636002)(47776003)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5911;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2e7793c-bc6e-4bbf-db38-08d6ac630ecd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB5911;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5911:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5911879E92F3BCE3B553764BCB400@BYAPR02MB5911.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: PwVkfRU1mMcpKaSeZR4ZZxsFEmQP/3+mwyekUbITFtRF7i7UIE44VcXUtCuQX6p1X/+PtZxznM8vSnTI4UaT+waeJKPcnqpMGW5sfshDbmFCX7oc5PWbINByGhs+hqeobYmScw7/tcNqPpInz3IarPamb7hQYBWMC15vC/bbSE5f9EYE9iJlIHwlmNQw8EwGRoixnejL3sSMqixVetO0H+ObiFjsXjbynKGFmFF2L6Ppn5pcS82tO3PEf/sbmggdxRpdLZhb7qLvxBYAu0wyVJM6AXEuQ73ImwBJozmtDPGKDixRWXm3h4ShilRxLsbRg5iIH3Wroeph4K5ffuC997PvOwJwr7+QpEYGUEfFNbKUyNKunT51o1MNDGOumYrrputjx0+UBtG8b3aXcOvZa9mCh9wm1ea268GCyw8Jf8M=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:36.4621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e7793c-bc6e-4bbf-db38-08d6ac630ecd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for Linux Clock Control Framework (CCF).
Registers and enables clocks with the Clock Control
Framework (CCF), to prevent shared clocks from been
disabled.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c | 154 ++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 154 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 278754b..a52a5c6 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -37,6 +37,28 @@ static atomic_t xsdfec_ndevs =3D ATOMIC_INIT(0);
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
+       struct clk *core_clk;
+       struct clk *axi_clk;
+       struct clk *din_words_clk;
+       struct clk *din_clk;
+       struct clk *dout_clk;
+       struct clk *dout_words_clk;
+       struct clk *ctrl_clk;
+       struct clk *status_clk;
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
+       struct xsdfec_clks clks;
 };

 static const struct file_operations xsdfec_fops =3D {
        .owner =3D THIS_MODULE,
 };

+static int xsdfec_clk_init(struct platform_device *pdev,
+                          struct xsdfec_clks *clks)
+{
+       int err;
+
+       clks->core_clk =3D devm_clk_get(&pdev->dev, "core_clk");
+       if (IS_ERR(clks->core_clk)) {
+               dev_err(&pdev->dev, "failed to get core_clk");
+               return PTR_ERR(clks->core_clk);
+       }
+
+       clks->axi_clk =3D devm_clk_get(&pdev->dev, "s_axi_aclk");
+       if (IS_ERR(clks->axi_clk)) {
+               dev_err(&pdev->dev, "failed to get axi_clk");
+               return PTR_ERR(clks->axi_clk);
+       }
+
+       clks->din_words_clk =3D devm_clk_get(&pdev->dev, "s_axis_din_words_=
aclk");
+       if (IS_ERR(clks->din_words_clk))
+               clks->din_words_clk =3D NULL;
+
+       clks->din_clk =3D devm_clk_get(&pdev->dev, "s_axis_din_aclk");
+       if (IS_ERR(clks->din_clk))
+               clks->din_clk =3D NULL;
+
+       clks->dout_clk =3D devm_clk_get(&pdev->dev, "m_axis_dout_aclk");
+       if (IS_ERR(clks->dout_clk))
+               clks->dout_clk =3D NULL;
+
+       clks->dout_words_clk =3D
+               devm_clk_get(&pdev->dev, "s_axis_dout_words_aclk");
+       if (IS_ERR(clks->dout_words_clk))
+               clks->dout_words_clk =3D NULL;
+
+       clks->ctrl_clk =3D devm_clk_get(&pdev->dev, "s_axis_ctrl_aclk");
+       if (IS_ERR(clks->ctrl_clk))
+               clks->ctrl_clk =3D NULL;
+
+       clks->status_clk =3D devm_clk_get(&pdev->dev, "m_axis_status_aclk")=
;
+       if (IS_ERR(clks->status_clk))
+               clks->status_clk =3D NULL;
+
+       err =3D clk_prepare_enable(clks->core_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable core_clk (%d)", err);
+               return err;
+       }
+
+       err =3D clk_prepare_enable(clks->axi_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable axi_clk (%d)", err);
+               goto err_disable_core_clk;
+       }
+
+       err =3D clk_prepare_enable(clks->din_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable din_clk (%d)", err);
+               goto err_disable_axi_clk;
+       }
+
+       err =3D clk_prepare_enable(clks->din_words_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable din_words_clk (%d)", =
err);
+               goto err_disable_din_clk;
+       }
+
+       err =3D clk_prepare_enable(clks->dout_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable dout_clk (%d)", err);
+               goto err_disable_din_words_clk;
+       }
+
+       err =3D clk_prepare_enable(clks->dout_words_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable dout_words_clk (%d)",
+                       err);
+               goto err_disable_dout_clk;
+       }
+
+       err =3D clk_prepare_enable(clks->ctrl_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable ctrl_clk (%d)", err);
+               goto err_disable_dout_words_clk;
+       }
+
+       err =3D clk_prepare_enable(clks->status_clk);
+       if (err) {
+               dev_err(&pdev->dev, "failed to enable status_clk (%d)\n", e=
rr);
+               goto err_disable_ctrl_clk;
+       }
+
+       return err;
+
+err_disable_ctrl_clk:
+       clk_disable_unprepare(clks->ctrl_clk);
+err_disable_dout_words_clk:
+       clk_disable_unprepare(clks->dout_words_clk);
+err_disable_dout_clk:
+       clk_disable_unprepare(clks->dout_clk);
+err_disable_din_words_clk:
+       clk_disable_unprepare(clks->din_words_clk);
+err_disable_din_clk:
+       clk_disable_unprepare(clks->din_clk);
+err_disable_axi_clk:
+       clk_disable_unprepare(clks->axi_clk);
+err_disable_core_clk:
+       clk_disable_unprepare(clks->core_clk);
+
+       return err;
+}
+
+static void xsdfec_disable_all_clks(struct xsdfec_clks *clks)
+{
+       clk_disable_unprepare(clks->status_clk);
+       clk_disable_unprepare(clks->ctrl_clk);
+       clk_disable_unprepare(clks->dout_words_clk);
+       clk_disable_unprepare(clks->dout_clk);
+       clk_disable_unprepare(clks->din_words_clk);
+       clk_disable_unprepare(clks->din_clk);
+       clk_disable_unprepare(clks->core_clk);
+       clk_disable_unprepare(clks->axi_clk);
+}
+
 static int xsdfec_probe(struct platform_device *pdev)
 {
        struct xsdfec_dev *xsdfec;
@@ -77,6 +224,10 @@ static int xsdfec_probe(struct platform_device *pdev)
        xsdfec->config.fec_id =3D atomic_read(&xsdfec_ndevs);
        spin_lock_init(&xsdfec->irq_lock);

+       err =3D xsdfec_clk_init(pdev, &xsdfec->clks);
+       if (err)
+               return err;
+
        dev =3D xsdfec->dev;
        res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
        xsdfec->regs =3D devm_ioremap_resource(dev, res);
@@ -124,6 +275,7 @@ static int xsdfec_probe(struct platform_device *pdev)
 err_xsdfec_cdev:
        cdev_del(&xsdfec->xsdfec_cdev);
 err_xsdfec_dev:
+       xsdfec_disable_all_clks(&xsdfec->clks);
        return err;
 }

@@ -141,6 +293,8 @@ static int xsdfec_remove(struct platform_device *pdev)
                return -EIO;
        }

+       xsdfec_disable_all_clks(&xsdfec->clks);
+
        device_destroy(xsdfec_class,
                       MKDEV(MAJOR(xsdfec_devt), xsdfec->config.fec_id));
        cdev_del(&xsdfec->xsdfec_cdev);
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
