Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2ECC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E485E218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908128;
	bh=OZ+A2K1JmLcdVFyEOhXpS5nOHoRgVyKSYff3qhSNIIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZn96WkajWtbTzQAoCNA/t4GhyyUVO8s7G/yf5DL1vqYpJ5u4WHZ64/4lSSGBA56O
	 N7pU7um42Ihb+zZjnumdtRm2Qylmiz3i/wedm65B8ahuVlu0Q12d5j9DRqvp8YU4bf
	 hFlZQ3/ERaHoxpQFzC/qy8+n3ECzdveUjzQ091lA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfC3BIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 21:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731097AbfC3Awp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC793218D9;
        Sat, 30 Mar 2019 00:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907164;
        bh=OZ+A2K1JmLcdVFyEOhXpS5nOHoRgVyKSYff3qhSNIIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZGtSAYlsgOgsOhsv9X4yZ+KMewbpBMsX/9Zy3dgSCfb4A06BulYdB+9F8+dahAJ/W
         BE4Clv+Q/tPh08lFNN36j7WcRbYq1WzKc7C9aRTLRk8uOctzPuOjEqq3NrKgiGR4V/
         K6vHuytBDw0sxtGVzOhllyMpKQYKsgdrcC9aNUHY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 59/67] drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
Date:   Fri, 29 Mar 2019 20:50:39 -0400
Message-Id: <20190330005047.25998-59-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 909e9c9c428376e2a43d178ed4b0a2d5ba9cb7d3 ]

pm_runtime_get_sync returns negative on failure.

Fixes: eaeb9010bb4b ("drm/nouveau/debugfs: Wake up GPU before doing any reclocking")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 88a52f6b39fe..7dfbbbc1beea 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -181,7 +181,7 @@ nouveau_debugfs_pstate_set(struct file *file, const char __user *ubuf,
 	}
 
 	ret = pm_runtime_get_sync(drm->dev);
-	if (IS_ERR_VALUE(ret) && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES)
 		return ret;
 	ret = nvif_mthd(ctrl, NVIF_CONTROL_PSTATE_USER, &args, sizeof(args));
 	pm_runtime_put_autosuspend(drm->dev);
-- 
2.19.1

