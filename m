Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56670C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F03121841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638532;
	bh=efh1BNoFi31+cLx+5zdLiuS2kTb44Z1B/wWMtGTGnj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LrUdpCJ0LcceG4HXkYcASXBCxhx59SPeyWPyHGQRHXxb1EUTX84AoK2wsRtbxt5yx
	 O2j+H5TV81gi/dBD8c24MHMjOJ/jLyQUdixjZB9s+3G40YsxT1BTJ8N37tjGgYS0dK
	 Kx3uW2VQz6u1ikEALAlylaKqZH6B8SYM77ZMIjBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbfEWTIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:08:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731901AbfEWTIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:08:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0197217D9;
        Thu, 23 May 2019 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638528;
        bh=efh1BNoFi31+cLx+5zdLiuS2kTb44Z1B/wWMtGTGnj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JtSNtHnsrP5P9/I6qGh8U6q6kwKmrqEVRc3zq9dvMv8HcA1BqPxKt+BoZnEFh2oeC
         23MxGggOLrxymLhtCMEXqJD+Ar3NvT9HBFOO19amuoOEncYDuPmNg8Ra5sg093mL1j
         4N6w31plBEFTPxb9HDUlcsu9B1K3eSMXxkd6rdVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.9 22/53] iommu/tegra-smmu: Fix invalid ASID bits on Tegra30/114
Date:   Thu, 23 May 2019 21:05:46 +0200
Message-Id: <20190523181714.380667133@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181710.981455400@linuxfoundation.org>
References: <20190523181710.981455400@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Osipenko <digetx@gmail.com>

commit 43a0541e312f7136e081e6bf58f6c8a2e9672688 upstream.

Both Tegra30 and Tegra114 have 4 ASID's and the corresponding bitfield of
the TLB_FLUSH register differs from later Tegra generations that have 128
ASID's.

In a result the PTE's are now flushed correctly from TLB and this fixes
problems with graphics (randomly failing tests) on Tegra30.

Cc: stable <stable@vger.kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/tegra-smmu.c |   25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -91,7 +91,6 @@ static inline u32 smmu_readl(struct tegr
 #define  SMMU_TLB_FLUSH_VA_MATCH_ALL     (0 << 0)
 #define  SMMU_TLB_FLUSH_VA_MATCH_SECTION (2 << 0)
 #define  SMMU_TLB_FLUSH_VA_MATCH_GROUP   (3 << 0)
-#define  SMMU_TLB_FLUSH_ASID(x)          (((x) & 0x7f) << 24)
 #define  SMMU_TLB_FLUSH_VA_SECTION(addr) ((((addr) & 0xffc00000) >> 12) | \
 					  SMMU_TLB_FLUSH_VA_MATCH_SECTION)
 #define  SMMU_TLB_FLUSH_VA_GROUP(addr)   ((((addr) & 0xffffc000) >> 12) | \
@@ -194,8 +193,12 @@ static inline void smmu_flush_tlb_asid(s
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
 
@@ -205,8 +208,12 @@ static inline void smmu_flush_tlb_sectio
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
 
@@ -216,8 +223,12 @@ static inline void smmu_flush_tlb_group(
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
 


