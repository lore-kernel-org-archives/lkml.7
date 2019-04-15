Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2336C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41AC20818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356367;
	bh=GmMeTWL6zzAz/YDdIDycDCUTqM0lVieesu7BK+dA4oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TE8YfWZ9qaq9jwWFjrfmcaigkWXL0EUDpOmu4jkDjasF6HnwbKHPJYvfxlgmbr6Ei
	 k2UXp+qs6hO+8xMOkP3xKmtAGE7/GY7GwKu1qqpChZPjhLkD+su1JPKZB74ieXQf/O
	 16hvxQ5bk2BnmmJ67OjjeWsr1stI5mkJ8y/fGh28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbfDOT0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729091AbfDOTE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DEAD218D3;
        Mon, 15 Apr 2019 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355097;
        bh=GmMeTWL6zzAz/YDdIDycDCUTqM0lVieesu7BK+dA4oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zEih1oFyvOlQbiBfGTu4Xzrw38QP1vlCrLQYp8pljATwRJhrmu3IrIEMgYG9FloPp
         kS+Y1p3Xg44iUV1niVsEX3YjLqPkJwl4wM3K1hhXM0SwpT4gvQQqukgQzSO/GM9hzE
         SKwuJ4hhczsU+Nx8mW2w/xsh8gW2mVofl5UXAMOM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhenyuw@linux.intel.com,
        Yan Zhao <yan.y.zhao@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/101] drm/i915/gvt: do not let pin count of shadow mm go negative
Date:   Mon, 15 Apr 2019 20:58:00 +0200
Message-Id: <20190415183740.470704316@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
index 00aad8164dec..542f31ce108f 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1940,7 +1940,7 @@ void _intel_vgpu_mm_release(struct kref *mm_ref)
  */
 void intel_vgpu_unpin_mm(struct intel_vgpu_mm *mm)
 {
-	atomic_dec(&mm->pincount);
+	atomic_dec_if_positive(&mm->pincount);
 }
 
 /**
-- 
2.19.1



