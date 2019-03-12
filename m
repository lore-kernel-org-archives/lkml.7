Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02089C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF751205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414272;
	bh=zWHFb2Z3aRB393ZEVC/EQ298Qzh7juzDTLmyp1lUD04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W8MjRBLj8FKkqSOfDtY9tHfHlic8glkLvKVEDYPLvW/sHbgsUkDKc+X7uTRtcnm8A
	 6F9+GdfHvY40rQPpKxqIuIKIkTsPtRz74/oNYeyD8ze6ukKX8A/FVsYvFP6J0aC+2J
	 ePXjGo25a4q1Rem4g28jviGAg/q9kG5aodkq83+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfCLSLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:11:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbfCLRLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:44 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BACB217D4;
        Tue, 12 Mar 2019 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410703;
        bh=zWHFb2Z3aRB393ZEVC/EQ298Qzh7juzDTLmyp1lUD04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQJm0bPR/iHkImbR/Vvmo9yriHwMtVAIRKXfPwmp0b9/77FGr9brgBZCLQrRw7ZS4
         sl9hSf2QdkG+VGJFI/ARklPvjQf0plgvhgO7RLIcs/lnVmgTf4PBkWysvbZK181OyW
         8Iztkans29s5zEG4iHPYaUsdMDHAzGjajd/wJR/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 014/171] iommu/amd: Unmap all mapped pages in error path of map_sg
Date:   Tue, 12 Mar 2019 10:06:34 -0700
Message-Id: <20190312170349.125089328@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f1724c0883bb0ce93b8dcb94b53dcca3b75ac9a7 ]

In the error path of map_sg there is an incorrect if condition
for breaking out of the loop that searches the scatterlist
for mapped pages to unmap. Instead of breaking out of the
loop once all the pages that were mapped have been unmapped,
it will break out of the loop after it has unmapped 1 page.
Fix the condition, so it breaks out of the loop only after
all the mapped pages have been unmapped.

Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5f33f843d30a..ca3a250d8fa7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2555,7 +2555,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			iommu_unmap_page(domain, bus_addr, PAGE_SIZE);
 
-			if (--mapped_pages)
+			if (--mapped_pages == 0)
 				goto out_free_iova;
 		}
 	}
-- 
2.19.1



