Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252B6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B332253D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfLMFEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:04:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:58713 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbfLMFEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:04:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 21:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,308,1571727600"; 
   d="scan'208";a="208340760"
Received: from vbagrodi-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.130.70])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2019 21:04:37 -0800
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
Subject: [PATCH v4 11/15] soundwire: intel: add prepare support in sdw dai driver
Date:   Thu, 12 Dec 2019 23:04:05 -0600
Message-Id: <20191213050409.12776-12-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
References: <20191213050409.12776-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

The existing code does not expose a prepare operation, which is very
much needed to deal with underflow and resume operations.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index adf06833af74..510b7f51826b 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -698,6 +698,21 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
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
@@ -744,6 +759,7 @@ static int intel_pdm_set_sdw_stream(struct snd_soc_dai *dai,
 
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.hw_params = intel_hw_params,
+	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
@@ -751,6 +767,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 
 static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_params = intel_hw_params,
+	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
-- 
2.20.1

