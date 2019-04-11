Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0780AC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5865217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfDKDRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:17:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:50951 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfDKDRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:17:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 20:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,335,1549958400"; 
   d="scan'208";a="160147308"
Received: from slin7-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.204.16])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 20:17:20 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH v3 4/5] soundwire: stream: remove useless initialization of local variable
Date:   Wed, 10 Apr 2019 22:17:00 -0500
Message-Id: <20190411031701.5926-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
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

