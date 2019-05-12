Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDBDC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112622173E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 07:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQE4Ueoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfELHey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 03:34:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43023 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbfELHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 03:34:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so5462141pfa.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 00:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LxI7s+V++JAUvOzarfFiJnaM3JwJCysE+CC40eBNLc8=;
        b=lQE4UeoirsFtysm0qU3i7hjaUNULmUhDM8+GN4GaJCnSNFV/I4gcr7o8MONqDNUXs6
         xdNgoVJFyO0QO7TYLgKlFJAMJ2w1p3WomIUuELCgaPoCdj+uBxECJqi1NQmAb2hZWedR
         GSeNV+SzqlQNEfzmc+aLsEK7WsVf4PJQgUd4IuYa8xI5Vml78AzcmkLcznD1byN3Oql8
         Rn/UQgEVu0CXyMDsE8ifKKgrPSufRDTyhMVYx/MUmErijcWDOcjFUg0jXwvUs5/XW1Z4
         sevIJXcJtDOcW8JYp1MgircTI2pBub7AW+a3jCtOj/vzR2E5O0wmxvLr3jzGay/qDH/j
         gk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LxI7s+V++JAUvOzarfFiJnaM3JwJCysE+CC40eBNLc8=;
        b=BRsvwjrT5xoCPmFkSK6r8gcq65yTTWivtm3Ws+c7AasU8IoZpGKgp+Z26oUgrVYtoj
         LWo4tB5V+Wl12xxKLJBOIGsOsOmz8+C+DN7rTUGKhGtibj2VlEXbRsDlRTVck4Iy1jpf
         Lhstj8HaQkWEecvGs2qpL3SAVCykPnVM/73MdnRdEg8Db09WyUdEz5BTZDqX1i+UhPZb
         nnsg68fdO5qAhwwYa++9C3ZHgvhDlUwqHFaEttWWy3kR4k6bYSyci15WPcxtMvRLmca4
         69Drpi1BWcZYZzp0Jt2OD9vwcaiiniiOX+EM2jNYEr4CXxqFl7dJKEwE5NfMJK6K/pvu
         gCGw==
X-Gm-Message-State: APjAAAXwxNXk0N3Av5EB6CEDiFd1MuUcZZ1vTCvJfcXoKtA2ra8WFy3N
        zpD9HMkI7WkwEGCrMvDd2cQpvw0sk/g=
X-Google-Smtp-Source: APXvYqwpGui4ENh4OlcIb4IcGFyh9EZpGYtB2wX1uYLEC0fgRSvCh6me/ZkbHZmapADChM7CfBMItg==
X-Received: by 2002:a63:e550:: with SMTP id z16mr24771296pgj.329.1557646489304;
        Sun, 12 May 2019 00:34:49 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id e123sm5492242pgc.29.2019.05.12.00.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 00:34:48 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH V3 3/5] nvme: Introduce nvme_is_fabrics to check fabrics cmd
Date:   Sun, 12 May 2019 16:34:11 +0900
Message-Id: <20190512073413.32050-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
References: <20190512073413.32050-1-minwoo.im.dev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a nvme_is_fabrics() inline function to check
whether or not the given command structure is for fabrics.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>
Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/fabrics.c       | 2 +-
 drivers/nvme/target/core.c        | 2 +-
 drivers/nvme/target/fabrics-cmd.c | 2 +-
 drivers/nvme/target/fc.c          | 2 +-
 include/linux/nvme.h              | 7 ++++++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 592d1e61ef7e..931995f2dbc3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -578,7 +578,7 @@ bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	switch (ctrl->state) {
 	case NVME_CTRL_NEW:
 	case NVME_CTRL_CONNECTING:
-		if (req->cmd->common.opcode == nvme_fabrics_command &&
+		if (nvme_is_fabrics(req->cmd) &&
 		    req->cmd->fabrics.fctype == nvme_fabrics_type_connect)
 			return true;
 		break;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7734a6acff85..da2ea97042af 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -871,7 +871,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		status = nvmet_parse_connect_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
-	else if (req->cmd->common.opcode == nvme_fabrics_command)
+	else if (nvme_is_fabrics(req->cmd))
 		status = nvmet_parse_fabrics_cmd(req);
 	else if (req->sq->ctrl->subsys->type == NVME_NQN_DISC)
 		status = nvmet_parse_discovery_cmd(req);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 3b9f79aba98f..d16b55ffe79f 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -268,7 +268,7 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
 
-	if (cmd->common.opcode != nvme_fabrics_command) {
+	if (!nvme_is_fabrics(cmd)) {
 		pr_err("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 508661af0f50..a59c5a013a5c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1806,7 +1806,7 @@ nvmet_fc_prep_fcp_rsp(struct nvmet_fc_tgtport *tgtport,
 	 */
 	rspcnt = atomic_inc_return(&fod->queue->zrspcnt);
 	if (!(rspcnt % fod->queue->ersp_ratio) ||
-	    sqe->opcode == nvme_fabrics_command ||
+	    nvme_is_fabrics((struct nvme_command *) sqe) ||
 	    xfr_length != fod->req.transfer_len ||
 	    (le16_to_cpu(cqe->status) & 0xFFFE) || cqewd[0] || cqewd[1] ||
 	    (sqe->flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND)) ||
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c40720cb59ac..ab5e9392b42d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1165,6 +1165,11 @@ struct nvme_command {
 	};
 };
 
+static inline bool nvme_is_fabrics(struct nvme_command *cmd)
+{
+	return cmd->common.opcode == nvme_fabrics_command;
+}
+
 struct nvme_error_slot {
 	__le64		error_count;
 	__le16		sqid;
@@ -1186,7 +1191,7 @@ static inline bool nvme_is_write(struct nvme_command *cmd)
 	 *
 	 * Why can't we simply have a Fabrics In and Fabrics out command?
 	 */
-	if (unlikely(cmd->common.opcode == nvme_fabrics_command))
+	if (unlikely(nvme_is_fabrics(cmd)))
 		return cmd->fabrics.fctype & 1;
 	return cmd->common.opcode & 1;
 }
-- 
2.17.1

