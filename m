Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074CCC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0A520651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356072;
	bh=dtcKUmUiz6wH42emtrQfgHVz5Km99gjrHJIYeaZ3Ky4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ibCaHsR9bEqQYHCTtoYrBP9tlrwAUrJEHKbOQbRZdEU63t18Il99iJ0OxjPX9mjFK
	 MGp+8frTnQ2ERjYnQCB3ukumKytv/nieq2HPw8ZQYYVH1w9esTS1M8bnrCpUCbO/o4
	 0f2mXygt2tmwp4eW6EttGkhdYWcBXp5QMj9cxZ8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfDOTVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730737AbfDOTJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8287620880;
        Mon, 15 Apr 2019 19:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355369;
        bh=dtcKUmUiz6wH42emtrQfgHVz5Km99gjrHJIYeaZ3Ky4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF87wKIpLRXz+GERfbGG6qNNmB9V+vBdiOear/2qmgMq3sMKMyhdoleMdSqNYZBbT
         XFx/FAVAvTzMCCY0A/oLNhitpumkElU8xgYfyoiRXaWQiwr3+go8+YpWn9oJGUDBuj
         QI08BxVaaB7OhCWadKuiq4DVwIOZ7xU4mfxu7unE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhenyuw@linux.intel.com,
        Yan Zhao <yan.y.zhao@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 001/117] drm/i915/gvt: do not let pin count of shadow mm go negative
Date:   Mon, 15 Apr 2019 20:59:31 +0200
Message-Id: <20190415183744.960396527@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
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
index c7103dd2d8d5..563ab8590061 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1942,7 +1942,7 @@ void _intel_vgpu_mm_release(struct kref *mm_ref)
  */
 void intel_vgpu_unpin_mm(struct intel_vgpu_mm *mm)
 {
-	atomic_dec(&mm->pincount);
+	atomic_dec_if_positive(&mm->pincount);
 }
 
 /**
-- 
2.19.1



