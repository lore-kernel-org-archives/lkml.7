Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8E1C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BFC2796F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk9rlW0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFBQZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:25:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42305 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFBQZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:25:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so2558523wrj.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=/UqyxurJk9eEtzMIXMHJ9qbmnyuH98XzxtxmlAvz/xo=;
        b=Fk9rlW0mvp0qcwyHrY2RbwFl9gGekgSKkF1Cmad+MfJy1kn99PJXIn15cn5NccNSIx
         J611pKMVXTyaVucKYaHPfl/iCJrdt3hcVueegXIQ8a17R7FOwgi1zZdhZu/JbnR8GfyJ
         p8G+qCZf8fnyiOgJ0K+uKfACNYSUkbEbY8XOS/MCI+BhIBqIQBDcFq/NRs83jDDvRlCn
         EAf2V8IGVL4qKjoLqKtbGyB1MKL1C348xrv5YpCpZwBDWX9F/APWo0zuYFZOVzMbuB57
         drW2otmUkc2XJW80VD8EVG6wob9jZNxlC6BDYMM3MJPUhPvEOd7d+dmM0rbPOrweITEH
         Xy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=/UqyxurJk9eEtzMIXMHJ9qbmnyuH98XzxtxmlAvz/xo=;
        b=hxV8IbEZV6oVcVAVtJMooHxcJYGAyei6PYemrMl0Fy/AY3hPyR5bh/hhHWfBmVT4pF
         hsHed8+uexgNZoFEREcvsLXYXjCbLg1u4E1h511oJ9jt3qDSxsyBKni8RARPFa5Y5lwu
         tiq61t7bEjG0rHmN49c1ydF3L0tYV+U+b+7P3tOfSqHdnsGqKgmwDUXSDL5DJkityv2x
         3xKGC//2uIYADfrJJ4vE2FNA5AN3Bg+gOeLBu+ucdZ4Nmnu/4ZHZPIJr5pJ59JOsLiZv
         JKTqV2j26WboOYAb26b/25yUkDhR2yzqZbTxZFZFv+vSBfEdZJfsQ3YShjpV+YtG5S+D
         1Yww==
X-Gm-Message-State: APjAAAVBWb8hmU+wQOgByscyet43/SCqI+dBjf++9/E/ZWO/fUC3gfSr
        PG+WermdjpzwZlzkvt9AqNSrffuWIX1FDg==
X-Google-Smtp-Source: APXvYqzyM59i8JN3JVsd3BdXhYhjDQvZYHfB9oI5D/UScUYZf8ewaUbP4+hGVvVcLUHsuXuqgSm9hw==
X-Received: by 2002:adf:9023:: with SMTP id h32mr13641735wrh.95.1559492748508;
        Sun, 02 Jun 2019 09:25:48 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id q14sm9959907wrw.60.2019.06.02.09.25.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 09:25:47 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Joe Perches <joe@perches.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pci: hotplug: ibmphp: Fix 'line over 80 characters' Warning
