Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C690BC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01102148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfDHUFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:05:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:62441 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbfDHUFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:05:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:05:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="334947714"
Received: from azakbar-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.183.167])
  by fmsmga006.fm.intel.com with ESMTP; 08 Apr 2019 13:05:15 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v2 2/4] soundwire: bus: remove useless initializations
Date:   Mon,  8 Apr 2019 15:04:59 -0500
Message-Id: <20190408200501.9610-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408200501.9610-1-pierre-louis.bossart@linux.intel.com>
References: <20190408200501.9610-1-pierre-louis.bossart@linux.intel.com>
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

