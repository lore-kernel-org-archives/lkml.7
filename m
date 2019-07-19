Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAB0C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802520873
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510657;
	bh=U2o3tcF4clpNjxhqTpa9MnqyzNpJJNHwS4xYYGcqXWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SLm7xyCVw8ONdtqwn5Fq2Bg8zrFq4xT+6FKRNKWHmJv9AJE9sXXgVYb3n85ykpwx+
	 juQt/Y/zvCATN8Ke/rDFT3knt/ZBRq5lXvZI+kEl1xH2wZBQzk0sq1vGBZyN6P9mso
	 H75P7b9DUlr+jlWJyp8J9Rsg0AAp6rnPDpbvVwew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfGSEEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729860AbfGSEEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:04:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5331218A3;
        Fri, 19 Jul 2019 04:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509082;
        bh=U2o3tcF4clpNjxhqTpa9MnqyzNpJJNHwS4xYYGcqXWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBlGisE6BZWC4ImkkUx2rvXtFpCUfXKRWTMyKeT2c1UsnSCrkOC/NnrXogUVrNusR
         qS0ZME9K6i9T4X6VmFn29xwz77KQAPiQB0cKDnWpGwMMDF83oUi/NwuY4mVr2ciU7T
         MbSXld/kJaHz8CWEfCtXIHz2Sm7FJ3xTKwU24rWQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 059/141] drm/msm: Depopulate platform on probe failure
Date:   Fri, 19 Jul 2019 00:01:24 -0400
Message-Id: <20190719040246.15945-59-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 4368a1539c6b41ac3cddc06f5a5117952998804c ]

add_display_components() calls of_platform_populate, and we depopluate
on pdev remove, but not when probe fails. So if we get a probe deferral
in one of the components, we won't depopulate the platform. This causes
the core to keep references to devices which should be destroyed, which
causes issues when those same devices try to re-initialize on the next
probe attempt.

I think this is the reason we had issues with the gmu's device-managed
resources on deferral (worked around in commit 94e3a17f33a5).

Reviewed-by: Rob Clark <robdclark@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190617201301.133275-3-sean@poorly.run
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_drv.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 0bdd93648761..fadb476a5cad 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1308,16 +1308,24 @@ static int msm_pdev_probe(struct platform_device *pdev)
 
 	ret = add_gpu_components(&pdev->dev, &match);
 	if (ret)
-		return ret;
+		goto fail;
 
 	/* on all devices that I am aware of, iommu's which can map
 	 * any address the cpu can see are used:
 	 */
 	ret = dma_set_mask_and_coherent(&pdev->dev, ~0);
 	if (ret)
-		return ret;
+		goto fail;
+
+	ret = component_master_add_with_match(&pdev->dev, &msm_drm_ops, match);
+	if (ret)
+		goto fail;
 
-	return component_master_add_with_match(&pdev->dev, &msm_drm_ops, match);
+	return 0;
+
+fail:
+	of_platform_depopulate(&pdev->dev);
+	return ret;
 }
 
 static int msm_pdev_remove(struct platform_device *pdev)
-- 
2.20.1

