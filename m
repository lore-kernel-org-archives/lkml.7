Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A83CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6009320818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="o5t0Rrmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbfDJL5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:57:37 -0400
Received: from mail-eopbgr770073.outbound.protection.outlook.com ([40.107.77.73]:47747
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbfDJL5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SBgCG+RAJNQ45pISLcheqyNCfPnsqZOoCxf4DvpZxg=;
 b=o5t0RrmvbfpybRldkjGsmQzChmFS6iyl8miGIaeByL8VuWzr/T14ufRneu4gN9WbnB1AC/eMsb873rEBkhwa2IvdWFQE0yGGyuA1+PupRtt7iRhuJT44/LF7xquWRZxXZA0hBStI/fstPdjrmhAzdOFq2ESN9dYjoP8IipHVPE8=
Received: from BL0PR02CA0034.namprd02.prod.outlook.com (52.132.26.175) by
 MW2PR02MB3834.namprd02.prod.outlook.com (52.132.178.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 10 Apr 2019 11:57:30 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BL0PR02CA0034.outlook.office365.com
 (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.15 via Frontend
 Transport; Wed, 10 Apr 2019 11:57:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1771.16
 via Frontend Transport; Wed, 10 Apr 2019 11:57:29 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49564 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hEBr6-0008Vk-UN; Wed, 10 Apr 2019 04:57:28 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hEBr1-0002Ip-Qq; Wed, 10 Apr 2019 04:57:23 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x3ABvEK0008209;
        Wed, 10 Apr 2019 04:57:15 -0700
Received: from [172.23.37.108] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <naga.sureshkumar.relli@xilinx.com>)
        id 1hEBqs-0002He-Cy; Wed, 10 Apr 2019 04:57:14 -0700
From:   Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
To:     <yuehaibing@huawei.com>, <vigneshr@ti.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <michal.simek@xilinx.com>, <nagasuresh12@gmail.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [LINUX PATCH v3] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Date:   Wed, 10 Apr 2019 17:27:09 +0530
Message-ID: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: git-send-email 2.7.4
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(396003)(2980300002)(199004)(189003)(50466002)(4326008)(107886003)(2616005)(16586007)(305945005)(2201001)(2906002)(316002)(5660300002)(54906003)(6666004)(336012)(47776003)(48376002)(478600001)(186003)(356004)(50226002)(426003)(106002)(8676002)(126002)(106466001)(26005)(486006)(476003)(9786002)(8936002)(7696005)(81156014)(77096007)(81166006)(36756003)(36386004)(63266004)(51416003)(110136005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR02MB3834;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7fb74bc-9ae0-4ebf-a31d-08d6bdabb544
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:MW2PR02MB3834;
X-MS-TrafficTypeDiagnostic: MW2PR02MB3834:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MW2PR02MB38349426ED1E35B67C646C96AF2E0@MW2PR02MB3834.namprd02.prod.outlook.com>
X-Forefront-PRVS: 00032065B2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3BFf+bbxFMVzCfzXJpILmnkf1Mug02hYWDjABUSmJiaTQ3ciBnDcRs9aq8dPB1ZGtvGQp7aqQo97GszNq919d0m38fxWYGe9UqnXeXYr4ds10TOKbspvwIdS4ZAmzW5x4fOEjSlyNNpSD7tBIimAbbhlYE7p7+iQpTdoYnIWa/V8XjAQI2nFMeUD0fGPle+nfMXbbKV67cZm3Q8zp7sUlCIY3qARy3TeyvcS7TmmcDgKY9ydLTdvVAFkXQWSbML3+1gGs9XY8gURKwZ6uXpj6bEWBQ2DdEpyVK7JnGvlURtdPITh3Ge6WAAgtSwzWNTsfjurB73VqSyRsk7Ni4LNG2WpaUKk2D98JKfwhg2KOz9rOmw1dRFm7BMT9l5Ng1M044Qm2g8QbvHO6oqoq/ojFlpBOAKv81qpUjzsfuf3yOw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2019 11:57:29.3862
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fb74bc-9ae0-4ebf-a31d-08d6bdabb544
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3834
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

When building with CONFIG_SPI_MEM is not set
gc warns this:

drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
---
Changes in v3
 - Updated the Author name
 - Removed extra line between Fixes and rest of the tags
Changes in v2
 - Added static inline to the function spi_mem_default_supports_op();
---
 include/linux/spi/spi-mem.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index eb71e9d..bf399f2 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -295,6 +295,8 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
@@ -310,6 +312,9 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+static inline bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #endif /* CONFIG_SPI_MEM */
 
 int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
@@ -336,9 +341,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
-bool spi_mem_default_supports_op(struct spi_mem *mem,
-				 const struct spi_mem_op *op);
-
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.7.4

