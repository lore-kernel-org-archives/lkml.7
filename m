Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E39AC3A59E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A71230F2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 19:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HeS8sMre";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IgFkJdL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbfHTTHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 15:07:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45276 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfHTTGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 15:06:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B0966119C; Tue, 20 Aug 2019 19:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328005;
        bh=OnE1CRltdThiSh478OmHpFjhtqzYCN7pRfxgwT3K5Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HeS8sMref/+ssQuI8XKgdSUPE/lc2QUEubZb0mkXRM9+Erf+SKsl4ILGC5e7kyZO6
         svXOEbje5jb9Ov7RscFqD2eQoc6Bwakz2EJj8tXrqiWzXneqi3v99ax5RxSBkSyzKn
         mixQis2IHu3y6kxYRKD8PmRgW9UesE+ELfAixDxY=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A27D66115D;
        Tue, 20 Aug 2019 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566328004;
        bh=OnE1CRltdThiSh478OmHpFjhtqzYCN7pRfxgwT3K5Vs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgFkJdL0ALFRYYrWGproQZN4BP4rNXrgT0RY8B79h72JQ+sULJ6FfqUF2RNG/gX/3
         lllx+JQXaHzpnVfSVyZoXp6rbwz+5Bkr8/no/PrqNpNATtAVCy9GOcBIdfhyy2GlV2
         Lq/pB9YInwIuZoDUHMrwosVAtDV50gJYZn9CQ3jM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A27D66115D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/7] iommu/arm-smmu: Support DOMAIN_ATTR_SPLIT_TABLES
Date:   Tue, 20 Aug 2019 13:06:30 -0600
Message-Id: <1566327992-362-6-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
References: <1566327992-362-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the DOMAIN_ATTR_SPLIT_TABLES attribute to let the leaf driver
know if split pagetables are enabled for the domain.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 3f41cf7..6a512ff 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1442,6 +1442,9 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_NESTING:
 			*(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
 			return 0;
+		case DOMAIN_ATTR_SPLIT_TABLES:
+			*(int *)data = !!(smmu_domain->split_pagetables);
+			return 0;
 		default:
 			return -ENODEV;
 		}
-- 
2.7.4

