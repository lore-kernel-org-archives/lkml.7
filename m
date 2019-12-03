Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D38FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33782205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfLCIC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:02:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:40450 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfLCIC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:02:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 00:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="412088291"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2019 00:02:12 -0800
Subject: Re: [LKP] Re: [refcount] d2d337b185:
 WARNING:at_lib/refcount.c:#refcount_warn_saturate
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Hanjun Guo <guohanjun@huawei.com>, lkp@lists.01.org
References: <20191121115902.2551-9-will@kernel.org>
 <20191201154913.GQ18573@shao2-debian>
 <CAKv+Gu8VinMc8nv=W2-8c-HP7d6i_TV2weOZu9R8PiiHDtHRFA@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <92d23f27-5ed0-5765-a9e3-9bc9fbd3768d@intel.com>
Date:   Tue, 3 Dec 2019 16:01:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8VinMc8nv=W2-8c-HP7d6i_TV2weOZu9R8PiiHDtHRFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/2/19 5:43 PM, Ard Biesheuvel wrote:
> On Sun, 1 Dec 2019 at 16:49, kernel test robot <rong.a.chen@intel.com> wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: d2d337b185bd2abff262f3cf7de0080b3888e41c ("[RESEND PATCH v4 08/10] refcount: Consolidate implementations of refcount_t")
>> url: https://github.com/0day-ci/linux/commits/Will-Deacon/Rework-REFCOUNT_FULL-using-atomic_fetch_-operations/20191124-052413
>>
>>
>> in testcase: ocfs2test
>> with following parameters:
>>
>>          disk: 1SSD
>>          test: test-mkfs
>>
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +-----------------------------------------------------------------------------+------------+------------+
>> |                                                                             | 2ab80bd4ae | d2d337b185 |
>> +-----------------------------------------------------------------------------+------------+------------+
>> | boot_successes                                                              | 0          | 0          |
>> | boot_failures                                                               | 24         | 24         |
> So we went from a success rate of 0 out of 24 to 0 out of 24 by
> applying that patch. How on earth is that a result that justifies
> spamming everybody?

Hi Ard,

These failures were triggered by ocfs2test test, and all tests were 
failed include parent commit "2ab80bd4ae".

>
>> | BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/rwsem.c | 24         | 24         |
>> | stack_segment:#[##]                                                         | 6          | 6          |
>> | RIP:__kmalloc                                                               | 8          | 6          |
>> | Kernel_panic-not_syncing:Fatal_exception                                    | 14         | 11         |
>> | kernel_BUG_at_mm/slub.c                                                     | 9          | 4          |
>> | invalid_opcode:#[##]                                                        | 9          | 4          |
>> | RIP:kfree                                                                   | 9          | 4          |
>> | RIP:native_safe_halt                                                        | 4          | 1          |
>> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt                       | 6          | 2          |
>> | BUG:unable_to_handle_page_fault_for_address                                 | 5          | 1          |
>> | Oops:#[##]                                                                  | 5          | 1          |
>> | RIP:kmem_cache_alloc_trace                                                  | 3          | 3          |
>> | RIP:idr_get_free                                                            | 1          |            |
>> | RIP:console_unlock                                                          | 1          |            |
>> | WARNING:at_lib/refcount.c:#refcount_warn_saturate                           | 0          | 9          |
>> | RIP:refcount_warn_saturate                                                  | 0          | 9          |

The difference is that commit "d2d337b185" introduces new errors. e.g. 
RIP:refcount_warn_saturate
In addition,  you can get the dmesg file in previous report email.

Please feel free to contact us if you need more information, and please 
forgive us if we got something
wrong.

Best Regards,
Rong Chen

