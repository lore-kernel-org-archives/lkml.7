Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66875C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3838F222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LFxhuEfs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKMBuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:50:17 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15598 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKMBuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:50:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dcb61200001>; Tue, 12 Nov 2019 17:49:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Nov 2019 17:50:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Nov 2019 17:50:16 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Nov
 2019 01:50:15 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Nov 2019 01:50:15 +0000
Received: from henryl-tu10x.nvidia.com (Not Verified[10.19.109.97]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dcb61560003>; Tue, 12 Nov 2019 17:50:15 -0800
From:   Henry Lin <henryl@nvidia.com>
CC:     <hch@infradead.org>, Henry Lin <henryl@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] usb: xhci: only set D3hot for pci device
Date:   Wed, 13 Nov 2019 09:49:27 +0800
Message-ID: <20191113014927.11915-1-henryl@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191112071831.1043-1-henryl@nvidia.com>
References: <20191112071831.1043-1-henryl@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1573609760; bh=Q6Yu1upf0qf3MvZjiXjYRmyX6HZloR3M4NpbMzagMCI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=LFxhuEfs14CMUq7d4HtyDndDhsKo5I9xGFO/Jg44hkjM1ma9H2JYQ6j0RR57qxhCB
         fGmQjO6vKhTBzIlHgrysDC6dqDYjYLNTPwolgs4/QX2F5qSrx7H8buA+xNhmgtQJXh
         9ZgKhdv45KrPEGvHQjG0qLUr1Kdx0hMXeu1UyrN02To5y2B3+KCdIjVM9QVMoQkFJf
         ACHdmvD6bCzpq2/4T735txn8uFeWfXcpQ/fNzhFRtTuJGvN/kZum7a6GA+waU/437r
         WATQFRIVU8Q6qetXNX02o9g2HXk0d2zqmj5HmZTxRmboWIJ3HOPRIzoohrIo0l0uIe
         xeJvLCowCekyQ==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xhci driver cannot call pci_set_power_state() on non-pci xhci host
controllers. For example, NVIDIA Tegra XHCI host controller which acts
as platform device with XHCI_SPURIOUS_WAKEUP quirk set in some platform
hits this issue during shutdown.

Signed-off-by: Henry Lin <henryl@nvidia.com>
---
 drivers/usb/host/xhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 6c17e3fe181a..61718b126d2b 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -791,8 +791,11 @@ static void xhci_shutdown(struct usb_hcd *hcd)
 			readl(&xhci->op_regs->status));
 
 	/* Yet another workaround for spurious wakeups at shutdown with HSW */
-	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
-		pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3hot);
+	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP) {
+		if (dev_is_pci(hcd->self.sysdev))
+			pci_set_power_state(to_pci_dev(hcd->self.sysdev),
+					PCI_D3hot);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

