Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7F8C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2397C2080C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbfFGLO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:14:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:11659 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727754AbfFGLO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:14:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2019 04:14:55 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Jun 2019 04:14:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 257EF526; Fri,  7 Jun 2019 14:14:51 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Peter Bowen <pzb@amazon.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] thunderbolt: Implement CIO reset correctly for Titan Ridge
Date:   Fri,  7 Jun 2019 14:14:51 +0300
Message-Id: <20190607111451.59648-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When starting ICM firmware on Apple systems we need to perform CIO reset
as part of the flow. However, it turns out that the reset register has
changed to another location in Titan Ridge.

Fix this by introducing ->cio_reset() callback with corresponding
implementations for Alpine and Titan Ridge.

Fixes: 4630d6ae6e3 ("thunderbolt: Start firmware on Titan Ridge Apple systems")
Reported-by: Peter Bowen <pzb@amazon.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c | 134 +++++++++++++++++++++-----------------
 1 file changed, 74 insertions(+), 60 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 40a8960b9a7e..fbdcef56a676 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -56,6 +56,7 @@
  * @max_boot_acl: Maximum number of preboot ACL entries (%0 if not supported)
  * @rpm: Does the controller support runtime PM (RTD3)
  * @is_supported: Checks if we can support ICM on this controller
+ * @cio_reset: Trigger CIO reset
  * @get_mode: Read and return the ICM firmware mode (optional)
  * @get_route: Find a route string for given switch
  * @save_devices: Ask ICM to save devices to ACL when suspending (optional)
@@ -74,6 +75,7 @@ struct icm {
 	bool safe_mode;
 	bool rpm;
 	bool (*is_supported)(struct tb *tb);
+	int (*cio_reset)(struct tb *tb);
 	int (*get_mode)(struct tb *tb);
 	int (*get_route)(struct tb *tb, u8 link, u8 depth, u64 *route);
 	void (*save_devices)(struct tb *tb);
@@ -166,6 +168,65 @@ static inline u64 get_parent_route(u64 route)
 	return depth ? route & ~(0xffULL << (depth - 1) * TB_ROUTE_SHIFT) : 0;
 }
 
+static int pci2cio_wait_completion(struct icm *icm, unsigned long timeout_msec)
+{
+	unsigned long end = jiffies + msecs_to_jiffies(timeout_msec);
+	u32 cmd;
+
+	do {
+		pci_read_config_dword(icm->upstream_port,
+				      icm->vnd_cap + PCIE2CIO_CMD, &cmd);
+		if (!(cmd & PCIE2CIO_CMD_START)) {
+			if (cmd & PCIE2CIO_CMD_TIMEOUT)
+				break;
+			return 0;
+		}
+
+		msleep(50);
+	} while (time_before(jiffies, end));
+
+	return -ETIMEDOUT;
+}
+
+static int pcie2cio_read(struct icm *icm, enum tb_cfg_space cs,
+			 unsigned int port, unsigned int index, u32 *data)
+{
+	struct pci_dev *pdev = icm->upstream_port;
+	int ret, vnd_cap = icm->vnd_cap;
+	u32 cmd;
+
+	cmd = index;
+	cmd |= (port << PCIE2CIO_CMD_PORT_SHIFT) & PCIE2CIO_CMD_PORT_MASK;
+	cmd |= (cs << PCIE2CIO_CMD_CS_SHIFT) & PCIE2CIO_CMD_CS_MASK;
+	cmd |= PCIE2CIO_CMD_START;
+	pci_write_config_dword(pdev, vnd_cap + PCIE2CIO_CMD, cmd);
+
+	ret = pci2cio_wait_completion(icm, 5000);
+	if (ret)
+		return ret;
+
+	pci_read_config_dword(pdev, vnd_cap + PCIE2CIO_RDDATA, data);
+	return 0;
+}
+
+static int pcie2cio_write(struct icm *icm, enum tb_cfg_space cs,
+			  unsigned int port, unsigned int index, u32 data)
+{
+	struct pci_dev *pdev = icm->upstream_port;
+	int vnd_cap = icm->vnd_cap;
+	u32 cmd;
+
+	pci_write_config_dword(pdev, vnd_cap + PCIE2CIO_WRDATA, data);
+
+	cmd = index;
+	cmd |= (port << PCIE2CIO_CMD_PORT_SHIFT) & PCIE2CIO_CMD_PORT_MASK;
+	cmd |= (cs << PCIE2CIO_CMD_CS_SHIFT) & PCIE2CIO_CMD_CS_MASK;
+	cmd |= PCIE2CIO_CMD_WRITE | PCIE2CIO_CMD_START;
+	pci_write_config_dword(pdev, vnd_cap + PCIE2CIO_CMD, cmd);
+
+	return pci2cio_wait_completion(icm, 5000);
+}
+
 static bool icm_match(const struct tb_cfg_request *req,
 		      const struct ctl_pkg *pkg)
 {
@@ -838,6 +899,11 @@ icm_fr_xdomain_disconnected(struct tb *tb, const struct icm_pkg_header *hdr)
 	}
 }
 
