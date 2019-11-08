Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E38C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F7220865
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239378;
	bh=b0x8Gs9Zpom0YF4Flfqrm3qMH3OCo1FV30kw02Qse9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=boZQI6zHkzewElL44/mGW7VZE/sYz1HpjBo1qclCCkF8v6WLW/YsTUE0uTNvGriXp
	 sFLhXwWViIklEAEs+FKnQ+zejOCS/8021uu30LL2oj25Cf4HmlvwlQ5oqdZD8ZEYHH
	 wgVdMyxONZJC1RJG4PkXHjeUJ2fps3bNH2rJKZXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfKHS4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbfKHS4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:56:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B8C214DB;
        Fri,  8 Nov 2019 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239356;
        bh=b0x8Gs9Zpom0YF4Flfqrm3qMH3OCo1FV30kw02Qse9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtTWUR2gkOOkmszFucKgl5k+6tWuKV61CRVt+ugK0fvkTv3fzKoVgIzjdjERQLnvi
         xPm/qWtxPyk8fcCDbjiRBDghi95969c+D0Z/JJuw0Lq9UeNyrteAVXT3ksaDborMTR
         Wea51oS0PnMSzvhImHZMTmj2/F9Gg6FFIm6S92BM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 04/34] ASoc: rockchip: i2s: Fix RPM imbalance
Date:   Fri,  8 Nov 2019 19:50:11 +0100
Message-Id: <20191108174624.598351311@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174618.266472504@linuxfoundation.org>
References: <20191108174618.266472504@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit b1e620e7d32f5aad5353cc3cfc13ed99fea65d3a ]

If rockchip_pcm_platform_register() fails, e.g. upon deferring to wait
for an absent DMA channel, we return without disabling RPM, which makes
subsequent re-probe attempts scream with errors about the unbalanced
enable. Don't do that.

Fixes: ebb75c0bdba2 ("ASoC: rockchip: i2s: Adjust devm usage")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/bcb12a849a05437fb18372bc7536c649b94bdf07.1570029862.git.robin.murphy@arm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 08bfee447a365..94b6f9c7dd6bb 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -649,7 +649,7 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	ret = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "Could not register PCM\n");
-		return ret;
+		goto err_suspend;
 	}
 
 	return 0;
-- 
2.20.1



