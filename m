Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D163C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DD9222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611858;
	bh=YGeYgAHoW8Hd4X7UlLwPS7U++ZsxUhbxtldKsxcXYWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+sPvdW5U/wYUQWV0OUTiFfukVtqyHNq6UG08Gk5na7kx0OHvb/los2TAO01V36po
	 WDnpxpHbCowXKWXaJZ+C0BAec7RnYsRos8LMdKyy2vxIrb/JIx3sgRr2v80t6GGhb6
	 JaKZyNp8bMlCxEMZqTtPqD1twI4ZuagxHIZ9l5gQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfKMCYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfKMBwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:52:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11739222CD;
        Wed, 13 Nov 2019 01:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609928;
        bh=YGeYgAHoW8Hd4X7UlLwPS7U++ZsxUhbxtldKsxcXYWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RM9B84GvQYu0DvIerGijsLEmf3/CObFjqalHrzC1ze2T9Id/9GUSYrlNIfLBUIzOI
         ThO5eaV5HoEkIYdn9MpH/ZwZKfb2yawu86/J+cGCmC6ZFdsRc4qF+v/Viy8wEEiEIE
         HIiZeHsnEkpGl5eMnwQf72yIksC99Wj4ecRwG8d0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lijun Ou <oulijun@huawei.com>, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 074/209] RDMA/hns: Submit bad wr when post send wr exception
Date:   Tue, 12 Nov 2019 20:48:10 -0500
Message-Id: <20191113015025.9685-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lijun Ou <oulijun@huawei.com>

[ Upstream commit c80e066100b5fed722c8da67c1bd2312e7bcf129 ]

When user issues a RDMA read and enables sq inline, it needs to report a
bad wr to user.

Signed-off-by: Lijun Ou <oulijun@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7eb6e4bf8a090..ce44a90d2bd3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -121,6 +121,7 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 		}
 
 		if (wr->opcode == IB_WR_RDMA_READ) {
+			*bad_wr =  wr;
 			dev_err(hr_dev->dev, "Not support inline data!\n");
 			return -EINVAL;
 		}
-- 
2.20.1

