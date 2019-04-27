Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E0CC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796F420B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329157;
	bh=BJQ9oUdXJLIUiX6CQfHQcoNqxAaqs+76x0Ckh//WCPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4kaMsFcpxTnSSewm+6CA+8wgsqxzNdsCbmeT/cQkQ0F20E1Ge/8m4KwNc0N8I+9f
	 Bp88kCJ6aOjNiz+BmUWWdRW5i/59mcBAmhJe/4H/I7EnhLLhlZcRuLfta+0rd1YvW+
	 z6V8uFEt4fGQJLqMGs/soBw8V+3c6WJt3sZAKu0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfD0BjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfD0BjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D6D8208CB;
        Sat, 27 Apr 2019 01:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329152;
        bh=BJQ9oUdXJLIUiX6CQfHQcoNqxAaqs+76x0Ckh//WCPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=04RmVMXcUV8u8JUZdaHridO3kaKdAAUrcGYxnYsyXEUXuGmYt/ksl9v2yGwv9YxED
         jZJDQx6SxHt91mqr8XuO/yteBZytjfLwGs/xbBqCc2YI1F8PoAr34N8kuAauP3gbwC
         md7IJEEYSs35oJvkZDOYdWCNfIKjOAgaBn62svwE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 26/79] IB/hfi1: Fix the allocation of RSM table
Date:   Fri, 26 Apr 2019 21:37:45 -0400
Message-Id: <20190427013838.6596-26-sashal@kernel.org>
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

From: Kaike Wan <kaike.wan@intel.com>

[ Upstream commit d0294344470e6b52d097aa7369173f32d11f2f52 ]

The receive side mapping (RSM) on hfi1 hardware is a special
matching mechanism to direct an incoming packet to a given
hardware receive context. It has 4 instances of matching capabilities
(RSM0 - RSM3) that share the same RSM table (RMT). The RMT has a total of
256 entries, each of which points to a receive context.

Currently, three instances of RSM have been used:
1. RSM0 by QOS;
2. RSM1 by PSM FECN;
3. RSM2 by VNIC.

Each RSM instance should reserve enough entries in RMT to function
properly. Since both PSM and VNIC could allocate any receive context
between dd->first_dyn_alloc_ctxt and dd->num_rcv_contexts, PSM FECN must
reserve enough RMT entries to cover the entire receive context index
range (dd->num_rcv_contexts - dd->first_dyn_alloc_ctxt) instead of only
the user receive contexts allocated for PSM
(dd->num_user_contexts). Consequently, the sizing of
dd->num_user_contexts in set_up_context_variables is incorrect.

Fixes: 2280740f01ae ("IB/hfi1: Virtual Network Interface Controller (VNIC) HW support")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/chip.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index b443642eac02..0ae05e9249b3 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -13219,7 +13219,7 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 	int total_contexts;
 	int ret;
 	unsigned ngroups;
-	int qos_rmt_count;
+	int rmt_count;
 	int user_rmt_reduced;
 	u32 n_usr_ctxts;
 	u32 send_contexts = chip_send_contexts(dd);
@@ -13281,10 +13281,20 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 		n_usr_ctxts = rcv_contexts - total_contexts;
 	}
 
-	/* each user context requires an entry in the RMT */
-	qos_rmt_count = qos_rmt_entries(dd, NULL, NULL);
-	if (qos_rmt_count + n_usr_ctxts > NUM_MAP_ENTRIES) {
-		user_rmt_reduced = NUM_MAP_ENTRIES - qos_rmt_count;
+	/*
+	 * The RMT entries are currently allocated as shown below:
+	 * 1. QOS (0 to 128 entries);
+	 * 2. FECN for PSM (num_user_contexts + num_vnic_contexts);
+	 * 3. VNIC (num_vnic_contexts).
+	 * It should be noted that PSM FECN oversubscribe num_vnic_contexts
+	 * entries of RMT because both VNIC and PSM could allocate any receive
+	 * context between dd->first_dyn_alloc_text and dd->num_rcv_contexts,
+	 * and PSM FECN must reserve an RMT entry for each possible PSM receive
+	 * context.
+	 */
+	rmt_count = qos_rmt_entries(dd, NULL, NULL) + (num_vnic_contexts * 2);
+	if (rmt_count + n_usr_ctxts > NUM_MAP_ENTRIES) {
+		user_rmt_reduced = NUM_MAP_ENTRIES - rmt_count;
 		dd_dev_err(dd,
 			   "RMT size is reducing the number of user receive contexts from %u to %d\n",
 			   n_usr_ctxts,
@@ -14272,9 +14282,11 @@ static void init_user_fecn_handling(struct hfi1_devdata *dd,
 	u64 reg;
 	int i, idx, regoff, regidx;
 	u8 offset;
+	u32 total_cnt;
 
 	/* there needs to be enough room in the map table */
-	if (rmt->used + dd->num_user_contexts >= NUM_MAP_ENTRIES) {
+	total_cnt = dd->num_rcv_contexts - dd->first_dyn_alloc_ctxt;
+	if (rmt->used + total_cnt >= NUM_MAP_ENTRIES) {
 		dd_dev_err(dd, "User FECN handling disabled - too many user contexts allocated\n");
 		return;
 	}
@@ -14328,7 +14340,7 @@ static void init_user_fecn_handling(struct hfi1_devdata *dd,
 	/* add rule 1 */
 	add_rsm_rule(dd, RSM_INS_FECN, &rrd);
 
-	rmt->used += dd->num_user_contexts;
+	rmt->used += total_cnt;
 }
 
 /* Initialize RSM for VNIC */
-- 
2.19.1

