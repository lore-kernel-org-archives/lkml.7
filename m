Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B15C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47702083E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="sUen2vn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfDIKHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:07:14 -0400
Received: from mail-eopbgr750088.outbound.protection.outlook.com ([40.107.75.88]:60835
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfDIKHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8MRF2uU6rgUPEeI5Hfyt7AT6RASv1/dJyQfeBPtsmE=;
 b=sUen2vn/4d193QZLC3fXPbkDDApBYr9SudFVMpOLLWElyV3zvtzBdxpTqcenb4Scx+snD/CnxgnDTIKodOMc0sVqZP1HPTKgwe2aOCnVN5nuAfKL2r4Qt2fi9fxJsooUifnlzXETGlBmI+VuLgpJg0dHLvGWXbFstk8vchRmjdU=
Received: from BYAPR02CA0009.namprd02.prod.outlook.com (2603:10b6:a02:ee::22)
 by SN1PR02MB3839.namprd02.prod.outlook.com (2603:10b6:802:24::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1771.16; Tue, 9 Apr
 2019 10:07:10 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BYAPR02CA0009.outlook.office365.com
 (2603:10b6:a02:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:10 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:10 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
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
        id 1hDnei-0007SJ-Jz; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Date:   Tue, 9 Apr 2019 11:06:46 +0100
Message-ID: <1554804414-206099-5-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(2980300002)(189003)(199004)(47776003)(26005)(26826003)(44832011)(8676002)(476003)(9786002)(478600001)(106466001)(7636002)(2906002)(71366001)(50466002)(186003)(486006)(93146003)(14444005)(336012)(2616005)(446003)(956004)(8936002)(48376002)(76130400001)(426003)(11346002)(28376004)(60926002)(246002)(50226002)(106002)(316002)(110136005)(16586007)(51416003)(126002)(76176011)(107886003)(5660300002)(54906003)(36756003)(7696005)(36906005)(2201001)(305945005)(4326008)(356004)(6666004)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR02MB3839;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 981c563d-3ed5-48ad-5aa0-08d6bcd32151
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:SN1PR02MB3839;
X-MS-TrafficTypeDiagnostic: SN1PR02MB3839:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN1PR02MB38397CABFBBB00C43BA0A1CECB2D0@SN1PR02MB3839.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: q6KIP0hAaIb1Lk61p4ERiIDFPnthQhTtY8ImHCN3wg9wTb+hBzorAIT53e213uh+8+f88oxbbo/lqFDedtM1QTo/Sa0lpWSIYW8Z9he5iiAI5U822AOZFh4svpSCEA5e5yNi0xxvHM/sd+XdPrnosIE7BDYoN/uOof24HJfY6k3g3cdbWnjxsQPyfKGpVCLJGHrz8bVtkj+9lGnrvdXubj/5di9BkTA+j4qUxaMX9Ew3HffESxPNNOPl4dJ9B7cLBQO0jWmGk+6jl1ScQxd3i5oP+XBfzwV/iR6SuTP1i3glsyGQiU8cb319SiS9d6+OhLq8kXh3PY2w9lVrgrybuCVWNfDQccK56fu35zd4HRyRHMDQk20/cLOA9EX+drUs9qsr92mPA4ZFQJ86ULsRmmclQk7ceu0URnGRIxnZC2k=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:10.1013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 981c563d-3ed5-48ad-5aa0-08d6bcd32151
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add char device interface per DT node present and support
file operations:
- open(),
- close(),
- unlocked_ioctl(),
- compat_ioctl().

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 78 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h |  4 +++
 2 files changed, 82 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index a52a5c6..30879ae 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -25,6 +25,7 @@
 #include <linux/uaccess.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
+#include <linux/compat.h>
 
 #include <uapi/misc/xilinx_sdfec.h>
 
@@ -81,8 +82,85 @@ struct xsdfec_dev {
 	struct xsdfec_clks clks;
 };
 
+static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
+{
+	struct xsdfec_dev *xsdfec;
+
+	xsdfec = container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cdev);
+
+	if (!atomic_dec_and_test(&xsdfec->open_count)) {
+		atomic_inc(&xsdfec->open_count);
+		return -EBUSY;
+	}
+
+	fptr->private_data = xsdfec;
+	return 0;
+}
+
+static int xsdfec_dev_release(struct inode *iptr, struct file *fptr)
+{
+	struct xsdfec_dev *xsdfec;
+
+	xsdfec = container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cdev);
+
+	atomic_inc(&xsdfec->open_count);
+	return 0;
+}
+
+static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
+			     unsigned long data)
+{
+	struct xsdfec_dev *xsdfec = fptr->private_data;
+	void __user *arg = NULL;
+	int rval = -EINVAL;
+	int err = 0;
+
+	if (!xsdfec)
+		return rval;
+
+	if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
+		return -ENOTTY;
+
+	/* check if ioctl argument is present and valid */
+	if (_IOC_DIR(cmd) != _IOC_NONE) {
+		arg = (void __user *)data;
+		if (!arg) {
+			dev_err(xsdfec->dev,
+				"xilinx sdfec ioctl argument is NULL Pointer");
+			return rval;
+		}
+	}
+
+	if (err) {
+		dev_err(xsdfec->dev, "Invalid xilinx sdfec ioctl argument");
+		return -EFAULT;
+	}
+
+	switch (cmd) {
+	default:
+		/* Should not get here */
+		dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
+		break;
+	}
+	return rval;
+}
+
+#ifdef CONFIG_COMPAT
+static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
+				    unsigned long data)
+{
+	return xsdfec_dev_ioctl(file, cmd, (unsigned long)compat_ptr(data));
+}
+#endif
+
 static const struct file_operations xsdfec_fops = {
 	.owner = THIS_MODULE,
+	.open = xsdfec_dev_open,
+	.release = xsdfec_dev_release,
+	.unlocked_ioctl = xsdfec_dev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = xsdfec_dev_compat_ioctl,
+#endif
 };
 
 static int xsdfec_clk_init(struct platform_device *pdev,
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index 5543163..5de0add 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -39,4 +39,8 @@ struct xsdfec_config {
 	s32 fec_id;
 };
 
+/*
+ * XSDFEC IOCTL List
+ */
+#define XSDFEC_MAGIC 'f'
 #endif /* __XILINX_SDFEC_H__ */
-- 
2.7.4

