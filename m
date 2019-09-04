Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249CCC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F176B208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620435;
	bh=YhZYuhnmS9tdig3xXuI3dsas3LT8WuW+r+Q0IcMXP2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xd7/G2bRPglQGoLjK1cHUBx+6dRhxt1N7zilGjg079YSqpXgX7Po2mHPSzgqSrAwI
	 6qhfNKtmX6sWTWR5Y819BxrPCm8jPbeS7VxbR7VYj3qW29pU/7CKrXHe/lbUTPAyKb
	 NukGyQd/taktOSuNxa0jzmLwSqfzmunCH1eTF3/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbfIDSHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:07:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389583AbfIDSHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:07:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BF72339E;
        Wed,  4 Sep 2019 18:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620430;
        bh=YhZYuhnmS9tdig3xXuI3dsas3LT8WuW+r+Q0IcMXP2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvNkWZZTkOIfr8mC8brCEg4jKbSoSSuKtHJCQ6vV3e7QAcHHlx5RUxRRJqP0yFAcN
         0kkyW37c2t6w1zQlitEEMDlveHPv/PFUltc6KOC2CB+HXYkeOi1B+ly5fSKSa8kBtG
         /BLHVFDYT/jHVeSK2cR//5msxR9bcqBm8rMJs8wE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Carsten Schmid <carsten_schmid@mentor.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 56/93] usb: hcd: use managed device resources
Date:   Wed,  4 Sep 2019 19:53:58 +0200
Message-Id: <20190904175307.950136275@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Schmid, Carsten <Carsten_Schmid@mentor.com>

commit 76da906ad727048a74bb8067031ee99fc070c7da upstream.

Using managed device resources in usb_hcd_pci_probe() allows devm usage for
resource subranges, such as the mmio resource for the platform device
created to control host/device mode mux, which is a xhci extended
capability, and sits inside the xhci mmio region.

If managed device resources are not used then "parent" resource
is released before subrange at driver removal as .remove callback is
called before the devres list of resources for this device is walked
and released.

This has been observed with the xhci extended capability driver causing a
use-after-free which is now fixed.

An additional nice benefit is that error handling on driver initialisation
is simplified much.

Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
Tested-by: Carsten Schmid <carsten_schmid@mentor.com>
Reviewed-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Fixes: fa31b3cb2ae1 ("xhci: Add Intel extended cap / otg phy mux handling")
Cc: <stable@vger.kernel.org> # v4.19+
Link: https://lore.kernel.org/r/1566569488679.31808@mentor.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/hcd-pci.c |   30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -216,17 +216,18 @@ int usb_hcd_pci_probe(struct pci_dev *de
 		/* EHCI, OHCI */
 		hcd->rsrc_start = pci_resource_start(dev, 0);
 		hcd->rsrc_len = pci_resource_len(dev, 0);
-		if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
-				driver->description)) {
+		if (!devm_request_mem_region(&dev->dev, hcd->rsrc_start,
+				hcd->rsrc_len, driver->description)) {
 			dev_dbg(&dev->dev, "controller already in use\n");
 			retval = -EBUSY;
 			goto put_hcd;
 		}
-		hcd->regs = ioremap_nocache(hcd->rsrc_start, hcd->rsrc_len);
+		hcd->regs = devm_ioremap_nocache(&dev->dev, hcd->rsrc_start,
+				hcd->rsrc_len);
 		if (hcd->regs == NULL) {
 			dev_dbg(&dev->dev, "error mapping memory\n");
 			retval = -EFAULT;
-			goto release_mem_region;
+			goto put_hcd;
 		}
 
 	} else {
@@ -240,8 +241,8 @@ int usb_hcd_pci_probe(struct pci_dev *de
 
 			hcd->rsrc_start = pci_resource_start(dev, region);
 			hcd->rsrc_len = pci_resource_len(dev, region);
-			if (request_region(hcd->rsrc_start, hcd->rsrc_len,
-					driver->description))
+			if (devm_request_region(&dev->dev, hcd->rsrc_start,
+					hcd->rsrc_len, driver->description))
 				break;
 		}
 		if (region == PCI_ROM_RESOURCE) {
@@ -275,20 +276,13 @@ int usb_hcd_pci_probe(struct pci_dev *de
 	}
 
 	if (retval != 0)
-		goto unmap_registers;
+		goto put_hcd;
 	device_wakeup_enable(hcd->self.controller);
 
 	if (pci_dev_run_wake(dev))
 		pm_runtime_put_noidle(&dev->dev);
 	return retval;
 
-unmap_registers:
-	if (driver->flags & HCD_MEMORY) {
-		iounmap(hcd->regs);
-release_mem_region:
-		release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-	} else
-		release_region(hcd->rsrc_start, hcd->rsrc_len);
 put_hcd:
 	usb_put_hcd(hcd);
 disable_pci:
@@ -347,14 +341,6 @@ void usb_hcd_pci_remove(struct pci_dev *
 		dev_set_drvdata(&dev->dev, NULL);
 		up_read(&companions_rwsem);
 	}
-
-	if (hcd->driver->flags & HCD_MEMORY) {
-		iounmap(hcd->regs);
-		release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
-	} else {
-		release_region(hcd->rsrc_start, hcd->rsrc_len);
-	}
-
 	usb_put_hcd(hcd);
 	pci_disable_device(dev);
 }


