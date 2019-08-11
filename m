Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18747C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9172216F4
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 15:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfHKPgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 11:36:54 -0400
Received: from enpas.org ([46.38.239.100]:53548 "EHLO mail.enpas.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfHKPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 11:36:54 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id 4B4C7FF845;
        Sun, 11 Aug 2019 15:36:50 +0000 (UTC)
From:   Max Staudt <max@enpas.org>
To:     b.zolnierkie@samsung.com, axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        schmitzmic@gmail.com, geert@linux-m68k.org,
        Max Staudt <max@enpas.org>
Subject: [PATCH v4] ata/pata_buddha: Probe via modalias instead of initcall
Date:   Sun, 11 Aug 2019 17:36:43 +0200
Message-Id: <20190811153643.12029-1-max@enpas.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Up until now, the pata_buddha driver would only check for cards on
initcall time. Now, the kernel will call its probe function as soon
as a compatible card is detected.

v4: Cleap up pata_buddha_probe() by using ent->driver_data,
    Support X-Surf via late_initcall()

v3: Clean up devm_*, implement device removal.

v2: Rename 'zdev' to 'z' to make the patch easy to analyse with
    git diff --ignore-space-change

Tested-by: Max Staudt <max@enpas.org>
Signed-off-by: Max Staudt <max@enpas.org>
---
 drivers/ata/pata_buddha.c | 243 ++++++++++++++++++++++++++++------------------
 1 file changed, 150 insertions(+), 93 deletions(-)

diff --git a/drivers/ata/pata_buddha.c b/drivers/ata/pata_buddha.c
index 11a8044ff..25d03b595 100644
--- a/drivers/ata/pata_buddha.c
+++ b/drivers/ata/pata_buddha.c
@@ -18,7 +18,9 @@
 #include <linux/kernel.h>
 #include <linux/libata.h>
 #include <linux/mm.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/types.h>
 #include <linux/zorro.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_host.h>
@@ -29,7 +31,7 @@
 #include <asm/setup.h>
 
 #define DRV_NAME "pata_buddha"
-#define DRV_VERSION "0.1.0"
+#define DRV_VERSION "0.1.1"
 
 #define BUDDHA_BASE1	0x800
 #define BUDDHA_BASE2	0xa00
@@ -47,11 +49,11 @@ enum {
 	BOARD_XSURF
 };
 
-static unsigned int buddha_bases[3] __initdata = {
+static unsigned int buddha_bases[3] = {
 	BUDDHA_BASE1, BUDDHA_BASE2, BUDDHA_BASE3
 };
 
-static unsigned int xsurf_bases[2] __initdata = {
+static unsigned int xsurf_bases[2] = {
 	XSURF_BASE1, XSURF_BASE2
 };
 
@@ -145,111 +147,166 @@ static struct ata_port_operations pata_xsurf_ops = {
 	.set_mode	= pata_buddha_set_mode,
 };
 
-static int __init pata_buddha_init_one(void)
+static int pata_buddha_probe(struct zorro_dev *z,
+			     const struct zorro_device_id *ent)
 {
-	struct zorro_dev *z = NULL;
+	static const char * const board_name[]
+		= { "Buddha", "Catweasel", "X-Surf" };
+	struct ata_host *host;
+	void __iomem *buddha_board;
+	unsigned long board;
+	unsigned int type = ent->driver_data;
+	unsigned int nr_ports = (type == BOARD_CATWEASEL) ? 3 : 2;
+	int i;
+
+	dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
+
+	board = z->resource.start;
+
+	if (type != BOARD_XSURF) {
+		if (!devm_request_mem_region(&z->dev,
+					     board + BUDDHA_BASE1,
+					     0x800, DRV_NAME))
+			return -ENXIO;
+	} else {
+		if (!devm_request_mem_region(&z->dev,
+					     board + XSURF_BASE1,
+					     0x1000, DRV_NAME))
+			return -ENXIO;
+		if (!devm_request_mem_region(&z->dev,
+					     board + XSURF_BASE2,
+					     0x1000, DRV_NAME)) {
+		}
+	}
+
+	/* allocate host */
+	host = ata_host_alloc(&z->dev, nr_ports);
+	if (!host)
+		return -ENXIO;
+
+	buddha_board = ZTWO_VADDR(board);
 
-	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-		static const char *board_name[]
-			= { "Buddha", "Catweasel", "X-Surf" };
-		struct ata_host *host;
-		void __iomem *buddha_board;
-		unsigned long board;
-		unsigned int type, nr_ports = 2;
-		int i;
-
-		if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA) {
-			type = BOARD_BUDDHA;
-		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL) {
-			type = BOARD_CATWEASEL;
-			nr_ports++;
-		} else if (z->id == ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF) {
-			type = BOARD_XSURF;
-		} else
-			continue;
-
-		dev_info(&z->dev, "%s IDE controller\n", board_name[type]);
-
-		board = z->resource.start;
+	/* enable the board IRQ on Buddha/Catweasel */
+	if (type != BOARD_XSURF)
+		z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
+
+	for (i = 0; i < nr_ports; i++) {
+		struct ata_port *ap = host->ports[i];
+		void __iomem *base, *irqport;
+		unsigned long ctl = 0;
 
 		if (type != BOARD_XSURF) {
-			if (!devm_request_mem_region(&z->dev,
-						     board + BUDDHA_BASE1,
-						     0x800, DRV_NAME))
-				continue;
+			ap->ops = &pata_buddha_ops;
+			base = buddha_board + buddha_bases[i];
+			ctl = BUDDHA_CONTROL;
+			irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
 		} else {
-			if (!devm_request_mem_region(&z->dev,
-						     board + XSURF_BASE1,
-						     0x1000, DRV_NAME))
-				continue;
-			if (!devm_request_mem_region(&z->dev,
-						     board + XSURF_BASE2,
-						     0x1000, DRV_NAME))
-				continue;
+			ap->ops = &pata_xsurf_ops;
+			base = buddha_board + xsurf_bases[i];
+			/* X-Surf has no CS1* (Control/AltStat) */
+			irqport = buddha_board + XSURF_IRQ;
 		}
 
-		/* allocate host */
-		host = ata_host_alloc(&z->dev, nr_ports);
-		if (!host)
-			continue;
-
-		buddha_board = ZTWO_VADDR(board);
-
-		/* enable the board IRQ on Buddha/Catweasel */
-		if (type != BOARD_XSURF)
-			z_writeb(0, buddha_board + BUDDHA_IRQ_MR);
-
-		for (i = 0; i < nr_ports; i++) {
-			struct ata_port *ap = host->ports[i];
-			void __iomem *base, *irqport;
-			unsigned long ctl = 0;
-
-			if (type != BOARD_XSURF) {
-				ap->ops = &pata_buddha_ops;
-				base = buddha_board + buddha_bases[i];
-				ctl = BUDDHA_CONTROL;
-				irqport = buddha_board + BUDDHA_IRQ + i * 0x40;
-			} else {
-				ap->ops = &pata_xsurf_ops;
-				base = buddha_board + xsurf_bases[i];
-				/* X-Surf has no CS1* (Control/AltStat) */
-				irqport = buddha_board + XSURF_IRQ;
-			}
-
-			ap->pio_mask = ATA_PIO4;
-			ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
-
-			ap->ioaddr.data_addr		= base;
-			ap->ioaddr.error_addr		= base + 2 + 1 * 4;
-			ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
-			ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
-			ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
-			ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
-			ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
-			ap->ioaddr.device_addr		= base + 2 + 6 * 4;
-			ap->ioaddr.status_addr		= base + 2 + 7 * 4;
-			ap->ioaddr.command_addr		= base + 2 + 7 * 4;
-
-			if (ctl) {
-				ap->ioaddr.altstatus_addr = base + ctl;
-				ap->ioaddr.ctl_addr	  = base + ctl;
-			}
-
-			ap->private_data = (void *)irqport;
-
-			ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
-				      ctl ? board + buddha_bases[i] + ctl : 0);
+		ap->pio_mask = ATA_PIO4;
+		ap->flags |= ATA_FLAG_SLAVE_POSS | ATA_FLAG_NO_IORDY;
+
+		ap->ioaddr.data_addr		= base;
+		ap->ioaddr.error_addr		= base + 2 + 1 * 4;
+		ap->ioaddr.feature_addr		= base + 2 + 1 * 4;
+		ap->ioaddr.nsect_addr		= base + 2 + 2 * 4;
+		ap->ioaddr.lbal_addr		= base + 2 + 3 * 4;
+		ap->ioaddr.lbam_addr		= base + 2 + 4 * 4;
+		ap->ioaddr.lbah_addr		= base + 2 + 5 * 4;
+		ap->ioaddr.device_addr		= base + 2 + 6 * 4;
+		ap->ioaddr.status_addr		= base + 2 + 7 * 4;
+		ap->ioaddr.command_addr		= base + 2 + 7 * 4;
+
+		if (ctl) {
+			ap->ioaddr.altstatus_addr = base + ctl;
+			ap->ioaddr.ctl_addr	  = base + ctl;
 		}
 
-		ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
-				  IRQF_SHARED, &pata_buddha_sht);
+		ap->private_data = (void *)irqport;
 
+		ata_port_desc(ap, "cmd 0x%lx ctl 0x%lx", board,
+			      ctl ? board + buddha_bases[i] + ctl : 0);
 	}
 
+	ata_host_activate(host, IRQ_AMIGA_PORTS, ata_sff_interrupt,
+			  IRQF_SHARED, &pata_buddha_sht);
+
+
 	return 0;
 }
 
-module_init(pata_buddha_init_one);
+static void pata_buddha_remove(struct zorro_dev *z)
+{
+	struct ata_host *host = dev_get_drvdata(&z->dev);
+
+	ata_host_detach(host);
+}
+
+static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
+	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, BOARD_BUDDHA},
+	{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, BOARD_CATWEASEL},
+	/* { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF}, */
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(zorro, pata_buddha_zorro_tbl);
+
+static struct zorro_driver pata_buddha_driver = {
+	.name           = "pata_buddha",
+	.id_table       = pata_buddha_zorro_tbl,
+	.probe          = pata_buddha_probe,
+	.remove         = pata_buddha_remove,
+};
+
+
+
+/*
+ * We cannot have a modalias for X-Surf boards, as it competes with the
+ * zorro8390 network driver. As a stopgap measure until we have proper
+ * MFC support for this board, we manually attach to it late after Zorro
+ * has enumerated its boards.
+ */
+static int __init pata_buddha_late_init(void)
+{
+        struct zorro_dev *z = NULL;
+
+	pr_info("pata_buddha: Scanning for stand-alone IDE controllers...\n");
+	zorro_register_driver(&pata_buddha_driver);
+
+	pr_info("pata_buddha: Scanning for X-Surf boards...\n");
+        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
+		static struct zorro_device_id xsurf_ent =
+			{ ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, BOARD_XSURF};
+
+		pata_buddha_probe(z, &xsurf_ent);
+        }
+
+        return 0;
+}
+
+static void __exit pata_buddha_exit(void)
+{
+	struct zorro_dev *z = NULL;
+
+	pr_info("pata_buddha: Releasing X-Surf boards...\n");
+        while ((z = zorro_find_device(ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, z))) {
+		struct ata_host *host = dev_get_drvdata(&z->dev);
+
+		if (host)
+			ata_host_detach(host);
+        }
+
+	pr_info("pata_buddha: Releasing stand-alone IDE controllers...\n");
+        zorro_unregister_driver(&pata_buddha_driver);
+}
+
+late_initcall(pata_buddha_late_init);
+module_exit(pata_buddha_exit);
+
 
 MODULE_AUTHOR("Bartlomiej Zolnierkiewicz");
 MODULE_DESCRIPTION("low-level driver for Buddha/Catweasel/X-Surf PATA");
-- 
2.11.0

