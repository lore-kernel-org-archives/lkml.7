Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F11C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0826420726
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 07:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfLCHf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 02:35:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:33808 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfLCHf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 02:35:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Dec 2019 23:35:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="235778260"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2019 23:35:27 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Brent Lu <brent.lu@intel.com>
Subject: [PATCH] ASoC: da7219: remove SRM lock check retry
Date:   Tue,  3 Dec 2019 15:31:05 +0800
Message-Id: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For platforms not able to provide WCLK in the PREPARED runtime state, it
takes 400ms for codec driver to print the message "SRM failed to lock" in
the da7219_dai_event() function which is called when DAPM widgets are
powering up. The latency penalty to audio input/output is too much so the
retry (8 times) and delay (50ms each retry) are removed.

Another reason is current Cold output latency requirement in Android CDD is
500ms but will be reduced to 200ms for 2021 platforms. With the 400ms
latency it would be difficult to pass the Android CTS test.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/codecs/da7219.c | 3 ++-
 sound/soc/codecs/da7219.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index f83a6ea..042e701 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -833,7 +833,8 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 				srm_lock = true;
 			} else {
 				++i;
-				msleep(50);
+				if (i < DA7219_SRM_CHECK_RETRIES)
+					msleep(50);
 			}
 		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
 
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 88b67fe..3149986 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -770,7 +770,7 @@
 #define DA7219_PLL_INDIV_36_TO_54_MHZ_VAL	16
 
 /* SRM */
-#define DA7219_SRM_CHECK_RETRIES	8
+#define DA7219_SRM_CHECK_RETRIES	1
 
 /* System Controller */
 #define DA7219_SYS_STAT_CHECK_RETRIES	6
-- 
2.7.4

