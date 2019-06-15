Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F066C31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 20:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C613321851
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 20:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFOU42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 16:56:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:31497 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfFOU41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 16:56:27 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2019 13:56:19 -0700
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2019 13:56:17 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hcFii-0008Ly-V7; Sun, 16 Jun 2019 04:56:16 +0800
Date:   Sun, 16 Jun 2019 04:55:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     LKP <lkp@01.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, philip.li@intel.com
Subject: 41c3b82ce7 ("block: return from __bio_try_merge_page if .."):
  BUG: KASAN: null-ptr-deref in __bio_add_pc_page
Message-ID: <5d055b54.Kf66KUxVpBPXKiIw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_5d055b54.q/3E1fY/IpzZAwn+Flm4zlzfDRdKl5nD54MhO6wyh+xwtWeZ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--=_5d055b54.q/3E1fY/IpzZAwn+Flm4zlzfDRdKl5nD54MhO6wyh+xwtWeZ
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git block/for-linus

commit 41c3b82ce7980f8e7b51cf2cf6c3f55fd8bc07c0
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Thu Jun 13 11:55:28 2019 +0200
Commit:     Jens Axboe <axboe@kernel.dk>
CommitDate: Thu Jun 13 04:02:35 2019 -0600

    block: return from __bio_try_merge_page if merging occured in the same page
    
    We currently have an input same_page parameter to __bio_try_merge_page
    to prohibit merging in the same page.  The rationale for that is that
    some callers need to account for every page added to a bio.  Instead of
    letting these callers call twice into the merge code to account for the
    new vs existing page cases, just turn the paramter into an output one that
    returns if a merge in the same page occured and let them act accordingly.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Ming Lei <ming.lei@redhat.com>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

1d0c06513b  block/ps3vram: Use %llu to format sector_t after LBDAF removal
41c3b82ce7  block: return from __bio_try_merge_page if merging occured in the same page
9c9b3e34fa  block: fix page leak when merging to same page
+------------------------------------------------+------------+------------+------------+
|                                                | 1d0c06513b | 41c3b82ce7 | 9c9b3e34fa |
+------------------------------------------------+------------+------------+------------+
| boot_successes                                 | 9          | 1          | 0          |
| boot_failures                                  | 3          | 14         | 12         |
| BUG:soft_lockup-CPU##stuck_for#s               | 2          |            |            |
| RIP:memset_erms                                | 1          |            |            |
| Kernel_panic-not_syncing:softlockup:hung_tasks | 2          |            |            |
| RIP:__asan_load8                               | 1          |            |            |
| BUG:kernel_timeout_in_torture_test_stage       | 1          |            |            |
| BUG:KASAN:null-ptr-deref_in__bio_add_pc_page   | 0          | 14         | 12         |
| BUG:kernel_NULL_pointer_dereference,address    | 0          | 14         | 12         |
| Oops:#[##]                                     | 0          | 14         | 12         |
| RIP:__bio_add_pc_page                          | 0          | 14         | 12         |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 14         | 12         |
+------------------------------------------------+------------+------------+------------+

If you fix the issue, kindly add following tag
Reported-by: kernel test robot <lkp@intel.com>

[  212.664343] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[  212.673694] scsi host0: scsi_debug: version 0188 [20190125]
[  212.673694]   dev_size_mb=8, opts=0x0, submit_queues=1, statistics=0
[  212.682114] scsi 0:0:0:0: Direct-Access     Linux    scsi_debug       0188 PQ: 0 ANSI: 7
[  212.685451] ==================================================================
[  212.687542] BUG: KASAN: null-ptr-deref in __bio_add_pc_page+0x223/0x510
[  212.689077] Write of size 1 at addr 0000000000000000 by task kworker/u2:1/108
[  212.690676] 
[  212.691445] CPU: 0 PID: 108 Comm: kworker/u2:1 Not tainted 5.2.0-rc4-00013-g41c3b82 #1
[  212.693624] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  212.694987] Workqueue: events_unbound async_run_entry_fn
[  212.694987] Call Trace:
[  212.694987]  ? __bio_add_pc_page+0x223/0x510
[  212.694987]  __kasan_report+0x1d2/0x207
[  212.694987]  ? __bio_add_pc_page+0x223/0x510
[  212.694987]  kasan_report+0x29/0x40
[  212.694987]  __bio_add_pc_page+0x223/0x510
[  212.694987]  bio_map_kern+0x118/0x190
[  212.694987]  blk_rq_map_kern+0x235/0x270
[  212.694987]  ? blk_rq_unmap_user+0x90/0x90
[  212.694987]  ? ftrace_likely_update+0x45/0x2a0
[  212.694987]  ? scsi_initialize_rq+0x54/0x70
[  212.694987]  __scsi_execute+0xa6/0x2d0
[  212.694987]  __scsi_scan_target+0x4d8/0x890
[  212.694987]  ? scsi_target_reap+0x60/0x60
[  212.694987]  ? find_held_lock+0x74/0xd0
[  212.694987]  ? __pm_runtime_resume+0x71/0xb0
[  212.694987]  ? ftrace_likely_update+0x45/0x2a0
[  212.694987]  ? _raw_spin_unlock_irqrestore+0x32/0x50
[  212.694987]  scsi_scan_channel+0x94/0xe0
[  212.694987]  scsi_scan_host_selected+0x158/0x1d0
[  212.694987]  ? do_scsi_scan_host+0x110/0x110
[  212.694987]  do_scan_async+0x29/0x250
[  212.694987]  ? do_scsi_scan_host+0x110/0x110
[  212.694987]  async_run_entry_fn+0x66/0x2e0
[  212.694987]  process_one_work+0x575/0xb10
[  212.694987]  ? pwq_dec_nr_in_flight+0x140/0x140
[  212.694987]  ? worker_thread+0x1cf/0x790
[  212.694987]  worker_thread+0x68/0x790
[  212.694987]  ? process_one_work+0xb10/0xb10
[  212.694987]  kthread+0x20c/0x230
[  212.694987]  ? kthread_delayed_work_timer_fn+0x1c0/0x1c0
[  212.694987]  ret_from_fork+0x24/0x30
[  212.694987] ==================================================================
[  212.694987] Disabling lock debugging due to kernel taint
[  212.738776] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  212.740355] #PF: supervisor write access in kernel mode
[  212.741675] #PF: error_code(0x0002) - not-present page
[  212.742998] PGD 0 P4D 0 
[  212.743930] Oops: 0002 [#1] KASAN PTI
[  212.745024] CPU: 0 PID: 108 Comm: kworker/u2:1 Tainted: G    B             5.2.0-rc4-00013-g41c3b82 #1
[  212.747388] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  212.748734] Workqueue: events_unbound async_run_entry_fn
[  212.748734] RIP: 0010:__bio_add_pc_page+0x22b/0x510
[  212.748734] Code: 06 85 c0 0f 85 b4 01 00 00 49 83 ed 01 31 ff 4c 89 e8 48 25 00 f0 ff ff 48 89 44 24 08 e8 bd 1e 8e ff 48 8b 44 24 08 49 39 c6 <0f> 94 04 25 00 00 00 00 0f 84 a0 01 00 00 4c 8b 35 98 db eb 03 49
[  212.748734] RSP: 0000:ffff8880192f7948 EFLAGS: 00010206
[  212.748734] RAX: 0000000013621000 RBX: ffff888015fce200 RCX: fffffbfff0d785d9
[  212.748734] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff83ba6482
[  212.748734] RBP: 0000000000000100 R08: fffffbfff0d785da R09: fffffbfff0d785da
[  212.748734] R10: ffffffff86bc2ecb R11: fffffbfff0d785da R12: ffff888013c496d0
[  212.748734] R13: 0000000013621fff R14: 0000000013622000 R15: ffff888015fce214
[  212.748734] FS:  0000000000000000(0000) GS:ffffffff85a9e000(0000) knlGS:0000000000000000
[  212.748734] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  212.748734] CR2: 0000000000000000 CR3: 0000000005a32001 CR4: 00000000001606f0
[  212.748734] Call Trace:
[  212.748734]  bio_map_kern+0x118/0x190
[  212.748734]  blk_rq_map_kern+0x235/0x270
[  212.748734]  ? blk_rq_unmap_user+0x90/0x90
[  212.748734]  ? ftrace_likely_update+0x45/0x2a0
[  212.748734]  ? scsi_initialize_rq+0x54/0x70
[  212.748734]  __scsi_execute+0xa6/0x2d0
[  212.748734]  __scsi_scan_target+0x4d8/0x890
[  212.748734]  ? scsi_target_reap+0x60/0x60
[  212.748734]  ? find_held_lock+0x74/0xd0
[  212.748734]  ? __pm_runtime_resume+0x71/0xb0
[  212.748734]  ? ftrace_likely_update+0x45/0x2a0
[  212.748734]  ? _raw_spin_unlock_irqrestore+0x32/0x50
[  212.748734]  scsi_scan_channel+0x94/0xe0
[  212.748734]  scsi_scan_host_selected+0x158/0x1d0
[  212.748734]  ? do_scsi_scan_host+0x110/0x110
[  212.748734]  do_scan_async+0x29/0x250
[  212.748734]  ? do_scsi_scan_host+0x110/0x110
[  212.748734]  async_run_entry_fn+0x66/0x2e0
[  212.748734]  process_one_work+0x575/0xb10
[  212.748734]  ? pwq_dec_nr_in_flight+0x140/0x140
[  212.748734]  ? worker_thread+0x1cf/0x790
[  212.748734]  worker_thread+0x68/0x790
[  212.748734]  ? process_one_work+0xb10/0xb10
[  212.748734]  kthread+0x20c/0x230
[  212.748734]  ? kthread_delayed_work_timer_fn+0x1c0/0x1c0
[  212.748734]  ret_from_fork+0x24/0x30
[  212.748734] CR2: 0000000000000000
[  212.748734] ---[ end trace b9d0d98398fe5790 ]---
[  212.748734] RIP: 0010:__bio_add_pc_page+0x22b/0x510

                                                          # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start b03773ed7363554492ff274f4a9364a4c30b3637 d1fdb6d8f6a4109a4263176c84b899076a5f8008 --
git bisect  bad a77e549e7925f1a071787a77d36e28d0f290e722  # 20:13  B      0     2   17   1  Merge 'jpoimboe/bpf-orc-fix-3' into devel-hourly-2019061516
git bisect  bad fec395990abb566155bfd809696168b65df8cde3  # 20:35  B      0     6   20   0  Merge 'pm/linux-next' into devel-hourly-2019061516
git bisect good 60c912e9d5d16b2e39194e51aa4e9196cda3df08  # 21:30  G     10     0    8   9  Merge 'sunxi/sunxi/dt64-for-5.3' into devel-hourly-2019061516
git bisect  bad cf1a70094c0b31e849ea1461e6da3da63cac85cb  # 21:53  B      0     1   15   0  Merge 'tip/x86/cpu' into devel-hourly-2019061516
git bisect  bad 4baf710ddb5fb2b90abefdd5cfa11660cdae67f6  # 23:01  B      0     1   20   5  Merge 'cgroup/block/for-linus' into devel-hourly-2019061516
git bisect good d4d2c24ea2a5346d75f21d3a44868f9021650115  # 23:35  G     10     0    8   8  Merge 'arm-tegra/for-5.3/firmware' into devel-hourly-2019061516
git bisect good e4fde4a63896f617c1d9b131ca973be1c791fbbf  # 00:24  G     10     0    6   6  Merge 'gpio/devel' into devel-hourly-2019061516
git bisect good 7448723a0b6ac76fe0766c37fc7aaa123613de0b  # 01:14  G     10     0   10  10  Merge 'linux-review/fei-yang-intel-com/usb-gadget-f_fs-data_len-used-before-properly-set/20190614-094348' into devel-hourly-2019061516
git bisect good 3a54fca087b6a92c1bcf9c2b72bb2e70131d378e  # 01:56  G     10     0   10  10  Merge 'm68knommu/for-next' into devel-hourly-2019061516
git bisect  bad 9c9b3e34faeaeee28fce5b613c7f0e5930f8da5c  # 02:12  B      0     7   21   0  block: fix page leak when merging to same page
git bisect  bad 41c3b82ce7980f8e7b51cf2cf6c3f55fd8bc07c0  # 02:50  B      0     9   24   1  block: return from __bio_try_merge_page if merging occured in the same page
# first bad commit: [41c3b82ce7980f8e7b51cf2cf6c3f55fd8bc07c0] block: return from __bio_try_merge_page if merging occured in the same page
git bisect good 1d0c06513bd44e724f572ef9c932d0c889d183c6  # 03:45  G     30     0   25  25  block/ps3vram: Use %llu to format sector_t after LBDAF removal
# extra tests with debug options
git bisect  bad 41c3b82ce7980f8e7b51cf2cf6c3f55fd8bc07c0  # 04:16  B      0     3   22   4  block: return from __bio_try_merge_page if merging occured in the same page
# extra tests on HEAD of linux-devel/devel-hourly-2019061516
git bisect  bad b03773ed7363554492ff274f4a9364a4c30b3637  # 04:21  B      0    14   36   4  0day head guard for 'devel-hourly-2019061516'
# extra tests on tree/branch cgroup/block/for-linus
git bisect  bad 9c9b3e34faeaeee28fce5b613c7f0e5930f8da5c  # 04:27  B      0    12   26   0  block: fix page leak when merging to same page
# extra tests with first bad commit reverted
git bisect good 5333d4fc3975d26a16540fc2e959060a27500329  # 04:55  G     12     0    7   7  Revert "block: return from __bio_try_merge_page if merging occured in the same page"

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation

