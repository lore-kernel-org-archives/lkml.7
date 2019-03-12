Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D620C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E97205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413435;
	bh=YSacvv6A1/v2cH1wM300Vre6x+BgKIUDjtWDywj4F6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AreyGRoW3XL0SVOtqSZGutxwCCu89N6ax6hwniaTYmAKLG9YRNTxRZtYcYCE6Sfn8
	 BTkf00zqK2w//PRMP4g6MLbn+cREhbjBiREN7RmrOvV+8WqLlqVLpfvS3tR2Jbz0kq
	 7cawceO6YnZJD8RdC5AQK4dcpXJcaLY8pC1bJvaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfCLR5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfCLRNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:13:50 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129D9217D4;
        Tue, 12 Mar 2019 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410830;
        bh=YSacvv6A1/v2cH1wM300Vre6x+BgKIUDjtWDywj4F6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l6hFpsXhta5IoWKR2/5OFffAxrQHjNAIQuPvzdCuNU3UNEg3QLEWY5QyJ7V904N5a
         U/qWmHWv7fksTJm0YY/ZnjQtC3qC8Gvqfaws+g/fsC0Fma3rqlRHQVMwStDDWh7kFF
         4VfKXB5hvuLNzV/NmSd6N+aJyUQNpPNZgg90kmxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 008/149] iommu/amd: Call free_iova_fast with pfn in map_sg
Date:   Tue, 12 Mar 2019 10:07:06 -0700
Message-Id: <20190312170350.199284038@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 51d8838d66d3249508940d8f59b07701f2129723 ]

In the error path of map_sg, free_iova_fast is being called with
address instead of the pfn. This results in a bad value getting into
the rcache, and can result in hitting a BUG_ON when
iova_magazine_free_pfns is called.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Fixes: 80187fd39dcb ("iommu/amd: Optimize map_sg and unmap_sg")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 34c9aa76a7bd..2a5c05ca7fca 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2561,7 +2561,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	}
 
 out_free_iova:
-	free_iova_fast(&dma_dom->iovad, address, npages);
+	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
 
 out_err:
 	return 0;
-- 
2.19.1



