Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5872AC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 05:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDC1222BE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 05:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtWSAXXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJEFdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 01:33:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38379 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfJEFdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 01:33:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so4123355plq.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 22:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjAy4P3i08X2ZHji+htjTSAclBOE811x/WDkW8jLYoc=;
        b=MtWSAXXClrLr2rKc4uDMx90+c2hHi1QkReabmPTH9Mm9b3DMnZo4gVUip/W/dO9Hu0
         JGw6V0ERj9wkl2n7Si49WHoMmcUvqNz7LL8bbaq8InV+9lqpy34isQUTqiwPKFaViAwB
         Ot/rvs4kkhERP2nbsIPtHntsgCCM1WbN2sp7xNc4mySdkPublE0Rysn3o5dojNYM8slv
         chfWJde7eOZ48Hstnq0QdvA2LYXCv6Aeo4AhMKJOD8AzBrBkzKP3OB8fgv6H5Vl1Xl7W
         hs8iMbEGs2UIpZPN//jUfmfLiVG5rZLOzPhgDxHokM1HMQ8eRQJTo+NfhMjTlOxITnk9
         0IHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IjAy4P3i08X2ZHji+htjTSAclBOE811x/WDkW8jLYoc=;
        b=Oe/uumhFQklAamqpO8p7dTWbgmFXN8icF2/OUAR6YaqZ4cYvOSZzOt8KbOW6JQaCwg
         mxtebY0ku/7ZFjHwFlRpTxgIGLrFkA5NJ+JJ1WvgGOa9LhLYULPO+Y3imqgAabY3SHIH
         nEBe8BidKQUExBMmS/2l5M2hX3qAO4zAhzK4pqo4n/EU6Ia75W9d35xe/NHlxXFYgQeg
         WdPCuYVLT9yyEGCoFK3lF16M+Rl5oW+pDVgFnCS7jQ6uraERJMKx+df8CecpcDvSDQSD
         5J3zqGRJXRZ5v88XtVNPmycl9ZZ5izpoxfA5Dy39yUR+wCb2E27zDXoWIu5lTI5Rp7Mo
         KUTw==
X-Gm-Message-State: APjAAAWj8zvwEEOPVx1s20vpvA/kwJU2vBTpu0qte9y0hm48n8gvTB+S
        7NqSsOs0xo0jU3sVOjxryRzRLsWTSaQ=
X-Google-Smtp-Source: APXvYqzm2Y1T1wRAHo+VkRQgWytiW+fb/gL2Rd3khlvUxpycSA52a0/UpD7YhcA0FE2MPKdlXamcRg==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr18999782plo.233.1570253614492;
        Fri, 04 Oct 2019 22:33:34 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id x37sm6988169pgl.18.2019.10.04.22.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 22:33:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH] dma-mapping: fix false positivse warnings in dma_common_free_remap()
