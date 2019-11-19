Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F781C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18DD206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143625;
	bh=uY1bbQZXu8e/sum3K53c3LzRzpreIfNaDyVXJa1Xcf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vbxfBiKPsuihxENS9SeU/HCuT6fbhOqTjbyaQ2f6DLkZnjJ1WCcVGKrh05LSELfVI
	 Xm/EuVGWtOQdFH6qOMPZd1MU7dUxJGwuF4QIoJNZ0vLDDiv8MXRGF8NG9NegSHFzIp
	 tXKEU+TzEiq8meRpEIcHAtdG8t0Msh4807BK39m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfKSGHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:07:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbfKSFdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:33:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB0F5206EC;
        Tue, 19 Nov 2019 05:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141630;
        bh=uY1bbQZXu8e/sum3K53c3LzRzpreIfNaDyVXJa1Xcf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xupFIbdzwfDg3R3XhzYc2Tr/C8Tp3gJiHBPftapvySzmgiQAS1t60ZSs/h4yw6drF
         JYmsjgFNXfHhy1jfHwBMdFfGAPH0mZELYytMYJuMi7V+jr5rnmrfEk2vO6Lkgrw/pg
         frUvBDNlMPmw7WPdHE1JhdJuYN41zLlR7fXwkecc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yana Esina <yana.esina@aquantia.com>,
        Nikita Danilov <nikita.danilov@aquantia.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 186/422] net: aquantia: fix hw_atl_utils_fw_upload_dwords
Date:   Tue, 19 Nov 2019 06:16:23 +0100
Message-Id: <20191119051410.542930934@linuxfoundation.org>
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

From: Yana Esina <yana.esina@aquantia.com>

[ Upstream commit 3ee5c8873fd369e2005dc93bf6d4b299b4976e68 ]

This patch fixes the upload function, which worked incorrectly with
some chips.

Signed-off-by: Yana Esina <yana.esina@aquantia.com>
Signed-off-by: Nikita Danilov <nikita.danilov@aquantia.com>
Tested-by: Nikita Danilov <nikita.danilov@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../aquantia/atlantic/hw_atl/hw_atl_llh.c     |  8 +++++
 .../aquantia/atlantic/hw_atl/hw_atl_llh.h     |  3 ++
 .../atlantic/hw_atl/hw_atl_llh_internal.h     | 13 +++++++
 .../aquantia/atlantic/hw_atl/hw_atl_utils.c   | 36 +++++++++++++------
 .../aquantia/atlantic/hw_atl/hw_atl_utils.h   |  5 +++
 .../atlantic/hw_atl/hw_atl_utils_fw2x.c       |  5 +++
 6 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
index 10ec5dc88e243..5502ec5f0f699 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
@@ -1468,3 +1468,11 @@ void hw_atl_reg_glb_cpu_scratch_scp_set(struct aq_hw_s *aq_hw,
 	aq_hw_write_reg(aq_hw, HW_ATL_GLB_CPU_SCRATCH_SCP_ADR(scratch_scp),
 			glb_cpu_scratch_scp);
 }
+
+void hw_atl_mcp_up_force_intr_set(struct aq_hw_s *aq_hw, u32 up_force_intr)
+{
+	aq_hw_write_reg_bit(aq_hw, HW_ATL_MCP_UP_FORCE_INTERRUPT_ADR,
+			    HW_ATL_MCP_UP_FORCE_INTERRUPT_MSK,
+			    HW_ATL_MCP_UP_FORCE_INTERRUPT_SHIFT,
+			    up_force_intr);
+}
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
index b3bf64b48b93d..41f239928c157 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h
@@ -701,4 +701,7 @@ void hw_atl_msm_reg_wr_strobe_set(struct aq_hw_s *aq_hw, u32 reg_wr_strobe);
 /* set pci register reset disable */
 void hw_atl_pci_pci_reg_res_dis_set(struct aq_hw_s *aq_hw, u32 pci_reg_res_dis);
 
+/* set uP Force Interrupt */
+void hw_atl_mcp_up_force_intr_set(struct aq_hw_s *aq_hw, u32 up_force_intr);
+
 #endif /* HW_ATL_LLH_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
index e2ecdb1c5a5c4..a715fa317b1c8 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
@@ -2405,4 +2405,17 @@
 #define HW_ATL_GLB_CPU_SCRATCH_SCP_ADR(scratch_scp) \
 	(0x00000300u + (scratch_scp) * 0x4)
 
+/* register address for bitfield uP Force Interrupt */
+#define HW_ATL_MCP_UP_FORCE_INTERRUPT_ADR 0x00000404
+/* bitmask for bitfield uP Force Interrupt */
+#define HW_ATL_MCP_UP_FORCE_INTERRUPT_MSK 0x00000002
+/* inverted bitmask for bitfield uP Force Interrupt */
+#define HW_ATL_MCP_UP_FORCE_INTERRUPT_MSKN 0xFFFFFFFD
+/* lower bit position of bitfield uP Force Interrupt */
+#define HW_ATL_MCP_UP_FORCE_INTERRUPT_SHIFT 1
+/* width of bitfield uP Force Interrupt */
+#define HW_ATL_MCP_UP_FORCE_INTERRUPT_WIDTH 1
+/* default value of bitfield uP Force Interrupt */
+#define HW_ATL_MCP_UP_FORCE_INTERRUPT_DEFAULT 0x0
+
 #endif /* HW_ATL_LLH_INTERNAL_H */
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
index 9939ccaeb125b..096ec18e8f15a 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.c
@@ -327,17 +327,31 @@ static int hw_atl_utils_fw_upload_dwords(struct aq_hw_s *self, u32 a, u32 *p,
 		err = -ETIME;
 		goto err_exit;
 	}
