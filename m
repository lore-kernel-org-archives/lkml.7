Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD108C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D812341F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493744;
	bh=0/I9yaWwLfbVKWZtR4EeIsv5AWU4gyl+tYZMLtkaT/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gc1o3TtlOAwKzMiNxcAmbgA++Mnajk6nt9hTHmTMH7ivlaPV9lIHzXFHB0YErroQO
	 SIv89BBGD0SP2Ir3HWhC79ptHjauSK4E0VMAt4Zcpo9LkpmVDGYKwG+xcDIqRC3E78
	 iF+ArhptyhjhxuBZJLN7oIXty3crtoPeergitCiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbfHVRJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390603AbfHVRI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:08:59 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBD0223404;
        Thu, 22 Aug 2019 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493739;
        bh=0/I9yaWwLfbVKWZtR4EeIsv5AWU4gyl+tYZMLtkaT/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eh/T2zu4SsSPhJkCBuz6UiNEY3rNnaOdYE4LxDVjt5SZp76DGvwU7zC17/FtImI5z
         bdBffyGuJA9fGDN9ZeseGpznp8OfB/dN4h2jAg6TzaneRCHuI4PN+ZNQxUA3+0hvjt
         SOpXNnNgED0b8i6OIwpo6PEXJ45pajWlYlqGQCBE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 083/135] drm/exynos: fix missing decrement of retry counter
Date:   Thu, 22 Aug 2019 13:07:19 -0400
Message-Id: <20190822170811.13303-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 1bbbab097a05276e312dd2462791d32b21ceb1ee ]

Currently the retry counter is not being decremented, leading to a
potential infinite spin if the scalar_reads don't change state.

Addresses-Coverity: ("Infinite loop")
Fixes: 280e54c9f614 ("drm/exynos: scaler: Reset hardware before starting the operation")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_scaler.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index ec9c1b7d31033..8989f8af716b7 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -94,12 +94,12 @@ static inline int scaler_reset(struct scaler_context *scaler)
 	scaler_write(SCALER_CFG_SOFT_RESET, SCALER_CFG);
 	do {
 		cpu_relax();
-	} while (retry > 1 &&
+	} while (--retry > 1 &&
 		 scaler_read(SCALER_CFG) & SCALER_CFG_SOFT_RESET);
 	do {
 		cpu_relax();
 		scaler_write(1, SCALER_INT_EN);
-	} while (retry > 0 && scaler_read(SCALER_INT_EN) != 1);
+	} while (--retry > 0 && scaler_read(SCALER_INT_EN) != 1);
 
 	return retry ? 0 : -EIO;
 }
-- 
2.20.1

