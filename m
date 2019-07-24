Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB75C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53AC229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 12:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DYgW/+PG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfGXMG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 08:06:56 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:47258 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbfGXMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 08:06:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 22468C0BBF;
        Wed, 24 Jul 2019 12:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1563970015; bh=Ig0atlwmgsMQV1c6ZCNpQe54UzgoUiNk3gRiTOLNySk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYgW/+PGir4wJeVTED6d027cLJNBKFHIMUF4s8zDniqkNqSyPmFcL6k+fw57rUPKC
         edLvbWoqSYg0fZO2wnoNAGKs3GUGeLjoPx41H5PcIohEE7jSCZkRJUjW/yC4hsfK68
         8K/r4C6c7hJamRGl6iV7kb4coTTHC/zG8ZhNAEIQZBJPuJG0kO2P2DvJX6VSzjdJlt
         42l6VHwIACoIZ3eYBWwjcWp2E2yRY/K7ArMxYVHuaGgyJ5QlJnYMfh0LMPN8b3fsNr
         lDbempoY48jJCR8I/vZCXU6F1kTpgNjXfx2jQXfPXNyb8Z3+67g+KsCiZxaxkt28XJ
         EWBBJUlkUls2A==
Received: from de02arcdev1.internal.synopsys.com (de02arcdev1.internal.synopsys.com [10.225.22.192])
        by mailhost.synopsys.com (Postfix) with ESMTP id F3EDFA0057;
        Wed, 24 Jul 2019 12:06:51 +0000 (UTC)
From:   Mischa Jonker <Mischa.Jonker@synopsys.com>
To:     Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        robh+dt@kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Mischa Jonker <Mischa.Jonker@synopsys.com>
Subject: [PATCH v2 1/3] ARCv2: IDU-intc: Add support for edge-triggered interrupts
Date:   Wed, 24 Jul 2019 14:04:34 +0200
Message-Id: <20190724120436.8537-1-mischa.jonker@synopsys.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <CY4PR1201MB0120EDD4173511912A9FC99EA1C60@CYPR1201MB0120.namprd12.prod.outlook.com>
References: <CY4PR1201MB0120EDD4173511912A9FC99EA1C60@CYPR1201MB0120.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for an optional extra interrupt cell to specify edge
vs level triggered. It is backward compatible with dts files with only
one cell, and will default to level-triggered in such a case.

Note that I had to make a change to idu_irq_set_affinity as well, as
this function was setting the interrupt type to "level" unconditionally,
since this was the only type supported previously.

Signed-off-by: Mischa Jonker <mischa.jonker@synopsys.com>
---
 arch/arc/kernel/mcip.c | 60 +++++++++++++++++++++++++++++++++++++++++++++-----
 include/soc/arc/mcip.h | 11 +++++++++
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index 18b493d..abf9398 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -202,8 +202,8 @@ static void idu_set_dest(unsigned int cmn_irq, unsigned int cpu_mask)
 	__mcip_cmd_data(CMD_IDU_SET_DEST, cmn_irq, cpu_mask);
 }
 
-static void idu_set_mode(unsigned int cmn_irq, unsigned int lvl,
-			   unsigned int distr)
+static void idu_set_mode(unsigned int cmn_irq, bool set_lvl, unsigned int lvl,
+			 bool set_distr, unsigned int distr)
 {
 	union {
 		unsigned int word;
@@ -212,8 +212,11 @@ static void idu_set_mode(unsigned int cmn_irq, unsigned int lvl,
 		};
 	} data;
 
-	data.distr = distr;
-	data.lvl = lvl;
+	data.word = __mcip_cmd_read(CMD_IDU_READ_MODE, cmn_irq);
+	if (set_distr)
+		data.distr = distr;
+	if (set_lvl)
+		data.lvl = lvl;
 	__mcip_cmd_data(CMD_IDU_SET_MODE, cmn_irq, data.word);
 }
 
@@ -240,6 +243,25 @@ static void idu_irq_unmask(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&mcip_lock, flags);
 }
 
