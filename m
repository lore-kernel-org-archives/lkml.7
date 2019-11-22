Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFB3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BEF206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 01:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="B4PBjm7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKVB1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 20:27:01 -0500
Received: from onstation.org ([52.200.56.107]:33796 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfKVB07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:26:59 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 29A634FE4B;
        Fri, 22 Nov 2019 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1574386018;
        bh=10+BffMjbxiihXp6FLNavq2ojK7BnwQalTkr2swFDV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4PBjm7ak6+ckQMuruSs+lNSKhx4HGQp1r7NQ+jtOLVtul4UT9S+MWUKQbftGMmUH
         se7DCsKdYvEdUkRlB2yzm29m1jDnHKhn2zYbz2d7dfBDL2YsYQbmXlPbyEC33iZkVi
         cgSz9BKwjnThtuXLPoY4AK/LUMjvHlnsfI7P0qzw=
From:   Brian Masney <masneyb@onstation.org>
To:     robdclark@gmail.com, sean@poorly.run, robh+dt@kernel.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, jcrouse@codeaurora.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] drm/msm/a4xx: set interconnect bandwidth vote
Date:   Thu, 21 Nov 2019 20:26:45 -0500
Message-Id: <20191122012645.7430-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122012645.7430-1-masneyb@onstation.org>
References: <20191122012645.7430-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the two interconnect paths for the GPU to maximum speed for now to
work towards getting the GPU working upstream. We can revisit a later
time to optimize this for battery life.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index b01388a9e89e..253d8d85daad 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -591,6 +591,14 @@ struct msm_gpu *a4xx_gpu_init(struct drm_device *dev)
 		goto fail;
 	}
 
+	/*
+	 * Set the ICC path to maximum speed for now by multiplying the fastest
+	 * frequency by the bus width (8). We'll want to scale this later on to
+	 * improve battery life.
+	 */
+	icc_set_bw(gpu->icc_path, 0, Bps_to_icc(gpu->fast_rate) * 8);
+	icc_set_bw(gpu->ocmem_icc_path, 0, Bps_to_icc(gpu->fast_rate) * 8);
+
 	return gpu;
 
 fail:
-- 
2.21.0

