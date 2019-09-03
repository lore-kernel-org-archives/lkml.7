Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572ABC3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E0823789
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528021;
	bh=IDegn3PA5hO68dkXxmfnYOmtBRQOB+r1GrT3sBEHpmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0MwYR4veo+weOGNmLn9e4RRRctxpCKKLFus8fAehwyaH53qy9+SkGdWLDjfd36Tk2
	 92j2aQiRQHHm6iHV7gug0oMcUvYkntHuHy+UausAYE8ZO3HtwZqi2Wn7D/gHyT1/rp
	 z5NpwjuPKK0ZOBvzNQWIhMfTuGb5wo5eTPHdBVEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfICQ07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:26:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730725AbfICQ0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:26:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91511238C5;
        Tue,  3 Sep 2019 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528011;
        bh=IDegn3PA5hO68dkXxmfnYOmtBRQOB+r1GrT3sBEHpmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCZXqinraaRzNmx7nhj7DvbnWaAMutnvb+qZUS0eV5h2E0Hsc2HLLMKWt23TskIPn
         Zz2xiTG8kLOBtnybQs0m439SxjnxXDys4hv9XvQKsmNx6WyOzdlJKSI/zabszKPwAU
         TZa3iFGuz3rOQtnqErw4vLM++qm4Wd5Nl/X+1d8Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricardo Biehl Pasquali <pasqualirb@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 052/167] ALSA: pcm: Update hardware pointer before start capture
Date:   Tue,  3 Sep 2019 12:23:24 -0400
Message-Id: <20190903162519.7136-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>

[ Upstream commit 64b6acf60b665fffd419c23886a1cbeeb253cfb4 ]

This ensures the transfer loop won't waste a run to read
the few frames (if any) between start and hw_ptr update.
It will wait for the next interrupt with wait_for_avail().

Signed-off-by: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_lib.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 7f71c2449af5e..40013b26f6719 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2172,6 +2172,10 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 	if (err < 0)
 		goto _end_unlock;
 
+	runtime->twake = runtime->control->avail_min ? : 1;
+	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+		snd_pcm_update_hw_ptr(substream);
+
 	if (!is_playback &&
 	    runtime->status->state == SNDRV_PCM_STATE_PREPARED) {
 		if (size >= runtime->start_threshold) {
@@ -2185,10 +2189,8 @@ snd_pcm_sframes_t __snd_pcm_lib_xfer(struct snd_pcm_substream *substream,
 		}
 	}
 
-	runtime->twake = runtime->control->avail_min ? : 1;
-	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
-		snd_pcm_update_hw_ptr(substream);
 	avail = snd_pcm_avail(substream);
+
 	while (size > 0) {
 		snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
 		snd_pcm_uframes_t cont;
-- 
2.20.1