--=_5d055b54.q/3E1fY/IpzZAwn+Flm4zlzfDRdKl5nD54MhO6wyh+xwtWeZ
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-711:20190616024949:x86_64-randconfig-a0-06151807:5.2.0-rc4-00013-g41c3b82:1.gz"

H4sICDdbBV0AA2RtZXNnLXlvY3RvLXZtLXlvY3RvLTcxMToyMDE5MDYxNjAyNDk0OTp4ODZf
NjQtcmFuZGNvbmZpZy1hMC0wNjE1MTgwNzo1LjIuMC1yYzQtMDAwMTMtZzQxYzNiODI6MQDs
XOtv20iS/56/og/zYZwdS+onHwK0OPk10SWOvZYzk9vAECg+LK4lUkNSTjzIH39VTVKkXqac
9QCLg2jEEsmuX1d3V1VXVZfjO8n0ibhxlMZTn4QRSf1sMYcHnv/mOonHYXRPzs/OyJHveb04
CEgWEy9MnfHUf9tut0n88MZfh/C/ZYnjZqMHP4n86Zswmi+ykedkTpfQb7S8DJ9K7lrF66kf
rbzlIvCdsfcmXmTweuUVyz+KVxuUJnVNJqw3ee+jLM6c6SgN//RXWlmcGwgCnM7m8TSM/JHg
43C1J0ptDxu9OfPdeDZP/DTF+fgQRotvOPhrJ9EPzj9c4K0XR377zUkcZ/gwm/gk56H95guB
i7ZzzLscgDz6QB1HRLV5m7YSV7ZwcKJ1L5krxhYnRw/jRTj1/nv6MG/lX6nxlhzdu+6S1myL
NiVHZ/44dIq7Fnv7lvzEyHARkf+Bf8wglHc571JJToe3hFNmrzN0Gs9mTuQRnIcuSWAEvY7n
P3ZgciiZLKL7UeakD6O5E4VujxHPHy/uiTOHm/xr+pQmf4yc6VfnKR35EUqHRxJ3MYdV99vw
ZeTOF6MUVgIWJJz5sHQ9WEYS+Vk7DCJn5qc9SuZJGGUPbej4YZbe92B4eYctRtI4yKax+7CY
L5mIZuHoq5O5Ey++7+mHJI7nafF1GjveCNgHWX3ocYCG9cuWDyjxkrHXnoVRnIzceBFlPQsH
kfkzrz2N70GoHv1pz08SEt5DG38ED/WzUs57WfZEiRb9nG18MKTHjCkOA6u1qh4+3js9AJs5
U5J8xbl+6HVcfz4J0k6+vJ1kEbX+WPgLv/MUu1ncepy19JfON8sYGbKVwCIBdBDetxzaogZT
zKJmZ4ry1PKQv67+3ZrEC+CshWutWxndQqhc37QtGli+OVbMDbgbGK4IlAo8a+xS06XdcZj6
btbKMe1O+3GGX/9s7QtQdmpQLhW1W0Z3dSwtkzEyhpG4k16N8c4OxsnJ1dXtaHDZ//W815k/
3OeDbZgQUJGW2dmX4045xJ2auEVaULr9JGink0XmxV+jHl1XKmCxE8wXXdDE+TxOtFH4POz/
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
TXKboGfy04f/oMeH/wtl/4ioSvkAAA==

--=_5d055b54.q/3E1fY/IpzZAwn+Flm4zlzfDRdKl5nD54MhO6wyh+xwtWeZ
Content-Type: application/gzip
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg-yocto-vm-yocto-47bd4dbb8d52:20190616032527:x86_64-randconfig-a0-06151807:5.2.0-rc4-00012-g1d0c065:1.gz"

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

--=_5d055b54.q/3E1fY/IpzZAwn+Flm4zlzfDRdKl5nD54MhO6wyh+xwtWeZ
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="reproduce-yocto-vm-yocto-711:20190616024949:x86_64-randconfig-a0-06151807:5.2.0-rc4-00013-g41c3b82:1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

wget --no-clobber https://download.01.org/0day-ci/lkp-qemu/osimage/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep,+smap
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 2
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--=_5d055b54.q/3E1fY/IpzZAwn+Flm4zlzfDRdKl5nD54MhO6wyh+xwtWeZ
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config-5.2.0-rc4-00013-g41c3b82"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.2.0-rc4 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70300
CONFIG_CLANG_VERSION=0
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
CONFIG_SLAB_FREELIST_HARDENED=y
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
# CONFIG_X86_MPPARSE is not set
CONFIG_GOLDFISH=y
# CONFIG_RETPOLINE is not set
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_DEBUG=y
CONFIG_XEN=y
# CONFIG_XEN_PV is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_SAVE_RESTORE=y
CONFIG_XEN_DEBUG_FS=y
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_PVH=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=y
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
# CONFIG_PERF_EVENTS_INTEL_CSTATE is not set
CONFIG_PERF_EVENTS_AMD_POWER=y
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=y
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
CONFIG_SECCOMP=y
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
# CONFIG_KEXEC_FILE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_PM_SLEEP=y
# CONFIG_PM_AUTOSLEEP is not set
CONFIG_PM_WAKELOCKS=y
CONFIG_PM_WAKELOCKS_LIMIT=100
CONFIG_PM_WAKELOCKS_GC=y
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_ACPI_EXTLOG is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
CONFIG_CPUFREQ_DT_PLATDEV=y
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# end of CPU Idle

# CONFIG_INTEL_IDLE is not set
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_MMCONFIG is not set
CONFIG_PCI_XEN=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_X86_SYSFB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# CONFIG_X86_X32 is not set
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y
CONFIG_HAVE_GENERIC_GUP=y

#
# Firmware Drivers
#
CONFIG_EDD=y
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set

#
# General architecture-dependent options
#
CONFIG_OPROFILE=y
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
# CONFIG_JUMP_LABEL is not set
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_64BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
CONFIG_GCC_PLUGIN_LATENT_ENTROPY=y
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
# CONFIG_MODULES is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
# CONFIG_BLK_DEV_INTEGRITY is not set
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
# CONFIG_MEMORY_HOTREMOVE is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_MEMORY_FAILURE is not set
# CONFIG_TRANSPARENT_HUGEPAGE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_ZPOOL=y
# CONFIG_ZBUD is not set
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM_MIRROR=y
CONFIG_FRAME_VECTOR=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=y
CONFIG_TLS_DEVICE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
# CONFIG_IP_MULTIPLE_TABLES is not set
# CONFIG_IP_ROUTE_MULTIPATH is not set
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
# CONFIG_IP_PIMSM_V1 is not set
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=y

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=y
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=y
# CONFIG_NETFILTER_NETLINK_QUEUE is not set
# CONFIG_NETFILTER_NETLINK_LOG is not set
CONFIG_NETFILTER_NETLINK_OSF=y
CONFIG_NF_CONNTRACK=y
CONFIG_NF_LOG_COMMON=y
CONFIG_NF_LOG_NETDEV=y
CONFIG_NETFILTER_CONNCOUNT=y
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
# CONFIG_NF_CONNTRACK_ZONES is not set
CONFIG_NF_CONNTRACK_PROCFS=y
# CONFIG_NF_CONNTRACK_EVENTS is not set
# CONFIG_NF_CONNTRACK_TIMEOUT is not set
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
# CONFIG_NF_CT_PROTO_SCTP is not set
# CONFIG_NF_CT_PROTO_UDPLITE is not set
CONFIG_NF_CONNTRACK_AMANDA=y
CONFIG_NF_CONNTRACK_FTP=y
CONFIG_NF_CONNTRACK_H323=y
CONFIG_NF_CONNTRACK_IRC=y
CONFIG_NF_CONNTRACK_BROADCAST=y
# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
CONFIG_NF_CONNTRACK_SNMP=y
CONFIG_NF_CONNTRACK_PPTP=y
# CONFIG_NF_CONNTRACK_SANE is not set
CONFIG_NF_CONNTRACK_SIP=y
# CONFIG_NF_CONNTRACK_TFTP is not set
CONFIG_NF_CT_NETLINK=y
CONFIG_NF_NAT=y
CONFIG_NF_NAT_AMANDA=y
CONFIG_NF_NAT_FTP=y
CONFIG_NF_NAT_IRC=y
CONFIG_NF_NAT_SIP=y
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=y
CONFIG_NF_TABLES=y
# CONFIG_NF_TABLES_SET is not set
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=y
# CONFIG_NFT_COUNTER is not set
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=y
CONFIG_NFT_LIMIT=y
CONFIG_NFT_MASQ=y
CONFIG_NFT_REDIR=y
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUOTA=y
CONFIG_NFT_REJECT=y
CONFIG_NFT_COMPAT=y
CONFIG_NFT_HASH=y
CONFIG_NFT_XFRM=y
CONFIG_NFT_SOCKET=y
CONFIG_NFT_OSF=y
CONFIG_NFT_TPROXY=y
CONFIG_NF_DUP_NETDEV=y
# CONFIG_NFT_DUP_NETDEV is not set
CONFIG_NFT_FWD_NETDEV=y
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=y
CONFIG_NETFILTER_XT_CONNMARK=y
CONFIG_NETFILTER_XT_SET=y

#
# Xtables targets
#
# CONFIG_NETFILTER_XT_TARGET_CLASSIFY is not set
CONFIG_NETFILTER_XT_TARGET_CONNMARK=y
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
CONFIG_NETFILTER_XT_TARGET_CT=y
# CONFIG_NETFILTER_XT_TARGET_HMARK is not set
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=y
# CONFIG_NETFILTER_XT_TARGET_LOG is not set
CONFIG_NETFILTER_XT_TARGET_MARK=y
CONFIG_NETFILTER_XT_NAT=y
# CONFIG_NETFILTER_XT_TARGET_NETMAP is not set
# CONFIG_NETFILTER_XT_TARGET_NFLOG is not set
# CONFIG_NETFILTER_XT_TARGET_NFQUEUE is not set
CONFIG_NETFILTER_XT_TARGET_NOTRACK=y
CONFIG_NETFILTER_XT_TARGET_RATEEST=y
CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
CONFIG_NETFILTER_XT_TARGET_TEE=y
CONFIG_NETFILTER_XT_TARGET_TRACE=y
CONFIG_NETFILTER_XT_TARGET_SECMARK=y
# CONFIG_NETFILTER_XT_TARGET_TCPMSS is not set

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=y
CONFIG_NETFILTER_XT_MATCH_BPF=y
# CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
CONFIG_NETFILTER_XT_MATCH_CLUSTER=y
CONFIG_NETFILTER_XT_MATCH_COMMENT=y
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=y
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=y
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=y
CONFIG_NETFILTER_XT_MATCH_CONNMARK=y
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=y
CONFIG_NETFILTER_XT_MATCH_CPU=y
CONFIG_NETFILTER_XT_MATCH_DCCP=y
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=y
CONFIG_NETFILTER_XT_MATCH_DSCP=y
# CONFIG_NETFILTER_XT_MATCH_ECN is not set
# CONFIG_NETFILTER_XT_MATCH_ESP is not set
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=y
# CONFIG_NETFILTER_XT_MATCH_HELPER is not set
CONFIG_NETFILTER_XT_MATCH_HL=y
CONFIG_NETFILTER_XT_MATCH_IPCOMP=y
# CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
CONFIG_NETFILTER_XT_MATCH_IPVS=y
CONFIG_NETFILTER_XT_MATCH_L2TP=y
# CONFIG_NETFILTER_XT_MATCH_LENGTH is not set
CONFIG_NETFILTER_XT_MATCH_LIMIT=y
CONFIG_NETFILTER_XT_MATCH_MAC=y
CONFIG_NETFILTER_XT_MATCH_MARK=y
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=y
CONFIG_NETFILTER_XT_MATCH_NFACCT=y
# CONFIG_NETFILTER_XT_MATCH_OSF is not set
# CONFIG_NETFILTER_XT_MATCH_OWNER is not set
CONFIG_NETFILTER_XT_MATCH_POLICY=y
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=y
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=y
# CONFIG_NETFILTER_XT_MATCH_QUOTA is not set
CONFIG_NETFILTER_XT_MATCH_RATEEST=y
# CONFIG_NETFILTER_XT_MATCH_REALM is not set
CONFIG_NETFILTER_XT_MATCH_RECENT=y
CONFIG_NETFILTER_XT_MATCH_SCTP=y
CONFIG_NETFILTER_XT_MATCH_SOCKET=y
# CONFIG_NETFILTER_XT_MATCH_STATE is not set
CONFIG_NETFILTER_XT_MATCH_STATISTIC=y
CONFIG_NETFILTER_XT_MATCH_STRING=y
# CONFIG_NETFILTER_XT_MATCH_TCPMSS is not set
CONFIG_NETFILTER_XT_MATCH_TIME=y
# CONFIG_NETFILTER_XT_MATCH_U32 is not set
# end of Core Netfilter Configuration