>> | general_protection_fault:#[##]                                              | 0          | 2          |
>> | RIP:lru_cache_add_active_or_unevictable                                     | 0          | 1          |
>> +-----------------------------------------------------------------------------+------------+------------+
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> [   93.421220] BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:1533
>> [   93.423478] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2464, name: mount.ocfs2
>> [   93.425258] CPU: 1 PID: 2464 Comm: mount.ocfs2 Not tainted 5.4.0-rc3-00012-gd2d337b185bd2 #1
>> [   93.428185] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [   93.430982] Call Trace:
>> [   93.432691]  dump_stack+0x5c/0x7b
>> [   93.434089]  ___might_sleep+0x102/0x120
>> [   93.435629]  down_write+0x1c/0x50
>> [   93.436962]  configfs_depend_item+0x3a/0xb0
>> [   93.438580]  o2hb_region_pin+0xf9/0x180 [ocfs2_nodemanager]
>> [   93.440630]  ? inode_doinit_with_dentry+0x250/0x4e0
>> [   93.441860]  o2hb_register_callback+0xc6/0x2a0 [ocfs2_nodemanager]
>> [   93.443298]  dlm_join_domain+0xbd/0x790 [ocfs2_dlm]
>> [   93.444491]  ? debugfs_create_dir+0xc4/0x100
>> [   93.445635]  ? dlm_alloc_ctxt+0x42f/0x560 [ocfs2_dlm]
>> [   93.446905]  dlm_register_domain+0x31f/0x440 [ocfs2_dlm]
>> [   93.448188]  ? _cond_resched+0x19/0x30
>> [   93.449248]  o2cb_cluster_connect+0x132/0x2c0 [ocfs2_stack_o2cb]
>> [   93.450701]  ocfs2_cluster_connect+0x14b/0x220 [ocfs2_stackglue]
>> [   93.452151]  ocfs2_dlm_init+0x2e9/0x4b0 [ocfs2]
>> [   93.453379]  ? ocfs2_init_node_maps+0x50/0x50 [ocfs2]
>> [   93.454700]  ocfs2_fill_super+0xcf4/0x12a0 [ocfs2]
>> [   93.455952]  ? ocfs2_initialize_super+0x1030/0x1030 [ocfs2]
>> [   93.457484]  mount_bdev+0x173/0x1b0
>> [   93.458543]  legacy_get_tree+0x27/0x40
>> [   93.459615]  vfs_get_tree+0x25/0xc0
>> [   93.460650]  do_mount+0x715/0x9a0
>> [   93.461697]  ksys_mount+0x80/0xd0
>> [   93.462728]  __x64_sys_mount+0x21/0x30
>> [   93.463802]  do_syscall_64+0x5b/0x1d0
>> [   93.464867]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   93.466224] RIP: 0033:0x7feaa42ee48a
>> [   93.467282] Code: 48 8b 0d 11 fa 2a 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d de f9 2a 00 f7 d8 64 89 01 48
>> [   93.472861] RSP: 002b:00007ffec903d4e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
>> [   93.475973] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007feaa42ee48a
>> [   93.479041] RDX: 0000562b43aae3ee RSI: 0000562b444af0b0 RDI: 0000562b444af310
>> [   93.481956] RBP: 00007ffec903d690 R08: 0000562b444af2b0 R09: 0000000000000020
>> [   93.485084] R10: 0000000000000000 R11: 0000000000000206 R12: 00007ffec903d580
>> [   93.488128] R13: 0000000000000000 R14: 0000562b444b0000 R15: 00007ffec903d500
>> [   93.494821] o2dlm: Joining domain 58A89FF3B793441A83C86B6A7816B4AF
>> [   93.494822] (
>> [   93.499229] 1
>> [   93.501238] ) 1 nodes
>> [   93.509977] JBD2: Ignoring recovery information on journal
>> [   93.518913] ocfs2: Mounting device (8,0) on (node 1, slot 0) with ordered data mode.
>> [   94.541086] mount /dev/sda /mnt/ocfs2 /dev/sda          16515072      243712    16271360   2% /mnt/ocfs2
>> [   94.541090]
>> [   94.546474] OK
>> [   94.546476]
>> [   94.550726] create testdir /mnt/ocfs2/20191130_125727
>> [   94.550729]
>> [   94.713069] create 15890 files .
>> [   94.713072]
>> [   94.717547]
>> [   98.760820] o2dlm: Leaving domain 58A89FF3B793441A83C86B6A7816B4AF
>> [   98.828610] blk_update_request: I/O error, dev fd0, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>> [   98.830929] floppy: error 10 while reading block 0
>> [   99.561301] ocfs2: Unmounting device (8,0) on (node 1)
>> [   99.563700] ------------[ cut here ]------------
>> [   99.566425] refcount_t: underflow; use-after-free.
>> [   99.569213] WARNING: CPU: 1 PID: 2531 at lib/refcount.c:28 refcount_warn_saturate+0x8d/0xf0
>> [   99.574231] Modules linked in: ocfs2_stack_o2cb ocfs2_dlm ocfs2 ocfs2_nodemanager ocfs2_stackglue jbd2 sr_mod intel_rapl_msr cdrom ata_generic pata_acpi intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sd_mod sg bochs_drm ppdev drm_vram_helper ttm drm_kms_helper snd_pcm syscopyarea ata_piix sysfillrect aesni_intel sysimgblt snd_timer fb_sys_fops crypto_simd libata drm cryptd glue_helper snd soundcore pcspkr joydev serio_raw virtio_scsi i2c_piix4 floppy parport_pc parport ip_tables
>> [   99.593419] CPU: 1 PID: 2531 Comm: umount Tainted: G        W         5.4.0-rc3-00012-gd2d337b185bd2 #1
>> [   99.597311] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [   99.604305] RIP: 0010:refcount_warn_saturate+0x8d/0xf0
>> [   99.607073] Code: 05 ce 6f 37 01 01 e8 32 a0 c1 ff 0f 0b c3 80 3d c1 6f 37 01 00 75 ad 48 c7 c7 e0 9f 73 a5 c6 05 b1 6f 37 01 01 e8 13 a0 c1 ff <0f> 0b c3 80 3d a5 6f 37 01 00 75 8e 48 c7 c7 60 9f 73 a5 c6 05 95
>> [   99.612363] RSP: 0018:ffffa895c0457e20 EFLAGS: 00010282
>> [   99.613931] RAX: 0000000000000000 RBX: ffff8d07e654e000 RCX: 0000000000000000
>> [   99.615800] RDX: ffff8d083fd27640 RSI: ffff8d083fd17778 RDI: ffff8d083fd17778
>> [   99.617687] RBP: ffff8d07db479000 R08: 000000000000050a R09: 0000000000aaaaaa
>> [   99.619574] R10: ffffa895c0457c48 R11: ffff8d0817a4cf20 R12: ffffa895c0457e34
>> [   99.621486] R13: ffff8d07e654e240 R14: ffff8d07e654e0c8 R15: 0000000000000000
>> [   99.623382] FS:  00007f39e9509e40(0000) GS:ffff8d083fd00000(0000) knlGS:0000000000000000
>> [   99.625452] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   99.627106] CR2: 00000000004216d0 CR3: 00000001d2bfe000 CR4: 00000000000406e0
>> [   99.628995] Call Trace:
>> [   99.630127]  ocfs2_dismount_volume+0x32a/0x3e0 [ocfs2]
>> [   99.631667]  generic_shutdown_super+0x6c/0x120
>> [   99.633102]  kill_block_super+0x21/0x50
>> [   99.634424]  deactivate_locked_super+0x3f/0x70
>> [   99.635843]  cleanup_mnt+0xb8/0x150
>> [   99.637130]  task_work_run+0xa3/0xe0
>> [   99.638407]  exit_to_usermode_loop+0xeb/0xf0
>> [   99.639827]  do_syscall_64+0x1a7/0x1d0
>> [   99.641185]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> [   99.643068] RIP: 0033:0x7f39e8dedd77
>> [   99.644352] Code: 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f1 00 2b 00 f7 d8 64 89 01 48
>> [   99.649122] RSP: 002b:00007fffc63b9bf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
>> [   99.651318] RAX: 0000000000000000 RBX: 0000557e0db2e080 RCX: 00007f39e8dedd77
>> [   99.653282] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000557e0db2e260
>> [   99.655401] RBP: 0000557e0db2e260 R08: 0000557e0db2f600 R09: 0000000000000015
>> [   99.657366] R10: 00000000000006b4 R11: 0000000000000246 R12: 00007f39e92efe64
>> [   99.659581] R13: 0000000000000000 R14: 0000000000000000 R15: 00007fffc63b9e80
>> [   99.661503] ---[ end trace eed33931ffa30ed0 ]---
>>
>>
>> To reproduce:
>>
>>          # build kernel
>>          cd linux
>>          cp config-5.4.0-rc3-00012-gd2d337b185bd2 .config
>>          make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
>>          make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>>          cd <mod-install-dir>
>>          find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>>
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>>
>>
>>
>> Thanks,
>> Rong Chen
>>
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org

