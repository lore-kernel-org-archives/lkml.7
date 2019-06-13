Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C1C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF38206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfFMPe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:34:26 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:43990 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfFMPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:34:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 279A73F7C1;
        Thu, 13 Jun 2019 17:34:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xRpvJaXI_Z3q; Thu, 13 Jun 2019 17:34:15 +0200 (CEST)
Received: from localhost (h-41-252.A163.priv.bahnhof.se [46.59.41.252])
        (Authenticated sender: mb547485)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 07A5E3F70B;
        Thu, 13 Jun 2019 17:34:14 +0200 (CEST)
Date:   Thu, 13 Jun 2019 17:34:14 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     laurentiu.tudor@nxp.com, hch@lst.de, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        marex@denx.de, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190613153414.GA909@sx9>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-4-laurentiu.tudor@nxp.com>
 <20190605214622.GA22254@roeck-us.net>
 <20190611133223.GA30054@roeck-us.net>
 <20190611172654.GA2602@sx9>
 <20190611190343.GA18459@roeck-us.net>
 <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> Thanks for the confirmation. Do you see the problem only with the
> ohci-sm501 driver or also with others ?

All are likely affected, but it depends, because I believe the problem is
that the USB subsystem runs out of memory. Please try the attached patch!

The pool assumed 4096 byte page alignment for every allocation, which is
excessive given that many requests are for 16 and 32 bytes. In the patch
below, I have turned down the order to 5, which is good enough for the ED
and TD structures of the OHCI, but not enough for the HCCA that needs 256
byte alignment. With some luck, the WARN_ON_ONCE will not trigger in your
test, though. If it does, you may try to increase the order from 5 to 8.

I have observed strange things happen when the USB subsystem runs out of
memory. The mass storage drivers often seem to busy-wait on -ENOMEM,
consuming a lot of processor resources. It would be much more efficient
to sleep waiting for memory to become available.

In your case I suspect that allocation failures are not correctly
attributed. Certain kinds of temporary freezes may also occur, as the
various devices are reset due to host memory allocation errors.

Fredrik

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -3011,7 +3011,7 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
 	int err;
 	void __iomem *local_mem;
 
-	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, PAGE_SHIFT,
+	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, 5,
 						  dev_to_node(hcd->self.sysdev),
 						  dev_name(hcd->self.sysdev));
 	if (IS_ERR(hcd->localmem_pool))
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -517,6 +517,7 @@ static int ohci_init (struct ohci_hcd *ohci)
 						GFP_KERNEL);
 	if (!ohci->hcca)
 		return -ENOMEM;
+	WARN_ON_ONCE(ohci->hcca_dma & 0xff);
 
 	if ((ret = ohci_mem_init (ohci)) < 0)
 		ohci_stop (hcd);
