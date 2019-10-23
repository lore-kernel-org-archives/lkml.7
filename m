Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEE3CA9EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637E620659
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407805AbfJWVqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:46:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:39636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407788AbfJWVqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:46:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="196908285"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 14:46:44 -0700
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
Subject: [PATCH 16/18] soundwire: stream: only prepare stream when it is configured.
Date:   Wed, 23 Oct 2019 16:45:59 -0500
Message-Id: <20191023214601.883-17-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
References: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We don't need to prepare the stream again if the stream is already
prepared.

sdw_prepare_stream() could be called multiple times without calling
sdw_deprepare_stream(). We call sdw_prepare_stream() in the prepare
dai ops and sdw_deprepare_stream() in the hw_free dai ops. If an xrun
happens, sdw_prepare_stream() will be called but
sdw_deprepare_stream() will not, which results in an imbalance and an
invalid total bandwidth.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 0a074d445b8d..38375c9124e4 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1544,7 +1544,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream)
  */
 int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 {
-	int ret = 0;
+	int ret;
 
 	if (!stream) {
 		pr_err("SoundWire: Handle not found for stream\n");
@@ -1553,6 +1553,11 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state == SDW_STREAM_PREPARED) {
+		ret = 0;
+		goto state_err;
+	}
+
 	if (stream->state != SDW_STREAM_CONFIGURED &&
 	    stream->state != SDW_STREAM_DEPREPARED &&
 	    stream->state != SDW_STREAM_DISABLED) {
-- 
2.20.1