Date:   Fri,  4 Oct 2019 22:33:17 -0700
Message-Id: <20191005053317.7856-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5cf4537975bb ("dma-mapping: introduce a dma_common_find_pages
helper") changed invalid input check in dma_common_free_remap() from:

    if (!area || !area->flags != VM_DMA_COHERENT)

to

    if (!area || !area->flags != VM_DMA_COHERENT || !area->pages)

which seem to produce false positives for memory obtained via
dma_common_contiguous_remap()

This triggers the following warning message when doing "reboot" on ZII
VF610 Dev Board Rev B:

WARNING: CPU: 0 PID: 1 at kernel/dma/remap.c:112 dma_common_free_remap+0x88/0x8c
trying to free invalid coherent area: 9ef82980
Modules linked in:
CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 5.3.0-rc6-next-20190820 #119
Hardware name: Freescale Vybrid VF5xx/VF6xx (Device Tree)
Backtrace:
[<8010d1ec>] (dump_backtrace) from [<8010d588>] (show_stack+0x20/0x24)
 r7:8015ed78 r6:00000009 r5:00000000 r4:9f4d9b14
[<8010d568>] (show_stack) from [<8077e3f0>] (dump_stack+0x24/0x28)
[<8077e3cc>] (dump_stack) from [<801197a0>] (__warn.part.3+0xcc/0xe4)
[<801196d4>] (__warn.part.3) from [<80119830>] (warn_slowpath_fmt+0x78/0x94)
 r6:00000070 r5:808e540c r4:81c03048
[<801197bc>] (warn_slowpath_fmt) from [<8015ed78>] (dma_common_free_remap+0x88/0x8c)
 r3:9ef82980 r2:808e53e0
 r7:00001000 r6:a0b1e000 r5:a0b1e000 r4:00001000
[<8015ecf0>] (dma_common_free_remap) from [<8010fa9c>] (remap_allocator_free+0x60/0x68)
 r5:81c03048 r4:9f4d9b78
[<8010fa3c>] (remap_allocator_free) from [<801100d0>] (__arm_dma_free.constprop.3+0xf8/0x148)
 r5:81c03048 r4:9ef82900
[<8010ffd8>] (__arm_dma_free.constprop.3) from [<80110144>] (arm_dma_free+0x24/0x2c)
 r5:9f563410 r4:80110120
[<80110120>] (arm_dma_free) from [<8015d80c>] (dma_free_attrs+0xa0/0xdc)
[<8015d76c>] (dma_free_attrs) from [<8020f3e4>] (dma_pool_destroy+0xc0/0x154)
 r8:9efa8860 r7:808f02f0 r6:808f02d0 r5:9ef82880 r4:9ef82780
[<8020f324>] (dma_pool_destroy) from [<805525d0>] (ehci_mem_cleanup+0x6c/0x150)
 r7:9f563410 r6:9efa8810 r5:00000000 r4:9efd0148
[<80552564>] (ehci_mem_cleanup) from [<80558e0c>] (ehci_stop+0xac/0xc0)
 r5:9efd0148 r4:9efd0000
[<80558d60>] (ehci_stop) from [<8053c4bc>] (usb_remove_hcd+0xf4/0x1b0)
 r7:9f563410 r6:9efd0074 r5:81c03048 r4:9efd0000
[<8053c3c8>] (usb_remove_hcd) from [<8056361c>] (host_stop+0x48/0xb8)
 r7:9f563410 r6:9efd0000 r5:9f5f4040 r4:9f5f5040
[<805635d4>] (host_stop) from [<80563d0c>] (ci_hdrc_host_destroy+0x34/0x38)
 r7:9f563410 r6:9f5f5040 r5:9efa8800 r4:9f5f4040
[<80563cd8>] (ci_hdrc_host_destroy) from [<8055ef18>] (ci_hdrc_remove+0x50/0x10c)
[<8055eec8>] (ci_hdrc_remove) from [<804a2ed8>] (platform_drv_remove+0x34/0x4c)
 r7:9f563410 r6:81c4f99c r5:9efa8810 r4:9efa8810
[<804a2ea4>] (platform_drv_remove) from [<804a18a8>] (device_release_driver_internal+0xec/0x19c)
 r5:00000000 r4:9efa8810
[<804a17bc>] (device_release_driver_internal) from [<804a1978>] (device_release_driver+0x20/0x24)
 r7:9f563410 r6:81c41ed0 r5:9efa8810 r4:9f4a1dac
[<804a1958>] (device_release_driver) from [<804a01b8>] (bus_remove_device+0xdc/0x108)
[<804a00dc>] (bus_remove_device) from [<8049c204>] (device_del+0x150/0x36c)
 r7:9f563410 r6:81c03048 r5:9efa8854 r4:9efa8810
[<8049c0b4>] (device_del) from [<804a3368>] (platform_device_del.part.2+0x20/0x84)
 r10:9f563414 r9:809177e0 r8:81cb07dc r7:81c78320 r6:9f563454 r5:9efa8800
 r4:9efa8800
[<804a3348>] (platform_device_del.part.2) from [<804a3420>] (platform_device_unregister+0x28/0x34)
 r5:9f563400 r4:9efa8800
[<804a33f8>] (platform_device_unregister) from [<8055dce0>] (ci_hdrc_remove_device+0x1c/0x30)
 r5:9f563400 r4:00000001
[<8055dcc4>] (ci_hdrc_remove_device) from [<805652ac>] (ci_hdrc_imx_remove+0x38/0x118)
 r7:81c78320 r6:9f563454 r5:9f563410 r4:9f541010
[<8056538c>] (ci_hdrc_imx_shutdown) from [<804a2970>] (platform_drv_shutdown+0x2c/0x30)
[<804a2944>] (platform_drv_shutdown) from [<8049e4fc>] (device_shutdown+0x158/0x1f0)
[<8049e3a4>] (device_shutdown) from [<8013ac80>] (kernel_restart_prepare+0x44/0x48)
 r10:00000058 r9:9f4d8000 r8:fee1dead r7:379ce700 r6:81c0b280 r5:81c03048
 r4:00000000
[<8013ac3c>] (kernel_restart_prepare) from [<8013ad14>] (kernel_restart+0x1c/0x60)
[<8013acf8>] (kernel_restart) from [<8013af84>] (__do_sys_reboot+0xe0/0x1d8)
 r5:81c03048 r4:00000000
[<8013aea4>] (__do_sys_reboot) from [<8013b0ec>] (sys_reboot+0x18/0x1c)
 r8:80101204 r7:00000058 r6:00000000 r5:00000000 r4:00000000
[<8013b0d4>] (sys_reboot) from [<80101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0x9f4d9fa8 to 0x9f4d9ff0)
9fa0:                   00000000 00000000 fee1dead 28121969 01234567 379ce700
9fc0: 00000000 00000000 00000000 00000058 00000000 00000000 00000000 00016d04
9fe0: 00028e0c 7ec87c64 000135ec 76c1f410

Restore original invalid input check in dma_common_free_remap() to
avoid this problem.

Fixes: 5cf4537975bb ("dma-mapping: introduce a dma_common_find_pages helper")
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
---

I think this is related to warning reported by Geert in [1], but it
didn't seem like discussion there reached any conclusions hence this
patch.

Thanks,
Andrey Smirnov

[1] https://lore.kernel.org/lkml/CAMuHMdXxWp2=9n2LQA9KVH_ArOUnY78ZoiQ7ZsDMbTOGsEz4hw@mail.gmail.com/


 kernel/dma/remap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index ca4e5d44b571..e8d9cc50fa4f 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -11,13 +11,21 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
-struct page **dma_common_find_pages(void *cpu_addr)
+static struct vm_struct *dma_common_find_area(void *cpu_addr)
 {
 	struct vm_struct *area = find_vm_area(cpu_addr);
 
 	if (!area || area->flags != VM_DMA_COHERENT)
 		return NULL;
-	return area->pages;
+
+	return area;
+}
+
+struct page **dma_common_find_pages(void *cpu_addr)
+{
+	struct vm_struct *area = dma_common_find_area(cpu_addr);
+
+	return area ? area->pages : NULL;
 }
 
 static struct vm_struct *__dma_common_pages_remap(struct page **pages,
@@ -87,9 +95,9 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
  */
 void dma_common_free_remap(void *cpu_addr, size_t size)
 {
-	struct page **pages = dma_common_find_pages(cpu_addr);
+	struct vm_struct *area = dma_common_find_area(cpu_addr);
 
-	if (!pages) {
+	if (!area) {
 		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
 		return;
 	}
-- 
2.21.0

