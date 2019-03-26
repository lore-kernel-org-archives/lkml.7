Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC519C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB88920828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfCZHvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:51:16 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:49500 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCZHvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:51:15 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 568703C013F;
        Tue, 26 Mar 2019 08:51:10 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Jw0JxbUWyEgB; Tue, 26 Mar 2019 08:50:59 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 57C733C014D;
        Tue, 26 Mar 2019 08:50:31 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 08:50:30 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH 08/10] ALSA: aloop: Support selection of snd_timer instead of jiffies
Date:   Tue, 26 Mar 2019 08:49:32 +0100
Message-ID: <1553586574-18608-4-git-send-email-twischer@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

to do synchronous audio forwarding between hardware sound card and aloop
devices. Such an audio route could look like the following:
Sound card -> Loopback application -> ALSA loop device -> arecord

In this case the loopback device should use the sound timer of the sound
card. Without this patch the loopback application has to implement an
adaptive sample rate converter to align the different clocks of the
different ALSA devices.

The used sound card can be selected when loading the module:
$ modprobe snd_aloop enable=1 timer_source=[card]
[card] can be replaced by the name of the sound card (e.g. I82801AAICH) or
a card number (e.g. 0).

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 410 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 409 insertions(+), 1 deletion(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 85a1519..a411aeb 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -36,12 +36,14 @@
 #include <linux/wait.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/stringify.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/info.h>
 #include <sound/initval.h>
+#include <sound/timer.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("A loopback soundcard");
@@ -49,12 +51,15 @@ MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ALSA,Loopback soundcard}}");
 
 #define MAX_PCM_SUBSTREAMS	8
+#define TIMER_SRC_JIFFIES	-1
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static bool enable[SNDRV_CARDS] = {1, [1 ... (SNDRV_CARDS - 1)] = 0};
 static int pcm_substreams[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 8};
 static int pcm_notify[SNDRV_CARDS];
+static char *timer_source[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] =
+					  __stringify(TIMER_SRC_JIFFIES)};
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for loopback soundcard.");
@@ -67,6 +72,12 @@ MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-8) for loopback driver.");
 module_param_array(pcm_notify, int, NULL, 0444);
 MODULE_PARM_DESC(pcm_notify, "Break capture when PCM format/rate/channels changes.");
 
+/* This parameter has to be kept read only because switch between jiffies and
+ * sound timer is not supported.
+ */
+module_param_array(timer_source, charp, NULL, 0444);
+MODULE_PARM_DESC(timer_source, "Sound card number of timer to be used (>=0). -2 jiffies timer [default].");
+
 #define NO_PITCH 100000
 
 #define CABLE_VALID_PLAYBACK	BIT(SNDRV_PCM_STREAM_PLAYBACK)
