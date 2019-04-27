Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C42C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC6C208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329199;
	bh=D6X36+ZdlipWQlatlGHLgzw0eh6f1IcXtuMNN6rw4/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1f6paEWBKYtt0r3E8W2Suc0P5czIQ8Fg0Jey8+71adRVWq7FBc2zNO8WyFcKq0DKB
	 avhxk0LDt1YH1AhQp7j1iSH8UwhIvqTdI3zyPew0nxrspu4W2q+ZJar83nEAL3Kfgz
	 zoP6+ub9/36asnporCz4IzQ+Cm/G/RrAJ6UJJ+6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfD0Bj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbfD0Bj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B4F20B7C;
        Sat, 27 Apr 2019 01:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329195;
        bh=D6X36+ZdlipWQlatlGHLgzw0eh6f1IcXtuMNN6rw4/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zl09j5pDphx6zL4WIuHSyZooVjap0rA1jL5Rnw+ymAXFxDNEX3qlRx9Jqfd+KsMn9
         ByfJRl4NdxzxDL7jCniq9FZFw/v0RNe8L/xjHMbnscgV24SzqQmQVkXNbUSW945XPN
         SG7UKBPqQ2ErdvPjkutFDFHqOdlzc/UF+mx/ibTA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lijun Ou <oulijun@huawei.com>, chenglang <chenglang@huawei.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 50/79] RDMA/hns: Fix bug that caused srq creation to fail
Date:   Fri, 26 Apr 2019 21:38:09 -0400
Message-Id: <20190427013838.6596-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
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
index 4cdbcafa5915..cae23364cfea 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -763,6 +763,8 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 		idx_offset = (obj & (table->num_obj - 1)) % obj_per_chunk;
 		dma_offset = offset = idx_offset * table->obj_size;
 	} else {
+		u32 seg_size = 64; /* 8 bytes per BA and 8 BA per segment */
+
 		hns_roce_calc_hem_mhop(hr_dev, table, &mhop_obj, &mhop);
 		/* mtt mhop */
 		i = mhop.l0_idx;
@@ -774,8 +776,8 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
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
index ee5991bd4171..dd4bb0ec6113 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -746,7 +746,6 @@ static int hns_roce_write_mtt_chunk(struct hns_roce_dev *hr_dev,
 	struct hns_roce_hem_table *table;
 	dma_addr_t dma_handle;
 	__le64 *mtts;
-	u32 s = start_index * sizeof(u64);
 	u32 bt_page_size;
 	u32 i;
 
@@ -780,7 +779,8 @@ static int hns_roce_write_mtt_chunk(struct hns_roce_dev *hr_dev,
 		return -EINVAL;
 
 	mtts = hns_roce_table_find(hr_dev, table,
-				mtt->first_seg + s / hr_dev->caps.mtt_entry_sz,
+				mtt->first_seg +
+				start_index / HNS_ROCE_MTT_ENTRY_PER_SEG,
 				&dma_handle);
 	if (!mtts)
 		return -ENOMEM;
-- 
2.19.1

