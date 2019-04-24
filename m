Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBCDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917A320835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126427;
	bh=qdUeN1YLhpiBlZwvdf2IfQ0OpwD/83RG08fUEnWpIHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Opwu+jFZVCDc9SO6uv3vz3TrKNpG30JiLEljmcHnBO5OE9oBasTsMX9G0oBDaS3sd
	 zQbctGowGkCTc5CilE8MNKgTl3s8fmoocpFLmb6bAbFNzd+/D5qoSqqxOIoSp9mDsJ
	 N6ghcFRaL0pY/v13vLc2QJjZqHNPya31SupvZm/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389167AbfDXRU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:20:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389154AbfDXRUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:22 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6382205ED;
        Wed, 24 Apr 2019 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126421;
        bh=qdUeN1YLhpiBlZwvdf2IfQ0OpwD/83RG08fUEnWpIHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsSMVYUy9O0y8cAkPznt5eKLzL+anp1TIDGEV/V6eKf4Iw82TZkbG9ZFHkqtfKsnN
         8kLhBYig5JQN+SPjEZWT5+LauVHLeQ8esy2Ap8T7GHPScuW+sARYRSgckW3e/86mCn
         V5L+ZZJPwnoX1PTb4AwVz7+q4XvYEa5K6y+8t6Q8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 105/168] ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration
Date:   Wed, 24 Apr 2019 19:09:09 +0200
Message-Id: <20190424170929.807101451@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
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
index a371c075ac87..e26702559f61 100644
--- a/sound/drivers/opl3/opl3_voice.h
+++ b/sound/drivers/opl3/opl3_voice.h
@@ -41,7 +41,7 @@ void snd_opl3_timer_func(unsigned long data);
 
 /* Prototypes for opl3_drums.c */
 void snd_opl3_load_drums(struct snd_opl3 *opl3);
-void snd_opl3_drum_switch(struct snd_opl3 *opl3, int note, int on_off, int vel, struct snd_midi_channel *chan);
+void snd_opl3_drum_switch(struct snd_opl3 *opl3, int note, int vel, int on_off, struct snd_midi_channel *chan);
 
 /* Prototypes for opl3_oss.c */
 #ifdef CONFIG_SND_SEQUENCER_OSS
-- 
2.19.1



