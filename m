Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F508C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685CD20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QB0Xdo1v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y1HaclBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbfCATkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:40:02 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:44070 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfCATj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:39:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1477761B30; Fri,  1 Mar 2019 19:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469197;
        bh=y0zGP4ZFToYS5xCseENwmzyCT+wKc2S0SKWjBV+zGw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QB0Xdo1v30TIiOPltv3r8cF0bHTyYd23IeZmR3i5fVsz+ElAqAX3HVjzoPMjkC+qC
         oFZKmSf84WKYH7MYOR2yHwz7sj2OvMgiSp6AcopFkMK2dc7XcwGLNYgOl2V0MSb60q
         d4oapDijFiR5wQNoepT3EO+RySIjeENVZ7NOp6+s=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60CEB618E9;
        Fri,  1 Mar 2019 19:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469141;
        bh=y0zGP4ZFToYS5xCseENwmzyCT+wKc2S0SKWjBV+zGw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y1HaclBEi4cjitThlqr9h6Xp66LxHT1iG4oT2kTad0vwno/9xyhUQhLMpfK8gTWWI
         EKfgQivh74+hNl8693B4wrmX53wDItjItG6vDvIgN6hTTVpJwCrqC2icBHY8NdDUll
         8vvC1b0W+UGFQ7lCYYjTvaK3oo6M4RakidOLD7w8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60CEB618E9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC PATCH v1 12/15] drm/msm: Add support to create target specific address spaces
Date:   Fri,  1 Mar 2019 12:38:34 -0700
Message-Id: <1551469117-3404-13-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to create a GPU target specific address space for
a context. For those targets that support per-instance
pagetables they will return a new address space set up for
the instance if possible otherwise just use the global
device pagetable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_drv.c | 25 ++++++++++++++++++++++---
 drivers/gpu/drm/msm/msm_gpu.h |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index cac2293..5b83093 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -605,6 +605,14 @@ static void load_gpu(struct drm_device *dev)
 	mutex_unlock(&init_lock);
 }
 
+static struct msm_gem_address_space *context_address_space(struct msm_gpu *gpu)
+{
+	if (!gpu->funcs->new_address_space)
+		return gpu->aspace;
+
+	return gpu->funcs->new_address_space(gpu);
+}
+
 static int context_init(struct drm_device *dev, struct drm_file *file)
 {
 	struct msm_drm_private *priv = dev->dev_private;
@@ -614,9 +622,16 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
 	if (!ctx)
 		return -ENOMEM;
 
+	ctx->aspace = context_address_space(priv->gpu);
+	if (IS_ERR(ctx->aspace)) {
+		int ret = PTR_ERR(ctx->aspace);
+
+		kfree(ctx);
+		return ret;
+	}
+
 	msm_submitqueue_init(dev, ctx);
 
-	ctx->aspace = priv->gpu->aspace;
 	file->driver_priv = ctx;
 
 	return 0;
@@ -632,8 +647,12 @@ static int msm_open(struct drm_device *dev, struct drm_file *file)
 	return context_init(dev, file);
 }
 
-static void context_close(struct msm_file_private *ctx)
+static void context_close(struct msm_drm_private *priv,
+		struct msm_file_private *ctx)
 {
+	if (ctx->aspace != priv->gpu->aspace)
+		msm_gem_address_space_put(ctx->aspace);
+
 	msm_submitqueue_close(ctx);
 	kfree(ctx);
 }
@@ -648,7 +667,7 @@ static void msm_postclose(struct drm_device *dev, struct drm_file *file)
 		priv->lastctx = NULL;
 	mutex_unlock(&dev->struct_mutex);
 
-	context_close(ctx);
+	context_close(priv, ctx);
 }
 
 static irqreturn_t msm_irq(int irq, void *arg)
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 81b9861..35b0faf 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -76,6 +76,7 @@ struct msm_gpu_funcs {
 	void (*gpu_set_freq)(struct msm_gpu *gpu, unsigned long freq);
 	struct msm_gem_address_space *(*create_address_space)
 		(struct msm_gpu *gpu);
+	struct msm_gem_address_space *(*new_address_space)(struct msm_gpu *gpu);
 };
 
 struct msm_gpu {
-- 
2.7.4

