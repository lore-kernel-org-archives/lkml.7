Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C76C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581772133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050014;
	bh=c3eKBxLTjxTPFVNeMBbdwEjTdIBaH5OoN7kYQ77NDMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W1JFvhZB3XBTguJjOv4AgkFXIUFG0HxK44EdUNKe+yaAM00qRqFuv+hnVjaCoZA07
	 wPm03xAiRPFp38yhdiOUf+x8DSTFciK23Kx51XGH2U3qdzpkuCQCUZbxFMb1rGXIdX
	 KOgPH1fkmT4mXRq1lw2Eez404dv/nCKTFGvo1cAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfCHNAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728261AbfCHNAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:00:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8225E2133F;
        Fri,  8 Mar 2019 13:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552050010;
        bh=c3eKBxLTjxTPFVNeMBbdwEjTdIBaH5OoN7kYQ77NDMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clrDFOC93kZrgHGG7GdBlCnL/TNVaff5hCDimKIATpKJLLL8ZNxvGg76ihG3VLPPD
         fpJ+gQPxcOeoyGqlIc2yoAhVpAS4al7WQ1xPyzALhil/5rjYL5IX3rgn0FreP1PU4L
         +B7XbaCXUaFUOTJf5W0SeQzGG+irCb6ukTQi0XKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Balaji Manoharan <m.balaji@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 56/68] usb: xhci: Fix for Enabling USB ROLE SWITCH QUIRK on INTEL_SUNRISEPOINT_LP_XHCI
Date:   Fri,  8 Mar 2019 13:50:26 +0100
Message-Id: <20190308124913.374858967@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Balaji Manoharan <m.balaji@intel.com>

commit 8fde481ef3674ae5ad0dbfef4df18ff507c5675a upstream.

This fix enables USB role feature on intel commercial nuc
platform which is based on Kabylake chipset.

Signed-off-by: Balaji Manoharan <m.balaji@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -187,6 +187,7 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_SSIC_PORT_UNUSED;
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI))
 		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&


