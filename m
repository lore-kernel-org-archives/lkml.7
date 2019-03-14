Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B580DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640A9217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 06:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="io3ErBav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCNGhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 02:37:08 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41885 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfCNGhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 02:37:08 -0400
Received: by mail-pf1-f194.google.com with SMTP id d25so3162988pfn.8;
        Wed, 13 Mar 2019 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0I3WKJlUFAZSs8iGQv5bsNWFzmafJZGWSNZg660yDg=;
        b=io3ErBavz/h3jT27JAWOX3vpbGqyNSlZlTedK1Sl27caB+ioxagEMQCwtJ+56vV7mk
         mxit2WE6tkE7NQHpCrLxv4MHhJSZXKAuoWPusRMTIaqEVsbcwNy2dKNBroNnd36wDHuK
         u8LVXnHG5wbu94bX1GlRK36hSa2d83nlcXi1mLMxYolyDs8u33XjdMHY6xC9oxsZpQAK
         3RtPXh2CDL4HAY12CXk9J6L5buF8A2CQ+0rEd5hOmLKa3KEBUKFXwA9MXgrHlCzuCNZF
         3XUW6VLbxwZt/rn3H63pV6HdVHbxJ35g1JnWlisvbhfj/nfCDrA1Nt2/n66TgKzRjsmN
         M02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T0I3WKJlUFAZSs8iGQv5bsNWFzmafJZGWSNZg660yDg=;
        b=dv4zJhDfJLHgLOzqjCeQ8l35TYwq+mFprkWe4py7esK1WOU/i8X57gqBIcmrPjhiqm
         vgZ8ec4bknDkPkOBHqfv4R0bAeMOm/WzAP+iP3PtHv+T63X45F65cA+x1NqaFcE1Rf7d
         DbhRagmWs4WinLnW5yBlnJclDSei5sIz5fqfmgP+TKSU+fToBA4A0fwvOtE0Nf98JSdf
         8NheqfmEzBUV/3sYGAFb00k+LZsGmylYxWuyYr48OuhOdMGW8pvKhrcd8R8CmF3MRWf/
         Wpw3MHjj7fDKVd+CXXPbdbhZoMqs1l5R9PZE7MulAA7xlJbHxWieQBVN40nFc7+MHo7l
         oy1Q==
X-Gm-Message-State: APjAAAW8dbrNUdzeOaFF2RmodT2cW1WPPQnlH8F+9Kaj4BJ+HAibXBqX
        61XgyTp0D/xYo5u4lIOSUaG4s5Fp
X-Google-Smtp-Source: APXvYqwZk85KAgP/Y8orYExmu8bJKClzdhhag80/2qerNVDttQQf6+P1Ml2QIarFGbcZrIDMwqNi0w==
X-Received: by 2002:a65:63c1:: with SMTP id n1mr43240378pgv.339.1552545426713;
        Wed, 13 Mar 2019 23:37:06 -0700 (PDT)
Received: from localhost.localdomain ([175.223.23.218])
        by smtp.gmail.com with ESMTPSA id f125sm25509011pfc.91.2019.03.13.23.37.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 23:37:05 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Martin Petersen <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        QLogic-Storage-Upstream@qlogic.com,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH 1/2] scsi: qla4xxx: do not use __constant_cpu_to_leXX
Date:   Thu, 14 Mar 2019 15:36:55 +0900
Message-Id: <20190314063656.25561-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A trivial patch.

cpu_to_le32() and cpu_to_le16() are capable enough to detect
__builtin_constant_p() and to use an appropriate compile time
___constant_swahbXX() functions.

So we can use cpu_to_leXX() instead of __constant_cpu_to_leXX().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/scsi/qla4xxx/ql4_init.c |  4 ++--
 drivers/scsi/qla4xxx/ql4_iocb.c |  2 +-
 drivers/scsi/qla4xxx/ql4_mbx.c  | 28 ++++++++++++++--------------
 drivers/scsi/qla4xxx/ql4_nx.c   | 10 +++++-----
 drivers/scsi/qla4xxx/ql4_os.c   | 10 +++++-----
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_init.c b/drivers/scsi/qla4xxx/ql4_init.c
index 2bf5e3e639e1..a3927597b9ad 100644
--- a/drivers/scsi/qla4xxx/ql4_init.c
+++ b/drivers/scsi/qla4xxx/ql4_init.c
@@ -122,8 +122,8 @@ int qla4xxx_init_rings(struct scsi_qla_host *ha)
 		 * the interrupt_handler to think there are responses to be
 		 * processed when there aren't.
 		 */
