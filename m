Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C971C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFFD229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfGYXmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:42:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:51850 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfGYXl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:41:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:41:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="369874860"
Received: from amrutaku-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.255.230.75])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2019 16:41:57 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [RFC PATCH 37/40] soundwire: cadence_master: add hw_reset capability in debugfs
Date:   Thu, 25 Jul 2019 18:40:29 -0500
Message-Id: <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to kick devices into reset and see what software does

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index fa7230b0f200..53278aa2436f 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -331,6 +331,25 @@ static const struct file_operations cdns_reg_fops = {
 	.llseek = default_llseek,
 };
 
+static int cdns_hw_reset(void *data, u64 value)
+{
+	struct sdw_cdns *cdns = data;
+	int ret;
+
+	if (value != 1)
+		return 0;
+
+	dev_info(cdns->dev, "starting link hw_reset\n");
+
+	ret = sdw_cdns_exit_reset(cdns);
+
+	dev_info(cdns->dev, "link hw_reset done\n");
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
+
 /**
  * sdw_cdns_debugfs_init() - Cadence debugfs init
  * @cdns: Cadence instance
@@ -339,6 +358,9 @@ static const struct file_operations cdns_reg_fops = {
 void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
 {
 	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
+
+	debugfs_create_file_unsafe("cdns-hw-reset", 0200, root, cdns,
+				   &cdns_hw_reset_fops);
 }
 EXPORT_SYMBOL_GPL(sdw_cdns_debugfs_init);
 
-- 
2.20.1

