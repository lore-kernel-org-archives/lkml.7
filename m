Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B42C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C72C218D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907077;
	bh=LeYvrwRUDltMhwxcC2hToscHxsD8jdn6J1GyX0eLcQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=okuWVQMXCUQoAEQazsSSk8L8Y3wo5g4tSGHIS7U/tVW/MLiTJIXiNmk4YpYt8P8Zx
	 NACriw9u2lKBNn0cWUB5fx5ZqXpzRlxtSyBV7oHH30uq+YYLShFALgnn/lnuMrcdXe
	 3q5lsEJaqoAXm/XkjP3C5WKMpxJUfMheUvOnjxd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfC3AvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:51:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfC3AvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:51:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DDD2206DD;
        Sat, 30 Mar 2019 00:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907071;
        bh=LeYvrwRUDltMhwxcC2hToscHxsD8jdn6J1GyX0eLcQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJU8BtxUEE7oHTW/NpBH5rX/JQpNbvkNxxcIw4ya114zgIaBasByFmwVgfqWIiyVG
         gme5dKZDLADQzK9aoRHKwqDK3T3DStyf319NZYPudp7DPyG5aCJbDtPJrkDpCor98e
         7y8VM42b4M+0rTdi1b9tMzgbJ/hs5J0wbJN0/9K4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 17/67] ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration
Date:   Fri, 29 Mar 2019 20:49:57 -0400
Message-Id: <20190330005047.25998-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
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

