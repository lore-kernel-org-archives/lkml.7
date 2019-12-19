Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424AAC2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2408F22314
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLSDWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:22:11 -0500
Received: from mxout2.idt.com ([157.165.5.26]:56755 "EHLO mxout2.idt.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfLSDWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:22:10 -0500
Received: from mail6.idt.com (localhost [127.0.0.1])
        by mxout2.idt.com (8.14.4/8.14.4) with ESMTP id xBJ3Lw0X009611;
        Wed, 18 Dec 2019 19:21:58 -0800
Received: from corpml3.corp.idt.com (corpml3.corp.idt.com [157.165.140.25])
        by mail6.idt.com (8.14.4/8.14.4) with ESMTP id xBJ3LwL6025860;
        Wed, 18 Dec 2019 19:21:58 -0800
Received: from vcheng-VirtualBox.localdomain (corpimss2.corp.idt.com [157.165.141.30])
        by corpml3.corp.idt.com (8.11.7p1+Sun/8.11.7) with ESMTP id xBJ3LvW09319;
        Wed, 18 Dec 2019 19:21:57 -0800 (PST)
From:   vincent.cheng.xh@renesas.com
To:     davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com,
        richardcochran@gmail.com
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Cheng <vincent.cheng.xh@renesas.com>
Subject: [PATCH v2 net-next 1/1] ptp: clockmatrix: Rework clockmatrix version information.
Date:   Wed, 18 Dec 2019 22:21:37 -0500
Message-Id: <1576725697-11828-2-git-send-email-vincent.cheng.xh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576725697-11828-1-git-send-email-vincent.cheng.xh@renesas.com>
References: <1576725697-11828-1-git-send-email-vincent.cheng.xh@renesas.com>
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Cheng <vincent.cheng.xh@renesas.com>

Remove pipeline id, bond id, csr id, and irq id.
Changes source register for reading HW rev id.
Add OTP config select.

Signed-off-by: Vincent Cheng <vincent.cheng.xh@renesas.com>
---
 drivers/ptp/idt8a340_reg.h    |  2 ++
 drivers/ptp/ptp_clockmatrix.c | 77 ++++++++-----------------------------------
 2 files changed, 15 insertions(+), 64 deletions(-)

diff --git a/drivers/ptp/idt8a340_reg.h b/drivers/ptp/idt8a340_reg.h
index 9263bc3..69eedda 100644
--- a/drivers/ptp/idt8a340_reg.h
+++ b/drivers/ptp/idt8a340_reg.h
@@ -77,6 +77,8 @@
 #define JTAG_DEVICE_ID                    0x001c
 #define PRODUCT_ID                        0x001e
 
+#define OTP_SCSR_CONFIG_SELECT            0x0022
+
 #define STATUS                            0xc03c
 #define USER_GPIO0_TO_7_STATUS            0x008a
 #define USER_GPIO8_TO_15_STATUS           0x008b
diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index a5110b7..9b1a89d 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -405,6 +405,7 @@ static int _idtcm_set_dpll_tod(struct idtcm_channel *channel,
 	if (wr_trig == HW_TOD_WR_TRIG_SEL_MSB) {
 
 		if (idtcm->calculate_overhead_flag) {
+			/* Assumption: I2C @ 400KHz */
 			total_overhead_ns =  ktime_to_ns(ktime_get_raw()
 							 - idtcm->start_time)
 					     + idtcm->tod_write_overhead_ns
@@ -596,44 +597,7 @@ static int idtcm_state_machine_reset(struct idtcm *idtcm)
 
 static int idtcm_read_hw_rev_id(struct idtcm *idtcm, u8 *hw_rev_id)
 {
-	return idtcm_read(idtcm,
-			  GENERAL_STATUS,
-			  HW_REV_ID,
-			  hw_rev_id,
-			  sizeof(u8));
-}
-
-static int idtcm_read_bond_id(struct idtcm *idtcm, u8 *bond_id)
-{
-	return idtcm_read(idtcm,
-			  GENERAL_STATUS,
-			  BOND_ID,
-			  bond_id,
-			  sizeof(u8));
-}
-
-static int idtcm_read_hw_csr_id(struct idtcm *idtcm, u16 *hw_csr_id)
-{
-	int err;
-	u8 buf[2] = {0};
-
-	err = idtcm_read(idtcm, GENERAL_STATUS, HW_CSR_ID, buf, sizeof(buf));
-
-	*hw_csr_id = (buf[1] << 8) | buf[0];
-
-	return err;
-}
-
-static int idtcm_read_hw_irq_id(struct idtcm *idtcm, u16 *hw_irq_id)
-{
-	int err;
-	u8 buf[2] = {0};
-
-	err = idtcm_read(idtcm, GENERAL_STATUS, HW_IRQ_ID, buf, sizeof(buf));
-
-	*hw_irq_id = (buf[1] << 8) | buf[0];
-
-	return err;
+	return idtcm_read(idtcm, HW_REVISION, REV_ID, hw_rev_id, sizeof(u8));
 }
 
 static int idtcm_read_product_id(struct idtcm *idtcm, u16 *product_id)
@@ -674,20 +638,11 @@ static int idtcm_read_hotfix_release(struct idtcm *idtcm, u8 *hotfix)
 			  sizeof(u8));
 }
 
-static int idtcm_read_pipeline(struct idtcm *idtcm, u32 *pipeline)
+static int idtcm_read_otp_scsr_config_select(struct idtcm *idtcm,
+					     u8 *config_select)
 {
-	int err;
-	u8 buf[4] = {0};
-
-	err = idtcm_read(idtcm,
-			 GENERAL_STATUS,
-			 PIPELINE_ID,
-			 &buf[0],
-			 sizeof(buf));
-
-	*pipeline = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
-
-	return err;
+	return idtcm_read(idtcm, GENERAL_STATUS, OTP_SCSR_CONFIG_SELECT,
+			  config_select, sizeof(u8));
 }
 
 static int process_pll_mask(struct idtcm *idtcm, u32 addr, u8 val, u8 *mask)
@@ -1078,28 +1033,22 @@ static void idtcm_display_version_info(struct idtcm *idtcm)
 	u8 major;
 	u8 minor;
 	u8 hotfix;
-	u32 pipeline;
 	u16 product_id;
-	u16 csr_id;
-	u16 irq_id;
 	u8 hw_rev_id;
-	u8 bond_id;
+	u8 config_select;
+	char *fmt = "%d.%d.%d, Id: 0x%04x  HW Rev: %d  OTP Config Select: %d\n";
 
 	idtcm_read_major_release(idtcm, &major);
 	idtcm_read_minor_release(idtcm, &minor);
 	idtcm_read_hotfix_release(idtcm, &hotfix);
-	idtcm_read_pipeline(idtcm, &pipeline);
 
 	idtcm_read_product_id(idtcm, &product_id);
 	idtcm_read_hw_rev_id(idtcm, &hw_rev_id);
-	idtcm_read_bond_id(idtcm, &bond_id);
-	idtcm_read_hw_csr_id(idtcm, &csr_id);
-	idtcm_read_hw_irq_id(idtcm, &irq_id);
-
-	dev_info(&idtcm->client->dev, "Version:  %d.%d.%d, Pipeline %u\t"
-		 "0x%04x, Rev %d, Bond %d, CSR %d, IRQ %d\n",
-		 major, minor, hotfix, pipeline,
-		 product_id, hw_rev_id, bond_id, csr_id, irq_id);
+
+	idtcm_read_otp_scsr_config_select(idtcm, &config_select);
+
+	dev_info(&idtcm->client->dev, fmt, major, minor, hotfix,
+		 product_id, hw_rev_id, config_select);
 }
 
 static struct ptp_clock_info idtcm_caps = {
-- 
2.7.4

