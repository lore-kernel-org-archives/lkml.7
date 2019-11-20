Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA028C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A626922528
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfKTNV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfKTNVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:19 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv0-000795-5z; Wed, 20 Nov 2019 14:21:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EF2931C1A12;
        Wed, 20 Nov 2019 14:21:03 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:03 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Synchronise INV command
 targetting a VLPI using VSYNC
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108165805.3071-9-maz@kernel.org>
References: <20191108165805.3071-9-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606389.12247.13811391966540477532.tip-bot2@tip-bot2>
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

Commit-ID:     286146960a110cdae455a18cef47d5113d9a95c6
Gitweb:        https://git.kernel.org/tip/286146960a110cdae455a18cef47d5113d9a95c6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:58:02 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:53 

irqchip/gic-v3-its: Synchronise INV command targetting a VLPI using VSYNC

We have so far alwways invalidated VLPIs usinc an INV+SYNC
sequence, but that's pretty wrong for two reasons:

- SYNC only synchronises physical LPIs
- The collection ID that for the associated LPI doesn't match
  the redistributor the vPE is associated with

Instead, send an INV+VSYNC for forwarded LPIs, ensuring that
the ITS can properly synchronise the invalidation of VLPIs.

Fixes: 015ec0386ab6 ("irqchip/gic-v3-its: Add VLPI configuration handling")
Reported-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191108165805.3071-9-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 36 ++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8d088c..6a18b01 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -703,6 +703,24 @@ static struct its_vpe *its_build_vmovp_cmd(struct its_node *its,
 	return valid_vpe(its, desc->its_vmovp_cmd.vpe);
 }
 
+static struct its_vpe *its_build_vinv_cmd(struct its_node *its,
+					  struct its_cmd_block *cmd,
+					  struct its_cmd_desc *desc)
+{
+	struct its_vlpi_map *map;
+
+	map = dev_event_to_vlpi_map(desc->its_inv_cmd.dev,
+				    desc->its_inv_cmd.event_id);
+
+	its_encode_cmd(cmd, GITS_CMD_INV);
+	its_encode_devid(cmd, desc->its_inv_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_inv_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+
+	return valid_vpe(its, map->vpe);
+}
+
 static u64 its_cmd_ptr_to_offset(struct its_node *its,
 				 struct its_cmd_block *ptr)
 {
@@ -1069,6 +1087,20 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
 	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
 }
 
+static void its_send_vinv(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	/*
+	 * There is no real VINV command. This is just a normal INV,
+	 * with a VSYNC instead of a SYNC.
+	 */
+	desc.its_inv_cmd.dev = dev;
+	desc.its_inv_cmd.event_id = event_id;
+
+	its_send_single_vcommand(dev->its, its_build_vinv_cmd, &desc);
+}
+
 /*
  * irqchip functions - assumes MSI, mostly.
  */
@@ -1143,8 +1175,10 @@ static void lpi_update_config(struct irq_data *d, u8 clr, u8 set)
 	lpi_write_config(d, clr, set);
 	if (gic_rdists->has_direct_lpi && !irqd_is_forwarded_to_vcpu(d))
 		direct_lpi_inv(d);
-	else
+	else if (!irqd_is_forwarded_to_vcpu(d))
 		its_send_inv(its_dev, its_get_event_id(d));
+	else
+		its_send_vinv(its_dev, its_get_event_id(d));
 }
 
 static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
