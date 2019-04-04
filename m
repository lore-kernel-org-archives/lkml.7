Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7342C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E1B206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfDDSWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:22:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:44491 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729619AbfDDSWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:22:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 11:22:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="220617806"
Received: from qcummins-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.110.11])
  by orsmga001.jf.intel.com with ESMTP; 04 Apr 2019 11:22:11 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 3/3] soundwire: stream: remove useless initialization of local variable
Date:   Thu,  4 Apr 2019 13:22:04 -0500
Message-Id: <20190404182204.31262-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no need to reset return value.

Detected with cppcheck:
[drivers/soundwire/stream.c:332]: (style) Variable 'ret' is assigned a
value that is never used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e3d2bc5cba80..ab64c2c4c33f 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -329,7 +329,7 @@ static int sdw_enable_disable_master_ports(struct sdw_master_runtime *m_rt,
 	struct sdw_transport_params *t_params = &p_rt->transport_params;
 	struct sdw_bus *bus = m_rt->bus;
 	struct sdw_enable_ch enable_ch;
-	int ret = 0;
+	int ret;
 
 	enable_ch.port_num = p_rt->num;
 	enable_ch.ch_mask = p_rt->ch_mask;
-- 
2.17.1

