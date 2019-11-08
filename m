Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979C9FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8DB21D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239687;
	bh=OKzxs6Vp36RleM3DGjN+gDcSlMvf+Optl6R2M+moc5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uu0VouIGd++WOt7lDRp5iA+2flwDDNIRLGaajN9BfsJTVqpTnonWENKO179/4Ktx9
	 gem1NK19TSxOsY3YXQHWjk+nd4gW+1xdiBRAHrVNP6iInyWh2O+8ji5NHY203Az2VM
	 ax+72HJbRNI/qGe3YkUsUrv459bfyBBO8bUMWOuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfKHTB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732355AbfKHTBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:01:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F77F21D7B;
        Fri,  8 Nov 2019 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239679;
        bh=OKzxs6Vp36RleM3DGjN+gDcSlMvf+Optl6R2M+moc5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kMLTX50sVXvEWmtfVHleZMEChJsYaiiLVpcAIhSeKLEgc9K7psSd5nqY+fI/dFrzA
         QBDhW+pk985SBTTEKC9E+1JISfiGAsl1h5WvpzjRNa8AXCfQ+aNnjFj7GVOZlNdqqO
         0aeYFpP4aNC4kPWOJDfUzkVfu9juhyJoPHk+VOS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/79] drm/amdgpu: fix potential VM faults
Date:   Fri,  8 Nov 2019 19:50:04 +0100
Message-Id: <20191108174759.515948589@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



