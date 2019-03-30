Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF71C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261E0218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907213;
	bh=LeYvrwRUDltMhwxcC2hToscHxsD8jdn6J1GyX0eLcQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqWMLaEVOQOjF6M6EoRFEEEawe5jkUEZIZsMRBWRu4xZ1EFwf26nnR0qtLD/DsHPx
	 ewQTbH7G5hMcEgol5u39a1qehMZeAnJSqmAyjv+tAmXBZAB7gtXpZwPMzV89zY8LII
	 TylWNrhpiD2fUa3VtD2+mrPW0clYkZDRti5y+uCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbfC3Axb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbfC3Ax2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6098218CD;
        Sat, 30 Mar 2019 00:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907207;
        bh=LeYvrwRUDltMhwxcC2hToscHxsD8jdn6J1GyX0eLcQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ilOZ7skmT3iSZzKaa1dMgCj8+z+0aJIH/SCb9lWdXNObrb42ezxcohMd/7ZgZB1by
         JRZ6BbKDSEbTeulknGsV86uIFwt+anbbZjtO+SqWFCl1k+7OQC6dKEkTM7Awi94fdj
         fczPfPndwbM2vLx450V29oog3V92Ant3ZEmuGNeE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 16/52] ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration
Date:   Fri, 29 Mar 2019 20:52:23 -0400
Message-Id: <20190330005301.26868-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b4748e7ab731e436cf5db4786358ada5dd2db6dd ]

The function snd_opl3_drum_switch declaration in the header file
has the order of the two arguments on_off and vel swapped when
compared to the definition arguments of vel and on_off.  Fix this
by swapping them around to match the definition.

This error predates the git history, so no idea when this error
was introduced.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/opl3/opl3_voice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/drivers/opl3/opl3_voice.h b/sound/drivers/opl3/opl3_voice.h
index 5b02bd49fde4..4e4ecc21760b 100644
--- a/sound/drivers/opl3/opl3_voice.h
+++ b/sound/drivers/opl3/opl3_voice.h
@@ -41,7 +41,7 @@ void snd_opl3_timer_func(struct timer_list *t);
 
 /* Prototypes for opl3_drums.c */
 void snd_opl3_load_drums(struct snd_opl3 *opl3);
-void snd_opl3_drum_switch(struct snd_opl3 *opl3, int note, int on_off, int vel, struct snd_midi_channel *chan);
+void snd_opl3_drum_switch(struct snd_opl3 *opl3, int note, int vel, int on_off, struct snd_midi_channel *chan);
 
 /* Prototypes for opl3_oss.c */
 #if IS_ENABLED(CONFIG_SND_SEQUENCER_OSS)
-- 
2.19.1

