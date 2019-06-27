Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AC5C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69922189F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfF0FCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 01:02:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:22916 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbfF0FBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:01:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 22:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="173005029"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga002.jf.intel.com with ESMTP; 26 Jun 2019 22:01:53 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com,
        gregkh@linuxfoundation.org, atull@kernel.org
Subject: [PATCH v4 03/15] fpga: dfl: fme: align PR buffer size per PR datawidth
Date:   Thu, 27 Jun 2019 12:44:43 +0800
Message-Id: <1561610695-5414-4-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561610695-5414-1-git-send-email-hao.wu@intel.com>
References: <1561610695-5414-1-git-send-email-hao.wu@intel.com>
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
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/dfl-fme-pr.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/dfl-fme-pr.c b/drivers/fpga/dfl-fme-pr.c
index 6ec0f09..3c71dc3 100644
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
1.8.3.1

