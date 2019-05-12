Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476D5C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA22217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jluMCum4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfELHfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:35:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43030 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfELHe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:34:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id c6so5462227pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 00:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tJij42jMZNA/RCdgMXUgkIF3wZNG+3vGAUeH3k8Od1M=;
        b=jluMCum4vO8FQf/7J8/CkknphoGKgcgI4VBYWDQsVhDgqpV+Too559TBFyjD7zgKfu
         D/dlYX3Vnf5VANGEd5jbgwkCC5rZFEmiw6PFiOz0THlFzn+xs3oItl5V19YTeUM5gZVN
         nt5Q0U3YiA3vbcQQB78/r/4/p3OOzUgQoB69iY8+Emg9soNLx4cTawwvY+x+nniwQnLO
         ZOzUOBM0I4GprAO0P4XrZK6FBNcaW+/7nGE6v3DglLYvgJzYaRweXOW/fdcHg9SkEt8m
         vjistPIYyz4TNNfTSfGr11muGKmZOTN58F9eic++xC9dbbSOQLhPMzX0JMuVa37TyzrA
         43lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tJij42jMZNA/RCdgMXUgkIF3wZNG+3vGAUeH3k8Od1M=;
        b=aj7xmcs4BOZDLzaTP0uVTDBF6iQIhO3ndawpAxAQxnomfrZMuqwH1sSVMVlH+dd7tJ
         PL/AFYQqubAsBc6YZdYGJBqG7VtwkJK1V9iD5+kZ4spJILl8Tu4BCjipP64Ic/YtYZWy
         thhFjYTZS5TUJIjI5HJVMHwlSb+dlh2/GTcpk40Ob6+Clyt8l8ctKTraM606fA0Ot+Rl
         x+CYa1Vsw22dU9X1NWda4t+Z/a2CPhQFS2P3T+zZnmdP5X7bTK+lJzscFsWh3fLr4wFz
         +gY5r/DsFmeMHjySK1hAven5QWyQlS1crjA+bLgMQ6ivC0pdYISX9k1n4MpgpXVKH4i4
         YU+Q==
X-Gm-Message-State: APjAAAWcZcztcU6/N0BbZoOWIqwpoyZRU7dw7t3Bg3tiymyg1sei5qtK
        xNDGw/ClfFdNRwkmjCHwbolNU/bNMW8=
X-Google-Smtp-Source: APXvYqyXFF+l9d400wplio9bVT1xUhp00uJ5v9kGooX1hdRRHjXQl6akdG0V24q0/XfqeJ0du2xMHw==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr466019pgp.372.1557646496098;
        Sun, 12 May 2019 00:34:56 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e123sm5492242pgc.29.2019.05.12.00.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 00:34:55 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH V3 5/5] nvme-trace: Add tracing for req_comp in target
Date:   Sun, 12 May 2019 16:34:13 +0900
Message-Id: <20190512073413.32050-6-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can have the common tracing code with different event entries.
  - nvme_complete_rq
  - nvmet_req_complete

This patch updates existing TRACE_EVENT to a template to provide a
common tracing interface.

