Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B232AC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC0A2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565748659;
	bh=J3Lo1cxa88GvBiqLpqc29gB3HJIGD4djX+xbc7OyQIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SUrdFPw97MKPEmVb3d1MA3ahJCdfLSlX2lIaZsHuIgXIEgHhBd5QVidDjbulRyYTt
	 9GRdYvxHq5vq8FZqBarRffCHk5hhv2LrByvHKEubRI3FO+IFHwJ3z6tj9FiimBi4JZ
	 2LoY7ZWt8hyw8EKrrglLiK+yQEAktT1jOpy2TXdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfHNCK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfHNCK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:10:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5567F20844;
        Wed, 14 Aug 2019 02:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748656;
        bh=J3Lo1cxa88GvBiqLpqc29gB3HJIGD4djX+xbc7OyQIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d6njIlUCH3S0VVLQybtimpJsaP4k+m79g+m1oRt36bJ1B3lt7hiFRHeCuhvaWd3IZ
         7TYzYWqStHBCKBGzOTYfrgG+u3hWZDunvGCSYebhh8nRD85ALI4EmL22cO/4XIqmWF
         2RtJ+GS/oa6rm+aAdjCZ04wcZ4fOm9sJaqMvgoSs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 004/123] ASoC: audio-graph-card: fix use-after-free in graph_dai_link_of_dpcm()
Date:   Tue, 13 Aug 2019 22:08:48 -0400
Message-Id: <20190814021047.14828-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit aa2e362cb6b3f5ca88093ada01e1a0ace8a517b2 ]

After calling of_node_put() on the ports, port, and node variables,
they are still being used, which may result in use-after-free.
Fix this issue by calling of_node_put() after the last usage.

Fixes: dd98fbc558a0 ("ASoC: audio-graph-card: cleanup DAI link loop method - step1")
Link: https://lore.kernel.org/r/1562743509-30496-4-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 70ed28d97d497..d5188a179378f 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -222,10 +222,6 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	dev_dbg(dev, "link_of DPCM (%pOF)\n", ep);
 
-	of_node_put(ports);
-	of_node_put(port);
-	of_node_put(node);
-
 	if (li->cpu) {
 		int is_single_links = 0;
 
@@ -243,17 +239,17 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_cpu(ep, dai_link, &is_single_links);
 		if (ret)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_cpu(dev, ep, dai_link, dai);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "fe.%s",
 						   dai_link->cpu_dai_name);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		/* card->num_links includes Codec */
 		asoc_simple_canonicalize_cpu(dai_link, is_single_links);
@@ -277,17 +273,17 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 		ret = asoc_simple_parse_codec(ep, dai_link);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_parse_clk_codec(dev, ep, dai_link, dai);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		ret = asoc_simple_set_dailink_name(dev, dai_link,
 						   "be.%s",
 						   codecs->dai_name);
 		if (ret < 0)
-			return ret;
+			goto out_put_node;
 
 		/* check "prefix" from top node */
 		snd_soc_of_parse_node_prefix(top, cconf, codecs->of_node,
@@ -307,19 +303,23 @@ static int graph_dai_link_of_dpcm(struct asoc_simple_priv *priv,
 
 	ret = asoc_simple_parse_tdm(ep, dai);
 	if (ret)
-		return ret;
+		goto out_put_node;
 
 	ret = asoc_simple_parse_daifmt(dev, cpu_ep, codec_ep,
 				       NULL, &dai_link->dai_fmt);
 	if (ret < 0)
-		return ret;
+		goto out_put_node;
 
 	dai_link->dpcm_playback		= 1;
 	dai_link->dpcm_capture		= 1;
 	dai_link->ops			= &graph_ops;
 	dai_link->init			= asoc_simple_dai_init;
 
-	return 0;
+out_put_node:
+	of_node_put(ports);
+	of_node_put(port);
+	of_node_put(node);
+	return ret;
 }
 
 static int graph_dai_link_of(struct asoc_simple_priv *priv,
-- 
2.20.1

