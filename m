Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A5FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD8F20675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208288;
	bh=I7g2P9K7D4dU1UxT9helvGgvqlFPJNb06UB/OqUI2Fo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zHqeRHMCJ4zYFGhF0KFCjOYW9aQ7nVpdGjoFqSPWeCx3Jrl2gG/xUkXmiFAodWkmI
	 sCUA4+2YRejAXlZQ7jD4JUP0Qr5BadjmzYupU6p009GrbIZqfqKxG8B758jUeDqdip
	 +/pR3j0t9nzapg89v2OR1v+bZVfVEiwfzMMrI9No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfEGFjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:39:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728940AbfEGFjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:39:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 874D8214AE;
        Tue,  7 May 2019 05:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207590;
        bh=I7g2P9K7D4dU1UxT9helvGgvqlFPJNb06UB/OqUI2Fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/W9O7Rt4ArS5XZQhIgTrZWaaZ8ezaybfLqm0jpQp6lBFa70RCkKptsv6UMSvCEmP
         OMtReh/AemwnHC79bshbWmCBwBtsU3XG9tZ8uPPMmwfB6p57WRj/1B7R3H/gVTiTAc
         NBj9S18PuvOotJNME8GNMPGqJV2nEQAjV7YQ5edQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Seth Howell <seth.howell@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 40/95] IB/rxe: Revise the ib_wr_opcode enum
Date:   Tue,  7 May 2019 01:37:29 -0400
Message-Id: <20190507053826.31622-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit 9a59739bd01f77db6fbe2955a4fce165f0f43568 ]

This enum has become part of the uABI, as both RXE and the
ib_uverbs_post_send() command expect userspace to supply values from this
enum. So it should be properly placed in include/uapi/rdma.

In userspace this enum is called 'enum ibv_wr_opcode' as part of
libibverbs.h. That enum defines different values for IB_WR_LOCAL_INV,
IB_WR_SEND_WITH_INV, and IB_WR_LSO. These were introduced (incorrectly, it
turns out) into libiberbs in 2015.

The kernel has changed its mind on the numbering for several of the IB_WC
values over the years, but has remained stable on IB_WR_LOCAL_INV and
below.

Based on this we can conclude that there is no real user space user of the
values beyond IB_WR_ATOMIC_FETCH_AND_ADD, as they have never worked via
rdma-core. This is confirmed by inspection, only rxe uses the kernel enum
and implements the latter operations. rxe has clearly never worked with
these attributes from userspace. Other drivers that support these opcodes
implement the functionality without calling out to the kernel.

To make IB_WR_SEND_WITH_INV and related work for RXE in userspace we
choose to renumber the IB_WR enum in the kernel to match the uABI that
userspace has bee using since before Soft RoCE was merged. This is an
overall simpler configuration for the whole software stack, and obviously
can't break anything existing.

Reported-by: Seth Howell <seth.howell@intel.com>
Tested-by: Seth Howell <seth.howell@intel.com>
Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/rdma/ib_verbs.h           | 34 ++++++++++++++++++-------------
 include/uapi/rdma/ib_user_verbs.h | 20 +++++++++++++++++-
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 5a24b4c700e5..9e76b2410d03 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -1251,21 +1251,27 @@ struct ib_qp_attr {
 };
 
 enum ib_wr_opcode {
-	IB_WR_RDMA_WRITE,
-	IB_WR_RDMA_WRITE_WITH_IMM,
-	IB_WR_SEND,
-	IB_WR_SEND_WITH_IMM,
-	IB_WR_RDMA_READ,
-	IB_WR_ATOMIC_CMP_AND_SWP,
-	IB_WR_ATOMIC_FETCH_AND_ADD,
-	IB_WR_LSO,
-	IB_WR_SEND_WITH_INV,
-	IB_WR_RDMA_READ_WITH_INV,
-	IB_WR_LOCAL_INV,
-	IB_WR_REG_MR,
-	IB_WR_MASKED_ATOMIC_CMP_AND_SWP,
-	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+	/* These are shared with userspace */
+	IB_WR_RDMA_WRITE = IB_UVERBS_WR_RDMA_WRITE,
+	IB_WR_RDMA_WRITE_WITH_IMM = IB_UVERBS_WR_RDMA_WRITE_WITH_IMM,
+	IB_WR_SEND = IB_UVERBS_WR_SEND,
+	IB_WR_SEND_WITH_IMM = IB_UVERBS_WR_SEND_WITH_IMM,
+	IB_WR_RDMA_READ = IB_UVERBS_WR_RDMA_READ,
+	IB_WR_ATOMIC_CMP_AND_SWP = IB_UVERBS_WR_ATOMIC_CMP_AND_SWP,
+	IB_WR_ATOMIC_FETCH_AND_ADD = IB_UVERBS_WR_ATOMIC_FETCH_AND_ADD,
+	IB_WR_LSO = IB_UVERBS_WR_TSO,
+	IB_WR_SEND_WITH_INV = IB_UVERBS_WR_SEND_WITH_INV,
+	IB_WR_RDMA_READ_WITH_INV = IB_UVERBS_WR_RDMA_READ_WITH_INV,
+	IB_WR_LOCAL_INV = IB_UVERBS_WR_LOCAL_INV,
+	IB_WR_MASKED_ATOMIC_CMP_AND_SWP =
+		IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP,
+	IB_WR_MASKED_ATOMIC_FETCH_AND_ADD =
+		IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD,
+
+	/* These are kernel only and can not be issued by userspace */
+	IB_WR_REG_MR = 0x20,
 	IB_WR_REG_SIG_MR,
+
 	/* reserve values for low level drivers' internal use.
 	 * These values will not be used at all in the ib core layer.
 	 */
diff --git a/include/uapi/rdma/ib_user_verbs.h b/include/uapi/rdma/ib_user_verbs.h
index e0e83a105953..e11b4def8630 100644
--- a/include/uapi/rdma/ib_user_verbs.h
+++ b/include/uapi/rdma/ib_user_verbs.h
@@ -751,10 +751,28 @@ struct ib_uverbs_sge {
 	__u32 lkey;
 };
 
+enum ib_uverbs_wr_opcode {
+	IB_UVERBS_WR_RDMA_WRITE = 0,
+	IB_UVERBS_WR_RDMA_WRITE_WITH_IMM = 1,
+	IB_UVERBS_WR_SEND = 2,
+	IB_UVERBS_WR_SEND_WITH_IMM = 3,
+	IB_UVERBS_WR_RDMA_READ = 4,
+	IB_UVERBS_WR_ATOMIC_CMP_AND_SWP = 5,
+	IB_UVERBS_WR_ATOMIC_FETCH_AND_ADD = 6,
+	IB_UVERBS_WR_LOCAL_INV = 7,
+	IB_UVERBS_WR_BIND_MW = 8,
+	IB_UVERBS_WR_SEND_WITH_INV = 9,
+	IB_UVERBS_WR_TSO = 10,
+	IB_UVERBS_WR_RDMA_READ_WITH_INV = 11,
+	IB_UVERBS_WR_MASKED_ATOMIC_CMP_AND_SWP = 12,
+	IB_UVERBS_WR_MASKED_ATOMIC_FETCH_AND_ADD = 13,
+	/* Review enum ib_wr_opcode before modifying this */
+};
+
 struct ib_uverbs_send_wr {
 	__u64 wr_id;
 	__u32 num_sge;
-	__u32 opcode;
+	__u32 opcode;		/* see enum ib_uverbs_wr_opcode */
 	__u32 send_flags;
 	union {
 		__u32 imm_data;
-- 
2.20.1

