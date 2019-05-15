Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB24C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AF22084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZ+s7feh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfEOBup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:50:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42790 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfEOBuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:50:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so484534pln.9;
        Tue, 14 May 2019 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4Usqzgg/1igU/jffcN6qFtV+3jC2DcuMo1JuZfIWFYs=;
        b=QZ+s7fehpZbYOJHFA2rRf+DqZvfmId4TYxJ73GmlVh7KuCXjyh4g+gWGW60UynxsqS
         bT4uUmAiJ8SJbFIg7U5RnMn8pe/7/b5wwLgbt7tlCJoMqvmo+n+JPiBijyblEpKTVdsd
         LDElbhyEycRJhOTUZB7s3ZmpjQyDZ+atXG6hwmNg5zJ8W7uoKb/DvC8v+P0V19dKUlRf
         mPGaCHl713z+9YB0HqDVJmQbW/cVzV+Ot1+pd4s8PEVVqFg7KE4BfFXThC5fqhKLWIFj
         4BtMxW0fFtUKb/U39GUq5XHoAR4lZktBXpKZnSsr72oMGCPDGkii1BeQc8M2r/qZkj8r
         yD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Usqzgg/1igU/jffcN6qFtV+3jC2DcuMo1JuZfIWFYs=;
        b=qsS1deoz/eydVxQdeXOvav+Zioo+TbuliRBa4GbBjt16x0rcf0mOIGowZwkrt0s+pQ
         gLC/J/xRxEpQe8WyPyTu6F+i7h1wJAmcS+hiAVv6xc1kKY96fVuQFE9f7BuD7yAtaK8R
         zejZ//2MkIa+Pztio+rTFik/UbamhCU/mHYTt0txEgvz+UX9W6BJok8wSN5DJO9EFVsz
         Tlt2LedXpbxbCnlAy0/wq6xZWCRJs7waTgXKOrJpj8fqdAXT+K6+lS/2HxWJNGZBdnuT
         c/4CwjfyxiK3tJp3v2lysuHowWajiNLlfM7OcY9IloeA3CI3gEWr4gqo0RgSAfU1oflf
         eYKw==
X-Gm-Message-State: APjAAAWwxkFMSzlfpELlxy+EfToD4vmhXeR81CxACOt3UFlfnl8cGxBa
        lvR7yD7MDx/WpCMK+EzAkgd6X0q/
X-Google-Smtp-Source: APXvYqyNpJb5MX7eI1Sfgbs/ZOvV5RbG2ZNAZXTGg5/ll03XQgrQzPFKWNY7ZAAS8JoKyg+bR0OC4Q==
X-Received: by 2002:a17:902:4383:: with SMTP id j3mr40608024pld.320.1557885043678;
        Tue, 14 May 2019 18:50:43 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id i27sm509424pfk.162.2019.05.14.18.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 18:50:43 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: xhci: Possible resource leaks when xhci_run() fails
Date:   Wed, 15 May 2019 09:50:33 +0800
Message-Id: <20190515015033.21113-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci_pci_setup() is assigned to hc_driver.reset;
xhci_run() is assigned to hc_driver.start();
xhci_stop() is assigned to hc_driver.stop().

xhci_pci_setup() calls xhci_gen_setup, which calls xhci_init(). And
xhci_init() calls xhci_mem_init() to allocate resources.

xhci_stop() calls xhci_mem_cleanup(), to release the resources allocated
in xhci_mem_init() (also namely xhci_pci_setup()).

xhci_run() can fail, because xhci_try_enable_msi() or
xhci_alloc_command() in this function can fail.

In drivers/usb/core/hcd.c:
    retval = hcd->driver->reset(hcd);
    if (retval < 0) {
        ......
        goto err_hcd_driver_setup;
    }
    ......
    retval = hcd->driver->start(hcd);
    if (retval < 0) {
        ......
        goto err_hcd_driver_start;
    }
    .......
    hcd->driver->stop(hcd);
    hcd->state = HC_STATE_HALT;
    clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
    del_timer_sync(&hcd->rh_timer);
err_hcd_driver_start:
    if (usb_hcd_is_primary_hcd(hcd) && hcd->irq > 0)
        free_irq(irqnum, hcd);
err_request_irq:
err_hcd_driver_setup:
err_set_rh_speed:
    usb_put_invalidate_rhdev(hcd);
err_allocate_root_hub:
    usb_deregister_bus(&hcd->self);
err_register_bus:
    hcd_buffer_destroy(hcd);
err_create_buf:
    usb_phy_roothub_power_off(hcd->phy_roothub);
err_usb_phy_roothub_power_on:
    usb_phy_roothub_exit(hcd->phy_roothub);

Thus, when hcd->driver->reset() succeeds and hcd->driver->start() fails,
hcd->driver->stop() is not called.

Namely, when xhci_pci_setup() successfully allocates resources, and
xhci_run() fails, xhci_stop() is not called to release the resources.
For this reason, resource leaks occur in this case.

The ehci driver, uhci driver and ohci driver do not have such bugs:
In the ehci driver, ehci_run() (namely hcd->driver->start()) never
fails.
In the uhci driver, all the resources are allocated in uhci_start
(namely hcd->driver->start()), and no resources are allocated in
uhci_pci_init() (namely hcd->driver->reset()).
In the ohci driver, ohci_setup() (namely hcd->driver->reset()) also
allocates resources. But when ohci_start() (namely hcd->driver->start())
is going to fail, ohci_stop() is directly called to release the
resources allocated by ohci_setup().

Referring to the ohci driver, to fix these resource leaks,
xhci_mem_cleanup() is called in error handling code of xhci_run(),
to release the allocated resources.

These bugs are found by a runtime fuzzing tool named FIZZER written by
us.


Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/host/xhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 7fa58c99f126..d18893cf03cb 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -651,8 +651,10 @@ int xhci_run(struct usb_hcd *hcd)
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "xhci_run");
 
 	ret = xhci_try_enable_msi(hcd);
-	if (ret)
+	if (ret) {
+		xhci_mem_cleanup(xhci);
 		return ret;
+	}
 
 	temp_64 = xhci_read_64(xhci, &xhci->ir_set->erst_dequeue);
 	temp_64 &= ~ERST_PTR_MASK;
@@ -683,8 +685,10 @@ int xhci_run(struct usb_hcd *hcd)
 		struct xhci_command *command;
 
 		command = xhci_alloc_command(xhci, false, GFP_KERNEL);
-		if (!command)
+		if (!command) {
+			xhci_mem_cleanup(xhci);
 			return -ENOMEM;
+		}
 
 		ret = xhci_queue_vendor_command(xhci, command, 0, 0, 0,
 				TRB_TYPE(TRB_NEC_GET_FW));
-- 
2.17.0

