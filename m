Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A54C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F9A217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610666;
	bh=Axz59moKgMJfsNbXi9hS7Wm12MSR0cYvjle8NE4YFLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBVwr1SfERKTsKcj5ptGEcgca9i2+mhmP7dQV3wg6xNWgSg52LVUleUQw2wi3Sj6s
	 ejqSIeuT+N/Y9KXVN+hdTZR6oSQSnbXKXXtYFG5QjApVb3nplRIWPs+Cd35ZKVQUUT
	 6sWhTeBkwa/sF3ARC5sWFjMTm7/g8ihXt9ejxiP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391107AbfDRSEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390675AbfDRSER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:04:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A43921871;
        Thu, 18 Apr 2019 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610657;
        bh=Axz59moKgMJfsNbXi9hS7Wm12MSR0cYvjle8NE4YFLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MrKcs2PFzpbrejL4/JANoTKjM8nvugzaDN1GWW4TAZoz6LWtSr2fgUWKEVOxCX4Wn
         /oThelJxNSAvYDw6XtWNS/jhxd7jxCPw9j8A14clPPVYqRUzD0QpMXG6/JofJBz8NK
         qj9KVnstjBCxIeEUGKImYR4R3q8Ud2ZEkwIusZ1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 33/92] drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
Date:   Thu, 18 Apr 2019 19:56:51 +0200
Message-Id: <20190418160433.289956688@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



