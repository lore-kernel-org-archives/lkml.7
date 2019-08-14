Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32186C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5C020679
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565749696;
	bh=BfmG4lrGqdqkzoDHYHNnDYZJryGrxYsFnNNr8ZPGoRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nAPoalEPt40J9z54qjKXJ8ApzUphEmf1ml6NglXI6cUwGHlgeVl2/kFYIu2N1X+7/
	 3YbA+kb5iSJwr9kYOb/a1DAtXxjmKiBR1LxuJNF/PgdtqUSFzXJQrJDyExzr7CERly
	 quJdaeu7bFvRfwoKdB1wzJsPBcnPlJ0+46oiRRsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfHNC0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbfHNCZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:25:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB1B7208C2;
        Wed, 14 Aug 2019 02:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565749559;
        bh=BfmG4lrGqdqkzoDHYHNnDYZJryGrxYsFnNNr8ZPGoRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snYBcWS/pwFeYWwYOH6693cZs51j1VVn3N+t7VmsD1o/hbmWpYH6R0a1CSIdbQcOB
         9QaxohtBRemx+sNh3ES8GDupNXWKkAEnk/hctdYMTvpA+QNnS36BcXj7aY53tTXlA6
         u8+dMGd+BPMPeEQKejtTg4yzsUNpOuVHPQqfZ1l8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ricard Wanderlof <ricard.wanderlof@axis.com>,
        Ricard Wanderlof <ricardw@axis.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 06/28] ASoC: Fail card instantiation if DAI format setup fails
Date:   Tue, 13 Aug 2019 22:25:28 -0400
Message-Id: <20190814022550.17463-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814022550.17463-1-sashal@kernel.org>
References: <20190814022550.17463-1-sashal@kernel.org>
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
index b927f9c81d922..8d10a24d38e06 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1357,8 +1357,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
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

