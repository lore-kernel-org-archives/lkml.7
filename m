Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AC7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7906421871
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610891;
	bh=qdUeN1YLhpiBlZwvdf2IfQ0OpwD/83RG08fUEnWpIHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eDb1aCa8LtmVhzVS5KGAcAt0CgBr/LrSmoK3MRiQyR+xzif02aMuByGbr3HljrumL
	 4vJVVPWzLs9MX2OG9AUKKjDEm3a0KL+l8xJNMn3bbR6UsknxGCYs2YNvgqs0vpOeiI
	 gzXb6qGJMtx164qjqgg+vdvgeCS1JyHnDTBuCQh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfDRSIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391727AbfDRSIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:08:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099EE21872;
        Thu, 18 Apr 2019 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610886;
        bh=qdUeN1YLhpiBlZwvdf2IfQ0OpwD/83RG08fUEnWpIHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOIN1eg0GXNVrHvTMjiDOr/pO6E43/VlEqMWtcRJhaFDTCETzi4C6X+0u7VZ2IucD
         2liPwMmOh9HU319/XEJRyNQTPGD+l9hKJYox5QLcfGXq1BWM+puRm1bPYNrwAdi3Nt
         pXhXvo6YFDjH+eTwqgwHIa3hoLIQ7dajD0FTyjYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/50] ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration
Date:   Thu, 18 Apr 2019 19:57:20 +0200
Message-Id: <20190418160423.951395888@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
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



