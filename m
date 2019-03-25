Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03521C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C28208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfCYQBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:01:37 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:46829 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbfCYQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:01:25 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 87C133C00DD;
        Mon, 25 Mar 2019 17:01:22 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W0r9sNwF8bGB; Mon, 25 Mar 2019 17:01:15 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 889893C013F;
        Mon, 25 Mar 2019 17:01:05 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Mon, 25 Mar
 2019 17:01:04 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH 04/10] ALSA: aloop: Use always spin_lock_irqsave() for cable->lock
Date:   Mon, 25 Mar 2019 17:00:38 +0100
Message-ID: <1553529644-5654-5-git-send-email-twischer@de.adit-jv.com>
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

to allow the usage of timer callbacks from interrupt context.
For example the sound timer.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 11e8ed6..c6217c4 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -272,6 +272,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct loopback_pcm *dpcm = runtime->private_data;
 	struct loopback_cable *cable = dpcm->cable;
 	int err = 0, stream = 1 << substream->stream;
+	unsigned long flags;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -281,39 +282,39 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		dpcm->last_jiffies = jiffies;
 		dpcm->pcm_rate_shift = 0;
 		dpcm->last_drift = 0;
-		spin_lock(&cable->lock);	
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->running |= stream;
 		cable->pause &= ~stream;
 		err = loopback_timer_start(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		spin_lock(&cable->lock);	
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->running &= ~stream;
 		cable->pause &= ~stream;
 		err = loopback_timer_stop(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		spin_lock(&cable->lock);	
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->pause |= stream;
 		err = loopback_timer_stop(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		spin_lock(&cable->lock);
+		spin_lock_irqsave(&cable->lock, flags);
 		dpcm->last_jiffies = jiffies;
 		cable->pause &= ~stream;
 		err = loopback_timer_start(dpcm);
-		spin_unlock(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
 		break;
@@ -557,12 +558,13 @@ static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct loopback_pcm *dpcm = runtime->private_data;
+	unsigned long flags;
 	snd_pcm_uframes_t pos;
 
-	spin_lock(&dpcm->cable->lock);
+	spin_lock_irqsave(&dpcm->cable->lock, flags);
 	loopback_pos_update(dpcm->cable);
 	pos = dpcm->buf_pos;
-	spin_unlock(&dpcm->cable->lock);
+	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
 	return bytes_to_frames(runtime, pos);
 }
 
@@ -679,10 +681,12 @@ static void free_cable(struct snd_pcm_substream *substream)
 	if (!cable)
 		return;
 	if (cable->streams[!substream->stream]) {
+		unsigned long flags;
+
 		/* other stream is still alive */
-		spin_lock_irq(&cable->lock);
+		spin_lock_irqsave(&cable->lock, flags);
 		cable->streams[substream->stream] = NULL;
-		spin_unlock_irq(&cable->lock);
+		spin_unlock_irqrestore(&cable->lock, flags);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
@@ -698,6 +702,7 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	struct loopback_cable *cable = NULL;
 	int err = 0;
 	int dev = get_cable_index(substream);
+	unsigned long flags;
 
 	mutex_lock(&loopback->cable_lock);
 	dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
@@ -753,9 +758,9 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	else
 		runtime->hw = cable->hw;
 
-	spin_lock_irq(&cable->lock);
+	spin_lock_irqsave(&cable->lock, flags);
 	cable->streams[substream->stream] = dpcm;
-	spin_unlock_irq(&cable->lock);
+	spin_unlock_irqrestore(&cable->lock, flags);
 
  unlock:
 	if (err < 0) {
-- 
2.7.4

