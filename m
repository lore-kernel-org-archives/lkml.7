Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AF6C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617EF206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfD0PTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:19:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34148 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbfD0PPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:37 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP38-0000zH-Eg; Sat, 27 Apr 2019 16:15:34 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0004Sq-A7; Sat, 27 Apr 2019 16:15:09 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Tariq Toukan" <tariqt@mellanox.com>,
        "Aya Levin" <ayal@mellanox.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.347183706@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 065/202] net/mlx4_core: Add masking for a few queries
 on HCA caps
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aya Levin <ayal@mellanox.com>

commit a40ded6043658444ee4dd6ee374119e4e98b33fc upstream.

Driver reads the query HCA capabilities without the corresponding masks.
Without the correct masks, the base addresses of the queues are
unaligned.  In addition some reserved bits were wrongly read.  Using the
correct masks, ensures alignment of the base addresses and allows future
firmware versions safe use of the reserved bits.

Fixes: ab9c17a009ee ("mlx4_core: Modify driver initialization flow to accommodate SRIOV for Ethernet")
Fixes: 0ff1fb654bec ("{NET, IB}/mlx4: Add device managed flow steering firmware API")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16:
 - There are no num_sys_eqs or dmfs_high_steer_mode parameters
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -1542,9 +1542,10 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 {
 	struct mlx4_cmd_mailbox *mailbox;
 	__be32 *outbox;
+	u64 qword_field;
 	u32 dword_field;
-	int err;
 	u8 byte_field;
+	int err;
 
 #define QUERY_HCA_GLOBAL_CAPS_OFFSET	0x04
 #define QUERY_HCA_CORE_CLOCK_OFFSET	0x0c
@@ -1566,18 +1567,30 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 
 	/* QPC/EEC/CQC/EQC/RDMARC attributes */
 
-	MLX4_GET(param->qpc_base,      outbox, INIT_HCA_QPC_BASE_OFFSET);
-	MLX4_GET(param->log_num_qps,   outbox, INIT_HCA_LOG_QP_OFFSET);
-	MLX4_GET(param->srqc_base,     outbox, INIT_HCA_SRQC_BASE_OFFSET);
-	MLX4_GET(param->log_num_srqs,  outbox, INIT_HCA_LOG_SRQ_OFFSET);
-	MLX4_GET(param->cqc_base,      outbox, INIT_HCA_CQC_BASE_OFFSET);
-	MLX4_GET(param->log_num_cqs,   outbox, INIT_HCA_LOG_CQ_OFFSET);
-	MLX4_GET(param->altc_base,     outbox, INIT_HCA_ALTC_BASE_OFFSET);
-	MLX4_GET(param->auxc_base,     outbox, INIT_HCA_AUXC_BASE_OFFSET);
-	MLX4_GET(param->eqc_base,      outbox, INIT_HCA_EQC_BASE_OFFSET);
-	MLX4_GET(param->log_num_eqs,   outbox, INIT_HCA_LOG_EQ_OFFSET);
-	MLX4_GET(param->rdmarc_base,   outbox, INIT_HCA_RDMARC_BASE_OFFSET);
-	MLX4_GET(param->log_rd_per_qp, outbox, INIT_HCA_LOG_RD_OFFSET);
+	MLX4_GET(qword_field, outbox, INIT_HCA_QPC_BASE_OFFSET);
+	param->qpc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_QP_OFFSET);
+	param->log_num_qps = byte_field & 0x1f;
+	MLX4_GET(qword_field, outbox, INIT_HCA_SRQC_BASE_OFFSET);
+	param->srqc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_SRQ_OFFSET);
+	param->log_num_srqs = byte_field & 0x1f;
+	MLX4_GET(qword_field, outbox, INIT_HCA_CQC_BASE_OFFSET);
+	param->cqc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_CQ_OFFSET);
+	param->log_num_cqs = byte_field & 0x1f;
+	MLX4_GET(qword_field, outbox, INIT_HCA_ALTC_BASE_OFFSET);
+	param->altc_base = qword_field;
+	MLX4_GET(qword_field, outbox, INIT_HCA_AUXC_BASE_OFFSET);
+	param->auxc_base = qword_field;
+	MLX4_GET(qword_field, outbox, INIT_HCA_EQC_BASE_OFFSET);
+	param->eqc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_EQ_OFFSET);
+	param->log_num_eqs = byte_field & 0x1f;
+	MLX4_GET(qword_field, outbox, INIT_HCA_RDMARC_BASE_OFFSET);
+	param->rdmarc_base = qword_field & ~((u64)0x1f);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_RD_OFFSET);
+	param->log_rd_per_qp = byte_field & 0x7;
 
 	MLX4_GET(dword_field, outbox, INIT_HCA_FLAGS_OFFSET);
 	if (dword_field & (1 << INIT_HCA_DEVICE_MANAGED_FLOW_STEERING_EN)) {
@@ -1592,18 +1605,18 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 	/* steering attributes */
 	if (param->steering_mode == MLX4_STEERING_MODE_DEVICE_MANAGED) {
 		MLX4_GET(param->mc_base, outbox, INIT_HCA_FS_BASE_OFFSET);
-		MLX4_GET(param->log_mc_entry_sz, outbox,
-			 INIT_HCA_FS_LOG_ENTRY_SZ_OFFSET);
-		MLX4_GET(param->log_mc_table_sz, outbox,
-			 INIT_HCA_FS_LOG_TABLE_SZ_OFFSET);
+		MLX4_GET(byte_field, outbox, INIT_HCA_FS_LOG_ENTRY_SZ_OFFSET);
+		param->log_mc_entry_sz = byte_field & 0x1f;
+		MLX4_GET(byte_field, outbox, INIT_HCA_FS_LOG_TABLE_SZ_OFFSET);
+		param->log_mc_table_sz = byte_field & 0x1f;
 	} else {
 		MLX4_GET(param->mc_base, outbox, INIT_HCA_MC_BASE_OFFSET);
-		MLX4_GET(param->log_mc_entry_sz, outbox,
-			 INIT_HCA_LOG_MC_ENTRY_SZ_OFFSET);
-		MLX4_GET(param->log_mc_hash_sz,  outbox,
-			 INIT_HCA_LOG_MC_HASH_SZ_OFFSET);
-		MLX4_GET(param->log_mc_table_sz, outbox,
-			 INIT_HCA_LOG_MC_TABLE_SZ_OFFSET);
+		MLX4_GET(byte_field, outbox, INIT_HCA_LOG_MC_ENTRY_SZ_OFFSET);
+		param->log_mc_entry_sz = byte_field & 0x1f;
+		MLX4_GET(byte_field,  outbox, INIT_HCA_LOG_MC_HASH_SZ_OFFSET);
+		param->log_mc_hash_sz = byte_field & 0x1f;
+		MLX4_GET(byte_field, outbox, INIT_HCA_LOG_MC_TABLE_SZ_OFFSET);
+		param->log_mc_table_sz = byte_field & 0x1f;
 	}
 
 	/* CX3 is capable of extending CQEs/EQEs from 32 to 64 bytes */
@@ -1616,15 +1629,18 @@ int mlx4_QUERY_HCA(struct mlx4_dev *dev,
 	/* TPT attributes */
 
 	MLX4_GET(param->dmpt_base,  outbox, INIT_HCA_DMPT_BASE_OFFSET);
-	MLX4_GET(param->mw_enabled, outbox, INIT_HCA_TPT_MW_OFFSET);
-	MLX4_GET(param->log_mpt_sz, outbox, INIT_HCA_LOG_MPT_SZ_OFFSET);
+	MLX4_GET(byte_field, outbox, INIT_HCA_TPT_MW_OFFSET);
+	param->mw_enabled = byte_field >> 7;
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_MPT_SZ_OFFSET);
+	param->log_mpt_sz = byte_field & 0x3f;
 	MLX4_GET(param->mtt_base,   outbox, INIT_HCA_MTT_BASE_OFFSET);
 	MLX4_GET(param->cmpt_base,  outbox, INIT_HCA_CMPT_BASE_OFFSET);
 
 	/* UAR attributes */
 
 	MLX4_GET(param->uar_page_sz, outbox, INIT_HCA_UAR_PAGE_SZ_OFFSET);
-	MLX4_GET(param->log_uar_sz, outbox, INIT_HCA_LOG_UAR_SZ_OFFSET);
+	MLX4_GET(byte_field, outbox, INIT_HCA_LOG_UAR_SZ_OFFSET);
+	param->log_uar_sz = byte_field & 0xf;
 
 out:
 	mlx4_free_cmd_mailbox(dev, mailbox);

