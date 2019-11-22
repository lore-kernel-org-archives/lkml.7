Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3052CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56F62071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 15:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oKs4Z5Sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfKVPGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:06:24 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39080 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 10:06:23 -0500
Received: by mail-qt1-f194.google.com with SMTP id t8so8160524qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 07:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=OmzPhk5Yyy7WolfhIXiZJLsVO7n+CH8VihE0LLeqRTQ=;
        b=oKs4Z5SlBXUmL/uMk286NbOKufC/Y+aGw0d7HrAQcGeV7i2dRuJOnB/N1ZgTFFBzOt
         ZoU+iNhGTnAut3ksC6+0vuAufn12yeMmU97A4WlUCACClJ97evqlF4K42VkwF2ibDd5g
         d2RS2uwVSZbaZ2nK44z9kaZG/SGD5fnfE1xJJPa8WLx4HFwaHrDNdcso+t+Y1FYc56rM
         xpNyO7j7G6M7iJs3nPzpM2clszt8Cd4Y7QS7TefUWWBtuEbRzRe6RHyeQeOCggERp4VS
         /d24jTqh5u7WctddAs1x2FtZz1U/ssXdMOVUatStlRjx8yBq4xuUALt9fd/ar4Xj0w/J
         YI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=OmzPhk5Yyy7WolfhIXiZJLsVO7n+CH8VihE0LLeqRTQ=;
        b=GS/yLk2VZZFG8Jt6Xz0pXGL2YESlZzXFLg+eAU4gw98qsmMUBk1sRQfDCOjUYeOC8j
         DSLprsBYuSxszESikO9XihS61G/BX2dyrQhGqQWyg+LlYrAqj6IoYqkm+nwaDJDaQrtA
         4ipwlNf7pOYfIZFnfoh+idukPDaxA2PDij2HDv4jhqZFdpq5+3G829xxJrucvaqSolw5
         8z4EdkFepM36q5yQLFq5oKsFl1yYcwVaqaJZx25y983Eb0ze2AtBTlQxi4JAXmN2aJxM
         +9T9YhINofcQqv/377OwEZyozKvo4619U+Gpi+vt/AARjfC1HJQuWC7/d6s7rLLoQuuE
         1jNw==
X-Gm-Message-State: APjAAAV7r8h+zAPhwzOr9aCbu7E/46pSUgZKfGPiq7YPbyfz+gj8Uk7m
        sEWJYKL+VQzFnKLmtt2pE9JSEw==
X-Google-Smtp-Source: APXvYqzCevE0A/1bfl+JMaiiwfk+z2ye83k9BU4q7Y44lJg6cBIrsRO/uTBPuppULvSxOYhk8bpSqQ==
X-Received: by 2002:ac8:7a83:: with SMTP id x3mr3837022qtr.141.1574435181217;
        Fri, 22 Nov 2019 07:06:21 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h186sm3105239qkf.64.2019.11.22.07.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 07:06:20 -0800 (PST)
Message-ID: <1574435179.9585.21.camel@lca.pw>
Subject: "Revisit iommu_insert_resv_region() implementation" causes
 use-after-free
From:   Qian Cai <cai@lca.pw>
To:     Joerg Roedel <jroedel@suse.de>, Eric Auger <eric.auger@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 Nov 2019 10:06:19 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read files under /sys/kernel/iommu_groups/ triggers an use-after-free. Reverted
the commit 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
implementation") fixed the issue.

