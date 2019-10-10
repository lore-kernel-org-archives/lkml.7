Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4710DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C4721A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696932;
	bh=WtMBOunqzYjl4jozG6r1PE63VrycBMI8XpYf9CAn4oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bNkSQpXVwaLq5Nk5GSxn7uWHvlZhuAgpkq6SrTJTkRw0d9KXtdI1a1qfqzPhlw5F4
	 8ZEgvkZbGS5p/a3MlNma710/cKbONni6cn4yOcf5V649qGzn2b2nINlIFpo6hNa4Wr
	 cXhnA5xXIPOuIrOJIW5dIcAGNIvC9iszmo+21aHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbfJJImL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388481AbfJJImI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:42:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D25A721A4C;
        Thu, 10 Oct 2019 08:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696928;
        bh=WtMBOunqzYjl4jozG6r1PE63VrycBMI8XpYf9CAn4oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUY3j8Mzm+Xc3kO/xDGJadtj6RzS193Mjj/y/UREr75eacxEoSGKw5iQDByM9v3X0
         VGzrwvwBUeViOMSX+dBt4kMszXiAOYooDyznQTUmDy3ApSxaeCrTzLigDSmWAxkd9K
         WkWy9co/ASMmkEf2pemdVmZOIWW80bbnKoYjlfhc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 104/148] drm/amdgpu: Fix KFD-related kernel oops on Hawaii
Date:   Thu, 10 Oct 2019 10:36:05 +0200
Message-Id: <20191010083617.506295681@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit dcafbd50f2e4d5cc964aae409fb5691b743fba23 ]

Hawaii needs to flush caches explicitly, submitting an IB in a user
VMID from kernel mode. There is no s_fence in this case.

Fixes: eb3961a57424 ("drm/amdgpu: remove fence context from the job")
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 7850084a05e3a..60655834d6498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -143,7 +143,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	/* ring tests don't use a job */
 	if (job) {
 		vm = job->vm;
-		fence_ctx = job->base.s_fence->scheduled.context;
+		fence_ctx = job->base.s_fence ?
+			job->base.s_fence->scheduled.context : 0;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
-- 
2.20.1



