Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD1AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91629213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M3ehYlM3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NHINJMBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfCLSOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:14:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfCLSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:14:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E52C761AA2; Tue, 12 Mar 2019 18:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414455;
        bh=XavfODKbiYd3VUlO1pljeUXeZYLnBdMdaR2DWcS0Jjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M3ehYlM3ux2SwmB7hkQOS42TY8kjmVX4Ap6TEqsMh6Rhxq1pXpd3pzLrJeP1tIZCi
         A42TddoRBmadbVQRKhSf2sbKo049PQWKA5T41ffg+aSNqijIQk7TdC3b+DcgRsAhuz
         F5qFXCgHBPngnK1FPqqX5oZYvJ6+MLcwQixoSaw4=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCF87619D0;
        Tue, 12 Mar 2019 18:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552414451;
        bh=XavfODKbiYd3VUlO1pljeUXeZYLnBdMdaR2DWcS0Jjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHINJMBrQ0nIJTVSwRpCmKbfxfoKgfYSE2MAJhuC3lVNa2ZAcXEygzmoqtAk6GsgF
         KgfdQEgjVEvMXyUqdsiQxr+0RYXn0J9kV5ISd80p6z/HfbjiNtFUw/2b9KqJ3XsVkB
         WE7+3leoW/0oglufdV7Q3Cz1f6j72CswhobHqy0Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCF87619D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Daniel Mack <daniel@zonque.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 2/4] drm/msm/a6xx: Add zap shader load
Date:   Tue, 12 Mar 2019 12:13:40 -0600
Message-Id: <1552414422-9568-3-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
References: <1552414422-9568-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The a6xx GPU powers on in secure mode which restricts what memory it can
write to. To get out of secure mode the GPU driver can write to
REG_A6XX_RBBM_SECVID_TRUST_CNTL but on targets that are "secure" that
register region is blocked and writes will cause the system to go down.

For those targets we need to execute a special sequence that involves
loadinga special shader that clears the GPU registers and use a PM4
sequence to pull the GPU out of secure. Add support for loading the zap
shader and executing the secure sequence. For targets that do not support
SCM or the specific SCM sequence this should fail and we would fall back
to writing the register.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 38 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/adreno_device.c |  1 +
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index fefe773..5983e47 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -10,6 +10,8 @@
 
 #include <linux/devfreq.h>
 
+#define GPU_PAS_ID 13
+
 static inline bool _a6xx_check_idle(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -343,6 +345,20 @@ static int a6xx_ucode_init(struct msm_gpu *gpu)
 	return 0;
 }
 
+static int a6xx_zap_shader_init(struct msm_gpu *gpu)
+{
+	static bool loaded;
+	int ret;
+
+	if (loaded)
+		return 0;
+
+	ret = adreno_zap_shader_load(gpu, GPU_PAS_ID);
+
+	loaded = !ret;
+	return ret;
+}
+
 #define A6XX_INT_MASK (A6XX_RBBM_INT_0_MASK_CP_AHB_ERROR | \
 	  A6XX_RBBM_INT_0_MASK_RBBM_ATB_ASYNCFIFO_OVERFLOW | \
 	  A6XX_RBBM_INT_0_MASK_CP_HW_ERROR | \
@@ -491,7 +507,27 @@ static int a6xx_hw_init(struct msm_gpu *gpu)
 	if (ret)
 		goto out;
 
-	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TRUST_CNTL, 0x0);
+	/*
+	 * Try to load a zap shader into the secure world. If successful
+	 * we can use the CP to switch out of secure mode. If not then we
+	 * have no resource but to try to switch ourselves out manually. If we
+	 * guessed wrong then access to the RBBM_SECVID_TRUST_CNTL register will
+	 * be blocked and a permissions violation will soon follow.
+	 */
+	ret = a6xx_zap_shader_init(gpu);
+	if (!ret) {
+		OUT_PKT7(gpu->rb[0], CP_SET_SECURE_MODE, 1);
+		OUT_RING(gpu->rb[0], 0x00000000);
+
+		a6xx_flush(gpu, gpu->rb[0]);
+		if (!a6xx_idle(gpu, gpu->rb[0]))
+			return -EINVAL;
+	} else {
+		/* Print a warning so if we die, we know why */
+		dev_warn_once(gpu->dev->dev,
+			"Zap shader not enabled - using SECVID_TRUST_CNTL instead\n");
+		gpu_write(gpu, REG_A6XX_RBBM_SECVID_TRUST_CNTL, 0x0);
+	}
 
 out:
 	/*
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 714ed65..ead5f6a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -155,6 +155,7 @@ static const struct adreno_info gpulist[] = {
 		.gmem = SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.init = a6xx_gpu_init,
+		.zapfw = "a630_zap.mdt",
 	},
 };
 
-- 
2.7.4

