Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A6C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5690D2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 03:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508648;
	bh=k+gLLS6cAeBNJKlLzA4rmJovYWHIqXeTW9b7HIGfzp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYsGTx2CQ5HRkLRE7FFGr8oAtmMxjq0EsLvbex7agTkgvfJnemooNXKLZHtjxNzGL
	 e27CRMApx5k2z0V0sbmBSOIUpBmOz0JTdjQ7dXr0xxHoMBcGqvwIFZ88WJOSjjBz3R
	 TrUku0PtJkceDwLbJbQUN4ewTogrfFaF3ThUX1u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGSD51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 23:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727244AbfGSD5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 23:57:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064F52082E;
        Fri, 19 Jul 2019 03:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508643;
        bh=k+gLLS6cAeBNJKlLzA4rmJovYWHIqXeTW9b7HIGfzp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mpQBqDGHtNZ/WMSyYnaKAlFXWOfXCAI8dXegR4QNkSOsdY9qxW3PoujX3uUYhaBkD
         +TZakwWO2YiLhj1mUE0Kish9VjMF+HhZvTXoOIqUmtF1cMkKGtxxmfSdTrZCdQfK2F
         zBfar2AFbS1THFlzRbPC02/f0+NF4J2HovmZbY+0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sean Paul <seanpaul@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.2 016/171] drm/msm/a6xx: Check for ERR or NULL before iounmap
Date:   Thu, 18 Jul 2019 23:54:07 -0400
Message-Id: <20190719035643.14300-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Paul <seanpaul@chromium.org>

[ Upstream commit 5ca4a094ba7e1369363dcbcbde8baf06ddcdc2d1 ]

pdcptr and seqptr aren't necessarily valid, check them before trying to
unmap them.

Changes in v2:
- None

Cc: Jordan Crouse <jcrouse@codeaurora.org>
Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20190523171653.138678-3-sean@poorly.run
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 38e2cfa9cec7..418bb08bbed7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -504,8 +504,10 @@ static void a6xx_gmu_rpmh_init(struct a6xx_gmu *gmu)
 	wmb();
 
 err:
-	devm_iounmap(gmu->dev, pdcptr);
-	devm_iounmap(gmu->dev, seqptr);
+	if (!IS_ERR_OR_NULL(pdcptr))
+		devm_iounmap(gmu->dev, pdcptr);
+	if (!IS_ERR_OR_NULL(seqptr))
+		devm_iounmap(gmu->dev, seqptr);
 }
 
 /*
-- 
2.20.1

