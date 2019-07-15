Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2549C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5896220644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vA92cRdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbfGODUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:20:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36742 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbfGODUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:20:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so6739203pfl.3;
        Sun, 14 Jul 2019 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U+GJSBFysOXn8idbgoGkTg/e2yOO2zOFtecZg4yWsYY=;
        b=vA92cRdzKSCDGtjQJusSvHO99Zc4yWSzcSKh79enHLa6LDMPY52tuwPqfk3mrG5NvV
         Zmu3UPApVJwoSLEKQcgZV2WHIdeZ67M0iZ3JTKWP8mZGRIFmnXOgc7f9k1hZf/TqPkLD
         Ce0BWCZrfIydBMncUDgf9Wx0yeLPIsbCuV0fcuJdhfS3T1YwyEzaGV0r/CHmJ8acl2q4
         f9jJisdr7DdFhsx/EOP8OtrDruR+eT03WfbuYHYCx/53O4Ee+tlGQGVCYrUBZOIcGDdw
         RxOGwacr62v4qj5TJLtlvYMiWyMhaPYkOpfJZtvelVK96wQF6qh/SBlqgybFi3kzr9cj
         TQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U+GJSBFysOXn8idbgoGkTg/e2yOO2zOFtecZg4yWsYY=;
        b=j0OsWHllnydgRuYAsaQZ6VTzXEycVqBoMMhi3bLo8vyHOPrWHgfjQcHwROGFE/J9tp
         5yeCDtxRfpjCbY1RXDJObOJIghg+OMfXzhbQ1FmPgC5DUtJEdcGIsbuivNTLHcn1eMz+
         v1z49tSmyLoGtY+5Ke5QRIyKCh324mVp1T2F83ZMXbaQMM7GnT6sYJCyBFi0USpYR5dI
         TgZdf2CqcJdT0YFCd9upOmzbuSxqLthblpudO3ko8nmpWQcU7aaFtbtdWpzcUIv+UEXL
         Acod0FgupD8iL7VQ1y6UF2+yrL+3kAPbKbMInXO13nE3GLEzTlWkJ52eGbiB9nP/Ldmy
         DLPg==
X-Gm-Message-State: APjAAAXp/WBQ/bOPEnsd9km5GAhLxW4EmidhZCCa/S1BKwZFXwCMEmdN
        jKifUmYd3KJcubPXFXN2SUk=
X-Google-Smtp-Source: APXvYqw8g6DB1ZLVCMo1O5OjMg3VCGdjB6hjAnhZnFtdfeA1/RFpvar4DeyzMCSpbuFzrjFDfKmyxg==
X-Received: by 2002:a63:4e5f:: with SMTP id o31mr25055996pgl.49.1563160800701;
        Sun, 14 Jul 2019 20:20:00 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id c69sm18420592pje.6.2019.07.14.20.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 20:20:00 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Adam Radford <aradford@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        QLogic-Storage-Upstream@qlogic.com,
        Bradley Grove <linuxdrivers@attotech.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Hannes Reinecke <hare@kernel.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 21/24] scsi: Remove redundant memset
Date:   Mon, 15 Jul 2019 11:19:51 +0800
Message-Id: <20190715031951.7166-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcalloc already zeros the memory during allocation.
In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So the memset after these functions is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 drivers/scsi/3w-9xxx.c                    | 2 --
 drivers/scsi/3w-xxxx.c                    | 2 --
 drivers/scsi/aacraid/rx.c                 | 1 -
 drivers/scsi/arcmsr/arcmsr_hba.c          | 1 -
 drivers/scsi/be2iscsi/be_iscsi.c          | 1 -
 drivers/scsi/bfa/bfad.c                   | 1 -
 drivers/scsi/bnx2fc/bnx2fc_io.c           | 2 --
 drivers/scsi/dpt_i2o.c                    | 4 ----
 drivers/scsi/esas2r/esas2r_init.c         | 1 -
 drivers/scsi/ips.c                        | 2 --
 drivers/scsi/lpfc/lpfc_init.c             | 2 --
 drivers/scsi/megaraid/megaraid_sas_base.c | 2 --
 drivers/scsi/mpt3sas/mpt3sas_transport.c  | 2 --
 drivers/scsi/mvsas/mv_init.c              | 4 ----
 drivers/scsi/myrs.c                       | 1 -
 drivers/scsi/pmcraid.c                    | 1 -
 drivers/scsi/qla4xxx/ql4_mbx.c            | 1 -
 drivers/scsi/qla4xxx/ql4_os.c             | 2 --
 drivers/scsi/qlogicpti.c                  | 2 --
 19 files changed, 34 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 3337b1e80412..da17d9104e6b 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -534,8 +534,6 @@ static int twa_allocate_memory(TW_Device_Extension *tw_dev, int size, int which)
 		goto out;
 	}
 
