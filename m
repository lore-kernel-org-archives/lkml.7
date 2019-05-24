Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D91C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BECC217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 08:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U7qLd1q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390039AbfEXIyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 04:54:24 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2118 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389964AbfEXIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 04:54:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ce7b1350000>; Fri, 24 May 2019 01:54:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 24 May 2019 01:54:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 24 May 2019 01:54:18 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 May
 2019 08:54:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 24 May 2019 08:54:18 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ce7b1380001>; Fri, 24 May 2019 01:54:17 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] Revert "ASoC: simple-card: Fix configuration of DAI format"
Date:   Fri, 24 May 2019 09:54:04 +0100
Message-ID: <1558688044-22025-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558688053; bh=nLIuj+dWoHUdiLPx4+WIEBrzL5eS8acbrvzehEuKewA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=U7qLd1q8OQQZhGp7qzKaeHeA6i3Xdhy1PU+tomyMsdXeT4AGyOeWMWaCXa08lSbM6
         Ph7h2yRh/+ZedkiWZQnPeGmW0K5ElEw0egotjTyGYhWPBzT205VlCYFU2ppM+kiBFz
         m6eeyCwAzBO5/yYdYJBIWWnlr27Xx09z0RcImMFsqbe39IRJV06XrGA44rpdD6hpqQ
         h/N7mlX7YjWvHukBqJEUgsWu1oC14osKxZbMIztu1lG9IE63xMMpwIwDJLsr79cVTg
         wkmj8u9jXSR5Ma0APD7hh6Y3raoh7J6UeY9SXog8GRaf8PvgiOEWs4vL0SQsWm8P2N
         wpIIL0Of/k6UA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert commit 069d037aea98 ("ASoC: simple-card: Fix configuration of
DAI format"). During further review, it turns out that the actual issue
was caused by an incorrectly formatted device-tree node describing the
soundcard.

The following is incorrect because the simple-audio-card
'bitclock-master' and 'frame-master' properties should not reference the
actual codec phandle ...

	sound {
		compatible = "simple-audio-card";
		...
	=>	simple-audio-card,bitclock-master = <&codec>;
	=>	simple-audio-card,frame-master = <&codec>;
		...

		simple-audio-card,cpu {
			sound-dai = <&xxx>;
		};

		simple-audio-card,codec {
	=>		sound-dai = <&codec>;
		};
	};

Rather, these properties should reference the phandle to the
'simple-audio-card,codec' property as shown below ...

	sound {
		compatible = "simple-audio-card";
		...
	=>	simple-audio-card,bitclock-master = <&codec>;
	=>	simple-audio-card,frame-master = <&codec>;
		...

		simple-audio-card,cpu {
			sound-dai = <&xxx>;
		};

	=>	codec: simple-audio-card,codec { /* simple-card wants here */
			sound-dai = <&xxx>;	 /* not here */
		};
	};

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/generic/simple-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index c2a2c5fd0801..d16e894fce2b 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -283,6 +283,11 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	codec_dai		=
 	dai_props->codec_dai	= &priv->dais[li->dais++];
 
+	ret = asoc_simple_parse_daifmt(dev, node, codec,
+				       prefix, &dai_link->dai_fmt);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
 
 	ret = asoc_simple_parse_cpu(cpu, dai_link, &single_cpu);
@@ -293,11 +298,6 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		goto dai_link_of_err;
 
-	ret = asoc_simple_parse_daifmt(dev, node, dai_link->codecs->of_node,
-				       prefix, &dai_link->dai_fmt);
-	if (ret < 0)
-		goto dai_link_of_err;
-
 	ret = asoc_simple_parse_platform(plat, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
-- 
2.7.4

