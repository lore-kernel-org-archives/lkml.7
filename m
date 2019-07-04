Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DF1C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0C52189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGDIlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:41:45 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38346 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfGDIlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:41:45 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 61BF4188D688A99E751A;
        Thu,  4 Jul 2019 16:41:41 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x648eZ70068213;
        Thu, 4 Jul 2019 16:40:35 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070416410469-2082440 ;
          Thu, 4 Jul 2019 16:41:04 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: audio-graph-card: fix use-after-free in graph_for_each_link
Date:   Thu, 4 Jul 2019 16:38:50 +0800
Message-Id: <1562229530-8121-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-04 16:41:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-04 16:40:40,
        Serialize complete at 2019-07-04 16:40:40
X-MAIL: mse-fl1.zte.com.cn x648eZ70068213
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After calling of_node_put() on the codec_ep and codec_port variables,
they are still being used, which may result in use-after-free.
We fix this issue by calling of_node_put() after the last usage.

Fixes: fce9b90c1ab7 ("ASoC: audio-graph-card: cleanup DAI link loop method - step2")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/generic/audio-graph-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index e438011..30a4e83 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -421,9 +421,6 @@ static int graph_for_each_link(struct asoc_simple_priv *priv,
 			codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 			codec_port = of_get_parent(codec_ep);
 
-			of_node_put(codec_ep);
-			of_node_put(codec_port);
-
 			/* get convert-xxx property */
 			memset(&adata, 0, sizeof(adata));
 			graph_parse_convert(dev, codec_ep, &adata);
@@ -443,6 +440,9 @@ static int graph_for_each_link(struct asoc_simple_priv *priv,
 			else
 				ret = func_noml(priv, cpu_ep, codec_ep, li);
 
+			of_node_put(codec_ep);
+			of_node_put(codec_port);
+
 			if (ret < 0)
 				return ret;
 
-- 
2.9.5

