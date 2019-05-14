Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED2C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575BB20850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfENRXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:23:18 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:41762 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfENRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:23:18 -0400
Received: from gsql.ggedos.sk (off-20.infotel.telecom.sk [212.5.213.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id AA9F47A045F;
        Tue, 14 May 2019 19:23:16 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] fdomain: Resurrect driver (PCI support)
Date:   Tue, 14 May 2019 19:23:08 +0200
Message-Id: <20190514172309.12874-3-linux@zary.sk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190514172309.12874-1-linux@zary.sk>
References: <20190514172309.12874-1-linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future Domain TMC-3260/AHA-2920A PCI card support.

Tested on Adaptec AHA-2920A PCI card.

Signed-off-by: Ondrej Zary <linux@zary.sk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/Kconfig       | 17 ++++++++++++
 drivers/scsi/Makefile      |  1 +
 drivers/scsi/fdomain_pci.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)
 create mode 100644 drivers/scsi/fdomain_pci.c

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 3d6b1f47cbb5..f9d058a07e2a 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -667,6 +667,23 @@ config SCSI_FDOMAIN
 	tristate
 	depends on SCSI
 
+config SCSI_FDOMAIN_PCI
+	tristate "Future Domain TMC-3260/AHA-2920A PCI SCSI support"
+	depends on PCI && SCSI
+	select SCSI_FDOMAIN
+	help
+	  This is support for Future Domain's PCI SCSI host adapters (TMC-3260)
+	  and other adapters with PCI bus based on the Future Domain chipsets
+	  (Adaptec AHA-2920A).
+
+	  NOTE: Newer Adaptec AHA-2920C boards use the Adaptec AIC-7850 chip
+	  and should use the aic7xxx driver ("Adaptec AIC7xxx chipset SCSI
+	  controller support"). This Future Domain driver works with the older
+	  Adaptec AHA-2920A boards with a Future Domain chip on them.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called fdomain_pci.
+
 config SCSI_GDTH
 	tristate "Intel/ICP (former GDT SCSI Disk Array) RAID Controller support"
 	depends on PCI && SCSI
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index b8fbc6d2de54..f6cc4fbe6957 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -77,6 +77,7 @@ obj-$(CONFIG_SCSI_PM8001)	+= pm8001/
 obj-$(CONFIG_SCSI_ISCI)		+= isci/
 obj-$(CONFIG_SCSI_IPS)		+= ips.o
 obj-$(CONFIG_SCSI_FDOMAIN)	+= fdomain.o
+obj-$(CONFIG_SCSI_FDOMAIN_PCI)	+= fdomain_pci.o
 obj-$(CONFIG_SCSI_GENERIC_NCR5380) += g_NCR5380.o
 obj-$(CONFIG_SCSI_QLOGIC_FAS)	+= qlogicfas408.o	qlogicfas.o
 obj-$(CONFIG_PCMCIA_QLOGIC)	+= qlogicfas408.o
diff --git a/drivers/scsi/fdomain_pci.c b/drivers/scsi/fdomain_pci.c
new file mode 100644
index 000000000000..3e05ce7b89e5
--- /dev/null
+++ b/drivers/scsi/fdomain_pci.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "fdomain.h"
+
+static int fdomain_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *d)
+{
+	int err;
+	struct Scsi_Host *sh;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		goto fail;
+
+	err = pci_request_regions(pdev, "fdomain_pci");
+	if (err)
+		goto disable_device;
+
+	err = -ENODEV;
+	if (pci_resource_len(pdev, 0) == 0)
+		goto release_region;
+
+	sh = fdomain_create(pci_resource_start(pdev, 0), pdev->irq, 7,
+			    &pdev->dev);
+	if (!sh)
+		goto release_region;
+
+	pci_set_drvdata(pdev, sh);
+	return 0;
+
+release_region:
+	pci_release_regions(pdev);
+disable_device:
+	pci_disable_device(pdev);
+fail:
+	return err;
+}
+
+static void fdomain_pci_remove(struct pci_dev *pdev)
+{
+	struct Scsi_Host *sh = pci_get_drvdata(pdev);
+
+	fdomain_destroy(sh);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static struct pci_device_id fdomain_pci_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_FD, PCI_DEVICE_ID_FD_36C70) },
+	{}
+};
+MODULE_DEVICE_TABLE(pci, fdomain_pci_table);
+
+static struct pci_driver fdomain_pci_driver = {
+	.name		= "fdomain_pci",
+	.id_table	= fdomain_pci_table,
+	.probe		= fdomain_pci_probe,
+	.remove		= fdomain_pci_remove,
+	.driver.pm	= FDOMAIN_PM_OPS,
+};
+
+module_pci_driver(fdomain_pci_driver);
+
+MODULE_AUTHOR("Ondrej Zary, Rickard E. Faith");
+MODULE_DESCRIPTION("Future Domain TMC-3260 PCI SCSI driver");
+MODULE_LICENSE("GPL");
-- 
Ondrej Zary

