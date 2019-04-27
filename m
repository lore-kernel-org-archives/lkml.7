Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D95EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DBD206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329893;
	bh=AQnlk+JqI7LX7oZX37ZlocPj5l2nMBvuzLIaZcb7rF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DQLqJhaFDXan+VqEVN2WE0labcaGGNn087OUtsFANViYUQ8h0OUL4ljPdJA/Upuu7
	 hQwauPLfJFhUVGm1Mi5cBIP5LiOPzWSDdvLnUBHCgHH8akk/IuH8b0mSxfuSTVwKr8
	 16iijs3lc+AQwRa8fjHhDH6WPOJlloWQBz59cdl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfD0BlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbfD0Bk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:40:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6E820C01;
        Sat, 27 Apr 2019 01:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329259;
        bh=AQnlk+JqI7LX7oZX37ZlocPj5l2nMBvuzLIaZcb7rF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2ngAUz9egfRx3BDJyc/+5WWIUrG2ZnPtFUGO2/SDWxAYOBuayZ9gVplrU21rhg6y
         codZUe2BiNNivEYvzNwHoXSP70Tadw0kHdyhtJOkmbLNe+QLDDmDDcvvaVd3ELtPj7
         EDn9n1ghBl/X9nLf68wjH7gzJj10tv3aoRLFRPPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 05/53] ASoC: stm32: sai: fix exposed capabilities in spdif mode
Date:   Fri, 26 Apr 2019 21:40:02 -0400
Message-Id: <20190427014051.7522-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olivier Moysan <olivier.moysan@st.com>

[ Upstream commit b8468192971807c43a80d6e2c41f83141cb7b211 ]

Change capabilities exposed in SAI S/PDIF mode, to match
actually supported formats.
In S/PDIF mode only 32 bits stereo is supported.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 606614649c04..1a8939f06ff8 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -498,6 +498,14 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 
 	sai->substream = substream;
 
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		snd_pcm_hw_constraint_mask64(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_FORMAT,
+					     SNDRV_PCM_FMTBIT_S32_LE);
+		snd_pcm_hw_constraint_single(substream->runtime,
+					     SNDRV_PCM_HW_PARAM_CHANNELS, 2);
+	}
+
 	ret = clk_prepare_enable(sai->sai_ck);
 	if (ret < 0) {
 		dev_err(cpu_dai->dev, "Failed to enable clock: %d\n", ret);
-- 
2.19.1

