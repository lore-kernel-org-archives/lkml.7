Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3E9C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3AC21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB9/pI1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfGBH6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:58:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35149 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBH6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:58:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so7291067pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UIzjHWkZLAMXu3z2VIzdhxp0HBEBGaRAZZzENhi457w=;
        b=TB9/pI1pIqLZYE+nYoqd9aSMONqK95pHtjWfqeXNQIPX8yoZWms7C9XONZw8jLaBV+
         0kUJxcV0gnSvMHtuGAij4ECWErBn1+4gOvxvyqKo/cDnJbK5STNTcnLN3vsgQnwt+YsH
         kSHMDuX6WzEDC/1iGMPf2FOZfPLdk1RcqXz0UDEeVirqsqhbKZNX3wPujKh56WcFVLqF
         YZN8I77PzkBvi50V7sO8mFHQCyO88Z3eoDVnieaRa28bgY+9+k2oDlWTb41tB5++u/OO
         FUnCDrv9pIIR6G1ZP5eM73QlOGUzD8FwjG684lJtM93O5J8yl8gIpckr/xcHs7PON4kG
         yAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UIzjHWkZLAMXu3z2VIzdhxp0HBEBGaRAZZzENhi457w=;
        b=ZeJeXxltCvwwrTG5K+mdCzd0Tmkis7ABV8zF/uzcMWm2SyeAtyg6oMgXgsZ9XGVc03
         osY1wUkIohNLuzPDEnMMuBqQY30mprauuc4QNX4cRAU0Nxzvf3y+giBg+tv0PlPcJyki
         7jj5Gy2L5MzjkdKYetqLt6YTn0AH9n+enbQT+tkbScCFEjFIcSAzp3mjyQh6+PFa/xTS
         2o4xfNrOFhBsIIuJssVcNufAc12Dd7sKHHl5d+s00u14ZZHjk9m41RexEAfsD0hD8Th3
         qI1AmSyl4/LxyhceVBVZYnNSzMZxWLMEjkkde+EyZx4fT4Deo6ZlkTap7hujJEFDeBUB
         AI3g==
X-Gm-Message-State: APjAAAXBoazUIlIMFL6TH1fMmU192A+koaa/mi9qJgDEuEIiY2KbGcJa
        eb7tCT0dJVpK/lH8HzrUJoS8CanwHYU=
X-Google-Smtp-Source: APXvYqwBOVJ5Zol0Ig8MJUk1McZENkJBTrIbtc0F9Bj7SSG+58fPR/UpAamK36DVbgPXNOZNlpgPAQ==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr30411509pgr.52.1562054280191;
        Tue, 02 Jul 2019 00:58:00 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f10sm14255422pfd.151.2019.07.02.00.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:57:59 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 09/27] infiniband: remove unneeded memset
Date:   Tue,  2 Jul 2019 15:57:52 +0800
Message-Id: <20190702075752.23927-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_alloc_consistent calls dma_alloc_coherent directly.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent/dmam_alloc_coherent has already zeroed the memory.
So the memset after these 3 function calls is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/infiniband/hw/cxgb3/cxio_hal.c        | 3 ---
 drivers/infiniband/hw/cxgb4/cq.c              | 1 -
 drivers/infiniband/hw/cxgb4/qp.c              | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    | 1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c    | 3 ---
 drivers/infiniband/hw/mthca/mthca_allocator.c | 2 --
 drivers/infiniband/hw/nes/nes_verbs.c         | 3 ---
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c      | 3 ---
 drivers/infiniband/ulp/ipoib/ipoib_cm.c       | 1 -
 9 files changed, 18 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb3/cxio_hal.c b/drivers/infiniband/hw/cxgb3/cxio_hal.c