/* no merge needed on elements of different types than @nr */
if (iter->type != nr->type) {
	list_move_tail(&iter->list, &stack);
	continue;

[  160.156964][ T3100] BUG: KASAN: use-after-free in
iommu_insert_resv_region+0x34b/0x520
[  160.197758][ T3100] Read of size 4 at addr ffff8887aba78464 by task cat/3100
[  160.230645][ T3100] 
[  160.240907][ T3100] CPU: 14 PID: 3100 Comm: cat Not tainted 5.4.0-rc8-next-
20191122+ #11
[  160.278671][ T3100] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
Gen9, BIOS U19 12/27/2015
[  160.320589][ T3100] Call Trace:
[  160.335229][ T3100]  dump_stack+0xa0/0xea
[  160.354011][ T3100]  print_address_description.constprop.5.cold.7+0x9/0x384
[  160.386569][ T3100]  __kasan_report.cold.8+0x7a/0xc0
[  160.409811][ T3100]  ? iommu_insert_resv_region+0x34b/0x520
[  160.435668][ T3100]  kasan_report+0x12/0x20
[  160.455387][ T3100]  __asan_load4+0x95/0xa0
[  160.474808][ T3100]  iommu_insert_resv_region+0x34b/0x520
[  160.500228][ T3100]  ? iommu_bus_notifier+0xe0/0xe0
[  160.522904][ T3100]  ? intel_iommu_get_resv_regions+0x348/0x400
[  160.550461][ T3100]  iommu_get_group_resv_regions+0x16d/0x2f0
[  160.577611][ T3100]  ? iommu_insert_resv_region+0x520/0x520
[  160.603756][ T3100]  ? register_lock_class+0x940/0x940
[  160.628265][ T3100]  iommu_group_show_resv_regions+0x8d/0x1f0
[  160.655370][ T3100]  ? iommu_get_group_resv_regions+0x2f0/0x2f0
[  160.684168][ T3100]  iommu_group_attr_show+0x34/0x50
[  160.708395][ T3100]  sysfs_kf_seq_show+0x11c/0x220
[  160.731758][ T3100]  ? iommu_default_passthrough+0x20/0x20
[  160.756898][ T3100]  kernfs_seq_show+0xa4/0xb0
[  160.777097][ T3100]  seq_read+0x27e/0x710
[  160.795195][ T3100]  kernfs_fop_read+0x7d/0x2c0
[  160.815349][ T3100]  __vfs_read+0x50/0xa0
[  160.834154][ T3100]  vfs_read+0xcb/0x1e0
[  160.852332][ T3100]  ksys_read+0xc6/0x160
[  160.871028][ T3100]  ? kernel_write+0xc0/0xc0
[  160.891307][ T3100]  ? do_syscall_64+0x79/0xaec
[  160.912446][ T3100]  ? do_syscall_64+0x79/0xaec
[  160.933640][ T3100]  __x64_sys_read+0x43/0x50
[  160.953957][ T3100]  do_syscall_64+0xcc/0xaec
[  160.974322][ T3100]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[  160.999130][ T3100]  ? syscall_return_slowpath+0x580/0x580
[  161.024753][ T3100]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xbe
[  161.052416][ T3100]  ? trace_hardirqs_off_caller+0x3a/0x150
[  161.078400][ T3100]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[  161.103711][ T3100]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  161.130793][ T3100] RIP: 0033:0x7f33e0d89d75
[  161.150732][ T3100] Code: fe ff ff 50 48 8d 3d 4a dc 09 00 e8 25 0e 02 00 0f
1f 44 00 00 f3 0f 1e fa 48 8d 05 a5 59 2d 00 8b 00 85 c0 75 0f 31 c0 0f 05 <48>
3d 00 f0 ff ff 77 53 c3 66 90 41 54 49 89 d4 55 48 89 f5 53 89
[  161.245503][ T3100] RSP: 002b:00007fff88f0db88 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[  161.284547][ T3100] RAX: ffffffffffffffda RBX: 0000000000020000 RCX:
00007f33e0d89d75
[  161.321123][ T3100] RDX: 0000000000020000 RSI: 00007f33e1201000 RDI:
0000000000000003
[  161.357617][ T3100] RBP: 00007f33e1201000 R08: 00000000ffffffff R09:
0000000000000000
[  161.394173][ T3100] R10: 0000000000000022 R11: 0000000000000246 R12:
00007f33e1201000
[  161.430736][ T3100] R13: 0000000000000003 R14: 0000000000000fff R15:
0000000000020000
[  161.467337][ T3100] 
[  161.477529][ T3100] Allocated by task 3100:
[  161.497133][ T3100]  save_stack+0x21/0x90
[  161.515777][ T3100]  __kasan_kmalloc.constprop.13+0xc1/0xd0
[  161.541743][ T3100]  kasan_kmalloc+0x9/0x10
[  161.561330][ T3100]  kmem_cache_alloc_trace+0x1f8/0x470
[  161.585949][ T3100]  iommu_insert_resv_region+0xeb/0x520
[  161.610876][ T3100]  iommu_get_group_resv_regions+0x16d/0x2f0
[  161.638318][ T3100]  iommu_group_show_resv_regions+0x8d/0x1f0
[  161.665322][ T3100]  iommu_group_attr_show+0x34/0x50
[  161.688526][ T3100]  sysfs_kf_seq_show+0x11c/0x220
[  161.711992][ T3100]  kernfs_seq_show+0xa4/0xb0
[  161.734252][ T3100]  seq_read+0x27e/0x710
[  161.754412][ T3100]  kernfs_fop_read+0x7d/0x2c0
[  161.775493][ T3100]  __vfs_read+0x50/0xa0
[  161.794328][ T3100]  vfs_read+0xcb/0x1e0
[  161.812559][ T3100]  ksys_read+0xc6/0x160
[  161.831554][ T3100]  __x64_sys_read+0x43/0x50
[  161.851772][ T3100]  do_syscall_64+0xcc/0xaec
[  161.872098][ T3100]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  161.898919][ T3100] 
[  161.909113][ T3100] Freed by task 3100:
[  161.927070][ T3100]  save_stack+0x21/0x90
[  161.945711][ T3100]  __kasan_slab_free+0x11c/0x170
[  161.968112][ T3100]  kasan_slab_free+0xe/0x10
[  161.988601][ T3100]  slab_free_freelist_hook+0x5f/0x1d0
[  162.012918][ T3100]  kfree+0xe9/0x410
[  162.029454][ T3100]  iommu_insert_resv_region+0x47d/0x520
[  162.053701][ T3100]  iommu_get_group_resv_regions+0x16d/0x2f0
[  162.079671][ T3100]  iommu_group_show_resv_regions+0x8d/0x1f0
[  162.105484][ T3100]  iommu_group_attr_show+0x34/0x50
[  162.127709][ T3100]  sysfs_kf_seq_show+0x11c/0x220
[  162.149250][ T3100]  kernfs_seq_show+0xa4/0xb0
[  162.169085][ T3100]  seq_read+0x27e/0x710
[  162.187038][ T3100]  kernfs_fop_read+0x7d/0x2c0
[  162.207391][ T3100]  __vfs_read+0x50/0xa0
[  162.227829][ T3100]  vfs_read+0xcb/0x1e0
[  162.247788][ T3100]  ksys_read+0xc6/0x160
[  162.265471][ T3100]  __x64_sys_read+0x43/0x50
[  162.285041][ T3100]  do_syscall_64+0xcc/0xaec
[  162.304627][ T3100]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  162.330429][ T3100] 
[  162.340199][ T3100] The buggy address belongs to the object at
ffff8887aba78440
[  162.340199][ T3100]  which belongs to the cache kmalloc-64 of size 64
[  162.402050][ T3100] The buggy address is located 36 bytes inside of
[  162.402050][ T3100]  64-byte region [ffff8887aba78440, ffff8887aba78480)
[  162.460127][ T3100] The buggy address belongs to the page:
[  162.484696][ T3100] page:ffffea001eae9e00 refcount:1 mapcount:0
mapping:ffff888207c02ac0 index:0xffff8887aba78e40
[  162.531045][ T3100] raw: 015fffe000000200 ffff888487c00740 ffff888487c00740
ffff888207c02ac0
[  162.569455][ T3100] raw: ffff8887aba78e40 0000000000080003 00000001ffffffff
0000000000000000
[  162.607801][ T3100] page dumped because: kasan: bad access detected
[  162.636603][ T3100] page_owner tracks the page as allocated
[  162.661634][ T3100] page last allocated via order 0, migratetype Unmovable,
gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY)
[  162.716310][ T3100]  prep_new_page+0x2ed/0x310
[  162.739158][ T3100]  get_page_from_freelist+0x20bb/0x3090
[  162.765017][ T3100]  __alloc_pages_nodemask+0x2e4/0x720
[  162.788440][ T3100]  alloc_pages_current+0x9c/0x110
[  162.810324][ T3100]  alloc_slab_page+0xc9/0x4e0
[  162.831044][ T3100]  allocate_slab+0x70/0x5d0
[  162.851450][ T3100]  new_slab+0x46/0x70
[  162.869326][ T3100]  ___slab_alloc+0x4ab/0x7b0
[  162.889554][ T3100]  __slab_alloc+0x43/0x70
[  162.908430][ T3100]  kmem_cache_alloc_trace+0x2f1/0x470
[  162.932036][ T3100]  iommu_insert_resv_region+0xeb/0x520
[  162.956179][ T3100]  iommu_get_group_resv_regions+0x16d/0x2f0
[  162.982083][ T3100]  iommu_group_show_resv_regions+0x8d/0x1f0
[  163.008373][ T3100]  iommu_group_attr_show+0x34/0x50
[  163.030557][ T3100]  sysfs_kf_seq_show+0x11c/0x220
[  163.052038][ T3100]  kernfs_seq_show+0xa4/0xb0
[  163.072179][ T3100] page last free stack trace:
[  163.092612][ T3100]  __free_pages_ok+0xa3e/0xb20
[  163.113361][ T3100]  __free_pages+0x94/0xd0
[  163.132198][ T3100]  __free_slab+0x177/0x520
[  163.150922][ T3100]  discard_slab+0x41/0x80
[  163.169708][ T3100]  __slab_free+0x4b7/0x520
[  163.188856][ T3100]  ___cache_free+0xc3/0x120
[  163.208452][ T3100]  qlist_free_all+0x44/0xa0
[  163.228335][ T3100]  quarantine_reduce+0x1b0/0x240
[  163.253120][ T3100]  __kasan_kmalloc.constprop.13+0x98/0xd0
[  163.279865][ T3100]  kasan_slab_alloc+0x11/0x20
[  163.300175][ T3100]  kmem_cache_alloc+0x17a/0x450
[  163.321373][ T3100]  ptlock_alloc+0x20/0x50
[  163.340168][ T3100]  pte_alloc_one+0x40/0xf0
[  163.359310][ T3100]  __handle_mm_fault+0x1257/0x1300
[  163.381603][ T3100]  handle_mm_fault+0x205/0x4c0
[  163.402312][ T3100]  __do_page_fault+0x29c/0x640
[  163.423082][ T3100] 
[  163.432556][ T3100] Memory state around the buggy address:
[  163.457292][ T3100]  ffff8887aba78300: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[  163.492994][ T3100]  ffff8887aba78380: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[  163.528530][ T3100] >ffff8887aba78400: fc fc fc fc fc fc fc fc fb fb fb fb fb
fb fb fb
[  163.565023][ T3100]                                                        ^
[  163.598027][ T3100]  ffff8887aba78480: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[  163.633747][ T3100]  ffff8887aba78500: fc fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc
[  163.669828][ T3100]
==================================================================
[  163.705417][ T3100] Disabling lock debugging due to kernel taint
