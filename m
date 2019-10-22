Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B65CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3300F2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733039AbfJVXzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:55:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:15717 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbfJVXzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:55:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 16:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="196612849"
Received: from srajamoh-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.20.203])
  by fmsmga008.fm.intel.com with ESMTP; 22 Oct 2019 16:54:59 -0700
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
Subject: [PATCH v3 3/5] soundwire: intel: add helper for initialization
Date:   Tue, 22 Oct 2019 18:54:46 -0500
Message-Id: <20191022235448.17586-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
References: <20191022235448.17586-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move code to helper for reuse in power management routines

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 748f832e14f6..891cd08e6037 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -903,6 +903,15 @@ static struct sdw_master_ops sdw_intel_ops = {
 	.post_bank_switch = intel_post_bank_switch,
 };
 
+static int intel_init(struct sdw_intel *sdw)
+{
+	/* Initialize shim and controller */
+	intel_link_power_up(sdw);
+	intel_shim_init(sdw);
+
+	return sdw_cdns_init(&sdw->cdns);
+}
+
 /*
  * probe and init
  */
@@ -945,11 +954,8 @@ static int intel_probe(struct platform_device *pdev)
 		return 0;
 	}
 
-	/* Initialize shim and controller */
-	intel_link_power_up(sdw);
-	intel_shim_init(sdw);
-
-	ret = sdw_cdns_init(&sdw->cdns);
+	/* Initialize shim, controller and Cadence IP */
+	ret = intel_init(sdw);
 	if (ret)
 		goto err_init;
 
-- 
2.20.1

