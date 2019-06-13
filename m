Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B1CC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E463120665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391174AbfFMQE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:04:29 -0400
Received: from sauhun.de ([88.99.104.3]:42058 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbfFMQE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 12:04:27 -0400
Received: from localhost (p5486CF99.dip0.t-ipconnect.de [84.134.207.153])
        by pokefinder.org (Postfix) with ESMTPSA id EB38D4A127B;
        Thu, 13 Jun 2019 18:04:25 +0200 (CEST)
From:   Wolfram Sang <wsa@the-dreams.de>
To:     alsa-devel@alsa-project.org
Cc:     Wolfram Sang <wsa@the-dreams.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pci: echoaudio: remove variable which is a constant
Date:   Thu, 13 Jun 2019 18:04:23 +0200
Message-Id: <20190613160423.17097-1-wsa@the-dreams.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking a variable which is always '1' has no use.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested. Found by static code analysis of similar patterns.

 sound/pci/echoaudio/echoaudio_dsp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index b181752b8481..50d4a87a6bb3 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -1058,7 +1058,6 @@ static int allocate_pipes(struct echoaudio *chip, struct audiopipe *pipe,
 {
 	int i;
 	u32 channel_mask;
-	char is_cyclic;
 
 	dev_dbg(chip->card->dev,
 		"allocate_pipes: ch=%d int=%d\n", pipe_index, interleave);
@@ -1066,8 +1065,6 @@ static int allocate_pipes(struct echoaudio *chip, struct audiopipe *pipe,
 	if (chip->bad_board)
 		return -EIO;
 
-	is_cyclic = 1;	/* This driver uses cyclic buffers only */
-
 	for (channel_mask = i = 0; i < interleave; i++)
 		channel_mask |= 1 << (pipe_index + i);
 	if (chip->pipe_alloc_mask & channel_mask) {
@@ -1078,8 +1075,8 @@ static int allocate_pipes(struct echoaudio *chip, struct audiopipe *pipe,
 
 	chip->comm_page->position[pipe_index] = 0;
 	chip->pipe_alloc_mask |= channel_mask;
-	if (is_cyclic)
-		chip->pipe_cyclic_mask |= channel_mask;
+	/* This driver uses cyclic buffers only */
+	chip->pipe_cyclic_mask |= channel_mask;
 	pipe->index = pipe_index;
 	pipe->interleave = interleave;
 	pipe->state = PIPE_STATE_STOPPED;
-- 
2.20.1

