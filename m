Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D8C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918F623403
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbfHUUFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:05:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfHUUFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:05:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:05:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196069779"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:05:40 -0700
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
Subject: [RFC PATCH 07/11] soundwire: intel: improve .config_stream callback, add .free_stream
Date:   Wed, 21 Aug 2019 15:05:17 -0500
Message-Id: <20190821200521.17283-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
References: <20190821200521.17283-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

We need the link_id as a parameter for the config callback, and we
also need a matching free callback in case any resources need to be
released.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c           | 19 +++++++++++++++++--
 include/linux/soundwire/sdw_intel.h |  4 +++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 0001f433e848..529d7bc693d1 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -578,17 +578,31 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 static int intel_config_stream(struct sdw_intel *sdw,
 			       struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai,
-			       struct snd_pcm_hw_params *hw_params, int link_id)
+			       struct snd_pcm_hw_params *hw_params,
+			       int link_id, int alh_stream_id)
 {
 	struct sdw_intel_link_res *res = sdw->res;
 
 	if (res->ops && res->ops->config_stream && res->arg)
 		return res->ops->config_stream(res->arg,
-				substream, dai, hw_params, link_id);
+					       substream, dai, hw_params,
+					       link_id, alh_stream_id);
 
 	return -EIO;
 }
 
+static int intel_free_stream(struct sdw_intel *sdw,
+			     struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai,
+			     int link_id)
+{
+	if (sdw->res->ops && sdw->res->ops->free_stream && sdw->res->arg)
+		return sdw->res->ops->free_stream(sdw->res->arg,
+						  substream, dai, link_id);
+
+	return 0;
+}
+
 /*
  * bank switch routines
  */
@@ -718,6 +732,7 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 	/* Inform DSP about PDI stream number */
 	ret = intel_config_stream(sdw, substream, dai, params,
+				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
 		goto error;
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index c9427cb6020b..c5a2caf3a9d5 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -12,7 +12,9 @@
  */
 struct sdw_intel_ops {
 	int (*config_stream)(void *arg, void *substream,
-			     void *dai, void *hw_params, int stream_num);
+			     void *dai, void *hw_params,
+			     int link_id, int alh_stream_id);
+	int (*free_stream)(void *arg, void *substream, void *dai, int link_id);
 };
 
 /**
-- 
2.20.1

