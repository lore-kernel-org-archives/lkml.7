Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C94C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB122184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 18:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTbacOGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCTS3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 14:29:24 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:52909 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfCTS3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 14:29:23 -0400
Received: by mail-it1-f179.google.com with SMTP id g17so395009ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=iaE2HwfnvBqASa/FXh8Gk9RfQ+V7UB0SRggYFhXlQmg=;
        b=OTbacOGD/d4BrnnFtIjg3PNncdi5zf5qF9ix6oN45JAcnWUza3HSYMjya4VBNni9kO
         l7FmWwV3qNO1yQRPjcYlxEDc73uUHegr4QCGiPnQG8xWMPFQW6/yN/A9Q7A6pKLAZxa7
         382C+s7zEHuLfIgTBt5g84TtNIULulYU9AbyNUZne9GcWXO9GhYNgqk7TPtDRB8KC49J
         C2uH3vZtsiI3hfMN0vGZcn3gCUZeXeVGiGI6jdmshYC8RMLlqjez7yT7aw46u9QuIqIO
         nQL6v5oSmD6A/cGIkTQJlI3mUR0T56eyqKTVwDZeiyx7ibwVJEQgcmvkh+Rw5gcAOpJ/
         d24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=iaE2HwfnvBqASa/FXh8Gk9RfQ+V7UB0SRggYFhXlQmg=;
        b=cahXNhNSW62UV72GNpfEn2KE3T7aiiy6Nsf+kZQKMV6kkxm0pBUFKE2lxedGMwswh5
         dMjDe8aHgV14cp1EyUz5twYa58FFqmff9+gj2wl4bmN0oYUOWOfwFOozUznzMM3Jwiwz
         ZupBBmo3db8uevL2UCQ8bHjVX9CSl6QcOFsVMUMB9cnCsNF6PECCPgs5HveL7+t5+mYv
         OT+aTOD/x8RwsbU6xk0IgZ45866D5g14BrR3NsEIvvnoJ21+cTwcKJnYNoxpBsEa9dqM
         AP6BxZ4Dl6eyNhmgbkjnxhyl4Q7BS/30skMAYeKM8fZFBsD2FDsthMw6Ftgc5Cjx+J4a
         ceHA==
X-Gm-Message-State: APjAAAWdQ1aoFqztor6D8nzCkCLNEhntLQXd/Hh9aPxDv3FudstU1T/T
        6KEhrspcHZSulZQHd341Wlo=
X-Google-Smtp-Source: APXvYqzCYwxx45wNGs1u1gUHwmSjmfoY0iHh4X/IopFRihY2SJMEs8mLqWVID6K4Y2fxBEJ+QUY2nA==
X-Received: by 2002:a24:978c:: with SMTP id k134mr5899968ite.67.1553106562302;
        Wed, 20 Mar 2019 11:29:22 -0700 (PDT)
Received: from tzanussi-mobl ([2601:246:0:7004:525:f36e:b522:a5fe])
        by smtp.googlemail.com with ESMTPSA id g186sm1630499iof.41.2019.03.20.11.29.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 11:29:21 -0700 (PDT)
Message-ID: <1553106560.2080.5.camel@gmail.com>
Subject: dell_smbios KASAN bug
From:   Tom Zanussi <tzanussi@gmail.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 20 Mar 2019 13:29:20 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

While looking into an unrelated problem, I hit this KASAN use-after-
free warning, so thought I'd let you know.

I have no idea how to fix it, but let me know if you need more info.

Thanks

Tom

[   23.330893] ==================================================================
[   23.330987] BUG: KASAN: use-after-free in dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   23.330999] Read of size 2 at addr ffff88840c2bc1a8 by task systemd-udevd/479

