Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87537C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570072173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfC1KGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:06:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35957 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfC1KGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:06:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so4380495wrd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=nDVKBVnYu5QBINLzNjni2J8sT7SzV0COKn/XViY6MSg=;
        b=QLRr1ri8pLrfkTLc5p6F7jcIMMUdmI7bwx3OSUqp8be4dJDIoUVeudluQMOHmbuwVh
         JzQxZveIJqu6o4NoGhvrN+1xJTfYF8xkAuIvVwoyIPbpQM+tOP1ucrRgEBVNF6WH4xlD
         QySDX/j0U6lbbh6OEFreSjkhpz2s2b1qllkNi9NPYNe5CCL5SHdw7bW7agjpylWwuLYV
         9Ra+cJfvfcvl5QxTsRbqL8DV8IqPNZQGqRHo+HF4BVcUnoN64YwYOC6qAyDbY6OEUxr0
         Zxacxm+/MBeAMqSOWozyeVnofUFno/Up7ElEDAT4ud+WAk65OKP7KEHsbeYHPH6jIEni
         +IbA==
X-Gm-Message-State: APjAAAWa5yFIHX4ciUAQPZhNv1Ezq5wDE0BHLh8seB0BmHPGL4mJI13u
        I4cxNXhUv+B70pVjAITr/3779FjA
X-Google-Smtp-Source: APXvYqy+C11PRTd35M6wsICjzHKdwZxro0F0feo5FW/mKEljZpyl/b7VctB6hcgoAslFPIcBPe3cXQ==
X-Received: by 2002:a5d:6292:: with SMTP id k18mr27373101wru.303.1553767563240;
        Thu, 28 Mar 2019 03:06:03 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id f11sm37494852wrm.30.2019.03.28.03.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 03:06:02 -0700 (PDT)
To:     Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From:   Jiri Slaby <jslaby@suse.cz>
Subject: Misplaced driver_sysfs_remove in really_probe?
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <582bf3ba-3733-eb38-cb9c-5b0d329fb068@suse.cz>
Date:   Thu, 28 Mar 2019 11:06:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since commit 1901fb2604fbcd53201f38725182ea807581159e
Author: Kay Sievers <kay.sievers@novell.com>
Date:   Sat Oct 7 21:55:55 2006 +0200

    Driver core: fix "driver" symlink timing

driver_sysfs_remove seems to be misplaced in the fail path of
really_probe. When driver_sysfs_add fails (or anything which is
currently above it in dd.c -- be it pinctrl_bind_pins or
dev->bus->dma_configure), driver_sysfs_remove is called. Given
dev->driver is set, attempt to remove sysfs device and driver links is
performed, but it is supposed to fail, as the links do not exist yet.

I am dealing with a Syzkaller WARNING from SLE15-SP1 (4.12) which
corresponds to the described scenario. Perhaps Syzkaller fault-injected
a kzalloc failure to pinctrl_bind_pins as I cannot reproduce the report
at all:
> WARNING: CPU: 1 PID: 2091 at ../fs/kernfs/dir.c:1481
kernfs_remove_by_name_ns+0xfa/0x120 fs/kernfs/dir.c:1480
> Supported: No, Unreleased kernel
> CPU: 1 PID: 2091 Comm: systemd-udevd Not tainted 4.12.14-396-default
#1 SLE15-SP1 (unreleased)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-0-ga698c89-prebuilt.qemu.org 04/01/2014
> task: ffff880053794fc0 task.stack: ffff880040ea0000
> RIP: 0010:kernfs_remove_by_name_ns+0xfa/0x120 fs/kernfs/dir.c:1480
> RSP: 0018:ffff880040ea7488 EFLAGS: 00010282
> RAX: 000000000000002d RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 000000000000002d RSI: 1ffff100081d4e48 RDI: ffffed00081d4e85
> RBP: ffffffffa772a380 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffffaa1872c4 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000037
> FS:  00007f0d24dc0f80(0000) GS:ffff88005e080000(0000)
knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000045c061 CR3: 000000003b878006 CR4: 0000000000060ee0
> Call Trace:
>  driver_sysfs_remove+0xb0/0x110 drivers/base/dd.c:290
>  really_probe drivers/base/dd.c:433 [inline]
>  driver_probe_device+0x2b3/0x1200 drivers/base/dd.c:530
>  __driver_attach+0x1dc/0x280 drivers/base/dd.c:763
>  bus_for_each_dev+0x146/0x1e0 drivers/base/bus.c:316
>  bus_add_driver+0x40f/0x850 drivers/base/bus.c:710
>  driver_register+0x1c9/0x410 drivers/base/driver.c:168
>  __hid_register_driver+0x1e0/0x2d0 drivers/hid/hid-core.c:2974
>  ? 0xffffffffc1510000
>  do_one_initcall+0xb7/0x300 init/main.c:808
>  do_init_module+0x23e/0x641 kernel/module.c:3515
>  load_module+0x47d6/0x60b0 kernel/module.c:3867
>  SYSC_finit_module+0x239/0x2a0 kernel/module.c:3980
>  do_syscall_64+0x26c/0x6e0 arch/x86/entry/common.c:284
>  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

I believe it survived from 2.6.20 to the current tree.

Does it look correct to you? This should help IMO and if you agree I
will send a proper patch:
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -496,7 +496,7 @@ static int really_probe(struct device *dev, struct
device_driver *drv)
        if (driver_sysfs_add(dev)) {
                printk(KERN_ERR "%s: driver_sysfs_add(%s) failed\n",
                        __func__, dev_name(dev));
-               goto probe_failed;
+               goto sysfs_failed;
        }

        if (dev->pm_domain && dev->pm_domain->activate) {
@@ -546,6 +546,8 @@ static int really_probe(struct device *dev, struct
device_driver *drv)
        goto done;

 probe_failed:
+       driver_sysfs_remove(dev);
+sysfs_failed:
        arch_teardown_dma_ops(dev);
 dma_failed:
        if (dev->bus)
@@ -554,7 +556,6 @@ static int really_probe(struct device *dev, struct
device_driver *drv)
 pinctrl_bind_failed:
        device_links_no_driver(dev);
        devres_release_all(dev);
-       driver_sysfs_remove(dev);
        dev->driver = NULL;
        dev_set_drvdata(dev, NULL);
        if (dev->pm_domain && dev->pm_domain->dismiss)




thanks,
-- 
js
suse labs
