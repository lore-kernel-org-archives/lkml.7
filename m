Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7648C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7C62186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731533AbfDEOAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:00:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49642 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730554AbfDEOAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:00:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44FBB1A25;
        Fri,  5 Apr 2019 07:00:51 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 675AF3F68F;
        Fri,  5 Apr 2019 07:00:47 -0700 (PDT)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-arch@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 16/21] drivers: Remove useless trailing comments from mmiowb() invocations
Date:   Fri,  5 Apr 2019 14:59:31 +0100
Message-Id: <20190405135936.7266-17-will.deacon@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405135936.7266-1-will.deacon@arm.com>
References: <20190405135936.7266-1-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for using coccinelle to remove all mmiowb() instances
from drivers, remove all trailing comments since they won't be picked up
by spatch later on and will end up being preserved in the code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/infiniband/hw/hfi1/chip.c                | 2 +-
 drivers/infiniband/hw/qedr/verbs.c               | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h  | 2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 612f04190ed8..12e67a91e578 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -8365,7 +8365,7 @@ static inline void clear_recv_intr(struct hfi1_ctxtdata *rcd)
 	struct hfi1_devdata *dd = rcd->dd;
 	u32 addr = CCE_INT_CLEAR + (8 * rcd->ireg);
 
-	mmiowb();	/* make sure everything before is written */
+	mmiowb();
 	write_csr(dd, addr, rcd->imask);
 	/* force the above write on the chip and get a value back */
 	(void)read_csr(dd, addr);
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 59ad4202422c..4dab2b5ffb0e 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -3700,7 +3700,7 @@ int qedr_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 		if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 			writel(qp->rq.iwarp_db2_data.raw, qp->rq.iwarp_db2);
-			mmiowb();	/* for second doorbell */
+			mmiowb();
 		}
 
 		wr = wr->next;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index 2462e7aa0c5d..1ed068509337 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -527,7 +527,7 @@ static inline void bnx2x_update_rx_prod(struct bnx2x *bp,
 		REG_WR_RELAXED(bp, fp->ustorm_rx_prods_offset + i * 4,
 			       ((u32 *)&rx_prods)[i]);
 
-	mmiowb(); /* keep prod updates ordered */
+	mmiowb();
 
 	DP(NETIF_MSG_RX_STATUS,
 	   "queue[%d]:  wrote  bd_prod %u  cqe_prod %u  sge_prod %u\n",
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index 626b491f7674..e46786a56b0c 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -5244,7 +5244,7 @@ static void bnx2x_update_eq_prod(struct bnx2x *bp, u16 prod)
 {
 	/* No memory barriers */
 	storm_memset_eq_prod(bp, prod, BP_FUNC(bp));
-	mmiowb(); /* keep prod updates ordered */
+	mmiowb();
 }
 
 static int  bnx2x_cnic_handle_cfc_del(struct bnx2x *bp, u32 cid,
diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index fae6f71e677d..d56a78f411cd 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -280,7 +280,7 @@ static void bnx2i_ring_sq_dbell(struct bnx2i_conn *bnx2i_conn, int count)
 	} else
 		writew(count, ep->qp.ctx_base + CNIC_SEND_DOORBELL);
 
-	mmiowb(); /* flush posted PCI writes */
+	mmiowb();
 }
 
 
-- 
2.11.0

