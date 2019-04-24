Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E78C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F2B2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117861;
	bh=cc/EM/u6qHh3+wRb0Tq6lFSHKNWmYp6wq5HdOkMlokY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VhFu48gXh/wwDlj9MHc9iNmImnHLXLUBWG/T5KyWVXPK/hmIwfkuTBp6cFpL5Cn4O
	 7gnUPiUGYVriKp/Qzjqhm9FtqCs9cZaWCDGSQs2Fp6itLB4J/rLcBLzU+Kl02xXH/+
	 IBZRT27q3gQlY4LOKnUJdxmpyIeynFkGiGcM/1Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733027AbfDXO5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:57:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731645AbfDXOsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:48:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCCED218FC;
        Wed, 24 Apr 2019 14:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117278;
        bh=cc/EM/u6qHh3+wRb0Tq6lFSHKNWmYp6wq5HdOkMlokY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PyNBH9rYsXLivy3LwGhax9UnTlHDImJ82iH4oZjrT/DH1XLxrtdJe1ao/XCSM1ZKV
         LkXUEf5pw09Dhxj2VEM6uTIHynbDovTVWBwJ/gtOKKyjIDU4sxriG9iGZdunPIu6QK
         fT15tSNXjAKwWLerpMRC8slQyF2Hd3eQk3hV1tLQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 21/35] vfio/type1: Limit DMA mappings per container
Date:   Wed, 24 Apr 2019 10:46:55 -0400
Message-Id: <20190424144709.30215-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit 492855939bdb59c6f947b0b5b44af9ad82b7e38c ]

Memory backed DMA mappings are accounted against a user's locked
memory limit, including multiple mappings of the same memory.  This
accounting bounds the number of such mappings that a user can create.
However, DMA mappings that are not backed by memory, such as DMA
mappings of device MMIO via mmaps, do not make use of page pinning
and therefore do not count against the user's locked memory limit.
These mappings still consume memory, but the memory is not well
associated to the process for the purpose of oom killing a task.

To add bounding on this use case, we introduce a limit to the total
number of concurrent DMA mappings that a user is allowed to create.
This limit is exposed as a tunable module option where the default
value of 64K is expected to be well in excess of any reasonable use
case (a large virtual machine configuration would typically only make
use of tens of concurrent mappings).

This fixes CVE-2019-3882.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/vfio_iommu_type1.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 50eeb74ddc0a..f77a9b3370b5 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -58,12 +58,18 @@ module_param_named(disable_hugepages,
 MODULE_PARM_DESC(disable_hugepages,
 		 "Disable VFIO IOMMU support for IOMMU hugepages.");
 
+static unsigned int dma_entry_limit __read_mostly = U16_MAX;
+module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
+MODULE_PARM_DESC(dma_entry_limit,
+		 "Maximum number of user DMA mappings per container (65535).");
+
 struct vfio_iommu {
 	struct list_head	domain_list;
 	struct vfio_domain	*external_domain; /* domain for external user */
 	struct mutex		lock;
 	struct rb_root		dma_list;
 	struct blocking_notifier_head notifier;
+	unsigned int		dma_avail;
 	bool			v2;
 	bool			nesting;
 };
@@ -732,6 +738,7 @@ static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	vfio_unlink_dma(iommu, dma);
 	put_task_struct(dma->task);
 	kfree(dma);
+	iommu->dma_avail++;
 }
 
 static unsigned long vfio_pgsize_bitmap(struct vfio_iommu *iommu)
@@ -1003,12 +1010,18 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 		goto out_unlock;
 	}
 
+	if (!iommu->dma_avail) {
+		ret = -ENOSPC;
+		goto out_unlock;
+	}
+
 	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
 	if (!dma) {
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
 
+	iommu->dma_avail--;
 	dma->iova = iova;
 	dma->vaddr = vaddr;
 	dma->prot = prot;
@@ -1504,6 +1517,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 
 	INIT_LIST_HEAD(&iommu->domain_list);
 	iommu->dma_list = RB_ROOT;
+	iommu->dma_avail = dma_entry_limit;
 	mutex_init(&iommu->lock);
 	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
 
-- 
2.19.1

