Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3567C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9FB2067D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556330246;
	bh=7F+q+eSEPcfodE25SQjyMkl5PNsmuS5dCgeo6QePAe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f7kqEqlBxjNnzb7VLhQ03rf1pE9g/fL3xbsxbsKCBxnwCtL0u/dtQzd3UAaR/1lN7
	 /OoJHc6FWf0NnxxaRnjm2hrmRKRgRMFdex6uetrVGm2rMO3qMc7reYEt0PbHoOPBs4
	 D+qsKMNIdX70m6JWBs+jux5hsN/aatZviOUQECoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfD0B5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbfD0Bio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:38:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A732084F;
        Sat, 27 Apr 2019 01:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329123;
        bh=7F+q+eSEPcfodE25SQjyMkl5PNsmuS5dCgeo6QePAe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJoUEZd6N0m+fl/yq1QaJQsgnJL5cLulaO+A3h7vwmpKSCEhHvaYKOfa4Ln9Go44u
         Txa6yX9a1QIO7Lp1s9sgyEItpDPKhTgaQmIv/7IqP8AMdQXQsHbJyrMc6FSuAVvWX9
         vnfplVnzOeeQp6F48LsaXosZ08GplTlNbVLQITlI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 04/79] ASoC: stm32: sai: fix iec958 controls indexation
Date:   Fri, 26 Apr 2019 21:37:23 -0400
Message-Id: <20190427013838.6596-4-sashal@kernel.org>
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

[ Upstream commit 5f8a1000c3e630c3ac06f1d664eeaa755bce8823 ]

Allow indexation of sai iec958 controls according
to device id.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index d4825700b63f..8746a22841f0 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -100,7 +100,7 @@
  * @slot_mask: rx or tx active slots mask. set at init or at runtime
  * @data_size: PCM data width. corresponds to PCM substream width.
  * @spdif_frm_cnt: S/PDIF playback frame counter
- * @snd_aes_iec958: iec958 data
+ * @iec958: iec958 data
  * @ctrl_lock: control lock
  */
 struct stm32_sai_sub_data {
@@ -1070,11 +1070,12 @@ static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
 			     struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+	struct snd_kcontrol_new knew = iec958_ctls;
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
 		dev_dbg(&sai->pdev->dev, "%s: register iec controls", __func__);
-		return snd_ctl_add(rtd->pcm->card,
-				   snd_ctl_new1(&iec958_ctls, sai));
+		knew.device = rtd->pcm->device;
+		return snd_ctl_add(rtd->pcm->card, snd_ctl_new1(&knew, sai));
 	}
 
 	return 0;
-- 
2.19.1

