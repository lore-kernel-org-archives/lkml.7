Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92182177E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709917;
	bh=eO+FsWqCgcDGLQwkANGQvPR+AWgXIpvlND091seKMpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gu4hguoA/xQRJAZIr2ehV3mJfjNMLxKz/hkpSCGyzrlxAWTYG3Hrka7j2oxeoMAOS
	 iKHUl8v4s3xOg+yTSdEXyKYuYbOtQKU2M4YcUHtRX9tZyVoUoDbdKUVM9FMkLUAtbI
	 gPYPnVlUzae42FSYWXenUm34lvPnITy3pxrZ08gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387649AbfC0SFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387608AbfC0SFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F2D32075C;
        Wed, 27 Mar 2019 18:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709911;
        bh=eO+FsWqCgcDGLQwkANGQvPR+AWgXIpvlND091seKMpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DgMeaQoI0zIrI1UE5rlEqCmixDHztqnMS07/g9NU7B1TIa69CN6/W/4ARI0F8d5mX
         PvD0PlrmAknHfOP4BGPaAFY1C1DZ/aT+vhKSa95EXS9zWy2uDSc8FqW1PpbE3+pk2i
         n7OHl15Xfh9y3HBzBFZ1mXMPqJMm0NT54twqksfQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 107/262] ASoC: qcom: Fix of-node refcount unbalance in apq8016_sbc_parse_of()
Date:   Wed, 27 Mar 2019 13:59:22 -0400
Message-Id: <20190327180158.10245-107-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 8d1667200850f8753c0265fa4bd25c9a6e5f94ce ]

The apq8016 driver leaves the of-node refcount at aborting from the
loop of for_each_child_of_node() in the error path.  Not only the
iterator node of for_each_child_of_node(), the children nodes referred
from it for codec and cpu have to be properly unreferenced.

Fixes: bdb052e81f62 ("ASoC: qcom: add apq8016 sound card support")
Cc: Patrick Lai <plai@codeaurora.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 1dd23bba1bed..4b559932adc3 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -164,41 +164,52 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 
 		if (!cpu || !codec) {
 			dev_err(dev, "Can't find cpu/codec DT node\n");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto error;
 		}
 
 		link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
 		if (!link->cpu_of_node) {
 			dev_err(card->dev, "error getting cpu phandle\n");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto error;
 		}
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpu_dai_name);
 		if (ret) {
 			dev_err(card->dev, "error getting cpu dai name\n");
-			return ERR_PTR(ret);
+			goto error;
 		}
 
 		ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 
 		if (ret < 0) {
 			dev_err(card->dev, "error getting codec dai name\n");
-			return ERR_PTR(ret);
+			goto error;
 		}
 
 		link->platform_of_node = link->cpu_of_node;
 		ret = of_property_read_string(np, "link-name", &link->name);
 		if (ret) {
 			dev_err(card->dev, "error getting codec dai_link name\n");
-			return ERR_PTR(ret);
+			goto error;
 		}
 
 		link->stream_name = link->name;
 		link->init = apq8016_sbc_dai_init;
 		link++;
+
+		of_node_put(cpu);
+		of_node_put(codec);
 	}
 
 	return data;
+
+ error:
+	of_node_put(np);
+	of_node_put(cpu);
+	of_node_put(codec);
+	return ERR_PTR(ret);
 }
 
 static const struct snd_soc_dapm_widget apq8016_sbc_dapm_widgets[] = {
-- 
2.19.1

