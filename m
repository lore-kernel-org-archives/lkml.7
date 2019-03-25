Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B00C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2DA20896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 03:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbfCYDX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 23:23:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:19145 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729518AbfCYDXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 23:23:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Mar 2019 20:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="310109617"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2019 20:23:49 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 02/17] fpga: dfl: fme: align PR buffer size per PR datawidth
Date:   Mon, 25 Mar 2019 11:07:29 +0800
Message-Id: <1553483264-5379-3-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
References: <1553483264-5379-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver checks if input bitstream file size is aligned or
not per PR data width (default 32bits). It requires one additional
step for end user when they generate the bitstream file, padding
extra zeros to bitstream file to align its size per PR data width,
but they don't have to as hardware will drop extra padding bytes
automatically.

In order to simplify the user steps, this patch aligns PR buffer
size per PR data width in driver, to allow user to pass unaligned
size bitstream files to driver.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
 drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index d9ca955..c1fb1fe 100644
--- a/drivers/fpga/dfl-fme-pr.c
+++ b/drivers/fpga/dfl-fme-pr.c
@@ -74,6 +74,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	struct dfl_fme *fme;
 	unsigned long minsz;
 	void *buf = NULL;
+	size_t length;
 	int ret = 0;
 	u64 v;
 
@@ -85,9 +86,6 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	if (port_pr.argsz < minsz || port_pr.flags)
 		return -EINVAL;
 
-	if (!IS_ALIGNED(port_pr.buffer_size, 4))
-		return -EINVAL;
-
 	/* get fme header region */
 	fme_hdr = dfl_get_feature_ioaddr_by_id(&pdev->dev,
 					       FME_FEATURE_ID_HEADER);
@@ -103,7 +101,13 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 		       port_pr.buffer_size))
 		return -EFAULT;
 
-	buf = vmalloc(port_pr.buffer_size);
+	/*
+	 * align PR buffer per PR bandwidth, as HW ignores the extra padding
+	 * data automatically.
+	 */
+	length = ALIGN(port_pr.buffer_size, 4);
+
+	buf = vmalloc(length);
 	if (!buf)
 		return -ENOMEM;
 
@@ -140,7 +144,7 @@ static int fme_pr(struct platform_device *pdev, unsigned long arg)
 	fpga_image_info_free(region->info);
 
 	info->buf = buf;
-	info->count = port_pr.buffer_size;
+	info->count = length;
 	info->region_id = port_pr.port_id;
 	region->info = info;
 
-- 
2.7.4

