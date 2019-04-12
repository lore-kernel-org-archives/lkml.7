Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D8FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35082186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDLOBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:01:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38243 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfDLOBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:01:38 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 822F23087949;
        Fri, 12 Apr 2019 14:01:26 +0000 (UTC)
Received: from llong.remote.csb (ovpn-117-71.phx2.redhat.com [10.3.117.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20D6F10694ED;
        Fri, 12 Apr 2019 14:01:20 +0000 (UTC)
Subject: Re: [locking/rwsem] f03c360396: WARNING:at_init/main.c:#start_kernel
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, tipbuild@zytor.com, lkp@01.org
References: <20190412031809.GJ17122@shao2-debian>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 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
 weim8xU=
Organization: Red Hat
Message-ID: <4d35a232-ed7b-b74e-bbae-30013355ceb8@redhat.com>
Date:   Fri, 12 Apr 2019 10:01:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190412031809.GJ17122@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 12 Apr 2019 14:01:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2019 11:18 PM, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
>
> commit: f03c36039664fc53ebf6d8322c46aaf8e373f70c ("locking/rwsem: Merge owner into count on x86-64")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.locking/core
>
> in testcase: trinity
> with following parameters:
>
> 	runtime: 300s
>
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
>
> +----------------------------------------------------+------------+------------+
> |                                                    | 1878939138 | f03c360396 |
> +----------------------------------------------------+------------+------------+
> | boot_successes                                     | 0          | 0          |
> | boot_failures                                      | 4          | 9          |
> | BUG:kernel_hang_in_boot-around-mounting-root_stage | 3          | 5          |
> | BUG:kernel_reboot-without-warning_in_test_stage    | 1          |            |
> | WARNING:at_init/main.c:#start_kernel               | 0          | 9          |
> | RIP:start_kernel                                   | 0          | 9          |
> +----------------------------------------------------+------------+------------+
>
>
>
> [    4.777899] WARNING: CPU: 0 PID: 0 at init/main.c:663 start_kernel+0x366/0x512
> [    4.777906] Modules linked in:
> [    4.777920] CPU: 0 PID: 0 Comm: swapper Not tainted 5.1.0-rc4-00083-gf03c360 #2
> [    4.777929] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    4.777943] RIP: 0010:start_kernel+0x366/0x512
> [    4.777957] Code: 01 00 e8 f2 85 00 00 e8 84 cd 01 00 e8 0e 48 02 00 e8 34 2b 8b fe 9c 58 0f ba e0 09 73 0e 48 c7 c7 e0 08 a0 99 e8 2c 91 bd fd <0f> 0b c6 05 4b c0 b9 ff 00 e8 64 d2 cb fd fb e8 c9 ca 02 00 e8 87
> [    4.777966] RSP: 0000:ffffffff9a207ed8 EFLAGS: 00010282
> [    4.777977] RAX: dffffc0000000008 RBX: ffff8881f699cb00 RCX: ffffffff9896f4d5
> [    4.777986] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff988f0c4b
> [    4.777995] RBP: 1ffffffff3440fdb R08: fffffbfff35085ae R09: fffffbfff35085ae
> [    4.778003] R10: 0000000000000001 R11: fffffbfff35085ad R12: ffffffff9ad812e0
> [    4.778011] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    4.778020] FS:  0000000000000000(0000) GS:ffffffff9a2a7000(0000) knlGS:0000000000000000
> [    4.778029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.778037] CR2: 00000000ffffffff CR3: 00000001e884c000 CR4: 00000000000006b0
> [    4.778046] Call Trace:
> [    4.778063]  ? mem_encrypt_init+0x1/0x1
> [    4.778080]  ? memcpy_orig+0x16/0x110
> [    4.778093]  secondary_startup_64+0xb6/0xc0
> [    4.778116] random: get_random_bytes called from print_oops_end_marker+0x34/0x47 with crng_init=0
> [    4.778128] ---[ end trace 8182026d66b2a4ad ]---
>
>
> To reproduce:
>
>         # build kernel
> 	cd linux
> 	cp config-5.1.0-rc4-00083-gf03c360 .configf03c36039664fc53ebf6d8322c46aaf8e373f70c
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 prepare
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 modules_prepare
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 SHELL=/bin/bash
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 bzImage
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
>
>
>
> Thanks,
> Rong Chen
>
I think it was caused by the bug that I forgot to initialize sem->owner
in __init_rwsem() when CONFIG_RWSEM_SPIN_ON_OWNER isn't defined as
pointed out by Peter. That will be fixed in the next version of the
patchset.

Thanks,
Longman

