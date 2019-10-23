Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FA6CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC67120650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436552AbfJWQgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:36:03 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48554 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407300AbfJWQgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:36:00 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc4-0006Vy-8G; Wed, 23 Oct 2019 10:35:59 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc3-00016n-3f; Wed, 23 Oct 2019 10:35:55 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 23 Oct 2019 10:35:45 -0600
Message-Id: <20191023163545.4193-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023163545.4193-1-logang@deltatee.com>
References: <20191023163545.4193-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 7/7] nvmet: Open code nvmet_req_execute()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that nvmet_req_execute does nothing, open code it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[logang@deltatee.com: separated out of a larger draft patch from hch]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/core.c  | 6 ------
 drivers/nvme/target/fc.c    | 4 ++--
 drivers/nvme/target/loop.c  | 2 +-
 drivers/nvme/target/nvmet.h | 1 -
 drivers/nvme/target/rdma.c  | 4 ++--
 drivers/nvme/target/tcp.c   | 6 +++---
 6 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 87fe82ccfa89..f7da0e50beeb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -942,12 +942,6 @@ bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len)
 }
 EXPORT_SYMBOL_GPL(nvmet_check_data_len);
 
-void nvmet_req_execute(struct nvmet_req *req)
-{
-	req->execute(req);
-}
-EXPORT_SYMBOL_GPL(nvmet_req_execute);
-
 int nvmet_req_alloc_sgl(struct nvmet_req *req)
 {
 	struct pci_dev *p2p_dev = NULL;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ce8d819f86cc..7f9c11138b93 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2015,7 +2015,7 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
 		}
 
 		/* data transfer complete, resume with nvmet layer */
-		nvmet_req_execute(&fod->req);
+		fod->req.execute(&fod->req);
 		break;
 
 	case NVMET_FCOP_READDATA:
@@ -2231,7 +2231,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	 * can invoke the nvmet_layer now. If read data, cmd completion will
 	 * push the data
 	 */
-	nvmet_req_execute(&fod->req);
+	fod->req.execute(&fod->req);
 	return;
 
 transport_error:
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 11f5aea97d1b..f4b878b113f7 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -126,7 +126,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
 	struct nvme_loop_iod *iod =
 		container_of(work, struct nvme_loop_iod, work);
 
-	nvmet_req_execute(&iod->req);
+	iod->req.execute(&iod->req);
 }
 
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ff55f1005b35..46df45e837c9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -374,7 +374,6 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		struct nvmet_sq *sq, const struct nvmet_fabrics_ops *ops);
 void nvmet_req_uninit(struct nvmet_req *req);
 bool nvmet_check_data_len(struct nvmet_req *req, size_t data_len);
-void nvmet_req_execute(struct nvmet_req *req);
 void nvmet_req_complete(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgl(struct nvmet_req *req);
 void nvmet_req_free_sgl(struct nvmet_req *req);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 36d906a7f70d..248e68da2e13 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -603,7 +603,7 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
-	nvmet_req_execute(&rsp->req);
+	rsp->req.execute(&rsp->req);
 }
 
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
@@ -746,7 +746,7 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 				queue->cm_id->port_num, &rsp->read_cqe, NULL))
 			nvmet_req_complete(&rsp->req, NVME_SC_DATA_XFER_ERROR);
 	} else {
-		nvmet_req_execute(&rsp->req);
+		rsp->req.execute(&rsp->req);
 	}
 
 	return true;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 3378480c49f6..af674fc0bb1e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -930,7 +930,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	nvmet_req_execute(&queue->cmd->req);
+	queue->cmd->req.execute(&queue->cmd->req);
 out:
 	nvmet_prepare_receive_pdu(queue);
 	return ret;
@@ -1050,7 +1050,7 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			nvmet_tcp_prep_recv_ddgst(cmd);
 			return 0;
 		}
-		nvmet_req_execute(&cmd->req);
+		cmd->req.execute(&cmd->req);
 	}
 
 	nvmet_prepare_receive_pdu(queue);
@@ -1090,7 +1090,7 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len)
-		nvmet_req_execute(&cmd->req);
+		cmd->req.execute(&cmd->req);
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
-- 
2.20.1