CONFIG_IP_SET=y
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=y
CONFIG_IP_SET_BITMAP_IPMAC=y
CONFIG_IP_SET_BITMAP_PORT=y
CONFIG_IP_SET_HASH_IP=y
CONFIG_IP_SET_HASH_IPMARK=y
CONFIG_IP_SET_HASH_IPPORT=y
CONFIG_IP_SET_HASH_IPPORTIP=y
CONFIG_IP_SET_HASH_IPPORTNET=y
CONFIG_IP_SET_HASH_IPMAC=y
# CONFIG_IP_SET_HASH_MAC is not set
CONFIG_IP_SET_HASH_NETPORTNET=y
CONFIG_IP_SET_HASH_NET=y
CONFIG_IP_SET_HASH_NETNET=y
CONFIG_IP_SET_HASH_NETPORT=y
CONFIG_IP_SET_HASH_NETIFACE=y
CONFIG_IP_SET_LIST_SET=y
CONFIG_IP_VS=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
# CONFIG_IP_VS_PROTO_TCP is not set
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
# CONFIG_IP_VS_PROTO_ESP is not set
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
# CONFIG_IP_VS_RR is not set
CONFIG_IP_VS_WRR=y
CONFIG_IP_VS_LC=y
CONFIG_IP_VS_WLC=y
CONFIG_IP_VS_FO=y
CONFIG_IP_VS_OVF=y
CONFIG_IP_VS_LBLC=y
CONFIG_IP_VS_LBLCR=y
CONFIG_IP_VS_DH=y
# CONFIG_IP_VS_SH is not set
CONFIG_IP_VS_MH=y
CONFIG_IP_VS_SED=y
CONFIG_IP_VS_NQ=y

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_NFCT=y
# CONFIG_IP_VS_PE_SIP is not set

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=y
CONFIG_NF_SOCKET_IPV4=y
CONFIG_NF_TPROXY_IPV4=y
# CONFIG_NF_TABLES_IPV4 is not set
CONFIG_NF_TABLES_ARP=y
CONFIG_NF_DUP_IPV4=y
CONFIG_NF_LOG_ARP=y
CONFIG_NF_LOG_IPV4=y
CONFIG_NF_REJECT_IPV4=y
# CONFIG_NF_NAT_SNMP_BASIC is not set
CONFIG_NF_NAT_PPTP=y
CONFIG_NF_NAT_H323=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_AH=y
# CONFIG_IP_NF_MATCH_ECN is not set
CONFIG_IP_NF_MATCH_RPFILTER=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_TARGET_SYNPROXY=y
# CONFIG_IP_NF_NAT is not set
# CONFIG_IP_NF_MANGLE is not set
CONFIG_IP_NF_RAW=y
CONFIG_IP_NF_SECURITY=y
# CONFIG_IP_NF_ARPTABLES is not set
# end of IP: Netfilter Configuration

#
# DECnet: Netfilter Configuration
#
# CONFIG_DECNET_NF_GRABULATOR is not set
# end of DECnet: Netfilter Configuration

# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_BRIDGE_NF_EBTABLES is not set
CONFIG_BPFILTER=y
CONFIG_BPFILTER_UMH=y
CONFIG_IP_DCCP=y

#
# DCCP CCIDs Configuration
#
CONFIG_IP_DCCP_CCID2_DEBUG=y
CONFIG_IP_DCCP_CCID3=y
CONFIG_IP_DCCP_CCID3_DEBUG=y
CONFIG_IP_DCCP_TFRC_LIB=y
CONFIG_IP_DCCP_TFRC_DEBUG=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
CONFIG_IP_DCCP_DEBUG=y
# end of DCCP Kernel Hacking

# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_DIAG=y
CONFIG_ATM=y
# CONFIG_ATM_CLIP is not set
CONFIG_ATM_LANE=y
CONFIG_ATM_MPOA=y
CONFIG_ATM_BR2684=y
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=y
CONFIG_L2TP_DEBUGFS=y
# CONFIG_L2TP_V3 is not set
CONFIG_STP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
# CONFIG_BRIDGE_VLAN_FILTERING is not set
CONFIG_HAVE_NET_DSA=y
CONFIG_NET_DSA=y
CONFIG_NET_DSA_TAG_8021Q=y
CONFIG_NET_DSA_TAG_BRCM_COMMON=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_GSWIP=y
CONFIG_NET_DSA_TAG_DSA=y
CONFIG_NET_DSA_TAG_EDSA=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_KSZ_COMMON=y
CONFIG_NET_DSA_TAG_KSZ=y
CONFIG_NET_DSA_TAG_KSZ9477=y
# CONFIG_NET_DSA_TAG_QCA is not set
CONFIG_NET_DSA_TAG_LAN9303=y
CONFIG_NET_DSA_TAG_SJA1105=y
CONFIG_NET_DSA_TAG_TRAILER=y
CONFIG_VLAN_8021Q=y
# CONFIG_VLAN_8021Q_GVRP is not set
CONFIG_VLAN_8021Q_MVRP=y
CONFIG_DECNET=y
CONFIG_DECNET_ROUTER=y
CONFIG_LLC=y
# CONFIG_LLC2 is not set
CONFIG_ATALK=y
CONFIG_DEV_APPLETALK=y
CONFIG_IPDDP=y
CONFIG_IPDDP_ENCAP=y
# CONFIG_X25 is not set
CONFIG_LAPB=y
CONFIG_PHONET=y
CONFIG_IEEE802154=y
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=y
# CONFIG_NET_SCH_HTB is not set
# CONFIG_NET_SCH_HFSC is not set
CONFIG_NET_SCH_ATM=y
# CONFIG_NET_SCH_PRIO is not set
CONFIG_NET_SCH_MULTIQ=y
# CONFIG_NET_SCH_RED is not set
# CONFIG_NET_SCH_SFB is not set
CONFIG_NET_SCH_SFQ=y
CONFIG_NET_SCH_TEQL=y
# CONFIG_NET_SCH_TBF is not set
CONFIG_NET_SCH_CBS=y
CONFIG_NET_SCH_ETF=y
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=y
# CONFIG_NET_SCH_DSMARK is not set
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_DRR=y
CONFIG_NET_SCH_MQPRIO=y
CONFIG_NET_SCH_SKBPRIO=y
CONFIG_NET_SCH_CHOKE=y
CONFIG_NET_SCH_QFQ=y
CONFIG_NET_SCH_CODEL=y
# CONFIG_NET_SCH_FQ_CODEL is not set
CONFIG_NET_SCH_CAKE=y
# CONFIG_NET_SCH_FQ is not set
CONFIG_NET_SCH_HHF=y
CONFIG_NET_SCH_PIE=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=y
CONFIG_NET_SCH_DEFAULT=y
CONFIG_DEFAULT_CODEL=y
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH="pfifo_fast"

#
# Classification
#
CONFIG_NET_CLS=y
# CONFIG_NET_CLS_BASIC is not set
# CONFIG_NET_CLS_TCINDEX is not set
CONFIG_NET_CLS_ROUTE4=y
# CONFIG_NET_CLS_FW is not set
# CONFIG_NET_CLS_U32 is not set
CONFIG_NET_CLS_RSVP=y
CONFIG_NET_CLS_RSVP6=y
# CONFIG_NET_CLS_FLOW is not set
# CONFIG_NET_CLS_CGROUP is not set
# CONFIG_NET_CLS_BPF is not set
CONFIG_NET_CLS_FLOWER=y
# CONFIG_NET_CLS_MATCHALL is not set
# CONFIG_NET_EMATCH is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=y
CONFIG_NET_ACT_GACT=y
# CONFIG_GACT_PROB is not set
CONFIG_NET_ACT_MIRRED=y
CONFIG_NET_ACT_SAMPLE=y
# CONFIG_NET_ACT_IPT is not set
CONFIG_NET_ACT_NAT=y
CONFIG_NET_ACT_PEDIT=y
# CONFIG_NET_ACT_SIMP is not set
CONFIG_NET_ACT_SKBEDIT=y
CONFIG_NET_ACT_CSUM=y
CONFIG_NET_ACT_VLAN=y
CONFIG_NET_ACT_BPF=y
CONFIG_NET_ACT_CONNMARK=y
# CONFIG_NET_ACT_SKBMOD is not set
# CONFIG_NET_ACT_IFE is not set
# CONFIG_NET_ACT_TUNNEL_KEY is not set
CONFIG_NET_SCH_FIFO=y
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
# CONFIG_BATMAN_ADV_BATMAN_V is not set
# CONFIG_BATMAN_ADV_BLA is not set
# CONFIG_BATMAN_ADV_DAT is not set
# CONFIG_BATMAN_ADV_NC is not set
CONFIG_BATMAN_ADV_MCAST=y
CONFIG_BATMAN_ADV_DEBUGFS=y
CONFIG_BATMAN_ADV_DEBUG=y
CONFIG_BATMAN_ADV_SYSFS=y
CONFIG_BATMAN_ADV_TRACING=y
CONFIG_OPENVSWITCH=y
# CONFIG_OPENVSWITCH_GRE is not set
CONFIG_OPENVSWITCH_GENEVE=y
CONFIG_VSOCKETS=y
# CONFIG_VSOCKETS_DIAG is not set
# CONFIG_VMWARE_VMCI_VSOCKETS is not set
CONFIG_VIRTIO_VSOCKETS=y
CONFIG_VIRTIO_VSOCKETS_COMMON=y
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
CONFIG_MPLS_IPTUNNEL=y
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=y

#
# Packet Radio protocols
#
CONFIG_AX25=y
# CONFIG_AX25_DAMA_SLAVE is not set
# CONFIG_NETROM is not set
CONFIG_ROSE=y

#
# AX.25 network device drivers
#
CONFIG_MKISS=y
CONFIG_6PACK=y
CONFIG_BPQETHER=y
CONFIG_BAYCOM_SER_FDX=y
# CONFIG_BAYCOM_SER_HDX is not set
CONFIG_BAYCOM_PAR=y
CONFIG_YAM=y
# end of AX.25 network device drivers

CONFIG_CAN=y
CONFIG_CAN_RAW=y
# CONFIG_CAN_BCM is not set
# CONFIG_CAN_GW is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=y
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=y
# CONFIG_CAN_DEV is not set
# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=y
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=y
CONFIG_BT_RFCOMM_TTY=y
# CONFIG_BT_BNEP is not set
# CONFIG_BT_HIDP is not set
# CONFIG_BT_HS is not set
CONFIG_BT_LE=y
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=y
# CONFIG_BT_HCIBTUSB is not set
# CONFIG_BT_HCIBTSDIO is not set
CONFIG_BT_HCIUART=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
CONFIG_BT_HCIUART_AG6XX=y
# CONFIG_BT_HCIUART_MRVL is not set
CONFIG_BT_HCIBCM203X=y
CONFIG_BT_HCIBPA10X=y
# CONFIG_BT_HCIBFUSB is not set
CONFIG_BT_HCIVHCI=y
CONFIG_BT_MRVL=y
CONFIG_BT_MRVL_SDIO=y
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
CONFIG_AF_RXRPC_DEBUG=y
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_NET_9P_XEN=y
CONFIG_NET_9P_DEBUG=y
CONFIG_CAIF=y
# CONFIG_CAIF_DEBUG is not set
# CONFIG_CAIF_NETDEV is not set
# CONFIG_CAIF_USB is not set
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
# CONFIG_LWTUNNEL_BPF is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_SOCK_VALIDATE_XMIT=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_FAILOVER=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
# CONFIG_PCI_STUB is not set
CONFIG_PCI_PF_STUB=y
CONFIG_XEN_PCIDEV_FRONTEND=y
CONFIG_PCI_ATS=y
CONFIG_PCI_ECAM=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=y
CONFIG_PCIE_CADENCE_HOST=y
# CONFIG_PCIE_CADENCE_EP is not set
# end of Cadence PCIe controllers support

