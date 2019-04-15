Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD55C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FC721900
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354924;
	bh=SXUxFNZnUslD8JfWuQMUnvk0n8/vG+XfcL6nCQfcYq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zz6pUyDAKUEGo7Xct6pQ1tVigHSsDOQoKiBGinW0EaJ9hHS7ets/eP4VsLO/fBfY6
	 ZLJyHj6UE1oxuhrn1LgYoV/utlBMaYL3OWcshxsezA6Evng2cnPh+AeEdMAbyIvk7Q
	 DkuX8aq4PyDKZNUoID6o4lrtb9d8JNnEmy5YPLYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfDOTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfDOTCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB0E20880;
        Mon, 15 Apr 2019 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354919;
        bh=SXUxFNZnUslD8JfWuQMUnvk0n8/vG+XfcL6nCQfcYq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4W/fX1oQutoG5UQqRtvo/hPq9m8eLs+vsAEpoLKFOIEEkUwLOXta9xZcYtboKNEM
         B4hcr/7uKp7z6CTEv5s6me5j2xb42RsNFE9QCGBndlbqe1y9Qq5LoUIQnHdgedYZeb
         vUqebJeaE3TEqDo5cUkKA32gKfgeKASBR4Y0+JQE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhenyuw@linux.intel.com,
        Yan Zhao <yan.y.zhao@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 06/69] drm/i915/gvt: do not let pin count of shadow mm go negative
Date:   Mon, 15 Apr 2019 20:58:24 +0200
Message-Id: <20190415183727.932389730@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 663a50ceac75c2208d2ad95365bc8382fd42f44d ]

shadow mm's pin count got increased in workload preparation phase, which
is after workload scanning.
it will get decreased in complete_current_workload() anyway after
workload completion.
Sometimes, if a workload meets a scanning error, its shadow mm pin count
will not get increased but will get decreased in the end.
This patch lets shadow mm's pin count not go below 0.

Fixes: 2707e4446688 ("drm/i915/gvt: vGPU graphics memory virtualization")
Cc: zhenyuw@linux.intel.com
Cc: stable@vger.kernel.org #4.14+
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index dadacbe558ab..1a1f7eb46d1e 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1629,7 +1629,7 @@ void intel_vgpu_unpin_mm(struct intel_vgpu_mm *mm)
 	if (WARN_ON(mm->type != INTEL_GVT_MM_PPGTT))
 		return;
 
-	atomic_dec(&mm->pincount);
+	atomic_dec_if_positive(&mm->pincount);
 }
 
 /**
-- 
2.19.1



