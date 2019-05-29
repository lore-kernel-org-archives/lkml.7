Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713BAC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41047241BE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ep2pnSl2";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nYHYkyZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfE2Uzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:55:38 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57702 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfE2Uzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:55:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8AD72616FE; Wed, 29 May 2019 20:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163334;
        bh=YbD1o3QTKsJc4Zlft7yYAtBneOymuecIq+BLGIcWNb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ep2pnSl2ZoaT6WMCGII3T905YRQ401enAsz1ZMEeGvgla8cWuRUr5cjtxMM7Rxvq9
         A4T4wQXhEr666vbzOh4M2SRFbqnBlzlY4mhDYf0w17cNoBDB+ZPZ8JfnPQl0hB62pY
         FBnI9wr+wc6SGvrQQcH4bgAK7NpApHYW++no8irw=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4616616B8;
        Wed, 29 May 2019 20:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559163329;
        bh=YbD1o3QTKsJc4Zlft7yYAtBneOymuecIq+BLGIcWNb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYHYkyZJa+Lai5q8jqcgeBcDrEj6cQB62keJdOHVhbcNkhiNKBKQEn4nVWpyDFsui
         jsPKrwoJ57vFozh20pqRBWWpA9JbdrhdyZ8yqz+GPvvyQHnNA8qH5xmFUepULKgJWn
         9XoPVBQKH3+h3Q8AT9R+CYggtVxjMUwIfmoarMy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4616616B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     jean-philippe.brucker@arm.com, linux-arm-msm@vger.kernel.org,
        hoegsberg@google.com, dianders@chromium.org,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 08/16] drm/msm: Print all 64 bits of the faulting IOMMU address
Date:   Wed, 29 May 2019 14:54:44 -0600
Message-Id: <1559163292-4792-9-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
References: <1559163292-4792-1-git-send-email-jcrouse@codeaurora.org>
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