# CONFIG_PCI_FTPCI100 is not set
CONFIG_PCI_HOST_COMMON=y
CONFIG_PCI_HOST_GENERIC=y
CONFIG_PCIE_XILINX=y
CONFIG_VMD=y

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCIE_DW_PLAT_EP is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=y
# CONFIG_PCI_ENDPOINT_CONFIGFS is not set
CONFIG_PCI_EPF_TEST=y
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
# CONFIG_CARDBUS is not set

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
CONFIG_DEBUG_TEST_DRIVER_REMOVE=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_SIMPLE_PM_BUS=y
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
CONFIG_GNSS=y
CONFIG_MTD=y
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_AR7_PARTS=y

#
# Partition parsers
#
CONFIG_MTD_REDBOOT_PARTS=y
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED=y
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_FTL=y
# CONFIG_NFTL is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
CONFIG_SSFDC=y
CONFIG_SM_FTL=y
# CONFIG_MTD_OOPS is not set
CONFIG_MTD_PARTITIONED_MASTER=y

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_AMD76XROM=y
CONFIG_MTD_ICHXROM=y
CONFIG_MTD_ESB2ROM=y
CONFIG_MTD_CK804XROM=y
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
CONFIG_MTD_L440GX=y
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=y
CONFIG_MTD_PMC551_BUGFIX=y
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=y
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=y

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_RAW_NAND=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=y
CONFIG_MTD_NAND_DENALI_PCI=y
CONFIG_MTD_NAND_DENALI_DT=y
CONFIG_MTD_NAND_CAFE=y
CONFIG_MTD_NAND_PLATFORM=y

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=y
# CONFIG_MTD_NAND_RICOH is not set
# CONFIG_MTD_NAND_DISKONCHIP is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=y
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=y
# CONFIG_SPI_MTK_QUADSPI is not set
# CONFIG_SPI_INTEL_SPI_PCI is not set
# CONFIG_SPI_INTEL_SPI_PLATFORM is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
CONFIG_MTD_UBI_FASTMAP=y
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_KOBJ=y
CONFIG_OF_DYNAMIC=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESOLVE=y
CONFIG_OF_OVERLAY=y
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
CONFIG_PARPORT_AX88796=y
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=y
# CONFIG_ZRAM is not set
CONFIG_BLK_DEV_UMEM=y
# CONFIG_BLK_DEV_LOOP is not set
CONFIG_BLK_DEV_DRBD=y
CONFIG_DRBD_FAULT_INJECTION=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_SKD=y
CONFIG_BLK_DEV_SX8=y
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
CONFIG_ATA_OVER_ETH=y
# CONFIG_XEN_BLKDEV_FRONTEND is not set
CONFIG_XEN_BLKDEV_BACKEND=y
# CONFIG_VIRTIO_BLK is not set
CONFIG_BLK_DEV_RBD=y
CONFIG_BLK_DEV_RSXX=y

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=y
# CONFIG_NVME_FC is not set
CONFIG_NVME_TCP=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_DUMMY_IRQ=y
CONFIG_IBM_ASM=y
CONFIG_PHANTOM=y
CONFIG_SGI_IOC4=y
CONFIG_TIFM_CORE=y
CONFIG_TIFM_7XX1=y
CONFIG_ICS932S401=y
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
CONFIG_HMC6352=y
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=y
CONFIG_USB_SWITCH_FSA9480=y
CONFIG_SRAM=y
CONFIG_PCI_ENDPOINT_TEST=y
CONFIG_MISC_RTSX=y
CONFIG_PVPANIC=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
CONFIG_EEPROM_93CX6=y
# CONFIG_EEPROM_IDT_89HPESX is not set
CONFIG_EEPROM_EE1004=y
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
CONFIG_ALTERA_STAPL=y
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
CONFIG_INTEL_MEI_TXE=y
CONFIG_INTEL_MEI_HDCP=y
CONFIG_VMWARE_VMCI=y

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
CONFIG_INTEL_MIC_BUS=y

#
# SCIF Bus Driver
#
CONFIG_SCIF_BUS=y

#
# VOP Bus Driver
#
CONFIG_VOP_BUS=y

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
# CONFIG_SCIF is not set

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_VOP is not set
CONFIG_VHOST_RING=y
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
CONFIG_MISC_RTSX_USB=y
CONFIG_HABANA_AI=y
# end of Misc devices

CONFIG_HAVE_IDE=y
CONFIG_IDE=y

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_XFER_MODE=y
CONFIG_IDE_TIMINGS=y
# CONFIG_BLK_DEV_IDE_SATA is not set
CONFIG_IDE_GD=y
CONFIG_IDE_GD_ATA=y
# CONFIG_IDE_GD_ATAPI is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEACPI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_PROC_FS=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_PLATFORM is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEDMA_SFF=y

#
# PCI IDE chipsets support
#
CONFIG_BLK_DEV_IDEPCI=y
# CONFIG_IDEPCI_PCIBUS_ORDER is not set
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_OPTI621=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_AEC62XX=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
CONFIG_BLK_DEV_HPT366=y
CONFIG_BLK_DEV_JMICRON=y
CONFIG_BLK_DEV_PIIX=y
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
CONFIG_BLK_DEV_IT821X=y
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
CONFIG_BLK_DEV_TRM290=y
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_BLK_DEV_TC86C001 is not set
CONFIG_BLK_DEV_IDEDMA=y

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
# CONFIG_BLK_DEV_SD is not set
CONFIG_CHR_DEV_ST=y
CONFIG_CHR_DEV_OSST=y
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=y
CONFIG_ISCSI_BOOT_SYSFS=y
CONFIG_SCSI_CXGB3_ISCSI=y
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
CONFIG_SCSI_BNX2X_FCOE=y
CONFIG_BE2ISCSI=y
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
CONFIG_SCSI_ACARD=y
CONFIG_SCSI_AACRAID=y
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_BUILD_FIRMWARE is not set
CONFIG_AIC79XX_DEBUG_ENABLE=y
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
CONFIG_SCSI_AIC94XX=y
CONFIG_AIC94XX_DEBUG=y
CONFIG_SCSI_MVSAS=y
# CONFIG_SCSI_MVSAS_DEBUG is not set
# CONFIG_SCSI_MVSAS_TASKLET is not set
CONFIG_SCSI_MVUMI=y
# CONFIG_SCSI_DPT_I2O is not set
CONFIG_SCSI_ADVANSYS=y
# CONFIG_SCSI_ARCMSR is not set
CONFIG_SCSI_ESAS2R=y
# CONFIG_MEGARAID_NEWGEN is not set
CONFIG_MEGARAID_LEGACY=y
CONFIG_MEGARAID_SAS=y
CONFIG_SCSI_MPT3SAS=y
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=y
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=y
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
CONFIG_SCSI_MYRB=y
CONFIG_SCSI_MYRS=y
# CONFIG_VMWARE_PVSCSI is not set
CONFIG_XEN_SCSI_FRONTEND=y
CONFIG_LIBFC=y
CONFIG_LIBFCOE=y
# CONFIG_FCOE is not set
CONFIG_FCOE_FNIC=y
CONFIG_SCSI_SNIC=y
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=y
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=y
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_PPA=y
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
# CONFIG_SCSI_STEX is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=y
CONFIG_SCSI_QLA_ISCSI=y
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
CONFIG_SCSI_PMCRAID=y
# CONFIG_SCSI_PM8001 is not set
# CONFIG_SCSI_BFA_FC is not set
# CONFIG_SCSI_VIRTIO is not set
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
# CONFIG_BLK_DEV_DM is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_FC=y
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
# CONFIG_FUSION_CTL is not set
CONFIG_FUSION_LAN=y
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_SBP2 is not set
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=y
CONFIG_DUMMY=y
CONFIG_EQUALIZER=y
CONFIG_NET_FC=y
# CONFIG_IFB is not set
CONFIG_NET_TEAM=y
# CONFIG_NET_TEAM_MODE_BROADCAST is not set
CONFIG_NET_TEAM_MODE_ROUNDROBIN=y
CONFIG_NET_TEAM_MODE_RANDOM=y
# CONFIG_NET_TEAM_MODE_ACTIVEBACKUP is not set
# CONFIG_NET_TEAM_MODE_LOADBALANCE is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
CONFIG_GENEVE=y
CONFIG_GTP=y
CONFIG_MACSEC=y
# CONFIG_NETCONSOLE is not set
# CONFIG_NTB_NETDEV is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=y
CONFIG_NLMON=y
CONFIG_ARCNET=y
CONFIG_ARCNET_1201=y
CONFIG_ARCNET_1051=y
CONFIG_ARCNET_RAW=y
CONFIG_ARCNET_CAP=y
CONFIG_ARCNET_COM90xx=y
CONFIG_ARCNET_COM90xxIO=y
# CONFIG_ARCNET_RIM_I is not set
# CONFIG_ARCNET_COM20020 is not set
CONFIG_ATM_DRIVERS=y
CONFIG_ATM_DUMMY=y
CONFIG_ATM_TCP=y
CONFIG_ATM_LANAI=y
CONFIG_ATM_ENI=y
CONFIG_ATM_ENI_DEBUG=y
CONFIG_ATM_ENI_TUNE_BURST=y
# CONFIG_ATM_ENI_BURST_TX_16W is not set
CONFIG_ATM_ENI_BURST_TX_8W=y
CONFIG_ATM_ENI_BURST_TX_4W=y
CONFIG_ATM_ENI_BURST_TX_2W=y
# CONFIG_ATM_ENI_BURST_RX_16W is not set
CONFIG_ATM_ENI_BURST_RX_8W=y
CONFIG_ATM_ENI_BURST_RX_4W=y
# CONFIG_ATM_ENI_BURST_RX_2W is not set
# CONFIG_ATM_FIRESTREAM is not set
CONFIG_ATM_ZATM=y
CONFIG_ATM_ZATM_DEBUG=y
CONFIG_ATM_NICSTAR=y
CONFIG_ATM_NICSTAR_USE_SUNI=y
CONFIG_ATM_NICSTAR_USE_IDT77105=y
CONFIG_ATM_IDT77252=y
# CONFIG_ATM_IDT77252_DEBUG is not set
CONFIG_ATM_IDT77252_RCV_ALL=y
CONFIG_ATM_IDT77252_USE_SUNI=y
CONFIG_ATM_AMBASSADOR=y
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=y
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=y
CONFIG_ATM_IA_DEBUG=y
# CONFIG_ATM_FORE200E is not set
# CONFIG_ATM_HE is not set
CONFIG_ATM_SOLOS=y

