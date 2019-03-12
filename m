Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1858C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D67206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411687;
	bh=LQl1chsSHNUmMs7IqAx6fjm1qOMV8hJbYUn4xW39Bpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GQ9Vzch4ujSnEBn7qIKVzhdl7+52uvaLTmwttrTlePeNP1HX5UbUWTiTibTA1HZ2a
	 WhWcwbJHRSOnRC9emXVid+OCIA03QuYo+ZO4YsJJAdkjrdX5KqPJx7Uobw3PL3FhHh
	 OuL5GTCqD6G+JcsVFAMgEYT8RWo74lBDpvdkytSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfCLR2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbfCLRRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:34 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2953121873;
        Tue, 12 Mar 2019 17:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411053;
        bh=LQl1chsSHNUmMs7IqAx6fjm1qOMV8hJbYUn4xW39Bpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uaIL+I1koscMmDZak3PBlHLyEb8OTTlPtdEVSGsVUA6TzFDfJbU1J69+MUAwHL7Ur
         5a0vgWouMQhNWPgBMJ4gv4NShBzywG8ru3IZB0GH+Slr9DMsmYmdCCdOTrRe4U/5jQ
         YHKk2gFjz32cJZJoxbPdV2ve6bSsxFU6If5JbG4c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 38/96] iommu/amd: Call free_iova_fast with pfn in map_sg
Date:   Tue, 12 Mar 2019 10:09:56 -0700
Message-Id: <20190312171037.390838646@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index e984418ffa2a..e413a4ef3c5c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2617,7 +2617,7 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 	}
 
 out_free_iova:
-	free_iova_fast(&dma_dom->iovad, address, npages);
+	free_iova_fast(&dma_dom->iovad, address >> PAGE_SHIFT, npages);
 
 out_err:
 	return 0;
-- 
2.19.1



