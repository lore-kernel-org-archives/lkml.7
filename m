Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B02C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F7F20665
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565803029;
	bh=r9w7miScZdmWFyZcTYDiMP1IwH1WZO9gDwXNl10KY8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a93H/maxNcFU+bz86ZV/mrzlepPPvvH2K8AnJ9NUVlK2ZWoaZSKdCnRak2f/t9VM0
	 jK7LK8WJdKrus+PyVaF4Lu2ZJ8ufqh+7Y+vKaA14bYwhdpH/DBcX3mmM1Vo9+0DIQA
	 5hRoAMbYt4umuaYWctFKnWxiHnfKoxQIOH3lYK5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfHNRRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:17:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfHNRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:13:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162DF2133F;
        Wed, 14 Aug 2019 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802815;
        bh=r9w7miScZdmWFyZcTYDiMP1IwH1WZO9gDwXNl10KY8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gu3F3T59Xvo5/poc5a/VB5B5mpL+4/K6nK2X9NcDoHuT4hAIFRyBlIAMs13TqqIVy
         /ObwPqbs0BXXONDjuX8+xVifyqU0gVO7+3vWqkyj/5BykumHVa4fL3/HbsJBB+e+B8
         //VH6U3Zu/tloLUdniHGeqsH375rJ6ySGh0q0Dic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 36/69] ALSA: compress: Fix regression on compressed capture streams
Date:   Wed, 14 Aug 2019 19:01:34 +0200
Message-Id: <20190814165747.897532300@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
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
index 392bac18398ba..33a07c3badf01 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -186,10 +186,7 @@ static inline void snd_compr_drain_notify(struct snd_compr_stream *stream)
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
index 555df64d46ffc..cf1317546b0ff 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -575,10 +575,7 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
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
@@ -694,8 +691,17 @@ static int snd_compr_start(struct snd_compr_stream *stream)
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



