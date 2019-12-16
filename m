Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1224C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742512072D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519238;
	bh=TrE3X/sVzFQzP/TNSPD+qtrx90TpPubFW52PJryieCw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DFEvgJWPI24QVJ4mVyEhCRMa9SDcoam6QL2TaErKrsOvOKH5pJWEs8lZni7LBFp9Q
	 u5NjaKfIJ9JYvL1ljEbHZlIDTyTNqfnQ1Tz778k2EuSPgHwG6z7oWIoLzdSlddqueS
	 60YnhTaC8lB5tX457RbD7Upn8gNsOAerahwvNT+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfLPSAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:00:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbfLPSAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0078320726;
        Mon, 16 Dec 2019 18:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519231;
        bh=TrE3X/sVzFQzP/TNSPD+qtrx90TpPubFW52PJryieCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyFyheR4NWiHGtEOeozbc2/IAXclCH5YxQqZm91kVLkroMbPJX/UlofbkfgtTgwyt
         eVEe7uTSJG6Ox/9WIx5tLyihFbAvNuSs8qjTfjyJ+aOsTfoQSx3eCDlc9vGklLrrNd
         4z87Q7zdzl8YdsC947y2Zcb1KNfuA0cOstNUEKIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 249/267] scsi: lpfc: Cap NPIV vports to 256
Date:   Mon, 16 Dec 2019 18:49:35 +0100
Message-Id: <20191216174916.243549675@linuxfoundation.org>
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

[ Upstream commit 8b47ae69e049ae0b3373859d901f0334322f9fe9 ]

Depending on the chipset, the number of NPIV vports may vary and be in
excess of what most switches support (256). To avoid confusion with the
users, limit the reported NPIV vports to 256.

Additionally correct the 16G adapter which is reporting a bogus NPIV vport
number if the link is down.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc.h      |  3 ++-
 drivers/scsi/lpfc/lpfc_attr.c | 12 ++++++++++--
 drivers/scsi/lpfc/lpfc_init.c |  3 +++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 03e95a3216c8c..5fc41aa53ceb3 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -969,7 +969,8 @@ struct lpfc_hba {
 	struct list_head port_list;
 	struct lpfc_vport *pport;	/* physical lpfc_vport pointer */
 	uint16_t max_vpi;		/* Maximum virtual nports */
-#define LPFC_MAX_VPI 0xFFFF		/* Max number of VPI supported */
+#define LPFC_MAX_VPI	0xFF		/* Max number VPI supported 0 - 0xff */
+#define LPFC_MAX_VPORTS	0x100		/* Max vports per port, with pport */
 	uint16_t max_vports;            /*
 					 * For IOV HBAs max_vpi can change
 					 * after a reset. max_vports is max
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 82ce5d1930189..f447355cc9c04 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1478,6 +1478,9 @@ lpfc_get_hba_info(struct lpfc_hba *phba,
 		max_vpi = (bf_get(lpfc_mbx_rd_conf_vpi_count, rd_config) > 0) ?
 			(bf_get(lpfc_mbx_rd_conf_vpi_count, rd_config) - 1) : 0;
 
+		/* Limit the max we support */
+		if (max_vpi > LPFC_MAX_VPI)
+			max_vpi = LPFC_MAX_VPI;
 		if (mvpi)
 			*mvpi = max_vpi;
 		if (avpi)
@@ -1493,8 +1496,13 @@ lpfc_get_hba_info(struct lpfc_hba *phba,
 			*axri = pmb->un.varRdConfig.avail_xri;
 		if (mvpi)
 			*mvpi = pmb->un.varRdConfig.max_vpi;
-		if (avpi)
-			*avpi = pmb->un.varRdConfig.avail_vpi;
+		if (avpi) {
+			/* avail_vpi is only valid if link is up and ready */
+			if (phba->link_state == LPFC_HBA_READY)
+				*avpi = pmb->un.varRdConfig.avail_vpi;
+			else
+				*avpi = pmb->un.varRdConfig.max_vpi;
+		}
 	}
 
 	mempool_free(pmboxq, phba->mbox_mem_pool);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index c69c2a2b2eadf..9fc5507ee39e7 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7643,6 +7643,9 @@ lpfc_sli4_read_config(struct lpfc_hba *phba)
 			bf_get(lpfc_mbx_rd_conf_xri_base, rd_config);
 		phba->sli4_hba.max_cfg_param.max_vpi =
 			bf_get(lpfc_mbx_rd_conf_vpi_count, rd_config);
+		/* Limit the max we support */
+		if (phba->sli4_hba.max_cfg_param.max_vpi > LPFC_MAX_VPORTS)
+			phba->sli4_hba.max_cfg_param.max_vpi = LPFC_MAX_VPORTS;
 		phba->sli4_hba.max_cfg_param.vpi_base =
 			bf_get(lpfc_mbx_rd_conf_vpi_base, rd_config);
 		phba->sli4_hba.max_cfg_param.max_rpi =
-- 
2.20.1