-	memset(cpu_addr, 0, size*TW_Q_LENGTH);
-
 	for (i = 0; i < TW_Q_LENGTH; i++) {
 		switch(which) {
 		case 0:
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index 2b1e0d503020..26703ef52a2e 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -848,8 +848,6 @@ static int tw_allocate_memory(TW_Device_Extension *tw_dev, int size, int which)
 		return 1;
 	}
 
-	memset(cpu_addr, 0, size*TW_Q_LENGTH);
-
 	for (i=0;i<TW_Q_LENGTH;i++) {
 		switch(which) {
 		case 0:
diff --git a/drivers/scsi/aacraid/rx.c b/drivers/scsi/aacraid/rx.c
index 3dea348bd25d..4d3484cbca26 100644
--- a/drivers/scsi/aacraid/rx.c
+++ b/drivers/scsi/aacraid/rx.c
@@ -353,7 +353,6 @@ static int aac_rx_check_health(struct aac_dev *dev)
 			dma_free_coherent(&dev->pdev->dev, 512, buffer, baddr);
 			return ret;
 		}
-		memset(buffer, 0, 512);
 		post->Post_Command = cpu_to_le32(COMMAND_POST_RESULTS);
 		post->Post_Address = cpu_to_le32(baddr);
 		rx_writel(dev, MUnit.IMRx[0], paddr);
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 88053b15c363..a0d0dc83184f 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -727,7 +727,6 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 	}
 	acb->dma_coherent = dma_coherent;
 	acb->dma_coherent_handle = dma_coherent_handle;
-	memset(dma_coherent, 0, acb->uncache_size);
 	acb->ccbsize = roundup_ccbsize;
 	ccb_tmp = dma_coherent;
 	curr_phy_upper32 = upper_32_bits(dma_coherent_handle);
diff --git a/drivers/scsi/be2iscsi/be_iscsi.c b/drivers/scsi/be2iscsi/be_iscsi.c
index 2058d50d62e1..09d63bac6d80 100644
--- a/drivers/scsi/be2iscsi/be_iscsi.c
+++ b/drivers/scsi/be2iscsi/be_iscsi.c
@@ -1081,7 +1081,6 @@ static int beiscsi_open_conn(struct iscsi_endpoint *ep,
 		return -ENOMEM;
 	}
 	nonemb_cmd.size = req_memsize;
-	memset(nonemb_cmd.va, 0, nonemb_cmd.size);
 	tag = mgmt_open_connection(phba, dst_addr, beiscsi_ep, &nonemb_cmd);
 	if (!tag) {
 		beiscsi_log(phba, KERN_ERR, BEISCSI_LOG_CONFIG,
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index 2f9213b257a4..39ac58337290 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -622,7 +622,6 @@ bfad_hal_mem_alloc(struct bfad_s *bfad)
 			goto ext;
 		}
 		dma_elem->dma = phys_addr;
-		memset(dma_elem->kva, 0, dma_elem->mem_len);
 	}
 ext:
 	return rc;
diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 9e50e5b53763..7a10b8738ece 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -614,8 +614,6 @@ int bnx2fc_init_mp_req(struct bnx2fc_cmd *io_req)
 		bnx2fc_free_mp_resc(io_req);
 		return FAILED;
 	}
