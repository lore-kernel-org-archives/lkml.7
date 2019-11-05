Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92BDC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F742190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572971006;
	bh=XTU9bI+Y9KVidysSIZmQEyAoxtf1dXd4PiUy3edkbDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jp8OBMdwzoPlQbYkFs3OI6lGlvDv7vTYjuvJSLUrbpOX6YWdyr5yPHYERShgGhT1K
	 2E9Dceh934wIA1kwetROCSQ1CG8VO1tbPgkIDY7VhAzlQ2FFHA1OHNcbsCG8vUloom
	 PEuukygxc7UrqlJ1fcfH7EcZXBJDGFQQDHoLNPRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbfKEQXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:23:25 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:36606 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390182AbfKEQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:23:15 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS1bu-0001q9-Kc; Tue, 05 Nov 2019 17:23:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH 09/11] irqchip/gic-v3-its: Synchronise INT/CLEAR commands targetting a VLPI using VSYNC
Date:   Tue,  5 Nov 2019 16:22:56 +0000
Message-Id: <20191105162258.22214-10-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105162258.22214-1-maz@kernel.org>
References: <20191105162258.22214-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have so far always injected/cleared VLPIs using either
INT+SYNC or CLEAR+SYNC sequences, but that's pretty wrong
for two reasons:

- SYNC only synchronises physical LPIs
- The collection ID that for the associated LPI doesn't match
  the redistributor the vPE is associated with

Instead, send an {INT,CLEAR}+VSYNC for forwarded LPIs, ensuring
that the ITS synchronises against the virtual pending table.

Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 79 ++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d4b9f12e2e53..dbb994f52e42 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -718,6 +718,42 @@ static struct its_vpe *its_build_vinv_cmd(struct its_node *its,
 	return valid_vpe(its, map->vpe);
 }
 
+static struct its_vpe *its_build_vint_cmd(struct its_node *its,
+					  struct its_cmd_block *cmd,
+					  struct its_cmd_desc *desc)
+{
+	struct its_vlpi_map *map;
+
+	map = dev_event_to_vlpi_map(desc->its_int_cmd.dev,
+				    desc->its_int_cmd.event_id);
+
+	its_encode_cmd(cmd, GITS_CMD_INT);
+	its_encode_devid(cmd, desc->its_int_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_int_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, map->vpe);
+}
+
+static struct its_vpe *its_build_vclear_cmd(struct its_node *its,
+					    struct its_cmd_block *cmd,
+					    struct its_cmd_desc *desc)
+{
+	struct its_vlpi_map *map;
+
+	map = dev_event_to_vlpi_map(desc->its_clear_cmd.dev,
+				    desc->its_clear_cmd.event_id);
+
+	its_encode_cmd(cmd, GITS_CMD_CLEAR);
+	its_encode_devid(cmd, desc->its_clear_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_clear_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, map->vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -1098,6 +1134,34 @@ static void its_send_vinv(struct its_device *dev, u32 event_id)
 	its_send_single_vcommand(dev->its, its_build_vinv_cmd, &desc);
 }
 
+static void its_send_vint(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	/*
+	 * There is no real VINT command. This is just a normal INT,
+	 * with a VSYNC instead of a SYNC.
+	 */
+	desc.its_int_cmd.dev = dev;
+	desc.its_int_cmd.event_id = event_id;
+
+	its_send_single_vcommand(dev->its, its_build_vint_cmd, &desc);
+}
+
+static void its_send_vclear(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	/*
+	 * There is no real VCLEAR command. This is just a normal CLEAR,
+	 * with a VSYNC instead of a SYNC.
+	 */
+	desc.its_clear_cmd.dev = dev;
+	desc.its_clear_cmd.event_id = event_id;
+
+	its_send_single_vcommand(dev->its, its_build_vclear_cmd, &desc);
+}
+
 /*
  * irqchip functions - assumes MSI, mostly.
  */
@@ -1291,10 +1355,17 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
 	if (which != IRQCHIP_STATE_PENDING)
 		return -EINVAL;
 
-	if (state)
-		its_send_int(its_dev, event);
-	else
-		its_send_clear(its_dev, event);
+	if (irqd_is_forwarded_to_vcpu(d)) {
+		if (state)
+			its_send_vint(its_dev, event);
+		else
+			its_send_vclear(its_dev, event);
+	} else {
+		if (state)
+			its_send_int(its_dev, event);
+		else
+			its_send_clear(its_dev, event);
+	}
 
 	return 0;
 }
-- 
2.20.1

