Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C901BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AFD20674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414379;
	bh=qcEG6w2/GDNSrFO6+mPfxkBVtMr5NJCSsxklqfbSFtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mfS6PGaOqRnB5+IfVdN7Z+0fR0D+zG6fgNQDrFxMIDOL1AnjJaLcSjV+qekrjRt2g
	 EmK7S6i/yOyS6d9hZ8I+iUpKOdVY3HUeHL1KlegZC/DUmGGRUfM0WN+GLN1xg3rC/h
	 Cf833NcVaLFd8wAEH3oIDLoe9BQFI20Uemasv3U4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfLCWtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:49:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbfLCWs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:48:57 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7820120803;
        Tue,  3 Dec 2019 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413336;
        bh=qcEG6w2/GDNSrFO6+mPfxkBVtMr5NJCSsxklqfbSFtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iE5UI842XUTyffcfAcf2lmYp3XTg6OW9RUJURlEZ0oWjViP4EncfaCzU15PnZgkSw
         4dypExn5sj1dsYTKqb56zaQfgFfnQRCzGjLKSfA9uTWf5QI2pPP6L3dse0IJ33UvxB
         hzOkCiIcuX/8bSKn4qb2xfbuhR2afD3pfAE5zZGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/321] scsi: lpfc: Fix dif and first burst use in write commands
Date:   Tue,  3 Dec 2019 23:31:55 +0100
Message-Id: <20191203223429.659802243@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 7c4042a4d0b7532cfbc90478fd3084b2dab5849e ]

When dif and first burst is used in a write command wqe, the driver was not
properly setting fields in the io command request. This resulted in no dif
bytes being sent and invalid xfer_rdy's, resulting in the io being aborted
by the hardware.

Correct the wqe initializaton when both dif and first burst are used.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 666495f21c246..425b83618a2e5 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -2732,6 +2732,7 @@ lpfc_bg_scsi_prep_dma_buf_s3(struct lpfc_hba *phba,
 	int datasegcnt, protsegcnt, datadir = scsi_cmnd->sc_data_direction;
 	int prot_group_type = 0;
 	int fcpdl;
+	struct lpfc_vport *vport = phba->pport;
 
 	/*
 	 * Start the lpfc command prep by bumping the bpl beyond fcp_cmnd
@@ -2837,6 +2838,14 @@ lpfc_bg_scsi_prep_dma_buf_s3(struct lpfc_hba *phba,
 	 */
 	iocb_cmd->un.fcpi.fcpi_parm = fcpdl;
 
+	/*
+	 * For First burst, we may need to adjust the initial transfer
+	 * length for DIF
+	 */
+	if (iocb_cmd->un.fcpi.fcpi_XRdy &&
+	    (fcpdl < vport->cfg_first_burst_size))
+		iocb_cmd->un.fcpi.fcpi_XRdy = fcpdl;
+
 	return 0;
 err:
 	if (lpfc_cmd->seg_cnt)
@@ -3401,6 +3410,7 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 	int datasegcnt, protsegcnt, datadir = scsi_cmnd->sc_data_direction;
 	int prot_group_type = 0;
 	int fcpdl;
+	struct lpfc_vport *vport = phba->pport;
 
 	/*
 	 * Start the lpfc command prep by bumping the sgl beyond fcp_cmnd
@@ -3516,6 +3526,14 @@ lpfc_bg_scsi_prep_dma_buf_s4(struct lpfc_hba *phba,
 	 */
 	iocb_cmd->un.fcpi.fcpi_parm = fcpdl;
 
+	/*
+	 * For First burst, we may need to adjust the initial transfer
+	 * length for DIF
+	 */
+	if (iocb_cmd->un.fcpi.fcpi_XRdy &&
+	    (fcpdl < vport->cfg_first_burst_size))
+		iocb_cmd->un.fcpi.fcpi_XRdy = fcpdl;
+
 	/*
 	 * If the OAS driver feature is enabled and the lun is enabled for
 	 * OAS, set the oas iocb related flags.
-- 
2.20.1