+static int icm_tr_cio_reset(struct tb *tb)
+{
+	return pcie2cio_write(tb_priv(tb), TB_CFG_SWITCH, 0, 0x777, BIT(1));
+}
+
 static int
 icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 		    size_t *nboot_acl, bool *rpm)
@@ -1244,6 +1310,11 @@ static bool icm_ar_is_supported(struct tb *tb)
 	return false;
 }
 
+static int icm_ar_cio_reset(struct tb *tb)
+{
+	return pcie2cio_write(tb_priv(tb), TB_CFG_SWITCH, 0, 0x50, BIT(9));
+}
+
 static int icm_ar_get_mode(struct tb *tb)
 {
 	struct tb_nhi *nhi = tb->nhi;
@@ -1481,65 +1552,6 @@ __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 	return -ETIMEDOUT;
 }
 
-static int pci2cio_wait_completion(struct icm *icm, unsigned long timeout_msec)
-{
-	unsigned long end = jiffies + msecs_to_jiffies(timeout_msec);
-	u32 cmd;
-
-	do {
-		pci_read_config_dword(icm->upstream_port,
-				      icm->vnd_cap + PCIE2CIO_CMD, &cmd);
-		if (!(cmd & PCIE2CIO_CMD_START)) {
-			if (cmd & PCIE2CIO_CMD_TIMEOUT)
-				break;
-			return 0;
-		}
-
-		msleep(50);
-	} while (time_before(jiffies, end));
-
-	return -ETIMEDOUT;
-}
-
-static int pcie2cio_read(struct icm *icm, enum tb_cfg_space cs,
-			 unsigned int port, unsigned int index, u32 *data)
-{
-	struct pci_dev *pdev = icm->upstream_port;
-	int ret, vnd_cap = icm->vnd_cap;
-	u32 cmd;
-
-	cmd = index;
-	cmd |= (port << PCIE2CIO_CMD_PORT_SHIFT) & PCIE2CIO_CMD_PORT_MASK;
-	cmd |= (cs << PCIE2CIO_CMD_CS_SHIFT) & PCIE2CIO_CMD_CS_MASK;
-	cmd |= PCIE2CIO_CMD_START;
-	pci_write_config_dword(pdev, vnd_cap + PCIE2CIO_CMD, cmd);
-
-	ret = pci2cio_wait_completion(icm, 5000);
-	if (ret)
-		return ret;
-
-	pci_read_config_dword(pdev, vnd_cap + PCIE2CIO_RDDATA, data);
-	return 0;
-}
-
-static int pcie2cio_write(struct icm *icm, enum tb_cfg_space cs,
-			  unsigned int port, unsigned int index, u32 data)
-{
-	struct pci_dev *pdev = icm->upstream_port;
-	int vnd_cap = icm->vnd_cap;
-	u32 cmd;
-
-	pci_write_config_dword(pdev, vnd_cap + PCIE2CIO_WRDATA, data);
-
-	cmd = index;
-	cmd |= (port << PCIE2CIO_CMD_PORT_SHIFT) & PCIE2CIO_CMD_PORT_MASK;
-	cmd |= (cs << PCIE2CIO_CMD_CS_SHIFT) & PCIE2CIO_CMD_CS_MASK;
-	cmd |= PCIE2CIO_CMD_WRITE | PCIE2CIO_CMD_START;
-	pci_write_config_dword(pdev, vnd_cap + PCIE2CIO_CMD, cmd);
-
-	return pci2cio_wait_completion(icm, 5000);
-}
-
 static int icm_firmware_reset(struct tb *tb, struct tb_nhi *nhi)
 {
 	struct icm *icm = tb_priv(tb);
@@ -1560,7 +1572,7 @@ static int icm_firmware_reset(struct tb *tb, struct tb_nhi *nhi)
 	iowrite32(val, nhi->iobase + REG_FW_STS);
 
 	/* Trigger CIO reset now */
-	return pcie2cio_write(icm, TB_CFG_SWITCH, 0, 0x50, BIT(9));
+	return icm->cio_reset(tb);
 }
 
 static int icm_firmware_start(struct tb *tb, struct tb_nhi *nhi)
@@ -2027,6 +2039,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_2C_NHI:
 		icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
 		icm->is_supported = icm_ar_is_supported;
+		icm->cio_reset = icm_ar_cio_reset;
 		icm->get_mode = icm_ar_get_mode;
 		icm->get_route = icm_ar_get_route;
 		icm->save_devices = icm_fr_save_devices;
@@ -2042,6 +2055,7 @@ struct tb *icm_probe(struct tb_nhi *nhi)
 	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		icm->max_boot_acl = ICM_AR_PREBOOT_ACL_ENTRIES;
 		icm->is_supported = icm_ar_is_supported;
+		icm->cio_reset = icm_tr_cio_reset;
 		icm->get_mode = icm_ar_get_mode;
 		icm->driver_ready = icm_tr_driver_ready;
 		icm->device_connected = icm_tr_device_connected;
-- 
2.20.1

