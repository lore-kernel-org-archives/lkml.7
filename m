Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3DC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F0A2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749763;
	bh=k8aHjmYarlmNEDivZmxzXZHeSrYfcuQTDuVm+kBg0qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c+L1SXIos5IcI4lqvFUegTJxxqnlXhPyjmpjkaw6pOn7gRREMvTMrg8C0NMCLArgR
	 ijom0j6OpKqE2Z1G7pPsU5GD/7Y5f1i7H3+7/PqPMF4KRLqMYy8aZXey25TkxdcuLa
	 JufqxZs1XRYVB2W1tm3DIHpMMR1QcNViYsubPQDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfHNC3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfHNCXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:23:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 428CC2084F;
        Wed, 14 Aug 2019 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749412;
        bh=k8aHjmYarlmNEDivZmxzXZHeSrYfcuQTDuVm+kBg0qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bKAeITgDal0PmJ/1++wExth0PxQv2YT5MWncXOgU9oUVSanI7lyV0T13cVnmKO8BF
         4YlUUo7ovOnnYfreXJ2LflkRUjxswVGHyY90K3vmL58alXh60fXqpcN4s96s8BhUH5
         AjpHDNfZWOl53mtUEIu/2l13x/q24mMM/Pcb1jqE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricard Wanderlof <ricard.wanderlof@axis.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 07/33] ASoC: Fail card instantiation if DAI format setup fails
Date:   Tue, 13 Aug 2019 22:22:57 -0400
Message-Id: <20190814022323.17111-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022323.17111-1-sashal@kernel.org>
References: <20190814022323.17111-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricard Wanderlof <ricard.wanderlof@axis.com>

[ Upstream commit 40aa5383e393d72f6aa3943a4e7b1aae25a1e43b ]

If the DAI format setup fails, there is no valid communication format
between CPU and CODEC, so fail card instantiation, rather than continue
with a card that will most likely not function properly.

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
Link: https://lore.kernel.org/r/alpine.DEB.2.20.1907241132350.6338@lnxricardw1.se.axis.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 168559b5e9f32..d4fb45710eec1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1632,8 +1632,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 		}
 	}
 
-	if (dai_link->dai_fmt)
-		snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+	if (dai_link->dai_fmt) {
+		ret = snd_soc_runtime_set_dai_fmt(rtd, dai_link->dai_fmt);
+		if (ret)
+			return ret;
+	}
 
 	ret = soc_post_component_init(rtd, dai_link->name);
 	if (ret)
-- 
2.20.1

