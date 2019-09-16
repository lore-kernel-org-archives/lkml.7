Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC69C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC10216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbfIPTYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:24:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:60613 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388126AbfIPTX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:23:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 12:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="270291176"
Received: from jvhicko1-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.104.227])
  by orsmga001.jf.intel.com with ESMTP; 16 Sep 2019 12:23:55 -0700
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
Subject: [PATCH 3/6] soundwire: intel: remove playback/capture stream_name
Date:   Mon, 16 Sep 2019 14:23:45 -0500
Message-Id: <20190916192348.467-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
References: <20190916192348.467-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard Liao <yung-chuan.liao@linux.intel.com>

We will create dai widget in SOF.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index c158a1d19a05..8aa513042a4e 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -843,14 +843,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 			return -ENOMEM;
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_OUT) {
-			dais[i].playback.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Tx%d",
-					  cdns->instance, i);
-			if (!dais[i].playback.stream_name) {
-				kfree(dais[i].name);
-				return -ENOMEM;
-			}
-
 			dais[i].playback.channels_min = 1;
 			dais[i].playback.channels_max = max_ch;
 			dais[i].playback.rates = SNDRV_PCM_RATE_48000;
@@ -858,15 +850,6 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 		}
 
 		if (type == INTEL_PDI_BD || type == INTEL_PDI_IN) {
-			dais[i].capture.stream_name =
-				kasprintf(GFP_KERNEL, "SDW%d Rx%d",
-					  cdns->instance, i);
-			if (!dais[i].capture.stream_name) {
-				kfree(dais[i].name);
-				kfree(dais[i].playback.stream_name);
-				return -ENOMEM;
-			}
-
 			dais[i].capture.channels_min = 1;
 			dais[i].capture.channels_max = max_ch;
 			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
-- 
2.20.1

