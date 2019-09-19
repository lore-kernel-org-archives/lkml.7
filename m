Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0439CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB3F20640
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932032;
	bh=EEJyiFOb58dYeSeHP50yL1HEZhSK5Fe9OBqGqb3mxTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z/2YbmW87FUs5RgOS1gaAhs1sSSj4r3DEJzQfWHBUaNmfIT3/id61iTOyd1pTmteQ
	 BlLPUYnD31e2LBG3KbmOiPeZLgWCGEKv1friVFkx7WhKYcLOWkDZol0CFq5AWDc9N1
	 Vz+QnBjpUb7ACBpONUvS1Z4A0BxnxVEpSlvfI3cE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436558AbfISW1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:27:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406686AbfISWVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:21:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7584D21927;
        Thu, 19 Sep 2019 22:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931672;
        bh=EEJyiFOb58dYeSeHP50yL1HEZhSK5Fe9OBqGqb3mxTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPpcGDutXP4TkKTjZXjcakyc0c+dAlP3QZkXp4YnEm1wHrAGABU71pYKrIIPHN9j0
         CSHfvCNUYsq/jQ6Vl3nvMtMhSvqtWGB5WnFKEpiWQ6f+p7flLuLApI957V/K2j4lvZ
         Tn2+xyV/d3CBntHSh2TZ8HRbLeR2JwYnvm/bkzkY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 71/74] iommu/amd: Fix race in increase_address_space()
Date:   Fri, 20 Sep 2019 00:04:24 +0200
Message-Id: <20190919214811.342705594@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

[ Upstream commit 754265bcab78a9014f0f99cd35e0d610fcd7dfa7 ]

After the conversion to lock-less dma-api call the
increase_address_space() function can be called without any
locking. Multiple CPUs could potentially race for increasing
the address space, leading to invalid domain->mode settings
and invalid page-tables. This has been happening in the wild
under high IO load and memory pressure.

Fix the race by locking this operation. The function is
called infrequently so that this does not introduce
a performance regression in the dma-api path again.

Reported-by: Qian Cai <cai@lca.pw>
Fixes: 256e4621c21a ('iommu/amd: Make use of the generic IOVA allocator')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c1233d0288a03..dd7880de7e4e9 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1321,18 +1321,21 @@ static void domain_flush_devices(struct protection_domain *domain)
  * another level increases the size of the address space by 9 bits to a size up
  * to 64 bits.
  */
-static bool increase_address_space(struct protection_domain *domain,
+static void increase_address_space(struct protection_domain *domain,
 				   gfp_t gfp)
 {
+	unsigned long flags;
 	u64 *pte;
 
-	if (domain->mode == PAGE_MODE_6_LEVEL)
+	spin_lock_irqsave(&domain->lock, flags);
+
+	if (WARN_ON_ONCE(domain->mode == PAGE_MODE_6_LEVEL))
 		/* address space already 64 bit large */
-		return false;
+		goto out;
 
 	pte = (void *)get_zeroed_page(gfp);
 	if (!pte)
-		return false;
+		goto out;
 
 	*pte             = PM_LEVEL_PDE(domain->mode,
 					virt_to_phys(domain->pt_root));
@@ -1340,7 +1343,10 @@ static bool increase_address_space(struct protection_domain *domain,
 	domain->mode    += 1;
 	domain->updated  = true;
 
-	return true;
+out:
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	return;
 }
 
 static u64 *alloc_pte(struct protection_domain *domain,
-- 
2.20.1



