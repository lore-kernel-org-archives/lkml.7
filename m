Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC264CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD8A20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572450923;
	bh=OKzxs6Vp36RleM3DGjN+gDcSlMvf+Optl6R2M+moc5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dmI/Ye9ni3IV+jqJJgFoBt24OkvnUk5WI5QbSMJq/MeBFNjx/guVL8nfUKgaZacAT
	 K6eTPg/h5tbmNXHXTBBdb79oFRq9E0GdxwPFyF/wtcQnniecP9hjCmhwiHDvewFixB
	 ndc+qKIYyfk4PRPDM+STFYykWn2A1a17CqV7rTDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfJ3PzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbfJ3PzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:55:18 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4117D20874;
        Wed, 30 Oct 2019 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572450917;
        bh=OKzxs6Vp36RleM3DGjN+gDcSlMvf+Optl6R2M+moc5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xw8Q+RdV34yn0nURa6PG7bdy2sp6YHCofNE3uUyTBjZ70QwLasbrvEMCr1sS/aGDM
         xJGotiQcYLG70d3XhwYtK5DofYU0rjUkRfF8jumIc7c/tXpMozjwxMRr+iCdo/tKf6
         MrRMD1h7OG+cx8nKmT5sRNOqwmwNWi7LyW7ftp+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 25/38] drm/amdgpu: fix potential VM faults
Date:   Wed, 30 Oct 2019 11:53:53 -0400
Message-Id: <20191030155406.10109-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155406.10109-1-sashal@kernel.org>
References: <20191030155406.10109-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 3122051edc7c27cc08534be730f4c7c180919b8a ]

When we allocate new page tables under memory
pressure we should not evict old ones.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b0e14a3d54efd..b14ce112703f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -428,7 +428,8 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 		.interruptible = (bp->type != ttm_bo_type_kernel),
 		.no_wait_gpu = false,
 		.resv = bp->resv,
-		.flags = TTM_OPT_FLAG_ALLOW_RES_EVICT
+		.flags = bp->type != ttm_bo_type_kernel ?
+			TTM_OPT_FLAG_ALLOW_RES_EVICT : 0
 	};
 	struct amdgpu_bo *bo;
 	unsigned long page_align, size = bp->size;
-- 
2.20.1

