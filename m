Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585A8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A04220652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556129487;
	bh=qdUeN1YLhpiBlZwvdf2IfQ0OpwD/83RG08fUEnWpIHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jpAtxjcj02ecTD3lYRX86QReGrF/e929fm9eGJ27wAIE63XLkbCT1MIhZpuIw6Xqs
	 FIYccio24F9uV8aK3ruAfH1n8x67JlJ1BzAN7Py/NWvMUV6PnOdP+2b0i/W2jEah9u
	 PbcAPQLt7vhj2oLseB/awlAoW9UgZ4hfpYuvFhsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389062AbfDXSLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387940AbfDXRNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:49 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05D5E21903;
        Wed, 24 Apr 2019 17:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126028;
        bh=qdUeN1YLhpiBlZwvdf2IfQ0OpwD/83RG08fUEnWpIHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cpv6wuf4FY/sKb9w8o+vmUGlRyyEBj/7tHWaOFmO+iveIYrAz2C54JV8+4lO3bA+y
         seanRY/gskV/6luQFKOP0PK2d9zxejc+7vgYleW4gQzbfO9nu34FYs4RLVAx0ncIia
         tbA7xm7SCRdRA7qSgN17/9JJXxVjoFVtJ3U95+BU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 067/104] ALSA: opl3: fix mismatch between snd_opl3_drum_switch definition and declaration
Date:   Wed, 24 Apr 2019 19:09:24 +0200
Message-Id: <20190424170905.079402862@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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