@@ -116,6 +127,13 @@ struct loopback_cable {
 	unsigned int pause;
 	/* timer specific */
 	struct loopback_ops *ops;
+	/* When loopback.timer_source > TIMER_SRC_JIFFIES */
+	struct {
+		int owner;
+		struct snd_timer_id id;
+		struct tasklet_struct event_tasklet;
+		struct snd_timer_instance *instance;
+	} snd_timer;
 };
 
 struct loopback_setup {
@@ -136,6 +154,8 @@ struct loopback {
 	struct loopback_cable *cables[MAX_PCM_SUBSTREAMS][2];
 	struct snd_pcm *pcm[2];
 	struct loopback_setup setup[MAX_PCM_SUBSTREAMS][2];
+	char *timer_source_name;
+	int timer_source;
 };
 
 struct loopback_pcm {
@@ -159,6 +179,7 @@ struct loopback_pcm {
 	unsigned int period_size_frac;	/* period size in jiffies ticks */
 	unsigned int last_drift;
 	unsigned long last_jiffies;
+	/* When loopback.timer_source <= TIMER_SRC_JIFFIES */
 	struct timer_list timer;
 };
 
@@ -227,6 +248,31 @@ static int loopback_jiffies_timer_start(struct loopback_pcm *dpcm)
 }
 
 /* call in cable->lock */
+static int loopback_snd_timer_start(struct loopback_pcm *dpcm)
+{
+	int err;
+
+	/* Loopback device has to use same period as timer card. Therefore
+	 * wake up for each snd_pcm_period_elapsed() call of timer card.
+	 */
+	err = snd_timer_start(dpcm->cable->snd_timer.instance, 1);
+	if (err < 0) {
+		/* do not report error if trying to start but already
+		 * running. For example called by opposit substream
+		 * of the same cable
+		 */
+		if (err == -EBUSY)
+			return 0;
+
+		pcm_err(dpcm->substream->pcm, "snd_timer_start(card %d) failed with %d",
+			dpcm->cable->snd_timer.id.card, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/* call in cable->lock */
 static inline int loopback_jiffies_timer_stop(struct loopback_pcm *dpcm)
 {
 	del_timer(&dpcm->timer);
@@ -235,6 +281,24 @@ static inline int loopback_jiffies_timer_stop(struct loopback_pcm *dpcm)
 	return 0;
 }
 
+/* call in cable->lock */
+static int loopback_snd_timer_stop(struct loopback_pcm *dpcm)
+{
+	int err;
+
+	/* only stop if both devices (playback and capture) are not running */
+	if (dpcm->cable->running)
+		return 0;
+	err = snd_timer_stop(dpcm->cable->snd_timer.instance);
+	if (err < 0) {
+		pcm_err(dpcm->substream->pcm, "snd_timer_stop(card %d) failed with %d",
+			dpcm->cable->snd_timer.id.card, err);
+		return err;
+	}
+
+	return 0;
+}
+
 static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 {
 	del_timer_sync(&dpcm->timer);
@@ -242,6 +306,29 @@ static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 	return 0;
 }
 
+/* call in loopback->cable_lock */
+static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
+{
+	int err;
+
+	/* wait till drain tasklet has finished if requested */
+	tasklet_kill(&dpcm->cable->snd_timer.event_tasklet);
+
+	/* will only be called from free_cable() when other stream was
+	 * already closed. Other stream cannot be reopened as long as
+	 * loopback->cable_lock is locked. Therefore no need to lock
+	 * cable->lock;
+	 */
+	err = snd_timer_close(dpcm->cable->snd_timer.instance);
+	if (err < 0) {
+		pcm_err(dpcm->substream->pcm, "snd_timer_close(card %d) = %d",
+			dpcm->cable->snd_timer.id.card, err);
+	}
+	memset(&dpcm->cable->snd_timer, 0, sizeof(dpcm->cable->snd_timer));
+
+	return err;
+}
+
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
 	struct snd_pcm_runtime *runtime, *cruntime;
@@ -368,6 +455,13 @@ static void params_change(struct snd_pcm_substream *substream)
 	cable->hw.rate_max = runtime->rate;
 	cable->hw.channels_min = runtime->channels;
 	cable->hw.channels_max = runtime->channels;
+
+	if (dpcm->loopback->timer_source > TIMER_SRC_JIFFIES) {
+		cable->hw.period_bytes_min =
+				frames_to_bytes(runtime, runtime->period_size);
+		cable->hw.period_bytes_max = cable->hw.period_bytes_min;
+	}
+
 }
 
 static int loopback_prepare(struct snd_pcm_substream *substream)
@@ -591,6 +685,160 @@ static void loopback_jiffies_timer_function(struct timer_list *t)
 	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
 }
 
+/* call in cable->lock */
+static int loopback_snd_timer_check_resolution(struct snd_pcm_runtime *runtime,
+					       unsigned long resolution)
+{
+	if (resolution != runtime->timer_resolution) {
+		struct loopback_pcm *dpcm = runtime->private_data;
+		struct loopback_cable *cable = dpcm->cable;
+		/* Worst case estimation of possible values for resolution
+		 * resolution <= (512 * 1024) frames / 8kHz in nsec
+		 * resolution <= 65.536.000.000 nsec
+		 *
+		 * period_size <= 65.536.000.000 nsec / 1000nsec/usec * 192kHz +
+		 *  500.000
+		 * period_size <= 12.582.912.000.000  <64bit
+		 *  / 1.000.000 usec/sec
+		 */
+		const snd_pcm_uframes_t period_size_usec = resolution / 1000 *
+				runtime->rate;
+		/* round to nearest sample rate */
+		const snd_pcm_uframes_t period_size = (period_size_usec + 500 *
+						       1000) / (1000 * 1000);
+
+		pcm_err(dpcm->substream->pcm, "Period size (%lu frames) of loopback device is not corresponding to timer resolution (%lu nsec = %lu frames) of card %d. Use period size of %lu frames for loopback device.",
+			runtime->period_size, resolution,
+			period_size, cable->snd_timer.id.card, period_size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void loopback_snd_timer_period_elapsed
+		(struct loopback_cable * const cable, const int event,
+		 const unsigned long resolution)
+{
+	struct loopback_pcm *dpcm_play =
+			cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
+	struct loopback_pcm *dpcm_capt =
+			cable->streams[SNDRV_PCM_STREAM_CAPTURE];
+	struct snd_pcm_runtime *valid_runtime;
+	unsigned int running, elapsed_bytes;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cable->lock, flags);
+	running = cable->running ^ cable->pause;
+	/* no need to do anything if no stream is running */
+	if (!running) {
+		spin_unlock_irqrestore(&cable->lock, flags);
+		return;
+	}
+
+	if (event == SNDRV_TIMER_EVENT_MSTOP) {
+		if (!dpcm_play || !dpcm_play->substream ||
+		    !dpcm_play->substream->runtime ||
+		    !dpcm_play->substream->runtime->status ||
+		    dpcm_play->substream->runtime->status->state !=
+		    SNDRV_PCM_STATE_DRAINING) {
+			spin_unlock_irqrestore(&cable->lock, flags);
+			return;
+		}
+	}
+
+	valid_runtime = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
+				dpcm_play->substream->runtime :
+				dpcm_capt->substream->runtime;
+
+	/* resolution is only valid for SNDRV_TIMER_EVENT_TICK events */
+	if (event == SNDRV_TIMER_EVENT_TICK) {
+		/* The hardware rules guarantee that playback and capture period
+		 * are the same. Therefore only one device has to be checked
+		 * here.
+		 */
+		if (loopback_snd_timer_check_resolution(valid_runtime,
+							resolution) < 0) {
+			spin_unlock_irqrestore(&cable->lock, flags);
+			if (cable->running & (1 << SNDRV_PCM_STREAM_PLAYBACK))
+				snd_pcm_stop_xrun(dpcm_play->substream);
+			if (cable->running & (1 << SNDRV_PCM_STREAM_CAPTURE))
+				snd_pcm_stop_xrun(dpcm_capt->substream);
+			return;
+		}
+	}
+
+	elapsed_bytes = frames_to_bytes(valid_runtime,
+					valid_runtime->period_size);
+	/* The same timer interrupt is used for playback and capture device */
+	if ((running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) &&
+	    (running & (1 << SNDRV_PCM_STREAM_CAPTURE))) {
+		copy_play_buf(dpcm_play, dpcm_capt, elapsed_bytes);
+		bytepos_finish(dpcm_play, elapsed_bytes);
+		bytepos_finish(dpcm_capt, elapsed_bytes);
+	} else if (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) {
+		bytepos_finish(dpcm_play, elapsed_bytes);
+	} else if (running & (1 << SNDRV_PCM_STREAM_CAPTURE)) {
+		clear_capture_buf(dpcm_capt, elapsed_bytes);
+		bytepos_finish(dpcm_capt, elapsed_bytes);
+	}
+	spin_unlock_irqrestore(&cable->lock, flags);
+
+	if (running & (1 << SNDRV_PCM_STREAM_PLAYBACK))
+		snd_pcm_period_elapsed(dpcm_play->substream);
+	if (running & (1 << SNDRV_PCM_STREAM_CAPTURE))
+		snd_pcm_period_elapsed(dpcm_capt->substream);
+}
+
+static void loopback_snd_timer_function(struct snd_timer_instance *timeri,
+					unsigned long resolution,
+					unsigned long ticks)
+{
+	struct loopback_cable *cable = timeri->callback_data;
+
+	loopback_snd_timer_period_elapsed(cable, SNDRV_TIMER_EVENT_TICK,
+					  resolution);
+}
+
+static void loopback_snd_timer_tasklet(unsigned long arg)
+{
+	struct snd_timer_instance *timeri = (struct snd_timer_instance *)arg;
+	struct loopback_cable *cable = timeri->callback_data;
+
+	loopback_snd_timer_period_elapsed(cable, SNDRV_TIMER_EVENT_MSTOP, 0);
+}
+
+static void loopback_snd_timer_event(struct snd_timer_instance * const timeri,
+				     const int event,
+				     struct timespec * const tstamp,
+				     const unsigned long resolution)
+{
+	/* Do not lock cable->lock here because timer->lock is already hold.
+	 * There are other functions which first lock cable->lock and than
+	 * timer->lock e.g.
+	 * loopback_trigger()
+	 * spin_lock(&cable->lock)
+	 * loopback_snd_timer_start()
+	 * snd_timer_start()
+	 * spin_lock(&timer->lock)
+	 * Therefore when using the oposit order of locks here it could result
+	 * in a deadlock.
+	 */
+
+	if (event == SNDRV_TIMER_EVENT_MSTOP) {
+		struct loopback_cable *cable = timeri->callback_data;
+
+		/* sound card of the timer was stopped. Therefore there will not
+		 * be any further timer callbacks. Due to this forward audio
+		 * data from here if in draining state. When still in running
+		 * state the streaming will be aborted by the usual timeout. It
+		 * should not be aborted here because may be the timer sound
+		 * card does only a recovery and the timer is back soon.
+		 * This tasklet triggers loopback_snd_timer_tasklet()
+		 */
+		tasklet_schedule(&cable->snd_timer.event_tasklet);
+	}
+}
+
 static void loopback_jiffies_timer_dpcm_info(struct loopback_pcm *dpcm,
 					     struct snd_info_buffer *buffer)
 {
@@ -603,6 +851,18 @@ static void loopback_jiffies_timer_dpcm_info(struct loopback_pcm *dpcm,
 	snd_iprintf(buffer, "    timer_expires:\t%lu\n", dpcm->timer.expires);
 }
 
+static void loopback_snd_timer_dpcm_info(struct loopback_pcm *dpcm,
+					 struct snd_info_buffer *buffer)
+{
+	snd_iprintf(buffer, "    sound timer:\thw:%d,%d,%d\n",
+		    dpcm->cable->snd_timer.id.card,
+		    dpcm->cable->snd_timer.id.device,
+		    dpcm->cable->snd_timer.id.subdevice);
+	snd_iprintf(buffer, "    owner:\t\t%s\n",
+		    (dpcm->cable->snd_timer.owner == SNDRV_PCM_STREAM_CAPTURE) ?
+			    "capture" : "playback");
+}
+
 static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -721,6 +981,23 @@ static int rule_channels(struct snd_pcm_hw_params *params,
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
 
+static int rule_period_bytes(struct snd_pcm_hw_params *params,
+			     struct snd_pcm_hw_rule *rule)
+{
+	struct loopback_pcm *dpcm = rule->private;
+	struct loopback_cable *cable = dpcm->cable;
+	struct snd_interval t;
+
+	mutex_lock(&dpcm->loopback->cable_lock);
+	t.min = cable->hw.period_bytes_min;
+	t.max = cable->hw.period_bytes_max;
+	mutex_unlock(&dpcm->loopback->cable_lock);
+	t.openmin = 0;
+	t.openmax = 0;
+	t.integer = 0;
+	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
+}
+
 static void free_cable(struct snd_pcm_substream *substream)
 {
 	struct loopback *loopback = substream->private_data;
@@ -765,6 +1042,112 @@ static struct loopback_ops loopback_jiffies_timer_ops = {
 	.dpcm_info = loopback_jiffies_timer_dpcm_info,
 };
 
+static int loopback_timer_source_by_name(const char * const name,
+					 int * const number)
+{
+	return kstrtoint(name, 10, number);
+}
+
+static int loopback_snd_card_by_name(const char * const name)
+{
+	int number;
+
+	if (loopback_timer_source_by_name(name, &number) >= 0)
+		return number;
+
+	for (number = 0; number < ARRAY_SIZE(snd_cards); number++) {
+		const struct snd_card * const card = snd_cards[number];
+
+		if (card && strcmp(card->id, name) == 0)
+			return number;
+	}
+
+	return -EINVAL;
+}
+
+/* call in loopback->cable_lock */
+static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
+{
+	int err = 0;
+	unsigned long flags;
+	struct snd_timer_id tid = {
+		.dev_class = SNDRV_TIMER_CLASS_PCM,
+		.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION,
+		.card = loopback_snd_card_by_name
+				(dpcm->loopback->timer_source_name),
+		.device = 0,
+		.subdevice = 0,
+	};
+	struct snd_timer_instance *timer = NULL;
+
+	spin_lock_irqsave(&dpcm->cable->lock, flags);
+	dpcm->cable->snd_timer.owner = dpcm->substream->stream;
+	dpcm->cable->snd_timer.id = tid;
+
+	/* check if timer was already opened. It is only opened once
+	 * per playback and capture subdevice (aka cable).
+	 */
+	if (dpcm->cable->snd_timer.instance)
+		goto unlock;
+
+	/* snd_timer_close() and snd_timer_open() should not be called with
+	 * locked spinlock because both functions can block on a mutex. The
+	 * mutex loopback->cable_lock is kept locked. Therefore snd_timer_open()
+	 * cannot be called a second time by the other device of the same cable.
+	 * Therefore the following issue cannot happen:
+	 * [proc1] Call loopback_timer_open() ->
+	 *	   Unlock cable->lock for snd_timer_close/open() call
+	 * [proc2] Call loopback_timer_open() -> snd_timer_open(),
+	 *	   snd_timer_start()
+	 * [proc1] Call snd_timer_open() and overwrite running timer
+	 *	   instance
+	 */
+	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
+	err = snd_timer_open(&timer, dpcm->loopback->card->id,
+			     &dpcm->cable->snd_timer.id,
+			     current->pid);
+	if (err < 0) {
+		pcm_err(dpcm->substream->pcm, "Opening sound timer of card %d failed with %d",
+			dpcm->cable->snd_timer.id.card, err);
+		return err;
+	}
+	spin_lock_irqsave(&dpcm->cable->lock, flags);
+
+	/* The callback has to be called from another tasklet. If
+	 * SNDRV_TIMER_IFLG_FAST is specified it will be called from the
+	 * snd_pcm_period_elapsed() call of the selected sound card.
+	 * snd_pcm_period_elapsed() helds snd_pcm_stream_lock_irqsave().
+	 * Due to our callback loopback_snd_timer_function() also calls
+	 * snd_pcm_period_elapsed() which calls snd_pcm_stream_lock_irqsave().
+	 * This would end up in a dead lock.
+	 */
+	timer->flags |= SNDRV_TIMER_IFLG_AUTO;
+	timer->callback = loopback_snd_timer_function;
+	timer->callback_data = (void *)dpcm->cable;
+	timer->ccallback = loopback_snd_timer_event;
+	dpcm->cable->snd_timer.instance = timer;
+
+	/* initialise a tasklet used for draining */
+	tasklet_init(&dpcm->cable->snd_timer.event_tasklet,
+		     loopback_snd_timer_tasklet, (unsigned long)timer);
+
+unlock:
+	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
+
+	return err;
+}
+
+/* stop_sync() is not required for sound timer because it does not need to be
+ * restarted in loopback_prepare() on Xrun recovery
+ */
+static struct loopback_ops loopback_snd_timer_ops = {
+	.open = loopback_snd_timer_open,
+	.start = loopback_snd_timer_start,
+	.stop = loopback_snd_timer_stop,
+	.close_cable = loopback_snd_timer_close_cable,
+	.dpcm_info = loopback_snd_timer_dpcm_info,
+};
+
 static int loopback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -793,7 +1176,10 @@ static int loopback_open(struct snd_pcm_substream *substream)
 		}
 		spin_lock_init(&cable->lock);
 		cable->hw = loopback_pcm_hardware;
-		cable->ops = &loopback_jiffies_timer_ops;
+		if (loopback->timer_source <= TIMER_SRC_JIFFIES)
+			cable->ops = &loopback_jiffies_timer_ops;
+		else
+			cable->ops = &loopback_snd_timer_ops;
 		loopback->cables[substream->number][dev] = cable;
 	}
 	dpcm->cable = cable;
@@ -829,6 +1215,19 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		goto unlock;
 
+	/* In case of sound timer the period time of both devices of the same
+	 * loop has to be the same. This rule only takes effect if a sound timer
+	 * was chosen via the kernel parameter.
+	 */
+	if (loopback->timer_source > TIMER_SRC_JIFFIES) {
+		err = snd_pcm_hw_rule_add(runtime, 0,
+					  SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
+					  rule_period_bytes, dpcm,
+					  SNDRV_PCM_HW_PARAM_PERIOD_BYTES, -1);
+		if (err < 0)
+			goto unlock;
+	}
+
 	/* loopback_runtime_free() has not to be called if kfree(dpcm) was
 	 * already called here. Otherwise it will end up with a double free.
 	 */
@@ -1250,6 +1649,15 @@ static int loopback_probe(struct platform_device *devptr)
 		pcm_substreams[dev] = MAX_PCM_SUBSTREAMS;
 	
 	loopback->card = card;
+	loopback->timer_source_name = timer_source[dev];
+	/* If it was not a number a sound card name was specified. Therefore a
+	 * the sound timer of this card should be used. The right card name will
+	 * be converted in loopback_snd_timer_open()
+	 */
+	if (loopback_timer_source_by_name(loopback->timer_source_name,
+					  &loopback->timer_source) < 0)
+		loopback->timer_source = 0;
+
 	mutex_init(&loopback->cable_lock);
 
 	err = loopback_pcm_new(loopback, 0, pcm_substreams[dev]);
-- 
2.7.4

