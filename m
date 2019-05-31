Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D71C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E7A26F93
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 22:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A6m+hWwr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WU34CiZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfEaWJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 18:09:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfEaWJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 18:09:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7E15F60A44; Fri, 31 May 2019 22:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559340593;
        bh=A8zDS66mjFwXp5YoMISUc0SPzfOMxvbFtRNcKwj+2ZY=;
        h=From:To:Cc:Subject:Date:From;
        b=A6m+hWwrjnUITlEJsQN/FfJWTlkxkPd14awJ83GY0dsezNVxfSE29U5VUlHlEpZHf
         7122p8L184mhQ4qBQQVzQXcyVhpniRXXJADucPytlIamdkLE2iAJcsCsBYzV5LDE4D
         9+jBnX5CbU3UokdeEf0Ng+onk/26SIIZEj0ib2/U=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 309D160712;
        Fri, 31 May 2019 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559340591;
        bh=A8zDS66mjFwXp5YoMISUc0SPzfOMxvbFtRNcKwj+2ZY=;
        h=From:To:Cc:Subject:Date:From;
        b=WU34CiZqbH7Vy5mC9Mv7jpghXfkOTCP5nHlG1N3qw1UyNTEcxajfVvALY+7S0xV6U
         lmGAXoHioCsmQXbl7xLpVEe5FChLTjOEoIpjQCjxEQsolowG/Yg1+5I9+xhPXh7OlA
         9ePXkP+nJfoc0SWBvx4sYPHFHPcEjJunrVYtF5tQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 309D160712
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     bjorn.andersson@linaro.org, Sean Paul <sean@poorly.run>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Marek <jonathan@marek.ca>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] drm/msm/adreno: Ensure that the zap shader region is big enough
Date:   Fri, 31 May 2019 16:09:38 -0600
Message-Id: <1559340578-11482-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before loading the zap shader we should ensure that the reserved memory
region is big enough to hold the loaded file.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 6f7f411..3db8e49 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -67,7 +67,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		return ret;
 
 	mem_phys = r.start;
-	mem_size = resource_size(&r);
 
 	/* Request the MDT file for the firmware */
 	fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
@@ -83,6 +82,13 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		goto out;
 	}
 
+	if (mem_size > resource_size(&r)) {
+		DRM_DEV_ERROR(dev,
+			"memory region is too small to load the MDT\n");
+		ret = -E2BIG;
+		goto out;
+	}
+
 	/* Allocate memory for the firmware image */
 	mem_region = memremap(mem_phys, mem_size,  MEMREMAP_WC);
 	if (!mem_region) {
-- 
2.7.4

