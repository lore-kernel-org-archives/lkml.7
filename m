Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D57CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C1F20650
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436604AbfJWQgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:36:25 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48578 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407309AbfJWQgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:36:02 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc4-0006Vu-8I; Wed, 23 Oct 2019 10:36:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc2-00016b-P6; Wed, 23 Oct 2019 10:35:54 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 23 Oct 2019 10:35:41 -0600
Message-Id: <20191023163545.4193-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023163545.4193-1-logang@deltatee.com>
References: <20191023163545.4193-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 3/7] nvmet: Introduce common execute function for get_log_page and identify
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of picking the sub-command handler to execute in a nested
switch statement introduce a landing functions that calls out
to the appropriate sub-command handler.

This will allow us to have a common place in the handler to check
the transfer length in a future patch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[logang@deltatee.com: separated out of a larger draft patch from hch]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/admin-cmd.c | 93 ++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 831a062d27cb..3665b45d6515 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -282,6 +282,33 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_get_log_page(struct nvmet_req *req)
+{
+	switch (req->cmd->get_log_page.lid) {
+	case NVME_LOG_ERROR:
+		return nvmet_execute_get_log_page_error(req);
+	case NVME_LOG_SMART:
+		return nvmet_execute_get_log_page_smart(req);
+	case NVME_LOG_FW_SLOT:
+		/*
+		 * We only support a single firmware slot which always is
+		 * active, so we can zero out the whole firmware slot log and
+		 * still claim to fully implement this mandatory log page.
+		 */
+		return nvmet_execute_get_log_page_noop(req);
+	case NVME_LOG_CHANGED_NS:
+		return nvmet_execute_get_log_changed_ns(req);
+	case NVME_LOG_CMD_EFFECTS:
+		return nvmet_execute_get_log_cmd_effects_ns(req);
+	case NVME_LOG_ANA:
+		return nvmet_execute_get_log_page_ana(req);
+	}
+	pr_err("unhandled lid %d on qid %d\n",
+	       req->cmd->get_log_page.lid, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -565,6 +592,25 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_identify(struct nvmet_req *req)
+{
+	switch (req->cmd->identify.cns) {
+	case NVME_ID_CNS_NS:
+		return nvmet_execute_identify_ns(req);
+	case NVME_ID_CNS_CTRL:
+		return nvmet_execute_identify_ctrl(req);
+	case NVME_ID_CNS_NS_ACTIVE_LIST:
+		return nvmet_execute_identify_nslist(req);
+	case NVME_ID_CNS_NS_DESC_LIST:
+		return nvmet_execute_identify_desclist(req);
+	}
+
+	pr_err("unhandled identify cns %d on qid %d\n",
+	       req->cmd->identify.cns, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_identify, cns);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 /*
  * A "minimum viable" abort implementation: the command is mandatory in the
  * spec, but we are not required to do any useful work.  We couldn't really
@@ -819,52 +865,13 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_get_log_page:
+		req->execute = nvmet_execute_get_log_page;
 		req->data_len = nvmet_get_log_page_len(cmd);
-
-		switch (cmd->get_log_page.lid) {
-		case NVME_LOG_ERROR:
-			req->execute = nvmet_execute_get_log_page_error;
-			return 0;
-		case NVME_LOG_SMART:
-			req->execute = nvmet_execute_get_log_page_smart;
-			return 0;
-		case NVME_LOG_FW_SLOT:
-			/*
-			 * We only support a single firmware slot which always
-			 * is active, so we can zero out the whole firmware slot
-			 * log and still claim to fully implement this mandatory
-			 * log page.
-			 */
-			req->execute = nvmet_execute_get_log_page_noop;
-			return 0;
-		case NVME_LOG_CHANGED_NS:
-			req->execute = nvmet_execute_get_log_changed_ns;
-			return 0;
-		case NVME_LOG_CMD_EFFECTS:
-			req->execute = nvmet_execute_get_log_cmd_effects_ns;
-			return 0;
-		case NVME_LOG_ANA:
-			req->execute = nvmet_execute_get_log_page_ana;
-			return 0;
-		}
-		break;
+		return 0;
 	case nvme_admin_identify:
+		req->execute = nvmet_execute_identify;
 		req->data_len = NVME_IDENTIFY_DATA_SIZE;
-		switch (cmd->identify.cns) {
-		case NVME_ID_CNS_NS:
-			req->execute = nvmet_execute_identify_ns;
-			return 0;
-		case NVME_ID_CNS_CTRL:
-			req->execute = nvmet_execute_identify_ctrl;
-			return 0;
-		case NVME_ID_CNS_NS_ACTIVE_LIST:
-			req->execute = nvmet_execute_identify_nslist;
-			return 0;
-		case NVME_ID_CNS_NS_DESC_LIST:
-			req->execute = nvmet_execute_identify_desclist;
-			return 0;
-		}
-		break;
+		return 0;
 	case nvme_admin_abort_cmd:
 		req->execute = nvmet_execute_abort;
 		req->data_len = 0;
-- 
2.20.1

