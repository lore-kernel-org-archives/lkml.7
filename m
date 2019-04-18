Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DABC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7C3205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfDRWCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:02:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:59838 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbfDRWCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:02:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 15:02:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,367,1549958400"; 
   d="scan'208";a="137004961"
Received: from agluck-desk.sc.intel.com ([10.3.52.160])
  by orsmga006.jf.intel.com with ESMTP; 18 Apr 2019 15:02:29 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Date:   Thu, 18 Apr 2019 15:02:29 -0700
Message-Id: <20190418220229.32133-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful when running error injection tests that want to
see all of the MCi_(STATUS|ADDR|MISC) data via /dev/mcelog.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/ras/cec.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 2d9ec378a8bc..a2ceedcd8516 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -123,6 +123,9 @@ static u64 dfs_pfn;
 /* Amount of errors after which we offline */
 static unsigned int count_threshold = COUNT_MASK;
 
+/* debugfs switch to enable/disable CEC */
+static u64 cec_enabled = 1;
+
 /*
  * The timer "decays" element count each timer_interval which is 24hrs by
  * default.
@@ -400,6 +403,14 @@ static int count_threshold_set(void *data, u64 val)
 }
 DEFINE_DEBUGFS_ATTRIBUTE(count_threshold_ops, u64_get, count_threshold_set, "%lld\n");
 
+static int enable_set(void *data, u64 val)
+{
+	ce_arr.disabled = !val;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(enable_ops, u64_get, enable_set, "%lld\n");
+
 static int array_dump(struct seq_file *m, void *v)
 {
 	struct ce_array *ca = &ce_arr;
@@ -451,7 +462,7 @@ static const struct file_operations array_ops = {
 
 static int __init create_debugfs_nodes(void)
 {
-	struct dentry *d, *pfn, *decay, *count, *array;
+	struct dentry *d, *pfn, *decay, *count, *array, *enable;
 
 	d = debugfs_create_dir("cec", ras_debugfs_dir);
 	if (!d) {
@@ -485,6 +496,13 @@ static int __init create_debugfs_nodes(void)
 		goto err;
 	}
 
+	enable = debugfs_create_file("enable", S_IRUSR | S_IWUSR, d,
+				    &cec_enabled, &enable_ops);
+	if (!enable) {
+		pr_warn("Error creating enable debugfs node!\n");
+		goto err;
+	}
+
 
 	return 0;
 
-- 
2.19.1

