Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC17C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8CE2254F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfKTNV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56755 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbfKTNVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPuy-00078F-Ke; Wed, 20 Nov 2019 14:21:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6750F1C1A10;
        Wed, 20 Nov 2019 14:21:03 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:03 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Make vlpi_lock a spinlock
Cc:     Heyi Guo <guoheyi@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108165805.3071-12-maz@kernel.org>
References: <20191108165805.3071-12-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <157425606332.12247.1289778849742974310.tip-bot2@tip-bot2>
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

Commit-ID:     11635fa26dc7a715f3fc1c351846859e90985ae1
Gitweb:        https://git.kernel.org/tip/11635fa26dc7a715f3fc1c351846859e90985ae1
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 08 Nov 2019 16:58:05 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:48:35 

irqchip/gic-v3-its: Make vlpi_lock a spinlock

The VLPI map is currently a mutex, and that's a bad idea as
this lock can be taken in non-preemptible contexts. Convert
it to a raw spinlock, and turn the memory allocation of the
VLPI map to be atomic.

Reported-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20191108165805.3071-12-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9c4f35e..e05673b 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -132,7 +132,7 @@ struct event_lpi_map {
 	u16			*col_map;
 	irq_hw_number_t		lpi_base;
 	int			nr_lpis;
-	struct mutex		vlpi_lock;
+	raw_spinlock_t		vlpi_lock;
 	struct its_vm		*vm;
 	struct its_vlpi_map	*vlpi_maps;
 	int			nr_vlpis;
@@ -1436,13 +1436,13 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 	if (!info->map)
 		return -EINVAL;
 
-	mutex_lock(&its_dev->event_map.vlpi_lock);
+	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	if (!its_dev->event_map.vm) {
 		struct its_vlpi_map *maps;
 
 		maps = kcalloc(its_dev->event_map.nr_lpis, sizeof(*maps),
-			       GFP_KERNEL);
+			       GFP_ATOMIC);
 		if (!maps) {
 			ret = -ENOMEM;
 			goto out;
@@ -1485,7 +1485,7 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 	}
 
 out:
-	mutex_unlock(&its_dev->event_map.vlpi_lock);
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
 	return ret;
 }
 
@@ -1495,7 +1495,7 @@ static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 	struct its_vlpi_map *map;
 	int ret = 0;
 
-	mutex_lock(&its_dev->event_map.vlpi_lock);
+	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	map = get_vlpi_map(d);
 
@@ -1508,7 +1508,7 @@ static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 	*info->map = *map;
 
 out:
-	mutex_unlock(&its_dev->event_map.vlpi_lock);
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
 	return ret;
 }
 
@@ -1518,7 +1518,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 	u32 event = its_get_event_id(d);
 	int ret = 0;
 
-	mutex_lock(&its_dev->event_map.vlpi_lock);
+	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
 		ret = -EINVAL;
@@ -1548,7 +1548,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 	}
 
 out:
-	mutex_unlock(&its_dev->event_map.vlpi_lock);
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
 	return ret;
 }
 
@@ -2608,7 +2608,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	dev->event_map.col_map = col_map;
 	dev->event_map.lpi_base = lpi_base;
 	dev->event_map.nr_lpis = nr_lpis;
-	mutex_init(&dev->event_map.vlpi_lock);
+	raw_spin_lock_init(&dev->event_map.vlpi_lock);
 	dev->device_id = dev_id;
 	INIT_LIST_HEAD(&dev->entry);
 
