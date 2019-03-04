Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B7CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097B020823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNtYlS9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCDOLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:11:35 -0500
Received: from mail-yw1-f43.google.com ([209.85.161.43]:38382 "EHLO
        mail-yw1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfCDOLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:11:35 -0500
Received: by mail-yw1-f43.google.com with SMTP id o184so4138014ywo.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/5CvE72hge+1VZASH6mM9+nM6QDF20zdbHqpANVln1w=;
        b=FNtYlS9q+PG8a3MWRt5JGODd3FexrWXdManez1BmUC5OF6rqhE6NeSVL60Kq0uRgFh
         SZW5LNbvL0mAu58XkKkOkVikACKTpOX8MHHihFeI+wStg7WpSWh7+g7JbUC5foHUcmCG
         d9ANA1SGu/WmyYOgx2nKQPhXveyMbZdiE6uUbK2DHilY7mBGY6f+17x6mfeQImungVBj
         1MDD/HeF4aNhVIbMNzoNeuoHjuhzL4GABlVfzrfLm4Lj0dW9orkx/lJEyOxjo1Qy8E/x
         HH8a/tELD45uMb6YtpGPRWEGLAzPFgbDwKw6DH7+FgUdtIFuktMiy3OdZ7J7F08DCAO1
         G3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/5CvE72hge+1VZASH6mM9+nM6QDF20zdbHqpANVln1w=;
        b=QbETyQMZQiCdvGgcWGPxS20a9IBq6/NU3LKeuIUx8gokyQvstu1OZNBK6HE5keswRr
         pnPlcQRaCt7EtdNuwrqeRJ7RbkNzawUCO9C2kBTDqNyXg3XmIjElho9hYuiCtt0lqLqM
         YBxUyocINSX/YzseQUxTSRn9ylj0guUNS0B/n5xjg+lB2+3ubfdRf3JYE9Ia/LDWKCRQ
         M63lNsyJAYAYDIr5fFmYXkTt1+nCo9tC8W25OpnJT/W6PRXTKYVgzU4O3EpGFBbzJTC6
         xBrTxgHp4+ItCpwEVlBlw1+rLKAPTj+yT2Hiq8JnKgQ5sLRC5DQa6wQp/yL3CypNM91W
         p47Q==
X-Gm-Message-State: APjAAAXEiXJV+/wNjTB0oT7Q0j+DJYk/wfcZTY2Yf2uVI6cqoEjIpQIB
        F4dauJjMcO7PGcA34SvI6QCevVIH1kOzTDe8rbQO5t2wBfA=
X-Google-Smtp-Source: APXvYqwShN3FtNu7j+OLHpZWT762H9dPY2PX/+qpIFRuRUy+MRa8XkPWUwo4+IEqqi1lk2LKubuxiASxBtdGS9B5PPs=
X-Received: by 2002:a25:35d5:: with SMTP id c204mr15509993yba.325.1551708693704;
 Mon, 04 Mar 2019 06:11:33 -0800 (PST)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Mon, 4 Mar 2019 15:11:22 +0100
Message-ID: <CADYN=9KkjPSP4KJ+AzG=Njq49zJ5fbWNZ4V_jOvHkq_kt0biyA@mail.gmail.com>
Subject: BUG: KASAN: i2c dev use after free
To:     erico.nunes@datacom.ind.br, wsa@the-dreams.de,
        dan.carpenter@oracle.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When running a kernel (from todays next-20190304) that has
CONFIG_KASAN and CONFIG_DEBUG_KOBJECT_RELEASE enabled I run into this
call trace:

[  494.752992][    C0]
==================================================================
[  494.755726][    C0] BUG: KASAN: use-after-free in
collect_expired_timers+0x174/0x1d8
[  494.758452][    C0] Write of size 8 at addr ffff800068868538 by
task swapper/0/0
[  494.761000][    C0]
[  494.761914][    C0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.0.0-rc8-next-20190301-00013-g4c430594824f #1
[  494.765290][    C0] Hardware name: linux,dummy-virt (DT)
[  494.767168][    C0] Call trace:
[  494.768358][    C0]  dump_backtrace+0x0/0x280
[  494.769970][    C0]  show_stack+0x28/0x38
[  494.771446][    C0]  dump_stack+0x110/0x190
[  494.772992][    C0]  print_address_description+0x2cc/0x308
[  494.774994][    C0]  kasan_report+0x164/0x1b0
[  494.776596][    C0]  __asan_store8+0x94/0xa0
[  494.778179][    C0]  collect_expired_timers+0x174/0x1d8
[  494.780059][    C0]  run_timer_softirq+0x184/0x3f8
[  494.781820][    C0]  __do_softirq+0x54c/0xa58
[  494.783408][    C0]  irq_exit+0x150/0x1d0
[  494.784892][    C0]  __handle_domain_irq+0x114/0x158
[  494.786709][    C0]  gic_handle_irq+0x90/0xf8
[  494.788293][    C0]  el1_irq+0x100/0x200
[  494.789768][    C0]  arch_cpu_idle+0x270/0x4f0
[  494.791398][    C0]  default_idle_call+0x48/0x58
[  494.793105][    C0]  do_idle+0x264/0x3e0
[  494.794568][    C0]  cpu_startup_entry+0x2c/0x30
[  494.796253][    C0]  rest_init+0x458/0x46c
[  494.797801][    C0]  arch_call_rest_init+0x18/0x20
[  494.799548][    C0]  start_kernel+0x6f4/0x734
[  494.801130][    C0]
[  494.801989][    C0] Allocated by task 1:
[  494.803453][    C0]  __kasan_kmalloc.isra.0+0xbc/0x178
[  494.805334][    C0]  kasan_kmalloc+0xc/0x18
[  494.806870][    C0]  kmem_cache_alloc_trace+0x56c/0x5c8
[  494.808752][    C0]  i2cdev_attach_adapter+0xc0/0x2c8
[  494.810612][    C0]  i2cdev_notifier_call+0x5c/0x90
[  494.812382][    C0]  notifier_call_chain+0x108/0x1b0
[  494.814214][    C0]  __blocking_notifier_call_chain+0x7c/0xb0
[  494.816271][    C0]  blocking_notifier_call_chain+0x40/0x50
[  494.818274][    C0]  device_add+0x884/0xc00
[  494.819820][    C0]  device_register+0x2c/0x38
[  494.821477][    C0]  i2c_register_adapter+0x27c/0x6f0
[  494.823295][    C0]  i2c_add_adapter+0x110/0x130
[  494.824980][    C0]  i2c_add_numbered_adapter+0x48/0x78
[  494.826899][    C0]  unittest_i2c_bus_probe+0x1a8/0x1f4
[  494.828778][    C0]  platform_drv_probe+0xd8/0x1a8
[  494.830741][    C0]  really_probe+0x424/0x840
[  494.832366][    C0]  driver_probe_device+0x16c/0x238
[  494.834216][    C0]  device_driver_attach+0x90/0xc0
[  494.835979][    C0]  __driver_attach+0x1e8/0x200
[  494.837697][    C0]  bus_for_each_dev+0xf8/0x190
[  494.839400][    C0]  driver_attach+0x3c/0x48
[  494.840986][    C0]  bus_add_driver+0x20c/0x3d0
[  494.842658][    C0]  driver_register+0x168/0x200
[  494.844369][    C0]  __platform_driver_register+0x84/0x90
[  494.846344][    C0]  of_unittest_overlay+0x1444/0x14e8
[  494.848200][    C0]  of_unittest+0x2034/0x28a4
[  494.849842][    C0]  do_one_initcall+0x490/0x9bc
[  494.851546][    C0]  kernel_init_freeable+0xb94/0xcc0
[  494.853398][    C0]  kernel_init+0x1c/0x204
[  494.854945][    C0]  ret_from_fork+0x10/0x18
[  494.856487][    C0]
[  494.857356][    C0] Freed by task 1:
[  494.858762][    C0]  __kasan_slab_free+0x140/0x200
[  494.860495][    C0]  kasan_slab_free+0x10/0x18
[  494.862116][    C0]  kfree+0x3f4/0x608
[  494.863457][    C0]  put_i2c_dev+0xc8/0xd8
[  494.864915][    C0]  i2cdev_detach_adapter+0x70/0xd8
[  494.866775][    C0]  i2cdev_notifier_call+0x74/0x90
[  494.868527][    C0]  notifier_call_chain+0x108/0x1b0
[  494.870292][    C0]  __blocking_notifier_call_chain+0x7c/0xb0
[  494.872204][    C0]  blocking_notifier_call_chain+0x40/0x50
[  494.874059][    C0]  device_del+0x108/0x5b0
[  494.875578][    C0]  device_unregister+0x78/0x98
[  494.877268][    C0]  i2c_del_adapter+0x36c/0x3c8
[  494.878820][    C0]  unittest_i2c_bus_remove+0x88/0xa0
[  494.880531][    C0]  platform_drv_remove+0x44/0x70
[  494.882211][    C0]  really_probe+0x488/0x840
[  494.883710][    C0]  driver_probe_device+0x16c/0x238
[  494.885514][    C0]  device_driver_attach+0x90/0xc0
[  494.887283][    C0]  __driver_attach+0x1e8/0x200
[  494.888910][    C0]  bus_for_each_dev+0xf8/0x190
[  494.890617][    C0]  driver_attach+0x3c/0x48
[  494.892179][    C0]  bus_add_driver+0x20c/0x3d0
[  494.893847][    C0]  driver_register+0x168/0x200
[  494.895489][    C0]  __platform_driver_register+0x84/0x90
[  494.897367][    C0]  of_unittest_overlay+0x1444/0x14e8
[  494.899235][    C0]  of_unittest+0x2034/0x28a4
[  494.900861][    C0]  do_one_initcall+0x490/0x9bc
[  494.902588][    C0]  kernel_init_freeable+0xb94/0xcc0
[  494.904429][    C0]  kernel_init+0x1c/0x204
[  494.905941][    C0]  ret_from_fork+0x10/0x18
[  494.907389][    C0]
[  494.908198][    C0] The buggy address belongs to the object at
ffff800068868480
[  494.908198][    C0]  which belongs to the cache kmalloc-512 of size 512
[  494.912942][    C0] The buggy address is located 184 bytes inside of
[  494.912942][    C0]  512-byte region [ffff800068868480, ffff800068868680)
[  494.917228][    C0] The buggy address belongs to the page:
[  494.919084][    C0] page:ffff7e0001a21a00 count:1 mapcount:0
mapping:ffff80003fc0c980 index:0x0 compound_mapcount: 0
[  494.922710][    C0] flags: 0xffff00000010200(slab|head)
[  494.924623][    C0] raw: 0ffff00000010200 ffff7e0001a21608
ffff7e0001a22588 ffff80003fc0c980
[  494.927501][    C0] raw: 0000000000000000 0000000000080008
00000001ffffffff 0000000000000000
[  494.930369][    C0] page dumped because: kasan: bad access detected
[  494.932528][    C0]
[  494.933358][    C0] Memory state around the buggy address:
[  494.935202][    C0]  ffff800068868400: fc fc fc fc fc fc fc fc fc
fc fc fc fc fc fc fc
[  494.937786][    C0]  ffff800068868480: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[  494.940516][    C0] >ffff800068868500: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[  494.943241][    C0]                                         ^
[  494.945291][    C0]  ffff800068868580: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[  494.948078][    C0]  ffff800068868600: fb fb fb fb fb fb fb fb fb
fb fb fb fb fb fb fb
[  494.950803][    C0]
==================================================================

I think patch introduced this issue d6760b14d4a1 ("i2c: dev: switch
from register_chrdev to cdev API")
and patch e6be18f6d62c ("i2c: dev: use after free in detach") tried to solve it.
However, when CONFIG_DEBUG_KOBJECT_RELEASE is enabled it delays
the ->release callback to make sure that anything that is done in release can
be done later than it happens in normal execution.
The cdev structure is supposed to be freed in the remove callback or after it,
but here it has already been freed by the put_i2c_dev().

Cheers,
Anders
