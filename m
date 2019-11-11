Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F60C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3DC21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 11:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfKKLJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 06:09:36 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:65317 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKLJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:09:35 -0500
IronPort-SDR: AvHYDsM4UkKO4ta4WogC2k2yPeBI4IaU9DX40v1HpYrwUVIDYxamCALy6vaoNOWM1HDfn7jvYq
 ixgzbjor8hfYghI4LkHEpT8VpGiWjyNhZCZaYupAJ2WC6YbmKJ4LY3+F37k9hjKgWWavFHg+1j
 nXzoW0zIFuraiN07dXqiVAOUaeN4zhtRT5qq/v+zWoJ7ZieTJDZbsUBN8zszd64HyDIPGh+DaU
 88SasPA4479D+R4JTgJ1GAzuVHxqNHjgfYzACJms9gy2h19jBQAoNMenDSjQtz3SrxlRJ24K5K
 C2A=
X-IronPort-AV: E=Sophos;i="5.68,292,1569312000"; 
   d="scan'208";a="43051114"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 11 Nov 2019 03:09:34 -0800
IronPort-SDR: bhf9RHemiZhEYgxTK31Avuj5LGYWOl/nNODdaj0rfXD31YWteLlg8W1NCDt3L3qw5PQyn8u4Ob
 guQ2OmHz/m9HA+Rtuh3CeW/LiviTduNyuAYNk6SUfuIre+zfugIDJg4gJsziE08uGCN9PWwyJ5
 2/KXzc0jtqaJ6df1rn6QWMXVL4Edcug60IALKzrdGrHMivjADQz5z6JqNWPWeKiWDrmu7Btb0G
 IlkAEi8rXV+cUoYYkVBL4kPQCyRsZ/mBhqI1qLJObaZrClaIpqBgmLapsfGfOekoeYYPfzBKme
 l+U=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v3 3/7] ALSA: aloop: Use callback functions for timer specific implementations
Date:   Mon, 11 Nov 2019 05:08:42 -0600
Message-ID: <20191111110846.18223-4-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191111110846.18223-3-andrew_gabbasov@mentor.com>
References: <20191111110846.18223-1-andrew_gabbasov@mentor.com>
 <20191111110846.18223-2-andrew_gabbasov@mentor.com>
 <20191111110846.18223-3-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

This commit only refactors the implementation. It does not change the
behaviour.
It is required to support other timers (e.g sound timer).

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 113 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 19 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index dc9154662d5b..92134e9c6ea7 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -55,8 +55,39 @@ MODULE_PARM_DESC(pcm_notify, "Break capture when PCM format/rate/channels change
 
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
@@ -65,6 +96,8 @@ struct loopback_cable {
 	unsigned int valid;
 	unsigned int running;
 	unsigned int pause;
+	/* timer specific */
+	struct loopback_ops *ops;
 };
 
 struct loopback_setup {
@@ -270,7 +303,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);	
 		cable->running |= stream;
 		cable->pause &= ~stream;
-		err = loopback_timer_start(dpcm);
+		err = cable->ops->start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -279,7 +312,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);	
 		cable->running &= ~stream;
 		cable->pause &= ~stream;
-		err = loopback_timer_stop(dpcm);
+		err = cable->ops->stop(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -288,7 +321,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		spin_lock(&cable->lock);	
 		cable->pause |= stream;
-		err = loopback_timer_stop(dpcm);
+		err = cable->ops->stop(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -298,7 +331,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
 		spin_lock(&cable->lock);
 		dpcm->last_jiffies = jiffies;
 		cable->pause &= ~stream;
-		err = loopback_timer_start(dpcm);
+		err = cable->ops->start(dpcm);
 		spin_unlock(&cable->lock);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 			loopback_active_notify(dpcm);
@@ -329,9 +362,11 @@ static int loopback_prepare(struct snd_pcm_substream *substream)
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
 
 	salign = (snd_pcm_format_physical_width(runtime->format) *
 						runtime->channels) / 8;
@@ -539,6 +574,18 @@ static void loopback_timer_function(struct timer_list *t)
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
@@ -546,7 +593,8 @@ static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t pos;
 
 	spin_lock(&dpcm->cable->lock);
-	loopback_pos_update(dpcm->cable);
+	if (dpcm->cable->ops->pos_update)
+		dpcm->cable->ops->pos_update(dpcm->cable);
 	pos = dpcm->buf_pos;
 	spin_unlock(&dpcm->cable->lock);
 	return bytes_to_frames(runtime, pos);
@@ -672,12 +720,33 @@ static void free_cable(struct snd_pcm_substream *substream)
 		cable->streams[substream->stream] = NULL;
 		spin_unlock_irq(&cable->lock);
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
@@ -695,7 +764,6 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	}
 	dpcm->loopback = loopback;
 	dpcm->substream = substream;
-	timer_setup(&dpcm->timer, loopback_timer_function, 0);
 
 	cable = loopback->cables[substream->number][dev];
 	if (!cable) {
@@ -706,9 +774,17 @@ static int loopback_open(struct snd_pcm_substream *substream)
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
 
@@ -734,7 +810,9 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto unlock;
 
-	runtime->private_data = dpcm;
+	/* loopback_runtime_free() has not to be called if kfree(dpcm) was
+	 * already called here. Otherwise it will end up with a double free.
+	 */
 	runtime->private_free = loopback_runtime_free;
 	if (get_notify(dpcm))
 		runtime->hw = loopback_pcm_hardware;
@@ -758,12 +836,14 @@ static int loopback_close(struct snd_pcm_substream *substream)
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
@@ -1086,13 +1166,8 @@ static void print_dpcm_info(struct snd_info_buffer *buffer,
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
2.21.0

