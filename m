Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF97C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80F2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfHSGsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:48:24 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38508 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbfHSGsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:48:24 -0400
Received: from dread.disaster.area (pa49-195-190-67.pa.nsw.optusnet.com.au [49.195.190.67])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6BB77360EB6;
        Mon, 19 Aug 2019 16:48:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hzbRf-00031C-52; Mon, 19 Aug 2019 16:47:11 +1000
Date:   Mon, 19 Aug 2019 16:47:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, longman@redhat.com
Subject: [BUG 5.3-rc5] rwsem: use after free on task_struct if task exits
 with rwsem held
Message-ID: <20190819064711.GL7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=TR82T6zjGmBjdfWdGgpkDw==:117 a=TR82T6zjGmBjdfWdGgpkDw==:17
        a=kj9zAlcOel0A:10 a=FmdZ9Uzk2mMA:10 a=7-415B0cAAAA:8
        a=4OtTbSVWJm2zToMiFYIA:9 a=8FdKqR766RsKY4QU:21 a=7n4UDYjnf_GPunBM:21
        a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

In trying to track down an XFS regression, I stumbled across KASAN
warnings about use-after-free behave in rwsems.

Essentially, the XFS regression is triggering an ASSERT, which is
BUG()ing a kernel thread that is holding the superblock s_umount
rwsem in write mode (it is a mount problem).

Once that thread has been killed (segv), the rwsem it held now has
no valid owner - the owning task_struct has been freed. When the
next attempt to access that superblock occurs (because it's visible
in the superblock list), either by attmepting to do something
through the block device (e.g. bdev_invalidate()) or by trying to
mount the block device again, we get use-after-free warnings on
the superblock s_umount rwsem.

Need 5.3-rc5 w/ CONFIG_XFS_DEBUG=y (needed for the BUG to trigger),
CONFIG_KASAN=y (to change the memory allocation alignment to cause
IO failures that cause the conditions for the BUG to to trigger).

Access through the bdev (I was only able to reproduce this one
through /dev/pmem0) from a thrid party:

# while [ 1 ]; do sudo xfs_io -fd -c "pwrite -S 0x0 -b 1m 0 8g" /dev/pmem0; mkfs.xfs -f -l size=2000m /dev/pmem0; mount -o logbsize=256k /dev/pmem0 /mnt/test; umount /dev/pmem0; done

On the third or fourth loop, everything gets really, really slow
when mounting - instaed of taking about 100ms to mount the filesystem,
it takes a couple of minutes before it finally fails, triggering
a BUG() that kills the mount process:

[   59.316335] XFS (pmem0): Mounting V5 Filesystem
[   59.322858] XFS (pmem0): Ending clean mount
[   59.368816] XFS (pmem0): Unmounting Filesystem
[   63.864465] XFS (pmem0): Mounting V5 Filesystem
[   63.880840] XFS (pmem0): Ending clean mount
[   63.928850] XFS (pmem0): Unmounting Filesystem
[   68.433309] XFS (pmem0): Mounting V5 Filesystem
[   68.436485] XFS (pmem0): totally zeroed log
[  188.034629] XFS: Assertion failed: head_blk != tail_blk, file: fs/xfs/xfs_log_recover.c, line: 5236
[  188.040585] ------------[ cut here ]------------
[  188.041687] kernel BUG at fs/xfs/xfs_message.c:102!
[  188.042870] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[  188.044129] CPU: 1 PID: 4740 Comm: mount Not tainted 5.3.0-rc5-dgc+ #1506
.....
<snip XFS stracktrace of problem I was trying to reproduce>
.....

Very shortly afterwards:

