Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708FDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 457612087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412507;
	bh=TfdkFv+oLfkP3SysO474sOpsz0+uaPUT2zRZCKtbuio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1F8ZCnxdPiLSGNkGdqN5GtXyhXJvtSIBOYfoieO7ORFwCU6EmL/c2rV7OiM+wEfnf
	 IXYS1hKcoFvNWwzWSa1w9QJq6NoKzyOIAz/vB+fzrFnXpfYMZOoFfW5xHml/DmRYHV
	 2rQ70FFq6v8CVmVVuvctGYgGS3DRroerzb5q680c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfCLRlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbfCLRQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:03 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B932171F;
        Tue, 12 Mar 2019 17:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410962;
        bh=TfdkFv+oLfkP3SysO474sOpsz0+uaPUT2zRZCKtbuio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxnSWHBjYIiE7jeeqOw5t/X92aF2TTtZspv+qlufnZYTHujMtaYbwr+P3sN/8myXc
         Qi49fMlKLEHu2qJbw6y8mb3rQ+WbnN1OQyY50NOrp3jMl/tv8LZzIVA25qQlp8vAQA
         c13JZpWTra5LUk3bqWds36mq0oQZR5f6G/KM1FYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/135] iommu/amd: Call free_iova_fast with pfn in map_sg
Date:   Tue, 12 Mar 2019 10:08:15 -0700
Message-Id: <20190312170345.573492325@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index 766103ea237e..ded13a6afa66 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2566,7 +2566,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	}
 
 out_free_iova:
-	free_iova_fast(&dma_dom->iovad, address, npages);
+	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
 
 out_err:
 	return 0;
-- 
2.19.1



