Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D0C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EF721775
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519248;
	bh=n7PqSwoJjQXmFCR1Rqf7AvkCzyPbm8XeHudT4zxom2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ODeJLBOqyhhi3eGjNycx4nfOeqUrJgkbvpaxFyJGVLSewiYmIvKp96e3qI6mnZ/Au
	 AkQmcmiaiXMXdjTg2aAepnJftPCvoTBeMJKHZkCOPAzl9tPAUHU5DmWBCv5nlRG5gp
	 x0hP3694BrV1HyzxvKoYYiD1WoKWXcKkI1SnY42Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbfLPSAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbfLPSAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7453220717;
        Mon, 16 Dec 2019 18:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519233;
        bh=n7PqSwoJjQXmFCR1Rqf7AvkCzyPbm8XeHudT4zxom2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBXEcPHk3pou2wYY1eu6L8Dc1jMbiocP9o0hBqztjwo+zlS0iq0HkrO+N7zK2EHPj
         gXje/JdVTtnfSLFDQ1oDWAobMzVcFLQYccB7ZV78b0eYZbR+ea/YauPLBfcV1876Jz
         kgpSp75lMiSVjA1RGriVryCdCFJjCMZiMmLPKW+A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 250/267] scsi: lpfc: Correct code setting non existent bits in sli4 ABORT WQE
Date:   Mon, 16 Dec 2019 18:49:36 +0100
Message-Id: <20191216174916.311797196@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 1c36833d82ff24d0d54215fd956e7cc30fffce54 ]

Driver is setting bits in word 10 of the SLI4 ABORT WQE (the wqid).  The
field was a carry over from a prior SLI revision. The field does not exist
in SLI4, and the action may result in an overlap with future definition of
the WQE.

Remove the setting of WQID in the ABORT WQE.

Also cleaned up WQE field settings - initialize to zero, don't bother to
set fields to zero.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_nvme.c |  2 --
 drivers/scsi/lpfc/lpfc_sli.c  | 14 +++-----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 6c4499db969c1..fcf4b4175d771 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1544,7 +1544,6 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	bf_set(abort_cmd_criteria, &abts_wqe->abort_cmd, T_XRI_TAG);
 
 	/* word 7 */
-	bf_set(wqe_ct, &abts_wqe->abort_cmd.wqe_com, 0);
 	bf_set(wqe_cmnd, &abts_wqe->abort_cmd.wqe_com, CMD_ABORT_XRI_CX);
 	bf_set(wqe_class, &abts_wqe->abort_cmd.wqe_com,
 	       nvmereq_wqe->iocb.ulpClass);
@@ -1559,7 +1558,6 @@ lpfc_nvme_fcp_abort(struct nvme_fc_local_port *pnvme_lport,
 	       abts_buf->iotag);
 
 	/* word 10 */
-	bf_set(wqe_wqid, &abts_wqe->abort_cmd.wqe_com, nvmereq_wqe->hba_wqidx);
 	bf_set(wqe_qosd, &abts_wqe->abort_cmd.wqe_com, 1);
 	bf_set(wqe_lenloc, &abts_wqe->abort_cmd.wqe_com, LPFC_WQE_LENLOC_NONE);
 
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 62bea4ffdc25a..d3bad0dbfaf7f 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -10722,19 +10722,12 @@ lpfc_sli4_abort_nvme_io(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 	/* Complete prepping the abort wqe and issue to the FW. */
 	abts_wqe = &abtsiocbp->wqe;
-	bf_set(abort_cmd_ia, &abts_wqe->abort_cmd, 0);
-	bf_set(abort_cmd_criteria, &abts_wqe->abort_cmd, T_XRI_TAG);
-
-	/* Explicitly set reserved fields to zero.*/
-	abts_wqe->abort_cmd.rsrvd4 = 0;
-	abts_wqe->abort_cmd.rsrvd5 = 0;
 
-	/* WQE Common - word 6.  Context is XRI tag.  Set 0. */
-	bf_set(wqe_xri_tag, &abts_wqe->abort_cmd.wqe_com, 0);
-	bf_set(wqe_ctxt_tag, &abts_wqe->abort_cmd.wqe_com, 0);
+	/* Clear any stale WQE contents */
+	memset(abts_wqe, 0, sizeof(union lpfc_wqe));
+	bf_set(abort_cmd_criteria, &abts_wqe->abort_cmd, T_XRI_TAG);
 
 	/* word 7 */
-	bf_set(wqe_ct, &abts_wqe->abort_cmd.wqe_com, 0);
 	bf_set(wqe_cmnd, &abts_wqe->abort_cmd.wqe_com, CMD_ABORT_XRI_CX);
 	bf_set(wqe_class, &abts_wqe->abort_cmd.wqe_com,
 	       cmdiocb->iocb.ulpClass);
@@ -10749,7 +10742,6 @@ lpfc_sli4_abort_nvme_io(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	       abtsiocbp->iotag);
 
 	/* word 10 */
-	bf_set(wqe_wqid, &abts_wqe->abort_cmd.wqe_com, cmdiocb->hba_wqidx);
 	bf_set(wqe_qosd, &abts_wqe->abort_cmd.wqe_com, 1);
 	bf_set(wqe_lenloc, &abts_wqe->abort_cmd.wqe_com, LPFC_WQE_LENLOC_NONE);
 
-- 
2.20.1