[  193.777801] ==================================================================
[  193.780976] BUG: KASAN: use-after-free in rwsem_down_read_slowpath+0x685/0x8f0
[  193.784072] Read of size 4 at addr ffff888237048038 by task systemd-udevd/2382
[  193.787147] 
[  193.787763] CPU: 2 PID: 2382 Comm: systemd-udevd Tainted: G      D           5.3.0-rc5-dgc+ #1506
[  193.789828] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  193.791764] Call Trace:
[  193.792358]  dump_stack+0x7c/0xc0
[  193.793153]  print_address_description+0x6c/0x322
[  193.794256]  ? rwsem_down_read_slowpath+0x685/0x8f0
[  193.795398]  __kasan_report.cold.6+0x1c/0x3e
[  193.796415]  ? rwsem_down_read_slowpath+0x685/0x8f0
[  193.797554]  ? rwsem_down_read_slowpath+0x685/0x8f0
[  193.798702]  kasan_report+0xe/0x12
[  193.799511]  rwsem_down_read_slowpath+0x685/0x8f0
[  193.800696]  ? unwind_get_return_address_ptr+0x50/0x50
[  193.802075]  ? unwind_next_frame+0x6d6/0x8a0
[  193.803423]  ? __down_timeout+0x1c0/0x1c0
[  193.808628]  ? unwind_next_frame+0x6d6/0x8a0
[  193.809631]  ? _raw_spin_lock+0x87/0xe0
[  193.810540]  ? _raw_spin_lock+0x87/0xe0
[  193.811449]  ? __cpuidle_text_end+0x5/0x5
[  193.812404]  ? set_init_blocksize+0xe0/0xe0
[  193.813391]  ? preempt_count_sub+0x43/0x50
[  193.814357]  ? __might_sleep+0x31/0xd0
[  193.815238]  ? set_init_blocksize+0xe0/0xe0
[  193.816237]  ? ___might_sleep+0xc8/0xe0
[  193.817146]  down_read+0x18d/0x1a0
[  193.817952]  ? refcount_sub_and_test_checked+0xaf/0x150
[  193.819178]  ? rwsem_down_read_slowpath+0x8f0/0x8f0
[  193.820326]  ? _raw_spin_lock+0x87/0xe0
[  193.821234]  __get_super.part.12+0xf8/0x130
[  193.822222]  fsync_bdev+0xf/0x60
[  193.822993]  invalidate_partition+0x1e/0x40
[  193.823992]  rescan_partitions+0x8a/0x420
[  193.824947]  blkdev_reread_part+0x1e/0x30
[  193.825896]  blkdev_ioctl+0xb0b/0xe60
[  193.826766]  ? __blkdev_driver_ioctl+0x80/0x80
[  193.827827]  ? __bpf_prog_run64+0xc0/0xc0
[  193.828770]  ? stack_trace_save+0x8a/0xb0
[  193.829729]  ? save_stack+0x4d/0x80
[  193.830567]  ? __seccomp_filter+0x133/0xa10
[  193.831556]  ? preempt_count_sub+0x43/0x50
[  193.832532]  block_ioctl+0x6d/0x80
[  193.833338]  do_vfs_ioctl+0x134/0x9c0
[  193.834205]  ? ioctl_preallocate+0x140/0x140
[  193.835217]  ? selinux_file_ioctl+0x2b7/0x360
[  193.836255]  ? selinux_capable+0x20/0x20
[  193.837185]  ? syscall_trace_enter+0x233/0x540
[  193.838231]  ksys_ioctl+0x60/0x90
[  193.839017]  __x64_sys_ioctl+0x3d/0x50
[  193.839921]  do_syscall_64+0x70/0x230
[  193.840789]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  193.841971] RIP: 0033:0x7fade328a427
[  193.842820] Code: 00 00 90 48 8b 05 69 aa 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 39 aa 0c 00 8
[  193.847128] RSP: 002b:00007ffdc4755928 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  193.848889] RAX: ffffffffffffffda RBX: 000000000000000e RCX: 00007fade328a427
[  193.850543] RDX: 0000000000000000 RSI: 000000000000125f RDI: 000000000000000e
[  193.852212] RBP: 0000000000000000 R08: 0000559597306140 R09: 0000000000000000
[  193.853867] R10: 0000000000000000 R11: 0000000000000246 R12: 000055959736dbc0
[  193.855519] R13: 0000000000000000 R14: 00007ffdc47569c8 R15: 000055959730dac0
[  193.857179] 
[  193.857550] Allocated by task 4739:
[  193.858378]  save_stack+0x19/0x80
[  193.859163]  __kasan_kmalloc.constprop.10+0xc1/0xd0
[  193.860309]  kmem_cache_alloc_node+0xf3/0x240
[  193.861329]  copy_process+0x1f91/0x2f20
[  193.862230]  _do_fork+0xe0/0x530
[  193.862992]  __x64_sys_clone+0x10e/0x160
[  193.863926]  do_syscall_64+0x70/0x230
[  193.864790]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  193.865963] 
[  193.866332] Freed by task 0:
[  193.867021]  save_stack+0x19/0x80
[  193.867816]  __kasan_slab_free+0x12e/0x180
[  193.868776]  kmem_cache_free+0x84/0x2c0
[  193.869679]  rcu_core+0x35f/0x810
[  193.870463]  __do_softirq+0x15f/0x476
[  193.871323] 
[  193.871700] The buggy address belongs to the object at ffff888237048000
[  193.871700]  which belongs to the cache task_struct of size 9792
[  193.874585] The buggy address is located 56 bytes inside of
[  193.874585]  9792-byte region [ffff888237048000, ffff88823704a640)
[  193.877290] The buggy address belongs to the page:
[  193.878409] page:ffffea0008dc1200 refcount:1 mapcount:0 mapping:ffff888078a91800 index:0x0 compound_mapcount: 0
[  193.880744] flags: 0x57ffffc0010200(slab|head)
[  193.881786] raw: 0057ffffc0010200 dead000000000100 dead000000000122 ffff888078a91800
[  193.883583] raw: 0000000000000000 0000000000030003 00000001ffffffff 0000000000000000
[  193.885382] page dumped because: kasan: bad access detected
[  193.886684] 
[  193.887054] Memory state around the buggy address:
[  193.888192]  ffff888237047f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  193.889869]  ffff888237047f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  193.891539] >ffff888237048000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  193.893222]                                         ^
[  193.894402]  ffff888237048080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  193.896082]  ffff888237048100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  193.897756] ==================================================================

