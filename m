Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6833EC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 375BA276E4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 01:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="HO8KxWKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfFCBBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 21:01:35 -0400
Received: from onstation.org ([52.200.56.107]:57700 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbfFCBBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 21:01:35 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id BF7B03E915;
        Mon,  3 Jun 2019 01:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1559523694;
        bh=4MM1CQQTS49y5fDiBKAh42vrZ+Pf8egF6h5JW9RgQVA=;
        h=From:To:Cc:Subject:Date:From;
        b=HO8KxWKs9DywQfM1vvhUGimX6bCkiJiKL+F1eygfxD/riSC5yMnDKmhKJuKdw1ZFA
         u1Pndo/Qx/87U9FWyMXaD+CBoW+Jatmm1vFsW9OYtZKZQIatUH6x+TzNpSknW5JLxb
         IeNFo+7Zo119AfddpJMkyDwDv1Rx7nD8djCCDyPA=
From:   Brian Masney <masneyb@onstation.org>
To:     robdclark@gmail.com, sean@poorly.run
Cc:     airlied@linux.ie, daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm: correct attempted NULL pointer dereference in put_iova
Date:   Sun,  2 Jun 2019 21:01:31 -0400
Message-Id: <20190603010131.16773-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put_iova() would attempt to dereference a NULL pointer via the
address space pointer when no IOMMU is present. Correct this by adding
the appropriate check.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 35f55dd25994..d31d9f927887 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -352,8 +352,10 @@ put_iova(struct drm_gem_object *obj)
 	WARN_ON(!mutex_is_locked(&msm_obj->lock));
 
 	list_for_each_entry_safe(vma, tmp, &msm_obj->vmas, list) {
-		msm_gem_purge_vma(vma->aspace, vma);
-		msm_gem_close_vma(vma->aspace, vma);
+		if (vma->aspace) {
+			msm_gem_purge_vma(vma->aspace, vma);
+			msm_gem_close_vma(vma->aspace, vma);
+		}
 		del_vma(vma);
 	}
 }
-- 
2.20.1

