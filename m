Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE73C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC42320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="FmXfjmkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfFGHeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:34:50 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:46744 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbfFGHeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:34:50 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 0152B2E0A38;
        Fri,  7 Jun 2019 10:34:47 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 8JAAoUYgLc-YkdiuvLg;
        Fri, 07 Jun 2019 10:34:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1559892886; bh=r+qlnKIT9LjEAJ34rfGoxUwRHjeBCfPpjBRNJlcp6/g=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=FmXfjmkCJJzAql6EAI5cd7CS1CCVLBuk5/8h7qf7SfvRqKj//nmZn8MJcWyGL4eaz
         Xi74w/foIHK89Iy3MaMOWVzhd8qVC/roB/Yff+DNHXu3Agwmeyr09VxuC2Xc0MEeNm
         /P6OQuhCuT+zSez3BFxMgGou8MgE1c0FtlYk9SZE=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:b19a:10ab:8629:85d9])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id opwduAb9ml-YkeCQSgV;
        Fri, 07 Jun 2019 10:34:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] drivers/ata: cleanup creation of device sysfs attribute
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Fri, 07 Jun 2019 10:34:46 +0300
Message-ID: <155989288635.1536.11972713412534297217.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges common ATA and AHCI specific attribute "sw_activity"
into one group with ->is_visible() method which hides attributes if
feature is not supported by hardware.