#
# CAIF transport drivers
#
CONFIG_CAIF_TTY=y
CONFIG_CAIF_SPI_SLAVE=y
CONFIG_CAIF_SPI_SYNC=y
CONFIG_CAIF_HSI=y
CONFIG_CAIF_VIRTIO=y

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
# CONFIG_B53_MDIO_DRIVER is not set
CONFIG_B53_MMAP_DRIVER=y
# CONFIG_B53_SRAB_DRIVER is not set
CONFIG_B53_SERDES=y
# CONFIG_NET_DSA_BCM_SF2 is not set
CONFIG_NET_DSA_LOOP=y
CONFIG_NET_DSA_LANTIQ_GSWIP=y
CONFIG_NET_DSA_MT7530=y
CONFIG_NET_DSA_MV88E6060=y
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
CONFIG_NET_DSA_MV88E6XXX=y
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=y
CONFIG_NET_DSA_MV88E6XXX_PTP=y
# CONFIG_NET_DSA_QCA8K is not set
CONFIG_NET_DSA_REALTEK_SMI=y
CONFIG_NET_DSA_SMSC_LAN9303=y
CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=y
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_VORTEX is not set
CONFIG_TYPHOON=y
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=y
# CONFIG_NET_VENDOR_ALACRITECH is not set
CONFIG_NET_VENDOR_ALTEON=y
CONFIG_ACENIC=y
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=y
CONFIG_PCNET32=y
CONFIG_AMD_XGBE=y
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
CONFIG_NET_VENDOR_AURORA=y
CONFIG_AURORA_NB8800=y
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=y
# CONFIG_TIGON3_HWMON is not set
CONFIG_BNX2X=y
CONFIG_BNX2X_SRIOV=y
CONFIG_SYSTEMPORT=y
CONFIG_BNXT=y
# CONFIG_BNXT_SRIOV is not set
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
# CONFIG_NET_VENDOR_CADENCE is not set
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_THUNDER_NIC_PF=y
CONFIG_THUNDER_NIC_VF=y
CONFIG_THUNDER_NIC_BGX=y
CONFIG_THUNDER_NIC_RGX=y
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=y
# CONFIG_LIQUIDIO_VF is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
# CONFIG_CHELSIO_T4VF is not set
CONFIG_CHELSIO_LIB=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=y
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=y
# CONFIG_BE2NET_HWMON is not set
# CONFIG_BE2NET_BE2 is not set
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
# CONFIG_BE2NET_SKYHAWK is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=y
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
CONFIG_JME=y
# CONFIG_NET_VENDOR_MARVELL is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=y
CONFIG_MLX4_CORE=y
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NATSEMI=y
CONFIG_NS83820=y
CONFIG_NET_VENDOR_NETERION=y
CONFIG_S2IO=y
# CONFIG_VXGE is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_8390=y
CONFIG_NE2K_PCI=y
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=y
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
CONFIG_QLCNIC=y
CONFIG_QLCNIC_SRIOV=y
# CONFIG_QLCNIC_HWMON is not set
CONFIG_QLGE=y
CONFIG_NETXEN_NIC=y
CONFIG_QED=y
CONFIG_QED_SRIOV=y
# CONFIG_QEDE is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=y
CONFIG_SFC_MTD=y
# CONFIG_SFC_MCDI_MON is not set
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=y
# CONFIG_SFC_FALCON_MTD is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_EPIC100 is not set
CONFIG_SMSC911X=y
CONFIG_SMSC9420=y
# CONFIG_NET_VENDOR_SOCIONEXT is not set
CONFIG_NET_VENDOR_STMICRO=y
CONFIG_STMMAC_ETH=y
# CONFIG_STMMAC_PLATFORM is not set
CONFIG_STMMAC_PCI=y
CONFIG_NET_VENDOR_SUN=y
CONFIG_HAPPYMEAL=y
# CONFIG_SUNGEM is not set
CONFIG_CASSINI=y
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BUS_MUX=y
CONFIG_MDIO_BUS_MUX_MMIOREG=y
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=y
CONFIG_MDIO_CAVIUM=y
CONFIG_MDIO_HISI_FEMAC=y
CONFIG_MDIO_MSCC_MIIM=y
CONFIG_MDIO_OCTEON=y
CONFIG_MDIO_THUNDER=y
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y

#
# MII PHY device drivers
#
# CONFIG_SFP is not set
CONFIG_AMD_PHY=y
# CONFIG_AQUANTIA_PHY is not set
CONFIG_ASIX_PHY=y
CONFIG_AT803X_PHY=y
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_BROADCOM_PHY=y
CONFIG_CICADA_PHY=y
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_LXT_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
# CONFIG_MICREL_PHY is not set
CONFIG_MICROCHIP_PHY=y
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=y
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
CONFIG_RENESAS_PHY=y
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
CONFIG_STE10XP=y
# CONFIG_TERANETICS_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=y
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=y
CONFIG_PPPOE=y
# CONFIG_PPTP is not set
# CONFIG_PPPOL2TP is not set
CONFIG_PPP_ASYNC=y
CONFIG_PPP_SYNC_TTY=y
CONFIG_SLIP=y
CONFIG_SLHC=y
# CONFIG_SLIP_COMPRESSED is not set
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=y
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
# CONFIG_USB_NET_AX8817X is not set
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
CONFIG_USB_NET_CDC_MBIM=y
CONFIG_USB_NET_DM9601=y
CONFIG_USB_NET_SR9700=y
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
# CONFIG_USB_NET_MCS7830 is not set
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=y
# CONFIG_USB_NET_KALMIA is not set
CONFIG_USB_NET_QMI_WWAN=y
# CONFIG_USB_NET_INT51X1 is not set
CONFIG_USB_CDC_PHONET=y
# CONFIG_USB_IPHETH is not set
CONFIG_USB_SIERRA_NET=y
# CONFIG_USB_VL600 is not set
CONFIG_USB_NET_CH9200=y
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
CONFIG_IEEE802154_ATUSB=y
CONFIG_IEEE802154_HWSIM=y
# CONFIG_XEN_NETDEV_FRONTEND is not set
# CONFIG_XEN_NETDEV_BACKEND is not set
CONFIG_VMXNET3=y
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=y
# CONFIG_ISDN is not set
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_EVDEV is not set
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=y
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_JOYSTICK_A3D=y
# CONFIG_JOYSTICK_ADI is not set
# CONFIG_JOYSTICK_COBRA is not set
CONFIG_JOYSTICK_GF2K=y
CONFIG_JOYSTICK_GRIP=y
CONFIG_JOYSTICK_GRIP_MP=y
CONFIG_JOYSTICK_GUILLEMOT=y
# CONFIG_JOYSTICK_INTERACT is not set
CONFIG_JOYSTICK_SIDEWINDER=y
CONFIG_JOYSTICK_TMDC=y
# CONFIG_JOYSTICK_IFORCE is not set
# CONFIG_JOYSTICK_WARRIOR is not set
CONFIG_JOYSTICK_MAGELLAN=y
# CONFIG_JOYSTICK_SPACEORB is not set
# CONFIG_JOYSTICK_SPACEBALL is not set
CONFIG_JOYSTICK_STINGER=y
# CONFIG_JOYSTICK_TWIDJOY is not set
CONFIG_JOYSTICK_ZHENHUA=y
CONFIG_JOYSTICK_DB9=y
# CONFIG_JOYSTICK_GAMECON is not set
CONFIG_JOYSTICK_TURBOGRAFX=y
CONFIG_JOYSTICK_AS5011=y
CONFIG_JOYSTICK_JOYDUMP=y
CONFIG_JOYSTICK_XPAD=y
CONFIG_JOYSTICK_XPAD_FF=y
CONFIG_JOYSTICK_XPAD_LEDS=y
CONFIG_JOYSTICK_PXRC=y
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
CONFIG_TOUCHSCREEN_88PM860X=y
CONFIG_TOUCHSCREEN_AD7879=y
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_AR1021_I2C=y
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
CONFIG_TOUCHSCREEN_BU21013=y
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DYNAPRO=y
CONFIG_TOUCHSCREEN_HAMPSHIRE=y
# CONFIG_TOUCHSCREEN_EETI is not set
CONFIG_TOUCHSCREEN_EGALAX=y
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=y
# CONFIG_TOUCHSCREEN_EXC3000 is not set
CONFIG_TOUCHSCREEN_FUJITSU=y
CONFIG_TOUCHSCREEN_HIDEEP=y
CONFIG_TOUCHSCREEN_ILI210X=y
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
CONFIG_TOUCHSCREEN_ELAN=y
CONFIG_TOUCHSCREEN_ELO=y
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
CONFIG_TOUCHSCREEN_MAX11801=y
CONFIG_TOUCHSCREEN_MCS5000=y
CONFIG_TOUCHSCREEN_MMS114=y
CONFIG_TOUCHSCREEN_MELFAS_MIP4=y
CONFIG_TOUCHSCREEN_MTOUCH=y
CONFIG_TOUCHSCREEN_INEXIO=y
CONFIG_TOUCHSCREEN_MK712=y
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
CONFIG_TOUCHSCREEN_EDT_FT5X06=y
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
CONFIG_TOUCHSCREEN_TOUCHWIN=y
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=y
# CONFIG_TOUCHSCREEN_PIXCIR is not set
CONFIG_TOUCHSCREEN_WDT87XX_I2C=y
# CONFIG_TOUCHSCREEN_WM831X is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_TOUCHIT213=y
CONFIG_TOUCHSCREEN_TSC_SERIO=y
CONFIG_TOUCHSCREEN_TSC200X_CORE=y
CONFIG_TOUCHSCREEN_TSC2004=y
CONFIG_TOUCHSCREEN_TSC2007=y
CONFIG_TOUCHSCREEN_SILEAD=y
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
CONFIG_TOUCHSCREEN_SX8654=y
CONFIG_TOUCHSCREEN_TPS6507X=y
CONFIG_TOUCHSCREEN_ZET6223=y
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
CONFIG_TOUCHSCREEN_IQS5XX=y
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
CONFIG_RMI4_I2C=y
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_USERIO is not set
CONFIG_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_ROCKETPORT=y
# CONFIG_CYCLADES is not set
CONFIG_MOXA_INTELLIO=y
CONFIG_MOXA_SMARTIO=y
CONFIG_SYNCLINK=y
CONFIG_SYNCLINKMP=y
CONFIG_SYNCLINK_GT=y
CONFIG_NOZOMI=y
CONFIG_ISI=y
CONFIG_N_HDLC=y
# CONFIG_N_GSM is not set
CONFIG_TRACE_ROUTER=y
CONFIG_TRACE_SINK=y
CONFIG_NULL_TTY=y
CONFIG_GOLDFISH_TTY=y
CONFIG_GOLDFISH_TTY_EARLY_CONSOLE=y
CONFIG_LDISC_AUTOLOAD=y
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_MEN_MCB=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_ASPEED_VUART=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
# CONFIG_SERIAL_8250_LPSS is not set
# CONFIG_SERIAL_8250_MID is not set
CONFIG_SERIAL_8250_MOXA=y
CONFIG_SERIAL_OF_PLATFORM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
CONFIG_SERIAL_UARTLITE_CONSOLE=y
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SIFIVE=y
# CONFIG_SERIAL_SIFIVE_CONSOLE is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
CONFIG_SERIAL_FSL_LPUART=y
# CONFIG_SERIAL_FSL_LPUART_CONSOLE is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# end of Serial drivers

# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
# CONFIG_HVC_XEN is not set
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=y
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_APPLICOM=y
CONFIG_MWAVE=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
# CONFIG_HANGCHECK_TIMER is not set
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_I2C_ATMEL=y
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_XEN is not set
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
# CONFIG_TCG_TIS_ST33ZP24_I2C is not set
CONFIG_TELCLOCK=y
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
CONFIG_XILLYBUS_PCIE=y
CONFIG_XILLYBUS_OF=y
# end of Character devices

CONFIG_RANDOM_TRUST_CPU=y

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPMUX=y
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=y
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

# CONFIG_I2C_HELPER_AUTO is not set
CONFIG_I2C_SMBUS=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCF=y
CONFIG_I2C_ALGOPCA=y
# end of I2C Algorithms

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=y
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
CONFIG_I2C_VIA=y
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_DESIGNWARE_CORE=y
CONFIG_I2C_DESIGNWARE_PLATFORM=y
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_KEMPLD=y
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_PARPORT=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
# end of I2C Hardware Bus support

CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
CONFIG_SPMI=y
CONFIG_HSI=y
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=y
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=y
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
# CONFIG_W1_SLAVE_SMEM is not set
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
# CONFIG_W1_SLAVE_DS2805 is not set
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2780=y
# CONFIG_W1_SLAVE_DS2781 is not set
# CONFIG_W1_SLAVE_DS28E04 is not set
# CONFIG_W1_SLAVE_DS28E17 is not set
# end of 1-wire Slaves

# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_RESET_SYSCON=y
# CONFIG_POWER_RESET_SYSCON_POWEROFF is not set
CONFIG_REBOOT_MODE=y
CONFIG_SYSCON_REBOOT_MODE=y
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_MAX8925_POWER is not set
CONFIG_WM831X_BACKUP=y
CONFIG_WM831X_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_ACT8945A=y
# CONFIG_BATTERY_DS2760 is not set
CONFIG_BATTERY_DS2780=y
# CONFIG_BATTERY_DS2781 is not set
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
CONFIG_BATTERY_BQ27XXX=y
CONFIG_BATTERY_BQ27XXX_I2C=y
# CONFIG_BATTERY_BQ27XXX_HDQ is not set
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9150=y
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_88PM860X=y
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_MAX77650=y
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_SMB347=y
# CONFIG_CHARGER_TPS65217 is not set
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
CONFIG_BATTERY_GOLDFISH=y
# CONFIG_CHARGER_CROS_USBPD is not set
# CONFIG_CHARGER_UCS1002 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
CONFIG_SENSORS_AD7414=y
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_ADM1025 is not set
CONFIG_SENSORS_ADM1026=y
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7410=y
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=y
# CONFIG_SENSORS_ADT7470 is not set
CONFIG_SENSORS_ADT7475=y
CONFIG_SENSORS_ASC7621=y
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
CONFIG_SENSORS_APPLESMC=y
CONFIG_SENSORS_ASB100=y
CONFIG_SENSORS_ASPEED=y
# CONFIG_SENSORS_ATXP1 is not set
CONFIG_SENSORS_DS620=y
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_I5K_AMB is not set
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_FSCHMD is not set
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=y
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=y
CONFIG_SENSORS_LINEAGE=y
# CONFIG_SENSORS_LOCHNAGAR is not set
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=y
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
CONFIG_SENSORS_MAX1668=y
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
CONFIG_SENSORS_MAX6650=y
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
# CONFIG_SENSORS_MLXREG_FAN is not set
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_MENF21BMC_HWMON=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM77 is not set
CONFIG_SENSORS_LM78=y
CONFIG_SENSORS_LM80=y
# CONFIG_SENSORS_LM83 is not set
CONFIG_SENSORS_LM85=y
# CONFIG_SENSORS_LM87 is not set
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
# CONFIG_SENSORS_LM93 is not set
CONFIG_SENSORS_LM95234=y
CONFIG_SENSORS_LM95241=y
CONFIG_SENSORS_LM95245=y
CONFIG_SENSORS_PC87360=y
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775=y
CONFIG_SENSORS_NCT7802=y
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=y
CONFIG_SENSORS_PCF8591=y
CONFIG_PMBUS=y
CONFIG_SENSORS_PMBUS=y
CONFIG_SENSORS_ADM1275=y
CONFIG_SENSORS_IBM_CFFPS=y
CONFIG_SENSORS_IR35221=y
# CONFIG_SENSORS_IR38064 is not set
CONFIG_SENSORS_ISL68137=y
CONFIG_SENSORS_LM25066=y
# CONFIG_SENSORS_LTC2978 is not set
CONFIG_SENSORS_LTC3815=y
# CONFIG_SENSORS_MAX16064 is not set
CONFIG_SENSORS_MAX20751=y
CONFIG_SENSORS_MAX31785=y
CONFIG_SENSORS_MAX34440=y
# CONFIG_SENSORS_MAX8688 is not set
# CONFIG_SENSORS_TPS40422 is not set
CONFIG_SENSORS_TPS53679=y
# CONFIG_SENSORS_UCD9000 is not set
CONFIG_SENSORS_UCD9200=y
CONFIG_SENSORS_ZL6100=y
CONFIG_SENSORS_PWM_FAN=y
CONFIG_SENSORS_SHT21=y
CONFIG_SENSORS_SHT3x=y
CONFIG_SENSORS_SHTC1=y
CONFIG_SENSORS_SIS5595=y
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
CONFIG_SENSORS_SMSC47M1=y
CONFIG_SENSORS_SMSC47M192=y
CONFIG_SENSORS_SMSC47B397=y
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
CONFIG_SENSORS_TMP401=y
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
CONFIG_SENSORS_W83781D=y
CONFIG_SENSORS_W83791D=y
CONFIG_SENSORS_W83792D=y
CONFIG_SENSORS_W83793=y
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
CONFIG_SENSORS_W83627HF=y
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_WM831X=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_OF=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR=y
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CPU_THERMAL is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set
# CONFIG_THERMAL_MMIO is not set
# CONFIG_QORIQ_THERMAL is not set
# CONFIG_DA9062_THERMAL is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_PKG_TEMP_THERMAL=y
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
# end of Intel thermal drivers

# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
# CONFIG_SSB_SDIOHOST is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
# CONFIG_BCMA_DRIVER_PCI is not set
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_ATMEL_FLEXCOM is not set
CONFIG_MFD_ATMEL_HLCDC=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_CHARDEV=y
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_HI6421_PMIC=y
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_88PM860X=y
CONFIG_MFD_MAX14577=y
# CONFIG_MFD_MAX77620 is not set
CONFIG_MFD_MAX77650=y
# CONFIG_MFD_MAX77686 is not set
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
CONFIG_MFD_MENF21BMC=y
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=y
CONFIG_PCF50633_ADC=y
CONFIG_PCF50633_GPIO=y
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_RC5T583=y
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=y
CONFIG_MFD_SEC_CORE=y
CONFIG_MFD_SI476X_CORE=y
# CONFIG_MFD_SM501 is not set
CONFIG_MFD_SKY81452=y
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=y
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
# CONFIG_MFD_PALMAS is not set
CONFIG_TPS6105X=y
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TPS65217=y
# CONFIG_MFD_TPS68470 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TI_LP87565=y
CONFIG_MFD_TPS65218=y
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65912=y
CONFIG_MFD_TPS65912_I2C=y
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
CONFIG_MFD_TQMX86=y
CONFIG_MFD_VX855=y
CONFIG_MFD_LOCHNAGAR=y
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_WM8400 is not set
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
# CONFIG_MFD_WM8350_I2C is not set
CONFIG_MFD_WM8994=y
CONFIG_MFD_ROHM_BD718XX=y
CONFIG_MFD_STPMIC1=y
CONFIG_MFD_STMFX=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
CONFIG_REGULATOR_DEBUG=y
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_88PG86X is not set
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_88PM8607=y
CONFIG_REGULATOR_ACT8865=y
# CONFIG_REGULATOR_ACT8945A is not set
# CONFIG_REGULATOR_AD5398 is not set
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_BD718XX=y
CONFIG_REGULATOR_DA9062=y
CONFIG_REGULATOR_DA9210=y
CONFIG_REGULATOR_DA9211=y
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_HI6421=y
CONFIG_REGULATOR_HI6421V530=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=y
CONFIG_REGULATOR_LOCHNAGAR=y
# CONFIG_REGULATOR_LP3971 is not set
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP873X=y
CONFIG_REGULATOR_LP8755=y
CONFIG_REGULATOR_LP87565=y
CONFIG_REGULATOR_LTC3589=y
CONFIG_REGULATOR_LTC3676=y
CONFIG_REGULATOR_MAX14577=y
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77650=y
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
# CONFIG_REGULATOR_MAX8907 is not set
# CONFIG_REGULATOR_MAX8925 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX8973=y
# CONFIG_REGULATOR_MAX8997 is not set
# CONFIG_REGULATOR_MAX77693 is not set
CONFIG_REGULATOR_MCP16502=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_PCF50633=y
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
CONFIG_REGULATOR_PV88080=y
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
# CONFIG_REGULATOR_QCOM_SPMI is not set
CONFIG_REGULATOR_RC5T583=y
# CONFIG_REGULATOR_RK808 is not set
# CONFIG_REGULATOR_RN5T618 is not set
CONFIG_REGULATOR_S2MPA01=y
# CONFIG_REGULATOR_S2MPS11 is not set
CONFIG_REGULATOR_S5M8767=y
CONFIG_REGULATOR_SKY81452=y
CONFIG_REGULATOR_STPMIC1=y
CONFIG_REGULATOR_SY8106A=y
CONFIG_REGULATOR_TPS51632=y
CONFIG_REGULATOR_TPS6105X=y
# CONFIG_REGULATOR_TPS62360 is not set
CONFIG_REGULATOR_TPS65023=y
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
CONFIG_REGULATOR_TPS65217=y
# CONFIG_REGULATOR_TPS65218 is not set
CONFIG_REGULATOR_TPS6586X=y
CONFIG_REGULATOR_TPS65912=y
CONFIG_REGULATOR_VCTRL=y
# CONFIG_REGULATOR_WM831X is not set
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y
CONFIG_RC_CORE=y
CONFIG_RC_MAP=y
# CONFIG_LIRC is not set
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=y
CONFIG_IR_RC5_DECODER=y
CONFIG_IR_RC6_DECODER=y
CONFIG_IR_JVC_DECODER=y
# CONFIG_IR_SONY_DECODER is not set
# CONFIG_IR_SANYO_DECODER is not set
# CONFIG_IR_SHARP_DECODER is not set
# CONFIG_IR_MCE_KBD_DECODER is not set
CONFIG_IR_XMP_DECODER=y
CONFIG_IR_IMON_DECODER=y
CONFIG_IR_RCMM_DECODER=y
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=y
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=y
CONFIG_IR_IMON=y
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=y
# CONFIG_IR_ITE_CIR is not set
# CONFIG_IR_FINTEK is not set
# CONFIG_IR_NUVOTON is not set
CONFIG_IR_REDRAT3=y
CONFIG_IR_STREAMZAP=y
# CONFIG_IR_WINBOND_CIR is not set
CONFIG_IR_IGORPLUGUSB=y
CONFIG_IR_IGUANA=y
CONFIG_IR_TTUSBIR=y
# CONFIG_RC_LOOPBACK is not set
CONFIG_IR_SERIAL=y
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=y
CONFIG_RC_XBOX_DVD=y
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
# CONFIG_AGP_INTEL is not set
CONFIG_AGP_SIS=y
# CONFIG_AGP_VIA is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
# CONFIG_DRM_DP_AUX_CHARDEV is not set
CONFIG_DRM_DEBUG_MM=y
CONFIG_DRM_DEBUG_SELFTEST=y
CONFIG_DRM_KMS_HELPER=y
# CONFIG_DRM_FBDEV_EMULATION is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=y
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# CONFIG_DRM_KOMEDA is not set
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_ALPHA_SUPPORT=y
# CONFIG_DRM_I915_CAPTURE_ERROR is not set
# CONFIG_DRM_I915_USERPTR is not set
# CONFIG_DRM_I915_GVT is not set
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
CONFIG_DRM_VMWGFX=y
# CONFIG_DRM_VMWGFX_FBCON is not set
# CONFIG_DRM_GMA500 is not set
# CONFIG_DRM_UDL is not set
CONFIG_DRM_AST=y
CONFIG_DRM_MGAG200=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_RCAR_DW_HDMI=y
CONFIG_DRM_RCAR_LVDS=y
CONFIG_DRM_QXL=y
# CONFIG_DRM_BOCHS is not set
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_ARM_VERSATILE is not set
CONFIG_DRM_PANEL_LVDS=y
# CONFIG_DRM_PANEL_SIMPLE is not set
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=y
CONFIG_DRM_PANEL_ILITEK_ILI9881C=y
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=y
CONFIG_DRM_PANEL_JDI_LT070ME05000=y
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=y
# CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=y
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=y
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
# CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=y
CONFIG_DRM_PANEL_RONBO_RB070D30=y
# CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=y
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=y
# CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=y
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=y
# CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
# CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
CONFIG_DRM_CDNS_DSI=y
# CONFIG_DRM_DUMB_VGA_DAC is not set
# CONFIG_DRM_LVDS_ENCODER is not set
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=y
CONFIG_DRM_NXP_PTN3460=y
# CONFIG_DRM_PARADE_PS8622 is not set
CONFIG_DRM_SIL_SII8620=y
# CONFIG_DRM_SII902X is not set
CONFIG_DRM_SII9234=y
CONFIG_DRM_THINE_THC63LVD1024=y
CONFIG_DRM_TOSHIBA_TC358764=y
CONFIG_DRM_TOSHIBA_TC358767=y
CONFIG_DRM_TI_TFP410=y
# CONFIG_DRM_TI_SN65DSI86 is not set
CONFIG_DRM_I2C_ADV7511=y
CONFIG_DRM_I2C_ADV7533=y
CONFIG_DRM_I2C_ADV7511_CEC=y
CONFIG_DRM_DW_HDMI=y
# CONFIG_DRM_DW_HDMI_CEC is not set
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_ARCPGU=y
CONFIG_DRM_HISI_HIBMC=y
# CONFIG_DRM_MXSFB is not set
CONFIG_DRM_TINYDRM=y
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_DDC=y
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
# CONFIG_FB_BIG_ENDIAN is not set
# CONFIG_FB_LITTLE_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_SVGALIB=y
CONFIG_FB_BACKLIGHT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
CONFIG_FB_CIRRUS=y
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
CONFIG_FB_ARC=y
CONFIG_FB_ASILIANT=y
CONFIG_FB_IMSTT=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
# CONFIG_FB_HGA is not set
CONFIG_FB_OPENCORES=y
CONFIG_FB_S1D13XXX=y
CONFIG_FB_NVIDIA=y
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_NVIDIA_DEBUG=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA=y
CONFIG_FB_RIVA_I2C=y
CONFIG_FB_RIVA_DEBUG=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_I740=y
CONFIG_FB_LE80578=y
CONFIG_FB_CARILLO_RANCH=y
# CONFIG_FB_MATROX is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_RADEON_I2C is not set
# CONFIG_FB_RADEON_BACKLIGHT is not set
CONFIG_FB_RADEON_DEBUG=y
CONFIG_FB_ATY128=y
CONFIG_FB_ATY128_BACKLIGHT=y
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
CONFIG_FB_SAVAGE=y
# CONFIG_FB_SAVAGE_I2C is not set
CONFIG_FB_SAVAGE_ACCEL=y
CONFIG_FB_SIS=y
CONFIG_FB_SIS_300=y
CONFIG_FB_SIS_315=y
CONFIG_FB_NEOMAGIC=y
CONFIG_FB_KYRO=y
# CONFIG_FB_3DFX is not set
CONFIG_FB_VOODOO1=y
# CONFIG_FB_VT8623 is not set
CONFIG_FB_TRIDENT=y
CONFIG_FB_ARK=y
# CONFIG_FB_PM3 is not set
CONFIG_FB_CARMINE=y
# CONFIG_FB_CARMINE_DRAM_EVAL is not set
CONFIG_CARMINE_DRAM_CUSTOM=y
CONFIG_FB_SMSCUFX=y
# CONFIG_FB_UDL is not set
CONFIG_FB_IBM_GXT4500=y
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=y
CONFIG_XEN_FBDEV_FRONTEND=y
CONFIG_FB_METRONOME=y
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SM712=y
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_CARILLO_RANCH=y
# CONFIG_BACKLIGHT_PWM is not set
# CONFIG_BACKLIGHT_MAX8925 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=y
# CONFIG_BACKLIGHT_SAHARA is not set
CONFIG_BACKLIGHT_WM831X=y
# CONFIG_BACKLIGHT_ADP5520 is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
# CONFIG_BACKLIGHT_LP855X is not set
CONFIG_BACKLIGHT_SKY81452=y
CONFIG_BACKLIGHT_TPS65217=y
CONFIG_BACKLIGHT_LV5207LP=y
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_VGASTATE=y
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=y
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACCUTOUCH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
CONFIG_HID_ASUS=y
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
CONFIG_HID_BETOP_FF=y
CONFIG_HID_BIGBEN_FF=y
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
CONFIG_HID_CORSAIR=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=y
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=y
CONFIG_HOLTEK_FF=y
CONFIG_HID_GOOGLE_HAMMER=y
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_UCLOGIC=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
CONFIG_HID_GYRATION=y
CONFIG_HID_ICADE=y
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=y
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_LOGITECH is not set
CONFIG_HID_MAGICMOUSE=y
CONFIG_HID_MALTRON=y
CONFIG_HID_MAYFLASH=y
CONFIG_HID_REDRAGON=y
# CONFIG_HID_MICROSOFT is not set
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
CONFIG_HID_NTI=y
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=y
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PENMOUNT=y
# CONFIG_HID_PETALYNX is not set
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_RETRODE=y
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
CONFIG_HID_SPEEDLINK=y
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
# CONFIG_HID_GREENASIA is not set
CONFIG_HID_SMARTJOYPLUS=y
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=y
CONFIG_HID_THINGM=y
# CONFIG_HID_THRUSTMASTER is not set
CONFIG_HID_UDRAW_PS3=y
# CONFIG_HID_WACOM is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
CONFIG_HID_ZYDACRON=y
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=y
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
# CONFIG_USB_PCI is not set
# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
CONFIG_USB_OTG=y
CONFIG_USB_OTG_WHITELIST=y
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_OTG_FSM is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y
CONFIG_USB_WUSB=y
CONFIG_USB_WUSB_CBAF=y
# CONFIG_USB_WUSB_CBAF_DEBUG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PLATFORM=y
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=y
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_OHCI_HCD is not set
CONFIG_USB_U132_HCD=y
# CONFIG_USB_SL811_HCD is not set
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HWA_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=y
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_STORAGE_ALAUDA=y
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
CONFIG_USB_STORAGE_ENE_UB6250=y
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=y
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=y
CONFIG_USB_MUSB_HOST=y

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
CONFIG_USB_DWC3=y
CONFIG_USB_DWC3_ULPI=y
CONFIG_USB_DWC3_HOST=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_OF_SIMPLE=y
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=y
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_RIO500=y
# CONFIG_USB_LEGOTOWER is not set
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
CONFIG_USB_CYTHERM=y
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=y
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=y
CONFIG_TYPEC_NVIDIA_ALTMODE=y
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=y
# CONFIG_USB_ROLES_INTEL_XHCI is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
CONFIG_UWB_HWA=y
CONFIG_UWB_WHCI=y
# CONFIG_UWB_I1480U is not set
CONFIG_MMC=y
# CONFIG_PWRSEQ_EMMC is not set
# CONFIG_PWRSEQ_SD8787 is not set
# CONFIG_PWRSEQ_SIMPLE is not set
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
# CONFIG_SDIO_UART is not set
CONFIG_MMC_TEST=y

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=y
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=y
CONFIG_MMC_RICOH_MMC=y
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=y
# CONFIG_MMC_SDHCI_OF_ARASAN is not set
CONFIG_MMC_SDHCI_OF_AT91=y
CONFIG_MMC_SDHCI_OF_DWCMSHC=y
# CONFIG_MMC_SDHCI_CADENCE is not set
CONFIG_MMC_SDHCI_F_SDH30=y
CONFIG_MMC_WBSD=y
# CONFIG_MMC_ALCOR is not set
CONFIG_MMC_TIFM_SD=y
CONFIG_MMC_GOLDFISH=y
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
# CONFIG_MMC_VUB300 is not set
CONFIG_MMC_USHC=y
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_REALTEK_PCI=y
# CONFIG_MMC_REALTEK_USB is not set
CONFIG_MMC_CQHCI=y
CONFIG_MMC_TOSHIBA_PCI=y
CONFIG_MMC_MTK=y
CONFIG_MMC_SDHCI_XENON=y
CONFIG_MMC_SDHCI_OMAP=y
CONFIG_MMC_SDHCI_AM654=y
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=y
CONFIG_MS_BLOCK=y

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=y
CONFIG_MEMSTICK_JMICRON_38X=y
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_REALTEK_PCI is not set
CONFIG_MEMSTICK_REALTEK_USB=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_AN30259A=y
CONFIG_LEDS_APU=y
CONFIG_LEDS_BCM6328=y
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=y
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP55XX_COMMON=y
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
CONFIG_LEDS_LP5562=y
CONFIG_LEDS_LP8501=y
CONFIG_LEDS_LP8860=y
CONFIG_LEDS_CLEVO_MAIL=y
CONFIG_LEDS_PCA955X=y
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_PWM=y
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_ADP5520=y
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
CONFIG_LEDS_MAX77650=y
CONFIG_LEDS_MAX8997=y
CONFIG_LEDS_LM355x=y
CONFIG_LEDS_MENF21BMC=y
CONFIG_LEDS_IS31FL319X=y
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
CONFIG_LEDS_SYSCON=y
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
# CONFIG_EDAC_LEGACY_SYSFS is not set
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=y
# CONFIG_EDAC_AMD64 is not set
CONFIG_EDAC_E752X=y
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=y
# CONFIG_EDAC_I3200 is not set
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I7CORE=y
CONFIG_EDAC_I5000=y
# CONFIG_EDAC_I5100 is not set
CONFIG_EDAC_I7300=y
CONFIG_EDAC_PND2=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
# CONFIG_RTC_HCTOSYS is not set
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
# CONFIG_RTC_INTF_SYSFS is not set
CONFIG_RTC_INTF_PROC=y
# CONFIG_RTC_INTF_DEV is not set
CONFIG_RTC_DRV_TEST=y

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=y
CONFIG_RTC_DRV_88PM80X=y
CONFIG_RTC_DRV_ABB5ZES3=y
CONFIG_RTC_DRV_ABEOZ9=y
CONFIG_RTC_DRV_ABX80X=y
CONFIG_RTC_DRV_DS1307=y
CONFIG_RTC_DRV_DS1307_CENTURY=y
# CONFIG_RTC_DRV_DS1374 is not set
CONFIG_RTC_DRV_DS1672=y
CONFIG_RTC_DRV_HYM8563=y
# CONFIG_RTC_DRV_MAX6900 is not set
CONFIG_RTC_DRV_MAX8907=y
CONFIG_RTC_DRV_MAX8925=y
CONFIG_RTC_DRV_MAX8997=y
# CONFIG_RTC_DRV_RK808 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
CONFIG_RTC_DRV_ISL1208=y
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_ISL12026=y
CONFIG_RTC_DRV_X1205=y
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF85063=y
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=y
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_TPS6586X=y
# CONFIG_RTC_DRV_RC5T583 is not set
CONFIG_RTC_DRV_S35390A=y
# CONFIG_RTC_DRV_FM3130 is not set
CONFIG_RTC_DRV_RX8010=y
# CONFIG_RTC_DRV_RX8581 is not set
CONFIG_RTC_DRV_RX8025=y
CONFIG_RTC_DRV_EM3027=y
CONFIG_RTC_DRV_RV3028=y
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_S5M is not set
CONFIG_RTC_DRV_SD3078=y

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
CONFIG_RTC_DRV_PCF2127=y
CONFIG_RTC_DRV_RV3029C2=y
# CONFIG_RTC_DRV_RV3029_HWMON is not set

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
# CONFIG_RTC_DRV_DS1286 is not set
CONFIG_RTC_DRV_DS1511=y
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=y
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
CONFIG_RTC_DRV_DS17285=y
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
# CONFIG_RTC_DRV_DS1742 is not set
CONFIG_RTC_DRV_DS2404=y
CONFIG_RTC_DRV_DA9063=y
# CONFIG_RTC_DRV_STK17TA8 is not set
CONFIG_RTC_DRV_M48T86=y
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
CONFIG_RTC_DRV_V3020=y
# CONFIG_RTC_DRV_WM831X is not set
CONFIG_RTC_DRV_PCF50633=y
CONFIG_RTC_DRV_AB3100=y
CONFIG_RTC_DRV_ZYNQMP=y
# CONFIG_RTC_DRV_CROS_EC is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=y
CONFIG_RTC_DRV_FTRTC010=y
CONFIG_RTC_DRV_SNVS=y
CONFIG_RTC_DRV_R7301=y

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_GOLDFISH is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
# CONFIG_DMADEVICES_VDEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
CONFIG_ALTERA_MSGDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_FSL_EDMA=y
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IOATDMA is not set
CONFIG_INTEL_MIC_X100_DMA=y
CONFIG_QCOM_HIDMA_MGMT=y
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=y
CONFIG_DW_DMAC_PCI=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
CONFIG_DMATEST=y
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
# CONFIG_SW_SYNC is not set
# CONFIG_UDMABUF is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
# CONFIG_KS0108 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_HT16K33=y
CONFIG_PARPORT_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=y
CONFIG_CHARLCD=y
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=y
# CONFIG_UIO_SERCOS3 is not set
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
# CONFIG_XEN_BALLOON is not set
# CONFIG_XEN_DEV_EVTCHN is not set
CONFIG_XEN_BACKEND=y
CONFIG_XENFS=y
CONFIG_XEN_COMPAT_XENFS=y
# CONFIG_XEN_SYS_HYPERVISOR is not set
CONFIG_XEN_XENBUS_FRONTEND=y
CONFIG_XEN_GNTDEV=y
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
CONFIG_XEN_PCIDEV_BACKEND=y
CONFIG_XEN_PVCALLS_FRONTEND=y
# CONFIG_XEN_PVCALLS_BACKEND is not set
CONFIG_XEN_PRIVCMD=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
# end of Xen driver support

CONFIG_STAGING=y
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
CONFIG_COMEDI_MISC_DRIVERS=y
CONFIG_COMEDI_BOND=y
CONFIG_COMEDI_TEST=y
# CONFIG_COMEDI_PARPORT is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_USB_DRIVERS=y
# CONFIG_COMEDI_DT9812 is not set
CONFIG_COMEDI_NI_USB6501=y
# CONFIG_COMEDI_USBDUX is not set
# CONFIG_COMEDI_USBDUXFAST is not set
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_RTS5208=y
CONFIG_FB_SM750=y

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ANDROID_VSOC=y
# CONFIG_ION is not set
# end of Android

# CONFIG_STAGING_BOARD is not set
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_GOLDFISH_AUDIO=y
# CONFIG_GS_FPGABOOT is not set
CONFIG_UNISYSSPAR=y
CONFIG_COMMON_CLK_XLNX_CLKWZRD=y
CONFIG_GREYBUS=y
CONFIG_GREYBUS_ES2=y
CONFIG_GREYBUS_BOOTROM=y
# CONFIG_GREYBUS_HID is not set
# CONFIG_GREYBUS_LIGHT is not set
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
CONFIG_GREYBUS_POWER=y
CONFIG_GREYBUS_RAW=y
CONFIG_GREYBUS_VIBRATOR=y
# CONFIG_GREYBUS_BRIDGED_PHY is not set