index 8ac72ac7cbac..0e37f55678f8 100644
--- a/drivers/infiniband/hw/cxgb3/cxio_hal.c
+++ b/drivers/infiniband/hw/cxgb3/cxio_hal.c
@@ -174,7 +174,6 @@ int cxio_create_cq(struct cxio_rdev *rdev_p, struct t3_cq *cq, int kernel)
 		return -ENOMEM;
 	}
 	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
-	memset(cq->queue, 0, size);
 	setup.id = cq->cqid;
 	setup.base_addr = (u64) (cq->dma_addr);
 	setup.size = 1UL << cq->size_log2;
@@ -538,8 +537,6 @@ static int cxio_hal_init_ctrl_qp(struct cxio_rdev *rdev_p)
 	dma_unmap_addr_set(&rdev_p->ctrl_qp, mapping,
 			   rdev_p->ctrl_qp.dma_addr);
 	rdev_p->ctrl_qp.doorbell = (void __iomem *)rdev_p->rnic_info.kdb_addr;
-	memset(rdev_p->ctrl_qp.workq, 0,
-	       (1 << T3_CTRL_QP_SIZE_LOG2) * sizeof(union t3_wr));
 
 	mutex_init(&rdev_p->ctrl_qp.lock);
 	init_waitqueue_head(&rdev_p->ctrl_qp.waitq);
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4/cq.c
index 52ce586621c6..fcd161e3495b 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -104,7 +104,6 @@ static int create_cq(struct c4iw_rdev *rdev, struct t4_cq *cq,
 		goto err3;
 	}
 	dma_unmap_addr_set(cq, mapping, cq->dma_addr);
