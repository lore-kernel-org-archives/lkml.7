Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D2C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5F62073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfLJQmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:42:40 -0500
Received: from ale.deltatee.com ([207.54.116.67]:36668 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbfLJQm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:42:26 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ieiad-0005DL-0G; Tue, 10 Dec 2019 09:42:24 -0700
To:     Jens Axboe <axboe@kernel.dk>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191208154020.GK32275@shao2-debian>
 <ee156e51-bede-9c58-b48b-31aac65976ea@kernel.dk>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <03060cee-4820-6706-03e4-11d5ccf3363f@deltatee.com>
Date:   Tue, 10 Dec 2019 09:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ee156e51-bede-9c58-b48b-31aac65976ea@kernel.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lkp@lists.01.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de, rong.a.chen@intel.com, axboe@kernel.dk
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [block] 48d9b0d431: BUG:kernel_NULL_pointer_dereference,address
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-12-09 10:06 p.m., Jens Axboe wrote:
> Logan,
> 
> Are you looking into this one?

Yes, I have a patch I'll send out shortly.

Logan

> 
> On 12/8/19 8:40 AM, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 48d9b0d43105e0da2b7c135eedd24e51234fb5e4 ("block: account statistics for passthrough requests")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> in testcase: rcuperf
>> with following parameters:
>>
>> 	runtime: 300s
>> 	perf_type: tasks
>>
>>
>>
>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +-------------------------------------------------------+------------+------------+
>> |                                                       | 8148f0b564 | 48d9b0d431 |
>> +-------------------------------------------------------+------------+------------+
>> | boot_successes                                        | 8          | 0          |
>> | boot_failures                                         | 0          | 8          |
>> | BUG:kernel_NULL_pointer_dereference,address           | 0          | 8          |
>> | Oops:#[##]                                            | 0          | 8          |
>> | EIP:blk_account_io_completion                         | 0          | 8          |
>> | EIP:ide_output_data                                   | 0          | 8          |
>> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 8          |
>> +-------------------------------------------------------+------------+------------+
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>>
>> [   14.392111] BUG: kernel NULL pointer dereference, address: 000002ac
>> [   14.392607] #PF: supervisor write access in kernel mode
>> [   14.392607] #PF: error_code(0x0002) - not-present page
>> [   14.392607] *pde = 00000000 
>> [   14.392607] Oops: 0002 [#1]
>> [   14.392607] CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted 5.4.0-rc2-00011-g48d9b0d43105e #1
>> [   14.392607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [   14.392607] Workqueue: kblockd drive_rq_insert_work
>> [   14.392607] EIP: blk_account_io_completion+0x7a/0xf0
>> [   14.392607] Code: 89 54 24 08 31 d2 89 4c 24 04 31 c9 c7 04 24 02 00 00 00 c1 ee 09 e8 f5 21 a6 ff e8 70 5c a7 ff 8b 53 60 8d 04 bd 00 00 00 00 <01> b4 02 ac 02 00 00 8b 9a 88 02 00 00 85 db 74 11 85 d2 74 51 8b
>> [   14.392607] EAX: 00000000 EBX: f5b80000 ECX: 00000000 EDX: 00000000
>> [   14.392607] ESI: 00000000 EDI: 00000000 EBP: f3031e70 ESP: f3031e54
>> [   14.392607] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010046
>> [   14.392607] CR0: 80050033 CR2: 000002ac CR3: 03c25000 CR4: 000406d0
>> [   14.392607] Call Trace:
>> [   14.392607]  <IRQ>
>> [   14.392607]  ? blk_account_io_completion+0x38/0xf0
>> [   14.392607]  blk_update_request+0x85/0x420
>> [   14.392607]  ? _raw_spin_unlock_irqrestore+0x4f/0x60
>> [   14.392607]  ? trace_hardirqs_off+0xca/0xe0
>> [   14.392607]  ? _raw_spin_unlock_irqrestore+0x4f/0x60
>> [   14.392607]  ? complete+0x41/0x50
>> [   14.392607]  ide_end_rq+0x38/0xa0
>> [   14.392607]  ide_complete_rq+0x3d/0x70
>> [   14.392607]  cdrom_newpc_intr+0x258/0xba0
>> [   14.392607]  ? find_held_lock+0x2f/0xa0
>> [   14.392607]  ? cdrom_analyze_sense_data+0x1b0/0x1b0
>> [   14.392607]  ide_intr+0x135/0x250
>> [   14.392607]  __handle_irq_event_percpu+0x3e/0x250
>> [   14.392607]  handle_irq_event_percpu+0x1f/0x50
>> [   14.392607]  handle_irq_event+0x32/0x60
>> [   14.392607]  ? handle_fasteoi_irq+0x160/0x160
>> [   14.392607]  handle_level_irq+0x6c/0x110
>> [   14.392607]  handle_irq+0x72/0xa0
>> [   14.392607]  </IRQ>
>> [   14.392607]  do_IRQ+0x45/0xad
>> [   14.392607]  common_interrupt+0x115/0x11c
>> [   14.392607] EIP: ide_output_data+0xb7/0x140
>> [   14.392607] Code: 00 00 00 0f b7 03 66 89 07 83 c3 02 39 d3 75 f3 83 c4 14 5b 5e 5f 5d c3 8d 76 00 8b 4d ec d1 e9 80 7d f0 00 75 15 89 de 89 fa <f3> 66 6f 83 c4 14 5b 5e 5f 5d c3 8d b6 00 00 00 00 85 c9 74 ee 49
>> [   14.392607] EAX: 00000000 EBX: f5b800ac ECX: 00000000 EDX: 00000170
>> [   14.392607] ESI: f5b800b8 EDI: 00000170 EBP: f6a57dac ESP: f6a57d8c
>> [   14.392607] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010246
>> [   14.392607]  ? print_usage_bug+0x9b/0x1f0
>> [   14.392607]  ? ide_output_data+0xb7/0x140
>> [   14.392607]  ? ide_set_handler+0x42/0x50
>> [   14.392607]  ide_transfer_pc+0x11c/0x2a0
>> [   14.392607]  ? ide_check_atapi_device+0x130/0x130
>> [   14.392607]  ? ide_pc_intr+0x3d0/0x3d0
>> [   14.392607]  ide_issue_pc+0x160/0x250
>> [   14.392607]  ? ide_check_atapi_device+0x130/0x130
>> [   14.392607]  ide_cd_do_request+0x18e/0x3d0
>> [   14.392607]  ide_issue_rq+0x13a/0x6a0
>> [   14.392607]  ? _raw_spin_unlock_irq+0x22/0x30
>> [   14.392607]  ? lockdep_hardirqs_on+0xe4/0x190
>> [   14.392607]  ? _raw_spin_unlock_irq+0x22/0x30
>> [   14.392607]  ? trace_hardirqs_on+0x38/0xe0
>> [   14.392607]  ? drive_rq_insert_work+0x7a/0xf0
>> [   14.392607]  drive_rq_insert_work+0x8a/0xf0
>> [   14.392607]  process_one_work+0x207/0x500
>> [   14.392607]  ? process_one_work+0x16b/0x500
>> [   14.392607]  worker_thread+0x39/0x400
>> [   14.392607]  kthread+0xee/0x110
>> [   14.392607]  ? process_one_work+0x500/0x500
>> [   14.392607]  ? kthread_create_on_node+0x30/0x30
>> [   14.392607]  ret_from_fork+0x1e/0x28
>> [   14.392607] Modules linked in:
>> [   14.392607] CR2: 00000000000002ac
>> [   14.392607] ---[ end trace 2efe0b990b41cd59 ]---
>>
>>
>> To reproduce:
>>
>>         # build kernel
>> 	cd linux
>> 	cp config-5.4.0-rc2-00011-g48d9b0d43105e .config
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=i386 olddefconfig prepare modules_prepare bzImage
>>
>>         git clone https://github.com/intel/lkp-tests.git
>>         cd lkp-tests
>>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>>
>>
>>
>> Thanks,
>> Rong Chen
>>
> 
> 
