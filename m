Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3484FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140FE20674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 17:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKVRyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 12:54:13 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:26900 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKVRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 12:54:12 -0500
IronPort-SDR: aTQGpPbHQeysFyvmmKooF0K+ljHkFLMyXHrMD96xYppAN3W2el7mrj4evjUVBA+dPU8/TXAB4K
 ttyUgxtKew2rT6m/vhHZ2ATws+LIh7wHz/plNUFfpjutVxzD6Qxw6v0w5rOK8DUZyn6KnxNlJB
 fh5XwrXaSrE/aMGiaO3nX/zV2xNnQ0/D9jVsrDe7xCm6R2kmmsdBpHhzv+91S3/WZS6LNYjEQY
 DWNu9AnhHwwjMKp7irHfLzES0+Uv7yA+Nx+bKC3jqScawwjysM2HW5letHn2W+JqnpxbbpqUNH
 q9g=
X-IronPort-AV: E=Sophos;i="5.69,230,1571731200"; 
   d="scan'208";a="43434818"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 22 Nov 2019 09:53:12 -0800
IronPort-SDR: wF5LDk+dyX65opAPimVh69XX/p/Naarbwluir5E8WXg8Mh0HUe+SXC8pOKFVrRGqAOu3hN6cch
 XJnpWvbXeMUYwWTrqBe8NoyKJhslb9l1EE/GHcqm3Kokds2pGICYJMBLZTDZy1j/D7jwwA9Lqp
 ThFcxkRlL6LVOITHjJTADJcYLSL6xaAcmbN2fDh+hlVjtklIR58xN5LkhAfXMkPyuXbW0jU4wS
 ZUAw361MxV7ZEZi7x9txEyBAA9noHSNzxH9ZeprSXCbWypQSPhZTYOuX4ZDuZ9eBJimjmfCTXf
 /Go=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 1/2] ALSA: aloop: Remove redundant locking in timer open function
Date:   Fri, 22 Nov 2019 11:52:17 -0600
Message-ID: <20191122175218.17187-1-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-09.mgc.mentorg.com (139.181.222.9) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

loopback_parse_timer_id() uses snd_card_ref(), that can lock on mutex,
also snd_timer_instance_new() uses non-atomic allocation, that can sleep.
So, both functions can not be called from loopback_snd_timer_open()
with cable->lock spinlock locked.

Moreover, most part of loopback_snd_timer_open() function body works
when the opposite stream of the same cable does not yet exist, and
the current stream is not yet completely open and can't be running,
so existing locking of loopback->cable_lock mutex is enough to protect
from conflicts with simultaneous opening or closing.
Locking of cable->lock spinlock is not needed in this case.

Fixes: 26c53379f98d ("ALSA: aloop: Support selection of snd_timer instead of jiffies")
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 1408403f727a..6408932f5f72 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1107,20 +1107,18 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 	struct snd_timer_instance *timeri;
 	struct loopback_cable *cable = dpcm->cable;
 
-	spin_lock_irq(&cable->lock);
-
 	/* check if timer was already opened. It is only opened once
 	 * per playback and capture subdevice (aka cable).
 	 */
 	if (cable->snd_timer.instance)
-		goto unlock;
+		goto exit;
 
 	err = loopback_parse_timer_id(dpcm->loopback->timer_source, &tid);
 	if (err < 0) {
 		pcm_err(dpcm->substream->pcm,
 			"Parsing timer source \'%s\' failed with %d",
 			dpcm->loopback->timer_source, err);
-		goto unlock;
+		goto exit;
 	}
 
 	cable->snd_timer.stream = dpcm->substream->stream;
@@ -1129,7 +1127,7 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 	timeri = snd_timer_instance_new(dpcm->loopback->card->id);
 	if (!timeri) {
 		err = -ENOMEM;
-		goto unlock;
+		goto exit;
 	}
 	/* The callback has to be called from another tasklet. If
 	 * SNDRV_TIMER_IFLG_FAST is specified it will be called from the
@@ -1148,10 +1146,9 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 	tasklet_init(&cable->snd_timer.event_tasklet,
 		     loopback_snd_timer_tasklet, (unsigned long)timeri);
 
-	/* snd_timer_close() and snd_timer_open() should not be called with
-	 * locked spinlock because both functions can block on a mutex. The
-	 * mutex loopback->cable_lock is kept locked. Therefore snd_timer_open()
-	 * cannot be called a second time by the other device of the same cable.
+	/* The mutex loopback->cable_lock is kept locked.
+	 * Therefore snd_timer_open() cannot be called a second time
+	 * by the other device of the same cable.
 	 * Therefore the following issue cannot happen:
 	 * [proc1] Call loopback_timer_open() ->
 	 *	   Unlock cable->lock for snd_timer_close/open() call
@@ -1160,9 +1157,7 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 	 * [proc1] Call snd_timer_open() and overwrite running timer
 	 *	   instance
 	 */
-	spin_unlock_irq(&cable->lock);
 	err = snd_timer_open(timeri, &cable->snd_timer.id, current->pid);
-	spin_lock_irq(&cable->lock);
 	if (err < 0) {
 		pcm_err(dpcm->substream->pcm,
 			"snd_timer_open (%d,%d,%d) failed with %d",
@@ -1171,14 +1166,12 @@ static int loopback_snd_timer_open(struct loopback_pcm *dpcm)
 			cable->snd_timer.id.subdevice,
 			err);
 		snd_timer_instance_free(timeri);
-		goto unlock;
+		goto exit;
 	}
 
 	cable->snd_timer.instance = timeri;
 
-unlock:
-	spin_unlock_irq(&cable->lock);
-
+exit:
 	return err;
 }
 
-- 
2.21.0

