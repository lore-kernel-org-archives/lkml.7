Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02694C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59E620721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420408;
	bh=rmpRqWBuUsMLm26OG9t+wtXYQizGsK/WZIguKaUORQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C3mQarUitnSlc4jVJtkjo+/pni5TSwKg5qfD9TbR4iEPgm414nmjU7AK6uDk9fPGA
	 u3yPPR+ypObBEIC/KTMl3aWtjdGbtE14WcF4vDqdfL27Xs2+452p7E618YK/vwD6bG
	 ehRa8L95lKDNJNCDfhzeJjCYbmcRT+JppAMqeStY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbfKVLAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbfKVLAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:00:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F9D220679;
        Fri, 22 Nov 2019 11:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420403;
        bh=rmpRqWBuUsMLm26OG9t+wtXYQizGsK/WZIguKaUORQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nk/3eLiWkP5oOhTGaYvonPH1HNFfqfIzgBvOGNS//h6abUHcn4Qc/sxkMEEgqYpRr
         QVrmB1f3+0vbPTVBt9n5bha9YoMLTIXRS4+OShrpl1mu8ziuoxvcO/wOryTDGl7Cw4
         omXemC/Je5vNjXM2BsmbbmPzyMAAJGTU2ivsS/IU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 095/220] ASoC: qdsp6: q6asm-dai: checking NULL vs IS_ERR()
Date:   Fri, 22 Nov 2019 11:27:40 +0100
Message-Id: <20191122100919.549015965@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 8e9f7265eda9f3a662ca1ca47a69042a7840735b ]

The q6asm_audio_client_alloc() doesn't return NULL, it returns error
pointers.

Fixes: 2a9e92d371db ("ASoC: qdsp6: q6asm: Add q6asm dai driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9db9a2944ef26..c1a7d376a3fea 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -319,10 +319,11 @@ static int q6asm_dai_open(struct snd_pcm_substream *substream)
 	prtd->audio_client = q6asm_audio_client_alloc(dev,
 				(q6asm_cb)event_handler, prtd, stream_id,
 				LEGACY_PCM_MODE);
-	if (!prtd->audio_client) {
+	if (IS_ERR(prtd->audio_client)) {
 		pr_info("%s: Could not allocate memory\n", __func__);
+		ret = PTR_ERR(prtd->audio_client);
 		kfree(prtd);
-		return -ENOMEM;
+		return ret;
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-- 
2.20.1



