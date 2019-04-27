Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F215206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfD0PQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:16:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33922 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727580AbfD0PPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:33 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP34-0000zM-Fh; Sat, 27 Apr 2019 16:15:30 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0004Wg-Lx; Sat, 27 Apr 2019 16:15:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Charles Keepax" <ckeepax@opensource.cirrus.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.315784436@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 103/202] ALSA: compress: Fix stop handling on
 compressed capture streams
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 4f2ab5e1d13d6aa77c55f4914659784efd776eb4 upstream.

It is normal user behaviour to start, stop, then start a stream
again without closing it. Currently this works for compressed
playback streams but not capture ones.

The states on a compressed capture stream go directly from OPEN to
PREPARED, unlike a playback stream which moves to SETUP and waits
for a write of data before moving to PREPARED. Currently however,
when a stop is sent the state is set to SETUP for both types of
streams. This leaves a capture stream in the situation where a new
start can't be sent as that requires the state to be PREPARED and
a new set_params can't be sent as that requires the state to be
OPEN. The only option being to close the stream, and then reopen.

Correct this issues by allowing snd_compr_drain_notify to set the
state depending on the stream direction, as we already do in
set_params.

Fixes: 49bb6402f1aa ("ALSA: compress_core: Add support for capture streams")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/sound/compress_driver.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -176,7 +176,11 @@ static inline void snd_compr_drain_notif
 	if (snd_BUG_ON(!stream))
 		return;
 
-	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	if (stream->direction == SND_COMPRESS_PLAYBACK)
+		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	else
+		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
+
 	wake_up(&stream->runtime->sleep);
 }
 

