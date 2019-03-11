Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B83C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4A22075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jOj69wC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCKOSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:18:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35190 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfCKOSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:18:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id g19so4173662edp.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyKUSzt7DHhz71coUrSDPkRMY/G4XTLO/TQVB0v5z8c=;
        b=jOj69wC0YiteOF0EPrLcAINmr9S8PIWJZfuOUZ5204JftK0L7R08B2bZ2MzwY952va
         y0j5R7q1+QR9qmgUnvI13WTYVWv6Xng8ahuNC7jVeeJ/cW5FYYDcNe/yo3EqSREyt6eZ
         uvMs/ExgV47EUnyjQSkukCRj52R01M0QO9IFDaoAWtcxrKRILZ5YL5N8R9+guMNvVXGw
         70F8lqKoIhMxxHU8WTXVsTU/ucFUeaBfsLFumz3JFvbNuJF4Kh3OH2dSqWrU5siOumjl
         XH5xzN0u8JqE58kPzRPncuPuy0CZLtFy+CMPKsmSrI296gaVq8gvsFS/IYvohQobTzfM
         g4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyKUSzt7DHhz71coUrSDPkRMY/G4XTLO/TQVB0v5z8c=;
        b=LBlZLmJKZ71iEoqQAWDhbBvJoFFtUbOh+MqE/7FGKCx9g6vK/GOmhoAzWMdDNlbIwl
         FRtjf8WhTum5pAPL1d4K1MGbrZMdzVNnH5bMi6ItVUZX57DasZupVXOU+CsXXa367NKY
         ByyMFTMI7wKU7TB6DEbtd64sjP7kXH8ezFPs/ykJLNZiIkdAKwMmwjk4iTO21khm4KYy
         fiJuWI07/SDqVGzEf1KNM3PHBU84457cvyGps/0ON5xJT3JLpPruYiSgC/6G49QzuLzy
         8yPfMFBrfjfq6GdvCEJoRuLPxtfkTUdJQD0LvhQVtgLY163c7FKlRnHMxzW/2Fe/N/NU
         UjFw==
X-Gm-Message-State: APjAAAXS4+OA4MLxMRkNFBD04pvyx9wp0peQJUGF+nqkFj/1Z9lCLg81
        AUhUCVaR4FA2/tM/NXjNckpEjESoL26vGIo/gpYzJw==
X-Google-Smtp-Source: APXvYqzoYxfrh7tx1i8+BPoT0+yN/H07FqSer7/M2IbA0GYaGRFbbxo+2f79H/l9qdOcTbm+vLJt31juPO4cr5jU7D8=
X-Received: by 2002:a17:906:4ada:: with SMTP id u26mr22425568ejt.191.1552313907972;
 Mon, 11 Mar 2019 07:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
 <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org> <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
 <7c37c201-8bca-ffa4-5e8d-5e0b4b268b3f@kernel.org> <CACT4Y+ZV2aMWjobgV=-aUdSLnGU=_2yuf2TOx4TD8ApoVqRVYw@mail.gmail.com>
 <CACT4Y+abRq25axHrxNczh7sVw2RjYJB8y7JOBmyMmVF5xJ+Y1w@mail.gmail.com>
In-Reply-To: <CACT4Y+abRq25axHrxNczh7sVw2RjYJB8y7JOBmyMmVF5xJ+Y1w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Mar 2019 15:18:15 +0100
Message-ID: <CACT4Y+a2aQ31MVxtb0hYZ0mxaXLVmhgeP2iE5gFQgmafv3p7gw@mail.gmail.com>
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     Shuah Khan <shuah@kernel.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, Sep 7, 2018 at 6:25 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Sep 7, 2018 at 6:20 PM, Shuah Khan <shuah@kernel.org> wrote:
> > > On 09/07/2018 10:14 AM, Dmitry Vyukov wrote:
> > >> On Fri, Sep 7, 2018 at 6:03 PM, Shuah Khan <shuah@kernel.org> wrote:
> > >>> Hi Dmitry,
> > >>>
> > >>> On 09/07/2018 04:54 AM, Dmitry Vyukov wrote:
> > >>>> Hi,
> > >>>>
> > >>>> I am getting the following error while booting kernel on upstream
> > >>>> commit a49a9dcce802b3651013f659813df1361d306172, config is attached.
> > >>>> Seems there is some kind of resource leak.
> > >>>>
> > >>>> Thanks
> > >>>
> > >>> Odd. This commit has nothing to do with vudc.
> > >>
> > >> This is not the guilty commit, I just described state of my tree.
> > >>
> > >
> > > Can you send me the full dmesg?
> >
> > Here it is:
> >
> > https://gist.githubusercontent.com/dvyukov/e9dec59fb23da9cedd8ab07a7d8c78ae/raw/3ee13c7a1f406c9927ca3b16db262f2c78e84536/gistfile1.txt
>
> Hello,
>
> The boot seems to be fixed now, but what commit fixed it?
>
> This bug makes all kernels starting from 4.14 unbootable for the
> purposes of bisection. If we figure out what was the bug and what
> fixed it, we can think of possible ways of unbreaking kernel boot.