Date:   Sun,  2 Jun 2019 18:25:42 +0200
Message-Id: <20190602162546.3470-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl 'line over 80 characters' Warning in ibmphp_ebda.c and
ibmphp_hpc.c

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/ibmphp_ebda.c |   7 +-
 drivers/pci/hotplug/ibmphp_hpc.c  | 107 +++++++++++++++++++-----------
 2 files changed, 75 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 7bea904a5203..fda0d1210a3b 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -1116,10 +1116,13 @@ static int ibmphp_probe(struct pci_dev *dev, const struct pci_device_id *ids)

 	list_for_each_entry(ctrl, &ebda_hpc_head, ebda_hpc_list) {
 		if (ctrl->ctlr_type == 1) {
-			if ((dev->devfn == ctrl->u.pci_ctlr.dev_fun) && (dev->bus->number == ctrl->u.pci_ctlr.bus)) {
+			if ((dev->devfn == ctrl->u.pci_ctlr.dev_fun) &&
+			    (dev->bus->number == ctrl->u.pci_ctlr.bus)) {
 				ctrl->ctrl_dev = dev;
 				debug("found device!!!\n");
-				debug("dev->device = %x, dev->subsystem_device = %x\n", dev->device, dev->subsystem_device);
+				debug("dev->device = %x, "
+				      "dev->subsystem_device = %x\n",
+				      dev->device, dev->subsystem_device);
 				return 0;
 			}
 		}
diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
index 6846923b42d3..e75173db5734 100644
--- a/drivers/pci/hotplug/ibmphp_hpc.c
+++ b/drivers/pci/hotplug/ibmphp_hpc.c
@@ -115,7 +115,8 @@ static int hpc_wait_ctlr_notworking(int, struct controller *, void __iomem *, u8
 * Action:  read from HPC over I2C
 *
 *---------------------------------------------------------------------*/
-static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 index)
+static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar,
+				u8 index)
 {
 	u8 status;
 	int i;
@@ -124,7 +125,8 @@ static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 i
 	unsigned long ultemp;
 	unsigned long data;	// actual data HILO format

-	debug_polling("%s - Entry WPGBbar[%p] index[%x] \n", __func__, WPGBbar, index);
+	debug_polling("%s - Entry WPGBbar[%p] index[%x] \n",
+			__func__, WPGBbar, index);

 	//--------------------------------------------------------------------
 	// READ - step 1
@@ -211,7 +213,8 @@ static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 i

 	status = (u8) data;

-	debug_polling("%s - Exit index[%x] status[%x]\n", __func__, index, status);
+	debug_polling("%s - Exit index[%x] status[%x]\n",
+			__func__, index, status);

 	return (status);
 }
@@ -223,7 +226,8 @@ static u8 i2c_ctrl_read(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 i
 *
 * Return   0 or error codes
 *---------------------------------------------------------------------*/
-static u8 i2c_ctrl_write(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8 index, u8 cmd)
+static u8 i2c_ctrl_write(struct controller *ctlr_ptr, void __iomem *WPGBbar,
+				u8 index, u8 cmd)
 {
 	u8 rc;
 	void __iomem *wpg_addr;	// base addr + offset
@@ -232,7 +236,8 @@ static u8 i2c_ctrl_write(struct controller *ctlr_ptr, void __iomem *WPGBbar, u8
 	unsigned long data;	// actual data HILO format
 	int i;

-	debug_polling("%s - Entry WPGBbar[%p] index[%x] cmd[%x]\n", __func__, WPGBbar, index, cmd);
+	debug_polling("%s - Entry WPGBbar[%p] index[%x] cmd[%x]\n",
+			__func__, WPGBbar, index, cmd);

 	rc = 0;
 	//--------------------------------------------------------------------
@@ -352,7 +357,8 @@ static u8 pci_ctrl_read(struct controller *ctrl, u8 offset)
 	u8 data = 0x00;
 	debug("inside %s\n", __func__);
 	if (ctrl->ctrl_dev)
-		pci_read_config_byte(ctrl->ctrl_dev, HPC_PCI_OFFSET + offset, &data);
+		pci_read_config_byte(ctrl->ctrl_dev, HPC_PCI_OFFSET + offset,
+					&data);
 	return data;
 }

@@ -361,7 +367,8 @@ static u8 pci_ctrl_write(struct controller *ctrl, u8 offset, u8 data)
 	u8 rc = -ENODEV;
 	debug("inside %s\n", __func__);
 	if (ctrl->ctrl_dev) {
-		pci_write_config_byte(ctrl->ctrl_dev, HPC_PCI_OFFSET + offset, data);
+		pci_write_config_byte(ctrl->ctrl_dev, HPC_PCI_OFFSET + offset,
+					data);
 		rc = 0;
 	}
 	return rc;
@@ -387,7 +394,8 @@ static u8 ctrl_read(struct controller *ctlr, void __iomem *base, u8 offset)
 	return rc;
 }

-static u8 ctrl_write(struct controller *ctlr, void __iomem *base, u8 offset, u8 data)
+static u8 ctrl_write(struct controller *ctlr, void __iomem *base, u8 offset,
+			u8 data)
 {
 	u8 rc = 0;
 	switch (ctlr->ctlr_type) {
@@ -510,10 +518,11 @@ int ibmphp_hpc_readslot(struct slot *pslot, u8 cmd, u8 *pstatus)
 	int rc = 0;
 	int busindex;

-	debug_polling("%s - Entry pslot[%p] cmd[%x] pstatus[%p]\n", __func__, pslot, cmd, pstatus);
+	debug_polling("%s - Entry pslot[%p] cmd[%x] pstatus[%p]\n",
+			__func__, pslot, cmd, pstatus);

-	if ((pslot == NULL)
-	    || ((pstatus == NULL) && (cmd != READ_ALLSTAT) && (cmd != READ_BUSSTATUS))) {
+	if ((pslot == NULL) || ((pstatus == NULL) && (cmd != READ_ALLSTAT) &&
+				(cmd != READ_BUSSTATUS))) {
 		rc = -EINVAL;
 		err("%s - Error invalid pointer, rc[%d]\n", __func__, rc);
 		return rc;
@@ -523,7 +532,8 @@ int ibmphp_hpc_readslot(struct slot *pslot, u8 cmd, u8 *pstatus)
 		busindex = ibmphp_get_bus_index(pslot->bus);
 		if (busindex < 0) {
 			rc = -EINVAL;
-			err("%s - Exit Error:invalid bus, rc[%d]\n", __func__, rc);
+			err("%s - Exit Error:invalid bus, rc[%d]\n",
+				__func__, rc);
 			return rc;
 		} else
 			index = (u8) busindex;
@@ -546,22 +556,27 @@ int ibmphp_hpc_readslot(struct slot *pslot, u8 cmd, u8 *pstatus)
 	// map physical address to logical address
 	//--------------------------------------------------------------------
 	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4))
-		wpg_bbar = ioremap(ctlr_ptr->u.wpeg_ctlr.wpegbbar, WPG_I2C_IOREMAP_SIZE);
+		wpg_bbar = ioremap(ctlr_ptr->u.wpeg_ctlr.wpegbbar,
+					WPG_I2C_IOREMAP_SIZE);

 	//--------------------------------------------------------------------
 	// check controller status before reading
 	//--------------------------------------------------------------------
-	rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT, ctlr_ptr, wpg_bbar, &status);
+	rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT, ctlr_ptr,
+					wpg_bbar, &status);
 	if (!rc) {
 		switch (cmd) {
 		case READ_ALLSTAT:
 			// update the slot structure
 			pslot->ctrl->status = status;
 			pslot->status = ctrl_read(ctlr_ptr, wpg_bbar, index);
-			rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT, ctlr_ptr, wpg_bbar,
-						       &status);
+			rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT,
+							ctlr_ptr, wpg_bbar,
+							&status);
 			if (!rc)
-				pslot->ext_status = ctrl_read(ctlr_ptr, wpg_bbar, index + WPG_1ST_EXTSLOT_INDEX);
+				pslot->ext_status = ctrl_read(ctlr_ptr,
+								wpg_bbar,
+								index + WPG_1ST_EXTSLOT_INDEX);

 			break;

@@ -610,7 +625,8 @@ int ibmphp_hpc_readslot(struct slot *pslot, u8 cmd, u8 *pstatus)
 						    ctrl_read(ctlr_ptr, wpg_bbar,
 								index + WPG_1ST_EXTSLOT_INDEX);
 				} else {
-					err("%s - Error ctrl_read failed\n", __func__);
+					err("%s - Error ctrl_read failed\n",
+						__func__);
 					rc = -EINVAL;
 					break;
 				}
@@ -663,7 +679,8 @@ int ibmphp_hpc_writeslot(struct slot *pslot, u8 cmd)
 		busindex = ibmphp_get_bus_index(pslot->bus);
 		if (busindex < 0) {
 			rc = -EINVAL;
-			err("%s - Exit Error:invalid bus, rc[%d]\n", __func__, rc);
+			err("%s - Exit Error:invalid bus, rc[%d]\n",
+				__func__, rc);
 			return rc;
 		} else
 			index = (u8) busindex;
@@ -686,16 +703,19 @@ int ibmphp_hpc_writeslot(struct slot *pslot, u8 cmd)
 	// map physical address to logical address
 	//--------------------------------------------------------------------
 	if ((ctlr_ptr->ctlr_type == 2) || (ctlr_ptr->ctlr_type == 4)) {
-		wpg_bbar = ioremap(ctlr_ptr->u.wpeg_ctlr.wpegbbar, WPG_I2C_IOREMAP_SIZE);
+		wpg_bbar = ioremap(ctlr_ptr->u.wpeg_ctlr.wpegbbar,
+					WPG_I2C_IOREMAP_SIZE);

-		debug("%s - ctlr id[%x] physical[%lx] logical[%lx] i2c[%x]\n", __func__,
-		ctlr_ptr->ctlr_id, (ulong) (ctlr_ptr->u.wpeg_ctlr.wpegbbar), (ulong) wpg_bbar,
-		ctlr_ptr->u.wpeg_ctlr.i2c_addr);
+		debug("%s - ctlr id[%x] physical[%lx] logical[%lx] i2c[%x]\n",
+			__func__, ctlr_ptr->ctlr_id,
+			(ulong) (ctlr_ptr->u.wpeg_ctlr.wpegbbar),
+			(ulong) wpg_bbar, ctlr_ptr->u.wpeg_ctlr.i2c_addr);
 	}
 	//--------------------------------------------------------------------
 	// check controller status before writing
 	//--------------------------------------------------------------------
-	rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT, ctlr_ptr, wpg_bbar, &status);
+	rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT, ctlr_ptr,
+					wpg_bbar, &status);
 	if (!rc) {

 		ctrl_write(ctlr_ptr, wpg_bbar, index, cmd);
@@ -706,7 +726,8 @@ int ibmphp_hpc_writeslot(struct slot *pslot, u8 cmd)
 		timeout = CMD_COMPLETE_TOUT_SEC;
 		done = 0;
 		while (!done) {
-			rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT, ctlr_ptr, wpg_bbar,
+			rc = hpc_wait_ctlr_notworking(HPC_CTLR_WORKING_TOUT,
+							ctlr_ptr, wpg_bbar,
 							&status);
 			if (!rc) {
 				if (NEEDTOCHECK_CMDSTATUS(cmd)) {
@@ -719,7 +740,8 @@ int ibmphp_hpc_writeslot(struct slot *pslot, u8 cmd)
 				msleep(1000);
 				if (timeout < 1) {
 					done = 1;
-					err("%s - Error command complete timeout\n", __func__);
+					err("%s - Error command complete"
+					    "timeout\n", __func__);
 					rc = -EFAULT;
 				} else
 					timeout--;
@@ -831,7 +853,9 @@ static int poll_hpc(void *data)
 				// make a copy of the old status
 				memcpy((void *) &myslot, (void *) pslot,
 					sizeof(struct slot));
-				rc = ibmphp_hpc_readslot(pslot, READ_ALLSTAT, NULL);
+				rc = ibmphp_hpc_readslot(pslot, READ_ALLSTAT,
+							 NULL);
+
 				if ((myslot.status != pslot->status)
 				    || (myslot.ext_status != pslot->ext_status))
 					process_changeinstatus(pslot, &myslot);
@@ -926,7 +950,9 @@ static int process_changeinstatus(struct slot *pslot, struct slot *poldslot)
 	// bit 5 - HPC_SLOT_PWRGD
 	if ((pslot->status & 0x20) != (poldslot->status & 0x20))
 		// OFF -> ON: ignore, ON -> OFF: disable slot
-		if ((poldslot->status & 0x20) && (SLOT_CONNECT(poldslot->status) == HPC_SLOT_CONNECTED) && (SLOT_PRESENT(poldslot->status)))
+		if ((poldslot->status & 0x20) &&
+		    (SLOT_CONNECT(poldslot->status) == HPC_SLOT_CONNECTED)
+		    && (SLOT_PRESENT(poldslot->status)))
 			disable = 1;

 	// bit 6 - HPC_SLOT_BUS_SPEED
@@ -941,7 +967,8 @@ static int process_changeinstatus(struct slot *pslot, struct slot *poldslot)
 				// power goes on and off after closing latch
 				// check again to make sure power is still ON
 				msleep(1000);
-				rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &status);
+				rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
+							 &status);
 				if (SLOT_PWRGD(status))
 					update = 1;
 				else	// overwrite power in pslot to OFF
@@ -950,7 +977,8 @@ static int process_changeinstatus(struct slot *pslot, struct slot *poldslot)
 		}
 		// CLOSE -> OPEN
 		else if ((SLOT_PWRGD(poldslot->status) == HPC_SLOT_PWRGD_GOOD)
-			&& (SLOT_CONNECT(poldslot->status) == HPC_SLOT_CONNECTED) && (SLOT_PRESENT(poldslot->status))) {
+			 && (SLOT_CONNECT(poldslot->status) == HPC_SLOT_CONNECTED)
+			 && (SLOT_PRESENT(poldslot->status))) {
 			disable = 1;
 		}
 		// else - ignore
@@ -968,7 +996,8 @@ static int process_changeinstatus(struct slot *pslot, struct slot *poldslot)
 	if (update || disable)
 		ibmphp_update_slot_info(pslot);

-	debug("%s - Exit rc[%d] disable[%x] update[%x]\n", __func__, rc, disable, update);
+	debug("%s - Exit rc[%d] disable[%x] update[%x]\n", __func__, rc,
+		disable, update);

 	return rc;
 }
