Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CFCECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40CE20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quQrLnOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbfJPJWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:22:12 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42274 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfJPJWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:22:12 -0400
Received: by mail-yw1-f66.google.com with SMTP id i207so8384463ywc.9;
        Wed, 16 Oct 2019 02:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fE2pjCnbjKZ4MlHeVN9jf9xQvMsEbh3Ui9qBwYYhdik=;
        b=quQrLnOXJ+Il6WrvPYFqz55r1v/b/zkH2rjO3kPNUeLava+9ZFcyGLJAY5MXYJrDG1
         gaOeuW9BiBU1vEhCnrzI8WIZbpQ0pUsTX1TugR8SOks/He43p/kFyM5y+mCbbGnL4tW/
         ph2pMfzCvj5cwTWv8DHkjobW3HNbvNDqIqfXhFfAizjdab3xiZDxEkvCd/OjK+HI92DD
         G+fA55tE/oHSzfX/qSVhBCmFqlCVgjz3gebmzQC5vrUO+BF3nP+V+44KiwMKKtMP5WeX
         AjLb8aHGJ6/VxKnkeLq+xncuj6W8yt4Mcxp3Zoi3bNccYWlLzdZNW4cu1smcH5wRBlaY
         w04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fE2pjCnbjKZ4MlHeVN9jf9xQvMsEbh3Ui9qBwYYhdik=;
        b=t2eSy2u5CL+/PSHmjoYHg1tsIoRE0EPpf938YrsEoh5GfrTYGSBJWlZrRavg8HCNz6
         xOO5XrNHyaBgDBkqaTAEUbALmVf23OsaX6VfgLek210oSerDmw6kz/LYHwTQqxZ7QN4u
         q6BzAXNxpYrLW1uLVoK9iq3/QaZF7jK8SOsV/OeLqtoAbBIEUfWOK7YskTcxvjiPKVUN
         IdyDNfSIMJWTdL+8WozPxYEDgadbKj7LQhgtsOKm0JiFxhzXHrFQAC8c0Z4ahjFqH1Ny
         QGnFexr81V+fnOai5AgF7uynPOM7Iw/cDkEQcNCE0tKKSMUYRoql26ZB1D9ST8pbilRe
         YycQ==
X-Gm-Message-State: APjAAAWkC3uxzY2H56dd4X3E5aSNoPv11NVSA7u5TWz7immZApzdLRaN
        LyKrtdjEz13GEhHx/A+IGIU+q5tZB6Ranb3Tquo=
X-Google-Smtp-Source: APXvYqy8YrQ7Fy9N0tSf6UnOVs5Y+XEEVGl5A6TEHhdSMmEJSPXvfJQR9YwZUrgWvsNk3tI/X/ypSn6EmXOCxoq1o/U=
X-Received: by 2002:a0d:fa01:: with SMTP id k1mr19961558ywf.326.1571217730743;
 Wed, 16 Oct 2019 02:22:10 -0700 (PDT)
MIME-Version: 1.0
From:   zzoru <zzoru007@gmail.com>
Date:   Wed, 16 Oct 2019 02:21:59 -0700
Message-ID: <CALRZ7UuEBvMtL6Q3TOKjXdh9B4X5bcHUdbO7i20TmPShZHmKZg@mail.gmail.com>
Subject: WARNING in __alloc_pages_nodemask
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        LKML <linux-kernel@vger.kernel.org>
Cc:     dokyungs@uci.edu, syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found the following crash on Linux 5.4-rc1 (Not patched in current
HEAD commit 3b1f00aceb7a67bf079a5a64aa5c6baf78a8f442)
with our customized syzkaller.

WARNING: CPU: 0 PID: 12 at linux/mm/page_alloc.c:4727
__alloc_pages_nodemask+0x333/0x760 linux/mm/page_alloc.c:4727
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.4.0-rc1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack linux/lib/dump_stack.c:77 [inline]
 dump_stack+0x7c/0xbb linux/lib/dump_stack.c:113
 panic+0x205/0x48e linux/kernel/panic.c:220
 __warn+0x19c/0x1c0 linux/kernel/panic.c:581
 report_bug+0x1a9/0x2b0 linux/lib/bug.c:195
 fixup_bug.part.11+0x32/0x80 linux/arch/x86/kernel/traps.c:179
 fixup_bug linux/arch/x86/include/asm/irqflags.h:54 [inline]
 do_error_trap+0xf5/0x160 linux/arch/x86/kernel/traps.c:272
 do_invalid_op+0x31/0x40 linux/arch/x86/kernel/traps.c:291
 invalid_op+0x23/0x30 linux/arch/x86/entry/entry_64.S:1028
