Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBAEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1122C20880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfDILZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:25:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:30218 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfDILZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:25:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 04:25:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="134230789"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 09 Apr 2019 04:25:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DD1022E9; Tue,  9 Apr 2019 14:25:15 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        junxiao.chang@intel.com, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] platform/x86: intel_punit_ipc: Revert "Fix resource ioremap warning"
Date:   Tue,  9 Apr 2019 14:25:15 +0300
Message-Id: <20190409112515.84725-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
References: <20190409112515.84725-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a proper fix for intel_pmc_ipc driver for resource management,
get rid of unneeded commit in the intel_punit_ipc driver.

This reverts commit 6cc8cbbc8868033f279b63e98b26b75eaa0006ab.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_punit_ipc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel_punit_ipc.c b/drivers/platform/x86/intel_punit_ipc.c
index 79671927f4ef..ab7ae1950867 100644
--- a/drivers/platform/x86/intel_punit_ipc.c
+++ b/drivers/platform/x86/intel_punit_ipc.c
@@ -252,28 +252,28 @@ static int intel_punit_get_bars(struct platform_device *pdev)
 	 * - GTDRIVER_IPC BASE_IFACE
 	 */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (res && resource_size(res) > 1) {
+	if (res) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[ISPDRIVER_IPC][BASE_DATA] = addr;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
-	if (res && resource_size(res) > 1) {
+	if (res) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[ISPDRIVER_IPC][BASE_IFACE] = addr;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 4);
-	if (res && resource_size(res) > 1) {
+	if (res) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[GTDRIVER_IPC][BASE_DATA] = addr;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 5);
-	if (res && resource_size(res) > 1) {
+	if (res) {
 		addr = devm_ioremap_resource(&pdev->dev, res);
 		if (!IS_ERR(addr))
 			punit_ipcdev->base[GTDRIVER_IPC][BASE_IFACE] = addr;
-- 
2.20.1