+	if (IS_CHIP_FEATURE(REVISION_B1)) {
+		u32 offset = 0;
+
+		for (; offset < cnt; ++offset) {
+			aq_hw_write_reg(self, 0x328, p[offset]);
+			aq_hw_write_reg(self, 0x32C,
+					(0x80000000 | (0xFFFF & (offset * 4))));
+			hw_atl_mcp_up_force_intr_set(self, 1);
+			/* 1000 times by 10us = 10ms */
+			AQ_HW_WAIT_FOR((aq_hw_read_reg(self,
+						       0x32C) & 0xF0000000) !=
+				       0x80000000,
+				       10, 1000);
+		}
+	} else {
+		u32 offset = 0;
 
-	aq_hw_write_reg(self, 0x00000208U, a);
-
-	for (++cnt; --cnt;) {
-		u32 i = 0U;
+		aq_hw_write_reg(self, 0x208, a);
 
-		aq_hw_write_reg(self, 0x0000020CU, *(p++));
-		aq_hw_write_reg(self, 0x00000200U, 0xC000U);
+		for (; offset < cnt; ++offset) {
+			aq_hw_write_reg(self, 0x20C, p[offset]);
+			aq_hw_write_reg(self, 0x200, 0xC000);
 
-		for (i = 1024U;
-			(0x100U & aq_hw_read_reg(self, 0x00000200U)) && --i;) {
+			AQ_HW_WAIT_FOR((aq_hw_read_reg(self, 0x200U) &
+					0x100) == 0, 10, 1000);
 		}
 	}
 
@@ -401,7 +415,7 @@ struct aq_hw_atl_utils_fw_rpc_tid_s {
 
 #define hw_atl_utils_fw_rpc_init(_H_) hw_atl_utils_fw_rpc_wait(_H_, NULL)
 
-static int hw_atl_utils_fw_rpc_call(struct aq_hw_s *self, unsigned int rpc_size)
+int hw_atl_utils_fw_rpc_call(struct aq_hw_s *self, unsigned int rpc_size)
 {
 	int err = 0;
 	struct aq_hw_atl_utils_fw_rpc_tid_s sw;
@@ -425,8 +439,8 @@ err_exit:
 	return err;
 }
 
-static int hw_atl_utils_fw_rpc_wait(struct aq_hw_s *self,
-				    struct hw_aq_atl_utils_fw_rpc **rpc)
+int hw_atl_utils_fw_rpc_wait(struct aq_hw_s *self,
+			     struct hw_aq_atl_utils_fw_rpc **rpc)
 {
 	int err = 0;
 	struct aq_hw_atl_utils_fw_rpc_tid_s sw;
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
index b875590efcbdd..505c8a2abd9ca 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h
@@ -319,6 +319,11 @@ struct aq_stats_s *hw_atl_utils_get_hw_stats(struct aq_hw_s *self);
 int hw_atl_utils_fw_downld_dwords(struct aq_hw_s *self, u32 a,
 				  u32 *p, u32 cnt);
 
+int hw_atl_utils_fw_rpc_call(struct aq_hw_s *self, unsigned int rpc_size);
+
+int hw_atl_utils_fw_rpc_wait(struct aq_hw_s *self,
+			     struct hw_aq_atl_utils_fw_rpc **rpc);
+
 extern const struct aq_fw_ops aq_fw_1x_ops;
 extern const struct aq_fw_ops aq_fw_2x_ops;
 
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
index e37943760a58b..6300d94c9ff07 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils_fw2x.c
@@ -21,6 +21,7 @@
 
 #define HW_ATL_FW2X_MPI_EFUSE_ADDR	0x364
 #define HW_ATL_FW2X_MPI_MBOX_ADDR	0x360
+#define HW_ATL_FW2X_MPI_RPC_ADDR        0x334
 
 #define HW_ATL_FW2X_MPI_CONTROL_ADDR	0x368
 #define HW_ATL_FW2X_MPI_CONTROL2_ADDR	0x36C
@@ -40,6 +41,10 @@ static int aq_fw2x_init(struct aq_hw_s *self)
 	AQ_HW_WAIT_FOR(0U != (self->mbox_addr =
 			aq_hw_read_reg(self, HW_ATL_FW2X_MPI_MBOX_ADDR)),
 		       1000U, 10U);
+	AQ_HW_WAIT_FOR(0U != (self->rpc_addr =
+		       aq_hw_read_reg(self, HW_ATL_FW2X_MPI_RPC_ADDR)),
+		       1000U, 100U);
+
 	return err;
 }
 
-- 
2.20.1



