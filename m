Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647A8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 399C1208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329322;
	bh=Z+qE7xG4O2eIgxIxJ81f/ln4gW6m6mknpiIlFK6KWrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1epCwH54hTL0FZOb77t6+h1vQw8jV7CKHnJR/QRoTrCK7kmg37mj6EOBzFFcPBXqc
	 hprB4O/yXQQ0XQUnnHxCM7SWbSR38NTxoSNymebGXtI1D9e7q2QGco3n91B835a/Ou
	 tBojAP6lFvVtNlkR51OTwKTpZH0Tnzy3utwtz3UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfD0BmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfD0Bl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:41:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6712146E;
        Sat, 27 Apr 2019 01:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329315;
        bh=Z+qE7xG4O2eIgxIxJ81f/ln4gW6m6mknpiIlFK6KWrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMnc5osflvrOdvmcv70e+3emckm2lYiBFnzy6TqSft7B5POkIYuIjlwLgIbURwjvm
         mq7pJk4bj3E2mGyRbx/OvvOI5T0Z3D+eZjdDxknts8ygPHwiAqj3fqqc45bDcBD1In
         0KlwKUTafcfl35kZYxbGKZePvW1nZoX0tZsKFQwY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lijun Ou <oulijun@huawei.com>, chenglang <chenglang@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 39/53] RDMA/hns: Fix bug that caused srq creation to fail
Date:   Fri, 26 Apr 2019 21:40:36 -0400
Message-Id: <20190427014051.7522-39-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014051.7522-1-sashal@kernel.org>
References: <20190427014051.7522-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit 4772e03d239484f3461e33c79d721c8ea03f7416 ]

Due to the incorrect use of the seg and obj information, the position of
the mtt is calculated incorrectly, and the free space of the page is not
enough to store the entire mtt, resulting in access to the next page. This
patch fixes this problem.

 Unable to handle kernel paging request at virtual address ffff00006e3cd000
 ...
 Call trace:
  hns_roce_write_mtt+0x154/0x2f0 [hns_roce]
  hns_roce_buf_write_mtt+0xa8/0xd8 [hns_roce]
  hns_roce_create_srq+0x74c/0x808 [hns_roce]
  ib_create_srq+0x28/0xc8

Fixes: 0203b14c4f32 ("RDMA/hns: Unify the calculation for hem index in hip08")
Signed-off-by: chenglang <chenglang@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 6 ++++--
 drivers/infiniband/hw/hns/hns_roce_mr.c  | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index f6faefed96e8..a73d388b7093 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -745,6 +745,8 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 		idx_offset = (obj & (table->num_obj - 1)) % obj_per_chunk;
 		dma_offset = offset = idx_offset * table->obj_size;
 	} else {
+		u32 seg_size = 64; /* 8 bytes per BA and 8 BA per segment */
+
 		hns_roce_calc_hem_mhop(hr_dev, table, &mhop_obj, &mhop);
 		/* mtt mhop */
 		i = mhop.l0_idx;
@@ -756,8 +758,8 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 			hem_idx = i;
 
 		hem = table->hem[hem_idx];
-		dma_offset = offset = (obj & (table->num_obj - 1)) *
-				       table->obj_size % mhop.bt_chunk_size;
+		dma_offset = offset = (obj & (table->num_obj - 1)) * seg_size %
+				       mhop.bt_chunk_size;
 		if (mhop.hop_num == 2)
 			dma_offset = offset = 0;
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index eb26a5f6fc58..41a538d23b80 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -707,7 +707,6 @@ static int hns_roce_write_mtt_chunk(struct hns_roce_dev *hr_dev,
 	struct hns_roce_hem_table *table;
 	dma_addr_t dma_handle;
 	__le64 *mtts;
-	u32 s = start_index * sizeof(u64);
 	u32 bt_page_size;
 	u32 i;
 
@@ -730,7 +729,8 @@ static int hns_roce_write_mtt_chunk(struct hns_roce_dev *hr_dev,
 		table = &hr_dev->mr_table.mtt_cqe_table;
 
 	mtts = hns_roce_table_find(hr_dev, table,
-				mtt->first_seg + s / hr_dev->caps.mtt_entry_sz,
+				mtt->first_seg +
+				start_index / HNS_ROCE_MTT_ENTRY_PER_SEG,
 				&dma_handle);
 	if (!mtts)
 		return -ENOMEM;
-- 
2.19.1

