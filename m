Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8729C73C7E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870592087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 07:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGJH3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 03:29:14 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:8542 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfGJH3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 03:29:12 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id F053DEF3F5A4DE7C6AA6;
        Wed, 10 Jul 2019 15:29:10 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x6A7RXEx070833;
        Wed, 10 Jul 2019 15:27:33 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071015275167-2237132 ;
          Wed, 10 Jul 2019 15:27:51 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 2/4] ASoC: simple-card: fix an use-after-free in simple_for_each_link()
Date:   Wed, 10 Jul 2019 15:25:07 +0800
Message-Id: <1562743509-30496-3-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
References: <1562743509-30496-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-10 15:27:51,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-10 15:27:37,
        Serialize complete at 2019-07-10 15:27:37
X-MAIL: mse-fl2.zte.com.cn x6A7RXEx070833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec variable is still being used after the of_node_put() call,
which may result in use-after-free.

Fixes: d947cdfd4be2 ("ASoC: simple-card: cleanup DAI link loop method - step1")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Jon Hunter <jonathanh@nvidia.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/generic/simple-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 4117e54..ef84915 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -364,8 +364,6 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 			goto error;
 		}
 
-		of_node_put(codec);
-
 		/* get convert-xxx property */
 		memset(&adata, 0, sizeof(adata));
 		for_each_child_of_node(node, np)
@@ -387,11 +385,13 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 				ret = func_noml(priv, np, codec, li, is_top);
 
 			if (ret < 0) {
+				of_node_put(codec);
 				of_node_put(np);
 				goto error;
 			}
 		}
 
+		of_node_put(codec);
 		node = of_get_next_child(top, node);
 	} while (!is_top && node);
 
-- 
2.9.5

