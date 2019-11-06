Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31032C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02698217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfKFTOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:14:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:4046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732005AbfKFTOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:14:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 11:14:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="402465837"
Received: from vidhipat-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.33.70])
  by fmsmga005.fm.intel.com with ESMTP; 06 Nov 2019 11:14:17 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 09/14] soundwire: add device driver to sdw_md_driver
Date:   Wed,  6 Nov 2019 13:13:53 -0600
Message-Id: <20191106191358.5712-10-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
References: <20191106191358.5712-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Setting an device driver is necessary for ASoC to register DAI
components.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c     | 4 ++++
 drivers/soundwire/master.c    | 2 ++
 include/linux/soundwire/sdw.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ba3bc410d816..492684ba08c3 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1059,6 +1059,10 @@ static int intel_master_remove(struct sdw_master_device *md)
 }
 
 struct sdw_md_driver intel_sdw_driver = {
+	.driver = {
+		.name = "intel-sdw",
+		.owner = THIS_MODULE,
+	},
 	.probe = intel_master_probe,
 	.startup = intel_master_startup,
 	.remove = intel_master_remove,
diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 6210098c892b..d23111d43fd6 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -57,6 +57,8 @@ struct sdw_master_device *sdw_md_add(struct sdw_md_driver *driver,
 		put_device(&md->dev);
 	}
 
+	md->dev.driver = &driver->driver;
+
 	return md;
 }
 EXPORT_SYMBOL(sdw_md_add);
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 9efb71e9d2f6..17ec786d3a15 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -621,6 +621,7 @@ struct sdw_md_driver {
 	 */
 	int (*autonomous_clock_stop_enable)(struct sdw_master_device *md,
 					    bool state);
+	struct device_driver driver;
 };
 
 #define SDW_SLAVE_ENTRY(_mfg_id, _part_id, _drv_data) \
-- 
2.20.1

