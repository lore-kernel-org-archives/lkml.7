Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6387C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDC7217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565127240;
	bh=YWZMTuicYL37W61tyGEDFMuUQiDu4m6h46X35x3t5h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyDwF89bkLDW1PeL/LynwnDPP0DQNJ5d5+uCNYWKN4pydDEiTcfo8kofjWuljLabo
	 U4NEtzi9cQFXGP26OrYNQT4LMTna8LJBdec8uft/FPONxK63dumnSQaOe1hR6OWMGS
	 sJKyZNVLgjNcrxcq27jzgzFpv9fEuH+dE69SxaKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfHFVd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727324AbfHFVdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:33:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8423B21743;
        Tue,  6 Aug 2019 21:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565127232;
        bh=YWZMTuicYL37W61tyGEDFMuUQiDu4m6h46X35x3t5h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Be9ieqRNixxKdnMAM0zYAo1XUd2ZNj7DNYZsdYszaXhkXsGKL3Jg3MXW+CGMX7FZD
         VB001adF+KKNQIs26jzxZ0VSi6nd+Xr2PNkwbqTH1UtRbPdKdMy85UPxBZAHX3jwz4
         6pMdO7nZFefSZMfMvewwFlkbsBnFRRhK0yXNNqkg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuki Tsunashima <ytsunashima@jp.adit-jv.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Adam Miartus <amiartus@de.adit-jv.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 19/59] ALSA: pcm: fix lost wakeup event scenarios in snd_pcm_drain
Date:   Tue,  6 Aug 2019 17:32:39 -0400
Message-Id: <20190806213319.19203-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuki Tsunashima <ytsunashima@jp.adit-jv.com>

[ Upstream commit 37151a41df800493cfcbbef4f7208ffe04feb959 ]

lost wakeup can occur after enabling irq, therefore put task
into interruptible before enabling interrupts,

without this change, task can be put to sleep and snd_pcm_drain
will delay

Fixes: f2b3614cefb6 ("ALSA: PCM - Don't check DMA time-out too shortly")
Signed-off-by: Yuki Tsunashima <ytsunashima@jp.adit-jv.com>
Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
[ported from 4.9]
Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 12dd9b318db18..703857aab00fc 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1873,6 +1873,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		if (!to_check)
 			break; /* all drained */
 		init_waitqueue_entry(&wait, current);
+		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&to_check->sleep, &wait);
 		snd_pcm_stream_unlock_irq(substream);
 		if (runtime->no_period_wakeup)
@@ -1885,7 +1886,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 			}
 			tout = msecs_to_jiffies(tout * 1000);
 		}
-		tout = schedule_timeout_interruptible(tout);
+		tout = schedule_timeout(tout);
 
 		snd_pcm_stream_lock_irq(substream);
 		group = snd_pcm_stream_group_ref(substream);
-- 
2.20.1

