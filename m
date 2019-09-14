Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18236C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCB2206A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfINPZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:25:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfINPY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 11:24:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0887AEB3;
        Sat, 14 Sep 2019 15:24:57 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835-audio: Fix draining behavior regression
Date:   Sat, 14 Sep 2019 17:24:05 +0200
Message-Id: <20190914152405.7416-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCM draining behavior got broken since the recent refactoring, and
this turned out to be the incorrect expectation of the firmware
behavior regarding "draining".  While I expected the "drain" flag at
the stop operation would do processing the queued samples, it seems
rather dropping the samples.

As a quick fix, just drop the SNDRV_PCM_INFO_DRAIN_TRIGGER flag, so
that the driver uses the normal PCM draining procedure.  Also, put
some caution comment to the function for future readers not to fall
into the same pitfall.

Fixes: d7ca3a71545b ("staging: bcm2835-audio: Operate non-atomic PCM ops")
BugLink: https://github.com/raspberrypi/linux/issues/2983
Cc: stable@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c   | 4 ++--
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index bc1eaa3a0773..826016c3431a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -12,7 +12,7 @@
 static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
+		 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats = SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
 	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
 	.rate_min = 8000,
@@ -29,7 +29,7 @@ static const struct snd_pcm_hardware snd_bcm2835_playback_hw = {
 static const struct snd_pcm_hardware snd_bcm2835_playback_spdif_hw = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
-		 SNDRV_PCM_INFO_DRAIN_TRIGGER | SNDRV_PCM_INFO_SYNC_APPLPTR),
+		 SNDRV_PCM_INFO_SYNC_APPLPTR),
 	.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	.rates = SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_44100 |
 	SNDRV_PCM_RATE_48000,
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
index 23fba01107b9..c6f9cf1913d2 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
@@ -289,6 +289,7 @@ int bcm2835_audio_stop(struct bcm2835_alsa_stream *alsa_stream)
 					 VC_AUDIO_MSG_TYPE_STOP, false);
 }
 
+/* FIXME: this doesn't seem working as expected for "draining" */
 int bcm2835_audio_drain(struct bcm2835_alsa_stream *alsa_stream)
 {
 	struct vc_audio_msg m = {
-- 
2.16.4

