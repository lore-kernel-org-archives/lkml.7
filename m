Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B7C00454
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E2C20838
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLJOOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:14:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:32884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbfLJOOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:14:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26925AF79;
        Tue, 10 Dec 2019 14:14:05 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH for-5.6 4/4] staging: bcm2835-audio: Drop superfluous ioctl PCM ops
Date:   Tue, 10 Dec 2019 15:13:56 +0100
Message-Id: <20191210141356.18074-5-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210141356.18074-1-tiwai@suse.de>
References: <20191210141356.18074-1-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCM core deals the empty ioctl field now as default.
Let's kill the redundant lines.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
index 97726b190bc5..33485184a98a 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c
@@ -305,7 +305,6 @@ snd_bcm2835_pcm_pointer(struct snd_pcm_substream *substream)
 static const struct snd_pcm_ops snd_bcm2835_playback_ops = {
 	.open = snd_bcm2835_playback_open,
 	.close = snd_bcm2835_playback_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = snd_bcm2835_pcm_prepare,
 	.trigger = snd_bcm2835_pcm_trigger,
 	.pointer = snd_bcm2835_pcm_pointer,
@@ -315,7 +314,6 @@ static const struct snd_pcm_ops snd_bcm2835_playback_ops = {
 static const struct snd_pcm_ops snd_bcm2835_playback_spdif_ops = {
 	.open = snd_bcm2835_playback_spdif_open,
 	.close = snd_bcm2835_playback_close,
-	.ioctl = snd_pcm_lib_ioctl,
 	.prepare = snd_bcm2835_pcm_prepare,
 	.trigger = snd_bcm2835_pcm_trigger,
 	.pointer = snd_bcm2835_pcm_pointer,
-- 
2.16.4

