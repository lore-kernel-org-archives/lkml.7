Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B16C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55F57206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141735;
	bh=jXkiVzZYSLUq0yhlysGpFlmVqSm2aSwxQEawDZL8+xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HUJLAThppHwGcX5nphuJemiJPEGdv+ncnHxCqMWGJKCwMnd+pFL5TqPdpaD7tNf5o
	 v3TLmAhG2dLhqbPsnNsxKrRnonvgSUW7mk6IpGnEl91aL9RHHowXH7zrBuBXXqhuYM
	 jsjarUKNrhmGSYo978SeV3RobMIrVwam70miN8es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfKSFfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:35:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbfKSFfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:35:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D095B20862;
        Tue, 19 Nov 2019 05:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141730;
        bh=jXkiVzZYSLUq0yhlysGpFlmVqSm2aSwxQEawDZL8+xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g8oWlJfevFGkyuuQOvCt3m2ptRut+0ojU3TgsjnFt8IVMcsUMHL6yIB3eImi190Uk
         bpSlZMOn71yyEYAIovCVy+SQ5tsx3C7aB+++/aRkewe8gba8vDcfVZ3vrekvhl/UaM
         L6MjJO6DE8f5SyJvEa/7h853drMLV8O9o9W550m4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 260/422] powerpc/iommu: Avoid derefence before pointer check
Date:   Tue, 19 Nov 2019 06:17:37 +0100
Message-Id: <20191119051415.839491019@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
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
index 19b4c628f3bec..f0dc680e659af 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -785,9 +785,9 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 
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



