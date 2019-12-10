Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E015C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157F420836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfLJOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:14:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:32862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbfLJOOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:14:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E394AAF26;
        Tue, 10 Dec 2019 14:14:04 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH for-5.6 1/4] staging: most: Use managed buffer allocation
Date:   Tue, 10 Dec 2019 15:13:53 +0100
Message-Id: <20191210141356.18074-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210141356.18074-1-tiwai@suse.de>
References: <20191210141356.18074-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the driver with the new managed buffer allocation API.
Also remove the unnecessary checks of channels in hw_params callback
as this is guaranteed by the hw constraints in anyway.
After these cleanups, the hw_params and hw_free callbacks became
empty, hence dropped.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/most/sound/sound.c | 44 +-------------------------------------
 1 file changed, 1 insertion(+), 43 deletions(-)

diff --git a/drivers/staging/most/sound/sound.c b/drivers/staging/most/sound/sound.c
index 723d0bd1cc21..7c212c0db980 100644
--- a/drivers/staging/most/sound/sound.c
+++ b/drivers/staging/most/sound/sound.c
@@ -322,45 +322,6 @@ static int pcm_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-/**
- * pcm_hw_params - implements hw_params callback function for PCM middle layer
- * @substream: sub-stream pointer
- * @hw_params: contains the hardware parameters set by the application
- *
- * This is called when the hardware parameters is set by the application, that
- * is, once when the buffer size, the period size, the format, etc. are defined
- * for the PCM substream. Many hardware setups should be done is this callback,
- * including the allocation of buffers.
- *
- * Returns 0 on success or error code otherwise.
- */
-static int pcm_hw_params(struct snd_pcm_substream *substream,
-			 struct snd_pcm_hw_params *hw_params)
-{
-	struct channel *channel = substream->private_data;
-
-	if ((params_channels(hw_params) > channel->pcm_hardware.channels_max) ||
-	    (params_channels(hw_params) < channel->pcm_hardware.channels_min)) {
-		pr_err("Requested number of channels not supported.\n");
-		return -EINVAL;
-	}
-	return snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params));
-}
-
-/**
- * pcm_hw_free - implements hw_free callback function for PCM middle layer
- * @substream: substream pointer
- *
- * This is called to release the resources allocated via hw_params.
- * This function will be always called before the close callback is called.
- *
- * Returns 0 on success or error code otherwise.
- */
-static int pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	return snd_pcm_lib_free_pages(substream);
-}
-
 /**
  * pcm_prepare - implements prepare callback function for PCM middle layer
  * @substream: substream pointer
@@ -463,8 +424,6 @@ static const struct snd_pcm_ops pcm_ops = {
 	.open       = pcm_open,
 	.close      = pcm_close,
 	.ioctl      = snd_pcm_lib_ioctl,
-	.hw_params  = pcm_hw_params,
-	.hw_free    = pcm_hw_free,
 	.prepare    = pcm_prepare,
 	.trigger    = pcm_trigger,
 	.pointer    = pcm_pointer,
@@ -661,8 +620,7 @@ static int audio_probe_channel(struct most_interface *iface, int channel_id,
 	pcm->private_data = channel;
 	strscpy(pcm->name, device_name, sizeof(pcm->name));
 	snd_pcm_set_ops(pcm, direction, &pcm_ops);
-	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_VMALLOC,
-					      NULL, 0, 0);
+	snd_pcm_set_managed_buffer_all(pcm, SNDRV_DMA_TYPE_VMALLOC, NULL, 0, 0);
 
 	return 0;
 
-- 
2.16.4

