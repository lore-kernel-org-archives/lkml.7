Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E608C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D151B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429847;
	bh=SLoCrE+l3z1bj2/xRj9SHLZmNuZjXvDISzhJ4Qw/hkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zl/kqlgwJeKJU8RmODM9oQY2mpZIWLPl4vG4WjDN8AQMvHA77A8JcZvPBd3VxM5cF
	 hMkQib6QyEI20HX5mjFeE4X8yiRtFYFE9ioyJEt1SRpfgvqPSngnbqbyG61DVZcBPL
	 1Jp9QOIUZso4avH/myTkFrKmUxrL6gsm9RfgGob8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbfG2Tuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403822AbfG2Tuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:50:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70DEF2054F;
        Mon, 29 Jul 2019 19:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429843;
        bh=SLoCrE+l3z1bj2/xRj9SHLZmNuZjXvDISzhJ4Qw/hkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMz+W7Z5FPeUeCm8meKe2thgmvrYPcOl9e06T86YBQBZfdA0kZlHK2kzThsas5Tdz
         6el7BA/xPPUYEV2xjUQ6RFrCdbAcO8jBf13SXPqN1YhNNxZVN7/oJASKmWU22eOn9v
         w2HeQxV0SfVI4M9Wn16XHHOn4v13zEzFa5YGFEHo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 076/215] drm/msm/adreno: Ensure that the zap shader region is big enough
Date:   Mon, 29 Jul 2019 21:21:12 +0200
Message-Id: <20190729190753.184172489@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