RIP: 0010:__alloc_pages_nodemask+0x333/0x760 linux/mm/page_alloc.c:4727
Code: fe ff ff 65 48 8b 04 25 00 ef 01 00 48 05 68 10 00 00 41 bc 01
00 00 00 48 89 44 24 40 e9 2a fe ff ff 81 e7 00 20 00 00 75 02 <0f> 0b
45 31 e4 e9 6e ff ff ff 41 f7 c6 00 00 40 00 0f 84 2c ff ff
RSP: 0018:ffff88801a1a6f60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff11003434def RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000034 RDI: 0000000000000000
RBP: ffffffffffffff5e R08: ffffed1002d261a2 R09: dffffc0000000000
R10: 0000000000000001 R11: ffffed1002d261a1 R12: ffffffffffffff5e
R13: 0000000000000dc0 R14: ffff888017140000 R15: 0000000000000034
 alloc_pages linux/include/linux/gfp.h:509 [inline]
 kmalloc_order+0x16/0x50 linux/mm/slab_common.c:1294
 kmalloc_order_trace+0x18/0x110 linux/mm/slab_common.c:1306
 kmalloc linux/include/linux/slab.h:557 [inline]
 kzalloc linux/include/linux/slab.h:686 [inline]
 init_realtek_cr+0x2ec/0x1440 linux/drivers/usb/storage/realtek_cr.c:990
 usb_stor_acquire_resources linux/drivers/usb/storage/usb.c:784 [inline]
 usb_stor_probe2+0x738/0xbb0 linux/drivers/usb/storage/usb.c:1047
 realtek_cr_probe+0x9b/0xe0 linux/drivers/usb/storage/realtek_cr.c:1048
 usb_probe_interface+0x2b9/0x870 linux/drivers/usb/core/driver.c:361
 really_probe+0x444/0x830 linux/drivers/base/dd.c:548
 driver_probe_device+0xe3/0x250 linux/drivers/base/dd.c:721
 __device_attach_driver+0x17a/0x1e0 linux/drivers/base/dd.c:828
 bus_for_each_drv+0x143/0x1e0 linux/drivers/base/bus.c:430
 __device_attach+0x1f1/0x310 linux/drivers/base/dd.c:894
 bus_probe_device+0x1d7/0x280 linux/drivers/base/bus.c:490
 device_add+0xb72/0x1660 linux/drivers/base/core.c:2201
 usb_set_configuration+0xaca/0x1840 linux/drivers/usb/core/message.c:2023
 generic_probe+0x63/0xd0 linux/drivers/usb/core/generic.c:210
 usb_probe_device+0x89/0xd0 linux/drivers/usb/core/driver.c:266
 really_probe+0x444/0x830 linux/drivers/base/dd.c:548
 driver_probe_device+0xe3/0x250 linux/drivers/base/dd.c:721
 __device_attach_driver+0x17a/0x1e0 linux/drivers/base/dd.c:828
 bus_for_each_drv+0x143/0x1e0 linux/drivers/base/bus.c:430
 __device_attach+0x1f1/0x310 linux/drivers/base/dd.c:894
 bus_probe_device+0x1d7/0x280 linux/drivers/base/bus.c:490
 device_add+0xb72/0x1660 linux/drivers/base/core.c:2201
 usb_new_device+0x784/0x10d0 linux/drivers/usb/core/hub.c:2536
 hub_port_connect linux/drivers/usb/core/hub.c:5098 [inline]
 hub_port_connect_change linux/drivers/usb/core/hub.c:5213 [inline]
 port_event linux/drivers/usb/core/hub.c:5359 [inline]
 hub_event+0x18ed/0x3610 linux/drivers/usb/core/hub.c:5441
 process_one_work+0x8b5/0x17c0 linux/kernel/workqueue.c:2269
 worker_thread+0x82/0xb80 linux/kernel/workqueue.c:2415
 kthread+0x325/0x3e0 linux/kernel/kthread.c:255
 ret_from_fork+0x24/0x30 linux/arch/x86/entry/entry_64.S:352
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled

Following is my analysis of this bug. (Just add some comments in source code):

realtek_cr.c:
struct rts51x_chip {
    u16 vendor_id;
    u16 product_id;
    char max_lun; // char -> signed 1byte
    ...
}

static int init_realtek_cr(struct us_data *us)
{
    int size, i, retval;
    ...
    us->max_lun = chip->max_lun = rts51x_get_max_lun(us); // From USB
device (-127~126) Malicious usb device can manipulate this value.

    size = (chip->max_lun + 1) * sizeof(struct rts51x_status); // Can
be negative integer or 0 (-1+1).

    chip->status = kzalloc(size, GFP_KERNEL); //  kzalloc(0) ==
ZERO_SIZE_PTR or kzalloc(negative integer) -> Warning

    ...

    for (i = 0; i <= (int)(chip->max_lun); i++) {
        retval = rts51x_check_status(us, (u8) i);
        ...
    }
}

tatic int rts51x_check_status(struct us_data *us, u8 lun)
{
    struct rts51x_chip *chip = (struct rts51x_chip *)(us->extra);
    int retval;
    u8 buf[16];

    retval = rts51x_read_status(us, lun, buf, 16, &(chip->status_len));
    if (retval != STATUS_SUCCESS)
        return -EIO;

    usb_stor_dbg(us, "chip->status_len = %d\n", chip->status_len);

    chip->status[lun].vid = ((u16) buf[0] << 8) | buf[1]; //
ZERO_SIZE_PTR DEREFERENCE :(
    chip->status[lun].pid = ((u16) buf[2] << 8) | buf[3];
    chip->status[lun].cur_lun = buf[4];
    chip->status[lun].card_type = buf[5];
    chip->status[lun].total_lun = buf[6];
    chip->status[lun].fw_ver = ((u16) buf[7] << 8) | buf[8];
    chip->status[lun].phy_exist = buf[9];
    chip->status[lun].multi_flag = buf[10];
    chip->status[lun].multi_card = buf[11];
    chip->status[lun].log_exist = buf[12];
    if (chip->status_len == 16) {
        chip->status[lun].detailed_type.detailed_type1 = buf[13];
        chip->status[lun].function[0] = buf[14];
        chip->status[lun].function[1] = buf[15];
    }
    return 0;
}

Need to change a declaration of max_lun. (u8)
