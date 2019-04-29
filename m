Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3E6C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ADA21655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfD2V0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:47024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbfD2V0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:26:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE8752075E;
        Mon, 29 Apr 2019 21:26:28 +0000 (UTC)
Date:   Mon, 29 Apr 2019 17:17:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Subject: Re: [function_graph] 02519fa3c4:
 BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:early_console_in_setup_code
Message-ID: <20190429171700.4d48791c@gandalf.local.home>
In-Reply-To: <20190429075629.GD29809@shao2-debian>
References: <20190429075629.GD29809@shao2-debian>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019 15:56:29 +0800
kernel test robot <lkp@intel.com> wrote:

> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 02519fa3c43164aa8ee0ebbe1b464a568130a36f ("function_graph: Use a ftrace_graph_ret_stub() for return")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 

Thanks. Seems that ftrace_graph_return is expected to point at
ftrace_stub when not in use, and this is critical when DYNAMIC_FTRACE
is not enabled (and for various other architectures).

I'll have to just remove this change for upstream (and rebase my
for-next, which I usually try to avoid doing. But this shouldn't hurt).

-- Steve

> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-----------------------------------------------------------------------------------------------+------------+------------+
> |                                                                                               | 52fde6e70c | 02519fa3c4 |
> +-----------------------------------------------------------------------------------------------+------------+------------+
> | boot_successes                                                                                | 4          | 0          |
> | boot_failures                                                                                 | 0          | 4          |
> | BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:early_console_in_setup_code | 0          | 4          |
> +-----------------------------------------------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> early console in setup code
> BUG: kernel reboot-without-warning in early-boot stage, last printk: early console in setup code
> Linux version 5.1.0-rc3-00023-g02519fa #1
> Command line: ip=::::vm-snb-quantal-ia32-804::dhcp root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-snb-quantal-ia32-804/trinity-300s-quantal-core-i386-2019-04-26.cgz-02519fa3c43-20190429-62375-116iczn-1.yaml ARCH=x86_64 kconfig=x86_64-randconfig-s3-04261012 branch=linux-devel/devel-hourly-2019042607 commit=02519fa3c43164aa8ee0ebbe1b464a568130a36f BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s3-04261012/gcc-7/02519fa3c43164aa8ee0ebbe1b464a568130a36f/vmlinuz-5.1.0-rc3-00023-g02519fa max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-ia32/quantal-core-i386-2019-04-26.cgz/x86_64-randconfig-s3-04261012/gcc-7/02519fa3c43164aa8ee0ebbe1b464a568130a36f/3 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=n
 ormal rw rcuperf.shutdown=0
> 
> Elapsed time: 30
> 
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.1.0-rc3-00023-g02519fa .config
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
> lkp
> 

