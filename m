Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FB3C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CE921019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCkHxLcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfELHe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:34:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45180 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfELHex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:34:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id i21so5102803pgi.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BMFvu0ZnMLh8JvCf75o+D0wJeqDw0qugkHDuv47z45c=;
        b=tCkHxLcO4hctswaPBY+/1bhjkpTr4LJY4jrdz2AtWoz1k1npW570sP3GL828uSDhRK
         S0yO8gSuMfyFVWkWg8A2RVVYsK4QEYx46EcUluMrEzHrrnUOoaxQ5utHTfGN4veKk6z4
         /9bE8iwuVk2U+hKqxXO6ENkrDKBthQCEgKGdENmq4U+p0YXI0hIwuUIrvly53M67zVy7
         b9d17uGWDxGtZlhQmXxOjdKphcFmoV686LO96uYiPEcNKuOanqKIHlQXifMrKAQJOXJF
         EKKxSY3qG9rJkZU6xa9IiGckbdvvIgErNrkPfZJdR2qkvaEnur0+cRwflqnD0El4V8iP
         CrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BMFvu0ZnMLh8JvCf75o+D0wJeqDw0qugkHDuv47z45c=;
        b=VglwBiweylH1aQb9IZZJd6d5POARQr4z2tdZNt5FZDoBRZNbn9zsRZA7yEVv5xMimQ
         FKZiDIID6rdU/RuM/c3QFf6CLDA3Ea/3MfC7dGw/6nPhEPMhlVeUltAXSi/FtboIZ7Qh
         ZS+UQvjzzcTx3yyVhbZdcmVcM/oocdo/48Ak1+XWQc57qgmQxjBaM1HQZ9/eQkMDMbPG
         uA1kdTnWOH5TuGQgLcsdne2VjZ6Xld8HdGxf6umDGnKjqj5wWt27+zrD04Grvj/nrM5Z
         cvYTO2A2ZINJaI1tXJnw1eFLLREiH10BgHaW1knKKnRvrT0s6Fts/UZ5v1k6ifRWz4R2
         B3yg==
X-Gm-Message-State: APjAAAUAhTbarjYZjvmSZCDdyEQPPNErnV0tI+YykyXpKXVoi72zDrOP
        IRGLryEqbrAc27tC325pIWzrkZJcZKo=
X-Google-Smtp-Source: APXvYqzjGqNE6jMGHoPLO94d8Q3pipoifuF2Kc2OZw8sCYoufqTN7oWoRTKPIMb7kIfj5R9A5xb6eg==
X-Received: by 2002:a63:3:: with SMTP id 3mr24128547pga.360.1557646492713;
        Sun, 12 May 2019 00:34:52 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e123sm5492242pgc.29.2019.05.12.00.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 00:34:52 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH V3 4/5] nvme-trace: Add tracing for req_init in trarget
Date:   Sun, 12 May 2019 16:34:12 +0900
Message-Id: <20190512073413.32050-5-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can have the common tracing code with different event entries.
  - nvme_setup_cmd
  - nvmet_req_init

This patch updates existing TRACE_EVENT to a template to provide a
common tracing interface.  More than that, nvme_setup_cmd entry point
has been defined as an event referring template made.

It also introduces tracing at the point of request creation for the
target system.  This might be useful to figure out what kind of
request has been received in the target.

Here's the example of target tracing introduced with RDMA:
kworker/0:1H-1043  [000] ....   276.785946: nvmet_req_init: nvme0: qid=0, cmdid=0, nsid=1, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_connect recfmt=0, qid=0, sqsize=31, cattr=0, kato=0)
kworker/0:1H-1043  [000] ....   276.789893: nvmet_req_init: nvme1: qid=0, cmdid=10, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=1, ofst=0x0)
kworker/0:1H-1043  [000] ....   276.791781: nvmet_req_init: nvme1: qid=0, cmdid=11, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_set attrib=0, ofst=0x14, value=0x460001)
kworker/0:1H-1043  [000] ....   276.794799: nvmet_req_init: nvme1: qid=0, cmdid=12, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=0, ofst=0x1c)
kworker/0:1H-1043  [000] ....   276.796804: nvmet_req_init: nvme1: qid=0, cmdid=13, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=0, ofst=0x8)
kworker/0:1H-1043  [000] ....   276.799163: nvmet_req_init: nvme1: qid=0, cmdid=10, nsid=4, flags=0x40, meta=0x0, cmd=(nvme_fabrics_type_property_get attrib=1, ofst=0x0)
kworker/0:1H-1043  [000] ....   276.801070: nvmet_req_init: nvme1: qid=0, cmdid=11, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_identify cns=1, ctrlid=0)
kworker/0:1H-1043  [000] ....   276.817592: nvmet_req_init: nvme1: qid=0, cmdid=12, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_get_log_page cdw10=70 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
kworker/0:1H-1043  [000] ....   276.822963: nvmet_req_init: nvme1: qid=0, cmdid=13, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_get_log_page cdw10=70 00 ff 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)
kworker/0:1H-1043  [000] ....   276.831908: nvmet_req_init: nvme1: qid=0, cmdid=10, nsid=0, flags=0x40, meta=0x0, cmd=(nvme_admin_get_log_page cdw10=70 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00)

Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c    |  2 +-
 drivers/nvme/target/core.c  |  3 +++
 drivers/nvme/target/nvmet.h |  9 +++++++
 drivers/nvme/trace.c        |  2 ++
 drivers/nvme/trace.h        | 50 ++++++++++++++++++++++++++++++++-----
 5 files changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae76c0b78a5f..39e49e9948c3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -732,7 +732,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
