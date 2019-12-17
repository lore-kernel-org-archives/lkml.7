Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6978C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83238206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 21:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbfLQVEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 16:04:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:15675 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728548AbfLQVDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 16:03:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 13:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="240561092"
Received: from smcdonal-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.83.42])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2019 13:03:45 -0800
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
Subject: [PATCH v5 17/17] soundwire: intel: use EXPORT_SYMBOL_NS
Date:   Tue, 17 Dec 2019 15:03:14 -0600
Message-Id: <20191217210314.20410-18-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
References: <20191217210314.20410-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The soundwire-intel module exports an 'intel_sdw_driver' structure,
which is declared with a namespace explicitly imported by the
soundwire-intel-init module.

The use of namespaces might be deemed overkill here, but it did help
enforce a proper code partitioning for follow-up patches on clock-stop
support.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c      | 2 +-
 drivers/soundwire/intel_init.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0e77df0a7760..c24b5f30789d 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1225,7 +1225,7 @@ struct sdw_md_driver intel_sdw_driver = {
 	.startup = intel_master_startup,
 	.remove = intel_master_remove,
 };
-EXPORT_SYMBOL(intel_sdw_driver);
+EXPORT_SYMBOL_NS(intel_sdw_driver, SOUNDWIRE_INTEL);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_ALIAS("platform:int-sdw");
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index 0f83907e1bc7..0acb92a3c6d1 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -390,3 +390,4 @@ EXPORT_SYMBOL_NS(sdw_intel_exit, SOUNDWIRE_INTEL_INIT);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Intel Soundwire Init Library");
+MODULE_IMPORT_NS(SOUNDWIRE_INTEL);
-- 
2.20.1

