Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2C5C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5677206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330125;
	bh=iRT0EXeDDp7bhj0MVCQPaCk6xPOrdZh6SP6c0lFoT/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1BFwoYBXIq2bDaXSyIxgFOnJafcz99+JwxuNXpnulkPv6zo8wNZuKYytk5pCq8rAj
	 +5F3CkrywmzsTmwq+Dc3ONTqf3Al160BpBqtfL79eWAVZVwk7aNWt5z45l5gNLCqjT
	 bF2eH+VH1EgAj7CM1uykR3Eudk8kzakrKbflbKWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfD0BzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727573AbfD0BjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA8820B7C;
        Sat, 27 Apr 2019 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329159;
        bh=iRT0EXeDDp7bhj0MVCQPaCk6xPOrdZh6SP6c0lFoT/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7/tx4zuWbzw7AO/DB3yLeMnBPFTh/ISqou+P8BaH3CsfcAdelPWU9Xfh19+naomC
         UYVMwl7a81RSp/zPtfehNYsbmP9pSCvMhquTyyfPG58z3vg7pBJHfG4YS3dO7UgOyh
         YePXSbuybUwGdqM9dPG5lH7kxssvqblcn5xfrjZk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 30/79] ASoC: dpcm: skip missing substream while applying symmetry
Date:   Fri, 26 Apr 2019 21:37:49 -0400
Message-Id: <20190427013838.6596-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 6246f283d5e02ac757bd8d9bacde8fdc54c4582d ]

If for any reason, the backend does not have the requested substream
(like capture on a playback only backend), the BE will be skipped in
dpcm_be_dai_startup().

However, dpcm_apply_symmetry() does not skip those BE and will
dereference the be_substream (NULL) pointer anyway.

Like in dpcm_be_dai_startup(), just skip those BE.

Fixes: 906c7d690c3b ("ASoC: dpcm: Apply symmetry for DPCM")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 4c24b13c1016..22946493a11f 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1907,10 +1907,15 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 		struct snd_soc_pcm_runtime *be = dpcm->be;
 		struct snd_pcm_substream *be_substream =
 			snd_soc_dpcm_get_substream(be, stream);
-		struct snd_soc_pcm_runtime *rtd = be_substream->private_data;
+		struct snd_soc_pcm_runtime *rtd;
 		struct snd_soc_dai *codec_dai;
 		int i;
 
+		/* A backend may not have the requested substream */
+		if (!be_substream)
+			continue;
+
+		rtd = be_substream->private_data;
 		if (rtd->dai_link->be_hw_params_fixup)
 			continue;
 
-- 
2.19.1

