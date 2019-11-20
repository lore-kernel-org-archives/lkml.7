Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A808C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9D22526
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfKTNV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56779 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbfKTNVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPuu-00078h-FV; Wed, 20 Nov 2019 14:21:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C54C11C1A01;
        Wed, 20 Nov 2019 14:21:03 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:03 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Synchronise INT/CLEAR commands
 targetting a VLPI using VSYNC
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108165805.3071-10-maz@kernel.org>
References: <20191108165805.3071-10-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606371.12247.8279559926497707725.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ed0e4aa9cc74c08a429f4a389483c1076da2ca51
Gitweb:        https://git.kernel.org/tip/ed0e4aa9cc74c08a429f4a389483c1076da2ca51
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:58:03 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:53 

irqchip/gic-v3-its: Synchronise INT/CLEAR commands targetting a VLPI using VSYNC

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
Link: https://lore.kernel.org/r/20191108165805.3071-10-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 79 +++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6a18b01..61b8851 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -721,6 +721,42 @@ static struct its_vpe *its_build_vinv_cmd(struct its_node *its,
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
@@ -1101,6 +1137,34 @@ static void its_send_vinv(struct its_device *dev, u32 event_id)
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
@@ -1294,10 +1358,17 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
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
