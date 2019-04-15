Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71989C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333CC218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="N0NTSq3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfDOSHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:07:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46764 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfDOSHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:07:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so15495342edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
        b=N0NTSq3Q4ojuYpUkjlK2prw6mQsPcTEtqzN7mYy7VPjp34PF8ONNdXWw1+iPNdnMDJ
         xhaqAvzIpQd1qUWrgFJQ6fjSJDFkQet6N168sqou/tTfja7IUhiFUZxrtuc4vxN9LthX
         zsmU0vvqYuzZiaoo7nnxLLLRF10ySHc4yGHS+0+I087jXXFqNTtnioOyqFjRnzqvzpgz
         dfYTImWltwKzcVkctMJHVKWr7ayYtpXXpEOJPE7kyk/NPmGAcXqKpKlE4VQDmhGPld5d
         U/nueMEpAXswgB9QUjfcgjx2cjo6SYz+flU4eSSi9cQ/ki8izPQA0/rolbY7c8ZrQ77b
         VwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
        b=ReiUt4EKdczEDyxRN5MqwJw1aO0+6qGesf2MuASGyP5zqohsUw6KRtSkGeeRlUSvN7
         sIdV1M8UQkz9tQ6uY1q2Ws9YkMyrU0m2MLKPSNDinh5gFuYQktUc1ZkiiO6MP65GJCty
         tBkACnZbs5u4qdvNzcKTJaCajgg9x7uvtId18/5ESdBLC99ZxhBTYtLgsf51tmSO45ln
         UW63VwkfEhag6oCrj+vi5l2olh1k0wit5xl/NPkeTotHGcdsFrX7zk3j0+jpXQvpr4au
         bkxqRvVXszPoHOtHt2zajiYcuaUv0qE1jdSgjUS+dXB0P4JKPY2i2OQcSUdYhfbCIfDw
         ADrQ==
X-Gm-Message-State: APjAAAUHft7ObuDb9DeeKzQNak+LzS0ZNZrDcbx9sJdIUVmiU8tZ3fzG
        WSOwQ6hBxyqbySEAMgw//lh6CQ==
X-Google-Smtp-Source: APXvYqxGbF6PBQssGl3zTaMtgNXM17abXrU39qUCc3fAxi71G1CMTTcoSTWH5P0IEoifOlPy8P3TAg==
X-Received: by 2002:a50:fc0a:: with SMTP id i10mr30663836edr.143.1555351661237;
        Mon, 15 Apr 2019 11:07:41 -0700 (PDT)
Received: from linux-ThinkPad-X1-Carbon-5th.Hitronhub.home ([80.111.101.37])
        by smtp.gmail.com with ESMTPSA id y12sm7239984ejr.75.2019.04.15.11.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 11:07:40 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie,
        Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Add allocated domain to global list earlier
Date:   Mon, 15 Apr 2019 19:05:56 +0100
Message-Id: <20190415180556.5018-1-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_ops_domain_free() expects domain to be in a global list.
Arguably, could be called before protection_domain_init().

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 02b351834a3b..bfb021d656aa 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1801,8 +1801,12 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
-		goto free_domain;
+	if (protection_domain_init(domain)) {
+		kfree(domain);
+		return NULL;
+	}
+
+	add_domain_to_list(domain);
 
 	domain->mode = PAGE_MODE_3_LEVEL;
 	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1824,8 +1828,6 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	iommu_dma_copy_reserved_iova(&reserved_iova_ranges, &domain->domain);
 
-	add_domain_to_list(domain);
-
 	return domain;
 
 free_cookie:
-- 
2.17.1

