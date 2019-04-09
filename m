Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B5C282DE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48F220880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfDILZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:25:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:34173 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfDILZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:25:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 04:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="159551204"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Apr 2019 04:25:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BE7D2155; Tue,  9 Apr 2019 14:25:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        junxiao.chang@intel.com, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] platform/x86: intel_pmc_ipc: Use BIT() macro
Date:   Tue,  9 Apr 2019 14:25:12 +0300
Message-Id: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use BIT() and BIT_MASK() macros for definitions.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_pmc_ipc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index d37cbd1cf58c..eb0b342996ca 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -41,13 +41,13 @@
  * the IPC1 registers, updates the IPC_STS response register with the status.
  */
 #define IPC_CMD			0x0
-#define		IPC_CMD_MSI		0x100
+#define		IPC_CMD_MSI		BIT(8)
 #define		IPC_CMD_SIZE		16
 #define		IPC_CMD_SUBCMD		12
 #define IPC_STATUS		0x04
-#define		IPC_STATUS_IRQ		0x4
-#define		IPC_STATUS_ERR		0x2
-#define		IPC_STATUS_BUSY		0x1
+#define		IPC_STATUS_IRQ		BIT(2)
+#define		IPC_STATUS_ERR		BIT(1)
+#define		IPC_STATUS_BUSY		BIT(0)
 #define IPC_SPTR		0x08
 #define IPC_DPTR		0x0C
 #define IPC_WRITE_BUFFER	0x80
@@ -107,7 +107,7 @@
 /* PMC register bit definitions */
 
 /* PMC_CFG_REG bit masks */
-#define PMC_CFG_NO_REBOOT_MASK		(1 << 4)
+#define PMC_CFG_NO_REBOOT_MASK		BIT_MASK(4)
 #define PMC_CFG_NO_REBOOT_EN		(1 << 4)
 #define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
 
-- 
2.20.1

