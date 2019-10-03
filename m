Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678BCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AB92086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570124213;
	bh=yboTTV9U5Hi5WqFc52skmFm/H4w+dx7z0bgyguhUBWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r+raS9z5/HUlyRyY4Ps/jFtZTtkC5V94B3D/Z4Uj1Ac7hrvBf7S7cWnL5bMOOZGrf
	 UaEqnrhlJ7JuwLmu3BCwyIGRx5f+XET3zK8yQYwlEDfxZZNCYIP96xmrIwKrphgI4m
	 pO8+PnHAe34NuGfsKfjdkoEuAg6QwJ7HoywY6QvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388773AbfJCRgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732345AbfJCQEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:04:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1C421A4C;
        Thu,  3 Oct 2019 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570118647;
        bh=yboTTV9U5Hi5WqFc52skmFm/H4w+dx7z0bgyguhUBWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bAE5haD1mVVI02dqS7srlHuiJcOGNx3SCA+X1dLQcI9oftP1NzNPtLqOUKvlIxRuQ
         eZHCMxtpgFXmExvxC1W3iINcqxIUtBEQ2mTH4Yb9EKerFnppbW7uAaWlCQhWpwM7Yb
         opPlaEWCCawTW8Hih9fzowscdAP6dwaVZzFQRduk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Arthur She <arthur.she@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 088/129] ASoC: dmaengine: Make the pcm->name equal to pcm->id if the name is not set
Date:   Thu,  3 Oct 2019 17:53:31 +0200
Message-Id: <20191003154359.394134963@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154318.081116689@linuxfoundation.org>
References: <20191003154318.081116689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 2ec42f3147e1610716f184b02e65d7f493eed925 ]

Some tools use the snd_pcm_info_get_name() to try to identify PCMs or for
other purposes.

Currently it is left empty with the dmaengine-pcm, in this case copy the
pcm->id string as pcm->name.

For example IGT is using this to find the HDMI PCM for testing audio on it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Arthur She <arthur.she@linaro.org>
Link: https://lore.kernel.org/r/20190906055524.7393-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6cef3977507ae..67d22b4baeb05 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -312,6 +312,12 @@ static int dmaengine_pcm_new(struct snd_soc_pcm_runtime *rtd)
 
 		if (!dmaengine_pcm_can_report_residue(dev, pcm->chan[i]))
 			pcm->flags |= SND_DMAENGINE_PCM_FLAG_NO_RESIDUE;
+
+		if (rtd->pcm->streams[i].pcm->name[0] == '\0') {
+			strncpy(rtd->pcm->streams[i].pcm->name,
+				rtd->pcm->streams[i].pcm->id,
+				sizeof(rtd->pcm->streams[i].pcm->name));
+		}
 	}
 
 	return 0;
-- 
2.20.1



