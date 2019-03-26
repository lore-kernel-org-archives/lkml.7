Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19ADEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB50120856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbfCZHuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:50:04 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:49457 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbfCZHuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:50:03 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CD2E23C00C4;
        Tue, 26 Mar 2019 08:50:00 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x6C92qGOclwe; Tue, 26 Mar 2019 08:49:54 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 7AF683C013A;
        Tue, 26 Mar 2019 08:49:54 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 08:49:54 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH 05/10] ALSA: aloop: Use callback functions for timer specific implementations
Date:   Tue, 26 Mar 2019 08:49:29 +0100
Message-ID: <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
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

This commit only refectors the implementation. It does not change the
behaviour.
It is required to support other timers (e.g sound timer).

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 113 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 94 insertions(+), 19 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index c6217c4..422d130 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -69,8 +69,39 @@ MODULE_PARM_DESC(pcm_notify, "Break capture when PCM format/rate/channels change
 
 #define NO_PITCH 100000
 
+struct loopback_cable;
 struct loopback_pcm;
 
+struct loopback_ops {
+	/* optional
+	 * call in loopback->cable_lock
+	 */
+	int (*open)(struct loopback_pcm *dpcm);
+	/* required
+	 * call in cable->lock
+	 */
+	int (*start)(struct loopback_pcm *dpcm);
+	/* required
+	 * call in cable->lock
+	 */
+	int (*stop)(struct loopback_pcm *dpcm);
+	/* optional */
+	int (*stop_sync)(struct loopback_pcm *dpcm);
+	/* optional */
+	int (*close_substream)(struct loopback_pcm *dpcm);
+	/* optional
+	 * call in loopback->cable_lock
+	 */
+	int (*close_cable)(struct loopback_pcm *dpcm);
+	/* optional
+	 * call in cable->lock
+	 */
+	unsigned int (*pos_update)(struct loopback_cable *cable);
+	/* optional */
+	void (*dpcm_info)(struct loopback_pcm *dpcm,
+			  struct snd_info_buffer *buffer);
+};
+
 struct loopback_cable {
 	spinlock_t lock;
 	struct loopback_pcm *streams[2];
@@ -79,6 +110,8 @@ struct loopback_cable {
 	unsigned int valid;
 	unsigned int running;
 	unsigned int pause;
+	/* timer specific */
+	struct loopback_ops *ops;
 };
 
 struct loopback_setup {
@@ -285,7 +318,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock_irqsave(&cable->lock, flags);
 		cable->running |= stream;
 		cable->pause &= ~stream;
-		err = loopback_timer_start(dpcm);
+		err = cable->ops->start(dpcm);
 		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -294,7 +327,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock_irqsave(&cable->lock, flags);
 		cable->running &= ~stream;
 		cable->pause &= ~stream;
-		err = loopback_timer_stop(dpcm);
+		err = cable->ops->stop(dpcm);
 		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -303,7 +336,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		spin_lock_irqsave(&cable->lock, flags);
 		cable->pause |= stream;
-		err = loopback_timer_stop(dpcm);
+		err = cable->ops->stop(dpcm);
 		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -313,7 +346,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock_irqsave(&cable->lock, flags);
 		dpcm->last_jiffies = jiffies;
 		cable->pause &= ~stream;
-		err = loopback_timer_start(dpcm);
+		err = cable->ops->start(dpcm);
 		spin_unlock_irqrestore(&cable->lock, flags);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -344,9 +377,11 @@ static int loopback_prepare(struct snd_pcm_substream *substream)
 	struct loopback_cable *cable = dpcm->cable;
 	int err, bps, salign;
 
-	err = loopback_timer_stop_sync(dpcm);
-	if (err < 0)
-		return err;
+	if (cable->ops->stop_sync) {
+		err = cable->ops->stop_sync(dpcm);
+		if (err < 0)
+			return err;
+	}
 
 	salign = (snd_pcm_format_width(runtime->format) *
 						runtime->channels) / 8;
@@ -554,6 +589,18 @@ static void loopback_timer_function(struct timer_list *t)
 	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
 }
 
+static void loopback_jiffies_timer_dpcm_info(struct loopback_pcm *dpcm,
+					     struct snd_info_buffer *buffer)
+{
+	snd_iprintf(buffer, "    update_pending:\t%u\n",
+		    dpcm->period_update_pending);
+	snd_iprintf(buffer, "    irq_pos:\t\t%u\n", dpcm->irq_pos);
+	snd_iprintf(buffer, "    period_frac:\t%u\n", dpcm->period_size_frac);
+	snd_iprintf(buffer, "    last_jiffies:\t%lu (%lu)\n",
+		    dpcm->last_jiffies, jiffies);
+	snd_iprintf(buffer, "    timer_expires:\t%lu\n", dpcm->timer.expires);
+}
+
 static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -562,7 +609,8 @@ static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t pos;
 
 	spin_lock_irqsave(&dpcm->cable->lock, flags);
-	loopback_pos_update(dpcm->cable);
+	if (dpcm->cable->ops->pos_update)
+		dpcm->cable->ops->pos_update(dpcm->cable);
 	pos = dpcm->buf_pos;
 	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
 	return bytes_to_frames(runtime, pos);
@@ -688,12 +736,33 @@ static void free_cable(struct snd_pcm_substream *substream)
 		cable->streams[substream->stream] = NULL;
 		spin_unlock_irqrestore(&cable->lock, flags);
 	} else {
+		struct loopback_pcm *dpcm = substream->runtime->private_data;
+
+		if (cable->ops && cable->ops->close_cable && dpcm)
+			cable->ops->close_cable(dpcm);
 		/* free the cable */
 		loopback->cables[substream->number][dev] = NULL;
 		kfree(cable);
 	}
 }
 
