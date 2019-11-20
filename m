Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E01C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347C12251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfKTNXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:23:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730190AbfKTNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPuv-00079M-OB; Wed, 20 Nov 2019 14:21:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C31F1C1A13;
        Wed, 20 Nov 2019 14:21:04 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:04 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Add its_vlpi_map helpers
Cc:     Marc Zyngier <maz@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191027144234.8395-8-maz@kernel.org>
References: <20191027144234.8395-8-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606405.12247.12927680220747155377.tip-bot2@tip-bot2>
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

Commit-ID:     c1d4d5cd203cc8ec83d67d4e2af51f1a9f01ba34
Gitweb:        https://git.kernel.org/tip/c1d4d5cd203cc8ec83d67d4e2af51f1a9f01ba34
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:58:01 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:52 

irqchip/gic-v3-its: Add its_vlpi_map helpers

Obtaining the mapping information for a VLPI is something quite common,
and the GICv4.1 code is going to make even more use of it. Expose it as
a separate set of helpers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/r/20191027144234.8395-8-maz@kernel.org
Link: https://lore.kernel.org/r/20191108165805.3071-8-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 47 +++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8aeb07..e8d088c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -207,6 +207,15 @@ static struct its_collection *dev_event_to_col(struct its_device *its_dev,
 	return its->collections + its_dev->event_map.col_map[event];
 }
 
+static struct its_vlpi_map *dev_event_to_vlpi_map(struct its_device *its_dev,
+					       u32 event)
+{
+	if (WARN_ON_ONCE(event >= its_dev->event_map.nr_lpis))
+		return NULL;
+
+	return &its_dev->event_map.vlpi_maps[event];
+}
+
 static struct its_collection *irq_to_col(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -971,7 +980,7 @@ static void its_send_invall(struct its_node *its, struct its_collection *col)
 
 static void its_send_vmapti(struct its_device *dev, u32 id)
 {
-	struct its_vlpi_map *map = &dev->event_map.vlpi_maps[id];
+	struct its_vlpi_map *map = dev_event_to_vlpi_map(dev, id);
 	struct its_cmd_desc desc;
 
 	desc.its_vmapti_cmd.vpe = map->vpe;
@@ -985,7 +994,7 @@ static void its_send_vmapti(struct its_device *dev, u32 id)
 
 static void its_send_vmovi(struct its_device *dev, u32 id)
 {
-	struct its_vlpi_map *map = &dev->event_map.vlpi_maps[id];
+	struct its_vlpi_map *map = dev_event_to_vlpi_map(dev, id);
 	struct its_cmd_desc desc;
 
 	desc.its_vmovi_cmd.vpe = map->vpe;
@@ -1063,20 +1072,26 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
 /*
  * irqchip functions - assumes MSI, mostly.
  */
+static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	u32 event = its_get_event_id(d);
+
+	if (!irqd_is_forwarded_to_vcpu(d))
+		return NULL;
+
+	return dev_event_to_vlpi_map(its_dev, event);
+}
 
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	irq_hw_number_t hwirq;
 	void *va;
 	u8 *cfg;
 
-	if (irqd_is_forwarded_to_vcpu(d)) {
-		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-		u32 event = its_get_event_id(d);
-		struct its_vlpi_map *map;
-
-		va = page_address(its_dev->event_map.vm->vprop_page);
-		map = &its_dev->event_map.vlpi_maps[event];
+	if (map) {
+		va = page_address(map->vm->vprop_page);
 		hwirq = map->vintid;
 
 		/* Remember the updated property */
@@ -1136,11 +1151,14 @@ static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
+	struct its_vlpi_map *map;
 
-	if (its_dev->event_map.vlpi_maps[event].db_enabled == enable)
+	map = dev_event_to_vlpi_map(its_dev, event);
+
+	if (map->db_enabled == enable)
 		return;
 
-	its_dev->event_map.vlpi_maps[event].db_enabled = enable;
+	map->db_enabled = enable;
 
 	/*
 	 * More fun with the architecture:
@@ -1369,19 +1387,18 @@ out:
 static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	u32 event = its_get_event_id(d);
+	struct its_vlpi_map *map = get_vlpi_map(d);
 	int ret = 0;
 
 	mutex_lock(&its_dev->event_map.vlpi_lock);
 
-	if (!its_dev->event_map.vm ||
-	    !its_dev->event_map.vlpi_maps[event].vm) {
+	if (!its_dev->event_map.vm || !map->vm) {
 		ret = -EINVAL;
 		goto out;
 	}
 
 	/* Copy our mapping information to the incoming request */
-	*info->map = its_dev->event_map.vlpi_maps[event];
+	*info->map = *map;
 
 out:
 	mutex_unlock(&its_dev->event_map.vlpi_lock);
