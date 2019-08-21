Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B4C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C0523403
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 20:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbfHUUGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 16:06:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:53248 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbfHUUFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 16:05:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 13:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="196069786"
Received: from smasango-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.252.139.100])
  by fmsmga001.fm.intel.com with ESMTP; 21 Aug 2019 13:05:42 -0700
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
Subject: [RFC PATCH 08/11] soundwire: intel: add prepare support in sdw dai driver
Date:   Wed, 21 Aug 2019 15:05:18 -0500
Message-Id: <20190821200521.17283-9-pierre-louis.bossart@linux.intel.com>
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

It gets sdw runtime information from dai to prepare stream.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 529d7bc693d1..b9ce13d01334 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -769,6 +769,21 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static int intel_prepare(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai)
+{
+	struct sdw_cdns_dma_data *dma;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma) {
+		dev_err(dai->dev, "failed to get dma data in %s",
+			__func__);
+		return -EIO;
+	}
+
+	return sdw_prepare_stream(dma->stream);
+}
+
 static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
@@ -825,6 +840,7 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
+	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
@@ -832,6 +848,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_params = intel_hw_params,
+	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
-- 
2.20.1

