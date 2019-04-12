Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E387EC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7A12083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfDLI6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:58:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727278AbfDLI61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:58:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B481B12ED4669CC8B778;
        Fri, 12 Apr 2019 16:58:24 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.408.0; Fri, 12 Apr 2019 16:58:16 +0800
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 4/6] scsi: libsas: Inject revalidate event for root port event
Date:   Fri, 12 Apr 2019 16:57:55 +0800
Message-ID: <1555059478-36224-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1555059478-36224-1-git-send-email-john.garry@huawei.com>
References: <1555059478-36224-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SAS spec, an expander device shall transmit BROADCAST
(CHANGE) from at least one phy in each expander port other than the
expander port that is the cause for transmitting BROADCAST (CHANGE).

As such, for when the link is lost for a root PHY attached to an
expander PHY, we get no broadcast event.

This causes an issue for libsas, in that we will not revalidate the
domain for these events.

As a solution, for when a root PHY is formed or deformed from a root
port, insert a broadcast event to trigger a domain revalidation.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_port.c | 24 +++++++++++++++++++++---
 include/scsi/libsas.h          |  7 +++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libsas/sas_port.c b/drivers/scsi/libsas/sas_port.c
index 03fe479359b6..38a10478605c 100644
--- a/drivers/scsi/libsas/sas_port.c
+++ b/drivers/scsi/libsas/sas_port.c
@@ -95,6 +95,7 @@ static void sas_form_port(struct asd_sas_phy *phy)
 	int i;
 	struct sas_ha_struct *sas_ha = phy->ha;
 	struct asd_sas_port *port = phy->port;
+	struct domain_device *port_dev;
 	struct sas_internal *si =
 		to_sas_internal(sas_ha->core.shost->transportt);
 	unsigned long flags;
@@ -153,8 +154,9 @@ static void sas_form_port(struct asd_sas_phy *phy)
 	}
 
 	/* add the phy to the port */
+	port_dev = port->port_dev;
 	list_add_tail(&phy->port_phy_el, &port->phy_list);
-	sas_phy_set_target(phy, port->port_dev);
+	sas_phy_set_target(phy, port_dev);
 	phy->port = port;
 	port->num_phys++;
 	port->phy_mask |= (1U << phy->id);
@@ -184,14 +186,21 @@ static void sas_form_port(struct asd_sas_phy *phy)
 		 port->phy_mask,
 		 SAS_ADDR(port->attached_sas_addr));
 
-	if (port->port_dev)
-		port->port_dev->pathways = port->num_phys;
+	if (port_dev)
+		port_dev->pathways = port->num_phys;
 
 	/* Tell the LLDD about this port formation. */
 	if (si->dft->lldd_port_formed)
 		si->dft->lldd_port_formed(phy);
 
 	sas_discover_event(phy->port, DISCE_DISCOVER_DOMAIN);
+	/* Only insert a revalidate event after initial discovery */
+	if (port_dev && sas_dev_type_is_expander(port_dev->dev_type)) {
+		struct expander_device *ex_dev = &port_dev->ex_dev;
+
+		ex_dev->ex_change_count = -1;
+		sas_discover_event(port, DISCE_REVALIDATE_DOMAIN);
+	}
 	flush_workqueue(sas_ha->disco_q);
 }
 
@@ -254,6 +263,15 @@ void sas_deform_port(struct asd_sas_phy *phy, int gone)
 	spin_unlock(&port->phy_list_lock);
 	spin_unlock_irqrestore(&sas_ha->phy_port_lock, flags);
 
+	/* Only insert revalidate event if the port still has members */
+	if (port->port && dev && sas_dev_type_is_expander(dev->dev_type)) {
+		struct expander_device *ex_dev = &dev->ex_dev;
+
+		ex_dev->ex_change_count = -1;
+		sas_discover_event(port, DISCE_REVALIDATE_DOMAIN);
+	}
+	flush_workqueue(sas_ha->disco_q);
+
 	return;
 }
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index cfaaf1254211..b08febec7895 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -224,6 +224,13 @@ struct sas_work {
 	struct work_struct work;
 };
 
+/* Lots of code duplicates this in the SCSI tree, which can be factored out */
+static inline bool sas_dev_type_is_expander(enum sas_device_type type)
+{
+	return type == SAS_EDGE_EXPANDER_DEVICE ||
+	       type == SAS_FANOUT_EXPANDER_DEVICE;
+}
+
 static inline void INIT_SAS_WORK(struct sas_work *sw, void (*fn)(struct work_struct *))
 {
 	INIT_WORK(&sw->work, fn);
-- 
2.17.1

