Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BF8C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D14F20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfDDSWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:22:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:44491 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfDDSWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:22:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 11:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="220617796"
Received: from qcummins-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.110.11])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2019 11:22:10 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 2/3] soundwire: bus: remove useless initializations
Date:   Thu,  4 Apr 2019 13:22:03 -0500
Message-Id: <20190404182204.31262-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for explicit initialization of page and ssp fields, they are
already zeroed with a memset.

Detected with cppcheck:

[drivers/soundwire/bus.c:309]: (style) Variable 'msg->page' is
reassigned a value before the old one has been used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/bus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 691a31df9732..bb697fd68580 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -271,8 +271,6 @@ int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
 	msg->dev_num = dev_num;
 	msg->flags = flags;
 	msg->buf = buf;
-	msg->ssp_sync = false;
-	msg->page = false;
 
 	if (addr < SDW_REG_NO_PAGE) { /* no paging area */
 		return 0;
-- 
2.17.1

