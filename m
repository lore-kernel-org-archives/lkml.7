Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3AFC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0418920674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574422016;
	bh=NYn043bx4MnFOiz3nSb2ma/6pRSTOnBpZQfujKJhvyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qQX1Qc+5Aut26/wGRsEVUE+JzZnZU/t8Kru1GYLa5YnxOEArmrrT/cIZUb84JR74n
	 8o1IvgQgXdI5yoJWcboVilmg7OayUq+8GdeuZ5BhaMb8Enlv5oMN51V5gPipdBRzdo
	 pXXhXNrTtfzmXd9BtnUgEnLe7cZM9apXUjxY3lnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfKVKdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:33:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727128AbfKVKdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:33:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04E1D20708;
        Fri, 22 Nov 2019 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418812;
        bh=NYn043bx4MnFOiz3nSb2ma/6pRSTOnBpZQfujKJhvyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mY1zU4dqTsIthZlRiBQ4ccgOBSVhkUyUhz7cO1CRo8XoBaYEgNT6A43yP8sHBFlA0
         P+vNqqfoszqprsfTfIF6dnyYfj1JQN9/UlGCmvuB35VNh4OPj8idBH2YZ4Oyk2+4vE
         BnSEbe5lr5lZ62qTsgggcGsx8gqkB+esJ5iCxD/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 059/159] powerpc/iommu: Avoid derefence before pointer check
Date:   Fri, 22 Nov 2019 11:27:30 +0100
Message-Id: <20191122100750.400464968@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



