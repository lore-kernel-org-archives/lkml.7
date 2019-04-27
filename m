Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CE8C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C122206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 22:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="YSn6uMfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfD0WFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 18:05:19 -0400
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:40773
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbfD0WFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 18:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eyy15l+WTX9G7ryN7C5Ycw8xt+UcwbCw3eYDQZc/T+w=;
 b=YSn6uMfOuMBt3q7hJEwjiF184niPdI3AKTDLNmMYj6IUgpzRbgxP3DthkYyyMk7+VdIu/Jz3K9Jnz62soPkKmuZs8Z1fN+Y7c0ii8BCjl6Xp33IseO3TJszl1iCDbF6D2GWYvpgjtU6yJ+oINPu4rYiL5xqQQG9dKdp1kfpg8lc=
Received: from BL0PR02CA0097.namprd02.prod.outlook.com (2603:10b6:208:51::38)
 by BLUPR02MB148.namprd02.prod.outlook.com (2a01:111:e400:849::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1835.12; Sat, 27
 Apr 2019 22:05:13 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BL0PR02CA0097.outlook.office365.com
 (2603:10b6:208:51::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1835.13 via Frontend
 Transport; Sat, 27 Apr 2019 22:05:13 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1835.13 via Frontend Transport; Sat, 27 Apr 2019 22:05:13 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 27 Apr 2019 23:05:12 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Sat, 27 Apr 2019 23:05:12 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org,
 mark.rutland@arm.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=52636 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hKVRY-0002Gu-35; Sat, 27 Apr 2019 23:05:12 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V3 04/12] misc: xilinx_sdfec: Add open, close and ioctl
Date:   Sat, 27 Apr 2019 23:04:58 +0100
Message-ID: <1556402706-176271-5-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(199004)(189003)(54906003)(110136005)(36756003)(446003)(11346002)(186003)(126002)(426003)(356004)(486006)(36906005)(51416003)(50466002)(7696005)(16586007)(44832011)(2616005)(48376002)(476003)(106002)(336012)(26005)(6666004)(70586007)(26826003)(478600001)(956004)(316002)(70206006)(8676002)(76130400001)(14444005)(9786002)(28376004)(8936002)(246002)(50226002)(93146003)(76176011)(2906002)(5660300002)(2201001)(107886003)(4326008)(71366001)(7636002)(305945005)(60926002)(47776003)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB148;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63dc98b8-3984-4b5f-78a9-08d6cb5c6c2c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:BLUPR02MB148;
X-MS-TrafficTypeDiagnostic: BLUPR02MB148:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB1488E78E2F7DE2F748246C5CB3F0@BLUPR02MB148.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 0020414413
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: GEDRnTsHJ2ggKjxXoxSfqqdmJctLzHEGtDhNo72y5rMiDM1GE1YeuTU4wjQGzDOWt5pUdry2f5je5kJ2lHFY9dtreG4tXhHGmcDvnkIkzBetxTEFHcNPAc8Kshmy5BRi3XEvldEmiZ6AZnoiDZKhfOAsEZNVsWef+xvhvFh3aE7xVR7aHrxadF+1jhYEGl0WNF1qPnPtTPvhTFM0gatBXfHToezKMqjoDNngaODrzQmySWhZl+OHy6osrJ/YFEnvpVylZT7J8MAal3erFu/vyKRu2N9tdK3dfGMuoJOYnWCw3ojSAsCxry23cbZHcN7pJyQ4LscmKFRRtHmz2+4Y4kgA6hNhv/dP6TnH3oukMFtn/vnKWHQmvo/M+XNYpLqh8s0Y6XUw1KsoC48K6MzGyu8jZ+VNRth/Fs5gYv3ZKu8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2019 22:05:13.0166
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dc98b8-3984-4b5f-78a9-08d6cb5c6c2c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB148
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
index ba577fa..9709759 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -39,4 +39,8 @@ struct xsdfec_config {
 	__s32 fec_id;
 };
 
+/*
+ * XSDFEC IOCTL List
+ */
+#define XSDFEC_MAGIC 'f'
 #endif /* __XILINX_SDFEC_H__ */
-- 
2.7.4

