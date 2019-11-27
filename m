Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD81CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8EC2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfK0LHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:07:01 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:62493 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfK0LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:07:01 -0500
IronPort-SDR: deNbieP6UdTGobvEVjuheEuC+WeKYnNuW0vlcJUn8JQUuAz2tkjQsC1NaJlJ22n7a4uHgPUfct
 dcXrt4d0AEblFMgF1GpNGfYRJTUzLNgQP/zYuOWW33oW4zlpSqhF/rs9OF3QhgBfTv0QN2MCGm
 mNTJL9UaXN1D0pFoLgFl0Vf4W/u6o/562tVmEX1OyFJd1FlWRS/rpttxV4SrJFRnvoViQ6ZnA7
 cTKeh09V+b5CeKMoDy5CMwaiC6dFR5GxYxlY+Kj2qjn73q2fJRJRTty3HVG0vyGAPWDv8gD47k
 tMY=
X-IronPort-AV: E=Sophos;i="5.69,249,1571731200"; 
   d="scan'208";a="45434597"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 27 Nov 2019 03:06:53 -0800
IronPort-SDR: u9bLZta3qFDdDn6N2mrrxy/SSduvpuQXHCs4GzEAimH8hT9GV/ZDtuYTMeaNTxiKsxAJe7CtJP
 zUihfbkrxFMmtK5aDg68fMXYy/NQ1FAx7FzEsguO69B+ZeJn//7bunzdnv0ZcUmPEx0P1xp9iJ
 HJZLf2XdThAbRjL0eKSq4qBai6cke5owvWvF105W965Olfp6EzEnvtW7yHhyAeE3wuAHTi369n
 SG+QXifuJMQ2gL3iR7fr16+D9IKsU3c4jA/fnY5MXsGDbm6fCHmcZHXdYQ0TIqkWqEB1f9iPVT
 9X8=
From:   Andrew Gabbasov <andrew_gabbasov@mentor.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Timo Wischer <twischer@de.adit-jv.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH] ALSA: aloop: Avoid pointer dereference before null-check
Date:   Wed, 27 Nov 2019 05:06:22 -0600
Message-ID: <20191127110622.26105-1-andrew_gabbasov@mentor.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static analysis tools (cppcheck and PVS Studio) report an error
in loopback_snd_timer_period_elapsed() regarding dpcm_play pointer
dereference earlier than its null-check. And although this is a result
of a formal check, and the pointer correctness is also protected
by having a corresponding bit set in the "running" mask, re-ordering
of the lines can imake the code even formally correct and eliminate
those static analysis error reports.

Fixes: 26c53379f98d ("ALSA: aloop: Support selection of snd_timer instead of jiffies")
Reported-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/drivers/aloop.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 0ebfbe70db00..6bb46423f5ae 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -727,10 +727,6 @@ static void loopback_snd_timer_period_elapsed(struct loopback_cable *cable,
 
 	dpcm_play = cable->streams[SNDRV_PCM_STREAM_PLAYBACK];
 	dpcm_capt = cable->streams[SNDRV_PCM_STREAM_CAPTURE];
-	substream_play = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
-			dpcm_play->substream : NULL;
-	substream_capt = (running & (1 << SNDRV_PCM_STREAM_CAPTURE)) ?
-			dpcm_capt->substream : NULL;
 
 	if (event == SNDRV_TIMER_EVENT_MSTOP) {
 		if (!dpcm_play ||
@@ -741,6 +737,10 @@ static void loopback_snd_timer_period_elapsed(struct loopback_cable *cable,
 		}
 	}
 
+	substream_play = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
+			dpcm_play->substream : NULL;
+	substream_capt = (running & (1 << SNDRV_PCM_STREAM_CAPTURE)) ?
+			dpcm_capt->substream : NULL;
 	valid_runtime = (running & (1 << SNDRV_PCM_STREAM_PLAYBACK)) ?
 				dpcm_play->substream->runtime :
 				dpcm_capt->substream->runtime;
-- 
2.21.0

