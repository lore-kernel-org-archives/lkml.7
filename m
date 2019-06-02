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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7EFC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C8B278BB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXMoMrcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFBQNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:13:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54419 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfFBQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:12:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id g135so5745685wme.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=ARcUEg6GQSTh3itflHRlhmyOJAPvpwjIkcYWULy8WhQ=;
        b=aXMoMrcut3LCjBu7UtkYdYx/60h2FGMsx8nMrifMCSBkoHX1k8rK+6YT403hs7T1ng
         n9ApVVMSgaLyrey5EXCzsEPfdb17TW2ietAod3AtjHgOFsRWXape4Yj0R4J4NOOj3r4o
         Ov0q7qhXOK5BtCGovAZSdrcB376xo9TtTKhnMl+42l/Q4td2nVKLgU3zo7O+JLQnJzaL
         t8K2pKA8UhemHSHMbm+3z1+PbuuJt1nr8nVE62dINjXddiSXT9K7R334k9X3pCVSr9OV
         RGKWi0FEHYSqpjOv7BcllUCHgf+ToMzTr/7KQh2uUCoGakX2+w1XyD6rctU8OyZ+dTLl
         yTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=ARcUEg6GQSTh3itflHRlhmyOJAPvpwjIkcYWULy8WhQ=;
        b=h/6k0DpqoFKt9NdfZSboTnkipp7RE5QyZK8RSZ091gHMpKGp20iasM4j0u2tlsCu9u
         b5pNfyoJMkrHy1E7DLmrj/P8yndZJu8b8KNdc7f/6V+fB3yXV+DFEDnAjGowSN841daD
         sTSJJQ3V9YvnKdSSHhhpZSWDEew2Inu7V2MV8XkSsgW5g9NxVQguVrPlgEvELGJ5BK82
         Gz0uN0HE1qw/7NBKAoLmO+Ltsg0j17IuRERqNaulFyl3p0hv0I52LyTg6fdQPfl30nfD
         duB3j0SLEz7V2v4oqXtB4oX7q4MpWI7BrhaQN3burWMlBQzjgfuCN0R6g6iqez7YOJZY
         Ysjw==
X-Gm-Message-State: APjAAAXpHWzWNyd3Gtyn1batMVPLu1Y1vFOXqiOBU7OJHQeBeSdFiKrT
        xy8xMenfpMPB8PMmjurXTwDKZMOPlb//Ag==
X-Google-Smtp-Source: APXvYqwkSZvT0wxU9eOxMvLTgYiNAJFmas9KwCK6wOUs2ah1kxoFQ3wuKd7PgtZqJS8H5TszF3zwZg==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr12012672wmi.116.1559491976549;
        Sun, 02 Jun 2019 09:12:56 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98712670014A3D3D52C57F0B4.dip0.t-ipconnect.de. [2003:c9:8712:6700:14a3:d3d5:2c57:f0b4])
        by smtp.gmail.com with ESMTPSA id 16sm8649783wmx.45.2019.06.02.09.12.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 09:12:55 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] pci: hotplug: Replace function names with __func__ Macro
Date:   Sun,  2 Jun 2019 18:12:46 +0200
Message-Id: <20190602161254.31521-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace hardcoded function names with __func__ Macro so if the function
name changes we have not to check all Messages and to retain the code
structure.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/pci/hotplug/cpqphp_ctrl.c |  4 ++--
 drivers/pci/hotplug/ibmphp_ebda.c |  4 ++--
 drivers/pci/hotplug/ibmphp_hpc.c  | 15 ++++++++-------
 drivers/pci/hotplug/ibmphp_res.c  |  2 +-
 drivers/pci/hotplug/rpaphp_slot.c |  3 ++-
 5 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index b7f4e1f099d9..4f4e3725566e 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -401,7 +401,7 @@ static struct pci_resource *do_pre_bridge_resource_split(struct pci_resource **h
 	struct pci_resource *split_node;
 	u32 rc;
 	u32 temp_dword;
-	dbg("do_pre_bridge_resource_split\n");
+	dbg("%s\n", __func__);

 	if (!(*head) || !(*orig_head))
 		return NULL;
@@ -2297,7 +2297,7 @@ static u32 configure_new_device(struct controller  *ctrl, struct pci_func  *func
 		}

 	} while (function < max_functions);
-	dbg("returning from configure_new_device\n");
+	dbg("returning from %s\n", __func__);

 	return 0;
 }
