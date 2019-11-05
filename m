Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9D8C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F4B21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 14:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389748AbfKEOed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 09:34:33 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:53861 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389185AbfKEOec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 09:34:32 -0500
IronPort-SDR: ahpSNUnGL3PqP0tcnBiAX1ctLLQvjFVobSMxkzGt2wV6cytx1dzt9DXERyNFTEOo1o7fmd8lBA
 fGE+/Nl2jL/MdtelUv4Jwy2YSS5fXcPzXXLJAUnwEqaPxt787gs1hNsOv1uCTzTsE/2oLOe7D+
 OZh6SAg3AfnvkpumDFLvkgFzdROFr7Cm1/gxsRbLyXbp1AuQ5TdP54PrOKRfY/ZuQh0zqbQnOi
 aiV87hdV37yL69BTqSvH1O/o/W9axciWRsDJBB/n4tAl191fyrOVTVXLSYxjh/Znjj/8A/upyy
 lBM=
X-IronPort-AV: E=Sophos;i="5.68,271,1569312000"; 
   d="scan'208";a="42878541"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 05 Nov 2019 06:34:31 -0800
IronPort-SDR: ivTcNRoZqcAx0GOcM23pubI0ZZ3SSMV0aEjNmuNj7UiFhAKUaeXfdYiagSsfkEkcaox5dYXLA9
 U3lV4vHiI7zqTM16wIA0m5boJ3r+GlH/eRn5RJ2Q6yyXDNP60GQts9RHRBpY9yhHj5MGYzH9fX
 zQREtmjAKLLLW/Ad7Dp/LSPNaaZ0S5NgdaMkFcb8CSvE1BYBekmwSWQf8KWK5k+bnHbtuXJQRt
 JQgGHbeNrXMUgE2dyL9v3EVevUf3GnYppDYfcPOTN9ZNCY3kvVQaDElvuBSzYWDnMdSvd8sSTF
 4Zc=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH v2 5/8] ALSA: aloop: Rename all jiffies timer specific functions
Date:   Tue, 5 Nov 2019 08:32:15 -0600
Message-ID: <20191105143218.5948-6-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105143218.5948-5-andrew_gabbasov@mentor.com>
References: <20191105143218.5948-1-andrew_gabbasov@mentor.com>
 <20191105143218.5948-2-andrew_gabbasov@mentor.com>
 <20191105143218.5948-3-andrew_gabbasov@mentor.com>
 <20191105143218.5948-4-andrew_gabbasov@mentor.com>
 <20191105143218.5948-5-andrew_gabbasov@mentor.com>
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

This commit does not change the behaviour. It only separates the jiffies
timer specific implementation from the generic part.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 92134e9c6ea7..178f7260a650 100644
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
@@ -732,18 +734,18 @@ static void free_cable(struct snd_pcm_substream *substream)
 
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

