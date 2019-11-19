Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76B6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9859222DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141507;
	bh=lTCx1fao8rSjs1HsCWHXN5FTFBsGcEklA2XINxZ1/+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hV57L7wKK+ndz7e9hpRm3fefBTe3+JgMEanzQMBqwAviP8K/PTi7VQQ8q2xg7r5dM
	 0iQ6rvLl9X4CzpnkOck4xsMjUtdWXcC0UppVhfWWwbOgx2cVTQynrNJ3SdNTE0YBlo
	 UxVvQPB1aO1EW8WLIMBRUfLByzhjZUrs6nKDcTuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfKSFbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:31:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729289AbfKSFbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:31:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB001222A2;
        Tue, 19 Nov 2019 05:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141501;
        bh=lTCx1fao8rSjs1HsCWHXN5FTFBsGcEklA2XINxZ1/+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1aRPLeMdDzX8RHOuM09n44yy/9ZZGAuJbDf+SOhBmdX4t30DwJPpIzfRIQWrhMS09
         3EGNYLPtWYF2UqbSM5KfK9hYPB1TaTZTl8C7RQJx4gY9XK/GJNEoti6IRY4uawBO63
         p5xUSPwI2y1i6+h2rWZFNxN0JP9/7Ot3n9r5aOUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 180/422] scsi: lpfc: Fix errors in log messages.
Date:   Tue, 19 Nov 2019 06:16:17 +0100
Message-Id: <20191119051410.122875018@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
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
index 645ffb5332b4a..8ee585e453dcf 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -282,7 +282,7 @@ lpfc_nvme_delete_queue(struct nvme_fc_local_port *pnvme_lport,
 	vport = lport->vport;
 
 	lpfc_printf_vlog(vport, KERN_INFO, LOG_NVME,
-			"6001 ENTER.  lpfc_pnvme %p, qidx x%xi qhandle %p\n",
+			"6001 ENTER.  lpfc_pnvme %p, qidx x%x qhandle %p\n",
 			lport, qidx, handle);
 	kfree(handle);
 }
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 22efefcc6cd84..768eba8c111d9 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1340,15 +1340,14 @@ lpfc_nvmet_setup_io_context(struct lpfc_hba *phba)
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



