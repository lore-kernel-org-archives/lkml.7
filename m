Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41C8CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25DF206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572096706;
	bh=M4BDqp+jaybyxjRpA8NRkwvztv6MOAjRnay/NpFZWJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CGth/IDv9mE/TrbJsYx9Wiy16kwqeNu3TjOSXj4yp2/lkScenNB3/1jpL3cFBv8q2
	 pSRTp+wzUGFgVY9JCPwyJEpIQDQ2VZL7Xxwh4SO3NKrJuTT7NKIb6fInLg9MkC1Hdt
	 D/yoZ15TZrBEjZJq707NjSc3gEBb+txDD+8XDfhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfJZNbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbfJZNTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 09:19:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C500222C2;
        Sat, 26 Oct 2019 13:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572095953;
        bh=M4BDqp+jaybyxjRpA8NRkwvztv6MOAjRnay/NpFZWJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIt046ZgQedWdhyz/jFcjwa6yQ6IPQj7a5a2mnVv3dfLYg2jCLQPL8HdUfG4c+BBO
         0hbxdICPUam8IJCK4la/b0I9CqNaD4l+8AdimYvqTYTiavpLDs7I4xfbKGZnVEbfHE
         JKNzuNdsmdKaH0CR+2K7g9VN9b3Zv1NpJJxAJis8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liu Xiang <liuxiang_1999@126.com>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.19 02/59] iommu/arm-smmu: Free context bitmap in the err path of arm_smmu_init_domain_context
Date:   Sat, 26 Oct 2019 09:18:13 -0400
Message-Id: <20191026131910.3435-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191026131910.3435-1-sashal@kernel.org>
References: <20191026131910.3435-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Xiang <liuxiang_1999@126.com>

[ Upstream commit 6db7bfb431220d78e34d2d0afdb7c12683323588 ]

When alloc_io_pgtable_ops is failed, context bitmap which is just allocated
by __arm_smmu_alloc_bitmap should be freed to release the resource.

Signed-off-by: Liu Xiang <liuxiang_1999@126.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 0c3b8f1c7225e..cfd3428627243 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -915,6 +915,7 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	return 0;
 
 out_clear_smmu:
+	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
 	smmu_domain->smmu = NULL;
 out_unlock:
 	mutex_unlock(&smmu_domain->init_mutex);
-- 
2.20.1

