Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D19C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01ED8206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240010;
	bh=RoOwuTEoleM5cqE4Jh826MjpsBVUMzm5KeiWX26H0Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Sj0gF7pSpAwC0SBamhYFlE3JYuSXJP1pPQxsg95dYOuSrOMEbNwCMY7VXhq5xOBj
	 ASFxiXwqd0HiqLFru8FTk5wLm5yH7pZRZl/geu7UV9fTheewBKb1rFjqgr1AESY4jV
	 0gMpTkBMKCB1eUgtd7D5klzRjsVgO70cPZi8QAHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391346AbfKHTGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:06:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733176AbfKHTGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:06:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FA320673;
        Fri,  8 Nov 2019 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240005;
        bh=RoOwuTEoleM5cqE4Jh826MjpsBVUMzm5KeiWX26H0Vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7p25BBWs3WMN27yLIpsy3CTSCoTxFZ8nm7Oli/555NlK81vmvi6ZnMMmaucuxmGu
         6MAkRyGORsUEES0nNKr75DxHNhee8KUMAsk+FHJJoIk8SyD520IPBcxBAsADpFJsoo
         Xg5fPs1ZR1+IOjvKPAlpTEDjGzNSlwxXdNv2plG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 055/140] drm/amdgpu: fix error handling in amdgpu_bo_list_create
Date:   Fri,  8 Nov 2019 19:49:43 +0100
Message-Id: <20191108174908.790526222@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit de51a5019ff32960218da8fd899fa3f361b031e9 ]

We need to drop normal and userptr BOs separately.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 61e38e43ad1d5..85b0515c0fdcf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -140,7 +140,12 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 	return 0;
 
 error_free:
-	while (i--) {
+	for (i = 0; i < last_entry; ++i) {
+		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(array[i].tv.bo);
+
+		amdgpu_bo_unref(&bo);
+	}
+	for (i = first_userptr; i < num_entries; ++i) {
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(array[i].tv.bo);
 
 		amdgpu_bo_unref(&bo);
-- 
2.20.1



