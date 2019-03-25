Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E918C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CE420879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfCYQBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:01:18 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:46818 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfCYQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:01:17 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id B4AF23C00C4;
        Mon, 25 Mar 2019 17:01:15 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zbsQ41msZljZ; Mon, 25 Mar 2019 17:01:04 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 9FFFC3C00DD;
        Mon, 25 Mar 2019 17:01:04 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 25 Mar
 2019 17:01:04 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH 02/10] ALSA: aloop: loopback_timer_start: Support return of error code
Date:   Mon, 25 Mar 2019 17:00:36 +0100
Message-ID: <1553529644-5654-3-git-send-email-twischer@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

This is required for additional timer implementations which could detect
errors and want to throw them.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 70145e6..f0c7b5b 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -169,7 +169,7 @@ static inline unsigned int get_rate_shift(struct loopback_pcm *dpcm)
 }
 
 /* call in cable->lock */
-static void loopback_timer_start(struct loopback_pcm *dpcm)
+static int loopback_timer_start(struct loopback_pcm *dpcm)
 {
 	unsigned long tick;
 	unsigned int rate_shift = get_rate_shift(dpcm);
@@ -185,6 +185,8 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
 	tick = dpcm->period_size_frac - dpcm->irq_pos;
 	tick = (tick + dpcm->pcm_bps - 1) / dpcm->pcm_bps;
 	mod_timer(&dpcm->timer, jiffies + tick);
+
+	return 0;
 }
 
 /* call in cable->lock */
@@ -265,7 +267,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
-	int err, stream = 1 << substream->stream;
+	int err = 0, stream = 1 << substream->stream;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -278,7 +280,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);	
 		cable->running |= stream;
 		cable->pause &= ~stream;
-		loopback_timer_start(dpcm);
+		err = loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -306,7 +308,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);
 		dpcm->last_jiffies = jiffies;
 		cable->pause &= ~stream;
-		loopback_timer_start(dpcm);
+		err = loopback_timer_start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -314,7 +316,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	default:
 		return -EINVAL;
 	}
-	return 0;
+	return err;
 }
 
 static void params_change(struct snd_pcm_substream *substream)
-- 
2.7.4