-	memset(mp_req->req_buf, 0, CNIC_PAGE_SIZE);
-	memset(mp_req->resp_buf, 0, CNIC_PAGE_SIZE);
 
 	/* Allocate and map mp_req_bd and mp_resp_bd */
 	sz = sizeof(struct fcoe_bd_ctx);
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index abc74fd474dc..b1b879beebfb 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -1331,7 +1331,6 @@ static s32 adpt_i2o_reset_hba(adpt_hba* pHba)
 		printk(KERN_ERR"IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
-	memset(status,0,4);
 
 	msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
 	msg[1]=I2O_CMD_ADAPTER_RESET<<24|HOST_TID<<12|ADAPTER_TID;
@@ -2803,7 +2802,6 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 			pHba->name);
 		return -ENOMEM;
 	}
-	memset(status, 0, 4);
 
 	writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
 	writel(I2O_CMD_OUTBOUND_INIT<<24 | HOST_TID<<12 | ADAPTER_TID, &msg[1]);
@@ -2857,7 +2855,6 @@ static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 		printk(KERN_ERR "%s: Could not allocate reply pool\n", pHba->name);
 		return -ENOMEM;
 	}
-	memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
 
 	for(i = 0; i < pHba->reply_fifo_size; i++) {
 		writel(pHba->reply_pool_pa + (i * REPLY_FRAME_SIZE * 4),
@@ -3092,7 +3089,6 @@ static int adpt_i2o_build_sys_table(void)
 		printk(KERN_WARNING "SysTab Set failed. Out of memory.\n");	
 		return -ENOMEM;
 	}
-	memset(sys_tbl, 0, sys_tbl_len);
 
 	sys_tbl->num_entries = hba_count;
 	sys_tbl->version = I2OVERSION;
diff --git a/drivers/scsi/esas2r/esas2r_init.c b/drivers/scsi/esas2r/esas2r_init.c
index 950cd92df2ff..67e7a78f408b 100644
--- a/drivers/scsi/esas2r/esas2r_init.c
+++ b/drivers/scsi/esas2r/esas2r_init.c
@@ -390,7 +390,6 @@ int esas2r_init_adapter(struct Scsi_Host *host, struct pci_dev *pcid,
 		     a->uncached,
 		     upper_32_bits(bus_addr),
 		     lower_32_bits(bus_addr));
-	memset(a->uncached, 0, a->uncached_size);
 	next_uncached = a->uncached;
 
 	if (!esas2r_init_adapter_struct(a,
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index e8bc8d328bab..ad941bb28060 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -4322,8 +4322,6 @@ ips_allocatescbs(ips_ha_t * ha)
 		return 0;
 	}
 
-	memset(ha->scbs, 0, ha->max_cmds * sizeof (ips_scb_t));
-
 	for (i = 0; i < ha->max_cmds; i++) {
 		scb_p = &ha->scbs[i];
 		scb_p->scb_busaddr = command_dma + sizeof (ips_scb_t) * i;
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index faf43b1d3dbe..6aac92fb1980 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7780,8 +7780,6 @@ lpfc_sli_pci_mem_setup(struct lpfc_hba *phba)
 	phba->hbqs[LPFC_ELS_HBQ].hbq_alloc_buffer = lpfc_els_hbq_alloc;
 	phba->hbqs[LPFC_ELS_HBQ].hbq_free_buffer = lpfc_els_hbq_free;
 
-	memset(phba->hbqslimp.virt, 0, lpfc_sli_hbq_size());
-
 	phba->MBslimaddr = phba->slim_memmap_p;
 	phba->HAregaddr = phba->ctrl_regs_memmap_p + HA_REG_OFFSET;
 	phba->CAregaddr = phba->ctrl_regs_memmap_p + CA_REG_OFFSET;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 80ab9700f1de..36f22603812e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4257,8 +4257,6 @@ int megasas_alloc_cmds(struct megasas_instance *instance)
 		return -ENOMEM;
 	}
 
-	memset(instance->cmd_list, 0, sizeof(struct megasas_cmd *) *max_cmd);
-
 	for (i = 0; i < max_cmd; i++) {
 		instance->cmd_list[i] = kmalloc(sizeof(struct megasas_cmd),
 						GFP_KERNEL);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 5324662751bf..69fe25c98c5a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -1111,7 +1111,6 @@ _transport_get_expander_phy_error_log(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	rc = -EINVAL;
-	memset(data_out, 0, sz);
 	phy_error_log_request = data_out;
 	phy_error_log_request->smp_frame_type = 0x40;
 	phy_error_log_request->function = 0x11;
@@ -1401,7 +1400,6 @@ _transport_expander_phy_control(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	rc = -EINVAL;
-	memset(data_out, 0, sz);
 	phy_control_request = data_out;
 	phy_control_request->smp_frame_type = 0x40;
 	phy_control_request->function = 0x91;
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index da719b0694dc..f2fae160691d 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -241,19 +241,16 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 				     &mvi->tx_dma, GFP_KERNEL);
 	if (!mvi->tx)
 		goto err_out;
-	memset(mvi->tx, 0, sizeof(*mvi->tx) * MVS_CHIP_SLOT_SZ);
 	mvi->rx_fis = dma_alloc_coherent(mvi->dev, MVS_RX_FISL_SZ,
 					 &mvi->rx_fis_dma, GFP_KERNEL);
 	if (!mvi->rx_fis)
 		goto err_out;
-	memset(mvi->rx_fis, 0, MVS_RX_FISL_SZ);
 
 	mvi->rx = dma_alloc_coherent(mvi->dev,
 				     sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1),
 				     &mvi->rx_dma, GFP_KERNEL);
 	if (!mvi->rx)
 		goto err_out;
-	memset(mvi->rx, 0, sizeof(*mvi->rx) * (MVS_RX_RING_SZ + 1));
 	mvi->rx[0] = cpu_to_le32(0xfff);
 	mvi->rx_cons = 0xfff;
 
@@ -262,7 +259,6 @@ static int mvs_alloc(struct mvs_info *mvi, struct Scsi_Host *shost)
 				       &mvi->slot_dma, GFP_KERNEL);
 	if (!mvi->slot)
 		goto err_out;
-	memset(mvi->slot, 0, sizeof(*mvi->slot) * slot_nr);
 
 	mvi->bulk_buffer = dma_alloc_coherent(mvi->dev,
 				       TRASH_BUCKET_SIZE,
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index eb0dd566330a..566cacee23b7 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -550,7 +550,6 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 		goto out_free;
 
 	/* Enable the Memory Mailbox Interface. */
-	memset(mbox, 0, sizeof(union myrs_cmd_mbox));
 	mbox->set_mbox.id = 1;
 	mbox->set_mbox.opcode = MYRS_CMD_OP_IOCTL;
 	mbox->set_mbox.control.no_autosense = true;
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 71ff3936da4f..e8a72edb051c 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -4720,7 +4720,6 @@ static int pmcraid_allocate_host_rrqs(struct pmcraid_instance *pinstance)
 			return -ENOMEM;
 		}
 
-		memset(pinstance->hrrq_start[i], 0, buffer_size);
 		pinstance->hrrq_curr[i] = pinstance->hrrq_start[i];
 		pinstance->hrrq_end[i] =
 			pinstance->hrrq_start[i] + PMCRAID_MAX_CMD - 1;
diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index dac9a7013208..eb3167186586 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -2354,7 +2354,6 @@ int qla4_84xx_config_acb(struct scsi_qla_host *ha, int acb_config)
 		rval = QLA_ERROR;
 		goto exit_config_acb;
 	}
-	memset(acb, 0, acb_len);
 
 	switch (acb_config) {
 	case ACB_CONFIG_DISABLE:
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 8c674eca09f1..8666d4fc93da 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -9478,8 +9478,6 @@ static int qla4xxx_context_reset(struct scsi_qla_host *ha)
 		goto exit_port_reset;
 	}
 
-	memset(acb, 0, acb_len);
-
 	rval = qla4xxx_get_acb(ha, acb_dma, PRIMARI_ACB, acb_len);
 	if (rval != QLA_SUCCESS) {
 		rval = -EIO;
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 9335849f6bea..7868db052042 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -828,8 +828,6 @@ static int qpti_map_queues(struct qlogicpti *qpti)
 		printk("QPTI: Cannot map request queue.\n");
 		return -1;
 	}
-	memset(qpti->res_cpu, 0, QSIZE(RES_QUEUE_LEN));
-	memset(qpti->req_cpu, 0, QSIZE(QLOGICPTI_REQ_QUEUE_LEN));
 	return 0;
 }
 
-- 
2.11.0

