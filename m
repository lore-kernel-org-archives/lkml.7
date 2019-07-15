Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B2C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4048C2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200176;
	bh=QdxkhPNgcZkx+wY+JoZuFgHJzgfudEMIkPwELkwc6D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W+H4a5OU3WH2LQ77tl3go3jJaZx+XRdyqDv14FJdo+8D4PA/kBantmleiOALd+1w3
	 wPQIo+yw2n4Qz0SYvj7e60si72s0FY9UWBKQUVxDgm8enIzJlukJ7lF+ks145UMt1l
	 yiumuRn4lZh1cNCS6EAdIvPvHwhZGFwvvjk8i2bs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389691AbfGOOQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:16:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388662AbfGOOQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:16:14 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C8D820868;
        Mon, 15 Jul 2019 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200173;
        bh=QdxkhPNgcZkx+wY+JoZuFgHJzgfudEMIkPwELkwc6D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKuMqlTruVNDKNNGZmMOkc8aqYTKwUifwqVpxostOpQPFzRWIO2GDI/shFEJVdYFV
         8DcVeS27FkpayOjZw0mlNguzZnzA6uk+KtU92LOOnxFaJQKANRjufHl3z70DxmW5AO
         6KX9YBTvobKRwXPxTW0mWSGsUaBFFFKxAPWiki4E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 201/219] ASoC: audio-graph-card: fix use-after-free in graph_for_each_link
Date:   Mon, 15 Jul 2019 10:03:22 -0400
Message-Id: <20190715140341.6443-201-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

[ Upstream commit 1bcc1fd64e4dd903f4d868a9e053986e3b102713 ]

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
Link: https://lore.kernel.org/r/1562229530-8121-1-git-send-email-wen.yang99@zte.com.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/audio-graph-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 69bc4848d787..f730830fb36c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -460,9 +460,6 @@ static int graph_for_each_link(struct graph_priv *priv,
 			codec_ep = of_graph_get_remote_endpoint(cpu_ep);
 			codec_port = of_get_parent(codec_ep);
 
-			of_node_put(codec_ep);
-			of_node_put(codec_port);
-
 			/* get convert-xxx property */
 			memset(&adata, 0, sizeof(adata));
 			graph_get_conversion(dev, codec_ep, &adata);
@@ -482,6 +479,9 @@ static int graph_for_each_link(struct graph_priv *priv,
 			else
 				ret = func_noml(priv, cpu_ep, codec_ep, li);
 
+			of_node_put(codec_ep);
+			of_node_put(codec_port);
+
 			if (ret < 0)
 				return ret;
 
-- 
2.20.1

