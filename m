Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F3C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 16:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E620740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 16:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfLZQbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 11:31:14 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:43890 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfLZQbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 11:31:14 -0500
Received: from localhost.localdomain ([90.40.29.152])
        by mwinf5d81 with ME
        id igX92100B3Gv28S03gX9u9; Thu, 26 Dec 2019 17:31:12 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Dec 2019 17:31:12 +0100
X-ME-IP: 90.40.29.152
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     brian.austin@cirrus.com, Paul.Handrigan@cirrus.com,
        ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ASoC: cs47l92: Simplify error handling code in 'cs47l92_probe()'
Date:   Thu, 26 Dec 2019 17:29:07 +0100
Message-Id: <20191226162907.9490-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'madera_init_bus_error_irq()' fails,
'wm_adsp2_remove(&cs47l92->core.adsp[0])' will be called twice.
Once in the 'if' block, and once in the error handling path.
This is harmless, but one of this call can be axed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/codecs/cs47l92.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs47l92.c b/sound/soc/codecs/cs47l92.c
index d50f75f3b3e4..536b7d35d6b2 100644
--- a/sound/soc/codecs/cs47l92.c
+++ b/sound/soc/codecs/cs47l92.c
@@ -1959,10 +1959,8 @@ static int cs47l92_probe(struct platform_device *pdev)
 		goto error_dsp_irq;
 
 	ret = madera_init_bus_error_irq(&cs47l92->core, 0, wm_adsp2_bus_error);
-	if (ret != 0) {
-		wm_adsp2_remove(&cs47l92->core.adsp[0]);
+	if (ret != 0)
 		goto error_adsp;
-	}
 
 	madera_init_fll(madera, 1, MADERA_FLL1_CONTROL_1 - 1,
 			&cs47l92->fll[0]);
-- 
2.20.1