+static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
+{
+	timer_setup(&dpcm->timer, loopback_timer_function, 0);
+
+	return 0;
+}
+
+static struct loopback_ops loopback_jiffies_timer_ops = {
+	.open = loopback_jiffies_timer_open,
+	.start = loopback_timer_start,
+	.stop = loopback_timer_stop,
+	.stop_sync = loopback_timer_stop_sync,
+	.close_substream = loopback_timer_stop_sync,
+	.pos_update = loopback_pos_update,
+	.dpcm_info = loopback_jiffies_timer_dpcm_info,
+};
+
 static int loopback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -712,7 +781,6 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	}
 	dpcm->loopback = loopback;
 	dpcm->substream = substream;
-	timer_setup(&dpcm->timer, loopback_timer_function, 0);
 
 	cable = loopback->cables[substream->number][dev];
 	if (!cable) {
@@ -723,9 +791,17 @@ static int loopback_open(struct snd_pcm_substream *substream)
 		}
 		spin_lock_init(&cable->lock);
 		cable->hw = loopback_pcm_hardware;
+		cable->ops = &loopback_jiffies_timer_ops;
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
+	runtime->private_data = dpcm;
+
+	if (cable->ops->open) {
+		err = cable->ops->open(dpcm);
+		if (err < 0)
+			goto unlock;
+	}
 
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
 
@@ -751,7 +827,9 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto unlock;
 
-	runtime->private_data = dpcm;
+	/* loopback_runtime_free() has not to be called if kfree(dpcm) was
+	 * already called here. Otherwise it will end up with a double free.
+	 */
 	runtime->private_free = loopback_runtime_free;
 	if (get_notify(dpcm))
 		runtime->hw = loopback_pcm_hardware;
@@ -775,12 +853,14 @@ static int loopback_close(struct snd_pcm_substream *substream)
 {
 	struct loopback *loopback = substream->private_data;
 	struct loopback_pcm *dpcm = substream->runtime->private_data;
+	int err = 0;
 
-	loopback_timer_stop_sync(dpcm);
+	if (dpcm->cable->ops->close_substream)
+		err = dpcm->cable->ops->close_substream(dpcm);
 	mutex_lock(&loopback->cable_lock);
 	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
-	return 0;
+	return err;
 }
 
 static const struct snd_pcm_ops loopback_pcm_ops = {
@@ -1103,13 +1183,8 @@ static void print_dpcm_info(struct snd_info_buffer *buffer,
 	snd_iprintf(buffer, "    bytes_per_sec:\t%u\n", dpcm->pcm_bps);
 	snd_iprintf(buffer, "    sample_align:\t%u\n", dpcm->pcm_salign);
 	snd_iprintf(buffer, "    rate_shift:\t\t%u\n", dpcm->pcm_rate_shift);
-	snd_iprintf(buffer, "    update_pending:\t%u\n",
-						dpcm->period_update_pending);
-	snd_iprintf(buffer, "    irq_pos:\t\t%u\n", dpcm->irq_pos);
-	snd_iprintf(buffer, "    period_frac:\t%u\n", dpcm->period_size_frac);
-	snd_iprintf(buffer, "    last_jiffies:\t%lu (%lu)\n",
-					dpcm->last_jiffies, jiffies);
-	snd_iprintf(buffer, "    timer_expires:\t%lu\n", dpcm->timer.expires);
+	if (dpcm->cable->ops->dpcm_info)
+		dpcm->cable->ops->dpcm_info(dpcm, buffer);
 }
 
 static void print_substream_info(struct snd_info_buffer *buffer,
-- 
2.7.4