-	memset(cq->queue, 0, cq->memsize);
 
 	if (user && ucontext->is_32b_cqe) {
 		cq->qp_errp = &((struct t4_status_page *)
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
index e92b9544357a..4882dcbb7d20 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -274,7 +274,6 @@ static int create_qp(struct c4iw_rdev *rdev, struct t4_wq *wq,
 			 (unsigned long long)virt_to_phys(wq->sq.queue),
 			 wq->rq.queue,
 			 (unsigned long long)virt_to_phys(wq->rq.queue));
-		memset(wq->rq.queue, 0, wq->rq.memsize);
 		dma_unmap_addr_set(&wq->rq, mapping, wq->rq.dma_addr);
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index e068a02122f5..36d9dcaaa8f9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4265,7 +4265,6 @@ static int hns_roce_v1_create_eq(struct hns_roce_dev *hr_dev,
 		}
 
 		eq->buf_list[i].map = tmp_dma_addr;
-		memset(eq->buf_list[i].buf, 0, HNS_ROCE_BA_SIZE);
 	}
 	eq->cons_index = 0;
 	roce_set_field(tmp, ROCEE_CAEP_AEQC_AEQE_SHIFT_CAEP_AEQC_STATE_M,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b5392cb5b20f..a4a7c5962916 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1774,7 +1774,6 @@ static int hns_roce_init_link_table(struct hns_roce_dev *hr_dev,
 			goto err_alloc_buf_failed;
 
 		link_tbl->pg_list[i].map = t;
-		memset(link_tbl->pg_list[i].buf, 0, buf_chk_sz);
 
 		entry[i].blk_ba0 = (t >> 12) & 0xffffffff;
 		roce_set_field(entry[i].blk_ba1_nxt_ptr,
@@ -5387,8 +5386,6 @@ static int hns_roce_mhop_alloc_eq(struct hns_roce_dev *hr_dev,
 		eq->cur_eqe_ba = eq->l0_dma;
 		eq->nxt_eqe_ba = 0;
 
-		memset(eq->bt_l0, 0, eq->entries * eq->eqe_size);
-
 		return 0;
 	}
 
diff --git a/drivers/infiniband/hw/mthca/mthca_allocator.c b/drivers/infiniband/hw/mthca/mthca_allocator.c
index aaf10dd5364d..aef1d274a14e 100644
--- a/drivers/infiniband/hw/mthca/mthca_allocator.c
+++ b/drivers/infiniband/hw/mthca/mthca_allocator.c
@@ -214,8 +214,6 @@ int mthca_buf_alloc(struct mthca_dev *dev, int size, int max_direct,
 
 		dma_unmap_addr_set(&buf->direct, mapping, t);
 
-		memset(buf->direct.buf, 0, size);
-
 		while (t & ((1 << shift) - 1)) {
 			--shift;
 			npages *= 2;
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index 49024326a518..534f978f1a58 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -828,7 +828,6 @@ static int nes_setup_virt_qp(struct nes_qp *nesqp, struct nes_pbl *nespbl,
 		kunmap(nesqp->page);
 		return -ENOMEM;
 	}
-	memset(nesqp->pbl_vbase, 0, 256);
 	/* fill in the page address in the pbl buffer.. */
 	tpbl = pblbuffer + 16;
 	pbl = (__le64 *)nespbl->pbl_vbase;
@@ -898,8 +897,6 @@ static int nes_setup_mmap_qp(struct nes_qp *nesqp, struct nes_vnic *nesvnic,
 			"host descriptor rings located @ %p (pa = 0x%08lX.) size = %u.\n",
 			mem, (unsigned long)nesqp->hwqp.sq_pbase, nesqp->qp_mem_size);
 
-	memset(mem, 0, nesqp->qp_mem_size);
-
 	nesqp->hwqp.sq_vbase = mem;
 	mem += sizeof(struct nes_hw_qp_wqe) * sq_size;
 
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
index 5127e2ea4bdd..6e07712eb3ed 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_hw.c
@@ -1351,7 +1351,6 @@ static int ocrdma_mbx_get_ctrl_attribs(struct ocrdma_dev *dev)
 	mqe->u.nonemb_req.sge[0].pa_hi = (u32) upper_32_bits(dma.pa);
 	mqe->u.nonemb_req.sge[0].len = dma.size;
 
-	memset(dma.va, 0, dma.size);
 	ocrdma_init_mch((struct ocrdma_mbx_hdr *)dma.va,
 			OCRDMA_CMD_GET_CTRL_ATTRIBUTES,
 			OCRDMA_SUBSYS_COMMON,
@@ -1690,7 +1689,6 @@ static int ocrdma_mbx_create_ah_tbl(struct ocrdma_dev *dev)
 		goto mem_err_ah;
 	dev->av_tbl.pa = pa;
 	dev->av_tbl.num_ah = max_ah;
-	memset(dev->av_tbl.va, 0, dev->av_tbl.size);
 
 	pbes = (struct ocrdma_pbe *)dev->av_tbl.pbl.va;
 	for (i = 0; i < dev->av_tbl.size / OCRDMA_MIN_Q_PAGE_SIZE; i++) {
@@ -2905,7 +2903,6 @@ static int ocrdma_mbx_get_dcbx_config(struct ocrdma_dev *dev, u32 ptype,
 	mqe_sge->pa_hi = (u32) upper_32_bits(pa);
 	mqe_sge->len = cmd.hdr.pyld_len;
 
-	memset(req, 0, sizeof(struct ocrdma_get_dcbx_cfg_req));
 	ocrdma_init_mch(&req->hdr, OCRDMA_CMD_GET_DCBX_CONFIG,
 			OCRDMA_SUBSYS_DCBX, cmd.hdr.pyld_len);
 	req->param_type = ptype;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
index aa9dcfc36cd3..c59e00a0881f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -1153,7 +1153,6 @@ static int ipoib_cm_tx_init(struct ipoib_cm_tx *p, u32 qpn,
 		ret = -ENOMEM;
 		goto err_tx;
 	}
-	memset(p->tx_ring, 0, ipoib_sendq_size * sizeof(*p->tx_ring));
 
 	p->qp = ipoib_cm_create_tx_qp(p->dev, p);
 	memalloc_noio_restore(noio_flag);
-- 
2.11.0

