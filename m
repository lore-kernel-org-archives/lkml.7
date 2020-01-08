Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AC1C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCD920720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgAHRzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:55:00 -0500
Received: from mga09.intel.com ([134.134.136.24]:41182 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgAHRy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:54:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:54:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211617357"
Received: from cozturk-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.17.77])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 09:54:57 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 1/6] soundwire: stream: remove redundant pr_err traces
Date:   Wed,  8 Jan 2020 11:54:33 -0600
Message-Id: <20200108175438.13121-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only keep pr_err to flag critical configuration errors that will
typically only happen during system integration.

For errors on prepare/deprepare/enable/disable, the caller can do a
much better job with more information on the DAI and device that
caused the issue.

Suggested-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e69f94a8c3a8..178ae92b8cc1 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1554,8 +1554,6 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_prepare_stream(stream);
-	if (ret < 0)
-		pr_err("Prepare for stream:%s failed: %d\n", stream->name, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
@@ -1622,8 +1620,6 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_enable_stream(stream);
-	if (ret < 0)
-		pr_err("Enable for stream:%s failed: %d\n", stream->name, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
@@ -1698,8 +1694,6 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 	sdw_acquire_bus_lock(stream);
 
 	ret = _sdw_disable_stream(stream);
-	if (ret < 0)
-		pr_err("Disable for stream:%s failed: %d\n", stream->name, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
@@ -1756,8 +1750,6 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 	ret = _sdw_deprepare_stream(stream);
-	if (ret < 0)
-		pr_err("De-prepare for stream:%d failed: %d\n", ret, ret);
 
 	sdw_release_bus_lock(stream);
 	return ret;
-- 
2.20.1

