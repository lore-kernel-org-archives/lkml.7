Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AD1C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510CE22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033502;
	bh=j4iyNJ4YWmIWaMaDJdTNswZPR5IpthwJe3et10SEop8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qsanKHb+O4Mphgi6+Wy/lGOhDJhvZtTNNwwfM9XbliPyV2ZAt41KT+H0ivX5W271k
	 RmXjY3PRbh60u4EL9E1j2ihD3LJETch7iic/ZQeRE0mVgwlx17iDlC9VoaEh58+XGE
	 yDkTwtLU6tEOZBO1feY3IyhUqLDW4JTdLSiyMZ0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405072AbfGYFpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:45:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391286AbfGYFo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:44:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E7E22BF3;
        Thu, 25 Jul 2019 05:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033496;
        bh=j4iyNJ4YWmIWaMaDJdTNswZPR5IpthwJe3et10SEop8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9yVkVnK2uMoSLEKoVNeTgBxezWw69pMRvjjQFgV0casiKU3Hdh8evCqGfoyCD696
         +Fg98LvfWHze8bxKp7Hzrz6qpWrdZgU8q/OwrNdvq/xmD9nWbIIqIe9qDe5lMDo2a7
         rZvoKRgNtJbuYKV2+JnNX9bjQonYOMXYD/AJRM1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH 4.19 229/271] PCI: hv: Fix a use-after-free bug in hv_eject_device_work()
Date:   Wed, 24 Jul 2019 21:21:38 +0200
Message-Id: <20190724191714.790843380@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

commit 4df591b20b80cb77920953812d894db259d85bd7 upstream.

Fix a use-after-free in hv_eject_device_work().

Fixes: 05f151a73ec2 ("PCI: hv: Fix a memory leak in hv_eject_device_work()")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/pci-hyperv.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -1880,6 +1880,7 @@ static void hv_pci_devices_present(struc
 static void hv_eject_device_work(struct work_struct *work)
 {
 	struct pci_eject_response *ejct_pkt;
+	struct hv_pcibus_device *hbus;
 	struct hv_pci_dev *hpdev;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1890,6 +1891,7 @@ static void hv_eject_device_work(struct
 	} ctxt;
 
 	hpdev = container_of(work, struct hv_pci_dev, wrk);
+	hbus = hpdev->hbus;
 
 	WARN_ON(hpdev->state != hv_pcichild_ejecting);
 
@@ -1900,8 +1902,7 @@ static void hv_eject_device_work(struct
 	 * because hbus->pci_bus may not exist yet.
 	 */
 	wslot = wslot_to_devfn(hpdev->desc.win_slot.slot);
-	pdev = pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
-					   wslot);
+	pdev = pci_get_domain_bus_and_slot(hbus->sysdata.domain, 0, wslot);
 	if (pdev) {
 		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
@@ -1909,9 +1910,9 @@ static void hv_eject_device_work(struct
 		pci_unlock_rescan_remove();
 	}
 
-	spin_lock_irqsave(&hpdev->hbus->device_list_lock, flags);
+	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	list_del(&hpdev->list_entry);
-	spin_unlock_irqrestore(&hpdev->hbus->device_list_lock, flags);
+	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
 
 	if (hpdev->pci_slot)
 		pci_destroy_slot(hpdev->pci_slot);
@@ -1920,7 +1921,7 @@ static void hv_eject_device_work(struct
 	ejct_pkt = (struct pci_eject_response *)&ctxt.pkt.message;
 	ejct_pkt->message_type.type = PCI_EJECTION_COMPLETE;
 	ejct_pkt->wslot.slot = hpdev->desc.win_slot.slot;
-	vmbus_sendpacket(hpdev->hbus->hdev->channel, ejct_pkt,
+	vmbus_sendpacket(hbus->hdev->channel, ejct_pkt,
 			 sizeof(*ejct_pkt), (unsigned long)&ctxt.pkt,
 			 VM_PKT_DATA_INBAND, 0);
 
@@ -1929,7 +1930,9 @@ static void hv_eject_device_work(struct
 	/* For the two refs got in new_pcichild_device() */
 	put_pcichild(hpdev);
 	put_pcichild(hpdev);
-	put_hvpcibus(hpdev->hbus);
+	/* hpdev has been freed. Do not use it any more. */
+
+	put_hvpcibus(hbus);
 }
 
 /**


