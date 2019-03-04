Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A475C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2D220836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688456;
	bh=KH2HEWqZB1p1MDITrIUNbFYsAvJKTR/Oz/Sed/XdKdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KOpHnnVn5Q03aK9bEB1nVSlJcpG8ZWLyMIpx3nHgfJ8sKWERzXKvUZdIcr/LTZ/fo
	 YOlurl58OfC3XllgSKvESFUUsF7KPzGqQtF3gPz3qtk65huxQsyhLe7173LlYyI+Cw
	 KI/nLJsEo+E1/6S6QyCNLdPlUdvlw51p6c7WOFC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCDIeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbfCDIeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E8820823;
        Mon,  4 Mar 2019 08:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688449;
        bh=KH2HEWqZB1p1MDITrIUNbFYsAvJKTR/Oz/Sed/XdKdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdgItVKfxgUaxFFe8guo1pIZ49b2gs5fTXUr8kkjIVjlLV71q2HMHLrq3DAygyUFw
         YhSYj94Y/BjVoKKKma84ftnHzpqMGwKus9KPqH145to9NNxHM7N82ggnNvZPTmLDAN
         RL94bacqW6QkvVAg4df7gweBvlsTt4e+W11EI3mA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Ewan D. Milne" <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 47/88] scsi: lpfc: nvmet: avoid hang / use-after-free when destroying targetport
Date:   Mon,  4 Mar 2019 09:22:30 +0100
Message-Id: <20190304081632.419080774@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c41f59884be5cca293ed61f3d64637dbba3a6381 ]

We cannot wait on a completion object in the lpfc_nvme_targetport structure
in the _destroy_targetport() code path because the NVMe/fc transport will
free that structure immediately after the .targetport_delete() callback.
This results in a use-after-free, and a hang if slub_debug=FZPU is enabled.

Fix this by putting the completion on the stack.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Acked-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 8 +++++---
 drivers/scsi/lpfc/lpfc_nvmet.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 6245f442d784b..95fee83090eb7 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1003,7 +1003,8 @@ lpfc_nvmet_targetport_delete(struct nvmet_fc_target_port *targetport)
 	struct lpfc_nvmet_tgtport *tport = targetport->private;
 
 	/* release any threads waiting for the unreg to complete */
-	complete(&tport->tport_unreg_done);
+	if (tport->phba->targetport)
+		complete(tport->tport_unreg_cmp);
 }
 
 static void
@@ -1692,6 +1693,7 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 	struct lpfc_nvmet_tgtport *tgtp;
 	struct lpfc_queue *wq;
 	uint32_t qidx;
+	DECLARE_COMPLETION_ONSTACK(tport_unreg_cmp);
 
 	if (phba->nvmet_support == 0)
 		return;
@@ -1701,9 +1703,9 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 			wq = phba->sli4_hba.nvme_wq[qidx];
 			lpfc_nvmet_wqfull_flush(phba, wq, NULL);
 		}
-		init_completion(&tgtp->tport_unreg_done);
+		tgtp->tport_unreg_cmp = &tport_unreg_cmp;
 		nvmet_fc_unregister_targetport(phba->targetport);
-		wait_for_completion_timeout(&tgtp->tport_unreg_done, 5);
+		wait_for_completion_timeout(&tport_unreg_cmp, 5);
 		lpfc_nvmet_cleanup_io_context(phba);
 	}
 	phba->targetport = NULL;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
index 1aaff63f1f419..0ec1082ce7ef6 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.h
+++ b/drivers/scsi/lpfc/lpfc_nvmet.h
@@ -34,7 +34,7 @@
 /* Used for NVME Target */
 struct lpfc_nvmet_tgtport {
 	struct lpfc_hba *phba;
-	struct completion tport_unreg_done;
+	struct completion *tport_unreg_cmp;
 
 	/* Stats counters - lpfc_nvmet_unsol_ls_buffer */
 	atomic_t rcv_ls_req_in;
-- 
2.19.1



