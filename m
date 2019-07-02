Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C9C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7140621841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6ycVPy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfGBH7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:59:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38102 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfGBH7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:59:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id z75so7291481pgz.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OMObhrlVmgP7QRHi9W6vFzgyEpuw7ZS3uPi2D5sd5KE=;
        b=l6ycVPy6uN++iSKEMNEeImLZFOSXm7CdIJFnWB7HuUWJpT16acJQChK/1KcZAX5RAx
         JZdB2CbU+ophyFs5e4R5sUWYafAt9BgFhO8tkyOm5kxtkp7zDSTdxcFOflVs7nn3puCC
         PtHNM46UQShhX9E8ragYms6sUDTaG2FOlsC/eX6/MRX8aLT17TtUqNRyxozuw8c5HPXb
         9Ccbngf/73SAUWiWeDWsXFdELoXmiDQzPz1qWU9/8tsJMKsM3m4cJT8AV8qfDu58Q0I0
         7I8LwxkqQW4RLkJnTFOmWwFMcuu5A6I1o5OdV/D2TVEOLEd69BrkVANafkul8l/dXaT/
         LUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OMObhrlVmgP7QRHi9W6vFzgyEpuw7ZS3uPi2D5sd5KE=;
        b=j9sUsX1QuAdq+x2sCSUZVfQy/71jzaG1zi4gpdYNeukMjfPIoEVDRZAUu0QlzEcXyA
         wK+Gct+HL6N5+in5DQ89gFL/X6hgjSwXe1CATM+3lRtvz6tGk9tloags3mXHY51o6/W0
         tuX4Ds950sxfrfepq5dUheizwYplzYBmUXHrRM0E9Vc5xArmi00jNgGjC60jTxMfhT5y
         C7b6NPM5OARthFDz5/zxsgWk6jkv3wXS8bFRyHL/ijsHlmNYXw7zBOjJeRW78WG9AMTv
         1YDSgCpCmISX6ALvDqDfCfcF9TbGUOwurVAOCX2q5GXLYG+rVvFvKM/Ser1698tE1XWi
         yfNA==
X-Gm-Message-State: APjAAAVqcfz2S7vzOBzk0dHFU44ztm1pe8rcYbu/2XI6wJVczGqjSpLz
        RkMBdBnfGsp6gwaeWQcqmAeMSVf9uEU=
X-Google-Smtp-Source: APXvYqx/Mf9tWpxNYON5aX27bnFkAAS2pBobCl89ALGxthr601LI7YAaStyqnA+kMJKKD9p2L/H8RA==
X-Received: by 2002:a65:5347:: with SMTP id w7mr29058755pgr.375.1562054340946;
        Tue, 02 Jul 2019 00:59:00 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id f10sm11128671pgo.14.2019.07.02.00.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 00:59:00 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v3 17/27] scsi: remove unneeded memset
Date:   Tue,  2 Jul 2019 15:58:55 +0800
Message-Id: <20190702075855.24306-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memset with 0 after zeroing alloctors is unneeded.

pci_alloc_persistent calls dma_alloc_coherent directly.
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
index 8def63c0755f..92b289466797 100644
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
index eaaef682de25..c3cca3be87f1 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -7770,8 +7770,6 @@ lpfc_sli_pci_mem_setup(struct lpfc_hba *phba)
 	phba->hbqs[LPFC_ELS_HBQ].hbq_alloc_buffer = lpfc_els_hbq_alloc;
 	phba->hbqs[LPFC_ELS_HBQ].hbq_free_buffer = lpfc_els_hbq_free;
 
-	memset(phba->hbqslimp.virt, 0, lpfc_sli_hbq_size());
-
 	phba->MBslimaddr = phba->slim_memmap_p;
 	phba->HAregaddr = phba->ctrl_regs_memmap_p + HA_REG_OFFSET;
 	phba->CAregaddr = phba->ctrl_regs_memmap_p + CA_REG_OFFSET;
diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 3dd1df472dc6..342b39bc9210 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -4141,8 +4141,6 @@ int megasas_alloc_cmds(struct megasas_instance *instance)
 		return -ENOMEM;
 	}
 
-	memset(instance->cmd_list, 0, sizeof(struct megasas_cmd *) *max_cmd);
-
 	for (i = 0; i < max_cmd; i++) {
 		instance->cmd_list[i] = kmalloc(sizeof(struct megasas_cmd),
 						GFP_KERNEL);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index 60ae2d0feb2b..b09af57840d8 100644
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
index ca22526aff7f..9e11e20d9e0d 100644
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

