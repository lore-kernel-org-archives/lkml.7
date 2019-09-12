Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8F7C4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5728D214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 10:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568285808;
	bh=Wh+g+Sf6b/JizRhZ/sVXx3Xjltc8jw97+7uAb8ReN6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vrf1XfO6BArO8//c9SFULMsv4VOD+G/wvCySKxMldXP+H1oyBYIOJmlTZVJo3JEf0
	 Ya2nwtyodn3Ehyc9JKMFz9r7jKZVlJgAYxOmlDWo0K2V+Sg1Bgmzl572okgTfgivEn
	 Tv65AlAxE0cIIUUqCBuF4HDXyHiTvKlkORc3/A54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfILK4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 06:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbfILK4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 06:56:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B956208E4;
        Thu, 12 Sep 2019 10:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568285805;
        bh=Wh+g+Sf6b/JizRhZ/sVXx3Xjltc8jw97+7uAb8ReN6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFToryuzoR/pZflijjHqWOA4PCHXFt+5viAgvRueTRPlEQiAZc+GGox+4j+VU5ikO
         P4/99JW1CGAKQ4OYgRNCT1ZQkyD6lsUD1Ixxd5PlORuajsMCZnNQL6bjqHYuGfS0cY
         9MWYqGSxCGCnRH3sjIYF3a3RbvUnzuU2/ezjkf8c=
Date:   Thu, 12 Sep 2019 11:56:41 +0100
From:   Will Deacon <will@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>, lkp@01.org, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@oss.oracle.com
Subject: Re: [refcount] 26d2e0d5df:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
Message-ID: <20190912105640.2l6mtdjmcyyhmyun@willie-the-truck>
References: <20190909015226.GM15734@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909015226.GM15734@shao2-debian>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding the ocfs2 maintainers and mailing list]

On Mon, Sep 09, 2019 at 09:52:26AM +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 26d2e0d5df5b9aab517d8327743e66fcb38e8136 ("refcount: Consolidate implementations of refcount_t")
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/will/linux.git refcount/full

This branch effectively enables REFCOUNT_FULL by default, so I think the
issue being flagged is a latent use-after-free in ocfs2, rather than a bug
in the refcount implementation.

> in testcase: ocfs2test
> with following parameters:
> 
> 	disk: 1SSD
> 	test: test-mkfs
> 
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

[...]

> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> [   72.121725] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1499
> [   72.126078] in_atomic(): 1, irqs_disabled(): 0, pid: 2466, name: mount.ocfs2
> [   72.128523] CPU: 1 PID: 2466 Comm: mount.ocfs2 Not tainted 5.3.0-rc3-00008-g26d2e0d5df5b9 #1
> [   72.130522] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   72.132522] Call Trace:
> [   72.134024]  dump_stack+0x5c/0x7b
> [   72.135106]  ___might_sleep+0xf1/0x110
> [   72.136280]  down_write+0x1c/0x50
> [   72.137349]  configfs_depend_item+0x3a/0xb0
> [   72.138597]  o2hb_region_pin+0xf9/0x180 [ocfs2_nodemanager]

This looks dodgy because o2hb_region_pin() asserts that the 'o2hb_live_lock'
is held, but then configfs_depend_item() calls inode_lock(), which can
sleep on the semaphore.

> [   72.140103]  ? inode_init_always+0x120/0x1d0
> [   72.141368]  o2hb_register_callback+0xc6/0x2a0 [ocfs2_nodemanager]
> [   72.143016]  dlm_join_domain+0xbd/0x7a0 [ocfs2_dlm]
> [   72.144441]  ? dlm_alloc_ctxt+0x50a/0x580 [ocfs2_dlm]
> [   72.145880]  dlm_register_domain+0x31f/0x440 [ocfs2_dlm]
> [   72.147395]  ? enqueue_entity+0x109/0x6c0
> [   72.148658]  ? _cond_resched+0x19/0x30
> [   72.149870]  o2cb_cluster_connect+0x132/0x2c0 [ocfs2_stack_o2cb]
> [   72.151524]  ocfs2_cluster_connect+0x14b/0x220 [ocfs2_stackglue]
> [   72.153237]  ocfs2_dlm_init+0x2f1/0x4b0 [ocfs2]
> [   72.154647]  ? ocfs2_init_node_maps+0x50/0x50 [ocfs2]
> [   72.156167]  ocfs2_fill_super+0xcfc/0x12b0 [ocfs2]
> [   72.157640]  ? ocfs2_initialize_super+0x1030/0x1030 [ocfs2]
> [   72.159395]  mount_bdev+0x173/0x1b0
> [   72.160627]  legacy_get_tree+0x27/0x40
> [   72.161900]  vfs_get_tree+0x25/0xf0
> [   72.163138]  do_mount+0x691/0x9c0
> [   72.164343]  ksys_mount+0x80/0xd0
> [   72.165536]  __x64_sys_mount+0x21/0x30
> [   72.166828]  do_syscall_64+0x5b/0x1f0
> [   72.168124]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   72.169649] RIP: 0033:0x7f9aec59148a
> [   72.170904] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d de f9 2a 00 f7 d8 64 89 01 48
> [   72.175696] RSP: 002b:00007ffc97973af8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> [   72.177764] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f9aec59148a
> [   72.179756] RDX: 00005630f7e3b3ee RSI: 00005630f988a0b0 RDI: 00005630f988a310
> [   72.181768] RBP: 00007ffc97973ca0 R08: 00005630f988a2b0 R09: 0000000000000020
> [   72.183776] R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc97973b90
> [   72.185795] R13: 0000000000000000 R14: 00005630f988b000 R15: 00007ffc97973b10
> [   72.193593] o2dlm: Joining domain 87608FBB69A6455A927DB6EE644FA256 
> [   72.193593] ( 
> [   72.195534] 1 
> [   72.196744] ) 1 nodes
> [   72.201889] JBD2: Ignoring recovery information on journal
> [   72.211850] ocfs2: Mounting device (8,0) on (node 1, slot 0) with ordered data mode.
> [   72.261789] mount /dev/sda /mnt/ocfs2 /dev/sda          16515072      243712    16271360   2% /mnt/ocfs2
> [   72.261792] 
> [   72.268799] OK
> [   72.268801] 
> [   72.273936] create testdir /mnt/ocfs2/20190907_114755
> [   72.273938] 
> [   72.286732] create 15890 files .
> [   72.286734] 
> [   72.290339] 
> [   76.331476] o2dlm: Leaving domain 87608FBB69A6455A927DB6EE644FA256
> [   76.402235] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [   76.406909] floppy: error 10 while reading block 0
> [   78.260271] ocfs2: Unmounting device (8,0) on (node 1)
> [   78.264188] ------------[ cut here ]------------
> [   78.267624] refcount_t: underflow; use-after-free.

