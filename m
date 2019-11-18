Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA06AC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997F5222DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 23:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJu8zppi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfKRXnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 18:43:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45037 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKRXnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 18:43:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id az9so10662064plb.11;
        Mon, 18 Nov 2019 15:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cf8yodkoGRtKDfrnD35YQbS3qTKWlwJfxsTIImJLdbM=;
        b=FJu8zppiMyx+omZy5bO+IVg+9qxEmoz1snhctE+l4K1z3OKnQKdim1lHw0K+pQAOs5
         yAnrDotA2p76SHeGML+riON2n/thBPNGDCQ3YreVJFqojlwEiMCRcZBI5S4Q5scCtnnV
         RK+98KfsTycbmuCcKgodZRzeFVKtNipyBDjZ8hx/eWi+QZkkfL8V0xiTBRIfLYy0i2qv
         p3XCnbkpHLGRRW3RWjeBbIWaYwRJ30xxs/h2X38/66nL+t6iHpGOxcc9GxdeneSI+N70
         4+EsFlHLglthkf+oNZttvfWbFK2of8DsBznJHxYlgJ9BvqSHMFhsdPIrmDmBCgLZK+qG
         0vxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cf8yodkoGRtKDfrnD35YQbS3qTKWlwJfxsTIImJLdbM=;
        b=pAAm/l9ZqUucinc8TAARY0wt2Ykqj+vm7MlYuWJE3ZycTCUnKiNbd4RDtmmCRlxVR2
         Dq7bF2+dCgG931tW3luI2fnUFb5IKTTq4dTl1+3iJJLKhFcEb0Al/kENdW80dtgZau7W
         Wl+X8dzavrlortUi+TZ/pBSMb++oNxGbkQ7VSXDYwWdY4oNgEOt+DrfeCI0Wp+Oj9JIM
         hIiwz6OVOt6yvF7YeS+/XMSmgxdlr47r/HwY8UUrfZe9kO0Mgq3swyFujBfT4xhZldZJ
         143ottvXmvzsh/B2bFQRvZefObh8GOJYJdTTd70b4heMltOgqejn8dkqB8yUJyARU1IA
         hUyg==
X-Gm-Message-State: APjAAAXAXDmmEb2a+zQaMm9Yu7jOJrfM7RSHdkgocP1yenFAhV3Igm1I
        4iRvUgYh9zdE8p+Hg33k/S0nEJEds0s=
X-Google-Smtp-Source: APXvYqxZFe04Csp23cuMrWCkWUlksPNGgycxX0DupFxhtb/wTx95pSfOfbetmGRcuXUnRewQwkoyaw==
X-Received: by 2002:a17:90a:353:: with SMTP id 19mr2265458pjf.128.1574120585799;
        Mon, 18 Nov 2019 15:43:05 -0800 (PST)
Received: from localhost ([100.118.89.215])
        by smtp.gmail.com with ESMTPSA id t15sm23615528pgb.0.2019.11.18.15.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 15:43:05 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        freedreno@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/a6xx: restore previous freq on resume
Date:   Mon, 18 Nov 2019 15:40:38 -0800
Message-Id: <20191118234043.331542-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Previously, if the freq were overriden (ie. via sysfs), it would get
reset to max on resume.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 8 ++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2ca470eb5cb8..b64867701e5a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -149,6 +149,8 @@ void a6xx_gmu_set_freq(struct msm_gpu *gpu, unsigned long freq)
 		if (freq == gmu->gpu_freqs[perf_index])
 			break;
 
+	gmu->current_perf_index = perf_index;
+
 	__a6xx_gmu_set_freq(gmu, perf_index);
 }
 
@@ -741,8 +743,8 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	gmu_write(gmu, REG_A6XX_GMU_GMU2HOST_INTR_MASK, ~A6XX_HFI_IRQ_MASK);
 	enable_irq(gmu->hfi_irq);
 
-	/* Set the GPU to the highest power frequency */
-	__a6xx_gmu_set_freq(gmu, gmu->nr_gpu_freqs - 1);
+	/* Set the GPU to the current freq */
+	__a6xx_gmu_set_freq(gmu, gmu->current_perf_index);
 
 	/*
 	 * "enable" the GX power domain which won't actually do anything but it
@@ -1166,6 +1168,8 @@ static int a6xx_gmu_pwrlevels_probe(struct a6xx_gmu *gmu)
 	gmu->nr_gpu_freqs = a6xx_gmu_build_freq_table(&gpu->pdev->dev,
 		gmu->gpu_freqs, ARRAY_SIZE(gmu->gpu_freqs));
 
+	gmu->current_perf_index = gmu->nr_gpu_freqs - 1;
+
 	/* Build the list of RPMh votes that we'll send to the GMU */
 	return a6xx_gmu_rpmh_votes_init(gmu);
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 39a26dd63674..2af91ed7ed0c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -63,6 +63,9 @@ struct a6xx_gmu {
 	struct clk_bulk_data *clocks;
 	struct clk *core_clk;
 
+	/* current performance index set externally */
+	int current_perf_index;
+
 	int nr_gpu_freqs;
 	unsigned long gpu_freqs[16];
 	u32 gx_arc_votes[16];
-- 
2.23.0

