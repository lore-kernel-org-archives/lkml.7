Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BCC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B8E2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 04:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="MnuOKR7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfECEAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 00:00:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38046 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfECEAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 00:00:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id b1so4169222otp.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 21:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bemVwThYo9q0n2DK440xU+X442vQzc77GP4hVe0jJ4E=;
        b=MnuOKR7uG7pcPWkW0rMB7/FyUielosvBYmm0XrwCCwnW4LRtq1TtyeVBtpov/f+Oyq
         6mgPbXjtka7FR9CM4Ht5ZxnQJsg9oDOzdBV/cgmtMSbJZ1X78/vkNwYVKVmJm0HBKxnJ
         9v7y+BwJfVo/FGZjua2oTpKv2boZMR/0ilGGA6TaEpJ4vW+JKYKJpdY78BrOUSLsjvxM
         vtYu4ipowTeu/xdDgl/IkFqkAjkj44aep0VIG1zHfuMQo7zr9pIQRoSp93NHmD4abncR
         nZMTsl0GE6RdK1d6Z3L2xVfJT0B7/Qlt1/NWBMR1vWbC1l3LwmY5txCHi/WpIJBVq29q
         2/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bemVwThYo9q0n2DK440xU+X442vQzc77GP4hVe0jJ4E=;
        b=ABqsEIXxZZCRGWawOPSMp3Ixbdf7jKX0glMOUTS/mBSsB3CjJHUj5DVNDNj8c0nav9
         AriMWhD0n9TTujyoElFq/2/wOStSYuKObvu6cyzo3kt2EFwsj4t6b3/hF5hOs9qVX4Hb
         FUMY9OB6HMgeLcGBfN3kbMAsFHtI8O5a0OwdHj7jVVXOurVW3eBwu51d5+Ez32dk4MM7
         2U7LC+wDCZBMyG5Mjm/Ri7s6D8WucXY1B8ZrfrTN0uN3abHR/smdIJDxJHpBkTN5so3W
         Nz/Vh1ge2PBwXWyKe06A6i2jfTH9XDY2HPwUQsl8AI8d2nz4uEFSOvFPPmcF2/z1cYLu
         qgXw==
X-Gm-Message-State: APjAAAVELLMjSa9adWGl9ug33JWBQsaR21GgaILDMiT1OaYmvR/ZM8VT
        e1red95PL6VlxEmMg4R1FizG3n8DsJAUGw==
X-Google-Smtp-Source: APXvYqzevyK5hKzuuX2jq7wn+tEh7BNGFYIuDk83wNoyfY1H+obg1w1W5gHg0HTbDu5owkm/TgdvKQ==
X-Received: by 2002:a9d:7cc3:: with SMTP id r3mr3257835otn.44.1556856031210;
        Thu, 02 May 2019 21:00:31 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id m20sm434952otq.30.2019.05.02.21.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:30 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 6/9] PCI: hotplug: Prefix dmesg logs with PCIe service name
Date:   Thu,  2 May 2019 22:59:43 -0500
Message-Id: <20190503035946.23608-7-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix dmesg logs with PCIe service name.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/hotplug/pciehp.h      | 18 +++++++++---------
 drivers/pci/hotplug/pciehp_core.c |  7 +++++--
 drivers/pci/hotplug/pciehp_ctrl.c |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c  |  4 +++-
 drivers/pci/hotplug/pciehp_pci.c  |  2 ++
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 506e1d923a1f..78325c8d961e 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -34,27 +34,27 @@ extern bool pciehp_debug;
 #define dbg(format, arg...)						\
 do {									\
 	if (pciehp_debug)						\
-		printk(KERN_DEBUG "%s: " format, MY_NAME, ## arg);	\
+		pr_info(format, ## arg);				\
 } while (0)
 #define err(format, arg...)						\
-	printk(KERN_ERR "%s: " format, MY_NAME, ## arg)
+	pr_err(format, ## arg)
 #define info(format, arg...)						\
-	printk(KERN_INFO "%s: " format, MY_NAME, ## arg)
+	pr_info(format, ## arg)
 #define warn(format, arg...)						\
-	printk(KERN_WARNING "%s: " format, MY_NAME, ## arg)
+	pr_warn(format, ## arg)
 
 #define ctrl_dbg(ctrl, format, arg...)					\
 	do {								\
 		if (pciehp_debug)					\
-			dev_printk(KERN_DEBUG, &ctrl->pcie->device,	\
-					format, ## arg);		\
+			pci_info(ctrl->pcie->port,			\
+				 format, ## arg);			\
 	} while (0)
 #define ctrl_err(ctrl, format, arg...)					\
-	dev_err(&ctrl->pcie->device, format, ## arg)
+	pci_err(ctrl->pcie->port, format, ## arg)
 #define ctrl_info(ctrl, format, arg...)					\
-	dev_info(&ctrl->pcie->device, format, ## arg)
+	pci_info(ctrl->pcie->port, format, ## arg)
 #define ctrl_warn(ctrl, format, arg...)					\
-	dev_warn(&ctrl->pcie->device, format, ## arg)
+	pci_warn(ctrl->pcie->port, format, ## arg)
 
 #define SLOT_NAME_SIZE 10
 
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index fc5366b50e95..7e06a0f9e644 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -17,6 +17,9 @@
  *   Dely Sy <dely.l.sy@intel.com>"
  */
 
+#define pr_fmt(fmt) "pciehp: " fmt
+#define dev_fmt pr_fmt
+
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -182,14 +185,14 @@ static int pciehp_probe(struct pcie_device *dev)
 
 	if (!dev->port->subordinate) {
 		/* Can happen if we run out of bus numbers during probe */
-		dev_err(&dev->device,
+		pci_err(dev->port,
 			"Hotplug bridge without secondary bus, ignoring\n");
 		return -ENODEV;
 	}
 
 	ctrl = pcie_init(dev);
 	if (!ctrl) {
-		dev_err(&dev->device, "Controller initialization failed\n");
+		pci_err(dev->port, "Controller initialization failed\n");
 		return -ENODEV;
 	}
 	set_service_data(dev, ctrl);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 3f3df4c29f6e..bf81f977a751 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -13,6 +13,8 @@
  *
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6a2365cd794e..1713b0b08a5e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -12,6 +12,8 @@
  * Send feedback to <greg@kroah.com>,<kristen.c.accardi@intel.com>
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
@@ -233,7 +235,7 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 	} while (delay > 0);
 
 	if (count > 1 && pciehp_debug)
-		printk(KERN_DEBUG "pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
+		pr_info("pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
 			pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
 			PCI_FUNC(devfn), count, step, l);
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index b9c1396db6fe..d17f3bf36f70 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -13,6 +13,8 @@
  *
  */
 
+#define dev_fmt(fmt) "pciehp: " fmt
+
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-- 
2.17.1

