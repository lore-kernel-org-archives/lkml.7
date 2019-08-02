Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B08C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAB22173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752137;
	bh=fgYQmhenvxKgy2yM4rFIOFAEyr/6mfSDZcosc71U7TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvlKx8Kvbbt2Atl+1kUZbHsmZJ6KEmUBaW39tjVpZZzU5YYvxBXpAZc9WHCKFia94
	 pcDjT45pIKljVjU4J9smMu8f5+yFAEEzCV2j4Jv3UiQGcwOMyBqzY23NvIaoNwq2yp
	 fymfPGm5L5fHNCCvSNSHlwSHbbkEbYJeRzBttXxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393688AbfHBNWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393653AbfHBNV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:21:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D432183F;
        Fri,  2 Aug 2019 13:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752115;
        bh=fgYQmhenvxKgy2yM4rFIOFAEyr/6mfSDZcosc71U7TA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0iuGt9AN71kAvc/2hRYLyfmFXZxycqsP2ugDqC9vmcGXwnqlmFU3repwIWrxY2e0/
         2bK3Zp1YLfkqP1BE+flxlPlw9fFNZSMEu5Htwnj7bpiGNpHiH+5V9vdGzP9YYdvRV7
         /U+z+ya5ehkoNY8mFYV3UacPJ1ySfAB11lUzIq/w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 49/76] ALSA: compress: Prevent bypasses of set_params
Date:   Fri,  2 Aug 2019 09:19:23 -0400
Message-Id: <20190802131951.11600-49-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 26c3f1542f5064310ad26794c09321780d00c57d ]

Currently, whilst in SNDRV_PCM_STATE_OPEN it is possible to call
snd_compr_stop, snd_compr_drain and snd_compr_partial_drain, which
allow a transition to SNDRV_PCM_STATE_SETUP. The stream should
only be able to move to the setup state once it has received a
SNDRV_COMPRESS_SET_PARAMS ioctl. Fix this issue by not allowing
those ioctls whilst in the open state.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/compress_offload.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index d79aee6b9edd2..40dae723c59db 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -711,9 +711,15 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
 {
 	int retval;
 
-	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
-			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
+	case SNDRV_PCM_STATE_SETUP:
+	case SNDRV_PCM_STATE_PREPARED:
 		return -EPERM;
+	default:
+		break;
+	}
+
 	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP);
 	if (!retval) {
 		snd_compr_drain_notify(stream);
@@ -801,9 +807,14 @@ static int snd_compr_drain(struct snd_compr_stream *stream)
 {
 	int retval;
 
-	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
-			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
+	case SNDRV_PCM_STATE_SETUP:
+	case SNDRV_PCM_STATE_PREPARED:
 		return -EPERM;
+	default:
+		break;
+	}
 
 	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
 	if (retval) {
@@ -840,9 +851,16 @@ static int snd_compr_next_track(struct snd_compr_stream *stream)
 static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 {
 	int retval;
-	if (stream->runtime->state == SNDRV_PCM_STATE_PREPARED ||
-			stream->runtime->state == SNDRV_PCM_STATE_SETUP)
+
+	switch (stream->runtime->state) {
+	case SNDRV_PCM_STATE_OPEN:
+	case SNDRV_PCM_STATE_SETUP:
+	case SNDRV_PCM_STATE_PREPARED:
 		return -EPERM;
+	default:
+		break;
+	}
+
 	/* stream can be drained only when next track has been signalled */
 	if (stream->next_track == false)
 		return -EPERM;
-- 
2.20.1