[   23.331020] CPU: 0 PID: 479 Comm: systemd-udevd Not tainted 5.1.0-rc1+ #9
[   23.331025] Hardware name: Dell Inc. XPS 13 9360/02PG84, BIOS 2.3.1 10/03/2017
[   23.331030] Call Trace:
[   23.331043]  dump_stack+0x7c/0xbb
[   23.331059]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   23.331068]  print_address_description+0xc7/0x280
[   23.331080]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   23.331090]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   23.331101]  kasan_report+0x14e/0x192
[   23.331121]  ? dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   23.331139]  dell_smbios_find_token+0x2e/0x80 [dell_smbios]
[   23.331161]  kbd_led_init+0x2e7/0x473 [dell_laptop]
[   23.331178]  ? dmi_matched+0x2a/0x2a [dell_laptop]
[   23.331188]  ? get_device_parent.isra.28+0x2a0/0x2a0
[   23.331202]  ? lockdep_init_map+0x98/0x2c0
[   23.331229]  ? platform_device_add+0x1b5/0x3a0
[   23.331256]  dell_init+0x4ad/0xb63 [dell_laptop]
[   23.331271]  ? kbd_led_init+0x473/0x473 [dell_laptop]
[   23.331290]  ? ___slab_alloc+0x61f/0x700
[   23.331298]  ? ___slab_alloc+0x61f/0x700
[   23.331318]  ? preempt_count_sub+0x15/0x100
[   23.331339]  ? kbd_led_init+0x473/0x473 [dell_laptop]
[   23.331348]  do_one_initcall+0xbd/0x3fd
[   23.331359]  ? perf_trace_initcall_level+0x280/0x280
[   23.331369]  ? kasan_unpoison_shadow+0x30/0x40
[   23.331380]  ? __kasan_kmalloc.constprop.8+0xa0/0xd0
[   23.331397]  ? kmem_cache_alloc_trace+0x163/0x390
[   23.331405]  ? kasan_unpoison_shadow+0x30/0x40
[   23.331428]  do_init_module+0xe3/0x341
[   23.331447]  load_module+0x2fc5/0x3ad0
[   23.331528]  ? layout_and_allocate+0x1170/0x1170
[   23.331541]  ? vfs_read+0xd4/0x1b0
[   23.331558]  ? kernel_read+0x74/0xa0
[   23.331577]  ? kernel_read_file+0x148/0x320
[   23.331614]  ? seccomp_notify_release+0x110/0x110
[   23.331652]  ? __do_sys_finit_module+0x192/0x1c0
[   23.331660]  __do_sys_finit_module+0x192/0x1c0
[   23.331670]  ? __ia32_sys_init_module+0x40/0x40
[   23.331697]  ? syscall_trace_enter+0x184/0x5e0
[   23.331739]  ? mark_held_locks+0x1a/0x90
[   23.331760]  do_syscall_64+0x72/0x220
[   23.331773]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   23.331781] RIP: 0033:0x7fcb4f5f5a49
[   23.331789] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0f b4 2c 00 f7 d8 64 89 01 48
[   23.331794] RSP: 002b:00007ffc73e340b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[   23.331802] RAX: ffffffffffffffda RBX: 00005599992bb850 RCX: 00007fcb4f5f5a49
[   23.331808] RDX: 0000000000000000 RSI: 00007fcb4f2e11c5 RDI: 0000000000000010
[   23.331813] RBP: 00007fcb4f2e11c5 R08: 0000000000000000 R09: 00005599992bb850
[   23.331819] R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
[   23.331824] R13: 0000559999298f40 R14: 0000000000020000 R15: 00005599992bb850

[   23.331873] Allocated by task 479:
[   23.331886]  __kasan_kmalloc.constprop.8+0xa0/0xd0
[   23.331893]  krealloc+0xa0/0xc0
[   23.331900]  0xffffffffc0cc0075
[   23.331909]  dmi_decode_table+0xf6/0x140
[   23.331915]  dmi_walk+0x46/0x70
[   23.331922]  0xffffffffc0cc0109
[   23.331928]  do_one_initcall+0xbd/0x3fd
[   23.331935]  do_init_module+0xe3/0x341
[   23.331941]  load_module+0x2fc5/0x3ad0
[   23.331948]  __do_sys_finit_module+0x192/0x1c0
[   23.331954]  do_syscall_64+0x72/0x220
[   23.331961]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   23.331975] Freed by task 479:
[   23.331985]  __kasan_slab_free+0x111/0x150
[   23.331990]  kfree+0xf5/0x350
[   23.331996]  0xffffffffc0cc01d4
[   23.332002]  do_one_initcall+0xbd/0x3fd
[   23.332009]  do_init_module+0xe3/0x341
[   23.332015]  load_module+0x2fc5/0x3ad0
[   23.332022]  __do_sys_finit_module+0x192/0x1c0
[   23.332028]  do_syscall_64+0x72/0x220
[   23.332035]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

[   23.332050] The buggy address belongs to the object at ffff88840c2bc1a8
                which belongs to the cache kmalloc-2k of size 2048
[   23.332061] The buggy address is located 0 bytes inside of
                2048-byte region [ffff88840c2bc1a8, ffff88840c2bc9a8)
[   23.332070] The buggy address belongs to the page:
[   23.332081] page:ffffea001030ae00 count:1 mapcount:0 mapping:ffff8884204113c0 index:0x0 compound_mapcount: 0
[   23.332091] flags: 0x17ffffc0010200(slab|head)
[   23.332100] raw: 0017ffffc0010200 ffffea0010367608 ffffea000ea31808 ffff8884204113c0
[   23.332106] raw: 0000000000000000 00000000000d000d 00000001ffffffff 0000000000000000
[   23.332111] page dumped because: kasan: bad access detected

[   23.332124] Memory state around the buggy address:
[   23.332134]  ffff88840c2bc080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.332145]  ffff88840c2bc100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   23.332155] >ffff88840c2bc180: fc fc fc fc fc fb fb fb fb fb fb fb fb fb fb fb
[   23.332164]                                   ^
[   23.332175]  ffff88840c2bc200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   23.332185]  ffff88840c2bc280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   23.332194] ==================================================================
