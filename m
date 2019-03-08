Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ABCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA842085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049547;
	bh=cRM6BpeSTI7ag/qBZlxF9Z79Q7SdsuB7woTEJnrxLg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iHQ8IKfxR5Iv093zwspl20/1R2kCmtPQxKvW1gqpV4nDUlOmKKfy10v0Kh+1Yh3d2
	 jay7je9CkShhib2K8HGKOFmLZScC3zPCUSDMcCGTxmN72HIcoMboe4P0+L7YFVbQf7
	 8By2VunAX2IEyXAXAjYkMyJABMGvrZUvdStk60qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCHMw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:52:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfCHMwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:52:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94C12085A;
        Fri,  8 Mar 2019 12:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049541;
        bh=cRM6BpeSTI7ag/qBZlxF9Z79Q7SdsuB7woTEJnrxLg8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FvKZeO8vFW5Rt6lpGJkaZjGeKjXufzLYGfFCu/821xPC2LD7b4LGpenh8kfLuX71J
         PFRLuisvpSXRnZWdpF94Jp5As7Np/I5O1kxRK+q/DevMzDyaiyIK+YWMUYoiP8ZTsB
         o9xtHiWsulC403G5yN0cd2eYDlWYRxCDge/g2qds=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Balaji Manoharan <m.balaji@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.0 33/46] usb: xhci: Fix for Enabling USB ROLE SWITCH QUIRK on INTEL_SUNRISEPOINT_LP_XHCI
Date:   Fri,  8 Mar 2019 13:50:06 +0100
Message-Id: <20190308124904.405344948@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -194,6 +194,7 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_SSIC_PORT_UNUSED;
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
 	    (pdev->device == PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI))
 		xhci->quirks |= XHCI_INTEL_USB_ROLE_SW;
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&


