Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67E220675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611400;
	bh=p1f7TdzYgphg43M3jHgFhO+Vju8BZayxXHbmZ626W34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JHWYekqTKKloLFw74q6f6mQ24AYwFefH3jOcTdYVZJngxjkOgrxjZPgjrBgGlS++p
	 cHVQbJfn7Sw4j+hVG+n365aN2qeS5daWpNh8faXpzh3B0Ft9dPIHs6YplcYWYCWeyp
	 ru4wOL1Op0znujLT3HOvjHSaxNfLzI56MyL+RUfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391841AbfDRSQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391765AbfDRSLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E4620675;
        Thu, 18 Apr 2019 18:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611104;
        bh=p1f7TdzYgphg43M3jHgFhO+Vju8BZayxXHbmZ626W34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QXr3KBH5zKzmxqASo/nfC5NPCtULW9yJmRN1hlrSNNTSUtaHH5EY7Xzv6R4bal/eQ
         46nQ0CtHDQV7G9sOHQct1udTT4LpG7VZrvOd17quvwSqF7c1Ehqnx+hYb/4jnIDQtR
         7RUdMNiegvHQGzFBJK+Z2RsL6X+Ltpy70Zb6oSeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 59/93] drm/nouveau/debugfs: Fix check of pm_runtime_get_sync failure
Date:   Thu, 18 Apr 2019 19:57:37 +0200
Message-Id: <20190418160443.477087307@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
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



