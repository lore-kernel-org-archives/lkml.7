Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79267C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDFF217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kKPZdrAq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JM4EA0/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfEUQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:14:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59350 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfEUQOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:14:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 751FA619CA; Tue, 21 May 2019 16:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558455274;
        bh=YbD1o3QTKsJc4Zlft7yYAtBneOymuecIq+BLGIcWNb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kKPZdrAqJmlZvaVhQ6Me30jU7MO8nOnanBwUJOrSMWKLAgTpJuZys3g/M/DHonbm4
         /2o5SSrELq/hxeHrgZkue2TldDek30Nz6TL6uohmJUCgY2TlC2WafpmLMCkesFVq2S
         qdcsfkNEddkw0B6O8guQuKv93f6jUlgxqb17Efgw=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 30005619D2;
        Tue, 21 May 2019 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558455260;
        bh=YbD1o3QTKsJc4Zlft7yYAtBneOymuecIq+BLGIcWNb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JM4EA0/sfmgBdsC6/u3ydjtQaQ+JZNWnGxG2o5O9a/U2I25Qk/cIWl41NsrZvN2/2
         J4shy7CVsdKYc+y/2AwdXOQLcEewIeDt+K6vpyjbVDoyfrAjoZR8+CI/F3JmMcALDT
         wUMmeV0i+V3BSC26JRRXx6QDODGCWDg3xgOJCElA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 30005619D2
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
Subject: [PATCH v2 07/15] drm/msm: Print all 64 bits of the faulting IOMMU address
Date:   Tue, 21 May 2019 10:13:55 -0600
Message-Id: <1558455243-32746-8-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558455243-32746-1-git-send-email-jcrouse@codeaurora.org>
References: <1558455243-32746-1-git-send-email-jcrouse@codeaurora.org>
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