Udev trips over the superblock  because for some reason it wants to
re-read the partition table on the ram disk, and that walks up into
the superblock and accesses the freed task_struct via the
sb->s_umount rwsem.

I then found another method to reproduce. Similar test case, but
with a ramdisk and simply retry the failed mount command:

# mkfs.xfs -f /dev/ram0 ; mount /dev/ram0 /mnt/test
meta-data=/dev/ram0              isize=512    agcount=4, agsize=512000 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1
data     =                       bsize=4096   blocks=2048000, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[  171.506592] XFS (ram0): Mounting V5 Filesystem
[  171.509471] XFS (ram0): totally zeroed log
[  172.180649] XFS: Assertion failed: head_blk != tail_blk, file: fs/xfs/xfs_log_recover.c, line: 5236
[  172.186295] ------------[ cut here ]------------
[  172.187614] kernel BUG at fs/xfs/xfs_message.c:102!
[  172.189037] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[  172.190605] CPU: 1 PID: 4693 Comm: mount Not tainted 5.3.0-rc5-dgc+ #1508
9  172.1
BM6e3s7s]a gHea rfdrwoamre n asme:y sQlEoMgUd S@ttaensdta3r da PCt  (Aiu4g4 01F9X  1+5 :P4I8I:X2, 199 9.6.).,
]I OkSe r1n.e1l2:.0-1[  0 41/720.11/820061449
  X[  172.196797] RIP: 0010:assfail+0x31/0x4d
[  172.197784] Code: f1 41 89 d0 48 c7 c6 60 04 c3 82 48 89 fa 31 ff e8 a0 f3 ff ff 48 c7 c7 ec 07 5b 83 e8 f5 f7 a8 ff 80 3d 6a 92 c5 01 00 74 02 <0f> 0b 48 c7 c7 c0 04 c3 82 e8 51 8c 88 ff 0f 0b 0
[  172.202440] RSP: 0018:ffff88880a5bf4b0 EFLAGS: 00010202
[  172.203752] RAX: 0000000000000000 RBX: 1ffff111014b7edb RCX: ffffffff8195757b
[  172.205561] RDX: 1ffffffff06b60fd RSI: 000000000000000a RDI: ffffffff835b07ec
[  172.207334] RBP: ffff88880a5bfa28 R08: ffffed1047745dd9 R09: ffffed1047745dd9
[  172.209129] R10: ffffed1047745dd8 R11: ffff88823ba2eec7 R12: ffff888235042d00
[  172.210839] R13: 0000000000000000 R14: 0000000000000000 R15: ffff888235042d00
[  172.212611] FS:  00007f4c2ff51100(0000) GS:ffff88823ba00000(0000) knlGS:0000000000000000
[  172.214549] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  172.215931] CR2: 00005650f9340078 CR3: 0000000233da5006 CR4: 0000000000060ee0
[  172.217673] Call Trace:
[  172.218282]  xlog_do_recovery_pass+0x7d2/0x890
....
[snip XFS stack trace]
....
XFS: Assertion failed: head_blk != tail_blk, file: fs/xfs/xfs_log_recover.c, line: 5236
Segmentation fault
root@test3:~# 
root@test3:~# mount /dev/ram0 /mnt/test
[  216.375529] ==================================================================
[  216.377749] BUG: KASAN: use-after-free in rwsem_down_write_slowpath+0x874/0x8f0
[  216.379868] Read of size 4 at addr ffff88880b3f8038 by task mount/4702
[  216.381820] 
[  216.382321] CPU: 0 PID: 4702 Comm: mount Tainted: G      D           5.3.0-rc5-dgc+ #1508
[  216.384860] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[  216.387014] Call Trace:
[  216.387811]  dump_stack+0x7c/0xc0
[  216.388871]  print_address_description+0x6c/0x322
[  216.390358]  ? rwsem_down_write_slowpath+0x874/0x8f0
[  216.391927]  __kasan_report.cold.6+0x1c/0x3e
[  216.393273]  ? rwsem_down_write_slowpath+0x874/0x8f0
[  216.394845]  ? rwsem_down_write_slowpath+0x874/0x8f0
[  216.396406]  kasan_report+0xe/0x12
[  216.397491]  rwsem_down_write_slowpath+0x874/0x8f0
[  216.399008]  ? path_lookupat.isra.50+0x156/0x420
[  216.400466]  ? rwsem_wake.isra.7+0x100/0x100
[  216.401820]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  216.403480]  ? refcount_inc_not_zero_checked+0x9a/0x120
[  216.405122]  ? refcount_inc_not_zero_checked+0x9a/0x120
[  216.406767]  ? refcount_add_checked+0x30/0x30
[  216.408136]  ? ___might_sleep+0xc8/0xe0
[  216.409345]  ? refcount_sub_and_test_checked+0xaf/0x150
[  216.410987]  ? refcount_inc_checked+0x30/0x30
[  216.412354]  ? mutex_lock+0x93/0xf0
[  216.413460]  ? __might_sleep+0x31/0xd0
[  216.414653]  down_write+0x10c/0x120
[  216.415754]  ? down_read_killable+0x1b0/0x1b0
[  216.417117]  ? _atomic_dec_and_lock+0x98/0x110
[  216.418518]  grab_super+0x8a/0x150
[  216.419574]  ? put_super+0x30/0x30
[  216.420649]  ? __cpuidle_text_end+0x5/0x5
[  216.421909]  ? mutex_lock+0x93/0xf0
[  216.423020]  ? test_single_super+0x10/0x10
[  216.424306]  sget+0x10b/0x290
[  216.425249]  ? super_cache_count+0x160/0x160
[  216.426596]  ? xfs_test_remount_options+0x60/0x60
[  216.428069]  mount_bdev+0xa7/0x200
[  216.429149]  ? xfs_finish_flags+0x1e0/0x1e0
[  216.430468]  legacy_get_tree+0x6e/0xb0
[  216.431338]  vfs_get_tree+0x41/0x160
[  216.432164]  do_mount+0xa48/0xcf0
[  216.432931]  ? copy_mount_string+0x20/0x20
[  216.433878]  ? kasan_unpoison_shadow+0x30/0x40
[  216.434907]  ? __might_sleep+0x31/0xd0
[  216.435771]  ? ___might_sleep+0xc8/0xe0
[  216.436659]  ? __might_fault+0x56/0x60
[  216.437527]  ? _copy_from_user+0xa1/0xd0
[  216.438438]  ? memdup_user+0x3e/0x70
[  216.439263]  ksys_mount+0xb6/0xd0
[  216.440029]  __x64_sys_mount+0x62/0x70
[  216.440897]  do_syscall_64+0x70/0x230
[  216.441737]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  216.442889] RIP: 0033:0x7f5728d3ffea
[  216.443719] Code: 48 8b 0d a9 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 76 0e 0c 00 8
[  216.447927] RSP: 002b:00007ffd6f2cb838 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[  216.449632] RAX: ffffffffffffffda RBX: 000055d422a58420 RCX: 00007f5728d3ffea
[  216.451244] RDX: 000055d422a5c3d0 RSI: 000055d422a58650 RDI: 000055d422a58630
[  216.452854] RBP: 00007f5728e911c4 R08: 0000000000000000 R09: 000055d422a5c0a0
[  216.454469] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[  216.456076] R13: 0000000000000000 R14: 000055d422a58630 R15: 000055d422a5c3d0
[  216.457686] 
[  216.458051] Allocated by task 4689:
[  216.458868]  save_stack+0x19/0x80
[  216.459639]  __kasan_kmalloc.constprop.10+0xc1/0xd0
[  216.460755]  kmem_cache_alloc_node+0xf3/0x240
[  216.461758]  copy_process+0x1f91/0x2f20
[  216.462653]  _do_fork+0xe0/0x530
[  216.463407]  __x64_sys_clone+0x10e/0x160
[  216.464304]  do_syscall_64+0x70/0x230
[  216.465146]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  216.466291] 
[  216.466659] Freed by task 0:
[  216.467337]  save_stack+0x19/0x80
[  216.468107]  __kasan_slab_free+0x12e/0x180
[  216.469050]  kmem_cache_free+0x84/0x2c0
[  216.469938]  rcu_core+0x35f/0x810
[  216.470713]  __do_softirq+0x15f/0x476
[  216.471557] 
[  216.471922] The buggy address belongs to the object at ffff88880b3f8000
[  216.471922]  which belongs to the cache task_struct of size 9792
[  216.474760] The buggy address is located 56 bytes inside of
[  216.474760]  9792-byte region [ffff88880b3f8000, ffff88880b3fa640)
[  216.477398] The buggy address belongs to the page:
[  216.478503] page:ffffea00202cfe00 refcount:1 mapcount:0 mapping:ffff888078a91800 index:0x0 compound_mapcount: 0
[  216.480784] flags: 0xd7ffffc0010200(slab|head)
[  216.481807] raw: 00d7ffffc0010200 dead000000000100 dead000000000122 ffff888078a91800
[  216.483563] raw: 0000000000000000 0000000000030003 00000001ffffffff 0000000000000000
[  216.485310] page dumped because: kasan: bad access detected
[  216.486582] 
[  216.486943] Memory state around the buggy address:
[  216.488038]  ffff88880b3f7f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  216.489674]  ffff88880b3f7f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  216.491315] >ffff88880b3f8000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  216.492943]                                         ^
[  216.494094]  ffff88880b3f8080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  216.495737]  ffff88880b3f8100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  216.497365] ==================================================================

I outlined both methods of causing this issue because they are two
different use-after-free cases - one is in the read slowpath, the
other is in the write slow path. 

I know that processes should not exit while holding a rwsem, but
bugs do happen.  I'd much prefer that leaked rwsems just hang and we
do not add the potential for random memory corruption into these
situations as well - a lock hang is much easier to debug than a
memory corruption....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
