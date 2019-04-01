Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB96C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F5620880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfDAPji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:39:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:56506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727021AbfDAPji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:39:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 18BFEAEC3;
        Mon,  1 Apr 2019 15:39:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B15F8DA823; Mon,  1 Apr 2019 17:40:45 +0200 (CEST)
Date:   Mon, 1 Apr 2019 17:40:44 +0200
From:   David Sterba <dsterba@suse.cz>
To:     " Chen, Rong A " <rong.a.chen@intel.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.de>,
        lkp@01.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Yoon Jungyeon <jungyeon@gatech.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [btrfs] 70d28b0e4f:
 BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
Message-ID: <20190401154044.GX29086@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, " Chen, Rong A " <rong.a.chen@intel.com>,
        Nikolay Borisov <nborisov@suse.com>, Qu Wenruo <wqu@suse.de>,
        lkp@01.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Yoon Jungyeon <jungyeon@gatech.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190401132427.GC9217@shao2-debian>
 <f3cef716-a1e3-2e84-0133-9a9c3fad2a74@suse.com>
 <7a6c000e-c523-382a-d13c-790809260e4e@intel.com>
 <5b82b026-bdd7-f781-e661-f1afdc9cb97b@suse.de>
 <23823210-1951-0492-1755-6263ccf388fa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23823210-1951-0492-1755-6263ccf388fa@intel.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:02:37PM +0800,  Chen, Rong A  wrote:
> 
> On 4/1/2019 10:29 PM, Qu Wenruo wrote:
> >
> > On 2019/4/1 下午10:02,  Chen, Rong A  wrote:
> >> On 4/1/2019 9:28 PM, Nikolay Borisov wrote:
> >>> On 1.04.19 г. 16:24 ч., kernel test robot wrote:
> >>>> FYI, we noticed the following commit (built with gcc-7):
> >>>>
> >>>> commit: 70d28b0e4f8ed2d38571e7b1f9bec7f321a53102 ("btrfs:
> >>>> tree-checker: Verify dev item")
> >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >>>>
> >>>> in testcase: trinity
> >>>> with following parameters:
> >>>>
> >>>>      runtime: 300s
> >>>>
> >>>> test-description: Trinity is a linux system call fuzz tester.
> >>>> test-url: http://codemonkey.org.uk/projects/trinity/
> >>>>
> >>>>
> >>>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
> >>>> 2 -m 2G
> >>>>
> >>>> caused below changes (please refer to attached dmesg/kmsg for entire
> >>>> log/backtrace):
> >>>>
> >>>>
> >>>> +--------------------------------------------------------------------------------------------------------+------------+------------+
> >>>>
> >>>> |
> >>>> | 36b9d2bc69 | 70d28b0e4f |
> >>>> +--------------------------------------------------------------------------------------------------------+------------+------------+
> >>>>
> >>>> |
> >>>> boot_successes
> >>>> | 14         | 0          |
> >>>> |
> >>>> boot_failures
> >>>> | 2          | 14         |
> >>>> |
> >>>> IP-Config:Auto-configuration_of_network_failed
> >>>> | 2          |            |
> >>>> |
> >>>> BUG:kernel_reboot-without-warning_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
> >>>> | 0          | 14         |
> >>>> +--------------------------------------------------------------------------------------------------------+------------+------------+
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> early console in setup code
> >>>> Probing EDD (edd=off to disable)... ok
> >>>> BUG: kernel reboot-without-warning in early-boot stage, last printk:
> >>>> Probing EDD (edd=off to disable)... ok
> >>>> Linux version 5.0.0-rc8-00196-g70d28b0 #1
> >>>> Command line: ip=::::vm-snb-quantal-x86_64-1415::dhcp root=/dev/ram0
> >>>> user=lkp
> >>>> job=/lkp/jobs/scheduled/vm-snb-quantal-x86_64-1415/trinity-300s-quantal-core-x86_64-2018-11-09.cgz-70d28b0-20190330-29362-1y6g0qb-2.yaml
> >>>> ARCH=x86_64 kconfig=x86_64-randconfig-s5-03231928
> >>>> branch=linux-devel/devel-hourly-2019032317
> >>>> commit=70d28b0e4f8ed2d38571e7b1f9bec7f321a53102
> >>>> BOOT_IMAGE=/pkg/linux/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/vmlinuz-5.0.0-rc8-00196-g70d28b0
> >>>> max_uptime=1500
> >>>> RESULT_ROOT=/result/trinity/300s/vm-snb-quantal-x86_64/quantal-core-x86_64-2018-11-09.cgz/x86_64-randconfig-s5-03231928/gcc-7/70d28b0e4f8ed2d38571e7b1f9bec7f321a53102/8
> >>>> LKP_SERVER=inn debug apic=debug sysrq_always_enabled
> >>>> rcupdate.rcu_cpu_stall_timeout=100 net.ifnames=0 printk.devkmsg=on
> >>>> panic=-1 softlockup_panic=1 nmi_watchdog=panic oops=panic
> >>>> load_ramdisk=2 prompt_ramdisk=0 drbd.minor_count=8
> >>>> systemd.log_level=err ignore_loglevel console=tty0
> >>>> earlyprintk=ttyS0,115200 console=ttyS0,115200 vga=normal rw
> >>>> rcuperf.shutdown=0
> >>>>
> >>> Can this report be made useful by actually including output from serial
> >>> console? For example possible bug-ons or whatnot? dmesg.xz just contains
> >>> qemu's command line + some metadata about the test and :
> >>>
> >>> "BUG: kernel reboot-without-warning in early-boot stage, last printk:
> >>> Probing EDD (edd=off to disable)... ok"
> >>>
> >>> At least a stack trace would have been useful.
> >>>
> >>> <snip>
> >>
> >> Hi,
> >>
> >> We usually use the tool ("bin/lkp qemu -k <bzImage> job-script") to
> >> reproduce it.  It seems no stack trace in the result:
> > So there is no regression at that commit right?
> >
> > Just some false alert?
> 
> 
> Hi,
> 
> I think there's a regression, it stopped in the early-boot stage .

Can you please provide any logs that would point at btrfs? If the module
is loaded or built-in started, there's a line about that. Besides that
it's preceded by messages from other subsystems' initialization.
