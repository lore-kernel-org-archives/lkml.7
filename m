Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB308C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F3020706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 08:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="LH5d5Xb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfLXIQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 03:16:06 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:61759 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLXIQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 03:16:03 -0500
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id xBO8F6tP002467;
        Tue, 24 Dec 2019 17:15:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com xBO8F6tP002467
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1577175313;
        bh=jKX8H24L9P/kDcEFr52nFIN6vZX1dw3qi1ILU0zzQ1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LH5d5Xb5XetelHCGw0KPciGf1DQ6qgz5oVGoCFofMdCnSzxQwCijuOMxa7tyy8Nae
         J8ya1rujKnF8/SQ4hvd9Ambys/TIe9W3GoOnvvjH1dNPRxx4KgLuZX662+Kxfx9pGu
         6ds95X3thYTUHLzGXLz9Pj3II036sln0SGiZZw84ZI87mGEq6glrS1ebEtSZrP1OlY
         e+d+TG8oVOFV49EzKMexbjYQZckYB2t92lbIuickAk52vdd8zLIn3jfhvse6zCQbgb
         +SYsgW6YMNFStKmpRhasFF4QBF7qRQ+ce9KCd2SYzQL/ipqJ8eOF4khF9Tk/rM25+4
         z7TBYuHiwL3+w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/arm-smmu: fix -Wunused-const-variable warning
Date:   Tue, 24 Dec 2019 17:15:00 +0900
Message-Id: <20191224081500.18628-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191224081500.18628-1-yamada.masahiro@socionext.com>
References: <20191224081500.18628-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ARCH=arm builds, OF is not necessarily enabled, that is, you can
build this driver without CONFIG_OF.

When CONFIG_OF is unset, of_match_ptr() is NULL, and arm_smmu_of_match
is left orphan.

Building it with W=1 emits a warning:

drivers/iommu/arm-smmu.c:1904:34: warning: ‘arm_smmu_of_match’ defined but not used [-Wunused-const-variable=]
 static const struct of_device_id arm_smmu_of_match[] = {
                                  ^~~~~~~~~~~~~~~~~

There are two ways to fix this:

 - annotate arm_smmu_of_match with __maybe_unused (or surround the
   code with #ifdef CONFIG_OF ... #endif)

 - stop using of_match_ptr()

This commit took the latter solution.

It slightly increases the object size, but it is probably not a big deal
because arm_smmu_device_dt_probe() is also compiled irrespective of
CONFIG_OF.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/iommu/arm-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 4f1a350d9529..0446a3bf6bd0 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2267,7 +2267,7 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
 		.name			= "arm-smmu",
-		.of_match_table		= of_match_ptr(arm_smmu_of_match),
+		.of_match_table		= arm_smmu_of_match,
 		.pm			= &arm_smmu_pm_ops,
 		.suppress_bind_attrs	= true,
 	},
-- 
2.17.1

