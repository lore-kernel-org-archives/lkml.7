Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E27C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDC720895
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573921308;
	bh=9Y+FllgtX9H8rgB0biRlPzQSiJRaRqpAoGAVl3BQjbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j8bU3nMdslw4uZLLQjGe6pZoUYdqsVEJoTMkLZ12yNqGEAdQR5KcwxjKxvMkKc8+L
	 ScdpSF+S1lpoctilVN9YveQ1IA/RrZE9UEo4hs6NTsFtUcPRyIEXw7dE1Yfw5sykbF
	 nmTvOxVplOanfBL9wW/7yjG/LtxJNj+gQQIXdgY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfKPQVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:21:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfKPPn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:43:27 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F7220733;
        Sat, 16 Nov 2019 15:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919007;
        bh=9Y+FllgtX9H8rgB0biRlPzQSiJRaRqpAoGAVl3BQjbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TWURu8VBKgZ/95mm9Stse6cWVRhrVJAtsRGaQrdZRPRy3fCqazGIos0HM0AFqRkoL
         OXgxT/zMESmJElRqP3zQlHLiyh7z9inVmDdQGLqbQIcikWbkg4oulEONPF3c4GBaC+
         xFVjE3tQ/1x7kY+4pGgkSWRT1CaoMVIFmrxF5qG8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.19 109/237] mfd: arizona: Correct calling of runtime_put_sync
Date:   Sat, 16 Nov 2019 10:39:04 -0500
Message-Id: <20191116154113.7417-109-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154113.7417-1-sashal@kernel.org>
References: <20191116154113.7417-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>

[ Upstream commit 6b269a41a4520f7eb639e61a45ebbb9c9267d5e0 ]

Don't call runtime_put_sync when clk32k_ref is ARIZONA_32KZ_MCLK2
as there is no corresponding runtime_get_sync call.

MCLK1 is not in the AoD power domain so if it is used as 32kHz clock
source we need to hold a runtime PM reference to keep the device from
going into low power mode.

Fixes: cdd8da8cc66b ("mfd: arizona: Add gating of external MCLKn clocks")
Signed-off-by: Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/arizona-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 47d6d40f41cd5..a4403a57ddc89 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -52,8 +52,10 @@ int arizona_clk32k_enable(struct arizona *arizona)
 			if (ret != 0)
 				goto err_ref;
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK1]);
-			if (ret != 0)
-				goto err_pm;
+			if (ret != 0) {
+				pm_runtime_put_sync(arizona->dev);
+				goto err_ref;
+			}
 			break;
 		case ARIZONA_32KZ_MCLK2:
 			ret = clk_prepare_enable(arizona->mclk[ARIZONA_MCLK2]);
@@ -67,8 +69,6 @@ int arizona_clk32k_enable(struct arizona *arizona)
 					 ARIZONA_CLK_32K_ENA);
 	}
 
-err_pm:
-	pm_runtime_put_sync(arizona->dev);
 err_ref:
 	if (ret != 0)
 		arizona->clk32k_ref--;
-- 
2.20.1

