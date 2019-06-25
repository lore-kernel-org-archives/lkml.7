Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F78C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B062133F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbfFYPIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:08:43 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:47660 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbfFYPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:08:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id CA9AD3F732;
        Tue, 25 Jun 2019 17:08:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1mKKqNFww7JF; Tue, 25 Jun 2019 17:08:24 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 12E773F3B2;
        Tue, 25 Jun 2019 17:08:23 +0200 (CEST)
Date:   Tue, 25 Jun 2019 17:08:23 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, laurentiu.tudor@nxp.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        JuergenUrban@gmx.de
Subject: [PATCH 2/2] usb: host: Fix excessive alignment restriction for local
 memory allocations
Message-ID: <20190625150823.GB2560@sx9>
References: <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
 <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
 <20190614142816.GA2574@sx9>
 <20190624063515.GA3296@lst.de>
 <20190624125916.GA2516@sx9>
 <20190625060000.GA28986@lst.de>
 <20190625150558.GA2560@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190625150558.GA2560@sx9>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAGE_SHIFT alignment restriction to devm_gen_pool_create() quickly
exhaust local memory because most allocations are much smaller than
PAGE_SIZE. This causes USB device failures such as

	usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
	sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
	sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
	print_req_error: I/O error, dev sda, sector 2172 flags 80700

when trying to boot from the SM501 USB controller on SH4 with QEMU.

Align allocations as required but not necessarily much more than that.
The HCCA, TD and ED structures align with 256, 32 and 16 byte memory
boundaries, as specified by the Open HCI[1]. The min_alloc_order argument
to devm_gen_pool_create is now somewhat arbitrarily set to 4 (16 bytes).
Perhaps it could be somewhat lower for general buffer allocations.

Reference:

[1] "Open Host Controller Interface Specification for USB",
    release 1.0a, Compaq, Microsoft, National Semiconductor, 1999,
    pp. 16, 19, 33.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 drivers/usb/core/hcd.c      | 2 +-
 drivers/usb/host/ohci-hcd.c | 4 ++--
 drivers/usb/host/ohci-mem.c | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index b2362303d32f..48483fa71854 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -3014,7 +3014,7 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
 	int err;
 	void __iomem *local_mem;
 
-	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, PAGE_SHIFT,
+	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, 4,
 						  dev_to_node(hcd->self.sysdev),
 						  dev_name(hcd->self.sysdev));
 	if (IS_ERR(hcd->localmem_pool))
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 5801858d867e..b457fdaff297 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -507,9 +507,9 @@ static int ohci_init (struct ohci_hcd *ohci)
 	ohci->prev_frame_no = IO_WATCHDOG_OFF;
 
 	if (hcd->localmem_pool)
-		ohci->hcca = gen_pool_dma_alloc(hcd->localmem_pool,
+		ohci->hcca = gen_pool_dma_alloc_align(hcd->localmem_pool,
 						sizeof(*ohci->hcca),
-						&ohci->hcca_dma);
+						&ohci->hcca_dma, 256);
 	else
 		ohci->hcca = dma_alloc_coherent(hcd->self.controller,
 						sizeof(*ohci->hcca),
diff --git a/drivers/usb/host/ohci-mem.c b/drivers/usb/host/ohci-mem.c
index 4afe27cc7e46..1425335c6baf 100644
--- a/drivers/usb/host/ohci-mem.c
+++ b/drivers/usb/host/ohci-mem.c
@@ -94,7 +94,8 @@ td_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 
 	if (hcd->localmem_pool)
-		td = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*td), &dma);
+		td = gen_pool_dma_zalloc_align(hcd->localmem_pool,
+				sizeof(*td), &dma, 32);
 	else
 		td = dma_pool_zalloc(hc->td_cache, mem_flags, &dma);
 	if (td) {
@@ -137,7 +138,8 @@ ed_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
 	struct usb_hcd	*hcd = ohci_to_hcd(hc);
 
 	if (hcd->localmem_pool)
-		ed = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*ed), &dma);
+		ed = gen_pool_dma_zalloc_align(hcd->localmem_pool,
+				sizeof(*ed), &dma, 16);
 	else
 		ed = dma_pool_zalloc(hc->ed_cache, mem_flags, &dma);
 	if (ed) {
-- 
2.21.0