@@ -998,13 +1027,17 @@ static int process_changeinlatch(u8 old, u8 new, struct controller *ctrl)
 		if ((mask & old) != (mask & new)) {
 			pslot = ibmphp_get_slot_from_physical_num(i);
 			if (pslot) {
-				memcpy((void *) &myslot, (void *) pslot, sizeof(struct slot));
-				rc = ibmphp_hpc_readslot(pslot, READ_ALLSTAT, NULL);
-				debug("%s - call process_changeinstatus for slot[%d]\n", __func__, i);
+				memcpy((void *) &myslot, (void *) pslot,
+				       sizeof(struct slot));
+				rc = ibmphp_hpc_readslot(pslot, READ_ALLSTAT,
+							 NULL);
+				debug("%s - call process_changeinstatus for"
+				      "slot[%d]\n", __func__, i);
 				process_changeinstatus(pslot, &myslot);
 			} else {
 				rc = -EINVAL;
-				err("%s - Error bad pointer for slot[%d]\n", __func__, i);
+				err("%s - Error bad pointer for slot[%d]\n",
+					__func__, i);
 			}
 		}
 	}
@@ -1066,8 +1099,8 @@ void __exit ibmphp_hpc_stop_poll_thread(void)
 * Return   0, HPC_ERROR
 * Value:
 *---------------------------------------------------------------------*/
-static int hpc_wait_ctlr_notworking(int timeout, struct controller *ctlr_ptr, void __iomem *wpg_bbar,
-				    u8 *pstatus)
+static int hpc_wait_ctlr_notworking(int timeout, struct controller *ctlr_ptr,
+				    void __iomem *wpg_bbar, u8 *pstatus)
 {
 	int rc = 0;
 	u8 done = 0;
--
2.19.1

