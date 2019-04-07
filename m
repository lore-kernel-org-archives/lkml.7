Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB303C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9558E213A2
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 03:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfDGDAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 23:00:53 -0400
Received: from www.osadl.org ([62.245.132.105]:39219 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfDGDAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 23:00:52 -0400
X-Greylist: delayed 2660 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Apr 2019 23:00:52 EDT
Received: from localhost.localdomain (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x372xh80025162;
        Sun, 7 Apr 2019 04:59:43 +0200
From:   Nicholas Mc Guire <hofrat@opentech.at>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@opentech.at>
Subject: [PATCH] ASoC: ab8500: add range to usleep_range
Date:   Sun,  7 Apr 2019 04:59:34 +0200
Message-Id: <1554605974-25481-1-git-send-email-hofrat@opentech.at>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Providing a range for usleep_range() allows the hrtimer subsystem to 
coalesce timers - as this delay has no upper limit anyway (interrupts
or context switch is possible) it should not hurt to extend this
from 2 to 2-4 milliseconds.

Signed-off-by: Nicholas Mc Guire <hofrat@opentech.at>
---

Problem located with an experimental coccinelle script

Basically usleep_range() with min == max never makes much sense notably
in non-atomic context.

Patch was compile tested with: u8500_defconfig (implies CONFIG_SND_SOC_AB8500_CODEC=y)
(with some sparse warnings about not implemented system calls)

Patch is against 5.1-rc3 (localversion-next is next=20190405)

 sound/soc/codecs/ab8500-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 87616b1..19e7f03 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1062,10 +1062,10 @@ static void anc_iir(struct snd_soc_component *component, unsigned int bnk,
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRINIT),
 					BIT(AB8500_ANCCONF1_ANCIIRINIT));
-			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY*2);
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRINIT), 0);
-			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY);
+			usleep_range(AB8500_ANC_SM_DELAY, AB8500_ANC_SM_DELAY*2);
 		} else {
 			snd_soc_component_update_bits(component, AB8500_ANCCONF1,
 					BIT(AB8500_ANCCONF1_ANCIIRUPDATE),
-- 
2.1.4

