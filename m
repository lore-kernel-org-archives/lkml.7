Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FFEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EAA218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907353;
	bh=f6BYvAxD7UhTqYmqTgiKN6eSDGoYoNVsqjjMq7NbeSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O8T26FqV5tHtD8eejE1s3FMRgyJt5eRjgefT/YYX+nYCNYn15bdCfP9H/8rh8Ce3K
	 H/oez5BURZWcJjF7Jmzfu/chxIGIhpJtE9nppVGp8MvMrQftKoRyiDgt2k6etWLZz4
	 U5Q+gKOAfhLDmVDGZ0q/5Nt9Z4VKl90tpzesT/U0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbfC3Azv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731816AbfC3Azr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B06218D8;
        Sat, 30 Mar 2019 00:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907347;
        bh=f6BYvAxD7UhTqYmqTgiKN6eSDGoYoNVsqjjMq7NbeSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NuC+zR85i1AK2rztTTBu8fh4ei0I9vE0ps5//DBgP0JAMHwWLii5L+pzbFI4HaLCg
         HBzIv32AK5/XvOvDJAJuuOc6wrDCBNLNXn39EqHulpqGcsGs7Py27FAw6XWwYJNYLl
         K/yfhx1QWnIB5+f7KPrHGzMPikIVRQGwibnCmd9w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.14 33/37] drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
Date:   Fri, 29 Mar 2019 20:54:34 -0400
Message-Id: <20190330005441.27540-33-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
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
index 9109b69cd052..9635704a1d86 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -161,7 +161,7 @@ nouveau_debugfs_pstate_set(struct file *file, const char __user *ubuf,
 	}
 
 	ret = pm_runtime_get_sync(drm->dev);
-	if (IS_ERR_VALUE(ret) && ret != -EACCES)
+	if (ret < 0 && ret != -EACCES)
 		return ret;
 	ret = nvif_mthd(ctrl, NVIF_CONTROL_PSTATE_USER, &args, sizeof(args));
 	pm_runtime_put_autosuspend(drm->dev);
-- 
2.19.1

