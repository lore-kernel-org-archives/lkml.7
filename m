Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BC8C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E9A21530
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559994220;
	bh=U43gp4ER5JVDxFLFOVHwt1cW9WDip0sBv7jyk0GXFHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q911etk3EAM0NW1TwRBNDMgUhow7v64UDoCoDIubAlOcFaPM3GyKIU9qnpPhyzBot
	 TqjAbbxVmsZqlgvqE7dfUHSSipu7mp+nNPmwRPr5LDEN5XNHPsJheaOkaKOLEUxyaJ
	 OAKcp4vUD8uRn8tjKrJaJh1UuOc537smH10bIcMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfFHLnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 07:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbfFHLnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 07:43:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36AB8214C6;
        Sat,  8 Jun 2019 11:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559994211;
        bh=U43gp4ER5JVDxFLFOVHwt1cW9WDip0sBv7jyk0GXFHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfbbcTZ+4yW8Nu2DT260Aweck9rGJoK1IA0oWNLZ+S7XZbmJA58NGbjz+DFIKLiAz
         nj6dxtKxXffGLX6RBNriig+yGrVoW2WYQpbdJKiiSVkoeLJ7aaXx3NRmBbIXm4AmKU
         afSUdBQpP33Nns2ue4ZT/Z4IHCMf23bxiJ1eEYX8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 23/49] drm/etnaviv: lock MMU while dumping core
Date:   Sat,  8 Jun 2019 07:42:04 -0400
Message-Id: <20190608114232.8731-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190608114232.8731-1-sashal@kernel.org>
References: <20190608114232.8731-1-sashal@kernel.org>
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
index 9146e30e24a6..468dff2f7904 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_dump.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_dump.c
@@ -124,6 +124,8 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 		return;
 	etnaviv_dump_core = false;
 
+	mutex_lock(&gpu->mmu->lock);
+
 	mmu_size = etnaviv_iommu_dump_size(gpu->mmu);
 
 	/* We always dump registers, mmu, ring and end marker */
@@ -166,6 +168,7 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 	iter.start = __vmalloc(file_size, GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY,
 			       PAGE_KERNEL);
 	if (!iter.start) {
+		mutex_unlock(&gpu->mmu->lock);
 		dev_warn(gpu->dev, "failed to allocate devcoredump file\n");
 		return;
 	}
@@ -233,6 +236,8 @@ void etnaviv_core_dump(struct etnaviv_gpu *gpu)
 					 obj->base.size);
 	}
 
+	mutex_unlock(&gpu->mmu->lock);
+
 	etnaviv_core_dump_header(&iter, ETDUMP_BUF_END, iter.data);
 
 	dev_coredumpv(gpu->dev, iter.start, iter.data - iter.start, GFP_KERNEL);
-- 
2.20.1