#
# Gasket devices
#
CONFIG_STAGING_GASKET_FRAMEWORK=y
CONFIG_STAGING_APEX_DRIVER=y
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=y
# CONFIG_EROFS_FS is not set
CONFIG_FIELDBUS_DEV=y
CONFIG_HMS_ANYBUSS_BUS=y
# CONFIG_HMS_PROFINET is not set
CONFIG_KPC2000=y
CONFIG_KPC2000_CORE=y
CONFIG_KPC2000_I2C=y
CONFIG_KPC2000_DMA=y
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=y
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
CONFIG_CROS_EC_I2C=y
# CONFIG_CROS_EC_RPMSG is not set
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
CONFIG_CROS_EC_LIGHTBAR=y
# CONFIG_CROS_EC_VBC is not set
# CONFIG_CROS_EC_DEBUGFS is not set
# CONFIG_CROS_EC_SYSFS is not set
CONFIG_MELLANOX_PLATFORM=y
CONFIG_MLXREG_HOTPLUG=y
CONFIG_MLXREG_IO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
CONFIG_COMMON_CLK_MAX9485=y
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
CONFIG_COMMON_CLK_SI514=y
CONFIG_COMMON_CLK_SI544=y
CONFIG_COMMON_CLK_SI570=y
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_CDCE925=y
CONFIG_COMMON_CLK_CS2000_CP=y
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_COMMON_CLK_LOCHNAGAR is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_VC5 is not set
CONFIG_COMMON_CLK_BD718XX=y
CONFIG_COMMON_CLK_FIXED_MMIO=y
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PLATFORM_MHU=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=y
# CONFIG_MAILBOX_TEST is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_AMD_IOMMU is not set
# CONFIG_INTEL_IOMMU is not set
# CONFIG_IRQ_REMAP is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_QCOM_GLINK_NATIVE=y
CONFIG_RPMSG_QCOM_GLINK_RPM=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# IXP4xx SoC drivers
#
# CONFIG_IXP4XX_QMGR is not set
# CONFIG_IXP4XX_NPE is not set
# end of IXP4xx SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_MAX14577 is not set
CONFIG_EXTCON_MAX77693=y
CONFIG_EXTCON_MAX77843=y
CONFIG_EXTCON_MAX8997=y
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
CONFIG_EXTCON_USBC_CROS_EC=y
CONFIG_MEMORY=y
# CONFIG_IIO is not set
CONFIG_NTB=y
# CONFIG_NTB_AMD is not set
CONFIG_NTB_IDT=y
# CONFIG_NTB_INTEL is not set
CONFIG_NTB_SWITCHTEC=y
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
CONFIG_NTB_TRANSPORT=y
CONFIG_VME_BUS=y

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=y
CONFIG_VME_TSI148=y
CONFIG_VME_FAKE=y

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=y

#
# VME Device Drivers
#
CONFIG_VME_USER=y
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
CONFIG_PWM_ATMEL_HLCDC_PWM=y
CONFIG_PWM_CROS_EC=y
CONFIG_PWM_FSL_FTM=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# end of IRQ chip support

CONFIG_IPACK_BUS=y
CONFIG_BOARD_TPCI200=y
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=y
CONFIG_FMC=y
# CONFIG_FMC_FAKEDEV is not set
CONFIG_FMC_TRIVIAL=y
CONFIG_FMC_WRITE_EEPROM=y
CONFIG_FMC_CHARDEV=y

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_GENERIC_PHY_MIPI_DPHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_CADENCE_DP=y
CONFIG_PHY_CADENCE_DPHY=y
# CONFIG_PHY_CADENCE_SIERRA is not set
CONFIG_PHY_FSL_IMX8MQ_USB=y
CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_OCELOT_SERDES=y
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_TUSB1210=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=y
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=y

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_THUNDERBOLT is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
CONFIG_ANDROID_BINDERFS=y
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
CONFIG_ANDROID_BINDER_IPC_SELFTEST=y
# end of Android

CONFIG_LIBNVDIMM=y
# CONFIG_BLK_DEV_PMEM is not set
# CONFIG_ND_BLK is not set
CONFIG_ND_CLAIM=y
CONFIG_BTT=y
CONFIG_OF_PMEM=y
CONFIG_NVDIMM_KEYS=y
# CONFIG_DAX is not set
CONFIG_NVMEM=y
# CONFIG_NVMEM_SYSFS is not set

#
# HW tracing support
#
# CONFIG_STM is not set
CONFIG_INTEL_TH=y
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=y
CONFIG_INTEL_TH_PTI=y
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=y
CONFIG_ALTERA_PR_IP_CORE=y
CONFIG_ALTERA_PR_IP_CORE_PLAT=y
CONFIG_FPGA_MGR_ALTERA_CVP=y
CONFIG_FPGA_BRIDGE=y
CONFIG_ALTERA_FREEZE_BRIDGE=y
CONFIG_XILINX_PR_DECOUPLER=y
CONFIG_FPGA_REGION=y
# CONFIG_OF_FPGA_REGION is not set
CONFIG_FPGA_DFL=y
CONFIG_FPGA_DFL_FME=y
CONFIG_FPGA_DFL_FME_MGR=y
CONFIG_FPGA_DFL_FME_BRIDGE=y
CONFIG_FPGA_DFL_FME_REGION=y
CONFIG_FPGA_DFL_AFU=y
# CONFIG_FPGA_DFL_PCI is not set
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=y

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=y
CONFIG_MUX_MMIO=y
# end of Multiplexer drivers

CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
# CONFIG_SLIM_QCOM_CTRL is not set
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=y
CONFIG_FTM_QUADDEC=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
CONFIG_EXT4_FS_SECURITY=y
CONFIG_EXT4_DEBUG=y
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
# CONFIG_REISERFS_FS_SECURITY is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_WARN=y
# CONFIG_XFS_DEBUG is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
CONFIG_NILFS2_FS=y
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
# CONFIG_PRINT_QUOTA_WARNING is not set
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
# CONFIG_FUSE_FS is not set
CONFIG_OVERLAY_FS=y
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
CONFIG_OVERLAY_FS_INDEX=y
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
CONFIG_OVERLAY_FS_METACOPY=y

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
CONFIG_NTFS_FS=y
CONFIG_NTFS_DEBUG=y
CONFIG_NTFS_RW=y
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
CONFIG_PROC_VMCORE_DEVICE_DUMP=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
# CONFIG_CONFIGFS_FS is not set
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NFS_SWAP=y
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V3_ACL is not set
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
CONFIG_NFSD_BLOCKLAYOUT=y
# CONFIG_NFSD_SCSILAYOUT is not set
CONFIG_NFSD_FLEXFILELAYOUT=y
CONFIG_NFSD_V4_SECURITY_LABEL=y
# CONFIG_NFSD_FAULT_INJECTION is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_SWAP=y
CONFIG_RPCSEC_GSS_KRB5=y
# CONFIG_CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=y
CONFIG_CEPH_FS_POSIX_ACL=y
CONFIG_CIFS=y
CONFIG_CIFS_STATS2=y
# CONFIG_CIFS_ALLOW_INSECURE_LEGACY is not set
# CONFIG_CIFS_UPCALL is not set
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_ACL=y
# CONFIG_CIFS_DEBUG is not set
# CONFIG_CIFS_DFS_UPCALL is not set
CONFIG_CODA_FS=y
CONFIG_AFS_FS=y
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_DEBUG_CURSOR=y
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=y
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
CONFIG_NLS_ISO8859_7=y
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=y
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
CONFIG_NLS_MAC_GAELIC=y
# CONFIG_NLS_MAC_GREEK is not set
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
# CONFIG_NLS_UTF8 is not set
CONFIG_UNICODE=y
CONFIG_UNICODE_NORMALIZATION_SELFTEST=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
# CONFIG_TRUSTED_KEYS is not set
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
# CONFIG_SECURITY_NETWORK_XFRM is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SMACK=y
CONFIG_SECURITY_SMACK_BRINGUP=y
# CONFIG_SECURITY_SMACK_NETFILTER is not set
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=y
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
CONFIG_SECURITY_SAFESETID=y
# CONFIG_INTEGRITY is not set
# CONFIG_DEFAULT_SECURITY_SMACK is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
CONFIG_GCC_PLUGIN_STACKLEAK=y
CONFIG_STACKLEAK_TRACK_MIN_SIZE=100
CONFIG_STACKLEAK_METRICS=y
CONFIG_STACKLEAK_RUNTIME_DISABLE=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=y
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_GLUE_HELPER_X86=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128L is not set
CONFIG_CRYPTO_AEGIS256=y
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS128L_AESNI_SSE2=y
CONFIG_CRYPTO_AEGIS256_AESNI_SSE2=y
CONFIG_CRYPTO_MORUS640=y
# CONFIG_CRYPTO_MORUS640_SSE2 is not set
CONFIG_CRYPTO_MORUS1280=y
CONFIG_CRYPTO_MORUS1280_GLUE=y
CONFIG_CRYPTO_MORUS1280_SSE2=y
CONFIG_CRYPTO_MORUS1280_AVX2=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=y
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=y
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_RMD256=y
CONFIG_CRYPTO_RMD320=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=y
CONFIG_CRYPTO_WP512=y
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_AES_TI=y
CONFIG_CRYPTO_AES_X86_64=y
CONFIG_CRYPTO_AES_NI_INTEL=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=y
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=y
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=y
CONFIG_CRYPTO_SEED=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TEA=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
CONFIG_CRYPTO_USER_API_AEAD=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
# CONFIG_CRYPTO_DEV_CCP is not set
CONFIG_CRYPTO_DEV_QAT=y
CONFIG_CRYPTO_DEV_QAT_DH895xCC=y
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=y
CONFIG_CRYPTO_DEV_QAT_C62XVF=y
CONFIG_CRYPTO_DEV_NITROX=y
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=y
# CONFIG_CRYPTO_DEV_CHELSIO is not set
# CONFIG_CRYPTO_DEV_CHELSIO_TLS is not set
CONFIG_CRYPTO_DEV_VIRTIO=y
CONFIG_CRYPTO_DEV_CCREE=y
CONFIG_ASYMMETRIC_KEY_TYPE=y
# CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not set

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
CONFIG_CRC32_SARWATE=y
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=y
CONFIG_CRC4=y
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_RANDOM32_SELFTEST=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=y
CONFIG_TEXTSEARCH_BM=y
CONFIG_TEXTSEARCH_FSM=y
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
CONFIG_GLOB_SELFTEST=y
CONFIG_NLATTR=y
CONFIG_LRU_CACHE=y
CONFIG_CLZ_TAB=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_LIBFDT=y
CONFIG_OID_REGISTRY=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=y
CONFIG_FONT_6x11=y
CONFIG_FONT_7x14=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
CONFIG_FONT_6x10=y
CONFIG_FONT_10x18=y
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_SECTION_MISMATCH_WARN_ONLY is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_OWNER=y
CONFIG_PAGE_POISONING=y
CONFIG_PAGE_POISONING_NO_SANITY=y
# CONFIG_PAGE_POISONING_ZERO is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_DEBUG_OBJECTS=y
CONFIG_DEBUG_OBJECTS_SELFTEST=y
# CONFIG_DEBUG_OBJECTS_FREE is not set
CONFIG_DEBUG_OBJECTS_TIMERS=y
# CONFIG_DEBUG_OBJECTS_WORK is not set
CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=y
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
CONFIG_WQ_WATCHDOG=y
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
CONFIG_SCHED_STACK_END_CHECK=y
CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
CONFIG_LOCK_TORTURE_TEST=y
CONFIG_WW_MUTEX_SELFTEST=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
CONFIG_DEBUG_SG=y
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=y
CONFIG_RCU_PERF_TEST=y
CONFIG_RCU_TORTURE_TEST=y
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=y
CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT=y
CONFIG_NETDEV_NOTIFIER_ERROR_INJECT=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
# CONFIG_FAIL_MAKE_REQUEST is not set
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
CONFIG_FAIL_MMC_REQUEST=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
CONFIG_MMIOTRACE=y
# CONFIG_HIST_TRIGGERS is not set
CONFIG_TRACEPOINT_BENCHMARK=y
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
CONFIG_TEST_BITMAP=y
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=y
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_STACKINIT=y
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_SANITIZE_ALL is not set
CONFIG_UBSAN_NO_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
CONFIG_DEBUG_TLBFLUSH=y
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
CONFIG_DEFAULT_IO_DELAY_TYPE=3
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
CONFIG_DEBUG_NMI_SELFTEST=y
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of Kernel hacking

--=_5d055b54.q/3E1fY/IpzZAwn+Flm4zlzfDRdKl5nD54MhO6wyh+xwtWeZ--
