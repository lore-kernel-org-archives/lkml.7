Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99A0206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfKTRvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:51:04 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:26563 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbfKTRvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:51:03 -0500
IronPort-SDR: gcAQk6KZMXt2G57n6ZKQf35LxnZrDLPx6KXaeXzWks/D3RP9os1NE5aAQ8I+uz4JVIwqZhCS+1
 AxLEnmo5FhKU838W8eh8rG/xA0hWm46yY7rbY7DY50gGtO4BJEvsn0b4lD6o8ioW0gVHVF14qo
 6EEZEuZKVSq3qJFMmJLetfLgbUlOZb3GlHW8Dr2q8ylKmpDKO0pM/ql2m6w7Ysx+/knH+oJdRA
 BH75KQOgSotebzwk08rnGuNNHgF2+sYOWWf0YxqhlROqWj1i0z8JnD/mJv1blXRGbe+YzIeKXz
 DDQ=
X-IronPort-AV: E=Sophos;i="5.69,222,1571731200"; 
   d="scan'208";a="45229175"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 20 Nov 2019 09:51:03 -0800
IronPort-SDR: rdVgfcKRYYiwdTsXLeZ1B5Qt8jk5ew7O/tTqmqm+78Zat4h5uk1AGPrpqoM0K2sBywFkJHsmiY
 1BihXZuZN5tIBLUn+j1uhbCrQTMPU+5AwrqSj1S6Rb5GMn3A2p6oNUS4rOkZxVcYlnuN5cN08a
 LDIJG2pCbZFNwYkJP1FNaP5Nivh4AimhWfnqq9wHInL9z0ajxH4453nhtyyf5iKLfMQMcwYYz5
 dou4AlJogdghqOajtAyzLI7lz4BHOqjlIVDU+knie9VpnSNsGB2qJ7oO39qjrELrrH1hjYfQFx
 aJI=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v5 4/7] ALSA: aloop: Rename all jiffies timer specific functions
Date:   Wed, 20 Nov 2019 11:49:52 -0600
Message-ID: <20191120174955.6410-5-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120174955.6410-4-andrew_gabbasov@mentor.com>
References: <20191120174955.6410-1-andrew_gabbasov@mentor.com>
 <20191120174955.6410-2-andrew_gabbasov@mentor.com>
 <20191120174955.6410-3-andrew_gabbasov@mentor.com>
 <20191120174955.6410-4-andrew_gabbasov@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timo Wischer <twischer@de.adit-jv.com>

This commit does not change the behaviour. It only separates the jiffies
timer specific implementation from the generic part.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 3bfd7c32803c..2f208aaa54cf 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -188,7 +188,7 @@ static inline unsigned int get_rate_shift(struct loopback_pcm *dpcm)
 }
 
 /* call in cable->lock */
-static int loopback_timer_start(struct loopback_pcm *dpcm)
+static int loopback_jiffies_timer_start(struct loopback_pcm *dpcm)
 {
 	unsigned long tick;
 	unsigned int rate_shift = get_rate_shift(dpcm);
@@ -209,7 +209,7 @@ static int loopback_timer_start(struct loopback_pcm *dpcm)
 }
 
 /* call in cable->lock */
-static inline int loopback_timer_stop(struct loopback_pcm *dpcm)
+static inline int loopback_jiffies_timer_stop(struct loopback_pcm *dpcm)
 {
 	del_timer(&dpcm->timer);
 	dpcm->timer.expires = 0;
@@ -217,7 +217,7 @@ static inline int loopback_timer_stop(struct loopback_pcm *dpcm)
 	return 0;
 }
 
-static inline int loopback_timer_stop_sync(struct loopback_pcm *dpcm)
+static inline int loopback_jiffies_timer_stop_sync(struct loopback_pcm *dpcm)
 {
 	del_timer_sync(&dpcm->timer);
 
@@ -502,7 +502,8 @@ static inline void bytepos_finish(struct loopback_pcm *dpcm,
 }
 
 /* call in cable->lock */
-static unsigned int loopback_pos_update(struct loopback_cable *cable)
+static unsigned int loopback_jiffies_timer_pos_update
+		(struct loopback_cable *cable)
 {
 	struct loopback_pcm *dpcm_play =
 			cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
@@ -555,14 +556,15 @@ static unsigned int loopback_pos_update(struct loopback_cable *cable)
 	return running;
 }
 
-static void loopback_timer_function(struct timer_list *t)
+static void loopback_jiffies_timer_function(struct timer_list *t)
 {
 	struct loopback_pcm *dpcm = from_timer(dpcm, t, timer);
 	unsigned long flags;
 
 	spin_lock_irqsave(&dpcm->cable->lock, flags);
-	if (loopback_pos_update(dpcm->cable) & (1 << dpcm->substream->stream)) {
-		loopback_timer_start(dpcm);
+	if (loopback_jiffies_timer_pos_update(dpcm->cable) &
+			(1 << dpcm->substream->stream)) {
+		loopback_jiffies_timer_start(dpcm);
 		if (dpcm->period_update_pending) {
 			dpcm->period_update_pending = 0;
 			spin_unlock_irqrestore(&dpcm->cable->lock, flags);
@@ -731,18 +733,18 @@ static void free_cable(struct snd_pcm_substream *substream)
 
 static int loopback_jiffies_timer_open(struct loopback_pcm *dpcm)
 {
-	timer_setup(&dpcm->timer, loopback_timer_function, 0);
+	timer_setup(&dpcm->timer, loopback_jiffies_timer_function, 0);
 
 	return 0;
 }
 
 static struct loopback_ops loopback_jiffies_timer_ops = {
 	.open = loopback_jiffies_timer_open,
-	.start = loopback_timer_start,
-	.stop = loopback_timer_stop,
-	.stop_sync = loopback_timer_stop_sync,
-	.close_substream = loopback_timer_stop_sync,
-	.pos_update = loopback_pos_update,
+	.start = loopback_jiffies_timer_start,
+	.stop = loopback_jiffies_timer_stop,
+	.stop_sync = loopback_jiffies_timer_stop_sync,
+	.close_substream = loopback_jiffies_timer_stop_sync,
+	.pos_update = loopback_jiffies_timer_pos_update,
 	.dpcm_info = loopback_jiffies_timer_dpcm_info,
 };
 
-- 
2.21.0

