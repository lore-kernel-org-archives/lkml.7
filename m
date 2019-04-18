Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D30D20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611558;
	bh=gt3BloQFJzLlyAUC1GyOGGq9HIpGz+T3aP1dH+xtdQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C/l2Ktd48lr43Vhq+QQDm/kaP6Ub0BQjaXZKvgmdfIQkoOLM8Bogdrnu1eJsDqpBP
	 YE3ytlYvsvBZHb99+/bmzIEB4c6A70t1II9G/ilkMH7nPYm0rjzCSvWd14pcPi1nr1
	 kVLnRi547YLF6VkviZucZDrRfkt/lqvMkd85nGMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbfDRSJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403796AbfDRSJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:09:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAEB820675;
        Thu, 18 Apr 2019 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610990;
        bh=gt3BloQFJzLlyAUC1GyOGGq9HIpGz+T3aP1dH+xtdQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2+naC0oMK+6FBPuO+8EydgMrR6zbdbu25C9YMqtIpp4I0fmWSrVRpLmJOb+oUwbD
         TB3arsLSz2s7alMpsLARPtsy0zl8+DE8V4Tw2a2gVW6zJAybNlsNoqv5p0c+PXAu5a
         EqA7hs+xuTvbOF3fGmEaL15RSfCaOZbbR2MG85ds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 17/93] ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration
Date:   Thu, 18 Apr 2019 19:56:55 +0200
Message-Id: <20190418160438.588122787@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



