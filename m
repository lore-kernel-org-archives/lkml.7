Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C033EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9026A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557920027;
	bh=v9hzfIKv/HOPTAZyxm0CjdWVH0ZUjVkKX3R9366S29A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2dke0LCwLwQr0LObNmLJoLC4nW2+Hc6tw4pxbc13FUSC3xC8Z5E19E8v1zTsxzhCK
	 pRSIZ0JdCNd4sooqUxqvhIVfypOMQLx69xEYA6XIsK9BuU9lgwPcY9VCZX66eYx+Cn
	 k9EkIR/L43L3RGEIszmm3A4MAeZnCWF12yDuhOVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbfEOLdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733241AbfEOLdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:33:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C1A62084A;
        Wed, 15 May 2019 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557920023;
        bh=v9hzfIKv/HOPTAZyxm0CjdWVH0ZUjVkKX3R9366S29A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDMO+TzkWJb4m+up/jWzRQu/eDXEDThEgQFFMljamI+VLhzkKiOKNM6HIkhTXLwKe
         wo2szQsRiCTmjysnfj+Ka+tQyoL215Eg16XljnI6++v69rJxhpRVpYnSa3w6D2OJQN
         vuOtQKUQg1qnMEzVAjIXRV6W7K+QKbCjeXz5LZJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 5.1 44/46] PCI: hv: Add hv_pci_remove_slots() when we unload the driver
Date:   Wed, 15 May 2019 12:57:08 +0200
Message-Id: <20190515090629.423766314@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.670410738@linuxfoundation.org>
References: <20190515090616.670410738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

commit 15becc2b56c6eda3d9bf5ae993bafd5661c1fad1 upstream.

When we unload the pci-hyperv host controller driver, the host does not
send us a PCI_EJECT message.

In this case we also need to make sure the sysfs PCI slot directory is
removed, otherwise a command on a slot file eg:

"cat /sys/bus/pci/slots/2/address"

will trigger a

"BUG: unable to handle kernel paging request"

and, if we unload/reload the driver several times we would end up with
stale slot entries in PCI slot directories in /sys/bus/pci/slots/

root@localhost:~# ls -rtl  /sys/bus/pci/slots/
total 0
drwxr-xr-x 2 root root 0 Feb  7 10:49 2
drwxr-xr-x 2 root root 0 Feb  7 10:49 2-1
drwxr-xr-x 2 root root 0 Feb  7 10:51 2-2

Add the missing code to remove the PCI slot and fix the current
behaviour.

Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
[lorenzo.pieralisi@arm.com: reformatted the log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/pci-hyperv.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1486,6 +1486,21 @@ static void hv_pci_assign_slots(struct h
 	}
 }
 
+/*
+ * Remove entries in sysfs pci slot directory.
+ */
+static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
+{
+	struct hv_pci_dev *hpdev;
+
+	list_for_each_entry(hpdev, &hbus->children, list_entry) {
+		if (!hpdev->pci_slot)
+			continue;
+		pci_destroy_slot(hpdev->pci_slot);
+		hpdev->pci_slot = NULL;
+	}
+}
+
 /**
  * create_root_hv_pci_bus() - Expose a new root PCI bus
  * @hbus:	Root PCI bus, as understood by this driver
@@ -2680,6 +2695,7 @@ static int hv_pci_remove(struct hv_devic
 		pci_lock_rescan_remove();
 		pci_stop_root_bus(hbus->pci_bus);
 		pci_remove_root_bus(hbus->pci_bus);
+		hv_pci_remove_slots(hbus);
 		pci_unlock_rescan_remove();
 		hbus->state = hv_pcibus_removed;
 	}


