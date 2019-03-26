Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F153BC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B549820828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfCZHxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:53:14 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:49530 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730422AbfCZHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:53:13 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 2A1DD3C00DD;
        Tue, 26 Mar 2019 08:53:09 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qlnHBbYKqpuL; Tue, 26 Mar 2019 08:53:02 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 915D83C00C4;
        Tue, 26 Mar 2019 08:53:02 +0100 (CET)
Received: from vmlxhi-087.adit-jv.com (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 08:53:02 +0100
From:   <twischer@de.adit-jv.com>
To:     <patch@alsa-project.org>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Timo Wischer <twischer@de.adit-jv.com>
Subject: [PATCH 10/10] ALSA: aloop: Use timer of linked card if chosen
Date:   Tue, 26 Mar 2019 08:52:55 +0100
Message-ID: <1553586775-18902-1-git-send-email-twischer@de.adit-jv.com>
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

If there is a hardware sound card linked to the loopback device
the sound timer of the hardware sound card will be used for this
loopback device. Such a link will be created when snd_pcm_link() was
called.
Linked dummy and loopback devices will be ignored.

This feature can be enabled when loading the module with the following
command:
$ modprobe snd_aloop enable=1 timer_source=-1

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 sound/drivers/aloop.c | 187 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 172 insertions(+), 15 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index a411aeb..e2f1d64 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -51,7 +51,8 @@ MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ALSA,Loopback soundcard}}");
 
 #define MAX_PCM_SUBSTREAMS	8