This allows to add all attributes in one place without exporting
each piece for linking into another list in ahci module.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 drivers/ata/ahci.h        |    4 +---
 drivers/ata/libahci.c     |    8 --------
 drivers/ata/libata-scsi.c |   48 +++++++++++++++++++++++++++++++++------------
 include/linux/libata.h    |    7 ++-----
 4 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 0570629d719d..09b55161a107 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -371,7 +371,6 @@ struct ahci_host_priv {
 extern int ahci_ignore_sss;
 
 extern struct device_attribute *ahci_shost_attrs[];
-extern struct device_attribute *ahci_sdev_attrs[];
 
 /*
  * This must be instantiated by the edge drivers.  Read the comments
@@ -382,8 +381,7 @@ extern struct device_attribute *ahci_sdev_attrs[];
 	.can_queue		= AHCI_MAX_CMDS,			\
 	.sg_tablesize		= AHCI_MAX_SG,				\
 	.dma_boundary		= AHCI_DMA_BOUNDARY,			\
-	.shost_attrs		= ahci_shost_attrs,			\
-	.sdev_attrs		= ahci_sdev_attrs
+	.shost_attrs		= ahci_shost_attrs
 
 extern struct ata_port_operations ahci_ops;
 extern struct ata_port_operations ahci_platform_ops;
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 0984c4b76d7e..532f087e7dbf 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -122,14 +122,6 @@ struct device_attribute *ahci_shost_attrs[] = {
 };
 EXPORT_SYMBOL_GPL(ahci_shost_attrs);
 
-struct device_attribute *ahci_sdev_attrs[] = {
-	&dev_attr_sw_activity,
-	&dev_attr_unload_heads,
-	&dev_attr_ncq_prio_enable,
-	NULL
-};
-EXPORT_SYMBOL_GPL(ahci_sdev_attrs);
-
 struct ata_port_operations ahci_ops = {
 	.inherits		= &sata_pmp_port_ops,
 
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a475e94944b7..810cc78814f5 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -253,9 +253,8 @@ static ssize_t ata_scsi_park_store(struct device *device,
 
 	return rc ? rc : len;
 }
-DEVICE_ATTR(unload_heads, S_IRUGO | S_IWUSR,
-	    ata_scsi_park_show, ata_scsi_park_store);
-EXPORT_SYMBOL_GPL(dev_attr_unload_heads);
+static DEVICE_ATTR(unload_heads, S_IRUGO | S_IWUSR,
+		   ata_scsi_park_show, ata_scsi_park_store);
 
 static ssize_t ata_ncq_prio_enable_show(struct device *device,
 					struct device_attribute *attr,
@@ -330,9 +329,8 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
 	return rc ? rc : len;
 }
 
-DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
-	    ata_ncq_prio_enable_show, ata_ncq_prio_enable_store);
-EXPORT_SYMBOL_GPL(dev_attr_ncq_prio_enable);
+static DEVICE_ATTR(ncq_prio_enable, S_IRUGO | S_IWUSR,
+		   ata_ncq_prio_enable_show, ata_ncq_prio_enable_store);
 
 void ata_scsi_set_sense(struct ata_device *dev, struct scsi_cmnd *cmd,
 			u8 sk, u8 asc, u8 ascq)
@@ -459,16 +457,40 @@ ata_scsi_activity_store(struct device *dev, struct device_attribute *attr,
 	}
 	return -EINVAL;
 }
-DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO, ata_scsi_activity_show,
-			ata_scsi_activity_store);
-EXPORT_SYMBOL_GPL(dev_attr_sw_activity);
+static DEVICE_ATTR(sw_activity, S_IWUSR | S_IRUGO,
+		   ata_scsi_activity_show, ata_scsi_activity_store);
 
-struct device_attribute *ata_common_sdev_attrs[] = {
-	&dev_attr_unload_heads,
-	&dev_attr_ncq_prio_enable,
+static umode_t ata_common_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct scsi_device *sdev = to_scsi_device(kobj_to_dev(kobj));
+	struct ata_port *ap = ata_shost_to_port(sdev->host);
+
+	if (a == &dev_attr_sw_activity.attr) {
+		if (!(ap->flags & ATA_FLAG_SW_ACTIVITY))
+			return 0;
+	}
+
+	return a->mode;
+}
+
+static struct attribute *ata_sdev_attrs[] = {
+	&dev_attr_unload_heads.attr,
+	&dev_attr_ncq_prio_enable.attr,
+	&dev_attr_sw_activity.attr,
+	NULL
+};
+
+static const struct attribute_group ata_sdev_attr_group = {
+	.attrs = ata_sdev_attrs,
+	.is_visible = ata_common_attrs_are_visible,
+};
+
+const struct attribute_group *ata_sdev_attr_groups[] = {
+	&ata_sdev_attr_group,
 	NULL
 };
-EXPORT_SYMBOL_GPL(ata_common_sdev_attrs);
+EXPORT_SYMBOL_GPL(ata_sdev_attr_groups);
 
 /**
  *	ata_std_bios_param - generic bios head/sector/cylinder calculator used by sd.
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 207e7ee764ce..c87a65dee8d2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -531,11 +531,8 @@ typedef int (*ata_reset_fn_t)(struct ata_link *link, unsigned int *classes,
 typedef void (*ata_postreset_fn_t)(struct ata_link *link, unsigned int *classes);
 
 extern struct device_attribute dev_attr_link_power_management_policy;
-extern struct device_attribute dev_attr_unload_heads;
-extern struct device_attribute dev_attr_ncq_prio_enable;
 extern struct device_attribute dev_attr_em_message_type;
 extern struct device_attribute dev_attr_em_message;
-extern struct device_attribute dev_attr_sw_activity;
 
 enum sw_activity {
 	OFF,
@@ -1327,7 +1324,7 @@ extern int ata_link_nr_enabled(struct ata_link *link);
  */
 extern const struct ata_port_operations ata_base_port_ops;
 extern const struct ata_port_operations sata_port_ops;
-extern struct device_attribute *ata_common_sdev_attrs[];
+extern const struct attribute_group *ata_sdev_attr_groups[];
 
 /*
  * All sht initializers (BASE, PIO, BMDMA, NCQ) must be instantiated
@@ -1349,7 +1346,7 @@ extern struct device_attribute *ata_common_sdev_attrs[];
 	.slave_destroy		= ata_scsi_slave_destroy,	\
 	.bios_param		= ata_std_bios_param,		\
 	.unlock_native_capacity	= ata_scsi_unlock_native_capacity, \
-	.sdev_attrs		= ata_common_sdev_attrs
+	.sdev_groups		= ata_sdev_attr_groups
 
 #define ATA_NCQ_SHT(drv_name)					\
 	ATA_BASE_SHT(drv_name),					\

