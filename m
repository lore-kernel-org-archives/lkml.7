Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A93AC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EA62084D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AArUVrkF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KWM0EjSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfCATjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:39:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43246 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfCATju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:39:50 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4EBBE61573; Fri,  1 Mar 2019 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469189;
        bh=Q7ZQd878jM/ppuJ4uNWWJeXdoWzwLS/xcQibVXy6ISg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AArUVrkFKvjHkX1FXD9EEVLAV7L5Ao0N+o3bXy8IZFCv6gpWnxJmB03/tnwYFNUYN
         QEmRR5FSGU2nRgeLIDwBOxTPPZmqPiSqfSRt080nnRIDLw4GrZfWDZ1YM1F6K8QZrm
         skBKQbSTEVEV46F6xo8vNQTSLZBKFqMp4r60IBwg=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27F5C6194F;
        Fri,  1 Mar 2019 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469143;
        bh=Q7ZQd878jM/ppuJ4uNWWJeXdoWzwLS/xcQibVXy6ISg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KWM0EjSK6HduFQocjxtBZDfAOqvWtyhwQMoulmMM9c6erKocfX9dVH0ua9CeOk4LG
         HIx7XfKcyM2IqpxWkHjRk5lmOXPMexPeL+UhXaxM4Wrvt6IJmGKwHEhxPI7IXaoc/H
         dyug1w2GCd0cpjJszOAe0e4TG4A/3+N6o3sQS/A0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27F5C6194F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        dianders@chromimum.org, hoegsberg@google.com,
        baolu.lu@linux.intel.com, Sean Paul <sean@poorly.run>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [RFC PATCH v1 13/15] drm/msm/gpu: Add ttbr0 to the memptrs
Date:   Fri,  1 Mar 2019 12:38:35 -0700
Message-Id: <1551469117-3404-14-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Targets that support per-instance pagetable switching will have to keep
track of which pagetable belongs to each instance to be able to recover
for preemption.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_ringbuffer.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 6434ebb..493fa89 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -40,6 +40,7 @@ struct msm_gpu_submit_stats {
 struct msm_rbmemptrs {
 	volatile uint32_t rptr;
 	volatile uint32_t fence;
+	volatile uint64_t ttbr0;
 
 	volatile struct msm_gpu_submit_stats stats[MSM_GPU_SUBMIT_STATS_COUNT];
 };
-- 
2.7.4