-#define TIMER_SRC_JIFFIES	-1
+#define TIMER_SRC_JIFFIES	-2
+#define TIMER_SRC_AUTODETECT	-1
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
@@ -76,7 +77,7 @@ MODULE_PARM_DESC(pcm_notify, "Break capture when PCM format/rate/channels change
  * sound timer is not supported.
  */
 module_param_array(timer_source, charp, NULL, 0444);
-MODULE_PARM_DESC(timer_source, "Sound card number of timer to be used (>=0). -2 jiffies timer [default].");
+MODULE_PARM_DESC(timer_source, "Sound card number of timer to be used (>=0). -2 jiffies timer [default]. -1 auto detect sound timer.");
 
 #define NO_PITCH 100000
 
@@ -252,6 +253,14 @@ static int loopback_snd_timer_start(struct loopback_pcm *dpcm)
 {
 	int err;
 
+	/* only in auto detect mode the sound timer will not be opened when the
+	 * device was opened. It will be opened on the first snd_pcm_link() call
+	 */
+	if (!dpcm->cable->snd_timer.instance) {
+		pcm_err(dpcm->substream->pcm, "Sound timer not auto detected. At least one application of the same loopback cable has to call snd_pcm_link() to detect the sound timer.");
+		return -EINVAL;
+	}
+
 	/* Loopback device has to use same period as timer card. Therefore
 	 * wake up for each snd_pcm_period_elapsed() call of timer card.
 	 */
@@ -286,6 +295,10 @@ static int loopback_snd_timer_stop(struct loopback_pcm *dpcm)
 {
 	int err;
 
+	/* no need to stop the timer if it was not yet opened */
+	if (!dpcm->cable->snd_timer.instance)
+		return 0;
+
 	/* only stop if both devices (playback and capture) are not running */
 	if (dpcm->cable->running)
 		return 0;
@@ -307,10 +320,15 @@ static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 }
 
 /* call in loopback->cable_lock */
-static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
+static int loopback_snd_timer_close(struct loopback_pcm *dpcm,
+				    struct snd_timer_instance * const timer)
 {
 	int err;
 
+	/* no need to close the timer if it was not yet opened */
+	if (!timer)
+		return 0;
+
 	/* wait till drain tasklet has finished if requested */
 	tasklet_kill(&dpcm->cable->snd_timer.event_tasklet);
 
@@ -319,7 +337,7 @@ static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
 	 * loopback->cable_lock is locked. Therefore no need to lock
 	 * cable->lock;
 	 */
-	err = snd_timer_close(dpcm->cable->snd_timer.instance);
+	err = snd_timer_close(timer);
 	if (err < 0) {
 		pcm_err(dpcm->substream->pcm, "snd_timer_close(card %d) = %d",
 			dpcm->cable->snd_timer.id.card, err);
@@ -329,6 +347,12 @@ static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
 	return err;
 }
 
+/* call in loopback->cable_lock */
+static int loopback_snd_timer_close_cable(struct loopback_pcm *dpcm)
+{
+	return loopback_snd_timer_close(dpcm, dpcm->cable->snd_timer.instance);
+}
+
 static int loopback_check_format(struct loopback_cable *cable, int stream)
 {
 	struct snd_pcm_runtime *runtime, *cruntime;
@@ -1065,11 +1089,11 @@ static int loopback_snd_card_by_name(const char * const name)
 	return -EINVAL;
 }
 
-/* call in loopback->cable_lock */
-static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
+/* call in cable->lock */
+static int loopback_snd_timer_source_update(struct loopback_pcm *dpcm)
 {
-	int err = 0;
-	unsigned long flags;
+	int changed = 0;
+	struct snd_pcm_substream *s;
 	struct snd_timer_id tid = {
 		.dev_class = SNDRV_TIMER_CLASS_PCM,
 		.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION,
@@ -1078,18 +1102,109 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 		.device = 0,
 		.subdevice = 0,
 	};
-	struct snd_timer_instance *timer = NULL;
 
-	spin_lock_irqsave(&dpcm->cable->lock, flags);
+	/* Enforce kernel module parameter if not auto detect */
+	if (tid.card != TIMER_SRC_AUTODETECT) {
+		dpcm->cable->snd_timer.owner = dpcm->substream->stream;
+		dpcm->cable->snd_timer.id = tid;
+		return 0;
+	}
+
+	/* find the first HW device which is linked to this loop device */
+	snd_pcm_group_for_each_entry(s, dpcm->substream) {
+		/* ignore all linked devices also using jiffies timer */
+		if (strcmp(s->pcm->card->driver, "Loopback") == 0)
+			continue;
+		if (strcmp(s->pcm->card->driver, "Dummy") == 0)
+			continue;
+
+		tid.card = s->pcm->card->number;
+		tid.device = s->pcm->device;
+		tid.subdevice = s->number;
+		break;
+	}
+
+	/* check if a sound timer could already be detected */
+	if (tid.card < 0)
+		return -ENODEV;
+
+	/* check if timer source has changed */
+	changed = (dpcm->cable->snd_timer.id.card != tid.card ||
+		   dpcm->cable->snd_timer.id.device != tid.device ||
+		   dpcm->cable->snd_timer.id.subdevice != tid.subdevice);
+	/* Do not change anything if we are the second device
+	 * which calls snd_pcm_link()
+	 */
+	if (changed) {
+		if (dpcm->cable->snd_timer.owner > 0 &&
+		    dpcm->cable->snd_timer.owner != dpcm->substream->stream) {
+			pcm_warn(dpcm->substream->pcm, "Both devices of the same loopback cable are requesting different sound timers. May be the wrong one is used. (used hw:%d,%d,%d reqested hw:%d,%d,%d)",
+				 dpcm->cable->snd_timer.id.card,
+				 dpcm->cable->snd_timer.id.device,
+				 dpcm->cable->snd_timer.id.subdevice, tid.card,
+				 tid.device, tid.subdevice);
+			return 0;
+		} else if (dpcm->cable->running) {
+			pcm_warn(dpcm->substream->pcm, "Another sound timer was requested but at least one device is already running. May be the wrong one is used. (used hw:%d,%d,%d reqested hw:%d,%d,%d)",
+				 dpcm->cable->snd_timer.id.card,
+				 dpcm->cable->snd_timer.id.device,
+				 dpcm->cable->snd_timer.id.subdevice, tid.card,
+				 tid.device, tid.subdevice);
+			return 0;
+		}
+	}
+
+	/* always return a valid  timer id with defined classes. Also in case
+	 * when it looks like card has not changed because hw:0,0,0 should be
+	 * used
+	 */
 	dpcm->cable->snd_timer.owner = dpcm->substream->stream;
 	dpcm->cable->snd_timer.id = tid;
 
-	/* check if timer was already opened. It is only opened once
-	 * per playback and capture subdevice (aka cable).
+	return changed;
+}
+
+/* call in loopback->cable_lock */
+static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
+{
+	int err = 0;
+	unsigned long flags;
+	struct snd_timer_instance *timer = NULL;
+
+	spin_lock_irqsave(&dpcm->cable->lock, flags);
+	err = loopback_snd_timer_source_update(dpcm);
+	if (err < 0) {
+		/* Could not yet detect the right sound timer because no valid
+		 * snd_pcm_link() exists. This should not be handled as an error
+		 * because the right timer will be opened with the call to
+		 * snd_pcm_link().
+		 */
+		if (err == -ENODEV)
+			err = 0;
+		goto unlock;
+	}
+	/* do not reopen the timer if it is already opened and nothing has
+	 * changed
 	 */
-	if (dpcm->cable->snd_timer.instance)
+	if (dpcm->cable->snd_timer.instance && err < 1)
 		goto unlock;
 
+	/* Avoids that any function accesses an invalid timer instance when
+	 * reopening the sound timer. Reopening the sound timer is only
+	 * supported in TIMER_SRC_AUTODETECT mode. snd_pcm_start() will fail on
+	 * the second device when the first device currently reopens the_timer:
+	 * [proc1] Calls snd_pcm_link() -> loopback_timer_open() ->
+	 *	   Unlock cable->lock for snd_timer_close/open() call
+	 * [proc2] Calls snd_pcm_start() when timer reopening is in progress
+	 * But this is fine because snd_pcm_start() would also fail if
+	 * snd_pcm_link() was not called from any device of the same cable in
+	 * TIMER_SRC_AUTODETECT mode. Therefore the user has to guarantee in
+	 * TIMER_SRC_AUTODETECT mode that snd_pcm_link() is called before anyone
+	 * calls snd_pcm_start() of the same cable.
+	 */
+	timer = dpcm->cable->snd_timer.instance;
+	dpcm->cable->snd_timer.instance = NULL;
+
 	/* snd_timer_close() and snd_timer_open() should not be called with
 	 * locked spinlock because both functions can block on a mutex. The
 	 * mutex loopback->cable_lock is kept locked. Therefore snd_timer_open()
@@ -1103,6 +1218,10 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 	 *	   instance
 	 */
 	spin_unlock_irqrestore(&dpcm->cable->lock, flags);
+	/* close timer if there is already something open */
+	err = loopback_snd_timer_close(dpcm, timer);
+	if (err < 0)
+		return err;
 	err = snd_timer_open(&timer, dpcm->loopback->card->id,
 			     &dpcm->cable->snd_timer.id,
 			     current->pid);
@@ -1137,6 +1256,19 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 	return err;
 }
 
+static int loopback_snd_timer_link_changed(struct snd_pcm_substream *substream)
+{
+	int err;
+	struct loopback_pcm *dpcm = substream->runtime->private_data;
+
+	mutex_lock(&dpcm->loopback->cable_lock);
+	/* Try to reopen the timer here if the link_list has changed. */
+	err = loopback_snd_timer_open(dpcm);
+	mutex_unlock(&dpcm->loopback->cable_lock);
+
+	return err;
+}
+
 /* stop_sync() is not required for sound timer because it does not need to be
  * restarted in loopback_prepare() on Xrun recovery
  */
@@ -1148,6 +1280,13 @@ static struct loopback_ops loopback_snd_timer_ops = {
 	.dpcm_info = loopback_snd_timer_dpcm_info,
 };
 
+static struct loopback_ops loopback_snd_timer_auto_ops = {
+	.start = loopback_snd_timer_start,
+	.stop = loopback_snd_timer_stop,
+	.close_cable = loopback_snd_timer_close_cable,
+	.dpcm_info = loopback_snd_timer_dpcm_info,
+};
+
 static int loopback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1178,6 +1317,8 @@ static int loopback_open(struct snd_pcm_substream *substream)
 		cable->hw = loopback_pcm_hardware;
 		if (loopback->timer_source <= TIMER_SRC_JIFFIES)
 			cable->ops = &loopback_jiffies_timer_ops;
+		else if (loopback->timer_source == TIMER_SRC_AUTODETECT)
+			cable->ops = &loopback_snd_timer_auto_ops;
 		else
 			cable->ops = &loopback_snd_timer_ops;
 		loopback->cables[substream->number][dev] = cable;
@@ -1276,18 +1417,34 @@ static const struct snd_pcm_ops loopback_pcm_ops = {
 	.page =		snd_pcm_lib_get_vmalloc_page,
 };
 
+static const struct snd_pcm_ops loopback_pcm_auto_ops = {
+	.open =		loopback_open,
+	.close =	loopback_close,
+	.ioctl =	snd_pcm_lib_ioctl,
+	.hw_params =	loopback_hw_params,
+	.hw_free =	loopback_hw_free,
+	.prepare =	loopback_prepare,
+	.trigger =	loopback_trigger,
+	.pointer =	loopback_pointer,
+	.page =		snd_pcm_lib_get_vmalloc_page,
+	.link_changed =	loopback_snd_timer_link_changed,
+};
+
 static int loopback_pcm_new(struct loopback *loopback,
 			    int device, int substreams)
 {
 	struct snd_pcm *pcm;
 	int err;
+	const struct snd_pcm_ops * const ops =
+			(loopback->timer_source == TIMER_SRC_AUTODETECT) ?
+				&loopback_pcm_auto_ops : &loopback_pcm_ops;
 
 	err = snd_pcm_new(loopback->card, "Loopback PCM", device,
 			  substreams, substreams, &pcm);
 	if (err < 0)
 		return err;
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &loopback_pcm_ops);
-	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &loopback_pcm_ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, ops);
+	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, ops);
 
 	pcm->private_data = loopback;
 	pcm->info_flags = 0;
-- 
2.7.4

