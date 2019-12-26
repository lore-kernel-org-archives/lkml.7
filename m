Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3FBC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DA62080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sQKn9VfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfLZJv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:51:57 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:32975 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfLZJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:51:57 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id xBQ9owph023896;
        Thu, 26 Dec 2019 18:50:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com xBQ9owph023896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1577353859;
        bh=NhUagKKjH1a+HNNxh90mRJCDlPp2AH9R9coPb0ehMDo=;
        h=From:To:Cc:Subject:Date:From;
        b=sQKn9VfBXtp3Wxh+M4b0yfgWfx/dlWKr4ftTQnJKm5YVElGOQPbAa5TqibegXpMGI
         molTYuHv+JNa/Kawe+PsWljhzyRbE/fS8souFOI0UCIPwvL4qPGYGjtIAu7wn0jywI
         zUYem3YY0FuMc5NDk4MYRtaVewslii2O7x8HH5XmUYqfi/YGJLbaK3EgGiSmPhu8tb
         IGlpkG3YavBEnrxdn2qfszs89QVjRnuSCjo6EZ6fxhs5D5CI4+WDZfGbKgOK5oDYed
         8uxWd91lcgBgJt3ay12uZl0UQ/tH6AoGFR6n7gO01+Nb1f2ejee7RftuXPt6xqJg4v
         eHf2aL+Nh31tA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/arm-smmu-v3: fix resource_size check
Date:   Thu, 26 Dec 2019 18:50:56 +0900
Message-Id: <20191226095056.30256-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an off-by-one mistake.

resource_size() returns res->end - res->start + 1.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index d9e0d9c19b4f..b463599559d2 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3599,7 +3599,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 
 	/* Base address */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (resource_size(res) + 1 < arm_smmu_resource_size(smmu)) {
+	if (resource_size(res) < arm_smmu_resource_size(smmu)) {
 		dev_err(dev, "MMIO region too small (%pr)\n", res);
 		return -EINVAL;
 	}
-- 
2.17.1

