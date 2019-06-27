Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12563C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0567218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfF0FCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 01:02:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:22936 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727394AbfF0FCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:02:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 22:02:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="173005117"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2019 22:02:10 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com,
        gregkh@linuxfoundation.org, atull@kernel.org
Subject: [PATCH v4 11/15] fpga: dfl: afu: export __port_enable/disable function.
Date:   Thu, 27 Jun 2019 12:44:51 +0800
Message-Id: <1561610695-5414-12-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561610695-5414-1-git-send-email-hao.wu@intel.com>
References: <1561610695-5414-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As these two functions are used by other private features. e.g.
in error reporting private feature, it requires to check port status
and reset port for error clearing.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-afu-main.c | 25 ++++++++++++++-----------
 drivers/fpga/dfl-afu.h      |  3 +++
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 65b3e89..c8bc0b5 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -24,14 +24,16 @@
 #define DRV_VERSION	"0.8"
 
 /**
- * port_enable - enable a port
+ * __port_enable - enable a port
  * @pdev: port platform device.
  *
  * Enable Port by clear the port soft reset bit, which is set by default.
  * The AFU is unable to respond to any MMIO access while in reset.
- * port_enable function should only be used after port_disable function.
+ * __port_enable function should only be used after __port_disable function.
+ *
+ * The caller needs to hold lock for protection.
  */
-static void port_enable(struct platform_device *pdev)
+void __port_enable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -54,13 +56,14 @@ static void port_enable(struct platform_device *pdev)
 #define RST_POLL_TIMEOUT 1000 /* us */
 
 /**
- * port_disable - disable a port
+ * __port_disable - disable a port
  * @pdev: port platform device.
  *
- * Disable Port by setting the port soft reset bit, it puts the port into
- * reset.
+ * Disable Port by setting the port soft reset bit, it puts the port into reset.
+ *
+ * The caller needs to hold lock for protection.
  */
-static int port_disable(struct platform_device *pdev)
+int __port_disable(struct platform_device *pdev)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	void __iomem *base;
@@ -106,9 +109,9 @@ static int __port_reset(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = port_disable(pdev);
+	ret = __port_disable(pdev);
 	if (!ret)
-		port_enable(pdev);
+		__port_enable(pdev);
 
 	return ret;
 }
@@ -805,9 +808,9 @@ static int port_enable_set(struct platform_device *pdev, bool enable)
 
 	mutex_lock(&pdata->lock);
 	if (enable)
-		port_enable(pdev);
+		__port_enable(pdev);
 	else
-		ret = port_disable(pdev);
+		ret = __port_disable(pdev);
 	mutex_unlock(&pdata->lock);
 
 	return ret;
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index 0c7630a..35e60c5 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -79,6 +79,9 @@ struct dfl_afu {
 	struct dfl_feature_platform_data *pdata;
 };
 
+void __port_enable(struct platform_device *pdev);
+int __port_disable(struct platform_device *pdev);
+
 void afu_mmio_region_init(struct dfl_feature_platform_data *pdata);
 int afu_mmio_region_add(struct dfl_feature_platform_data *pdata,
 			u32 region_index, u64 region_size, u64 phys, u32 flags);
-- 
1.8.3.1