-		ha->shadow_regs->req_q_out = __constant_cpu_to_le32(0);
-		ha->shadow_regs->rsp_q_in = __constant_cpu_to_le32(0);
+		ha->shadow_regs->req_q_out = cpu_to_le32(0);
+		ha->shadow_regs->rsp_q_in = cpu_to_le32(0);
 		wmb();
 
 		writel(0, &ha->reg->req_q_in);
diff --git a/drivers/scsi/qla4xxx/ql4_iocb.c b/drivers/scsi/qla4xxx/ql4_iocb.c
index 17222eb49762..03fa045b45e0 100644
--- a/drivers/scsi/qla4xxx/ql4_iocb.c
+++ b/drivers/scsi/qla4xxx/ql4_iocb.c
@@ -161,7 +161,7 @@ static void qla4xxx_build_scsi_iocbs(struct srb *srb,
 
 	if (!scsi_bufflen(cmd) || cmd->sc_data_direction == DMA_NONE) {
 		/* No data being transferred */
-		cmd_entry->ttlByteCnt = __constant_cpu_to_le32(0);
+		cmd_entry->ttlByteCnt = cpu_to_le32(0);
 		return;
 	}
 
diff --git a/drivers/scsi/qla4xxx/ql4_mbx.c b/drivers/scsi/qla4xxx/ql4_mbx.c
index dac9a7013208..7a353a067496 100644
--- a/drivers/scsi/qla4xxx/ql4_mbx.c
+++ b/drivers/scsi/qla4xxx/ql4_mbx.c
@@ -649,8 +649,8 @@ int qla4xxx_initialize_fw_cb(struct scsi_qla_host * ha)
 	/* Fill in the request and response queue information. */
 	init_fw_cb->rqq_consumer_idx = cpu_to_le16(ha->request_out);
 	init_fw_cb->compq_producer_idx = cpu_to_le16(ha->response_in);
-	init_fw_cb->rqq_len = __constant_cpu_to_le16(REQUEST_QUEUE_DEPTH);
-	init_fw_cb->compq_len = __constant_cpu_to_le16(RESPONSE_QUEUE_DEPTH);
+	init_fw_cb->rqq_len = cpu_to_le16(REQUEST_QUEUE_DEPTH);
+	init_fw_cb->compq_len = cpu_to_le16(RESPONSE_QUEUE_DEPTH);
 	init_fw_cb->rqq_addr_lo = cpu_to_le32(LSDW(ha->request_dma));
 	init_fw_cb->rqq_addr_hi = cpu_to_le32(MSDW(ha->request_dma));
 	init_fw_cb->compq_addr_lo = cpu_to_le32(LSDW(ha->response_dma));
@@ -660,20 +660,20 @@ int qla4xxx_initialize_fw_cb(struct scsi_qla_host * ha)
 
 	/* Set up required options. */
 	init_fw_cb->fw_options |=
-		__constant_cpu_to_le16(FWOPT_SESSION_MODE |
+		cpu_to_le16(FWOPT_SESSION_MODE |
 				       FWOPT_INITIATOR_MODE);
 
 	if (is_qla80XX(ha))
 		init_fw_cb->fw_options |=
-		    __constant_cpu_to_le16(FWOPT_ENABLE_CRBDB);
+		    cpu_to_le16(FWOPT_ENABLE_CRBDB);
 
-	init_fw_cb->fw_options &= __constant_cpu_to_le16(~FWOPT_TARGET_MODE);
+	init_fw_cb->fw_options &= cpu_to_le16(~FWOPT_TARGET_MODE);
 
 	init_fw_cb->add_fw_options = 0;
 	init_fw_cb->add_fw_options |=
-			__constant_cpu_to_le16(ADFWOPT_SERIALIZE_TASK_MGMT);
+			cpu_to_le16(ADFWOPT_SERIALIZE_TASK_MGMT);
 	init_fw_cb->add_fw_options |=
-			__constant_cpu_to_le16(ADFWOPT_AUTOCONN_DISABLE);
+			cpu_to_le16(ADFWOPT_AUTOCONN_DISABLE);
 
 	if (qla4xxx_set_ifcb(ha, &mbox_cmd[0], &mbox_sts[0], init_fw_cb_dma)
 		!= QLA_SUCCESS) {
@@ -1618,7 +1618,7 @@ int qla4xxx_get_chap(struct scsi_qla_host *ha, char *username, char *password,
 
 	strlcpy(password, chap_table->secret, QL4_CHAP_MAX_SECRET_LEN);
 	strlcpy(username, chap_table->name, QL4_CHAP_MAX_NAME_LEN);
-	chap_table->cookie = __constant_cpu_to_le16(CHAP_VALID_COOKIE);
+	chap_table->cookie = cpu_to_le16(CHAP_VALID_COOKIE);
 
 exit_get_chap:
 	dma_pool_free(ha->chap_dma_pool, chap_table, chap_dma);
@@ -1660,7 +1660,7 @@ int qla4xxx_set_chap(struct scsi_qla_host *ha, char *username, char *password,
 	chap_table->secret_len = strlen(password);
 	strncpy(chap_table->secret, password, MAX_CHAP_SECRET_LEN - 1);
 	strncpy(chap_table->name, username, MAX_CHAP_NAME_LEN - 1);
-	chap_table->cookie = __constant_cpu_to_le16(CHAP_VALID_COOKIE);
+	chap_table->cookie = cpu_to_le16(CHAP_VALID_COOKIE);
 
 	if (is_qla40XX(ha)) {
 		chap_size = MAX_CHAP_ENTRIES_40XX * sizeof(*chap_table);
@@ -1726,7 +1726,7 @@ int qla4xxx_get_uni_chap_at_index(struct scsi_qla_host *ha, char *username,
 
 	mutex_lock(&ha->chap_sem);
 	chap_table = (struct ql4_chap_table *)ha->chap_list + chap_index;
-	if (chap_table->cookie != __constant_cpu_to_le16(CHAP_VALID_COOKIE)) {
+	if (chap_table->cookie != cpu_to_le16(CHAP_VALID_COOKIE)) {
 		rval = QLA_ERROR;
 		goto exit_unlock_uni_chap;
 	}
@@ -1789,7 +1789,7 @@ int qla4xxx_get_chap_index(struct scsi_qla_host *ha, char *username,
 	for (i = 0; i < max_chap_entries; i++) {
 		chap_table = (struct ql4_chap_table *)ha->chap_list + i;
 		if (chap_table->cookie !=
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE)) {
+		    cpu_to_le16(CHAP_VALID_COOKIE)) {
 			if (i > MAX_RESRV_CHAP_IDX && free_index == -1)
 				free_index = i;
 			continue;
@@ -2110,18 +2110,18 @@ int qla4xxx_set_param_ddbentry(struct scsi_qla_host *ha,
 
 	if (conn->max_recv_dlength)
 		fw_ddb_entry->iscsi_max_rcv_data_seg_len =
-		  __constant_cpu_to_le16((conn->max_recv_dlength / BYTE_UNITS));
+		  cpu_to_le16((conn->max_recv_dlength / BYTE_UNITS));
 
 	if (sess->max_r2t)
 		fw_ddb_entry->iscsi_max_outsnd_r2t = cpu_to_le16(sess->max_r2t);
 
 	if (sess->first_burst)
 		fw_ddb_entry->iscsi_first_burst_len =
-		       __constant_cpu_to_le16((sess->first_burst / BYTE_UNITS));
+		       cpu_to_le16((sess->first_burst / BYTE_UNITS));
 
 	if (sess->max_burst)
 		fw_ddb_entry->iscsi_max_burst_len =
-			__constant_cpu_to_le16((sess->max_burst / BYTE_UNITS));
+			cpu_to_le16((sess->max_burst / BYTE_UNITS));
 
 	if (sess->time2wait)
 		fw_ddb_entry->iscsi_def_time2wait =
diff --git a/drivers/scsi/qla4xxx/ql4_nx.c b/drivers/scsi/qla4xxx/ql4_nx.c
index 5a31877c9d04..9a332884d75a 100644
--- a/drivers/scsi/qla4xxx/ql4_nx.c
+++ b/drivers/scsi/qla4xxx/ql4_nx.c
@@ -3680,7 +3680,7 @@ qla4_82xx_read_flash_data(struct scsi_qla_host *ha, uint32_t *dwptr,
 			    "Do ROM fast read failed\n");
 			goto done_read;
 		}
-		dwptr[i] = __constant_cpu_to_le32(val);
+		dwptr[i] = cpu_to_le32(val);
 	}
 
 done_read:
@@ -3743,9 +3743,9 @@ qla4_8xxx_get_flt_info(struct scsi_qla_host *ha, uint32_t flt_addr)
 			goto no_flash_data;
 	}
 
-	if (*wptr == __constant_cpu_to_le16(0xffff))
+	if (*wptr == cpu_to_le16(0xffff))
 		goto no_flash_data;
-	if (flt->version != __constant_cpu_to_le16(1)) {
+	if (flt->version != cpu_to_le16(1)) {
 		DEBUG2(ql4_printk(KERN_INFO, ha, "Unsupported FLT detected: "
 			"version=0x%x length=0x%x checksum=0x%x.\n",
 			le16_to_cpu(flt->version), le16_to_cpu(flt->length),
@@ -3848,7 +3848,7 @@ qla4_82xx_get_fdt_info(struct scsi_qla_host *ha)
 	qla4_82xx_read_optrom_data(ha, (uint8_t *)ha->request_ring,
 	    hw->flt_region_fdt << 2, OPTROM_BURST_SIZE);
 
-	if (*wptr == __constant_cpu_to_le16(0xffff))
+	if (*wptr == cpu_to_le16(0xffff))
 		goto no_flash_data;
 
 	if (fdt->sig[0] != 'Q' || fdt->sig[1] != 'L' || fdt->sig[2] != 'I' ||
@@ -3905,7 +3905,7 @@ qla4_82xx_get_idc_param(struct scsi_qla_host *ha)
 	qla4_82xx_read_optrom_data(ha, (uint8_t *)ha->request_ring,
 			QLA82XX_IDC_PARAM_ADDR , 8);
 
-	if (*wptr == __constant_cpu_to_le32(0xffffffff)) {
+	if (*wptr == cpu_to_le32(0xffffffff)) {
 		ha->nx_dev_init_timeout = ROM_DEV_INIT_TIMEOUT;
 		ha->nx_reset_timeout = ROM_DRV_RESET_ACK_TIMEOUT;
 	} else {
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 16a18d5d856f..074448106f81 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -670,7 +670,7 @@ static int qla4xxx_get_chap_by_index(struct scsi_qla_host *ha,
 
 	*chap_entry = (struct ql4_chap_table *)ha->chap_list + chap_index;
 	if ((*chap_entry)->cookie !=
-	     __constant_cpu_to_le16(CHAP_VALID_COOKIE)) {
+	     cpu_to_le16(CHAP_VALID_COOKIE)) {
 		rval = QLA_ERROR;
 		*chap_entry = NULL;
 	} else {
@@ -714,7 +714,7 @@ static int qla4xxx_find_free_chap_index(struct scsi_qla_host *ha,
 		chap_table = (struct ql4_chap_table *)ha->chap_list + i;
 
 		if ((chap_table->cookie !=
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE)) &&
+		    cpu_to_le16(CHAP_VALID_COOKIE)) &&
 		   (i > MAX_RESRV_CHAP_IDX)) {
 				free_index = i;
 				break;
@@ -763,7 +763,7 @@ static int qla4xxx_get_chap_list(struct Scsi_Host *shost, uint16_t chap_tbl_idx,
 	for (i = chap_tbl_idx; i < max_chap_entries; i++) {
 		chap_table = (struct ql4_chap_table *)ha->chap_list + i;
 		if (chap_table->cookie !=
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE))
+		    cpu_to_le16(CHAP_VALID_COOKIE))
 			continue;
 
 		chap_rec->chap_tbl_idx = i;
@@ -894,7 +894,7 @@ static int qla4xxx_delete_chap(struct Scsi_Host *shost, uint16_t chap_tbl_idx)
 		goto exit_delete_chap;
 	}
 
-	chap_table->cookie = __constant_cpu_to_le16(0xFFFF);
+	chap_table->cookie = cpu_to_le16(0xFFFF);
 
 	offset = FLASH_CHAP_OFFSET |
 			(chap_tbl_idx * sizeof(struct ql4_chap_table));
@@ -6022,7 +6022,7 @@ static int qla4xxx_get_bidi_chap(struct scsi_qla_host *ha, char *username,
 	for (i = 0; i < max_chap_entries; i++) {
 		chap_table = (struct ql4_chap_table *)ha->chap_list + i;
 		if (chap_table->cookie !=
-		    __constant_cpu_to_le16(CHAP_VALID_COOKIE)) {
+		    cpu_to_le16(CHAP_VALID_COOKIE)) {
 			continue;
 		}
 
-- 
2.21.0

