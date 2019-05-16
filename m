Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC55C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D3A20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PuCiB1me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfEPRvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:51:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2856 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEPRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:51:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdda32c0000>; Thu, 16 May 2019 10:51:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 May 2019 10:51:34 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 May 2019 10:51:34 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 17:51:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 17:51:33 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.148]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdda3240001>; Thu, 16 May 2019 10:51:33 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [RFC PATCH] ASoC: simple-card: Fix configuration of DAI format
Date:   Thu, 16 May 2019 18:51:26 +0100
Message-ID: <1558029086-18024-1-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558029100; bh=yB3KkuZkbrO3YjQsTuD3PSDyuis5tu4UMkVyz1IzSIs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=PuCiB1me1b0alm/045Qy0kui84kFwIbn4YYbcyMVGdaWVS4UvqNsTVj/5zCl2QlUC
         uhFLGj0c3fS47hdG2uq5fj9107eXUpsqxRYNkiVcZdP2h+uuJ5wDwiTWhaXGAlRzaI
         L4krH4K3JO+tr9iFmwLlnf/OeQTtiWHhbJAGuKsq8vCrN5pAwToUqXwbYY5uZBJGre
         rgJvk2hiC7qU+9fHZPsaOwoyopOlX2OAFq1G5fmUroZMJ3eB9eQFSIxMcO4uYC9KRN
         Z0ajrFMPg7PXcmyO1MV7BU5rHBirhfHlJFEnhrLMoJfXVIJNY+4GYBMaK71HP3A0pt
         fZs3o1pFVdVxQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When configuring a codec to be both bit-clock and frame-master, it was
found that the codec was always configured as bit-clock and frame-slave.
Looking at the simple_dai_link_of() function there appears to be two
problems with the configuration of the DAI format, which are ...

1. The function asoc_simple_parse_daifmt() is called before the function
   asoc_simple_parse_codec() and this means that the device-tree node
   for the codec has not been parsed yet, which is needed by the
   function asoc_simple_parse_daifmt() to determine who is the codec.
2. The phandle passed to asoc_simple_parse_daifmt() is the phandle to
   the 'codec' node and not the phandle of the actual codec defined by
   the 'sound-dai' property under the 'codec' node.

Fix the above by moving the call to asoc_simple_parse_daifmt() after the
the call to asoc_simple_parse_codec() and pass the phandle for the codec
to asoc_simple_parse_daifmt().

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/generic/simple-card.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 9b568f578bcd..c2c8dcbcf795 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -283,11 +283,6 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	codec_dai		=
 	dai_props->codec_dai	= &priv->dais[li->dais++];
 
-	ret = asoc_simple_parse_daifmt(dev, node, codec,
-				       prefix, &dai_link->dai_fmt);
-	if (ret < 0)
-		goto dai_link_of_err;
-
 	simple_parse_mclk_fs(top, cpu, codec, dai_props, prefix);
 
 	ret = asoc_simple_parse_cpu(cpu, dai_link, &single_cpu);
@@ -298,6 +293,11 @@ static int simple_dai_link_of(struct asoc_simple_priv *priv,
 	if (ret < 0)
 		goto dai_link_of_err;
 
+	ret = asoc_simple_parse_daifmt(dev, node, dai_link->codecs->of_node,
+				       prefix, &dai_link->dai_fmt);
+	if (ret < 0)
+		goto dai_link_of_err;
+
 	ret = asoc_simple_parse_platform(plat, dai_link);
 	if (ret < 0)
 		goto dai_link_of_err;
-- 
2.7.4

