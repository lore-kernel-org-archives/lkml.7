Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A87C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF870208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfDAOCM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:02:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:47663 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbfDAOCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:02:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 07:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="157669335"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.171.234]) ([10.249.171.234])
  by fmsmga004.fm.intel.com with ESMTP; 01 Apr 2019 07:02:08 -0700
Subject: Re: [btrfs] 70d28b0e4f:
 BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
To:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.com>
Cc:     David Sterba <dsterba@suse.com>,
        Yoon Jungyeon <jungyeon@gatech.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20190401132427.GC9217@shao2-debian>
 <f3cef716-a1e3-2e84-0133-9a9c3fad2a74@suse.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <7a6c000e-c523-382a-d13c-790809260e4e@intel.com>
Date:   Mon, 1 Apr 2019 22:02:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <f3cef716-a1e3-2e84-0133-9a9c3fad2a74@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/1/2019 9:28 PM, Nikolay Borisov wrote:
>
> On 1.04.19 г. 16:24 ч., kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 70d28b0e4f8ed2d38571e7b1f9bec7f321a53102 ("btrfs: tree-checker: Verify dev item")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
>> in testcase: trinity
>> with following parameters:
>>
>> 	runtime: 300s
>>
>> test-description: Trinity is a linux system call fuzz tester.
>> test-url: http://codemonkey.org.uk/projects/trinity/
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 2G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>> +--------------------------------------------------------------------------------------------------------+------------+------------+
>> |                                                                                                        | 36b9d2bc69 | 70d28b0e4f |
>> +--------------------------------------------------------------------------------------------------------+------------+------------+
>> | boot_successes                                                                                         | 14         | 0          |
>> | boot_failures                                                                                          | 2          | 14         |
>> | IP-Config:Auto-configuration_of_network_failed                                                         | 2          |            |
>> | BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok | 0          | 14         |
>> +--------------------------------------------------------------------------------------------------------+------------+------------+
>>
>>
>>
>> early console in setup code
>> Probing EDD (edd=off to disable)... ok
>> BUG: kernel reboot-without-warning in early-boot stage, last printk: Probing EDD (edd=off to disable)... ok
>> Linux version 5.0.0-rc8-00196-g70d28b0 #1
>> Command line: ip=::::vm-snb-quantal-x86_64-1415::dhcp root=/dev/ram0 user=lkp job=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-1415/trinity-300s-quantal-core-x86_64-2018-11-09.cgz-70d28b0-20190330-29362-1y6g0qb-2.yaml ARCH=x86_64 kconfig=x86_64-randconfig-s5-03231928 branch=linux-devel/devel-hourly-2019032317 commit=70d28b0e4f8ed2d38571e7b1f9bec7f321a53102 BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/vmlinuz-5.0.0-rc8-00196-g70d28b0 max_uptime=1500 RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2018-11-09.cgz/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/8 LKP_SERVER=inn debug apic=debug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 console=ttyS0,115
 200 vga=normal rw rcuperf.shutdown=0
>>
> Can this report be made useful by actually including output from serial
> console? For example possible bug-ons or whatnot? dmesg.xz just contains
> qemu's command line + some metadata about the test and :
>
> "BUG: kernel reboot-without-warning in early-boot stage, last printk:
> Probing EDD (edd=off to disable)... ok"
>
> At least a stack trace would have been useful.
>
> <snip>


Hi,

We usually use the tool ("bin/lkp qemu -k <bzImage> job-script") to 
reproduce it.  It seems no stack trace in the result:

$ lkp qemu -k vmlinuz-5.0.0-rc8-00196-g70d28b0 job-script
...
Formatting '/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-0', fmt=qcow2 
size=274877906944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
Formatting '/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-1', fmt=qcow2 
size=274877906944 cluster_size=65536 lazy_refcounts=off refcount_bits=16
exec command: qemu-system-x86_64 -enable-kvm -fsdev 
local,id=test_dev,path=/home/nfs/.lkp//result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2018-11-09.cgz/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/2,security_model=none 
-device virtio-9p-pci,fsdev=test_dev,mount_tag=9p/virtfs_mount -kernel 
vmlinuz-5.0.0-rc8-00196-g70d28b0 -append root=/dev/ram0 user=lkp 
job=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-1415/trinity-300s-quantal-core-x86_64-2018-11-09.cgz-70d28b0-20190330-29362-1y6g0qb-2.yaml 
ARCH=x86_64 kconfig=x86_64-randconfig-s5-03231928 
branch=linux-devel/devel-hourly-2019032317 
commit=70d28b0e4f8ed2d38571e7b1f9bec7f321a53102 
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/vmlinuz-5.0.0-rc8-00196-g70d28b0 
max_uptime=1500 
RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2018-11-09.cgz/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/8 
LKP_LOCAL_RUN=1 debug apic=debug sysrq_always_enabled 
rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on 
panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic load_ramdisk=2 
prompt_ramdisk=0 drbd.minor_count=8 systemd.log_level=err 
ignore_loglevel console=tty0 earlyprintk=ttyS0,115200 
console=ttyS0,115200 vga=normal rw ip=dhcp 
result_service=9p/virtfs_mount -initrd /home/nfs/.lkp/cache/final_initrd 
-smp 2 -m 2048M -no-reboot -watchdog i6300esb -rtc base=localtime 
-device e1000,netdev=net0 -netdev user,id=net0 -display none -monitor 
null -serial stdio -drive 
file=/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-0,media=disk,if=virtio 
-drive 
file=/tmp/vdisk-nfs/disk-vm-snb-quantal-x86_64-1415-1,media=disk,if=virtio
early console in setup code
Probing EDD (edd=off to disable)... ok

Best Regards,
Rong Chen

