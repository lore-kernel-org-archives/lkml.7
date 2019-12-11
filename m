Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10CCC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF4124671
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576077398;
	bh=PgmHLsBySMD/WAnnTimLDpSm6vxvYajJ38PYZvgkUhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q2Wk53aGimGKs1gRJBTOBXocucfUXJIPafj+ZVeZghvD5M7Y5Nz0I20Pek5pv+GtP
	 xT4yAa5PBHWP6B9QxfbZ+gQE7aksa+v6PbokyfUhm5LAmiEVykQw+pqfh9pKa5ZOQu
	 +/pgS6S0zN9/qa1ph3/4eQAm1EAzvIhhf0Zy7Tnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfLKPQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:16:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729948AbfLKPQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:16:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FBBD22B48;
        Wed, 11 Dec 2019 15:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077391;
        bh=PgmHLsBySMD/WAnnTimLDpSm6vxvYajJ38PYZvgkUhw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMaPxVIBIWxeTZqJGgvYS16fZ4JxCp4KvkZO31vDQQjO4tcvSFuOFocyK3i3qHQ3o
         BrjAv7tHphpEgpzbyggI+PCMjmNH5fdXcrd1DE5iQeL1jH0MZD/J7KHJKXXkh+sq77
         9HnFAm2fRwMgHIRJlhFx+JawgACxy/bW1IGdJzrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, paulhsia <paulhsia@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 021/243] ALSA: pcm: Fix stream lock usage in snd_pcm_period_elapsed()
Date:   Wed, 11 Dec 2019 16:03:03 +0100
Message-Id: <20191211150340.396129292@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