-	trace_nvme_setup_cmd(req, cmd);
+	trace_nvme_setup_cmd(NVME_TRACE_HOST, req, cmd);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_setup_cmd);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index da2ea97042af..10b3b3767f91 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -10,6 +10,7 @@
 #include <linux/pci-p2pdma.h>
 #include <linux/scatterlist.h>
 
+#include "../trace.h"
 #include "nvmet.h"
 
 struct workqueue_struct *buffered_io_wq;
@@ -848,6 +849,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->error_loc = NVMET_NO_ERROR_LOC;
 	req->error_slba = 0;
 
+	trace_nvmet_req_init(NVME_TRACE_TARGET, req, req->cmd);
+
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c25d88fc9dec..2d569a1dc3f4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -318,6 +318,15 @@ struct nvmet_req {
 	u64			error_slba;
 };
 
+static inline struct nvmet_ctrl *nvmet_req_to_ctrl(struct nvmet_req *req)
+{
+	struct nvmet_sq *sq = req->sq;
+
+	if (sq)
+		return sq->ctrl;
+	return NULL;
+}
+
 extern struct workqueue_struct *buffered_io_wq;
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
diff --git a/drivers/nvme/trace.c b/drivers/nvme/trace.c
index 88dfadb68b92..8fe2dcee6a42 100644
--- a/drivers/nvme/trace.c
+++ b/drivers/nvme/trace.c
@@ -220,3 +220,5 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_setup_cmd);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_complete_rq);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_async_event);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nvme_sq);
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(nvmet_req_init);
diff --git a/drivers/nvme/trace.h b/drivers/nvme/trace.h
index 7fbfd6cb815c..afda9c2ab4a1 100644
--- a/drivers/nvme/trace.h
+++ b/drivers/nvme/trace.h
@@ -15,6 +15,7 @@
 #include <linux/trace_seq.h>
 
 #include "host/nvme.h"
+#include "target/nvmet.h"
 
 #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
 #define show_admin_opcode_name(val)					\
@@ -103,11 +104,17 @@ static inline void __assign_disk_name(char *name, struct gendisk *disk)
 	else
 		memset(name, 0, DISK_NAME_LEN);
 }
+
+enum nvme_trace_type {
+	NVME_TRACE_HOST,
+	NVME_TRACE_TARGET,
+};
 #endif
 
-TRACE_EVENT(nvme_setup_cmd,
-	    TP_PROTO(struct request *req, struct nvme_command *cmd),
-	    TP_ARGS(req, cmd),
+DECLARE_EVENT_CLASS(nvme__cmd_begin,
+	    TP_PROTO(enum nvme_trace_type type, void *req,
+		     struct nvme_command *cmd),
+	    TP_ARGS(type, req, cmd),
 	    TP_STRUCT__entry(
 		__array(char, disk, DISK_NAME_LEN)
 		__field(int, ctrl_id)
@@ -121,15 +128,28 @@ TRACE_EVENT(nvme_setup_cmd,
 		__array(u8, cdw10, 24)
 	    ),
 	    TP_fast_assign(
-		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
-		__entry->qid = nvme_req_qid(req);
+		if (type != NVME_TRACE_TARGET) {
+			__entry->ctrl_id = nvme_req(req)->ctrl->instance;
+			__entry->qid = nvme_req_qid(req);
+			__assign_disk_name(__entry->disk,
+					((struct request *) req)->rq_disk);
+		} else {
+			struct nvmet_ctrl *ctrl = nvmet_req_to_ctrl(req);
+			struct nvmet_sq *sq = ((struct nvmet_req *) req)->sq;
+			struct nvmet_ns *ns = ((struct nvmet_req *) req)->ns;
+
+			__entry->ctrl_id = ctrl ? ctrl->cntlid : 0;
+			__entry->qid = sq ? sq->qid : 0;
+			__assign_disk_name(__entry->disk, ns ?
+						ns->bdev->bd_disk : NULL);
+		}
+
 		__entry->opcode = cmd->common.opcode;
 		__entry->flags = cmd->common.flags;
 		__entry->cid = cmd->common.command_id;
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->fctype = __entry->nsid & 0xff;
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
-		__assign_disk_name(__entry->disk, req->rq_disk);
 		memcpy(__entry->cdw10, &cmd->common.cdw10,
 			sizeof(__entry->cdw10));
 	    ),
@@ -143,6 +163,24 @@ TRACE_EVENT(nvme_setup_cmd,
 					__entry->fctype, __entry->cdw10))
 );
 
+/*
+ * @req: (struct request *) req needs to be here for nvme common commands
+ */
+DEFINE_EVENT(nvme__cmd_begin, nvme_setup_cmd,
+	TP_PROTO(enum nvme_trace_type type, void *req,
+		 struct nvme_command *cmd),
+	TP_ARGS(type, req, cmd)
+);
+
+/*
+ * @req: (struct nvmet_req *) req needs to be here for nvme fabrics commands
+ */
+DEFINE_EVENT(nvme__cmd_begin, nvmet_req_init,
+	TP_PROTO(enum nvme_trace_type type, void *req,
+		 struct nvme_command *cmd),
+	TP_ARGS(type, req, cmd)
+);
+
 TRACE_EVENT(nvme_complete_rq,
 	    TP_PROTO(struct request *req),
 	    TP_ARGS(req),
-- 
2.17.1

