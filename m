Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED4EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A28020862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbfEVTsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:48:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:47986 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731880AbfEVTsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:48:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 May 2019 12:48:03 -0700
X-ExtLoop1: 1
Received: from cjpowell-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.154.39])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2019 12:48:02 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 11/15] soundwire: cadence_master: log Slave status mask on errors
Date:   Wed, 22 May 2019 14:47:27 -0500
Message-Id: <20190522194732.25704-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
References: <20190522194732.25704-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Slave status mask exposes 4 sticky bits. When the device loses
sync, the IP will report two status but the log will only show that
the device lost sync. The status mask has all the information needed
so let's report it instead.

Also change the resolution of the mask, using 64 bits is not needed
when you need 4.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 6f4184f5256c..a505d74ab461 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -486,7 +486,8 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 {
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	bool is_slave = false;
-	u64 slave, mask;
+	u64 slave;
+	u32 mask;
 	int i, set_status;
 
 	/* combine the two status */
@@ -526,7 +527,7 @@ static int cdns_update_slave_status(struct sdw_cdns *cdns,
 		if (set_status > 1) {
 			dev_warn_ratelimited(cdns->dev,
 					     "Slave reported multiple Status: %d\n",
-					     status[i]);
+					     mask);
 			/*
 			 * TODO: we need to reread the status here by
 			 * issuing a PING cmd
-- 
2.20.1

