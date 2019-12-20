Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EC4C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88035222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfLTPsL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:48:11 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:44887 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727181AbfLTPsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:48:11 -0500
Received: from [85.158.142.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 75/01-12462-72DECFD5; Fri, 20 Dec 2019 15:47:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRWlGSWpSXmKPExsVyU+ECq67a2z+
  xBjNfSVj8nXSM3aJ58Xo2i8u75rA5MHv8/jWJ0WP/3DXsHp83yQUwR7Fm5iXlVySwZjS9XMRU
  MOEUW8WuKSdYGxgnbWLtYuTkEBLYxyhxvE+xi5ELyD7KKLF7z3IWkASbgJpE97KlbCC2iIChR
  GvPanYQm1kgU+LDsrVgzcICbhJTfuxkBLFZBFQlPl76wQxi8wpYSUzp3QhWLyEgL7H12ydWiL
  igxMmZT1gg5mhKtG7/DTVTW2LZwtfMEAcpSZz5+4Gpi5EDqNda4uqXkgmMfLOQdM9C0j0LSfc
  CRuZVjJZJRZnpGSW5iZk5uoYGBrqGhsa6JrpGBgZ6iVW6SXqppbrJqXklRYlAWb3E8mK94src
  5JwUvbzUkk2MwMBNKWQ5sYPx1Ne3eocYJTmYlER5k/z/xArxJeWnVGYkFmfEF5XmpBYfYpTh4
  FCS4F3yBignWJSanlqRlpkDjCKYtAQHj5IIrxlImre4IDG3ODMdInWK0ZLj9oYli5g5br4HkZ
  vnLl3ELMSSl5+XKiXO6wHSIADSkFGaBzcOFumXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinMwKgn
  zzgSZwpOZVwK39RXQQUxAB3Fo/gI5qCQRISXVwDQtVX6bnor9eRPJWQsXGApKLDn9ff3Zrfff
  91hm7hDc/nmyZqN1xMYnWs3SYc0xzqF1W99477z+9F9w66TNcwoK+RgOSVd3ONt/Fk8o+LEu/
  W/Ct5vCarN9d89kTDDyMgh7td63t/Rn9Mm/iV9rUiI/H92aE7BPj/Noi3bZspM9f2pDzz7pjV
  DP6bCNC0lJ3C8mctGxK8Umq5N5RfcfDUVB1ns2KytvvWWel2k1oXGNTX5k3n2pvVOklmywaVm
  9N0KqSG/Pt9uXNkzIWjx/db+qzZF3pgl7T+ZI8VziZXMVmuOrnfH78kH7S/pagS9c9EK7q6em
  8j9NUazOUeVuf770ce5aRRsZttzzW6bkKLEUZyQaajEXFScCAO7JLgNvAwAA
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-15.tower-244.messagelabs.com!1576856869!1021919!3
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24416 invoked from network); 20 Dec 2019 15:47:50 -0000
Received: from unknown (HELO exukdagfar02.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-15.tower-244.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 20 Dec 2019 15:47:50 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar02.INTERNAL.ROOT.TES (10.194.2.71) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Dec 2019 15:47:48 +0000
Received: from kimbop.ncipher.com (172.23.136.54) by
 exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 20 Dec 2019 15:47:48 +0000
From:   Dave Kim <david.kim@ncipher.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     David Kim <david.kim@ncipher.com>, <linux-kernel@vger.kernel.org>,
        Tim Magee <tim.magee@ncipher.com>
Subject: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Date:   Fri, 20 Dec 2019 15:47:38 +0000
Message-ID: <20191220154738.31448-1-david.kim@ncipher.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-EXCLAIMER-MD-CONFIG: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿From: David Kim <david.kim@ncipher.com>

This is the driver for nCipher’s Solo and Solo XC hardware security modules.
These modules implement a proprietary command set (the ’nCore API’) to
perform cryptographic operations - key generation, signature, and so on. HSM
commands and their replies are passed in a serialised binary format over the
PCIe bus via a shared memory region. Multiple commands may be in-flight at
any one time - command processing is multi-threaded and asynchronous. A write
operation may, therefore, deliver multiple commands, and multiple replies may
be retrieved in one read operation.

The HSM is supported by software supplied by nCipher. The driver supports
only a single user-space connection, so the support software includes a
daemon called ‘hardserver’ . This accepts network or Unix- domain socket
connections from client applications, and multiplexes / demultiplexes
commands and replies from these clients to one or more HSM devices.

The nCipher support software includes a variety of command-line and graphical
tools for HSM management, and a number of libraries which interface between
numerous industry-standard APIs and the nCore API commands implemented by the
HSM. On Linux, the JCE (Java Cryptography Extensions) and C-language PKCS#11
interfaces are supported.

Previously, the support software included the kernel driver as source code,
which is built against the host machine’s kernel headers when the support
software is installed.  For most standard OS distributions this isn’t a
problem, but many users in security- sensitive environments (such as banking
services) remove all unnecessary components for their own in-house
distributions. For these users, the need to support compiling and loading of
externally- supplied kernel modules is problematic, and adds extra friction
when the kernel needs to be updated.

In general, users who have an nCipher PCI HSM will be able to download the
required support software from nCipher. The devices themselves are subject to
export control restrictions under US and EU law, and because of this we are
unable to make the software freely available, or offer detailed technical
support, in all territories.

Co-developed-by: Tim Magee <tim.magee@ncipher.com>
Signed-off-by: Tim Magee <tim.magee@ncipher.com>
Signed-off-by: Dave Kim <david.kim@ncipher.com>

---
 MAINTAINERS                       |    9 +
 drivers/misc/Kconfig              |    1 +
 drivers/misc/Makefile             |    1 +
 drivers/misc/ncipher/Kconfig      |    8 +
 drivers/misc/ncipher/Makefile     |    7 +
 drivers/misc/ncipher/fsl.c        |  881 +++++++++++++++++
 drivers/misc/ncipher/fsl.h        |  116 +++
 drivers/misc/ncipher/hostif.c     | 1522 +++++++++++++++++++++++++++++
 drivers/misc/ncipher/i21555.c     |  623 ++++++++++++
 drivers/misc/ncipher/i21555.h     |   64 ++
 drivers/misc/ncipher/solo.h       |  315 ++++++
 include/uapi/linux/nshield_solo.h |  159 +++
 12 files changed, 3706 insertions(+)
 create mode 100644 drivers/misc/ncipher/Kconfig
 create mode 100644 drivers/misc/ncipher/Makefile
 create mode 100644 drivers/misc/ncipher/fsl.c
 create mode 100644 drivers/misc/ncipher/fsl.h
 create mode 100644 drivers/misc/ncipher/hostif.c
 create mode 100644 drivers/misc/ncipher/i21555.c
 create mode 100644 drivers/misc/ncipher/i21555.h
 create mode 100644 drivers/misc/ncipher/solo.h
 create mode 100644 include/uapi/linux/nshield_solo.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 061d59a4a80b..fb0ce295a0e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11319,6 +11319,15 @@ NATSEMI ETHERNET DRIVER (DP8381x)
 S:	Orphan
 F:	drivers/net/ethernet/natsemi/natsemi.c
 
+NCIPHER NSHIELD HARDWARE SECURITY MODULE DRIVERS
+M:	Tim Magee <tim.magee@ncipher.com>
+M:	David Kim <david.kim@ncipher.com>
+M:	Hamish Cameron <hamish.cameron@ncipher.com>
+W:	https://www.ncipher.com/products/general-purpose-hsms/nshield-solo
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/misc/ncipher/
+
 NCR 5380 SCSI DRIVERS
 M:	Finn Thain <fthain@telegraphics.com.au>
 M:	Michael Schmitz <schmitzmic@gmail.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7f0d48f406e3..a6265ad5ca98 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -480,4 +480,5 @@ source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 source "drivers/misc/habanalabs/Kconfig"
+source "drivers/misc/ncipher/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index c1860d35dc7e..8e4a6ab0a7ba 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
 obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
+obj-$(CONFIG_NCIPHER)		+= ncipher/
diff --git a/drivers/misc/ncipher/Kconfig b/drivers/misc/ncipher/Kconfig
new file mode 100644
index 000000000000..5b466cd1896a
--- /dev/null
+++ b/drivers/misc/ncipher/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+# Enable support for nCipher's nShield Solo and Solo XC
+config HSM_NCIPHER_NSHIELD_SOLO
+	tristate "nCipher Solo and Solo XC family of PCIe HSMs"
+	depends on PCI
+	help
+	  Select this as built-in or module if you expect to use
+	  a Hardware Security Module from nCipher's Solo or Solo XC range.
diff --git a/drivers/misc/ncipher/Makefile b/drivers/misc/ncipher/Makefile
new file mode 100644
index 000000000000..b4d5f92addee
--- /dev/null
+++ b/drivers/misc/ncipher/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for nCipher nShield HSM drivers
+#
+
+obj-$(CONFIG_HSM_NCIPHER_NSHIELD_SOLO) := nshield_solo.o
+nshield_solo-y := hostif.o fsl.o i21555.o
diff --git a/drivers/misc/ncipher/fsl.c b/drivers/misc/ncipher/fsl.c
new file mode 100644
index 000000000000..175c8ef37745
--- /dev/null
+++ b/drivers/misc/ncipher/fsl.c
@@ -0,0 +1,881 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * fsl.c: nCipher PCI HSM FSL command driver
+ * Copyright 2019 nCipher Security Ltd
+ *
+ */
+
+#include "solo.h"
+#include "fsl.h"
+
+/**
+ * fsl_create - Resets FSL device.
+ * @ndev:	common device
+ *
+ * Extra device info is initialized the first time created.
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int fsl_create(struct nfp_dev *ndev)
+{
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	if (ndev->created) {
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: device already created", __func__);
+		return 0;
+	}
+
+	ndev->active_bar = -1;
+	ndev->detection_type = NFP_HSM_POLLING;
+	ndev->conn_status = NFP_HSM_STARTING;
+
+	/*
+	 * try to reset check doorbell registers
+	 * (don't read back in case they hang)
+	 */
+	ndev->active_bar = FSL_MEMBAR;
+	fsl_outl(ndev, FSL_OFFSET_DOORBELL_CS_STATUS, NFAST_INT_DEVICE_CLR);
+
+	if (!ndev->bar[ndev->active_bar]) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: null FSL memory BAR[%d]",
+			__func__, ndev->active_bar);
+		return -ENOMEM;
+	}
+
+	/* set our context to just be a pointer to ourself */
+	ndev->cmdctx = ndev;
+
+	/*
+	 * try to reset read/write doorbell registers
+	 * (don't read back in case they hang)
+	 */
+	dev_notice(&ndev->pcidev->dev,
+		   "%s: clearing read/write doorbell registers", __func__);
+	fsl_outl(ndev, FSL_OFFSET_DOORBELL_WR_CMD, NFAST_INT_HOST_CLR);
+	fsl_outl(ndev, FSL_OFFSET_DOORBELL_RD_CMD, NFAST_INT_HOST_CLR);
+
+	dev_notice(&ndev->pcidev->dev, "%s: exiting %s active_bar: %d.",
+		   __func__, __func__, ndev->active_bar);
+
+	ndev->created = 1;
+
+	return 0;
+}
+
+/**
+ * fsl_destroy - Destroys an FSL device.
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int fsl_destroy(struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev;
+
+	/* check for device */
+	ndev = ctx;
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* clear doorbell registers */
+	if (ndev->bar[ndev->active_bar]) {
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: clearing doorbell registers", __func__);
+		fsl_outl(ndev,
+			 FSL_OFFSET_DOORBELL_WR_STATUS, NFAST_INT_DEVICE_CLR);
+		fsl_outl(ndev,
+			 FSL_OFFSET_DOORBELL_RD_STATUS, NFAST_INT_DEVICE_CLR);
+		fsl_outl(ndev,
+			 FSL_OFFSET_DOORBELL_CS_STATUS, NFAST_INT_DEVICE_CLR);
+	} else {
+		dev_err(&ndev->pcidev->dev,
+			"%s: warning: no FSL BAR[%d] memory",
+			__func__, ndev->active_bar);
+	}
+
+	return 0;
+}
+
+/**
+ * fsl_created - Returns fsl_created status.
+ * @ndev:	common device
+ *
+ * RETURNS: 0 if created or other value if error.
+ */
+static int fsl_created(struct nfp_dev *ndev)
+{
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	if (!ndev->created) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: device not created", __func__);
+		return -ENODEV;
+	}
+
+	if (!ndev->bar[ndev->active_bar]) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: no FSL BAR[%d] memory", __func__,
+			ndev->active_bar);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * fsl_started - Returns the current status of the connection.
+ * @ndev:	common device
+ *
+ * RETURNS: 0 if started, NFP_HSM_STARTING if not ready,
+ * or other value if error.
+ */
+static int fsl_started(struct nfp_dev *ndev)
+{
+	int status = NFP_HSM_STARTING;
+	int epd_status = NFP_HSM_STARTING;
+	u32 doorbell_cs = 0x0;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	if (!ndev->bar[ndev->active_bar]) {
+		dev_err(&ndev->pcidev->dev, "%s: error: no FSL BAR[%d] memory",
+			__func__, ndev->active_bar);
+		return -ENOMEM;
+	}
+
+	/* check the status register to see if epd has started */
+	doorbell_cs = fsl_inl(ndev, FSL_OFFSET_DOORBELL_POLLING);
+	dev_notice(&ndev->pcidev->dev,
+		   "%s: doorbell_polling is: %x", __func__, doorbell_cs);
+
+	if (doorbell_cs == NFAST_INT_DEVICE_POLL) {
+		epd_status = NFP_HSM_POLLING;
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: EPD in polling mode", __func__);
+	} else if (doorbell_cs == NFAST_INT_DEVICE_PCI_DOWN) {
+		epd_status = NFAST_INT_DEVICE_PCI_DOWN;
+	}
+
+	/* check current connection status */
+
+	/*
+	 * support backwards compatibility with the interrupt driven approach
+	 * to detection.
+	 */
+	if (epd_status == NFP_HSM_POLLING) {
+		ndev->detection_type = NFP_HSM_POLLING;
+		ndev->conn_status = 0;
+		status = ndev->conn_status;
+		dev_notice(&ndev->pcidev->dev, "%s: device started", __func__);
+	} else if (epd_status == NFAST_INT_DEVICE_PCI_DOWN) {
+		ndev->conn_status = NFP_HSM_STARTING;
+		dev_notice(&ndev->pcidev->dev, "%s: device starting", __func__);
+		/* Closest existing error code */
+		status = -EAGAIN;
+	}
+
+	return status;
+}
+
+/**
+ * fsl_update_connection_status - Updates the connection check status.
+ * @ndev:	common device
+ * @status:	new status
+ *
+ * RETURNS: 0 if stopped or other value if error.
+ */
+
+static int fsl_update_connection_status(struct nfp_dev *ndev, int status)
+{
+	int current_status;
+
+	if (!ndev)
+		return -ENODEV;
+
+	current_status = ndev->conn_status;
+	ndev->conn_status = status;
+	return current_status;
+}
+
+/**
+ * fsl_check_complete - Completes a connection check status interrupt.
+ * @ndev:	common device
+ * @status:	device status
+ */
+static void fsl_check_complete(struct nfp_dev *ndev, int status)
+{
+	int ne;
+	int started;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check device status */
+	ne = fsl_created(ndev);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: check not completed", __func__);
+		return;
+	}
+
+	/*
+	 * started becomes true after fsl_create and the first cs interrupt is
+	 * successful.
+	 * It switches to false right after since cs_status is set to
+	 * 0 right after this check
+	 * A fsl_close or a fsl_create can
+	 * reset the cs_status to NFP_HSM_STARTING again.
+	 */
+	started =
+		(fsl_update_connection_status(ndev, status) ==
+		 NFP_HSM_STARTING) && (status == 0);
+
+	/* reset read/write doorbell registers if just started */
+
+	if (started) {
+		dev_notice(&ndev->pcidev->dev,
+			   "fsl_create: clearing read/write doorbell registers");
+		fsl_outl(ndev, FSL_OFFSET_DOORBELL_WR_CMD, NFAST_INT_HOST_CLR);
+		fsl_inl(ndev, FSL_OFFSET_DOORBELL_WR_CMD);
+		fsl_outl(ndev, FSL_OFFSET_DOORBELL_RD_CMD, NFAST_INT_HOST_CLR);
+		fsl_inl(ndev, FSL_OFFSET_DOORBELL_RD_CMD);
+		fsl_outl(ndev,
+			 FSL_OFFSET_DOORBELL_WR_STATUS, NFAST_INT_DEVICE_CLR);
+		fsl_inl(ndev, FSL_OFFSET_DOORBELL_WR_STATUS);
+		fsl_outl(ndev,
+			 FSL_OFFSET_DOORBELL_RD_STATUS, NFAST_INT_DEVICE_CLR);
+		fsl_inl(ndev, FSL_OFFSET_DOORBELL_RD_STATUS);
+	}
+
+	if (status == 0) {
+		dev_notice(&ndev->pcidev->dev, "%s: device started", __func__);
+	} else if (status == NFP_HSM_STARTING) {
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: device not started yet", __func__);
+	} else {
+		dev_err(&ndev->pcidev->dev,
+			"%s: device check failed with code: 0x%x",
+			__func__, status);
+	}
+}
+
+/**
+ * fsl_isr - Handles an interrupt from the FSL device.
+ * @ctx:	device context (always the device itself)
+ * @handled:	set non-zero by this routine if interrupt considered handled
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int fsl_isr(struct nfp_dev *ctx, int *handled)
+{
+	struct nfp_dev *ndev = ctx;
+	int ne;
+	u32 doorbell_rd, doorbell_wr, doorbell_cs;
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* mark not yet handled */
+	*handled = 0;
+
+	ne = fsl_created(ndev);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: interrupt not handled", __func__);
+		return ne;
+	}
+
+	++ndev->stats.isr;
+
+	doorbell_wr = fsl_inl(ndev, FSL_OFFSET_DOORBELL_WR_STATUS);
+	doorbell_rd = fsl_inl(ndev, FSL_OFFSET_DOORBELL_RD_STATUS);
+	doorbell_cs = fsl_inl(ndev, FSL_OFFSET_DOORBELL_CS_STATUS);
+	dev_notice(&ndev->pcidev->dev, "%s: cs:= %x,rd:=%x,wr:=%x",
+		   __func__, doorbell_cs, doorbell_rd, doorbell_wr);
+
+	while (doorbell_rd || doorbell_wr || doorbell_cs) {
+		/*
+		 * prevent any illegal combination of set bits from triggering
+		 * processing. Note that if anyone of these registers have an
+		 * incorrect bit set, it would prevent the other operations from
+		 * being processed since we return from the ISR, even if they
+		 * have legal values. This is an unlikely scenario since these
+		 * registers are written either to 0 or one of the legal values
+		 * by the software on the card.
+		 */
+		if ((doorbell_cs) &&
+		    ((doorbell_cs & ~NFAST_INT_DEVICE_CHECK_OK) &&
+		     (doorbell_cs & ~NFAST_INT_DEVICE_CHECK_FAILED))) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: illegal bits in doorbell_cs %x",
+				__func__, doorbell_cs);
+			*handled = 1;
+			/* clear the register*/
+			fsl_outl(ndev, FSL_OFFSET_DOORBELL_CS_STATUS,
+				 NFAST_INT_DEVICE_CLR);
+			return 0;
+		}
+		if ((doorbell_rd) &&
+		    ((doorbell_rd & ~NFAST_INT_DEVICE_READ_OK) &&
+		     (doorbell_rd & ~NFAST_INT_DEVICE_READ_FAILED))) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: illegal bits in doorbell_rd %x",
+				__func__, doorbell_rd);
+			*handled = 1;
+			/* clear the register*/
+			fsl_outl(ndev, FSL_OFFSET_DOORBELL_RD_STATUS,
+				 NFAST_INT_DEVICE_CLR);
+			return 0;
+		}
+		if ((doorbell_wr) &&
+		    ((doorbell_wr & ~NFAST_INT_DEVICE_WRITE_OK) &&
+		     (doorbell_wr & ~NFAST_INT_DEVICE_WRITE_FAILED))) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: illegal bits in doorbell_wr %x",
+				__func__, doorbell_wr);
+			/* clear the register*/
+			fsl_outl(ndev, FSL_OFFSET_DOORBELL_WR_STATUS,
+				 NFAST_INT_DEVICE_CLR);
+			*handled = 1;
+			return 0;
+		}
+
+		/*
+		 * service interrupts.
+		 * if we made it here, the doorbell registers are all valid,
+		 * so no need to check for their validity anymore.
+		 */
+
+		if (doorbell_wr) {
+			fsl_outl(ndev, FSL_OFFSET_DOORBELL_WR_STATUS,
+				 NFAST_INT_DEVICE_CLR);
+			ndev->stats.isr_write++;
+			nfp_write_complete(ndev,
+					   doorbell_wr &
+					     NFAST_INT_DEVICE_WRITE_OK ?
+						1 : 0);
+			dev_notice(&ndev->pcidev->dev,
+				   "%s: acknowledging write interrupt: ok = %d",
+				__func__,
+				doorbell_wr & NFAST_INT_DEVICE_WRITE_OK
+				? 1 : 0);
+		}
+
+		if (doorbell_rd) {
+			fsl_outl(ndev, FSL_OFFSET_DOORBELL_RD_STATUS,
+				 NFAST_INT_DEVICE_CLR);
+			ndev->stats.isr_read++;
+			nfp_read_complete(ndev,
+					  doorbell_rd &
+					    NFAST_INT_DEVICE_READ_OK ? 1 : 0);
+			dev_notice(&ndev->pcidev->dev,
+				   "%s: acknowledging read interrupt: ok = %d",
+				__func__,
+				doorbell_rd & NFAST_INT_DEVICE_READ_OK ? 1 : 0);
+		}
+		/*
+		 * the doorbell_cs is being phased out in favor of polling since
+		 * there were issues caused by this interrupt being issued from
+		 * the card on its own when the driver was not even present.
+		 * To maintain backwards compatibility, this code is being kept,
+		 * but might be removed in the future.
+		 */
+		dev_notice(&ndev->pcidev->dev, "%s: doorbell_cs is: %x",
+			   __func__, doorbell_cs);
+		if (doorbell_cs) {
+			fsl_outl(ndev, FSL_OFFSET_DOORBELL_CS_STATUS,
+				 NFAST_INT_DEVICE_CLR);
+			fsl_check_complete(ndev,
+					   doorbell_cs &
+						NFAST_INT_DEVICE_CHECK_OK ?
+						0 :
+						NFP_HSM_STARTING);
+			dev_notice(&ndev->pcidev->dev,
+				   "%s: acknowledging check interrupt: status:0x%x",
+				   __func__,
+				   doorbell_cs & NFAST_INT_DEVICE_CHECK_OK ?
+					0 :
+					NFP_HSM_STARTING);
+		}
+
+		doorbell_wr = fsl_inl(ndev, FSL_OFFSET_DOORBELL_WR_STATUS);
+		doorbell_rd = fsl_inl(ndev, FSL_OFFSET_DOORBELL_RD_STATUS);
+		doorbell_cs = fsl_inl(ndev, FSL_OFFSET_DOORBELL_CS_STATUS);
+
+		dev_notice(&ndev->pcidev->dev, "%s: cs status in isr is: %x",
+			   __func__, doorbell_cs);
+	}
+
+	/* always report the interrupt as handled */
+	*handled = 1;
+
+	dev_notice(&ndev->pcidev->dev, "%s: exiting", __func__);
+
+	return 0;
+}
+
+/**
+ * fsl_open - Performs additional FSL-specific actions when opening a device.
+ * @ctx:	device context (always the device itself)
+ *
+ * This routine returns an error if the device has not properly started.
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int fsl_open(struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	int ne;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check device status */
+	ne = fsl_started(ndev);
+	if (ne != 0) {
+		ndev->stats.ensure_fail++;
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: device not started", __func__);
+		return ne;
+	}
+
+	return 0;
+}
+
+/**
+ * fsl_close - Performs additional FSL-specific actions when closing a device.
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int fsl_close(struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	return 0;
+}
+
+/**
+ * fsl_set_control - Sets control data.
+ * @control:	control string to copy from
+ * @ctx:	device context (always the device itself)
+ *
+ * The device control register is writen directly. No doorbell style handshake
+ * is used.
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int fsl_set_control(const struct nfdev_control_str *control,
+			   struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	int ne;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check device status */
+	ne = fsl_started(ndev);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: unable to set control", __func__);
+		return ne;
+	}
+
+	/*
+	 * set control (written immediately with no explicit
+	 * synchronization with the firmware)
+	 */
+
+	fsl_outl(ndev, FSL_OFFSET_REGISTER_CONTROL, control->control);
+
+	return 0;
+}
+
+/**
+ * fsl_get_status - Returns status data.
+ * @status:	string to copy into
+ * @ctx:	device context (always the device itself)
+ *
+ * The device status registers are read immediately. No doorbell style
+ * handshake is used. Without explicit synchronization, it is possible
+ * that an inconsistent state may be returned if the status is being
+ * updated by the firmware while simultaneously being read by the host.
+ * For example, the call could return an updated status word with a not
+ * as yet updated error string. This is likely a degenerate case.
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int fsl_get_status(struct nfdev_status_str *status, struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	int ne;
+	u32 *error = (uint32_t *)status->error;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check device status */
+	ne = fsl_started(ndev);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: unable to get status", __func__);
+		return ne;
+	}
+
+	/*
+	 * get status (read immediately with no explicit synchronization
+	 * with the firmware)
+	 */
+	status->status = fsl_inl(ndev, FSL_OFFSET_REGISTER_STATUS);
+	error[0] = fsl_inl(ndev, FSL_OFFSET_REGISTER_ERROR_LO);
+	error[1] = fsl_inl(ndev, FSL_OFFSET_REGISTER_ERROR_HI);
+
+	return 0;
+}
+
+/**
+ * fsl_ensure_reading - Initiates a device read request.
+ * @addr:	32-bit bus address used by DMA to push reply from device
+ * @len:	maximum length data to return
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if read initiated, NFP_HSM_STARTING if device not ready,
+ * or other value if error.
+ */
+static int fsl_ensure_reading(dma_addr_t addr, int len, struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	__le32 hdr[3];
+	__le32 tmp32;
+	int ne;
+	int hdr_len;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check device status */
+	ne = fsl_started(ndev);
+	if (ne != 0) {
+		ndev->stats.ensure_fail++;
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: unable to initiate read", __func__);
+		return ne;
+	}
+
+	dev_notice(&ndev->pcidev->dev, "%s: ndev->bar[ndev->active_bar]= %p",
+		   __func__, (void *)ndev->bar[ndev->active_bar]);
+
+	/* send read request */
+
+	if (addr) {
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: requesting DMA reply to bus address %p",
+			   __func__, (void *)addr);
+		hdr[0] = cpu_to_le32(NFPCI_JOB_CONTROL_PCI_PUSH);
+		hdr[1] = cpu_to_le32(len);
+		hdr[2] = cpu_to_le32(addr);
+		hdr_len = 3 * sizeof(hdr[0]);
+	} else {
+		hdr[0] = cpu_to_le32(NFPCI_JOB_CONTROL);
+		hdr[1] = cpu_to_le32(len);
+		hdr_len = 2 * sizeof(hdr[0]);
+	}
+	memcpy(ndev->bar[ndev->active_bar] + NFPCI_JOBS_RD_CONTROL,
+	       (char const *)hdr, hdr_len);
+
+	/* confirm read request */
+
+	memcpy((char *)hdr,
+	       ndev->bar[ndev->active_bar] + NFPCI_JOBS_RD_LENGTH,
+	       sizeof(hdr[0]));
+	tmp32 = cpu_to_le32(len);
+	if (hdr[0] != tmp32) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: expected length not written (%08x != %08x)",
+			__func__, hdr[0], tmp32);
+		ndev->stats.ensure_fail++;
+		return -EIO;
+	}
+
+	/* trigger read request */
+
+	fsl_outl(ndev, FSL_OFFSET_DOORBELL_RD_CMD, NFAST_INT_HOST_READ_REQUEST);
+
+	ndev->stats.ensure++;
+
+	dev_notice(&ndev->pcidev->dev,
+		   "%s: requesting max %d bytes", __func__, len);
+
+	return 0;
+}
+
+/**
+ * fsl_read - Reads a device read reply.
+ * @block:	data buffer to copy into
+ * @len:	maximum length of data to copy
+ * @ctx:	device context (always the device itself)
+ * @rcnt:	returned actual # of bytes copied
+ *
+ * RETURNS: 0 if read initiated, NFP_HSM_STARTING if device not ready,
+ * or other value if error.
+ */
+static int fsl_read(char *block, int len, struct nfp_dev *ctx, int *rcnt)
+{
+	struct nfp_dev *ndev = ctx;
+	int ne;
+	int cnt;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	*rcnt = 0;
+
+	/* check device status */
+	ne = fsl_started(ndev);
+	if (ne != 0) {
+		ndev->stats.read_fail++;
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: unable to complete read", __func__);
+		return ne;
+	}
+
+	/* receive reply length */
+
+	memcpy((char *)&cnt,
+	       ndev->bar[ndev->active_bar] + NFPCI_JOBS_RD_LENGTH,
+	       sizeof(cnt));
+	cnt = le32_to_cpu(cnt);
+	dev_notice(&ndev->pcidev->dev, "%s: cnt=%u.", __func__, cnt);
+	if (cnt < 0 || cnt > len) {
+		ndev->stats.read_fail++;
+		dev_err(&ndev->pcidev->dev, "%s: error: bad byte count (%d) from device",
+			__func__, cnt);
+		return -EIO;
+	}
+
+	/* receive data */
+
+	ne = copy_to_user(block, ndev->bar[ndev->active_bar] +
+			  NFPCI_JOBS_RD_DATA, cnt) ? -EFAULT : 0;
+	if (ne != 0) {
+		ndev->stats.read_fail++;
+		dev_err(&ndev->pcidev->dev, "%s: error: copy_to_user failed",
+			__func__);
+		return ne;
+	}
+
+	*rcnt = cnt;
+	ndev->stats.read_block++;
+	ndev->stats.read_byte += cnt;
+	dev_warn(&ndev->pcidev->dev, "%s: read %d bytes (std)", __func__, cnt);
+
+	return 0;
+}
+
+/**
+ * fsl_write - Initiates a device write request.
+ * @addr:	32-bit bus address used by DMA to pull request to device
+ * @block:	data buffer to copy from
+ * @len:	length of data to copy
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if write successful, NFP_HSM_STARTING if device not
+ * ready, or other value if error.
+ */
+static int fsl_write(u32 addr, char const *block, int len, struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	__le32 hdr[3];
+	int ne;
+	__le32 tmp32;
+	int hdr_len;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check device status */
+	ne = fsl_started(ndev);
+	if (ne != 0) {
+		ndev->stats.write_fail++;
+		dev_err(&ndev->pcidev->dev,
+			"%s: error: unable to initiate write", __func__);
+		return ne;
+	}
+
+	if (addr == 0) {
+		/* std write */
+
+		dev_notice(&ndev->pcidev->dev, "%s: ndev->bar[ndev->active_bar]= %p",
+			   __func__, (void *)ndev->bar[ndev->active_bar]);
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: block len %d", __func__, len);
+
+		/* send write request */
+
+		ne = copy_from_user(ndev->bar[ndev->active_bar] +
+				    NFPCI_JOBS_WR_DATA, block, len)
+				    ? -EFAULT : 0;
+		if (ne != 0) {
+			ndev->stats.write_fail++;
+			dev_err(&ndev->pcidev->dev,
+				"%s: error: copy_from_user failed", __func__);
+			return ne;
+		}
+
+		hdr[0] = cpu_to_le32(NFPCI_JOB_CONTROL);
+		hdr[1] = cpu_to_le32(len);
+		hdr_len = 2 * sizeof(hdr[0]);
+		memcpy(ndev->bar[ndev->active_bar] + NFPCI_JOBS_WR_CONTROL,
+		       (char const *)hdr, hdr_len);
+
+		/* confirm write request */
+
+		memcpy((char *)hdr,
+		       ndev->bar[ndev->active_bar] + NFPCI_JOBS_WR_LENGTH,
+		       sizeof(hdr[0]));
+		tmp32 = cpu_to_le32(len);
+		if (hdr[0] != tmp32) {
+			ndev->stats.write_fail++;
+			dev_err(&ndev->pcidev->dev, "%s: length not written (%08x != %08x)",
+				__func__, hdr[0], tmp32);
+			return -EIO;
+		}
+	} else {
+		/* dma write */
+
+		dev_notice(&ndev->pcidev->dev, "%s: ndev->bar[ndev->active_bar]= %p",
+			   __func__, (void *)ndev->bar[ndev->active_bar]);
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: block len %d", __func__, len);
+		dev_notice(&ndev->pcidev->dev, "%s: pull from 0x%016x using DMA",
+			   __func__, addr);
+
+		/* submit write request */
+
+		hdr[0] = cpu_to_le32(NFPCI_JOB_CONTROL_PCI_PULL);
+		hdr[1] = cpu_to_le32(len);
+		hdr[2] = cpu_to_le32(addr);
+		hdr_len = 3 * sizeof(hdr[0]);
+		memcpy(ndev->bar[ndev->active_bar] + NFPCI_JOBS_WR_CONTROL,
+		       (char const *)hdr, hdr_len);
+
+		/* confirm write request */
+
+		memcpy((char *)hdr,
+		       ndev->bar[ndev->active_bar] + NFPCI_JOBS_WR_LENGTH,
+		       sizeof(hdr[0]));
+		tmp32 = cpu_to_le32(len);
+		if (hdr[0] != tmp32) {
+			ndev->stats.write_fail++;
+			dev_err(&ndev->pcidev->dev,
+				"%s: length not written (%08x != %08x)",
+				__func__, tmp32, hdr[0]);
+			return -EIO;
+		}
+	}
+
+	/* trigger write */
+
+	fsl_outl(ndev,
+		 FSL_OFFSET_DOORBELL_WR_CMD, NFAST_INT_HOST_WRITE_REQUEST);
+
+	ndev->stats.write_block++;
+	ndev->stats.write_byte += len;
+
+	dev_notice(&ndev->pcidev->dev, "%s: done", __func__);
+	return 0;
+}
+
+/* FSL Sawshark T1022 device configuration. */
+const struct nfpcmd_dev fsl_t1022_cmddev = { "nCipher nShield Solo XC",
+				      PCI_VENDOR_ID_FREESCALE,
+				      PCI_DEVICE_ID_FREESCALE_T1022,
+				      PCI_VENDOR_ID_NCIPHER,
+				      PCI_SUBSYSTEM_ID_NFAST_REV1,
+				      { 0, FSL_MEMSIZE, 0, 0, 0, 0 },
+				      NFP_CMD_FLG_NEED_MSI,
+				      NFDEV_IF_PCI_PULL,
+				      fsl_create,
+				      fsl_destroy,
+				      fsl_open,
+				      fsl_close,
+				      fsl_isr,
+				      fsl_write,
+				      fsl_read,
+				      fsl_ensure_reading,
+				      fsl_set_control,
+				      fsl_get_status };
+/* end of file */
diff --git a/drivers/misc/ncipher/fsl.h b/drivers/misc/ncipher/fsl.h
new file mode 100644
index 000000000000..417dee3c9f93
--- /dev/null
+++ b/drivers/misc/ncipher/fsl.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *
+ * Interface to the Solo XC's T1022 communication processor
+ * Copyright 2019 nCipher Security Ltd
+ *
+ */
+
+#ifndef NFP_FSL_H
+#define NFP_FSL_H
+
+#include <linux/io.h>
+#include "solo.h"
+
+/* Always use a lock when 'we' call fsl_started */
+#define NFP_WITH_LOCK 1
+
+/* PCI FSL definitions */
+
+#ifndef PCI_VENDOR_ID_FREESCALE
+#define PCI_VENDOR_ID_FREESCALE 0x1957
+#endif
+
+#ifndef PCI_DEVICE_ID_FREESCALE_T1022
+#define PCI_DEVICE_ID_FREESCALE_T1022 0x082c
+#endif
+
+#ifndef PCI_VENDOR_ID_NCIPHER
+#define PCI_VENDOR_ID_NCIPHER 0x0100
+#endif
+
+#ifndef PCI_SUBSYSTEM_ID_NFAST_REV1
+#define PCI_SUBSYSTEM_ID_NFAST_REV1 0x0100
+#endif
+
+#define FSL_CFG_SEC_CMD_STATUS 0x4C
+#define FSL_CFG_CMD_MASTER 0x10
+
+#define FSL_MEMBAR 1
+
+/* NFAST extended PCI register definitions */
+
+#define NFPCI_OFFSET_JOBS_DS 0x00020000
+
+/* Interrupts from device to host */
+
+#define NFAST_INT_DEVICE_CLR 0x00000000
+#define NFAST_INT_DEVICE_CHECK_OK 0x00000100
+#define NFAST_INT_DEVICE_CHECK_FAILED 0x00000200
+#define NFAST_INT_DEVICE_POLL 0x00000300
+#define NFAST_INT_DEVICE_PCI_DOWN 0x00000400
+
+/* Interrupts from host to device */
+
+#define NFAST_INT_HOST_CLR 0x00000000
+
+/* PCI FSL register definitions */
+
+#define FSL_LENGTH NFPCI_RAM_MINSIZE_JOBS
+#define FSL_MEMSIZE NFPCI_RAM_MINSIZE_KERN
+
+#define FSL_DOORBELL_LOCATION (FSL_MEMSIZE - 0x100)
+
+#define FSL_OFFSET_DOORBELL_RD_CMD 0x00u
+#define FSL_OFFSET_DOORBELL_WR_CMD 0x04u
+#define FSL_OFFSET_DOORBELL_RD_STATUS 0x08u
+#define FSL_OFFSET_DOORBELL_WR_STATUS 0x0Cu
+#define FSL_OFFSET_DOORBELL_CS_STATUS 0x10u
+
+#define FSL_OFFSET_REGISTER_CONTROL 0x20u
+#define FSL_OFFSET_REGISTER_STATUS 0x24u
+#define FSL_OFFSET_REGISTER_ERROR_LO 0x28u
+#define FSL_OFFSET_REGISTER_ERROR_HI 0x2Cu
+#define FSL_OFFSET_DOORBELL_POLLING 0x30u
+
+#define FSL_MAGIC 0x12345678u
+
+/* Monitor firmware supports MOI control and error reporting */
+#define NFDEV_STATUS_MONITOR_MOI 0x0001
+
+/* Application firmware supports MOI control and error reporting */
+#define NFDEV_STATUS_APPLICATION_MOI 0x0002
+
+/* Application firmware running and supports error reporting */
+#define NFDEV_STATUS_APPLICATION_RUNNING 0x0004
+
+/**
+ * fsl_outl - Writes a 32 bit word across PCI to the FSL card.
+ * @ndev:	command device
+ * @bar:	base address region id
+ * @offset:	offset in bytes from base address
+ * @value:	32 bit value being written
+ */
+static inline void fsl_outl(struct nfp_dev *ndev, int offset, u32 value)
+{
+	iowrite32(cpu_to_le32(value), ndev->bar[ndev->active_bar] +
+		  FSL_DOORBELL_LOCATION + offset);
+}
+
+/**
+ * fsl_inl - Reads a 32 bit word across PCI from the FSL card.
+ * @ndev:	command device
+ * @bar:	base address region id
+ * @offset:	offset in bytes from base address
+ *
+ * RETURNS: 32 bit value.
+ */
+static inline uint32_t fsl_inl(struct nfp_dev *ndev, int offset)
+{
+	return le32_to_cpu(ioread32(ndev->bar[ndev->active_bar]
+			   + FSL_DOORBELL_LOCATION + offset));
+}
+
+#endif /* NFP_FSL_H */
+
+/* end of file */
diff --git a/drivers/misc/ncipher/hostif.c b/drivers/misc/ncipher/hostif.c
new file mode 100644
index 000000000000..128d9c4a3359
--- /dev/null
+++ b/drivers/misc/ncipher/hostif.c
@@ -0,0 +1,1522 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * hostif.c: nCipher PCI HSM linux host interface
+ * Copyright 2019 nCipher Security Ltd
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/bitops.h>
+
+#include "solo.h"
+#include "i21555.h"
+#include "fsl.h"
+
+/* limits & sizes */
+#define NFP_READ_MAX (8 * 1024)
+#define NFP_WRITE_MAX (8 * 1024)
+#define NFP_READBUF_SIZE (NFP_READ_MAX + 8)
+#define NFP_WRITEBUF_SIZE (NFP_WRITE_MAX + 8)
+#define NFP_MAXDEV 16
+
+/* other operating constants */
+#define NFP_TIMEOUT_SEC 20
+#define NFP_DMA_NBYTES_OFFSET (4)
+#define NFP_DMA_ADDRESS_OFFSET (8)
+#define NFP_DRVNAME "nCipher nFast PCI driver"
+#define NFP_TIMEOUT ((NFP_TIMEOUT_SEC) * HZ)
+
+/* Interpretation of the bits of struct nfp_dev.rd_outstanding */
+#define WAIT_BIT  0 /* waiting for data */
+#define CMPLT_BIT 1 /* completing a read (got data or timing out) */
+
+/*
+ * Used to determine which installed module we're looking at
+ * from its minor device number
+ */
+#define INODE_FROM_FILE(file) ((file)->f_path.dentry->d_inode)
+
+/*
+ * Major device type
+ * "nCipher nFast PCI crypto accelerator" in
+ * https://www.kernel.org/doc/html/v4.11/admin-guide/devices.html
+ */
+#define NFP_MAJOR 176
+
+/* device list */
+
+static struct nfp_dev *nfp_dev_list[NFP_MAXDEV];
+static int nfp_num_devices;
+static struct class *nfp_class;
+
+/**
+ * Module structures.
+ */
+
+/**
+ * NSHIELD_SOLO module interface version parameter.
+ *
+ * This value can be overridden when the module is loaded, for example:
+ *
+ *   insmod nshield_solo.ko nfp_ifvers=<n>
+ *
+ * where n = 0 allows any supported interface,
+ *       n > 0 allows only interface versions <= n.
+ * See nfdev-common.h for a list of supported interface versions.
+ * Specific card models may not support all interface versions.
+ */
+static int nfp_ifvers;
+
+MODULE_AUTHOR("nCipher");
+MODULE_DESCRIPTION("nCipher PCI HSM driver");
+module_param(nfp_ifvers, int, 0444);
+MODULE_PARM_DESC(nfp_ifvers, "maximum interface version (1-2), or any (0)");
+MODULE_LICENSE("GPL");
+
+/**
+ * NSHIELD_SOLO character device file operations.
+ */
+
+/**
+ * nfp_poll - Polls an NSHIELD SOLO device.
+ * @filep:	device file pointer
+ * @wait:	poll table pointer
+ *
+ * The kernel calls this function when a user tries to poll an NSHIELD SOLO
+ * device. The function returns a bit mask which indicates if the device is
+ * immediately readable or writable.  A readable device will set
+ * (POLLIN | POLLRDNORM). A writable device will set (POLLOUT | POLLWRNORM).
+ *
+ * RETURNS: mask indicating if readable and/or writable.
+ */
+static u32 nfp_poll(struct file *file, poll_table *wait)
+{
+	struct nfp_dev *ndev;
+	u32 mask = 0;
+	int minor = MINOR(INODE_FROM_FILE(file)->i_rdev);
+
+	if (minor >= NFP_MAXDEV) {
+		pr_err("%s: minor out of range.", __func__);
+		return -ENODEV;
+	}
+
+	ndev = nfp_dev_list[minor];
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* find ndev from minor */
+
+	poll_wait(file, &ndev->wr_queue, wait);
+	poll_wait(file, &ndev->rd_queue, wait);
+
+	if (test_bit(0, &ndev->wr_ready))
+		mask |= POLLOUT | POLLWRNORM; /* writeable */
+	if (test_bit(0, &ndev->rd_ready))
+		mask |= POLLIN | POLLRDNORM; /* readable */
+
+	dev_notice(&ndev->pcidev->dev, "%s: device is %swritable, %sreadable",
+		   __func__,
+		mask & POLLOUT ? "" : "not ", mask & POLLIN ? "" : "not ");
+
+	return mask;
+}
+
+void nfp_write_complete(struct nfp_dev *ndev, int ok)
+{
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/*
+	 * could be executed simultaneously by more than one thread -
+	 * e.g. from the write isr and from the nfp_write/timeout
+	 * we don't want that to happen.
+	 */
+	if (test_and_set_bit(CMPLT_BIT, &ndev->wr_outstanding))
+		return;
+
+	if (!test_bit(WAIT_BIT, &ndev->wr_outstanding)) {
+		/*
+		 * we can only get here if the write has already
+		 * been completed
+		 */
+		dev_err(&ndev->pcidev->dev,
+			"%s: no write outstanding to complete; ignoring completion",
+			__func__);
+		clear_bit(CMPLT_BIT, &ndev->wr_outstanding);
+		return;
+	}
+
+	/* complete write by waking waiting processes */
+	ndev->wr_ok = ok;
+
+	dev_notice(&ndev->pcidev->dev, "%s: write completed %sokay",
+		   __func__, ok ? "" : "not ");
+
+	/* make sure that write is complete before we clear wr_outstanding */
+	smp_mb__before_atomic();
+	clear_bit(CMPLT_BIT, &ndev->wr_outstanding);
+	clear_bit(WAIT_BIT, &ndev->wr_outstanding);
+
+	/* wake up anyone waiting */
+
+	wake_up_all(&ndev->wr_queue);
+}
+
+#define CREATE_TRACE_POINTS
+
+/**
+ * nfp_write - Writes to an NSHIELD SOLO device.
+ * @file:	device file pointer
+ * @buf:	pointer to a user space buffer
+ * @count:	size of user space buffer
+ * @off:	offset position (ignored)
+ *
+ * Data in the user space buffer is written to the NSHIELD SOLO device. Any
+ * previous data is overwritten. An error is returned if not all
+ * bytes are written from the user space buffer.
+ *
+ * RETURNS: actual number of bytes written or a negative value if an error
+ * occurred.
+ */
+static ssize_t nfp_write(struct file *file, char const __user *buf,
+			 size_t count, loff_t *off)
+{
+	struct nfp_dev *ndev;
+	u32 addr;
+	int nbytes;
+	int minor;
+	int ne;
+
+	/* find ndev from minor */
+	minor = MINOR(INODE_FROM_FILE(file)->i_rdev);
+	if (minor >= NFP_MAXDEV) {
+		pr_err("%s: minor out of range.", __func__);
+		return -ENODEV;
+	}
+
+	ndev = nfp_dev_list[minor];
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check max length requested */
+	if (count <= 0 || NFP_WRITE_MAX < count) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: invalid requested write length %lu",
+			__func__, count);
+		return -EINVAL;
+	}
+
+	/* check if called before ready */
+	if (!test_and_clear_bit(0, &ndev->wr_ready)) {
+		dev_err(&ndev->pcidev->dev, "%s: write called when not ready.",
+			__func__);
+		return -ENXIO;
+	}
+	set_bit(WAIT_BIT, &ndev->wr_outstanding);
+
+	dev_notice(&ndev->pcidev->dev, "%s: writing %ld bytes",
+		   __func__, count);
+
+	addr = 0;
+	if (ndev->ifvers >= NFDEV_IF_PCI_PULL) {
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: copying %lu bytes to dma buffer",
+			   __func__, count);
+		addr = ndev->write_dma;
+		nbytes = cpu_to_le32(count);
+		*(u32 *)(ndev->write_buf + NFP_DMA_NBYTES_OFFSET) = nbytes;
+		if (0 !=
+		    copy_from_user(ndev->write_buf + NFP_DMA_ADDRESS_OFFSET,
+				   buf, count)) {
+			clear_bit(WAIT_BIT, &ndev->wr_outstanding);
+			set_bit(0, &ndev->wr_ready);
+			dev_err(&ndev->pcidev->dev,
+				"%s: copy from user space failed", __func__);
+			return -EIO;
+		}
+	}
+
+	ne = ndev->cmddev->write_block(addr, buf, count, ndev->cmdctx);
+	if (ne != 0) {
+		nfp_write_complete(ndev, 0);
+		if (ne != -EAGAIN)
+			dev_err(&ndev->pcidev->dev,
+				"%s: write_block failed", __func__);
+	}
+
+	while (test_bit(WAIT_BIT, &ndev->wr_outstanding)) {
+		if (!wait_event_timeout(ndev->wr_queue,
+					test_bit(WAIT_BIT,
+						 &ndev->wr_outstanding) == 0,
+					NFP_TIMEOUT)) {
+			nfp_write_complete(ndev, 0);
+			set_bit(0, &ndev->wr_ready);
+			dev_err(&ndev->pcidev->dev,
+				"%s: module timed out", __func__);
+			return -ENXIO;
+		}
+		if (test_bit(WAIT_BIT, &ndev->wr_outstanding)) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: handling spurious wake-up", __func__);
+		}
+	}
+	set_bit(0, &ndev->wr_ready);
+
+	dev_warn(&ndev->pcidev->dev, "%s: returning %ld.", __func__,
+		 ndev->wr_ok ? count : -EIO);
+
+	if (!ndev->wr_ok) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: device write failed", __func__);
+		return -EIO;
+	}
+
+	dev_warn(&ndev->pcidev->dev,
+		 "%s: wrote %ld bytes (%s)", __func__, count,
+		 ndev->ifvers >= NFDEV_IF_PCI_PULL ? "dma" : "std");
+	return count;
+}
+
+void nfp_read_complete(struct nfp_dev *ndev, int ok)
+{
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/*
+	 * could be executed simultaneously by more than one thread -
+	 * e.g. from the read isr and from the timeout
+	 * we don't want that to happen.
+	 */
+	if (test_and_set_bit(CMPLT_BIT, &ndev->rd_outstanding))
+		return;
+
+	if (!test_bit(WAIT_BIT, &ndev->rd_outstanding)) {
+		/*
+		 * we can only get here if the read has already been completed
+		 * and no new ENSUREREADING request has been received since
+		 */
+		dev_err(&ndev->pcidev->dev,
+			"%s: no read outstanding to complete; ignoring completion",
+			__func__);
+		clear_bit(CMPLT_BIT, &ndev->rd_outstanding);
+		return;
+	}
+
+	/* in case the timer has not expired */
+	del_timer(&ndev->rd_timer);
+
+	ndev->rd_ok = ok;
+	set_bit(0, &ndev->rd_ready);
+
+	dev_notice(&ndev->pcidev->dev, "%s: read completed %sokay",
+		   __func__, ok ? "" : "not ");
+
+	/* make sure that rd_ready is set before we clear rd_outstanding */
+	smp_mb__before_atomic();
+	clear_bit(CMPLT_BIT, &ndev->rd_outstanding);
+	clear_bit(WAIT_BIT, &ndev->rd_outstanding);
+
+	/* wake up anyone waiting */
+
+	wake_up_all(&ndev->rd_queue);
+}
+
+static void nfp_read_timeout(struct timer_list *t)
+{
+	struct nfp_dev *ndev = from_timer(ndev, t, rd_timer);
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	nfp_read_complete(ndev, 0);
+}
+
+/**
+ * nfp_read - Reads from an NSHIELD SOLO device.
+ * @file:	device file pointer
+ * @buf:	pointer to a user space buffer
+ * @count:	maximum size of user space buffer
+ * @off:	offset position (ignored)
+ *
+ * Data is read from the NSHIELD SOLO device into the user space buffer.
+ * The read removes the data from the device. An error is returned is not
+ * all the bytes are read from the user space buffer.
+ *
+ * RETURNS: actual number of bytes read or a negative value if an error
+ * occurred.
+ */
+static ssize_t nfp_read(struct file *file, char __user *buf, size_t count,
+			loff_t *off)
+{
+	struct nfp_dev *ndev;
+	int nbytes;
+	int minor;
+	int ne;
+
+	minor = MINOR(INODE_FROM_FILE(file)->i_rdev);
+	if (minor >= NFP_MAXDEV) {
+		pr_err("%s: minor out of range.", __func__);
+		return -ENODEV;
+	}
+
+	ndev = nfp_dev_list[minor];
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* check user space buffer */
+	if (!access_ok(buf, count)) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: user space verify failed.", __func__);
+		return -EFAULT;
+	}
+
+	/* check max length requested */
+
+	if (count <= 0 || NFP_READ_MAX < count) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: invalid requested max read length %lu",
+			__func__, count);
+		return -EINVAL;
+	}
+
+	if (!test_and_clear_bit(0, &ndev->rd_ready)) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: read called when not ready.", __func__);
+		return -EIO;
+	}
+	nbytes = 0;
+
+	/* check if read was ok */
+
+	if (!ndev->rd_ok) {
+		dev_err(&ndev->pcidev->dev, "%s: read failed", __func__);
+		return -EIO;
+	}
+
+	/* finish read */
+
+	if (ndev->ifvers >= NFDEV_IF_PCI_PUSH) {
+		nbytes = *(u32 *)(ndev->read_buf + NFP_DMA_NBYTES_OFFSET);
+		nbytes = le32_to_cpu(nbytes);
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: nbytes %d", __func__, nbytes);
+		if (nbytes < 0 || nbytes > count) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: bad byte count (%d) from device",
+				__func__, nbytes);
+			return -EIO;
+		}
+		if (copy_to_user(buf, ndev->read_buf + NFP_DMA_ADDRESS_OFFSET,
+				 nbytes) != 0) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: copy to user space failed", __func__);
+			return -EIO;
+		}
+	} else {
+		nbytes = 0;
+		ne = ndev->cmddev->read_block(buf, count, ndev->cmdctx,
+					      (void *)&nbytes);
+		if (ne != 0) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: device read failed", __func__);
+			return ne;
+		}
+	}
+
+	if (nbytes > NFP_READ_MAX) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: read reply overflow: %d > %d max",
+			__func__, nbytes, NFP_READ_MAX);
+		return -EIO;
+	}
+
+	dev_warn(&ndev->pcidev->dev, "%s: read %d bytes (%s)", __func__, nbytes,
+		 ndev->ifvers >= NFDEV_IF_PCI_PUSH ? "dma" : "std");
+	return nbytes;
+}
+
+static int nfp_alloc_pci_push(struct nfp_dev *ndev)
+{
+	/*
+	 * allocate resources needed for PCI Push,
+	 * if not already allocated.
+	 * return True if successful
+	 */
+	if (!ndev->read_buf) {
+		ndev->read_buf =
+			kzalloc(NFP_READBUF_SIZE, GFP_KERNEL | GFP_DMA);
+		if (!ndev->read_buf)
+			return -ENOMEM;
+
+		ndev->read_dma =
+			dma_map_single(&ndev->pcidev->dev, ndev->read_buf,
+				       NFP_READBUF_SIZE, DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(&ndev->pcidev->dev, ndev->read_dma)) {
+			dev_err(&ndev->pcidev->dev,
+				"dma_mapping_error found after attempting dma_map_single");
+			kfree(ndev->read_buf);
+			ndev->read_buf = NULL;
+			ndev->read_dma = 0;
+		}
+	}
+	return ndev->read_buf ? 1 : 0;
+}
+
+static int nfp_alloc_pci_pull(struct nfp_dev *ndev)
+{
+	/*
+	 * allocate resources needed for PCI Pull,
+	 * if not already allocated.
+	 * return True if successful
+	 */
+	if (!ndev->write_buf) {
+		ndev->write_buf =
+			kzalloc(NFP_WRITEBUF_SIZE, GFP_KERNEL | GFP_DMA);
+		if (!ndev->write_buf)
+			return -ENOMEM;
+
+		ndev->write_dma = dma_map_single(&ndev->pcidev->dev,
+						 ndev->write_buf,
+						 NFP_WRITEBUF_SIZE,
+						 DMA_BIDIRECTIONAL);
+		if (dma_mapping_error(&ndev->pcidev->dev, ndev->write_dma)) {
+			dev_err(&ndev->pcidev->dev,
+				"dma_mapping_error found after attempting dma_map_single");
+			kfree(ndev->write_buf);
+			ndev->write_buf = NULL;
+			ndev->write_dma = 0;
+		}
+	}
+	return ndev->write_buf ? 1 : 0;
+}
+
+static void nfp_free_pci_push(struct nfp_dev *ndev)
+{
+	/* free resources allocated to PCI Push */
+	if (ndev->read_buf) {
+		dma_unmap_single(&ndev->pcidev->dev, ndev->read_dma,
+				 NFP_READBUF_SIZE, DMA_BIDIRECTIONAL);
+		kfree(ndev->read_buf);
+		ndev->read_buf = NULL;
+		ndev->read_dma = 0;
+	}
+}
+
+static void nfp_free_pci_pull(struct nfp_dev *ndev)
+{
+	/* free resources allocated to PCI Pull */
+	if (ndev->write_buf) {
+		dma_unmap_single(&ndev->pcidev->dev, ndev->write_dma,
+				 NFP_WRITEBUF_SIZE, DMA_BIDIRECTIONAL);
+		kfree(ndev->write_buf);
+		ndev->write_buf = NULL;
+		ndev->write_dma = 0;
+	}
+}
+
+/**
+ * nfp_set_ifvers - Sets device interface version.
+ * @ndev:	an NSHIELD SOLO device
+ * @ifvers:	interface version
+ *
+ * RETURNS: interface version actually set.
+ */
+static int nfp_set_ifvers(struct nfp_dev *ndev, int ifvers)
+{
+	int max_ifvers;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return 0; /* no interface version */
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	max_ifvers = ndev->cmddev->max_ifvers;
+	if (nfp_ifvers != 0 && max_ifvers > nfp_ifvers)
+		max_ifvers = nfp_ifvers;
+
+	/* on any error, ifvers remains unchanged */
+	if (ifvers < 0 || ifvers > max_ifvers) {
+		/* invalid nfp_ifvers: set to max as fallback */
+		dev_err(&ndev->pcidev->dev, "%s: %d out of allowable range [0:%d]",
+			__func__, ifvers, max_ifvers);
+		return ndev->ifvers;
+	}
+
+	if (ifvers == 0 &&
+	    ndev->cmddev->deviceid == PCI_DEVICE_ID_FREESCALE_T1022) {
+		/*
+		 * default ifvers: set to max for ngsolo not for legacy!
+		 * The legacy card needs it set to 0 when in Maintenance
+		 * mode and then the hardserver steps it up to ifvers 2
+		 * when switching back to Operational mode. Solo XC starts
+		 * at the max (3) whenever possible.
+		 */
+		ifvers = max_ifvers;
+	}
+
+	if (ifvers >= NFDEV_IF_PCI_PUSH) {
+		if (!nfp_alloc_pci_push(ndev)) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: can't set ifvers %d as resources not available",
+				__func__, ifvers);
+			return ndev->ifvers;
+		}
+	} else {
+		nfp_free_pci_push(ndev);
+	}
+
+	if (ifvers >= NFDEV_IF_PCI_PULL) {
+		if (!nfp_alloc_pci_pull(ndev)) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: can't set ifvers %d as resources not available",
+				__func__, ifvers);
+			return ndev->ifvers;
+		}
+	} else {
+		nfp_free_pci_pull(ndev);
+	}
+
+	ndev->ifvers = ifvers;
+	dev_warn(&ndev->pcidev->dev,
+		 "%s: setting ifvers = %d", __func__, ifvers);
+
+	return ifvers;
+}
+
+/**
+ * nfp_ioctl - Performs an NSHIELD SOLO device IOCTL call.
+ * @inode:	device inode pointer
+ * @file:	device file pointer
+ * @cmd:	command id
+ * @arg:	command argument
+ *
+ * RETURNS: 0 if successful or other value if error.
+ */
+static int nfp_ioctl(struct inode *inode,
+		     struct file *file,
+		     u32 cmd,
+		     u64 arg)
+{
+	struct nfp_dev *ndev;
+	int minor;
+
+	/* find ndev from minor */
+	minor = MINOR(INODE_FROM_FILE(file)->i_rdev);
+
+	if (minor >= NFP_MAXDEV) {
+		pr_err("%s: minor out of range.", __func__);
+		return -ENODEV;
+	}
+
+	ndev = nfp_dev_list[minor];
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	switch (cmd) {
+	case NFDEV_IOCTL_ENQUIRY: {
+		struct nfdev_enquiry_str enq_data;
+		int err = -EIO;
+
+		dev_dbg(&ndev->pcidev->dev, "%s: enquiry", __func__);
+		enq_data.busno = ndev->busno;
+		enq_data.slotno = ndev->slotno;
+		if ((void *)arg) {
+			err = copy_to_user((void __user *)arg, &enq_data,
+					   sizeof(enq_data)) ? -EFAULT : 0;
+			if (err) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: copy to user space failed.",
+					__func__);
+				return err;
+			}
+		} else {
+			dev_err(&ndev->pcidev->dev,
+				"%s enquiry: arg pointer is NULL!", __func__);
+			return err;
+		}
+	} break;
+	case NFDEV_IOCTL_ENSUREREADING: {
+		dma_addr_t addr;
+		u32 len;
+		int err = -EIO;
+		int ne;
+
+		dev_dbg(&ndev->pcidev->dev, "%s: ensure reading", __func__);
+
+		/* get and check max length */
+		if ((void *)arg) {
+			err = copy_from_user((void *)&len, (void __user *)arg,
+					     sizeof(u32)) ? -EFAULT : 0;
+			if (err) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: ensure reading: copy from user space failed.",
+					__func__);
+				return err;
+			}
+			/* signal a read to the module */
+			dev_warn(&ndev->pcidev->dev,
+				 "%s: signalling read request to module, len = %x.",
+				 __func__, len);
+			if (len > NFP_READ_MAX) {
+				dev_err(&ndev->pcidev->dev, "%s: len > %x = %x.",
+					__func__, NFP_READ_MAX, len);
+				return -EINVAL;
+			}
+		} else {
+			dev_err(&ndev->pcidev->dev,
+				"%s ensure reading: arg pointer is NULL!",
+				__func__);
+			return err;
+		}
+
+		if (len <= 0 || NFP_READ_MAX < len) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: ensure reading: invalid max length %d/%d",
+				__func__, len, NFP_READ_MAX);
+			err = -EINVAL;
+			return err;
+		}
+
+		/* check if okay to start read */
+
+		if (test_and_set_bit(WAIT_BIT, &ndev->rd_outstanding)) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: ensure reading: another read is outstanding",
+				__func__);
+			return -EBUSY;
+		}
+
+		dev_warn(&ndev->pcidev->dev,
+			 "%s: ndev->rd_outstanding=1", __func__);
+
+		/* start read ready timeout */
+
+		mod_timer(&ndev->rd_timer, jiffies + (NFP_TIMEOUT_SEC * HZ));
+
+		dev_warn(&ndev->pcidev->dev, "%s: read request", __func__);
+		/* start read */
+
+		addr = (ndev->ifvers < NFDEV_IF_PCI_PUSH) ? 0 : ndev->read_dma;
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: ensure reading: read request with ifvers=%d addr=%p",
+			   __func__, ndev->ifvers, (void *)addr);
+
+		ne = ndev->cmddev->ensure_reading(addr, len, ndev->cmdctx);
+
+		if (ne != 0) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: ensure reading: read request failed",
+				__func__);
+			del_timer_sync(&ndev->rd_timer);
+			/*
+			 * make sure that del_timer_sync is done before
+			 * we clear rd_outstanding
+			 */
+			smp_mb__before_atomic();
+			clear_bit(WAIT_BIT, &ndev->rd_outstanding);
+			return -EIO;
+		}
+	} break;
+
+	case NFDEV_IOCTL_PCI_IFVERS: {
+		int vers, err = -EIO;
+
+		dev_dbg(&ndev->pcidev->dev, "%s: set ifvers", __func__);
+		if ((void *)arg) {
+			err = copy_from_user(&vers, (void __user *)arg,
+					     sizeof(vers)) ? -EFAULT : 0;
+			if (err) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: set ifvers: copy from user space failed.",
+					__func__);
+				return err;
+			}
+		} else {
+			dev_err(&ndev->pcidev->dev,
+				"%s ifvers: arg pointer is NULL!",
+				__func__);
+			return err;
+		}
+
+		if (test_bit(WAIT_BIT, &ndev->rd_outstanding)) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: set ifvers: unable to set interface version while read outstanding",
+				__func__);
+			return -EIO;
+		}
+
+		nfp_set_ifvers(ndev, vers);
+	} break;
+
+	case NFDEV_IOCTL_STATS: {
+		int err = -EIO;
+
+		dev_dbg(&ndev->pcidev->dev, "%s: stats", __func__);
+		if ((void *)arg) {
+			err = copy_to_user((void __user *)arg, &ndev->stats,
+					   sizeof(struct nfdev_stats_str))
+					   ? -EFAULT : 0;
+			if (err) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: stats: copy to user space failed.",
+					__func__);
+				return err;
+			}
+		} else {
+			dev_err(&ndev->pcidev->dev,
+				"%s stats: arg pointer is NULL!", __func__);
+			return err;
+		}
+	} break;
+
+	case NFDEV_IOCTL_CONTROL: {
+		int err = -EIO;
+		struct nfdev_control_str control;
+
+		dev_dbg(&ndev->pcidev->dev, "%s: control", __func__);
+		if ((void *)arg) {
+			err = copy_from_user(&control, (void __user *)arg,
+					     sizeof(control)) ? -EFAULT : 0;
+			if (err) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: control: copy from user space failed.",
+					__func__);
+				return err;
+			}
+		} else {
+			dev_err(&ndev->pcidev->dev,
+				"%s control: arg pointer is NULL!", __func__);
+			return err;
+		}
+		if (!ndev->cmddev->setcontrol) {
+			dev_warn(&ndev->pcidev->dev,
+				 "%s: control: set control not supported for this device: ignored",
+				 __func__);
+			return -EINVAL;
+		}
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: control: updating HSM control register to 0x%x.",
+			   __func__,
+			   control.control);
+
+		return ndev->cmddev->setcontrol(&control, ndev->cmdctx);
+	} break;
+
+	case NFDEV_IOCTL_STATUS: {
+		int err = -EIO;
+		struct nfdev_status_str status;
+
+		dev_dbg(&ndev->pcidev->dev, "%s: status", __func__);
+
+		if (!ndev->cmddev->getstatus) {
+			dev_warn(&ndev->pcidev->dev,
+				 "%s: status not supported for this device: ignored",
+				 __func__);
+			return -EINVAL;
+		}
+		err = ndev->cmddev->getstatus(&status,
+					      ndev->cmdctx);
+
+		if (err)
+			return err;
+
+		if ((void *)arg) {
+			err = copy_to_user((void __user *)arg, &status,
+					   sizeof(status)) ? -EFAULT : 0;
+			if (err) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: status: copy from user space failed.",
+					__func__);
+				return err;
+			}
+		} else {
+			dev_err(&ndev->pcidev->dev,
+				"%s status: arg pointer is NULL!",
+				__func__);
+			return err;
+		}
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: read status: 0x%x, error: 0x%02x%02x%02x%02x%02x%02x%02x%02x",
+			   __func__,
+			status.status, status.error[0], status.error[1],
+			status.error[2], status.error[3], status.error[4],
+			status.error[5], status.error[6], status.error[7]);
+	} break;
+
+	default: {
+		dev_err(&ndev->pcidev->dev, "%s: unknown ioctl.", __func__);
+		return -EINVAL;
+	} break;
+	}
+
+	return 0;
+}
+
+/**
+ * nfp_unlocked_ioctl - Performs an NSHIELD SOLO device unlocked IOCTL call.
+ * @file:	device file pointer
+ * @cmd:	command id
+ * @arg:	command argument
+ *
+ * RETURNS: 0 if successful or other value if error.
+ */
+static long nfp_unlocked_ioctl(struct file *file,
+			       u32 cmd,
+			       unsigned long arg)
+{
+	long ret;
+	int minor;
+	struct nfp_dev *ndev;
+
+	minor = MINOR(INODE_FROM_FILE(file)->i_rdev);
+	if (minor >= NFP_MAXDEV) {
+		pr_err("%s: minor out of range.", __func__);
+		return -ENODEV;
+	}
+
+	ndev = nfp_dev_list[minor];
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	mutex_lock(&ndev->ioctl_mutex);
+	ret = nfp_ioctl(NULL, file, cmd, arg);
+	mutex_unlock(&ndev->ioctl_mutex);
+
+	dev_dbg(&ndev->pcidev->dev, "%s: left", __func__);
+	return ret;
+}
+
+static irqreturn_t nfp_isr(int irq, void *context)
+{
+	struct nfp_dev *ndev = (struct nfp_dev *)context;
+	int handled;
+	int ne;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return IRQ_NONE;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	ne = ndev->cmddev->isr(ndev->cmdctx, &handled);
+
+	if (ne != 0)
+		dev_err(&ndev->pcidev->dev, "%s: cmddev isr failed (%d)",
+			__func__, ne);
+
+	return IRQ_RETVAL(handled);
+}
+
+/**
+ * nfp_open - Opens an NSHIELD SOLO device.
+ * @inode:	device inode pointer
+ * @file:	device file pointer
+ *
+ * The kernel calls this function when a user tries to open an
+ * NSHIELD SOLO device.  It is an error to attempt to open an
+ * already opened device.
+ *
+ * RETURNS: 0 if successful or other value if error.
+ */
+static int nfp_open(struct inode *inode, struct file *file)
+{
+	struct nfp_dev *ndev;
+	int ne;
+	int minor = MINOR(INODE_FROM_FILE(file)->i_rdev);
+
+	/* find ndev */
+
+	if (minor >= NFP_MAXDEV) {
+		pr_err("%s: minor out of range.", __func__);
+		return -ENODEV;
+	}
+
+	ndev = nfp_dev_list[minor];
+	if (!ndev) {
+		pr_err("%s: cannot find dev %d.", __func__, minor);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	dev_notice(&ndev->pcidev->dev,
+		   "%s: opening file at %p.", __func__, file);
+
+	/* check if already open */
+
+	if (atomic_read(&ndev->busy)) {
+		dev_err(&ndev->pcidev->dev, "%s: device %s busy", __func__,
+			pci_name(ndev->pcidev));
+		return -EBUSY;
+	}
+	atomic_set(&ndev->busy, 1);
+
+	/* drop any old data */
+
+	clear_bit(0, &ndev->rd_ready);
+
+	/* set interface to module default */
+
+	if (ndev->cmddev->deviceid == PCI_DEVICE_ID_FREESCALE_T1022)
+		nfp_set_ifvers(ndev, NFDEV_IF_PCI_PULL);
+	else
+		nfp_set_ifvers(ndev, NFDEV_IF_STANDARD);
+
+	dev_notice(&ndev->pcidev->dev,
+		   "%s: ifvers set to %d", __func__, ndev->ifvers);
+
+	/* open device */
+
+	ne = ndev->cmddev->open(ndev->cmdctx);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev, "%s: device open failed: error %d",
+			__func__, ne);
+		atomic_set(&ndev->busy, 0);
+		return ne;
+	}
+
+	dev_warn(&ndev->pcidev->dev, "%s: device %s open",
+		 __func__, pci_name(ndev->pcidev));
+
+	return 0;
+}
+
+/**
+ * nfp_release - Releases an NSHIELD SOLO device.
+ * @node:	device inode pointer
+ * @file:	device file pointer
+ *
+ * The kernel calls this function when a user tries to close an
+ * NSHIELD SOLO device.  It is an error to attempt to close an
+ * already closed device.
+ *
+ * RETURNS: 0 if successful or other value if error.
+ */
+static int nfp_release(struct inode *node, struct file *file)
+{
+	struct nfp_dev *ndev;
+	long timeout;
+	int ne;
+	int minor = MINOR(INODE_FROM_FILE(file)->i_rdev);
+
+	/* find ndev from minor */
+	if (minor >= NFP_MAXDEV) {
+		pr_err("%s: minor out of range.", __func__);
+		return(-ENODEV);
+	}
+
+	ndev = nfp_dev_list[minor];
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	dev_warn(&ndev->pcidev->dev, "%s: closing file at %p.", __func__, file);
+
+	{
+		wait_queue_entry_t wait;
+
+		timeout = 1;
+		init_waitqueue_entry(&wait, current);
+		current->state = TASK_UNINTERRUPTIBLE;
+		add_wait_queue(&ndev->rd_queue, &wait);
+		if (test_bit(WAIT_BIT, &ndev->rd_outstanding)) {
+			dev_dbg(&ndev->pcidev->dev,
+				"%s: read outstanding", __func__);
+			timeout = schedule_timeout(NFP_TIMEOUT);
+			dev_dbg(&ndev->pcidev->dev,
+				"%s: finished waiting", __func__);
+		}
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&ndev->rd_queue, &wait);
+		if (!timeout) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: outstanding read timed out", __func__);
+		}
+	}
+
+	atomic_set(&ndev->busy, 1);
+	if (test_bit(WAIT_BIT, &ndev->rd_outstanding)) {
+		del_timer_sync(&ndev->rd_timer);
+		/* make sure that del_timer_sync is done before
+		 * we clear rd_outstanding
+		 */
+		smp_mb__before_atomic();
+		clear_bit(WAIT_BIT, &ndev->rd_outstanding);
+	}
+	atomic_set(&ndev->busy, 0);
+
+	/* close device */
+
+	ne = ndev->cmddev->close(ndev->cmdctx);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: device close failed", __func__);
+		return ne;
+	}
+
+	return(0);
+}
+
+/**
+ * NSHIELD SOLO character device file operations table.
+ */
+static const struct file_operations nfp_fops = { .owner = THIS_MODULE,
+	.poll = nfp_poll,
+	.write = nfp_write,
+	.read = nfp_read,
+	.unlocked_ioctl = nfp_unlocked_ioctl,
+	.open = nfp_open,
+	.release = nfp_release,
+};
+
+/**
+ * NSHIELD SOLO device management.
+ */
+
+/* device setup */
+
+static void nfp_dev_destroy(struct nfp_dev *ndev, struct pci_dev *pci_dev)
+{
+	int i;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return;
+	}
+
+	dev_dbg(&ndev->pcidev->dev, "%s: entered", __func__);
+	if (ndev) {
+		nfp_free_pci_push(ndev);
+		nfp_free_pci_pull(ndev);
+
+		if (ndev->irq) {
+			dev_notice(&ndev->pcidev->dev, "%s: freeing irq, %x",
+				   __func__, ndev->irq);
+			free_irq(ndev->irq, ndev);
+		}
+		for (i = 0; i < 6; i++)
+			if (ndev->bar[i]) {
+				dev_notice(&ndev->pcidev->dev,
+					   "%s: freeing MEM BAR, %d",
+					   __func__, i);
+				release_mem_region(pci_resource_start(pci_dev,
+								      i),
+						   pci_resource_len(pci_dev,
+								    i));
+				iounmap(ndev->bar[i]);
+			}
+		dev_notice(&ndev->pcidev->dev, "%s: freeing ndev", __func__);
+		kfree(ndev);
+	}
+}
+
+static int nfp_setup(const struct nfpcmd_dev *cmddev, u8 bus, u8 slot,
+		     u32 bar[6], u32 irq_line, struct pci_dev *pcidev)
+{
+	struct nfp_dev *ndev = 0;
+	int ne;
+	int i;
+
+	dev_warn(&pcidev->dev,
+		 "%s: Found '%s' at bus %x, slot %x, irq %d.",
+		 __func__, cmddev->name, bus, slot, irq_line);
+
+	if (nfp_num_devices >= NFP_MAXDEV) {
+		dev_err(&pcidev->dev,
+			"%s: minor out of range.", __func__);
+		goto fail_continue;
+	}
+
+	ndev = kzalloc(sizeof(*ndev), GFP_KERNEL);
+	if (!ndev) {
+		/* logged by the allocator */
+		goto fail_continue;
+	}
+	dev_warn(&pcidev->dev,
+		 "%s: allocated device structure.", __func__);
+
+	ndev->busno = bus;
+	ndev->pcidev = pcidev;
+	ndev->slotno = slot;
+	ndev->cmddev = cmddev;
+
+	for (i = 0; i < NFP_BARSIZES_COUNT; i++) {
+		int map_bar_size = cmddev->bar_sizes[i] & NFP_BARSIZES_MASK;
+		int bar_flags = cmddev->bar_sizes[i] & ~NFP_BARSIZES_MASK;
+
+		if (map_bar_size) {
+			if (!request_mem_region(pci_resource_start(pcidev, i),
+						pci_resource_len(pcidev, i),
+						cmddev->name)) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: request_mem_region failed, %llx %llx %d (%s)",
+					__func__,
+					pci_resource_start(pcidev, i),
+					pci_resource_len(pcidev, i), i,
+					cmddev->name);
+				goto fail_continue;
+			}
+
+			if (bar_flags & PCI_BASE_ADDRESS_SPACE_PREFETCHABLE) {
+				ndev->bar[i] =
+					ioremap(bar[i], map_bar_size);
+			} else {
+				ndev->bar[i] =
+					ioremap_nocache(bar[i], map_bar_size);
+			}
+
+			if (!ndev->bar[i]) {
+				dev_err(&ndev->pcidev->dev,
+					"%s: unable to map memory BAR %d, (0x%x).",
+					__func__, i, bar[i]);
+				goto fail_continue;
+			}
+		}
+	}
+
+	mutex_init(&ndev->ioctl_mutex);
+
+	init_waitqueue_head(&ndev->wr_queue);
+	init_waitqueue_head(&ndev->rd_queue);
+
+	set_bit(0, &ndev->wr_ready);
+
+	ne = ndev->cmddev->create(ndev);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: failed to create command device (%d)",
+			__func__, ne);
+		goto fail_continue;
+	}
+
+	if (request_irq(irq_line, nfp_isr, IRQF_SHARED, cmddev->name, ndev)) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: unable to claim interrupt.", __func__);
+		goto fail_continue;
+	}
+	ndev->irq = irq_line;
+
+	memset(&ndev->stats, 0, sizeof(ndev->stats));
+
+	pci_set_drvdata(pcidev, ndev);
+
+	/* setup timeout timer */
+	timer_setup(&ndev->rd_timer, nfp_read_timeout, 0);
+	mod_timer(&ndev->rd_timer, jiffies + (NFP_TIMEOUT_SEC * HZ));
+
+	nfp_dev_list[nfp_num_devices] = ndev;
+	device_create(nfp_class, NULL, /* parent */
+		      MKDEV(NFP_MAJOR, nfp_num_devices), NULL, /* drvdata */
+		      "nshield_solo%d", nfp_num_devices);
+	dev_warn(&ndev->pcidev->dev, "%s: nfp_num_devices= %d, ndev = %p.",
+		 __func__, nfp_num_devices, ndev);
+	nfp_num_devices++;
+	return 1;
+
+fail_continue:
+	nfp_dev_destroy(ndev, pcidev);
+
+	return 0;
+}
+
+/* device probing */
+
+/**
+ * nfp_pci_probe - Adds a PCI device to the module.
+ * @pcidev:	PCI device
+ * @id:	PCI device ids
+ *
+ * The PCI subsystem calls this function when a PCI device is found.
+ *
+ * RETURNS: 0 if successful or other value if error.
+ */
+static int nfp_pci_probe(struct pci_dev *pcidev,
+			 struct pci_device_id const *id)
+{
+	int i;
+	u32 bar[6];
+	const struct nfpcmd_dev *nfp_drvlist[] = { &i21555_cmddev,
+						   &fsl_t1022_cmddev, NULL };
+	const struct nfpcmd_dev *cmddev = nfp_drvlist[id->driver_data];
+	u64 iosize;
+	u32 irq_line;
+	int pos = 0u;
+	int err = 0;
+
+	if (!pcidev || !id) {
+		pr_err("%s: pcidev or id was NULL!", __func__);
+		return -ENODEV;
+	}
+
+	dev_notice(&pcidev->dev, "%s: probing PCI device %s",
+		   __func__, pci_name(pcidev));
+
+	/* enable the device */
+	err = pci_enable_device(pcidev);
+	if (err) {
+		dev_err(&pcidev->dev, "%s: pci_enable_device failed", __func__);
+		err = -ENODEV;
+		goto probe_err;
+	}
+
+	pci_set_master(pcidev);
+
+	/* save PCI device info */
+	irq_line = pcidev->irq;
+	for (i = 0; i < NFP_BARSIZES_COUNT; ++i) {
+		iosize = cmddev->bar_sizes[i] & NFP_BARSIZES_MASK;
+		if (pci_resource_len(pcidev, i) < iosize) {
+			dev_err(&pcidev->dev,
+				"%s: %s region request overflow: bar %d, requested %llx, maximum %llx",
+				__func__, pci_name(pcidev), i, iosize,
+				pci_resource_len(pcidev, i));
+			err = -ENODEV;
+			goto probe_err;
+		}
+		bar[i] = pci_resource_start(pcidev, i);
+	}
+
+	if (cmddev->flags & NFP_CMD_FLG_NEED_MSI) {
+		pos = pci_find_capability(pcidev, PCI_CAP_ID_MSI);
+		if (!pos) {
+			dev_err(&pcidev->dev, "%s: %s MSI not supported",
+				__func__, pci_name(pcidev));
+			err = -ENODEV;
+			goto probe_err;
+		}
+		dev_err(&pcidev->dev, "%s: %s MSI support at %d",
+			__func__, pci_name(pcidev), pos);
+
+		err = pci_enable_msi(pcidev);
+		if (err) {
+			dev_err(&pcidev->dev,
+				"%s: %s unable to enable MSI",
+				__func__, pci_name(pcidev));
+			goto probe_err;
+		}
+
+		/* IRQ vector changes if MSI is enabled. */
+		irq_line = pcidev->irq;
+		dev_notice(&pcidev->dev, "%s: %s MSI IRQ at %d",
+			   __func__, pci_name(pcidev), irq_line);
+	}
+
+	dev_warn(&pcidev->dev, "%s: devname %s, slotname %s, busname %s",
+		 __func__, "", pci_name(pcidev), pcidev->bus->name);
+
+	err = nfp_setup(cmddev, pcidev->bus->number, PCI_SLOT(pcidev->devfn),
+			bar, irq_line, pcidev);
+	if (!err) {
+		err = -ENODEV;
+		goto probe_err;
+	}
+
+	return 0;
+
+probe_err:
+	pci_disable_msi(pcidev);
+	pci_clear_master(pcidev);
+	pci_disable_device(pcidev);
+	return err;
+}
+
+/**
+ * nfp_pci_remove - Removes a PCI device from the module.
+ * @pcidev:	PCI device
+ *
+ * The PCI subsystem calls this function when a PCI device is removed.
+ *
+ * RETURNS: 0 if successful or other value if error.
+ */
+static void nfp_pci_remove(struct pci_dev *pcidev)
+{
+	int index;
+	struct nfp_dev *ndev;
+
+	dev_err(&pcidev->dev, "%s: removing PCI device %s",
+		__func__, pci_name(pcidev));
+
+	/* find existing device */
+
+	ndev = pci_get_drvdata(pcidev);
+	if (!ndev) {
+		dev_err(&pcidev->dev,
+			"%s: no NSHIELD SOLO device associated with this PCI device",
+			__func__);
+		return;
+	}
+
+	/* destroy common device */
+
+	if (ndev->cmddev)
+		ndev->cmddev->destroy(ndev->cmdctx);
+
+	nfp_dev_destroy(ndev, pcidev);
+
+	pci_disable_msi(pcidev);
+	pci_clear_master(pcidev);
+	pci_disable_device(pcidev);
+
+	index = 0;
+	while (index < NFP_MAXDEV) {
+		if (nfp_dev_list[index] == ndev) {
+			nfp_dev_list[index] = NULL;
+			device_destroy(nfp_class, MKDEV(NFP_MAJOR, index));
+		}
+		index++;
+	}
+}
+
+/**
+ * PCI device ID table.  We use the driver_data field to hold an index into
+ * nfp_drvlist, so bear than in mind when editing either.
+ */
+static struct pci_device_id nfp_pci_tbl[] = {
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL,
+			       PCI_DEVICE_ID_INTEL_21555,
+			       PCI_VENDOR_ID_NCIPHER,
+			       PCI_SUBSYSTEM_ID_NFAST_REV1),
+		.class = 0, /* Ignore class */
+		.class_mask = 0, /* Ignore class mask */
+		.driver_data = 0 /* Index into nfp_drvlist */
+	},
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_FREESCALE,
+			       PCI_DEVICE_ID_FREESCALE_T1022,
+			       PCI_VENDOR_ID_NCIPHER,
+			       PCI_SUBSYSTEM_ID_NFAST_REV1),
+		.class = 0, /* Ignore class */
+		.class_mask = 0, /* Ignore class mask */
+		.driver_data = 1 /* Index into nfp_drvlist */
+	},
+	{
+		0,
+	} /* terminate list */
+};
+MODULE_DEVICE_TABLE(pci, nfp_pci_tbl);
+
+/**
+ * PCI driver operations.
+ */
+static struct pci_driver nfp_pci_driver = { .name = "nshield_solo",
+					    .probe = nfp_pci_probe,
+					    .remove = nfp_pci_remove,
+					    .id_table = nfp_pci_tbl };
+
+/**
+ * initialisation
+ */
+
+static int nfp_init(void)
+{
+	int index;
+
+	pr_info("%s: entered", __func__);
+
+	if (register_chrdev(NFP_MAJOR, NFP_DRVNAME, &nfp_fops)) {
+		pr_err("unable to get major for nshield_solo device.");
+		return -EIO;
+	}
+
+	for (index = 0; index < NFP_MAXDEV; index++)
+		nfp_dev_list[index] = NULL;
+
+	nfp_class = class_create(THIS_MODULE, "nshield_solo");
+	if (IS_ERR(nfp_class)) {
+		pr_err("%s: failed to create a class for this device, err = %ld",
+		       __func__, PTR_ERR(nfp_class));
+		return -EIO;
+	}
+
+	index = 0;
+	return pci_register_driver(&nfp_pci_driver);
+}
+
+/**
+ * Initializes this NSHIELD SOLO kernel module.
+ */
+static int __init nfp_module_init(void)
+{
+	int err;
+
+	pr_err("%s: inserting nshield_solo module", __func__);
+
+	err = nfp_init();
+
+	return err;
+}
+
+/**
+ * Exits this NSHIELD SOLO kernel module.
+ */
+static void __exit nfp_module_exit(void)
+{
+	pr_notice("%s: removing nshield_solo module", __func__);
+
+	/* unregister pci driver */
+
+	pci_unregister_driver(&nfp_pci_driver);
+	/* this triggers device removals */
+
+	class_destroy(nfp_class);
+
+	unregister_chrdev(NFP_MAJOR, NFP_DRVNAME);
+	pr_notice("%s: removed nshield_solo module", __func__);
+}
+
+module_init(nfp_module_init);
+module_exit(nfp_module_exit);
+
+/* end of file */
diff --git a/drivers/misc/ncipher/i21555.c b/drivers/misc/ncipher/i21555.c
new file mode 100644
index 000000000000..2e927d56c3b6
--- /dev/null
+++ b/drivers/misc/ncipher/i21555.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *
+ * i21555.c: nCipher PCI HSM intel 21555 command driver
+ * Copyright 2019 nCipher Security Ltd
+ *
+ */
+
+#include "solo.h"
+#include "i21555.h"
+
+/*
+ * pci fixed length accessors.
+ * The below functions are used predominantly to access CSR registers in pci
+ * memory space.
+ */
+static u32 nfp_inl(struct nfp_dev *ndev, int bar, int offset)
+{
+	dev_dbg(&ndev->pcidev->dev,
+		"%s: addr %p", __func__, ndev->bar[bar] + offset);
+	return le32_to_cpu(ioread32(ndev->bar[bar] + offset));
+}
+
+static u16 nfp_inw(struct nfp_dev *ndev, int bar, int offset)
+{
+	dev_dbg(&ndev->pcidev->dev,
+		"%s: addr %p", __func__, ndev->bar[bar] + offset);
+	return le16_to_cpu(ioread16(ndev->bar[bar] + offset));
+}
+
+static void nfp_outl(struct nfp_dev *ndev, int bar, int offset, u32 data)
+{
+	dev_dbg(&ndev->pcidev->dev, "%s: addr %p, data %x",
+		__func__, ndev->bar[bar] + offset, data);
+	iowrite32(cpu_to_le32(data), ndev->bar[bar] + offset);
+}
+
+static void nfp_outw(struct nfp_dev *ndev, int bar, int offset, u16 data)
+{
+	dev_dbg(&ndev->pcidev->dev, "%s: addr %p, data %x",
+		__func__, ndev->bar[bar] + offset, data);
+	iowrite16(cpu_to_le16(data), ndev->bar[bar] + offset);
+}
+
+static int nfp_config_inl(struct nfp_dev *ndev, int offset, u32 *res)
+{
+	if (!ndev || !ndev->pcidev)
+		return -ENODEV;
+	pci_read_config_dword(ndev->pcidev, offset, res);
+	return 0;
+}
+
+/**
+ * i21555_started - Check that device is ready to talk
+ * @ndev:	common device
+ *
+ * Checks that device is ready to talk by checking that the i21555 has master
+ * enabled on its secondary interface
+ *
+ * RETURNS: 0 if ready or other value if error.
+ */
+static int i21555_started(struct nfp_dev *ndev)
+{
+	u32 tmp32;
+	int ne;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	ne = nfp_config_inl(ndev, I21555_CFG_SEC_CMD_STATUS, &tmp32);
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: nfp_config_inl failed", __func__);
+		return ne;
+	}
+
+	tmp32 = le32_to_cpu(tmp32) & 0xffff;
+
+	if (tmp32 & CFG_CMD_MASTER) {
+		dev_notice(&ndev->pcidev->dev,
+			   "%s: Yes %x", __func__, tmp32);
+	} else {
+		dev_err(&ndev->pcidev->dev, "%s: device not started yet %x",
+			__func__, tmp32);
+		ne = -EAGAIN;
+	}
+	return ne;
+}
+
+/**
+ * i21555_create - Resets the i21555 device.
+ * @ndev:	common device
+ *
+ * RETURNS: 0 if successful or other value if error.
+ */
+static int i21555_create(struct nfp_dev *ndev)
+{
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	/* set our context to just be a pointer to our struct nfp_dev */
+	ndev->cmdctx = ndev;
+
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: null BAR[%d]", __func__, CSR_BAR);
+		return -ENOMEM;
+	}
+	dev_warn(&ndev->pcidev->dev, "%s: enable doorbell", __func__);
+	nfp_outl(ndev, CSR_BAR, I21555_OFFSET_DOORBELL_PRI_SET_MASK,
+		 I21555_DOORBELL_PRI_ENABLE);
+	nfp_outl(ndev, CSR_BAR, I21555_OFFSET_DOORBELL_PRI_CLEAR_MASK,
+		 I21555_DOORBELL_PRI_ENABLE);
+	return 0;
+}
+
+/**
+ * i21555_destroy - Destroys an i21555 device.
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int i21555_destroy(struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	if (!ndev) {
+		dev_err(&ndev->pcidev->dev, "%s: NULL ndev", __func__);
+		return -ENODEV;
+	}
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: null BAR[%d]", __func__, CSR_BAR);
+		return -ENOMEM;
+	}
+	nfp_outl(ndev, CSR_BAR, I21555_OFFSET_DOORBELL_PRI_SET_MASK,
+		 I21555_DOORBELL_PRI_DISABLE);
+	nfp_outl(ndev, CSR_BAR, I21555_OFFSET_DOORBELL_PRI_CLEAR_MASK,
+		 I21555_DOORBELL_PRI_DISABLE);
+
+	return 0;
+}
+
+/**
+ * i21555_open - Opens an i21555 device
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int i21555_open(struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	return 0;
+}
+
+/**
+ * i21555_close - Closes an i21555 device
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int i21555_close(struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	return 0;
+}
+
+/**
+ * i21555_isr - Handles an interrupt from the i21555 device.
+ * @ctx:	device context (always the device itself)
+ * @handled:	set non-zero by this routine if interrupt considered handled
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int i21555_isr(struct nfp_dev *ctx, int *handled)
+{
+	struct nfp_dev *ndev = ctx;
+	u16 doorbell;
+	u16 tmp16;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	*handled = 0;
+
+	ndev->stats.isr++;
+
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: null BAR[%d]", __func__, CSR_BAR);
+		return -ENOMEM;
+	}
+
+	/*
+	 * This interrupt may not be from our module, so check that it
+	 * actually is us before handling it.
+	 */
+	doorbell = nfp_inw(ndev, CSR_BAR, I21555_OFFSET_DOORBELL_PRI_SET);
+	while (doorbell && doorbell != 0xffff) {
+		*handled = 1;
+		/* service interrupts */
+		if (doorbell & (NFAST_INT_DEVICE_WRITE_OK |
+				NFAST_INT_DEVICE_WRITE_FAILED)) {
+			ndev->stats.isr_write++;
+			tmp16 = (NFAST_INT_DEVICE_WRITE_OK |
+				 NFAST_INT_DEVICE_WRITE_FAILED);
+			nfp_outw(ndev, CSR_BAR,
+				 I21555_OFFSET_DOORBELL_PRI_CLEAR, tmp16);
+
+			dev_warn(&ndev->pcidev->dev,
+				 "%s: write done interrupt, ok = %d.", __func__,
+				 doorbell & NFAST_INT_DEVICE_WRITE_OK ? 1 : 0);
+
+			nfp_write_complete(ndev, doorbell &
+					   NFAST_INT_DEVICE_WRITE_OK ? 1 : 0);
+		}
+
+		if (doorbell &
+		    (NFAST_INT_DEVICE_READ_OK |
+		     NFAST_INT_DEVICE_READ_FAILED)) {
+			ndev->stats.isr_read++;
+			tmp16 = (NFAST_INT_DEVICE_READ_OK |
+				 NFAST_INT_DEVICE_READ_FAILED);
+			nfp_outw(ndev, CSR_BAR,
+				 I21555_OFFSET_DOORBELL_PRI_CLEAR, tmp16);
+
+			dev_warn(&ndev->pcidev->dev,
+				 "%s: read ack interrupt, ok = %d.", __func__,
+				 doorbell & NFAST_INT_DEVICE_READ_OK ? 1 : 0);
+			nfp_read_complete(ndev, doorbell &
+					  NFAST_INT_DEVICE_READ_OK ? 1 : 0);
+		}
+
+		if (doorbell &
+		    ~(NFAST_INT_DEVICE_READ_OK | NFAST_INT_DEVICE_READ_FAILED |
+		      NFAST_INT_DEVICE_WRITE_OK |
+		      NFAST_INT_DEVICE_WRITE_FAILED)) {
+			nfp_outw(ndev, CSR_BAR,
+				 I21555_OFFSET_DOORBELL_PRI_CLEAR, doorbell);
+			dev_err(&ndev->pcidev->dev, "%s: unexpected interrupt %x",
+				__func__, doorbell);
+		}
+		doorbell = nfp_inw(ndev, CSR_BAR,
+				   I21555_OFFSET_DOORBELL_PRI_SET);
+	}
+	dev_notice(&ndev->pcidev->dev, "%s: exiting", __func__);
+	return 0;
+}
+
+/**
+ * i21555_write - Initiates a device write request.
+ * @addr:	32-bit bus address used by DMA to pull request to device
+ * @block:	data buffer to copy from
+ * @len:	length of data to copy
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if write successful or other value if error.
+ */
+static int i21555_write(u32 addr, const char *block, int len,
+			struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	__le32 hdr[2];
+	int ne;
+	u16 tmp16;
+	__le32 tmp32;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	ndev->stats.write_fail++;
+
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: null BAR[%d]", __func__, CSR_BAR);
+		return -ENOMEM;
+	}
+
+	ne = i21555_started(ndev);
+	if (ne != 0) {
+		if (ne != -EAGAIN) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: i21555_started failed", __func__);
+		}
+		return ne;
+	}
+
+	dev_notice(&ndev->pcidev->dev, "%s: ndev->bar[ MEMBAR2 ]= %p",
+		   __func__, ndev->bar[MEMBAR2]);
+	dev_notice(&ndev->pcidev->dev, "%s: ndev->bar[ CSR_BAR ]= %p",
+		   __func__, ndev->bar[CSR_BAR]);
+	dev_notice(&ndev->pcidev->dev, "%s: block len %d", __func__, len);
+
+	/* send write request */
+
+	ne = copy_from_user(ndev->bar[MEMBAR2] + NFPCI_JOBS_WR_DATA,
+			    block, len) ? -EFAULT : 0;
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: copy_from_user failed", __func__);
+		return ne;
+	}
+	hdr[0] = cpu_to_le32(NFPCI_JOB_CONTROL);
+	hdr[1] = cpu_to_le32(len);
+	memcpy(ndev->bar[MEMBAR2] + NFPCI_JOBS_WR_CONTROL,
+	       (const char *)hdr, 2 * sizeof(hdr[0]));
+
+	/* confirm write request */
+
+	memcpy((char *)hdr, ndev->bar[MEMBAR2] + NFPCI_JOBS_WR_LENGTH,
+	       sizeof(hdr[0]));
+	tmp32 = cpu_to_le32(len);
+	if (hdr[0] != tmp32) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: length not written", __func__);
+		return -EIO;
+	}
+
+	tmp16 = NFAST_INT_HOST_WRITE_REQUEST >> 16;
+	nfp_outw(ndev, CSR_BAR, I21555_OFFSET_DOORBELL_SEC_SET, tmp16);
+
+	ndev->stats.write_fail--;
+	ndev->stats.write_block++;
+	ndev->stats.write_byte += len;
+
+	dev_warn(&ndev->pcidev->dev, "%s: done", __func__);
+	return 0;
+}
+
+/**
+ * i21555_read - Reads a device read reply.
+ * @block:	data buffer to copy into
+ * @len:	maximum length of data to copy
+ * @ctx:	device context (always the device itself)
+ * @rcnt:	returned actual # of bytes copied
+ *
+ * RETURNS: 0 if read initiated or other value if error.
+ */
+static int i21555_read(char *block, int len, struct nfp_dev *ctx, int *rcount)
+{
+	struct nfp_dev *ndev = ctx;
+	int ne;
+	int count;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+	*rcount = 0;
+
+	ndev->stats.read_fail++;
+
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev, "%s: null BAR[%d]",
+			__func__, CSR_BAR);
+		return -ENOMEM;
+	}
+
+	ne = i21555_started(ndev);
+	if (ne != 0) {
+		if (ne != -EAGAIN)
+			dev_err(&ndev->pcidev->dev,
+				"%s: i21555_started failed", __func__);
+
+		return ne;
+	}
+
+	memcpy((char *)&count, ndev->bar[MEMBAR2] + NFPCI_JOBS_RD_LENGTH,
+	       sizeof(count));
+	count = le32_to_cpu(count);
+	if (count < 0 || count > len) {
+		dev_err(&ndev->pcidev->dev, "%s: bad byte count (%d) from device",
+			__func__, count);
+		return -EIO;
+	}
+	ne = copy_to_user(block, ndev->bar[MEMBAR2] +  NFPCI_JOBS_RD_DATA,
+			  count) ? -EFAULT : 0;
+	if (ne != 0) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: copy_to_user failed", __func__);
+		return ne;
+	}
+	dev_warn(&ndev->pcidev->dev, "%s: done", __func__);
+	*rcount = count;
+	ndev->stats.read_fail--;
+	ndev->stats.read_block++;
+	ndev->stats.read_byte += len;
+	return 0;
+}
+
+/**
+ * i21555_ensure_reading - Initiates a device read request.
+ * @addr:	32-bit bus address used by DMA to push reply from device
+ * @len:	maximum length data to return
+ * @ctx:	device context (always the device itself)
+ *
+ * RETURNS: 0 if read initiated or other value if error.
+ */
+static int i21555_ensure_reading(dma_addr_t addr, int len, struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	__le32 hdr[3];
+	u16 tmp16;
+	__le32 tmp32;
+	int ne;
+	int hdr_len;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+
+	ndev->stats.ensure_fail++;
+
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev, "%s: null BAR[%d]",
+			__func__, CSR_BAR);
+		return -ENOMEM;
+	}
+
+	ne = i21555_started(ndev);
+	if (ne != 0) {
+		if (ne != -EAGAIN) {
+			dev_err(&ndev->pcidev->dev,
+				"%s: i21555_started failed", __func__);
+		}
+		return ne;
+	}
+
+	dev_notice(&ndev->pcidev->dev, "%s: ndev->bar[ MEMBAR2 ]= %p", __func__,
+		   ndev->bar[MEMBAR2]);
+	dev_notice(&ndev->pcidev->dev, "%s: ndev->bar[ CSR_BAR ]= %p", __func__,
+		   ndev->bar[CSR_BAR]);
+
+	/* send read request */
+
+	if (addr) {
+		dev_notice(&ndev->pcidev->dev, "%s: new format, addr %p",
+			   __func__, (void *)addr);
+		hdr[0] = cpu_to_le32(NFPCI_JOB_CONTROL_PCI_PUSH);
+		hdr[1] = cpu_to_le32(len);
+		hdr[2] = cpu_to_le32(addr);
+		hdr_len = 3 * sizeof(hdr[0]);
+	} else {
+		hdr[0] = cpu_to_le32(NFPCI_JOB_CONTROL);
+		hdr[1] = cpu_to_le32(len);
+		hdr_len = 2 * sizeof(hdr[0]);
+	}
+
+	memcpy(ndev->bar[MEMBAR2] + NFPCI_JOBS_RD_CONTROL,
+	       (const char *)hdr, hdr_len);
+
+	/* confirm read request */
+
+	memcpy((char *)hdr, ndev->bar[MEMBAR2] + NFPCI_JOBS_RD_LENGTH,
+	       sizeof(hdr[0]));
+	tmp32 = cpu_to_le32(len);
+	if (hdr[0] != tmp32) {
+		dev_err(&ndev->pcidev->dev, "%s: len not written", __func__);
+		return -EIO;
+	}
+
+	tmp16 = NFAST_INT_HOST_READ_REQUEST >> 16;
+	nfp_outw(ndev, CSR_BAR, I21555_OFFSET_DOORBELL_SEC_SET, tmp16);
+
+	ndev->stats.ensure_fail--;
+	ndev->stats.ensure++;
+
+	return 0;
+}
+
+/**
+ * i21555_set_control - Sets control data.
+ * @control:	control string to copy from
+ * @ctx:	device context (always the device itself)
+ *
+ * The device control register is writen directly. No doorbell style handshake
+ * is used.
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int i21555_set_control(const struct nfdev_control_str *control,
+			      struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev, "%s: null BAR[%d]",
+			__func__, CSR_BAR);
+		return -ENOMEM;
+	}
+	nfp_outl(ndev, CSR_BAR, I21555_SCRATCHPAD_REGISTER_CONTROL,
+		 control->control);
+	return 0;
+}
+
+/**
+ * i21555_get_status - Returns status data.
+ * @status:	string to copy into
+ * @ctx:	device context (always the device itself)
+ *
+ * The device status registers are read immediately. No doorbell style
+ * handshake is used. Without explicit synchronization, it is possible
+ * that an inconsistent state may be returned if the status is being
+ * updated by the firmware while simultaneously being read by the host.
+ * For example, the call could return an updated status word with a not
+ * as yet updated error string. This is likely a degenerate case.
+ *
+ * RETURNS: 0 if successful, other value if error.
+ */
+static int i21555_get_status(struct nfdev_status_str *status,
+			     struct nfp_dev *ctx)
+{
+	struct nfp_dev *ndev = ctx;
+	u32 *error = (u32 *)status->error;
+
+	/* check for device */
+	if (!ndev) {
+		pr_err("%s: error: no device", __func__);
+		return -ENODEV;
+	}
+
+	dev_info(&ndev->pcidev->dev, "%s: entered", __func__);
+	if (!ndev->bar[CSR_BAR]) {
+		dev_err(&ndev->pcidev->dev,
+			"%s: null BAR[%d]", __func__, CSR_BAR);
+		return -ENOMEM;
+	}
+
+	/*
+	 * get status (read immediately with no explicit synchronization
+	 * with the firmware)
+	 */
+	status->status = nfp_inl(ndev,
+				 CSR_BAR, I21555_SCRATCHPAD_REGISTER_STATUS);
+	error[0] = nfp_inl(ndev, CSR_BAR, I21555_SCRATCHPAD_REGISTER_ERROR_LO);
+	error[1] = nfp_inl(ndev, CSR_BAR, I21555_SCRATCHPAD_REGISTER_ERROR_HI);
+	return 0;
+}
+
+/* command device structure */
+
+const struct nfpcmd_dev i21555_cmddev = {
+	.name = "nCipher nShield Solo",
+	.vendorid = PCI_VENDOR_ID_INTEL,
+	.deviceid = PCI_DEVICE_ID_INTEL_21555,
+	.sub_vendorid = PCI_VENDOR_ID_NCIPHER,
+	.sub_deviceid = PCI_SUBSYSTEM_ID_NFAST_REV1,
+	.bar_sizes = BAR_SIZES,
+	.flags = 0,
+	.max_ifvers = NFDEV_IF_PCI_PUSH,
+	.create = i21555_create,
+	.destroy = i21555_destroy,
+	.open = i21555_open,
+	.close = i21555_close,
+	.isr = i21555_isr,
+	.write_block = i21555_write,
+	.read_block = i21555_read,
+	.ensure_reading = i21555_ensure_reading,
+	.setcontrol = i21555_set_control,
+	.getstatus = i21555_get_status,
+};
+
+/* end of file */
diff --git a/drivers/misc/ncipher/i21555.h b/drivers/misc/ncipher/i21555.h
new file mode 100644
index 000000000000..85f88b39106a
--- /dev/null
+++ b/drivers/misc/ncipher/i21555.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *
+ * Interfaces to the Solo's Intel 21555 bridge
+ * Copyright 2019 nCipher Security Ltd
+ *
+ */
+
+#ifndef NFP_I21555_H
+#define NFP_I21555_H
+
+#include "solo.h"
+
+#ifndef PCI_DEVICE_ID_INTEL_21555
+#define PCI_DEVICE_ID_INTEL_21555		0xb555
+#endif
+
+#ifndef PCI_VENDOR_ID_NCIPHER
+#define PCI_VENDOR_ID_NCIPHER			0x0100
+#endif
+
+#ifndef PCI_SUBSYSTEM_ID_NFAST_REV1
+#define PCI_SUBSYSTEM_ID_NFAST_REV1		0x0100
+#endif
+
+#define I21555_OFFSET_DOORBELL_PRI_SET		0x9C
+#define I21555_OFFSET_DOORBELL_SEC_SET		0x9E
+#define I21555_OFFSET_DOORBELL_PRI_CLEAR	0x98
+
+#define I21555_OFFSET_DOORBELL_PRI_SET_MASK	0xA4
+#define I21555_OFFSET_DOORBELL_PRI_CLEAR_MASK	0xA0
+
+#define I21555_DOORBELL_PRI_ENABLE 0x0000
+#define I21555_DOORBELL_PRI_DISABLE 0xFFFF
+
+/* 8 32-bit scratchpad registers start here; bridge manual section 11.4 */
+#define I21555_SCRATCHPAD_REGISTER(n)		(0xA8 + 4 * (n))
+
+/* Scratchpad register assignments */
+#define I21555_SCRATCHPAD_REGISTER_CONTROL	I21555_SCRATCHPAD_REGISTER(0)
+#define I21555_SCRATCHPAD_REGISTER_STATUS	I21555_SCRATCHPAD_REGISTER(1)
+#define I21555_SCRATCHPAD_REGISTER_ERROR_LO	I21555_SCRATCHPAD_REGISTER(2)
+#define I21555_SCRATCHPAD_REGISTER_ERROR_HI	I21555_SCRATCHPAD_REGISTER(3)
+
+#define I21555_CFG_SEC_CMD_STATUS		0x44
+
+#define CFG_CMD_MASTER				0x0004
+
+#define MEMBAR1					0
+#define MEMBAR2					2
+
+/* lower 4k of BAR0 map the 21555 CSRs (doorbell IRQs etc) */
+#define MEMBAR1_SIZE 4096
+
+#define CSR_BAR MEMBAR1
+#define BAR_SIZES {MEMBAR1_SIZE,                                               \
+		   0,                                                          \
+		   NFPCI_RAM_MINSIZE_JOBS |                                    \
+		   PCI_BASE_ADDRESS_SPACE_PREFETCHABLE,                        \
+		   0,                                                          \
+		   0,                                                          \
+		   0}
+
+#endif /* NFP_I21555_H */
diff --git a/drivers/misc/ncipher/solo.h b/drivers/misc/ncipher/solo.h
new file mode 100644
index 000000000000..144c779887f8
--- /dev/null
+++ b/drivers/misc/ncipher/solo.h
@@ -0,0 +1,315 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *
+ * solo.h: nCipher PCI HSM interface
+ * Copyright 2019 nCipher Security Ltd
+ *
+ * Declares the nFast PCI register interface, driver runtime
+ * structures, and supporting items.
+ *
+ * The interface presented by nFast PCI devices consists of:
+ *
+ * - a region of shared RAM used for data transfer & control information
+ * - a doorbell interrupt register, so both sides can give each other
+ *   interrupts
+ * - a number of DMA channels for transferring data
+ *
+ */
+
+#ifndef SOLO_H
+#define SOLO_H
+
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/io.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/timer.h>
+#include <linux/ptrace.h>
+#include <linux/errno.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/poll.h>
+#include <linux/mutex.h>
+#include <linux/nshield_solo.h>
+
+/* Sizes of some regions */
+
+/*
+ * This is the minimum size of shared RAM. In future it may be possible to
+ * negotiate larger sizes of shared RAM or auto-detect how big it is
+ */
+#define NFPCI_RAM_MINSIZE		    0x00100000
+#define NFPCI_RAM_MINSIZE_JOBS		    0x00020000 /* standard jobs only */
+/* standard and kernel jobs */
+#define NFPCI_RAM_MINSIZE_KERN		    0x00040000
+
+/*
+ * Offsets within shared memory space.
+ * The following main regions are:
+ *   jobs input area
+ *   jobs output area
+ *   kernel jobs input area
+ *   kernel output area
+ */
+
+#define NFPCI_OFFSET_JOBS		    0x00000000
+#define NFPCI_OFFSET_JOBS_WR		    0x00000000
+#define NFPCI_OFFSET_JOBS_RD		    0x00010000
+#define NFPCI_OFFSET_KERN		    0x00020000
+#define NFPCI_OFFSET_KERN_WR		    0x00020000
+#define NFPCI_OFFSET_KERN_RD		    0x00030000
+
+/* Interrupts, defined by bit position in doorbell register */
+
+/* Interrupts from device to host */
+#define NFAST_INT_DEVICE_WRITE_OK	    0x00000001
+#define NFAST_INT_DEVICE_WRITE_FAILED	    0x00000002
+#define NFAST_INT_DEVICE_READ_OK	    0x00000004
+#define NFAST_INT_DEVICE_READ_FAILED	    0x00000008
+#define NFAST_INT_DEVICE_KERN_WRITE_OK	    0x00000010
+#define NFAST_INT_DEVICE_KERN_WRITE_FAILED  0x00000020
+#define NFAST_INT_DEVICE_KERN_READ_OK	    0x00000040
+#define NFAST_INT_DEVICE_KERN_READ_FAILED   0x00000080
+
+/* Interrupts from host to device */
+#define NFAST_INT_HOST_WRITE_REQUEST	    0x00010000
+#define NFAST_INT_HOST_READ_REQUEST	    0x00020000
+#define NFAST_INT_HOST_DEBUG		    0x00040000
+#define NFAST_INT_HOST_KERN_WRITE_REQUEST   0x00080000
+#define NFAST_INT_HOST_KERN_READ_REQUEST    0x00100000
+
+/* Ordinary job submission */
+
+/*
+ * The NFPCI_OFFSET_JOBS_WR and NFPCI_OFFSET_JOBS_RD regions
+ * are defined by the following (byte) address offsets.
+ */
+
+#define NFPCI_OFFSET_CONTROL		    0x0
+#define NFPCI_OFFSET_LENGTH		    0x4
+#define NFPCI_OFFSET_DATA		    0x8
+#define NFPCI_OFFSET_PUSH_ADDR		    0x8
+#define NFPCI_OFFSET_PULL_ADDR		    0x8
+
+#define NFPCI_JOBS_WR_CONTROL		    (NFPCI_OFFSET_JOBS_WR + \
+					     NFPCI_OFFSET_CONTROL)
+#define NFPCI_JOBS_WR_LENGTH		    (NFPCI_OFFSET_JOBS_WR + \
+					     NFPCI_OFFSET_LENGTH)
+#define NFPCI_JOBS_WR_DATA		    (NFPCI_OFFSET_JOBS_WR + \
+					     NFPCI_OFFSET_DATA)
+/* address in PCI space of host buffer for NFPCI_JOB_CONTROL_PCI_PUSH */
+#define NFPCI_JOBS_WR_PULL_ADDR		    (NFPCI_OFFSET_JOBS_WR + \
+					     NFPCI_OFFSET_PULL_ADDR)
+#define NFPCI_MAX_JOBS_WR_LEN		    (0x0000FFF8)
+
+#define NFPCI_JOBS_RD_CONTROL		    (NFPCI_OFFSET_JOBS_RD + \
+					     NFPCI_OFFSET_CONTROL)
+#define NFPCI_JOBS_RD_LENGTH		    (NFPCI_OFFSET_JOBS_RD + \
+					     NFPCI_OFFSET_LENGTH)
+#define NFPCI_JOBS_RD_DATA		    (NFPCI_OFFSET_JOBS_RD + \
+					     NFPCI_OFFSET_DATA)
+/* address in PCI space of host buffer for NFPCI_JOB_CONTROL_PCI_PUSH */
+#define NFPCI_JOBS_RD_PUSH_ADDR		    (NFPCI_OFFSET_JOBS_RD + \
+					     NFPCI_OFFSET_PUSH_ADDR)
+#define NFPCI_MAX_JOBS_RD_LEN		    (0x000FFF8)
+
+/* Kernel interface job submission */
+
+#define NFPCI_KERN_WR_CONTROL		    (NFPCI_OFFSET_KERN_WR + \
+					     NFPCI_OFFSET_CONTROL)
+#define NFPCI_KERN_WR_LENGTH		    (NFPCI_OFFSET_KERN_WR + \
+					     NFPCI_OFFSET_LENGTH)
+#define NFPCI_KERN_WR_DATA		    (NFPCI_OFFSET_KERN_WR + \
+					     NFPCI_OFFSET_DATA)
+/* address in PCI space of host buffer for NFPCI_JOB_CONTROL_PCI_PUSH */
+#define NFPCI_KERN_WR_PULL_ADDR		    (NFPCI_OFFSET_KERN_WR + \
+					     NFPCI_OFFSET_PULL_ADDR)
+#define NFPCI_MAX_KERN_WR_LEN	            (0x0000FFF8)
+
+#define NFPCI_KERN_RD_CONTROL		    (NFPCI_OFFSET_KERN_RD + \
+					     NFPCI_OFFSET_CONTROL)
+#define NFPCI_KERN_RD_LENGTH		    (NFPCI_OFFSET_KERN_RD + \
+					     NFPCI_OFFSET_LENGTH)
+#define NFPCI_KERN_RD_DATA		    (NFPCI_OFFSET_KERN_RD + \
+					     NFPCI_OFFSET_DATA)
+/* address in PCI space of host buffer for NFPCI_JOB_CONTROL_PCI_PUSH */
+#define NFPCI_KERN_RD_PUSH_ADDR		    (NFPCI_OFFSET_KERN_RD + \
+					     NFPCI_OFFSET_PUSH_ADDR)
+#define NFPCI_MAX_KERN_RD_LEN		    (0x000FFF8)
+
+#define NFPCI_JOB_CONTROL		    0x00000001
+#define NFPCI_JOB_CONTROL_PCI_PUSH	    0x00000002
+#define NFPCI_JOB_CONTROL_PCI_PULL	    0x00000003
+
+/*
+ * The 'Control' word is analogous to the SCSI read/write address;
+ * 1 = standard push/pull I/O
+ * 2 = push/push I/O
+ * 3 = pull/push I/O
+ *
+ * To submit a block of job data, the host:
+ * - sets the (32-bit, little-endian) word at NFPCI_JOBS_WR_CONTROL to
+ * NFPCI_JOB_CONTROL
+ * - sets the word at NFPCI_JOBS_WR_LENGTH to the length of the data
+ * - copies the data to NFPCI_JOBS_WR_DATA
+ * - sets interrupt NFAST_INT_HOST_WRITE_REQUEST in the doorbell register
+ * - awaits the NFAST_INT_DEVICE_WRITE_OK (or _FAILED) interrupts back
+ *
+ * To read a block of jobs back, the host:
+ * - sets the word at NFPCI_JOBS_RD_CONTROL to NFPCI_JOB_CONTROL
+ * - sets the word at NFPCI_JOBS_RD_LENGTH to the max length for returned data
+ * - sets interrupt NFAST_INT_HOST_READ_REQUEST
+ * - awaits the NFAST_INT_DEVICE_READ_OK (or _FAILED) interrupt
+ * - reads the data from NFPCI_JOBS_RD_DATA; the module will set the word at
+ * NFPCI_JOBS_RD_LENGTH to its actual length.
+ *
+ * Optionally the host can request the PCI read data to be pushed to host PCI
+ * mapped ram:
+ * - allocates a contiguous PCI addressable buffer for a NFPCI_JOBS_BLOCK of
+ * max size NFPCI_MAX_JOBS_RD_LEN (or NFPCI_MAX_KERN_RD_LEN) + 8
+ * - sets the word at NFPCI_JOBS_RD_CONTROL to NFPCI_JOB_CONTROL_PCI_PUSH
+ * - sets the word at NFPCI_JOBS_RD_LENGTH to the max length for returned data
+ * - sets the word at NFPCI_JOBS_RD_PUSH_ADDR to be the host PCI address of
+ * the buffer
+ * - sets interrupt NFAST_INT_HOST_READ_REQUEST
+ * - awaits the NFAST_INT_DEVICE_READ_OK (or _FAILED) interrupt
+ * - reads the data from the buffer at NFPCI_OFFSET_DATA in the buffer. The
+ * module will set NFPCI_OFFSET_LENGTH to the actual length.
+ *
+ * Optionally the host can request the PCI write data to be pulled from host
+ * PCI mapped ram:
+ * - allocates a contiguous PCI addressable buffer for a NFPCI_JOBS_BLOCK of
+ * max size NFPCI_MAX_JOBS_WR_LEN (or NFPCI_MAX_KERN_WR_LEN) + 8
+ * - copies the data to the PCI addressable buffer
+ * - sets the word at NFPCI_JOBS_WR_CONTROL to NFPCI_JOB_CONTROL_PCI_PULL
+ * - sets the word at NFPCI_JOBS_WR_LENGTH to the length of the data
+ * - sets the word at NFPCI_JOBS_RD_PULL_ADDR to be the host PCI address of
+ * the buffer
+ * - sets interrupt NFAST_INT_HOST_WRITE_REQUEST in the doorbell register
+ * - awaits the NFAST_INT_DEVICE_WRITE_OK (or _FAILED) interrupts back
+ */
+
+#define NFPCI_SCRATCH_CONTROL		    0
+
+#define NFPCI_SCRATCH_CONTROL_HOST_MOI	    (0x1)
+#define NFPCI_SCRATCH_CONTROL_MODE_SHIFT    1
+#define NFPCI_SCRATCH_CONTROL_MODE_MASK	    (3 << \
+					     NFPCI_SCRATCH_CONTROL_MODE_SHIFT)
+
+#define NFPCI_SCRATCH_STATUS		    1
+
+#define NFPCI_SCRATCH_STATUS_MONITOR_MOI         (0x1)
+#define NFPCI_SCRATCH_STATUS_APPLICATION_MOI     (0x2)
+#define NFPCI_SCRATCH_STATUS_APPLICATION_RUNNING (0x4)
+#define NFPCI_SCRATCH_STATUS_ERROR               (0x8)
+
+#define NFPCI_SCRATCH_ERROR_LO		    2
+#define NFPCI_SCRATCH_ERROR_HI		    3
+
+#define NFP_BARSIZES_COUNT 6
+/*
+ * This masks off the bottom bits of the PCI_CSR_BAR which signify that the
+ * BAR is an IO BAR rather than a MEM BAR
+ */
+#define NFP_BARSIZES_MASK ~0xF
+
+/* per-instance device structure */
+struct nfp_dev {
+	/* downward facing part of the device interface */
+	void __iomem *bar[NFP_BARSIZES_COUNT];
+	void *extra[NFP_BARSIZES_COUNT];
+	int busno;
+	int slotno;
+	struct nfp_dev *cmdctx;
+	char *iobuf;
+	int active_bar;
+	int created;
+	int conn_status;
+	int detection_type;
+	int iosize[6];
+	u32 irq;
+	struct nfpcmd_dev const *cmddev;
+	struct nfdev_stats_str stats;
+
+	/* upward facing part of the device interface */
+	u8 *read_buf;
+	dma_addr_t read_dma;
+
+	u8 *write_buf;
+	dma_addr_t write_dma;
+
+	struct pci_dev *pcidev;
+
+	atomic_t busy;
+	int ifvers;
+	struct timer_list rd_timer;
+
+	wait_queue_head_t rd_queue;
+	unsigned long rd_ready;
+	unsigned long rd_outstanding;
+	int rd_ok;
+
+	wait_queue_head_t wr_queue;
+	unsigned long wr_ready;
+	unsigned long wr_outstanding;
+	int wr_ok;
+
+	struct mutex ioctl_mutex;  /* lock across ioctl */
+};
+
+/* Per-device-type command handlers */
+struct nfpcmd_dev {
+	const char *name;
+	u16 vendorid, deviceid, sub_vendorid, sub_deviceid;
+	u32 bar_sizes[NFP_BARSIZES_COUNT]; /* includes IO bit */
+	u32 flags, max_ifvers;
+
+	int (*create)(struct nfp_dev *ndev);
+	int (*destroy)(struct nfp_dev *ctx);
+	int (*open)(struct nfp_dev *ctx);
+	int (*close)(struct nfp_dev *ctx);
+	int (*isr)(struct nfp_dev *ctx, int *handled);
+	int (*write_block)(u32 addr,
+			   const char __user *ublock, int len,
+			   struct nfp_dev *ctx);
+	int (*read_block)(char __user *ublock,
+			  int len, struct nfp_dev *ctx, int *rcount);
+	int (*ensure_reading)(dma_addr_t addr, int len, struct nfp_dev *ctx);
+	int (*setcontrol)(const struct nfdev_control_str *control,
+			  struct nfp_dev *ctx); /* may be NULL */
+	int (*getstatus)(struct nfdev_status_str *status,
+			 struct nfp_dev *ctx); /* may be NULL */
+};
+
+/* These instances are defined in the per-board driver modules */
+extern const struct nfpcmd_dev i21555_cmddev;
+extern const struct nfpcmd_dev fsl_t1022_cmddev;
+
+#define NFP_CMD_FLG_NEED_MSI   0x2
+
+#ifndef PCI_BASE_ADDRESS_SPACE_PREFETCHABLE
+#define PCI_BASE_ADDRESS_SPACE_PREFETCHABLE 0x8
+#endif
+
+/* callbacks from command drivers */
+void nfp_read_complete(struct nfp_dev *ndev, int ok);
+void nfp_write_complete(struct nfp_dev *ndev, int ok);
+
+/* status codes */
+#define NFP_HSM_STARTING 1 /* The HSM hasn't readied its PCI interface yet */
+#define NFP_HSM_POLLING	2 /* The HSM's EPD will use polling */
+
+/* error conversions table */
+struct errstr {
+	int oserr;
+	int nferr;
+};
+
+extern struct errstr errtab[];
+
+#endif /* SOLO_H */
diff --git a/include/uapi/linux/nshield_solo.h b/include/uapi/linux/nshield_solo.h
new file mode 100644
index 000000000000..1691e3f23007
--- /dev/null
+++ b/include/uapi/linux/nshield_solo.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ *
+ * nshield_solo.h: UAPI header for driving the nCipher PCI HSMs using the
+ * nshield_solo module
+ */
+#ifndef _UAPI_NSHIELD_SOLO_H_
+#define _UAPI_NSHIELD_SOLO_H_
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* Device ioctl struct definitions */
+
+/* Result of the ENQUIRY ioctl. */
+struct nfdev_enquiry_str {
+	__u32 busno;			/* Which bus is the PCI device on. */
+	__u8 slotno;			/* Which slot is the PCI device in. */
+	__u8 reserved[3];		/* for consistent struct alignment */
+};
+
+/* Result of the STATS ioctl. */
+struct nfdev_stats_str {
+	__u32 isr;			/* Count interrupts. */
+	__u32 isr_read;			/* Count read interrupts. */
+	__u32 isr_write;		/* Count write interrupts. */
+	__u32 write_fail;		/* Count write failures. */
+	__u32 write_block;		/* Count blocks written. */
+	__u32 write_byte;		/* Count bytes written. */
+	__u32 read_fail;		/* Count read failures. */
+	__u32 read_block;		/* Count blocks read. */
+	__u32 read_byte;		/* Count bytes read. */
+	__u32 ensure_fail;		/* Count read request failures. */
+	__u32 ensure;			/* Count read requests. */
+};
+
+/* Result of the STATUS ioctl. */
+struct nfdev_status_str {
+	__u32 status;			/* Status flags. */
+	char error[8];			/* Error string. */
+};
+
+/* Input to the CONTROL ioctl. */
+struct nfdev_control_str {
+	__u32 control;			/* Control flags. */
+};
+
+/**
+ * Index of control bits indicating desired mode
+ *
+ * Desired mode follows the M_ModuleMode enumeration.
+ */
+#define NFDEV_CONTROL_MODE_SHIFT	1
+
+/* Monitor firmware supports MOI control and error reporting */
+#define NFDEV_STATUS_MONITOR_MOI	0x0001
+
+/* Application firmware supports MOI control and error reporting */
+#define NFDEV_STATUS_APPLICATION_MOI	0x0002
+
+/* Application firmware running and supports error reporting */
+#define NFDEV_STATUS_APPLICATION_RUNNING 0x0004
+
+/**
+ * HSM failed
+ *
+ * Consult error[] for additional information.
+ */
+#define NFDEV_STATUS_FAILED		0x0008
+
+/* Standard PCI interface. */
+#define NFDEV_IF_STANDARD		0x01
+
+/* PCI interface with read replies pushed from device via DMA. */
+#define NFDEV_IF_PCI_PUSH		0x02
+
+/**
+ * PCI interface with read replies pushed from device and write requests
+ * pulled from host via DMA.
+ */
+#define NFDEV_IF_PCI_PULL		0x03
+
+/* Maximum PCI interface. */
+#define NFDEV_IF_MAX_VERS		NFDEV_IF_PCI_PUSH_PULL
+
+/* platform independent base ioctl numbers */
+
+enum {
+	/**
+	 * Enquiry ioctl.
+	 * return nfdev_enquiry_str describing the attached device.
+	 */
+	NFDEV_IOCTL_NUM_ENQUIRY = 1,
+
+	/**
+	 * Ensure Reading ioctl.
+	 * Signal a read request to the device.
+	 * param (unsigned int) Length of data to be read.
+	 */
+	NFDEV_IOCTL_NUM_ENSUREREADING = 3,
+
+	/**
+	 * Device Count ioctl.
+	 * Not implemented for on all platforms.
+	 * return (int) the number of attached devices.
+	 */
+	NFDEV_IOCTL_NUM_DEVCOUNT = 4,
+
+	/**
+	 * PCI Interface Version ioctl.
+	 * param (int) Maximum PCI interface version
+	 * supported by the user of the device.
+	 */
+	NFDEV_IOCTL_NUM_PCI_IFVERS = 6,
+
+	/**
+	 * Statistics ioctl.
+	 * return nfdev_enquiry_str describing the attached device.
+	 */
+	NFDEV_IOCTL_NUM_STATS = 7,
+
+	/**
+	 * Module control ioctl
+	 * param (nfdev_control_str) Value to write to HSM
+	 * control register
+	 */
+	NFDEV_IOCTL_NUM_CONTROL = 8,
+
+	/**
+	 * Module state ioctl
+	 * return (nfdev_status_str) Values read from HSM
+	 * status/error registers
+	 */
+	NFDEV_IOCTL_NUM_STATUS = 9,
+};
+
+#define NFDEV_IOCTL_TYPE 0x10
+
+#define NFDEV_IOCTL_ENQUIRY                                                    \
+	_IOR(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_ENQUIRY,                        \
+	     struct nfdev_enquiry_str)
+
+#define NFDEV_IOCTL_ENSUREREADING                                              \
+	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_ENSUREREADING, int)
+
+#define NFDEV_IOCTL_PCI_IFVERS                                                 \
+	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_PCI_IFVERS, int)
+
+#define NFDEV_IOCTL_STATS                                                      \
+	_IOR(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_STATS, struct nfdev_stats_str)
+
+#define NFDEV_IOCTL_CONTROL                                                    \
+	_IOW(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_CONTROL,                        \
+	     const struct nfdev_control_str)
+
+#define NFDEV_IOCTL_STATUS                                                     \
+	_IOR(NFDEV_IOCTL_TYPE, NFDEV_IOCTL_NUM_STATUS, struct nfdev_status_str)
+
+#endif /* _UAPI_NSHIELD_SOLO_H_ */
-- 
2.24.1



David Kim
Senior Software Engineer
Tel: +44 1223 703449

nCipher Security
One Station Square
Cambridge CB1 2GA
United Kingdom

