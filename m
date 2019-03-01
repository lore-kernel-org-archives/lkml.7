Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA275C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B0520838
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GKimwz6y";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jMha91ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfCATjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:39:07 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCATjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:39:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 706CA618CE; Fri,  1 Mar 2019 19:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469139;
        bh=YbD1o3QTKsJc4Zlft7yYAtBneOymuecIq+BLGIcWNb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKimwz6yZWnbhr03410wjR4QBiyQv55BRPq+asK/ZjqvozPCoRV3ANP4uxqbKae6J
         iXinci/SCBNlIU2BAEaHLPzK+VhunbQx43BvxauQ/iiIUilCDLUBgEIBV2npbboA6T
         EHLDmsfVCDgOQ/PM57pffoUijbC6wQtnGm9H3hDs=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE37B6155F;
        Fri,  1 Mar 2019 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551469133;
        bh=YbD1o3QTKsJc4Zlft7yYAtBneOymuecIq+BLGIcWNb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jMha91ayzW6yvovYZP4gY4++Z9fRUhd/7Jgxwk9WeIjkCMtHPh161NsZie7HTdukq
         bgs9ZoZBbSSe7TR410QnexN+zB4CM5bTX1MgW0D5yR4RaUvkNE87Z3qKMgKrU+qy0x
         2QiA2+MExg0SMFV7J1kAyBrjpIufDGEzlV1hKItc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE37B6155F
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
Subject: [RFC PATCH v1 07/15] drm/msm: Print all 64 bits of the faulting IOMMU address
Date:   Fri,  1 Mar 2019 12:38:29 -0700
Message-Id: <1551469117-3404-8-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
References: <1551469117-3404-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we move to 64 bit addressing for a5xx and a6xx targets we will start
seeing pagefaults at larger addresses so format them appropriately in the
log message for easier debugging.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 12bb54c..1926329 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -30,7 +30,7 @@ static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
 	struct msm_iommu *iommu = arg;
 	if (iommu->base.handler)
 		return iommu->base.handler(iommu->base.arg, iova, flags);
-	pr_warn_ratelimited("*** fault: iova=%08lx, flags=%d\n", iova, flags);
+	pr_warn_ratelimited("*** fault: iova=%16lx, flags=%d\n", iova, flags);
 	return 0;
 }
 
-- 
2.7.4

