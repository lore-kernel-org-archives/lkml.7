Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D6DC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63672214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994053;
	bh=pqEzLv81IrX0kqzgfw1hYmpQ73Vr7DSMGwdy294pxAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/ap0BOQ2f3e/FUWaX3WtIXuORdEatMTIlEZvKb58luD8WoaP+eS0JSHVCQ90rIDL
	 aZQP7Q0c5rLL6DP1mH0uc7uvnn53v3MFNbs3nxqGHPjgyhwmrUdPIxAgApQ3w40hOd
	 bUwhvyNbckylP0YTANbIisK133Xn4ShW5VUGpIfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfFHLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbfFHLkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:40:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF2E208C0;
        Sat,  8 Jun 2019 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994046;
        bh=pqEzLv81IrX0kqzgfw1hYmpQ73Vr7DSMGwdy294pxAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pkXmtASyqET0+vZiJXrjN2BiSx2piRr1e9iF4VIcCTYNPWucUhat0J8oWncLe9EtD
         RTI5+ObfVH43rKWJsm8icTF9iVLwejmOVfEXIzACECb4lzX+TgqOoVPmcVOiy+XNc0
         Pqf+Dycmp9slr/TkPR5fFLIyP24JdllvP/emjMtg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.1 36/70] drm/etnaviv: lock MMU while dumping core
Date:   Sat,  8 Jun 2019 07:39:15 -0400
Message-Id: <20190608113950.8033-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608113950.8033-1-sashal@kernel.org>
References: <20190608113950.8033-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 1396500d673bd027683a0609ff84dca7eb6ea2e7 ]

The devcoredump needs to operate on a stable state of the MMU while
it is writing the MMU state to the coredump. The missing lock
allowed both the userspace submit, as well as the GPU job finish
paths to mutate the MMU state while a coredump is under way.

Fixes: a8c21a5451d8 (drm/etnaviv: add initial etnaviv DRM driver)
Reported-by: David Jander <david@protonic.nl>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: David Jander <david@protonic.nl>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_dump.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_dump.c b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
index 33854c94cb85..515515ef24f9 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_dump.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
@@ -125,6 +125,8 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 		return;
 	etnaviv_dump_core = false;
 
+	mutex_lock(&gpu->mmu->lock);
+
 	mmu_size = etnaviv_iommu_dump_size(gpu->mmu);
 
 	/* We always dump registers, mmu, ring and end marker */
@@ -167,6 +169,7 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 	iter.start = __vmalloc(file_size, GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY,
 			       PAGE_KERNEL);
 	if (!iter.start) {
+		mutex_unlock(&gpu->mmu->lock);
 		dev_warn(gpu->dev, "failed to allocate devcoredump file\n");
 		return;
 	}
@@ -234,6 +237,8 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 					 obj->base.size);
 	}
 
+	mutex_unlock(&gpu->mmu->lock);
+
 	etnaviv_core_dump_header(&iter, ETDUMP_BUF_END, iter.data);
 
 	dev_coredumpv(gpu->dev, iter.start, iter.data - iter.start, GFP_KERNEL);
-- 
2.20.1