diff --git a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
index 7e523ce071b3..7bea904a5203 100644
--- a/drivers/pci/hotplug/ibmphp_ebda.c
+++ b/drivers/pci/hotplug/ibmphp_ebda.c
@@ -130,7 +130,7 @@ static void __init print_bus_info(void)
 static void print_lo_info(void)
 {
 	struct rio_detail *ptr;
-	debug("print_lo_info ----\n");
+	debug("%s ----\n", __func__);
 	list_for_each_entry(ptr, &rio_lo_head, rio_detail_list) {
 		debug("%s - rio_node_id = %x\n", __func__, ptr->rio_node_id);
 		debug("%s - rio_type = %x\n", __func__, ptr->rio_type);
@@ -1112,7 +1112,7 @@ static int ibmphp_probe(struct pci_dev *dev, const struct pci_device_id *ids)
 {
 	struct controller *ctrl;

-	debug("inside ibmphp_probe\n");
+	debug("inside %s\n", __func__);

 	list_for_each_entry(ctrl, &ebda_hpc_head, ebda_hpc_list) {
 		if (ctrl->ctlr_type == 1) {
diff --git a/drivers/pci/hotplug/ibmphp_hpc.c b/drivers/pci/hotplug/ibmphp_hpc.c
index 508a62a6b5f9..6846923b42d3 100644
--- a/drivers/pci/hotplug/ibmphp_hpc.c
+++ b/drivers/pci/hotplug/ibmphp_hpc.c
@@ -350,7 +350,7 @@ static void isa_ctrl_write(struct controller *ctlr_ptr, u8 offset, u8 data)
 static u8 pci_ctrl_read(struct controller *ctrl, u8 offset)
 {
 	u8 data = 0x00;
-	debug("inside pci_ctrl_read\n");
+	debug("inside %s\n", __func__);
 	if (ctrl->ctrl_dev)
 		pci_read_config_byte(ctrl->ctrl_dev, HPC_PCI_OFFSET + offset, &data);
 	return data;
@@ -359,7 +359,7 @@ static u8 pci_ctrl_read(struct controller *ctrl, u8 offset)
 static u8 pci_ctrl_write(struct controller *ctrl, u8 offset, u8 data)
 {
 	u8 rc = -ENODEV;
-	debug("inside pci_ctrl_write\n");
+	debug("inside %s\n", __func__);
 	if (ctrl->ctrl_dev) {
 		pci_write_config_byte(ctrl->ctrl_dev, HPC_PCI_OFFSET + offset, data);
 		rc = 0;
@@ -445,7 +445,7 @@ static u8 hpc_writecmdtoindex(u8 cmd, u8 index)
 		break;

 	default:
-		err("hpc_writecmdtoindex - Error invalid cmd[%x]\n", cmd);
+		err("%s - Error invalid cmd[%x]\n", __func__, cmd);
 		rc = HPC_ERROR;
 	}

@@ -903,7 +903,8 @@ static int process_changeinstatus(struct slot *pslot, struct slot *poldslot)
 	u8 disable = 0;
 	u8 update = 0;

-	debug("process_changeinstatus - Entry pslot[%p], poldslot[%p]\n", pslot, poldslot);
+	debug("%s - Entry pslot[%p], poldslot[%p]\n", __func__, pslot,
+		poldslot);

 	// bit 0 - HPC_SLOT_POWER
 	if ((pslot->status & 0x01) != (poldslot->status & 0x01))
@@ -959,7 +960,7 @@ static int process_changeinstatus(struct slot *pslot, struct slot *poldslot)
 		update = 1;

 	if (disable) {
-		debug("process_changeinstatus - disable slot\n");
+		debug("%s - disable slot\n", __func__);
 		pslot->flag = 0;
 		rc = ibmphp_do_disable_slot(pslot);
 	}
@@ -1071,7 +1072,7 @@ static int hpc_wait_ctlr_notworking(int timeout, struct controller *ctlr_ptr, vo
 	int rc = 0;
 	u8 done = 0;

-	debug_polling("hpc_wait_ctlr_notworking - Entry timeout[%d]\n", timeout);
+	debug_polling("%s - Entry timeout[%d]\n", __func__, timeout);

 	while (!done) {
 		*pstatus = ctrl_read(ctlr_ptr, wpg_bbar, WPG_CTLR_INDEX);
@@ -1091,6 +1092,6 @@ static int hpc_wait_ctlr_notworking(int timeout, struct controller *ctlr_ptr, vo
 				timeout--;
 		}
 	}
-	debug_polling("hpc_wait_ctlr_notworking - Exit rc[%x] status[%x]\n", rc, *pstatus);
+	debug_polling("%s - Exit rc[%x] status[%x]\n", __func__, rc, *pstatus);
 	return rc;
 }
diff --git a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
index 5e8caf7a4452..b12dc0ea04cf 100644
--- a/drivers/pci/hotplug/ibmphp_res.c
+++ b/drivers/pci/hotplug/ibmphp_res.c
@@ -1351,7 +1351,7 @@ int ibmphp_remove_bus(struct bus_node *bus, u8 parent_busno)
 		return -ENODEV;
 	}

-	debug("In ibmphp_remove_bus... prev_bus->busno is %x\n", prev_bus->busno);
+	debug("In %s ... prev_bus->busno is %x\n", __func__, prev_bus->busno);

 	rc = remove_ranges(bus, prev_bus);
 	if (rc)
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 93b4a945c55d..1cbd307df635 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -92,7 +92,8 @@ int rpaphp_register_slot(struct slot *slot)

 	/* should not try to register the same slot twice */
 	if (is_registered(slot)) {
-		err("rpaphp_register_slot: slot[%s] is already registered\n", slot->name);
+		err("%s: slot[%s] is already registered\n", __func__,
+			slot->name);
 		return -EAGAIN;
 	}

--
2.19.1

