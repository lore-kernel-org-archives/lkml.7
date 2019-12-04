Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BTC_ID,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312B0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A6C20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PY5OgnzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfLDKya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:54:30 -0500
Received: from mail-qk1-f178.google.com ([209.85.222.178]:41304 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:54:29 -0500
Received: by mail-qk1-f178.google.com with SMTP id g15so6642788qka.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 02:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UXlbnLzz9HES2vhv5tD/Nn8F6D/cgg2//ybv0zzSBu4=;
        b=PY5OgnzZ4Yu71ua3ifLEJX+TnVmFVZPPd+rDe3LYuHdkA2Q89ea7a/ydRQVhgmK3UO
         1oKJRNNK79gNEkGXJPPZeaT5S57B+d5qrQl2+vGw1lLV3E5qRzKYHBUV9FbdK8TSrgai
         VpKo3qDvmkg9AiAPPUjZ/gBLdtDTpUgT7kKXq33EjeLxxa+G71JQiQTq+oR94FbFHObp
         OYNyNauSEcBBfb2Di8jAdibSsH+rFtV2rMhq+8rtvoJKsiVvgtBgzH28zAxImU19H5wX
         6bkUpFHvK3wmYa3x23xHHzitD0A5TLTjmkKTuK/fA/IaZT6BZ3MBJ3kobNKuhxiYNgkX
         SgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UXlbnLzz9HES2vhv5tD/Nn8F6D/cgg2//ybv0zzSBu4=;
        b=eK37l2DI9n30RWrPNZbdFGcJz93eZesLJ3Oft3uPkx65ekrgf7Ep4MsWoj54KUYrI3
         UWZl5lUIhcChLd60W+5SPPjmpXK0P0Y50cOjRJkS3erzHPw7um/PUXbDA5/eihoC4D7o
         lTS0Hq1l5yp3ZknUGcMUa1WDFXXN385uWzlW6IeV0hjCG3UYpoOzDokLR5tmYNDIJC/1
         dWeAkVZozVQS4GRa2ffrdMya75vEd4tmcErrz+DuAAeZGcOUK48zPlakMutOJ3gd0HY9
         HUawKHpkCFMyfk/DsrrPkIaeoCokJilt94DzKQr0oSLcK2pQ6sc7qKvgBUwAHdhb73hY
         YNuA==
X-Gm-Message-State: APjAAAW4IFyLzT1OYh0MFIJgh7VlU/lWD3XtZuzxR+Z/obX9xOXI+LZo
        k1U3ynZ+6xy+BLamKqvuYuLVDS75eqm/Pp3s4Y83Sw==
X-Google-Smtp-Source: APXvYqzI5+IudYP6psb24pDdmt6InHaR+nukd19DyGQKbpxqUP9wI4CfgPkz/74ZbB0k0OAg/00CkKehF8XeADp09tk=
X-Received: by 2002:a37:e312:: with SMTP id y18mr2229324qki.250.1575456868384;
 Wed, 04 Dec 2019 02:54:28 -0800 (PST)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 4 Dec 2019 11:54:17 +0100
Message-ID: <CACT4Y+YjudGzx44Jw1UMgEPB4kfzp3jo-TcCVR62U+N+2C6tjA@mail.gmail.com>
Subject: cirrusfb: divide errors in cirrusfb_check_var/cirrusfb_check_pixclock/cirrusfb_set_par_foo
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzkaller has found 3 of divide errors in the cirrusfb driver.
Kernel is on c5db92909bedd Add linux-next specific files for 20191202.

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8133 Comm: syz-executor.5 Not tainted 5.4.0-next-20191202+ #13
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cirrusfb_set_par_foo+0x1d17/0x64b0 drivers/video/fbdev/cirrusfb.c:836
Call Trace:
 cirrusfb_set_par+0x15/0x20 drivers/video/fbdev/cirrusfb.c:1272
 fb_set_var+0x518/0xdd0 drivers/video/fbdev/core/fbmem.c:1024
 do_fb_ioctl+0x50c/0x830 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x1df/0x1420 fs/ioctl.c:732
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:749

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 3 PID: 7639 Comm: syz-executor.0 Not tainted 5.4.0-next-20191202+ #12
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cirrusfb_check_pixclock drivers/video/fbdev/cirrusfb.c:482 [inline]
RIP: 0010:cirrusfb_check_var+0x6e8/0x1150 drivers/video/fbdev/cirrusfb.c:623
Call Trace:
 fb_set_var+0x236/0xdd0 drivers/video/fbdev/core/fbmem.c:1005
 do_fb_ioctl+0x50c/0x830 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x1df/0x1420 fs/ioctl.c:732
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:749

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 12555 Comm: syz-executor.5 Not tainted 5.4.0-next-20191202+ #15
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:cirrusfb_check_var.cold.16+0x12e/0x1e7
drivers/video/fbdev/cirrusfb.c:581
Call Trace:
 fb_set_var+0x236/0xdd0 drivers/video/fbdev/core/fbmem.c:1005
 do_fb_ioctl+0x50c/0x830 drivers/video/fbdev/core/fbmem.c:1104
 fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
 vfs_ioctl fs/ioctl.c:47 [inline]
 file_ioctl fs/ioctl.c:545 [inline]
 do_vfs_ioctl+0x1df/0x1420 fs/ioctl.c:732
 ksys_ioctl+0xa9/0xd0 fs/ioctl.c:749
