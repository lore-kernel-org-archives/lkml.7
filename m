Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0AC2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6897220828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oMWsgAD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLZJwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:52:44 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:36691 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:52:42 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id xBQ9pgNY023812;
        Thu, 26 Dec 2019 18:51:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com xBQ9pgNY023812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1577353904;
        bh=ZLGd9Sa7OALWrLmeWhKg0zq7ZvRRBITnevotAyP+VUY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMWsgAD7R/WJ2a2AIefVtYY9nZ9TdqVt884C1haeLpabCj7Fd2Xf4zuc3jhuQk30K
         yjjIxwdEdN2KbihzBeV7tl0m0LqoCaihEX/dETE7W/li8pQqaH85rnWM/s+ojNu2Xz
         203MHgdB5eUJBhu9KvHsOKMuWvmQ7KzJycDHx6Fzg7evPmc34l0qY1TdGdVdZvXCrF
         /aIGwh8lWfh1dMQyXw5GDKKywIecYr1hq+0y47ELlRUPnsV5Ty+IeHMdCDzOb0qgDp
         LZU34q1ozlbJdJvz++YtUNDTbHztD+AQXSZQ6cKTSxj0w0CkMes0JrI31FZaQCIb9s
         5syvPjmEpHsVA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/arm-smmu-v3: simplify parse_driver_options()
Date:   Thu, 26 Dec 2019 18:51:41 +0900
Message-Id: <20191226095141.30352-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226095141.30352-1-yamada.masahiro@socionext.com>
References: <20191226095141.30352-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using ARRAY_SIZE() instead of the sentinel is slightly simpler, IMHO.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/iommu/arm-smmu-v3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index ed9933960370..b27489b7f9d8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -676,7 +676,6 @@ struct arm_smmu_option_prop {
 static const struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
 	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium,cn9900-broken-page1-regspace"},
-	{ 0, NULL},
 };
 
 static inline void __iomem *arm_smmu_page1_fixup(unsigned long offset,
@@ -696,16 +695,16 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
-	int i = 0;
+	int i;
 
-	do {
+	for (i = 0; i < ARRAY_SIZE(arm_smmu_options); i++) {
 		if (of_property_read_bool(smmu->dev->of_node,
 						arm_smmu_options[i].prop)) {
 			smmu->options |= arm_smmu_options[i].opt;
 			dev_notice(smmu->dev, "option %s\n",
 				arm_smmu_options[i].prop);
 		}
-	} while (arm_smmu_options[++i].opt);
+	};
 }
 
 /* Low-level queue manipulation functions */
-- 
2.17.1

