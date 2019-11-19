Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ADDC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5852071B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142490;
	bh=TQNxn8PQb6pfkKLulXH3rqOfZl5w2skxGNN/p3loGqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IX2bYHsjPJk9bDAzHE/ofhXkxk8SxeyZF0K1tsa94mF8XKJ0uEIeJbmvfIxg4OfUS
	 Ag5LtDqWqcZ8ZIHZUV6mxJLT8HigkOISeGPu7bo7R+vDZ/BHeIlOMiM3BQH+I0JeS/
	 n70PJfhdpj11bRgxnA4Tyb76yc23UbdjoRQnssgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbfKSFsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfKSFsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:48:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7626B208C3;
        Tue, 19 Nov 2019 05:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142485;
        bh=TQNxn8PQb6pfkKLulXH3rqOfZl5w2skxGNN/p3loGqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1zNdVURH5M+ypCHl9b61YKJtQ6wvkUXwSN6YjNCzlFJvuLGl1WDG2Y2ge7az5PR/y
         6nVe+55hv1ANkn5SK66JoP0fWnKBpG0VnpnI+UDWZU3gPTkkZW8xHwChaYjeSa3ODJ
         gs+iIcnfUmCKcTqZHc7XHgu1zJ8/X90PS5lvkMRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 098/239] scsi: lpfc: Fix errors in log messages.
Date:   Tue, 19 Nov 2019 06:18:18 +0100
Message-Id: <20191119051323.580192078@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 2879265f514b1f4154288243c91438ddbedb3ed4 ]

Message 6408 is displayed for each entry in an array, but the cpu and queue
numbers were incorrect for the entry.  Message 6001 includes an extraneous
character.

Resolve both issues

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <james.smart@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c  | 2 +-
 drivers/scsi/lpfc/lpfc_nvmet.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 23bdb1ca106e4..6c4499db969c1 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -144,7 +144,7 @@ lpfc_nvme_delete_queue(struct nvme_fc_local_port *pnvme_lport,
 	vport = lport->vport;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
-			"6001 ENTER.  lpfc_pnvme %p, qidx x%xi qhandle %p\n",
+			"6001 ENTER.  lpfc_pnvme %p, qidx x%x qhandle %p\n",
 			lport, qidx, handle);
 	kfree(handle);
 }
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 7ac1a067d7801..eacdcb931bdab 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1078,15 +1078,14 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
 			idx = 0;
 	}
 
-	infop = phba->sli4_hba.nvmet_ctx_info;
-	for (j = 0; j < phba->cfg_nvmet_mrq; j++) {
-		for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
+	for (i = 0; i < phba->sli4_hba.num_present_cpu; i++) {
+		for (j = 0; j < phba->cfg_nvmet_mrq; j++) {
+			infop = lpfc_get_ctx_list(phba, i, j);
 			lpfc_printf_log(phba, KERN_INFO, LOG_NVME | LOG_INIT,
 					"6408 TOTAL NVMET ctx for CPU %d "
 					"MRQ %d: cnt %d nextcpu %p\n",
 					i, j, infop->nvmet_ctx_list_cnt,
 					infop->nvmet_ctx_next_cpu);
-			infop++;
 		}
 	}
 	return 0;
-- 
2.20.1



