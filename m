Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78054C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F7E20842
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 22:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs0pketZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCFWxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 17:53:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45096 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfCFWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 17:53:08 -0500
Received: by mail-lj1-f194.google.com with SMTP id d24so12420054ljc.12;
        Wed, 06 Mar 2019 14:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tVU/OeoqMr+PZYKr0GcwSg6aU4eH1Ge3wbhogIE2Vw=;
        b=hs0pketZ4EM8d6oq+QMgeo6iNqiSQOat3KGtNW+rw+WWM6mWK1seKiN5CK+CqiHyg4
         cTG/ngr4K5www2OH9kXo7hyUShAQ44nTIoRyWPdoHxAuKI16lQrlYH7K2vMJk4fCHWft
         3sSgSOyqGg9EQ5Tp7fwvsYgt7+TW22hOKeCBS+42+FLwjxhcN5b0dZfjQJmBH2L0s5zB
         upR6TKqPkGipb7UCvGk3N6zbrAs1vN9EPm2zwdCYqkvQHt3sVQNMLBJh0M6i3wWja4Kz
         i7X61j4P3ztNUquNt2XWpjodaFQmdwbtAxlxOhfzHEElKoUWuChX2G3mpc4r6msi/n2b
         D/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tVU/OeoqMr+PZYKr0GcwSg6aU4eH1Ge3wbhogIE2Vw=;
        b=JTfXsQbn28vOkBc1V/C4a5V6cKhh3mwfgdiLieHR4eHOachC4NuTzuzKjVrMKxoclQ
         dOProbGuWicDYFUxppqDUeB1AD9IyPk/zUVN8JxKhKbIDBEzDpWB9aMCi4TvUVupj9BP
         gYb0PKekVsiMit233O50M1m/2uxH6W6fueZlB5X2PAUHjsl64OiJK7uEsj9bjC/yubcE
         2s1bsy7yilzsF24eja0MDgUnjhienOTgolGDzA8fUouC7c92nPp/covM/M4gTL3fvdJP
         r7RBo3cxY1/NLprlAQAGrAyPYXnpeQz32Igsse/OESJq9U1w6QXTWZiSe5G5oSulVq8/
         oH3Q==
X-Gm-Message-State: APjAAAXBkSHwmZq2AinZ21/zxwtfm1UDEphMF0gvQA/cVsoB4SJBwZi6
        aFAAAItMySwO94k3EL2BiZk=
X-Google-Smtp-Source: APXvYqxuqRjHPJBp7zeadIzpUq6QlL1D+/kCFDfl3ncQHhUgR7Gmfy0xseCqyL9HgRoUE8f4p4wrKA==
X-Received: by 2002:a2e:80cd:: with SMTP id r13mr3827561ljg.34.1551912786281;
        Wed, 06 Mar 2019 14:53:06 -0800 (PST)
Received: from localhost.localdomain (ppp94-29-37-86.pppoe.spdop.ru. [94.29.37.86])
        by smtp.gmail.com with ESMTPSA id x18sm536961ljc.67.2019.03.06.14.53.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 14:53:05 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] iommu/tegra-smmu: Fix invalid ASID bits on Tegra30/114
Date:   Thu,  7 Mar 2019 01:50:07 +0300
Message-Id: <20190306225009.3391-2-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190306225009.3391-1-digetx@gmail.com>
References: <20190306225009.3391-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
the TLB_FLUSH register differs from later Tegra generations that have 128
ASID's.

In a result the PTE's are now flushed correctly from TLB and this fixes
problems with graphics (randomly failing tests) on Tegra30.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 5182c7d6171e..8d30653cd13a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -102,7 +102,6 @@ static inline u32 smmu_readl(struct tegra_smmu *smmu, unsigned long offset)
 #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
 #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
 #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
-#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)
 #define  SMMU_TLB_FLUSH_VA_SECTION(addr) ((((addr) & 0xffc00000) >> 12) | \
 					  SMMU_TLB_FLUSH_VA_MATCH_SECTION)
 #define  SMMU_TLB_FLUSH_VA_GROUP(addr)   ((((addr) & 0xffffc000) >> 12) | \
@@ -205,8 +204,12 @@ static inline void smmu_flush_tlb_asid(struct tegra_smmu *smmu,
 {
 	u32 value;
 
-	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
-		SMMU_TLB_FLUSH_VA_MATCH_ALL;
+	if (smmu->soc->num_asids == 4)
+		value = (asid & 0x3) << 29;
+	else
+		value = (asid & 0x7f) << 24;
+
+	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_MATCH_ALL;
 	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
 }
 
@@ -216,8 +219,12 @@ static inline void smmu_flush_tlb_section(struct tegra_smmu *smmu,
 {
 	u32 value;
 
-	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
-		SMMU_TLB_FLUSH_VA_SECTION(iova);
+	if (smmu->soc->num_asids == 4)
+		value = (asid & 0x3) << 29;
+	else
+		value = (asid & 0x7f) << 24;
+
+	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_SECTION(iova);
 	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
 }
 
@@ -227,8 +234,12 @@ static inline void smmu_flush_tlb_group(struct tegra_smmu *smmu,
 {
 	u32 value;
 
-	value = SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_ASID(asid) |
-		SMMU_TLB_FLUSH_VA_GROUP(iova);
+	if (smmu->soc->num_asids == 4)
+		value = (asid & 0x3) << 29;
+	else
+		value = (asid & 0x7f) << 24;
+
+	value |= SMMU_TLB_FLUSH_ASID_MATCH | SMMU_TLB_FLUSH_VA_GROUP(iova);
 	smmu_writel(smmu, value, SMMU_TLB_FLUSH);
 }
 
-- 
2.20.1

