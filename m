Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D10DC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB02217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 16:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572971511;
	bh=7YZKoMBdIMG5LxiBKu+hEcjHLWRggSK3vGSt3BTj1QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zsSXgHHCPKLNOh6twVQkhCxWmyk9hH8dKhFFPbrB4OcEZnSs4GHwYUjUdXT/zyk5c
	 lre5r2Kd08k7THMHO/6fRYy/UuMgpxwt5dH/8C/+2MhU017r0IhUKqqwxXd0fLW0aK
	 GeWqfVK9Y4k8gRK65xrDfow/88FYuXO4MWJmpG00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbfKEQbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 11:31:50 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:51919 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390116AbfKEQbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 11:31:50 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iS1bv-0001q9-H4; Tue, 05 Nov 2019 17:23:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH 11/11] irqchip/gic-v3-its: Make vlpi_lock a spinlock
Date:   Tue,  5 Nov 2019 16:22:58 +0000
Message-Id: <20191105162258.22214-12-maz@kernel.org>
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

The VLPI map is currently a mutex, and that's a bad idea as
this lock can be taken in non-preemptible contexts. Convert
it to a raw spinlock, and turn the memory allocation of the
VLPI map to be atomic.

Reported-by: Heyi Guo <guoheyi@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 58ce231d5ade..93a39fcc2c96 100644
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
@@ -1433,13 +1433,13 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
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
@@ -1482,7 +1482,7 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 	}
 
 out:
-	mutex_unlock(&its_dev->event_map.vlpi_lock);
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
 	return ret;
 }
 
@@ -1492,7 +1492,7 @@ static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 	struct its_vlpi_map *map;
 	int ret = 0;
 
-	mutex_lock(&its_dev->event_map.vlpi_lock);
+	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	map = get_vlpi_map(d);
 
@@ -1505,7 +1505,7 @@ static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 	*info->map = *map;
 
 out:
-	mutex_unlock(&its_dev->event_map.vlpi_lock);
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
 	return ret;
 }
 
@@ -1515,7 +1515,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 	u32 event = its_get_event_id(d);
 	int ret = 0;
 
-	mutex_lock(&its_dev->event_map.vlpi_lock);
+	raw_spin_lock(&its_dev->event_map.vlpi_lock);
 
 	if (!its_dev->event_map.vm || !irqd_is_forwarded_to_vcpu(d)) {
 		ret = -EINVAL;
@@ -1545,7 +1545,7 @@ static int its_vlpi_unmap(struct irq_data *d)
 	}
 
 out:
-	mutex_unlock(&its_dev->event_map.vlpi_lock);
+	raw_spin_unlock(&its_dev->event_map.vlpi_lock);
 	return ret;
 }
 
@@ -2605,7 +2605,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	dev->event_map.col_map = col_map;
 	dev->event_map.lpi_base = lpi_base;
 	dev->event_map.nr_lpis = nr_lpis;
-	mutex_init(&dev->event_map.vlpi_lock);
+	raw_spin_lock_init(&dev->event_map.vlpi_lock);
 	dev->device_id = dev_id;
 	INIT_LIST_HEAD(&dev->entry);
 
-- 
2.20.1

