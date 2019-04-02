Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B30C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E10B2148E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfDBNko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:40:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43782 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731383AbfDBNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:13 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe6-0002ny-Sk; Tue, 02 Apr 2019 14:40:11 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004vH-Va; Tue, 02 Apr 2019 14:40:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.797525697@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 60/99] ALSA: emu10k1: Fix potential Spectre v1
 vulnerabilities
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

commit 5ae4f61f012a097df93de2285070ec8e34716d29 upstream.

ipcm->substream is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

sound/pci/emu10k1/emufx.c:1031 snd_emu10k1_ipcm_poke() warn: potential spectre issue 'emu->fx8010.pcm' [r] (local cap)
sound/pci/emu10k1/emufx.c:1075 snd_emu10k1_ipcm_peek() warn: potential spectre issue 'emu->fx8010.pcm' [r] (local cap)

Fix this by sanitizing ipcm->substream before using it to index emu->fx8010.pcm

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/emu10k1/emufx.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -36,6 +36,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/moduleparam.h>
+#include <linux/nospec.h>
 
 #include <sound/core.h>
 #include <sound/tlv.h>
@@ -1001,6 +1002,8 @@ static int snd_emu10k1_ipcm_poke(struct
 
 	if (ipcm->substream >= EMU10K1_FX8010_PCM_COUNT)
 		return -EINVAL;
+	ipcm->substream = array_index_nospec(ipcm->substream,
+					     EMU10K1_FX8010_PCM_COUNT);
 	if (ipcm->channels > 32)
 		return -EINVAL;
 	pcm = &emu->fx8010.pcm[ipcm->substream];
@@ -1047,6 +1050,8 @@ static int snd_emu10k1_ipcm_peek(struct
 
 	if (ipcm->substream >= EMU10K1_FX8010_PCM_COUNT)
 		return -EINVAL;
+	ipcm->substream = array_index_nospec(ipcm->substream,
+					     EMU10K1_FX8010_PCM_COUNT);
 	pcm = &emu->fx8010.pcm[ipcm->substream];
 	mutex_lock(&emu->fx8010.lock);
 	spin_lock_irq(&emu->reg_lock);