Booting 4.14 I am actually seeing a double-free but assuming it's the same bug.

[    6.527072] ==================================================================
[    6.527913] BUG: KASAN: double-free or invalid-free in
usb_add_gadget_udc_release+0x6f8/0x980
[    6.528898]
[    6.529081] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 4.14.0 #4
[    6.529769] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.10.2-1 04/01/2014
[    6.530330] Call Trace:
[    6.530330]  dump_stack+0x194/0x25a
[    6.530330]  ? arch_local_irq_restore+0x53/0x53
[    6.530330]  ? show_regs_print_info+0x65/0x65
[    6.530330]  ? usb_add_gadget_udc_release+0x6f8/0x980
[    6.530330]  print_address_description+0xd4/0x230
[    6.530330]  ? usb_add_gadget_udc_release+0x6f8/0x980
[    6.530330]  ? usb_add_gadget_udc_release+0x6f8/0x980
[    6.530330]  kasan_report_double_free+0x55/0x80
[    6.530330]  kasan_slab_free+0xa3/0xc0
[    6.530330]  kfree+0xcc/0x270
[    6.530330]  usb_add_gadget_udc_release+0x6f8/0x980
[    6.530330]  ? __lockdep_init_map+0xe4/0x650
[    6.530330]  ? check_pending_gadget_drivers+0x480/0x480
[    6.530330]  ? lockdep_init_map+0x9/0x10
[    6.530330]  ? init_timer_key+0x146/0x410
[    6.530330]  ? init_timer_on_stack_key+0xb0/0xb0
[    6.530330]  ? __raw_spin_lock_init+0x1c/0x100
[    6.530330]  ? trace_hardirqs_on_caller+0x421/0x5c0
[    6.530330]  ? __lockdep_init_map+0xe4/0x650
[    6.530330]  usb_add_gadget_udc+0x1f/0x30
[    6.530330]  vudc_probe+0x8bd/0xcb0
[    6.530330]  ? put_vudc_device+0x50/0x50
[    6.530330]  ? do_raw_spin_trylock+0x190/0x190
[    6.530330]  ? _raw_spin_unlock+0x2c/0x50
[    6.530330]  ? devices_kset_move_last+0x280/0x3a0
[    6.530330]  ? lock_device_hotplug_sysfs+0x50/0x50
[    6.530330]  ? is_acpi_device_node+0x5a/0x70
[    6.530330]  ? acpi_dev_pm_attach+0x187/0x1f0
[    6.530330]  ? put_vudc_device+0x50/0x50
[    6.530330]  ? platform_drv_remove+0xa0/0xa0
[    6.530330]  platform_drv_probe+0x8f/0x170
[    6.530330]  driver_probe_device+0x63c/0xa20
[    6.530330]  ? driver_probe_done+0xe0/0xe0
[    6.530330]  ? do_raw_spin_unlock+0x1ec/0x300
[    6.530330]  ? do_raw_spin_trylock+0x190/0x190
[    6.530330]  ? acpi_of_match_device+0x1cb/0x250
[    6.530330]  ? platform_match+0x82/0x280
[    6.530330]  ? __driver_attach+0x1c0/0x1c0
[    6.530330]  __device_attach_driver+0x1c7/0x290
[    6.530330]  bus_for_each_drv+0x148/0x1d0
[    6.530330]  ? bus_rescan_devices+0x30/0x30
[    6.530330]  ? _raw_spin_unlock_irqrestore+0xa6/0xe0
[    6.530330]  __device_attach+0x271/0x3d0
[    6.530330]  ? device_bind_driver+0xd0/0xd0
[    6.530330]  ? kobject_uevent_env+0x29f/0xe20
[    6.530330]  ? blocking_notifier_call_chain+0x112/0x190
[    6.530330]  device_initial_probe+0x1a/0x20
[    6.530330]  bus_probe_device+0x1e7/0x290
[    6.530330]  device_add+0xcf9/0x1640
[    6.530330]  ? device_private_init+0x230/0x230
[    6.530330]  ? arch_setup_pdev_archdata+0x9/0x10
[    6.530330]  ? platform_device_alloc+0xd0/0x100
[    6.530330]  ? usbip_host_init+0x123/0x123
[    6.530330]  platform_device_add+0x31e/0x660
[    6.530330]  ? usbip_host_init+0x123/0x123
[    6.530330]  init+0x12d/0x335
[    6.530330]  ? usbip_host_init+0x123/0x123
[    6.530330]  ? vhci_hcd_init+0x432/0x432
[    6.530330]  ? sysfs_create_file_ns+0x86/0xb0
[    6.530330]  ? driver_create_file+0x4c/0x70
[    6.530330]  ? usbip_host_init+0x123/0x123
[    6.530330]  do_one_initcall+0x9e/0x330
[    6.530330]  ? arch_local_save_flags+0x50/0x50
[    6.530330]  ? down_write_nested+0xd0/0x120
[    6.530330]  ? kasan_unpoison_shadow+0x35/0x50
[    6.530330]  kernel_init_freeable+0x469/0x521
[    6.530330]  ? rest_init+0x100/0x100
[    6.530330]  kernel_init+0x13/0x172
[    6.530330]  ? rest_init+0x100/0x100
[    6.530330]  ret_from_fork+0x2a/0x40
[    6.530330]
[    6.530330] Allocated by task 1:
[    6.530330]  save_stack_trace+0x16/0x20
[    6.530330]  save_stack+0x43/0xd0
[    6.530330]  kasan_kmalloc+0xad/0xe0
[    6.530330]  kmem_cache_alloc_trace+0x136/0x780
[    6.530330]  usb_add_gadget_udc_release+0x22b/0x980
[    6.530330]  usb_add_gadget_udc+0x1f/0x30
[    6.530330]  vudc_probe+0x8bd/0xcb0
[    6.530330]  platform_drv_probe+0x8f/0x170
[    6.530330]  driver_probe_device+0x63c/0xa20
[    6.530330]  __device_attach_driver+0x1c7/0x290
[    6.530330]  bus_for_each_drv+0x148/0x1d0
[    6.530330]  __device_attach+0x271/0x3d0
[    6.530330]  device_initial_probe+0x1a/0x20
[    6.530330]  bus_probe_device+0x1e7/0x290
[    6.530330]  device_add+0xcf9/0x1640
[    6.530330]  platform_device_add+0x31e/0x660
[    6.530330]  init+0x12d/0x335
[    6.530330]  do_one_initcall+0x9e/0x330
[    6.530330]  kernel_init_freeable+0x469/0x521
[    6.530330]  kernel_init+0x13/0x172
[    6.530330]  ret_from_fork+0x2a/0x40
[    6.530330]
[    6.530330] Freed by task 1:
[    6.530330]  save_stack_trace+0x16/0x20
[    6.530330]  save_stack+0x43/0xd0
[    6.530330]  kasan_slab_free+0x71/0xc0
[    6.530330]  kfree+0xcc/0x270
[    6.530330]  usb_udc_release+0x16/0x20
[    6.530330]  device_release+0x7c/0x200
[    6.530330]  kobject_put+0x26e/0x400
[    6.530330]  put_device+0x20/0x30
[    6.530330]  usb_add_gadget_udc_release+0x6e3/0x980
[    6.530330]  usb_add_gadget_udc+0x1f/0x30
[    6.530330]  vudc_probe+0x8bd/0xcb0
[    6.530330]  platform_drv_probe+0x8f/0x170
[    6.530330]  driver_probe_device+0x63c/0xa20
[    6.530330]  __device_attach_driver+0x1c7/0x290
[    6.530330]  bus_for_each_drv+0x148/0x1d0
[    6.530330]  __device_attach+0x271/0x3d0
[    6.530330]  device_initial_probe+0x1a/0x20
[    6.530330]  bus_probe_device+0x1e7/0x290
[    6.530330]  device_add+0xcf9/0x1640
[    6.530330]  platform_device_add+0x31e/0x660
[    6.530330]  init+0x12d/0x335
[    6.530330]  do_one_initcall+0x9e/0x330
[    6.530330]  kernel_init_freeable+0x469/0x521
[    6.530330]  kernel_init+0x13/0x172
[    6.530330]  ret_from_fork+0x2a/0x40
[    6.530330]
[    6.530330] The buggy address belongs to the object at ffff8800675bed00
[    6.530330]  which belongs to the cache kmalloc-2048 of size 2048
[    6.530330] The buggy address is located 0 bytes inside of
[    6.530330]  2048-byte region [ffff8800675bed00, ffff8800675bf500)
[    6.530330] The buggy address belongs to the page:
[    6.530330] page:ffffea00019d6f80 count:1 mapcount:0
mapping:ffff8800675be480 index:0x0 compound_mapcount: 0
[    6.530330] flags: 0x1fffc0000008100(slab|head)
[    6.530330] raw: 01fffc0000008100 ffff8800675be480 0000000000000000
0000000100000003
[    6.530330] raw: ffffea00018c8620 ffffea00019d70a0 ffff88006c000c40
0000000000000000
[    6.530330] page dumped because: kasan: bad access detected
[    6.530330]
[    6.530330] Memory state around the buggy address:
[    6.530330]  ffff8800675bec00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    6.530330]  ffff8800675bec80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    6.530330] >ffff8800675bed00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    6.530330]                    ^
[    6.530330]  ffff8800675bed80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    6.530330]  ffff8800675bee00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    6.530330] ==================================================================
