Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC23FC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C225321851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lz259Gch";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PXvWRxJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfGYQyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:54:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55906 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbfGYQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:54:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8F1FF618E1; Thu, 25 Jul 2019 16:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564073642;
        bh=JX5a4knX1zlE7Ic/SEaGbhWGGuYLtzUU8dSNGCasgeU=;
        h=From:To:Cc:Subject:Date:From;
        b=lz259GchXqS1PlLGI5Tr5CByuFTtOEcB70GJtw3nTxuq91DEGiJ5koBK0ftEy6wHz
         ukDb5r2vXaD7uHupgB8TqbPP5aEdI8958j3262+v2Dc+ScId9CUjQikEtySLIjPgEY
         UjmRYjULEyQyjQI+2nhc4IIc8odSrqiaDNT7fx7E=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE69F60C5F;
        Thu, 25 Jul 2019 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564073640;
        bh=JX5a4knX1zlE7Ic/SEaGbhWGGuYLtzUU8dSNGCasgeU=;
        h=From:To:Cc:Subject:Date:From;
        b=PXvWRxJgS3p+MdXTXy/lw/0oCGSwBg4JlcQBBGPozVMUNb8G8IppudngNpR/HrgF7
         bFpvpbsfYI7XEKQ5Usz9b9xdd+5AXOSDN9h0jN0sfU2Fd8KnHf7fZth7CH8PMnGrhC
         w1iOd3zB59X6JM+rE7iueb2Uzx/no19asKYVQZIQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE69F60C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Rob Clark <robdclark@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm: Use generic bulk clock function
Date:   Thu, 25 Jul 2019 10:53:55 -0600
Message-Id: <1564073635-27998-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the homebrewed bulk clock get function and replace it with
devm_clk_bulk_get_all().

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  2 +-
 drivers/gpu/drm/msm/msm_drv.c         | 40 -----------------------------------
 drivers/gpu/drm/msm/msm_drv.h         |  1 -
 drivers/gpu/drm/msm/msm_gpu.c         |  2 +-
 4 files changed, 2 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2ca470e..85f14fe 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1172,7 +1172,7 @@ static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
 
 static int a6xx_gmu_clocks_probe(struct a6xx_gmu *gmu)
 {
-	int ret = msm_clk_bulk_get(gmu->dev, &gmu->clocks);
+	int ret = devm_clk_bulk_get_all(gmu->dev, &gmu->clocks);
 
 	if (ret < 1)
 		return ret;
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 0e0fca1..96fe24c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -75,46 +75,6 @@ module_param(modeset, bool, 0600);
  * Util/helpers:
  */
 
-int msm_clk_bulk_get(struct device *dev, struct clk_bulk_data **bulk)
-{
-	struct property *prop;
-	const char *name;
-	struct clk_bulk_data *local;
-	int i = 0, ret, count;
-
-	count = of_property_count_strings(dev->of_node, "clock-names");
-	if (count < 1)
-		return 0;
-
-	local = devm_kcalloc(dev, sizeof(struct clk_bulk_data *),
-		count, GFP_KERNEL);
-	if (!local)
-		return -ENOMEM;
-
-	of_property_for_each_string(dev->of_node, "clock-names", prop, name) {
-		local[i].id = devm_kstrdup(dev, name, GFP_KERNEL);
-		if (!local[i].id) {
-			devm_kfree(dev, local);
-			return -ENOMEM;
-		}
-
-		i++;
-	}
-
-	ret = devm_clk_bulk_get(dev, count, local);
-
-	if (ret) {
-		for (i = 0; i < count; i++)
-			devm_kfree(dev, (void *) local[i].id);
-		devm_kfree(dev, local);
-
-		return ret;
-	}
-
-	*bulk = local;
-	return count;
-}
-
 struct clk *msm_clk_bulk_get_clock(struct clk_bulk_data *bulk, int count,
 		const char *name)
 {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index ee7b512..843c68f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -399,7 +399,6 @@ static inline void msm_perf_debugfs_cleanup(struct msm_drm_private *priv) {}
 #endif
 
 struct clk *msm_clk_get(struct platform_device *pdev, const char *name);
-int msm_clk_bulk_get(struct device *dev, struct clk_bulk_data **bulk);
 
 struct clk *msm_clk_bulk_get_clock(struct clk_bulk_data *bulk, int count,
 	const char *name);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 4edb874..445a9f8 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -783,7 +783,7 @@ static irqreturn_t irq_handler(int irq, void *data)
 
 static int get_clocks(struct platform_device *pdev, struct msm_gpu *gpu)
 {
-	int ret = msm_clk_bulk_get(&pdev->dev, &gpu->grp_clks);
+	int ret = devm_clk_bulk_get_all(&pdev->dev, &gpu->grp_clks);
 
 	if (ret < 1) {
 		gpu->nr_clocks = 0;
-- 
2.7.4

