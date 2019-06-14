Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E912C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159152187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560544414;
	bh=cQ3VaTLg3+vEm1IPPPlsDN4PJOfib1Gp9Y5tmbYJhXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EDEvW6aISVQ7f7iIsE3dlVNkOq2U8UPrCVStuIX2MNrx9RW+W/hyUrubOW4YveDCI
	 ExHfFxENqmO3S2hUwpvq3eixwjg3iuo9yueQEhTHfelR2LoHTVSi2BNCp99AMREcRo
	 BLNun8/3PQm/mGgnBFwVaEKM1Inl4tW6yzeTqGoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfFNUa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfFNUaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:30:23 -0400
Received: from sasha-vm.mshome.net (unknown [131.107.159.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D8AB21874;
        Fri, 14 Jun 2019 20:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560544222;
        bh=cQ3VaTLg3+vEm1IPPPlsDN4PJOfib1Gp9Y5tmbYJhXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKUx12uBbepnFKjRwKzojp1ldd8TEwC4tZcPSlitUi73qlB1S0pizJCUs8mUJ+9xp
         vkf5s8pKdfEeaFPjqoemWE+nloChQuGIkaJg+N/jsev0FsTS7vbYeviX6FYf4VdvWf
         APcJtiA49CDntBmmYepRSN759JhiE8H1i+DttkMs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Josh Collier <josh.d.collier@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 08/27] IB/{qib, hfi1, rdmavt}: Correct ibv_devinfo max_mr value
Date:   Fri, 14 Jun 2019 16:29:57 -0400
Message-Id: <20190614203018.27686-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614203018.27686-1-sashal@kernel.org>
References: <20190614203018.27686-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

[ Upstream commit 35164f5259a47ea756fa1deb3e463ac2a4f10dc9 ]

The command 'ibv_devinfo -v' reports 0 for max_mr.

Fix by assigning the query values after the mr lkey_table has been built
rather than early on in the driver.

Fixes: 7b1e2099adc8 ("IB/rdmavt: Move memory registration into rdmavt")
Reviewed-by: Josh Collier <josh.d.collier@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/verbs.c    | 2 --
 drivers/infiniband/hw/qib/qib_verbs.c | 2 --
 drivers/infiniband/sw/rdmavt/mr.c     | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 2e8854ba18cf..f4372afa0e81 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1400,8 +1400,6 @@ static void hfi1_fill_device_attr(struct hfi1_devdata *dd)
 	rdi->dparms.props.max_cq = hfi1_max_cqs;
 	rdi->dparms.props.max_ah = hfi1_max_ahs;
 	rdi->dparms.props.max_cqe = hfi1_max_cqes;
-	rdi->dparms.props.max_mr = rdi->lkey_table.max;
-	rdi->dparms.props.max_fmr = rdi->lkey_table.max;
 	rdi->dparms.props.max_map_per_fmr = 32767;
 	rdi->dparms.props.max_pd = hfi1_max_pds;
 	rdi->dparms.props.max_qp_rd_atom = HFI1_MAX_RDMA_ATOMIC;
diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 9d92aeb8d9a1..350bc29a066f 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1495,8 +1495,6 @@ static void qib_fill_device_attr(struct qib_devdata *dd)
 	rdi->dparms.props.max_cq = ib_qib_max_cqs;
 	rdi->dparms.props.max_cqe = ib_qib_max_cqes;
 	rdi->dparms.props.max_ah = ib_qib_max_ahs;
-	rdi->dparms.props.max_mr = rdi->lkey_table.max;
-	rdi->dparms.props.max_fmr = rdi->lkey_table.max;
 	rdi->dparms.props.max_map_per_fmr = 32767;
 	rdi->dparms.props.max_qp_rd_atom = QIB_MAX_RDMA_ATOMIC;
 	rdi->dparms.props.max_qp_init_rd_atom = 255;
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index e7013d2d4f0e..d5b51f4cb49a 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -96,6 +96,8 @@ int rvt_driver_mr_init(struct rvt_dev_info *rdi)
 	for (i = 0; i < rdi->lkey_table.max; i++)
 		RCU_INIT_POINTER(rdi->lkey_table.table[i], NULL);
 
+	rdi->dparms.props.max_mr = rdi->lkey_table.max;
+	rdi->dparms.props.max_fmr = rdi->lkey_table.max;
 	return 0;
 }
 
-- 
2.20.1