Here's the use-after-free, but I couldn't follow 'ocfs2_dismount_volume()'
enough to figure out where the refcount_t actually lives.

I've preserved the rest of the log below, in the hope that somebody more
familiar with ocfs2 can take a look. The original report, including the
.config, is here:

  http://lkml.kernel.org/r/20190909015226.GM15734@shao2-debian

Thanks,

Will

--->8

> [   78.271193] WARNING: CPU: 1 PID: 2531 at lib/refcount.c:28 refcount_warn_saturate+0x95/0xe0
> [   78.275787] Modules linked in: ocfs2_stack_o2cb ocfs2_dlm ocfs2 ocfs2_nodemanager ocfs2_stackglue jbd2 bochs_drm sr_mod cdrom ata_generic drm_vram_helper pata_acpi ttm intel_rapl_msr sd_mod sg intel_rapl_common drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ppdev syscopyarea sysfillrect sysimgblt fb_sys_fops drm snd_pcm aesni_intel ata_piix crypto_simd snd_timer libata joydev snd cryptd glue_helper soundcore pcspkr serio_raw virtio_scsi i2c_piix4 floppy parport_pc parport ip_tables
> [   78.294615] CPU: 1 PID: 2531 Comm: umount Tainted: G        W         5.3.0-rc3-00008-g26d2e0d5df5b9 #1
> [   78.297253] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [   78.299697] RIP: 0010:refcount_warn_saturate+0x95/0xe0
> [   78.301533] Code: 05 13 c8 37 01 01 e8 3a fd c1 ff 0f 0b c3 80 3d 01 c8 37 01 00 75 aa 48 c7 c7 c8 79 d1 aa c6 05 f1 c7 37 01 01 e8 1b fd c1 ff <0f> 0b c3 80 3d e3 c7 37 01 00 75 8b 48 c7 c7 98 79 d1 aa c6 05 d3
> [   78.306840] RSP: 0018:ffffad0540413e20 EFLAGS: 00010282
> [   78.308741] RAX: 0000000000000000 RBX: ffff96be3da63000 RCX: 0000000000000000
> [   78.311011] RDX: ffff96beffd27200 RSI: ffff96beffd17778 RDI: ffff96beffd17778
> [   78.313311] RBP: ffff96be3baf6000 R08: 00000000000004ff R09: 0000000000aaaaaa
> [   78.315620] R10: ffff96bedf05eec0 R11: ffff96bedc6ee950 R12: ffffad0540413e34
> [   78.317899] R13: ffff96be3da63240 R14: ffff96be3da630c8 R15: 0000000000000000
> [   78.320192] FS:  00007fb431b58e40(0000) GS:ffff96beffd00000(0000) knlGS:0000000000000000
> [   78.322666] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   78.324751] CR2: 00000000004216d0 CR3: 000000007cf4c000 CR4: 00000000000406e0
> [   78.327003] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   78.329278] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   78.331517] Call Trace:
> [   78.332928]  ocfs2_dismount_volume+0x342/0x400 [ocfs2]
> [   78.334790]  generic_shutdown_super+0x6c/0x120
> [   78.336521]  kill_block_super+0x21/0x50
> [   78.338131]  deactivate_locked_super+0x3f/0x70
> [   78.339858]  cleanup_mnt+0xb8/0x150
> [   78.341396]  task_work_run+0xa3/0xe0
> [   78.342965]  exit_to_usermode_loop+0xeb/0xf0
> [   78.344679]  do_syscall_64+0x1c1/0x1f0
> [   78.346272]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   78.348112] RIP: 0033:0x7fb43143cd77
> [   78.349647] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
> [   78.353636] RSP: 002b:00007ffc671b3ad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [   78.355313] RAX: 0000000000000000 RBX: 0000558a27aef080 RCX: 00007fb43143cd77
> [   78.356858] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000558a27aef260
> [   78.358382] RBP: 0000558a27aef260 R08: 0000558a27af0600 R09: 0000000000000015
> [   78.359939] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007fb43193ee64
> [   78.361625] R13: 0000000000000000 R14: 0000000000000000 R15: 00007ffc671b3d60
> [   78.363256] ---[ end trace 06b247ab8ebf3051 ]---
