Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54380C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184382053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920545;
	bh=clui04QC4t4n0r//6FAgmXuRtDJsSv/oVvcDZ/NpBYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XfMX+TUIrd8v/1mQDnEwWFlaGIPikaDMsmSit9WhBIXHGP95zRdckBGuGUJuFBsd8
	 DTUaaTpi+N9rbjsz9L5eLky1daC0i/hTadd7SPj6QHal0sZLkeAw24e6NHGssD1Lc7
	 n5Buy06iSpFgVEdH9QNc3ng911VH92ECz8R4MZco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfEOLmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:42:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfEOL2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:28:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0507F20881;
        Wed, 15 May 2019 11:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557919691;
        bh=clui04QC4t4n0r//6FAgmXuRtDJsSv/oVvcDZ/NpBYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEg98YSQ3qR92SdS9BNQ7lsehbbaXJwzVaXg7bxb3y70+IxCKY3QGBWP9I4I36k/a
         jn9N4/rBPODeY3EqWX6WIB7XmMxNm/0NEHAHlzva6WCelJac7r9qTLd1/s4nTi3vHT
         jP528tCtKXxyzqy/w6lprAvnKdRyWgDcphXd3LUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Yi <teroincn@163.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 030/137] drm/ttm: fix dma_fence refcount imbalance on error path
Date:   Wed, 15 May 2019 12:55:11 +0200
Message-Id: <20190515090655.492579941@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090651.633556783@linuxfoundation.org>
References: <20190515090651.633556783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 543c364d8eeeb42c0edfaac9764f4e9f3d777ec1 ]

the ttm_bo_add_move_fence takes a reference to the struct dma_fence, but
failed to release it on the error path, leading to a memory leak.
add dma_fence_put before return when error occur.

Signed-off-by: Lin Yi <teroincn@163.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 996cadd83f244..d8e1b3f129046 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -881,8 +881,10 @@ static int ttm_bo_add_move_fence(struct ttm_buffer_object *bo,
 		reservation_object_add_shared_fence(bo->resv, fence);
 
 		ret = reservation_object_reserve_shared(bo->resv, 1);
-		if (unlikely(ret))
+		if (unlikely(ret)) {
+			dma_fence_put(fence);
 			return ret;
+		}
 
 		dma_fence_put(bo->moving);
 		bo->moving = fence;
-- 
2.20.1