We can have it as a common code because most of the fields need to be
printed out for both host and target system.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c   |  2 +-
 drivers/nvme/target/core.c |  3 +++
 drivers/nvme/trace.c       |  1 +
 drivers/nvme/trace.h       | 51 ++++++++++++++++++++++++++++++--------
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 39e49e9948c3..f377ed039a83 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -260,7 +260,7 @@ void nvme_complete_rq(struct request *req)
 {
 	blk_status_t status = nvme_error_status(req);
 
-	trace_nvme_complete_rq(req);
+	trace_nvme_complete_rq(NVME_TRACE_HOST, req);
 
 	if (nvme_req(req)->ctrl->kas)
 		nvme_req(req)->ctrl->comp_seen = true;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 10b3b3767f91..0f184abe432f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -690,6 +690,9 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 
 	if (unlikely(status))
 		nvmet_set_error(req, status);
+
+	trace_nvmet_req_complete(NVME_TRACE_TARGET, req);
+
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
 	req->ops->queue_response(req);
diff --git a/drivers/nvme/trace.c b/drivers/nvme/trace.c
index 8fe2dcee6a42..8071b60ec71d 100644
--- a/drivers/nvme/trace.c
+++ b/drivers/nvme/trace.c
@@ -222,3 +222,4 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_async_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvmet_req_init);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvmet_req_complete);
diff --git a/drivers/nvme/trace.h b/drivers/nvme/trace.h
index afda9c2ab4a1..0674bb85ac66 100644
--- a/drivers/nvme/trace.h
+++ b/drivers/nvme/trace.h
@@ -181,9 +181,9 @@ DEFINE_EVENT(nvme__cmd_begin, nvmet_req_init,
 	TP_ARGS(type, req, cmd)
 );
 
-TRACE_EVENT(nvme_complete_rq,
-	    TP_PROTO(struct request *req),
-	    TP_ARGS(req),
+DECLARE_EVENT_CLASS(nvme__cmd_end,
+	    TP_PROTO(enum nvme_trace_type type, void *req),
+	    TP_ARGS(type, req),
 	    TP_STRUCT__entry(
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, ctrl_id)
@@ -195,20 +195,49 @@ TRACE_EVENT(nvme_complete_rq,
 		__field(u16, status)
 	    ),
 	    TP_fast_assign(
-		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
-		__entry->qid = nvme_req_qid(req);
-		__entry->cid = req->tag;
-		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
-		__entry->retries = nvme_req(req)->retries;
-		__entry->flags = nvme_req(req)->flags;
-		__entry->status = nvme_req(req)->status;
-		__assign_disk_name(__entry->disk, req->rq_disk);
+		if (type != NVME_TRACE_TARGET) {
+			struct request *req = (struct request *) req;
+
+			__entry->ctrl_id = nvme_req(req)->ctrl->instance;
+			__entry->qid = nvme_req_qid(req);
+			__entry->cid = req->tag;
+			__entry->result =
+					le64_to_cpu(nvme_req(req)->result.u64);
+			__entry->retries = nvme_req(req)->retries;
+			__entry->flags = nvme_req(req)->flags;
+			__entry->status = nvme_req(req)->status;
+			__assign_disk_name(__entry->disk, req->rq_disk);
+		} else {
+			struct nvmet_ctrl *ctrl = nvmet_req_to_ctrl(req);
+			struct nvmet_cq *cq = ((struct nvmet_req *) req)->cq;
+			struct nvme_completion *cqe =
+					((struct nvmet_req *) req)->cqe;
+			struct nvmet_ns *ns = ((struct nvmet_req *) req)->ns;
+
+			__entry->ctrl_id = ctrl ? ctrl->cntlid : 0;
+			__entry->qid = cq->qid;
+			__entry->cid = cqe->command_id;
+			__entry->result = cqe->result.u64;
+			__entry->flags = 0;
+			__entry->status = cqe->status >> 1;
+			__assign_disk_name(__entry->disk, ns ?
+						ns->bdev->bd_disk : NULL);
+		}
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, res=%llu, retries=%u, flags=0x%x, status=%u",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
 		      __entry->qid, __entry->cid, __entry->result,
 		      __entry->retries, __entry->flags, __entry->status)
+);
+
+DEFINE_EVENT(nvme__cmd_end, nvme_complete_rq,
+	TP_PROTO(enum nvme_trace_type type, void *req),
+	TP_ARGS(type, req)
+);
 
+DEFINE_EVENT(nvme__cmd_end, nvmet_req_complete,
+	TP_PROTO(enum nvme_trace_type type, void *req),
+	TP_ARGS(type, req)
 );
 
 #define aer_name(aer) { aer, #aer }
-- 
2.17.1

