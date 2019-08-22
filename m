Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFB123400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566494539;
	bh=QaYLitf28++zoQll8y97+7nUquOIPERVuEw+AXt5wP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bQ6Pji7CMCf5t4S4Q1GWZYAFkJ2YX9IbS+ki2YVxD2NfSKUDrbIh8E2F0e802qiI0
	 PCP3YofjnGmE7BvJQuA8Z4885AZAm6ecNg9jA1BQT/VGDae/tZnfuZ9zulCcjXScM2
	 zhZKw4Ep36zXrTZ3IRI/+s03D4G4BTdy3nhX+PK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbfHVRWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389867AbfHVRWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:22:17 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40911233FD;
        Thu, 22 Aug 2019 17:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494536;
        bh=QaYLitf28++zoQll8y97+7nUquOIPERVuEw+AXt5wP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zIGn2wlLaDQdWG0HtkEeDOIFxjMNLET+GcS80HFqYesfkf5wzZM0vx4BZYYRUzO+r
         LFVco8tNS/G/rSkAliVOWyWJI3ku7ed6pQBl2k3JjGPQ1U74wkMh0MA610pOYGnvrl
         fTpDUo0A4tyaB0w/wi+pq7JNvgQHd8Pg2sIvwroE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 15/78] ALSA: compress: Fix regression on compressed capture streams
Date:   Thu, 22 Aug 2019 10:18:19 -0700
Message-Id: <20190822171832.482436940@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171832.012773482@linuxfoundation.org>
References: <20190822171832.012773482@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 4475f8c4ab7b248991a60d9c02808dbb813d6be8 ]

A previous fix to the stop handling on compressed capture streams causes
some knock on issues. The previous fix updated snd_compr_drain_notify to
set the state back to PREPARED for capture streams. This causes some
issues however as the handling for snd_compr_poll differs between the
two states and some user-space applications were relying on the poll
failing after the stream had been stopped.

To correct this regression whilst still fixing the original problem the
patch was addressing, update the capture handling to skip the PREPARED
state rather than skipping the SETUP state as it has done until now.

Fixes: 4f2ab5e1d13d ("ALSA: compress: Fix stop handling on compressed capture streams")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/compress_driver.h |  5 +----
 sound/core/compress_offload.c   | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 85ff3181e6f11..a5c6e6da3d3d4 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -178,10 +178,7 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
 	if (snd_BUG_ON(!stream))
 		return;
 
-	if (stream->direction == SND_COMPRESS_PLAYBACK)
-		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
-	else
-		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
+	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
 
 	wake_up(&stream->runtime->sleep);
 }
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 3c88a33840645..16269e7ff3904 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -551,10 +551,7 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		stream->metadata_set = false;
 		stream->next_track = false;
 
-		if (stream->direction == SND_COMPRESS_PLAYBACK)
-			stream->runtime->state = SNDRV_PCM_STATE_SETUP;
-		else
-			stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
+		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
 	} else {
 		return -EPERM;
 	}
@@ -670,8 +667,17 @@ static int snd_compr_start(struct snd_compr_stream *stream)
 {
 	int retval;
 
-	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED)
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_SETUP:
+		if (stream->direction != SND_COMPRESS_CAPTURE)
+			return -EPERM;
+		break;
+	case SNDRV_PCM_STATE_PREPARED:
+		break;
+	default:
 		return -EPERM;
+	}
+
 	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_START);
 	if (!retval)
 		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
-- 
2.20.1



