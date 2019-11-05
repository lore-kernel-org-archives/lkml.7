Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EA9C5DF62
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F2421D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572971010;
	bh=lqWPpi1nQ+Rool4FQfDEcKWYoNF0VEkIWJstvVQhXfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZtQZuKhiOGUrXiPlPUeQEez+VUpILVXsovRRDVG/aUp/eZw3z2GSmsJkDZ66eEeIs
	 qOU37PKHP1wp6Viz1AJkvLOtP+bTQxBJHpaoOd1uxprIyx97KVJk7K9s0no3KkGjCR
	 xvtY00Cs4e5NQq0IO1HBoAcgxeNvOu5/yOTzcd6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbfKEQX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:23:29 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:40827 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390150AbfKEQXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:23:15 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS1bt-0001q9-FV; Tue, 05 Nov 2019 17:23:13 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH 07/11] irqchip/gic-v3-its: Add its_vlpi_map helpers
Date:   Tue,  5 Nov 2019 16:22:54 +0000
Message-Id: <20191105162258.22214-8-maz@kernel.org>
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

Obtaining the mapping information for a VLPI is something quite common,
and the GICv4.1 code is going to make even more use of it. Expose it as
a separate set of helpers.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 47 ++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9b1c53a5db4a..c8c280f803a5 100644
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
+	return its_dev->event_map.vlpi_maps[event];
+}
+
 static struct its_collection *irq_to_col(struct irq_data *d)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
@@ -968,7 +977,7 @@ static void its_send_invall(struct its_node *its, struct its_collection *col)
 
 static void its_send_vmapti(struct its_device *dev, u32 id)
 {
-	struct its_vlpi_map *map = &dev->event_map.vlpi_maps[id];
+	struct its_vlpi_map *map = dev_event_to_vlpi_map(dev, id);
 	struct its_cmd_desc desc;
 
 	desc.its_vmapti_cmd.vpe = map->vpe;
@@ -982,7 +991,7 @@ static void its_send_vmapti(struct its_device *dev, u32 id)
 
 static void its_send_vmovi(struct its_device *dev, u32 id)
 {
-	struct its_vlpi_map *map = &dev->event_map.vlpi_maps[id];
+	struct its_vlpi_map *map = dev_event_to_vlpi_map(dev, id);
 	struct its_cmd_desc desc;
 
 	desc.its_vmovi_cmd.vpe = map->vpe;
@@ -1060,20 +1069,26 @@ static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
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
@@ -1133,11 +1148,14 @@ static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
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
@@ -1366,19 +1384,18 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
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
-- 
2.20.1

