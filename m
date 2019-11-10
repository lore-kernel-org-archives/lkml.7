Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF63C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C9322573
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354437;
	bh=NYn043bx4MnFOiz3nSb2ma/6pRSTOnBpZQfujKJhvyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QjNNfjMu++NVrQWh8ogPB8kgViB0beaLA66rnqkxBMnVEuLMLxn1rvkw2KcWF20cI
	 G2ICuWGabYJO17f4tG6Lx651QL40rjxG+4Mt0875Ni4+BBjoK5GV1PWwR8YFJUknQU
	 aabAOpq4fO0Ql4Vi1zFxnqJ1THWCM3UJc1li7WJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfKJCvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbfKJCuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:50:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F6F227C3;
        Sun, 10 Nov 2019 02:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354238;
        bh=NYn043bx4MnFOiz3nSb2ma/6pRSTOnBpZQfujKJhvyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A53NGpYuwwk60bwX3J0kZ3rPF9+UszahT2QOQOVkcngSlX4ZfdV5dnWtZIEXVCgfk
         Bl7uBPYSmh/KFPh6z8cSqhnW2qGUetVM4bWX7A5VuJcnv5FwwUm9O9v3gAwxoHsLZ0
         2+p/mnDnoMIGRTXx5ixR9M52a6n15bBqhC/iogkM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 04/40] powerpc/iommu: Avoid derefence before pointer check
Date:   Sat,  9 Nov 2019 21:49:56 -0500
Message-Id: <20191110025032.827-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110025032.827-1-sashal@kernel.org>
References: <20191110025032.827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 984ecdd68de0fa1f63ce205d6c19ef5a7bc67b40 ]

The tbl pointer is being derefenced by IOMMU_PAGE_SIZE prior the check
if it is not NULL.

Just moving the dereference code to after the check, where there will
be guarantee that 'tbl' will not be NULL.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a8e3490b54e3b..4c9b5970af371 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -764,9 +764,9 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 
 	vaddr = page_address(page) + offset;
 	uaddr = (unsigned long)vaddr;
-	npages = iommu_num_pages(uaddr, size, IOMMU_PAGE_SIZE(tbl));
 
 	if (tbl) {
+		npages = iommu_num_pages(uaddr, size, IOMMU_PAGE_SIZE(tbl));
 		align = 0;
 		if (tbl->it_page_shift < PAGE_SHIFT && size >= PAGE_SIZE &&
 		    ((unsigned long)vaddr & ~PAGE_MASK) == 0)
-- 
2.20.1

