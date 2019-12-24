Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E06C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CE120643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="w1D1o9lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfLXIQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 03:16:03 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:61760 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfLXIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:16:02 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id xBO8F6tO002467;
        Tue, 24 Dec 2019 17:15:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xBO8F6tO002467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1577175308;
        bh=NbmBvDtMJ9z3Td8I6VubahSRd9ne5gs2UkZ7H3zze/8=;
        h=From:To:Cc:Subject:Date:From;
        b=w1D1o9lLd17YUs9iR6sMAJ70Ko/YIzdjEGoKti9JQCdALk56d5wqxG1STTEJUkUeV
         OvRF13UWwZZf8xS6CXgiOg+/jwFaX01jDqcRYaZegKpO4OalJyND/FAalfnQPVDv2y
         7v5hvfSt6B2jVx2SdXBZ6WSY8dfCN9QcFYrNyG+6SK20UV82gTdius2NerU2XrkCH8
         dDi6g/PE0uyrpptvh/YijOR5bixz6F6b9gVRbHQ3y5Awhsp856QkkWkfWZl+jMtVGP
         hT2nXixKIw+I0oY/lXK0tAZgkn8cwzuD1Ak07HI0atUmHZDT3a/mEkh27vroNROc9Z
         TbrVy0Ofau6Sg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/arm-smmu-v3: remove useless of_match_ptr()
Date:   Tue, 24 Dec 2019 17:14:59 +0900
Message-Id: <20191224081500.18628-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG option controlling this driver, ARM_SMMU_V3,
depends on ARM64, which select's OF.

So, CONFIG_OF is always defined when building this driver.
of_match_ptr(arm_smmu_of_match) is the same as arm_smmu_of_match.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index effe72eb89e7..d9e0d9c19b4f 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -3698,7 +3698,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name		= "arm-smmu-v3",
-		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.of_match_table	= arm_smmu_of_match,
 		.suppress_bind_attrs = true,
 	},
 	.probe	= arm_smmu_device_probe,
-- 
2.17.1

