Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B428AC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 804E820B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561520772;
	bh=d33sPLEdkeaam/ARepclApgTATRf3TlQ/h3eEIpPpNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TIcCFexlPBPq6WCV0YYihy5MU/lXi1mhT/waMb3qo1gLRTw3HQX+teiKsqREI5mOH
	 2yTSbwVz6RKkZg+8L1nGQ10lQZUzVFk/g5oFyHaMTu0WLdTNVH9FEciEdDJvGDcZZp
	 4YesyWbTH4Z3bjzHClJkOBsalOmSdCV1EDPjIUHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfFZDqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbfFZDqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:46:07 -0400
Received: from sasha-vm.mshome.net (mobile-107-77-172-82.mobile.att.net [107.77.172.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98B9F216F4;
        Wed, 26 Jun 2019 03:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561520766;
        bh=d33sPLEdkeaam/ARepclApgTATRf3TlQ/h3eEIpPpNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gs6uH5hX+GonwB3ncbvp9kNRgZyxrI/Cq2UDBWgt/g5rNfL93lKCIf2w4sLgSe3GE
         02ICrbsCBHrgEvZphdN8MhYuKUwQnCI31wx4Zc0o/eENQOclAQjJXlpYGbs7cLrFw7
         MHxtThMlZUjOdX2A2sDE10avynfJP2mnl+BaaD5A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Libin Yang <libin.yang@intel.com>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 02/11] ASoC: soc-pcm: BE dai needs prepare when pause release after resume
Date:   Tue, 25 Jun 2019 23:45:52 -0400
Message-Id: <20190626034602.24367-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626034602.24367-1-sashal@kernel.org>
References: <20190626034602.24367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Libin Yang <libin.yang@intel.com>

[ Upstream commit 5087a8f17df868601cd7568299e91c28086d2b45 ]

If playback/capture is paused and system enters S3, after system returns
from suspend, BE dai needs to call prepare() callback when playback/capture
is released from pause if RESUME_INFO flag is not set.

Currently, the dpcm_be_dai_prepare() function will block calling prepare()
if the pcm is in SND_SOC_DPCM_STATE_PAUSED state. This will cause the
following test case fail if the pcm uses BE:

playback -> pause -> S3 suspend -> S3 resume -> pause release

The playback may exit abnormally when pause is released because the BE dai
prepare() is not called.

This patch allows dpcm_be_dai_prepare() to call dai prepare() callback in
SND_SOC_DPCM_STATE_PAUSED state.

Signed-off-by: Libin Yang <libin.yang@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1dbcdc99dbe3..1d00f6e894ef 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2247,7 +2247,8 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
-		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 			continue;
 
 		dev_dbg(be->dev, "ASoC: prepare BE %s\n",
-- 
2.20.1

