Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA918C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742612067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330239;
	bh=ciHZmotvTXGQHVIJZM6vL4RLCth1X/pD7RjawRYgCv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCmOKKANKtIdfSHok4rF0/QLFNJ3d9voyd7Q/V9h1F4FmQXNLu6qKgv3oMkPE2OiV
	 1tXzd50ta/igUIMohscEb/SkSWztsHkJ+8vLX/scZQDfbl69uK6HXoIHhpDyk9IrO3
	 2yqq7RP3VlHYgLLal1zaOXIuRBAI8Kigi/v/GOBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfD0B5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:57:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727317AbfD0Bip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0396A212F5;
        Sat, 27 Apr 2019 01:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329124;
        bh=ciHZmotvTXGQHVIJZM6vL4RLCth1X/pD7RjawRYgCv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D52V1LNNZkZLZYYXHQR2ioov07vSfTeZ3m1Ter/AAY4RyssQ4DjvJ/ZCUpT9e4hx7
         8mnXZOSdSKVjDI2Q1J98DNoFJsHHnS3CXa+Ebs9PEVg+oDp9jJJxdpmQ/GxRMGQ51M
         sPnryRrbgpACpzpUAYDwitR/M73U1ZJSVp2krpeI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 05/79] ASoC: stm32: sai: fix exposed capabilities in spdif mode
Date:   Fri, 26 Apr 2019 21:37:24 -0400
Message-Id: <20190427013838.6596-5-sashal@kernel.org>
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
index 8746a22841f0..de4855b30e36 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -682,6 +682,14 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 
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

