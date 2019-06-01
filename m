Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A310C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0477F2725B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559395042;
	bh=scxhZynwZodEPPgyPa4Jy0luRfXCFIG9QxNi2wfXlKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WF7uTPVQTkK0cMQm7Yus6EGhetmmIPh1eI+t2pcLRnfGrfQe7CDPkG54ggPC6HzUv
	 Cx3FLV3XBwEmL/+Ffew7z/O8/L+GhYYrf3CCc+lvAKLmkyzQv4C0HXHx9O/tHftwKF
	 WpXmHPj4CnQTUXsQwkmTaHUoqB9lq9u8SF4u56Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfFANRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:17:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfFANRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:17:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8061827227;
        Sat,  1 Jun 2019 13:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395034;
        bh=scxhZynwZodEPPgyPa4Jy0luRfXCFIG9QxNi2wfXlKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMbyILE5MCNZMfK70LuvMQvHLVF/vFCMdvbovVxzUdGbm5sBADDhGn6X+BQLb5bt5
         /TQnh0lA/NO0AoI/xkUlpOTTicgTtAnau13b6jgFZtsLOm9azsSuO6e6G8zjJ2Qh8I
         CzOyBtXErF0WVDE6C8eebLtPnYgDGJFQIRAfBv68=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Masney <masneyb@onstation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 007/186] drm/msm: correct attempted NULL pointer dereference in debugfs
Date:   Sat,  1 Jun 2019 09:13:43 -0400
Message-Id: <20190601131653.24205-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Masney <masneyb@onstation.org>

[ Upstream commit 90f94660e53189755676543954101de78c26253b ]

msm_gem_describe() would attempt to dereference a NULL pointer via the
address space pointer when no IOMMU is present. Correct this by adding
the appropriate check.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Fixes: 575f0485508b ("drm/msm: Clean up and enhance the output of the 'gem' debugfs node")
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190513234105.7531-2-masneyb@onstation.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 18ca651ab942a..23de4d1b7b1ac 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -805,7 +805,8 @@ void msm_gem_describe(struct drm_gem_object *obj, struct seq_file *m)
 		seq_puts(m, "      vmas:");
 
 		list_for_each_entry(vma, &msm_obj->vmas, list)
-			seq_printf(m, " [%s: %08llx,%s,inuse=%d]", vma->aspace->name,
+			seq_printf(m, " [%s: %08llx,%s,inuse=%d]",
+				vma->aspace != NULL ? vma->aspace->name : NULL,
 				vma->iova, vma->mapped ? "mapped" : "unmapped",
 				vma->inuse);
 
-- 
2.20.1

