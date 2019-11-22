Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D901BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A003E20704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 19:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452468;
	bh=PgmHLsBySMD/WAnnTimLDpSm6vxvYajJ38PYZvgkUhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=go8EqyMHr8UuILQAzUi+zGVi0BTOExv+egpXwvVIAWyyFXDIvJkOGn25Il/3bKXFX
	 Nhy+slOaIpXoUFEQJMSpS+3L7QYIRR95kdYl009nA4z7234YuUf1NWSgKZLcqP+Fy7
	 Us0Nen8Osexm9yBHIvPpMPAKcCmXHvnMscoicjh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfKVTy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:54:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfKVTtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 14:49:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CFF20748;
        Fri, 22 Nov 2019 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452154;
        bh=PgmHLsBySMD/WAnnTimLDpSm6vxvYajJ38PYZvgkUhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IPNz2N0BqMim9CviXVGJlJoM+CRMyIzygL7/DcKdeA1CJbwVWrM0SD/a+H4r143Tl
         W5PHpw0t3aejWUAefncqbCwFyyPZXC5pusxLFJiFcz6wPCnz0DIUY0qNyGHeZMreTA
         FuLJ3p7YRMvIrjcssuDnIpMTv43mDgaOtihyvQu0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     paulhsia <paulhsia@chromium.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 12/25] ALSA: pcm: Fix stream lock usage in snd_pcm_period_elapsed()
Date:   Fri, 22 Nov 2019 14:48:45 -0500
Message-Id: <20191122194859.24508-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122194859.24508-1-sashal@kernel.org>
References: <20191122194859.24508-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: paulhsia <paulhsia@chromium.org>

[ Upstream commit f5cdc9d4003a2f66ea57b3edd3e04acc2b1a4439 ]

If the nullity check for `substream->runtime` is outside of the lock
region, it is possible to have a null runtime in the critical section
if snd_pcm_detach_substream is called right before the lock.

Signed-off-by: paulhsia <paulhsia@chromium.org>
Link: https://lore.kernel.org/r/20191112171715.128727-2-paulhsia@chromium.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 4e6110d778bd2..ad52126d3d22e 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1797,11 +1797,14 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime;
 	unsigned long flags;
 
-	if (PCM_RUNTIME_CHECK(substream))
+	if (snd_BUG_ON(!substream))
 		return;
-	runtime = substream->runtime;
 
 	snd_pcm_stream_lock_irqsave(substream, flags);
+	if (PCM_RUNTIME_CHECK(substream))
+		goto _unlock;
+	runtime = substream->runtime;
+
 	if (!snd_pcm_running(substream) ||
 	    snd_pcm_update_hw_ptr0(substream, 1) < 0)
 		goto _end;
@@ -1812,6 +1815,7 @@ void snd_pcm_period_elapsed(struct snd_pcm_substream *substream)
 #endif
  _end:
 	kill_fasync(&runtime->fasync, SIGIO, POLL_IN);
+ _unlock:
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
 }
 EXPORT_SYMBOL(snd_pcm_period_elapsed);
-- 
2.20.1