+static void idu_irq_ack(struct irq_data *data)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+	__mcip_cmd(CMD_IDU_ACK_CIRQ, data->hwirq);
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
+static void idu_irq_mask_ack(struct irq_data *data)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+	__mcip_cmd_data(CMD_IDU_SET_MASK, data->hwirq, 1);
+	__mcip_cmd(CMD_IDU_ACK_CIRQ, data->hwirq);
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+}
+
 static int
 idu_irq_set_affinity(struct irq_data *data, const struct cpumask *cpumask,
 		     bool force)
@@ -263,13 +285,36 @@ idu_irq_set_affinity(struct irq_data *data, const struct cpumask *cpumask,
 	else
 		distribution_mode = IDU_M_DISTRI_RR;
 
-	idu_set_mode(data->hwirq, IDU_M_TRIG_LEVEL, distribution_mode);
+	idu_set_mode(data->hwirq, false, 0, true, distribution_mode);
 
 	raw_spin_unlock_irqrestore(&mcip_lock, flags);
 
 	return IRQ_SET_MASK_OK;
 }
 
+static int idu_irq_set_type(struct irq_data *data, u32 type)
+{
+	unsigned long flags;
+
+	/*
+	 * ARCv2 IDU HW does not support inverse polarity, so these are the
+	 * only interrupt types supported.
+	 */
+	if (type & ~(IRQ_TYPE_EDGE_RISING | IRQ_TYPE_LEVEL_HIGH))
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&mcip_lock, flags);
+
+	idu_set_mode(data->hwirq, true,
+		     type & IRQ_TYPE_EDGE_RISING ? IDU_M_TRIG_EDGE :
+						   IDU_M_TRIG_LEVEL,
+		     false, 0);
+
+	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+
+	return 0;
+}
+
 static void idu_irq_enable(struct irq_data *data)
 {
 	/*
@@ -289,7 +334,10 @@ static struct irq_chip idu_irq_chip = {
 	.name			= "MCIP IDU Intc",
 	.irq_mask		= idu_irq_mask,
 	.irq_unmask		= idu_irq_unmask,
+	.irq_ack		= idu_irq_ack,
+	.irq_mask_ack		= idu_irq_mask_ack,
 	.irq_enable		= idu_irq_enable,
+	.irq_set_type		= idu_irq_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity       = idu_irq_set_affinity,
 #endif
@@ -317,7 +365,7 @@ static int idu_irq_map(struct irq_domain *d, unsigned int virq, irq_hw_number_t
 }
 
 static const struct irq_domain_ops idu_irq_ops = {
-	.xlate	= irq_domain_xlate_onecell,
+	.xlate	= irq_domain_xlate_onetwocell,
 	.map	= idu_irq_map,
 };
 
diff --git a/include/soc/arc/mcip.h b/include/soc/arc/mcip.h
index 50f49e0..d1a93c7 100644
--- a/include/soc/arc/mcip.h
+++ b/include/soc/arc/mcip.h
@@ -46,7 +46,9 @@ struct mcip_cmd {
 #define CMD_IDU_ENABLE			0x71
 #define CMD_IDU_DISABLE			0x72
 #define CMD_IDU_SET_MODE		0x74
+#define CMD_IDU_READ_MODE		0x75
 #define CMD_IDU_SET_DEST		0x76
+#define CMD_IDU_ACK_CIRQ		0x79
 #define CMD_IDU_SET_MASK		0x7C
 
 #define IDU_M_TRIG_LEVEL		0x0
@@ -119,4 +121,13 @@ static inline void __mcip_cmd_data(unsigned int cmd, unsigned int param,
 	__mcip_cmd(cmd, param);
 }
 
+/*
+ * Read MCIP register
+ */
+static inline unsigned int __mcip_cmd_read(unsigned int cmd, unsigned int param)
+{
+	__mcip_cmd(cmd, param);
+	return read_aux_reg(ARC_REG_MCIP_READBACK);
+}
+
 #endif
-- 
2.8.3

