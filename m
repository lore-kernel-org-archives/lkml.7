Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6042DC76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308BC2189E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508769;
	bh=dhxt8vrEK/YOQ/s69fnoSZf6HqR0cV3OukQKYT12Uq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2YmCrL2jTjiNUJYA5cLCVFUsSca9lpBt831NSU2QHTtmeTzixR48sM42s2YW3rGHI
	 9avBlT9XKPTAbPF66iHlgzK6WEHReFvUdLO69pQTbFCD2Jotwoxpzzu2tZ60jP6tKr
	 RRoYy1lzShG+3ax5NX7YzFBmHSeaFoFzKyHSIwFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfGSD72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfGSD7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:59:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2212F2189E;
        Fri, 19 Jul 2019 03:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508763;
        bh=dhxt8vrEK/YOQ/s69fnoSZf6HqR0cV3OukQKYT12Uq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeS6kzXV6Qw09mpw5SCui6FwlyXHpBna91RX0X7aI1mk+PzIDH2W4IoF4pRKkpKu6
         WmPdWZ9D82UuRxE7ah/RSYGiJAFB+ZpxLfCtuivYWp/w4LqeXhl8/g1qLQgOddF+4N
         UOOxinn+JomDKXSwvgNbhn90HzxwmS6FDaOVfVVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 076/171] drm/msm/adreno: Ensure that the zap shader region is big enough
Date:   Thu, 18 Jul 2019 23:55:07 -0400
Message-Id: <20190719035643.14300-76-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jcrouse@codeaurora.org>

[ Upstream commit 6672e11cad662ce6631e04c38f92a140a99c042c ]

Before loading the zap shader we should ensure that the reserved memory
region is big enough to hold the loaded file.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Signed-off-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index a9c0ac937b00..9acbbc0f3232 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -56,7 +56,6 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
 		return ret;
 
 	mem_phys = r.start;
-	mem_size = resource_size(&r);
 
 	/* Request the MDT file for the firmware */
 	fw = adreno_request_fw(to_adreno_gpu(gpu), fwname);
@@ -72,6 +71,13 @@ static int zap_shader_load_mdt(struct msm_gpu *gpu, const char *fwname,
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
2.20.1

