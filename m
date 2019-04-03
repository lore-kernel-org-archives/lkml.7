Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D911BC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6220882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfDCFfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:35:06 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:51767 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726330AbfDCFfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:35:05 -0400
X-IronPort-AV: E=Sophos;i="5.60,303,1549900800"; 
   d="scan'208";a="58359966"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Apr 2019 13:35:03 +0800
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id DF29B4CD7FD5;
        Wed,  3 Apr 2019 13:35:04 +0800 (CST)
Received: from localhost.localdomain (10.167.225.56) by
 G08CNEXCHPEKD01.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 3 Apr 2019 13:35:08 +0800
Date:   Wed, 3 Apr 2019 13:35:00 +0800
From:   Chao Fan <fanc.fnst@cn.fujitsu.com>
To:     Dave Young <dyoung@redhat.com>
CC:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Borislav Petkov <bp@alien8.de>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "kasong@redhat.com" <kasong@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Message-ID: <20190403053459.GD1555@localhost.localdomain>
References: <20190325123229.GL12016@zn.tnic>
 <20190325231000.GA9184@jeru.linux.bs1.fc.nec.co.jp>
 <20190326135714.GG1867@zn.tnic>
 <20190327014852.GA3659@MiWiFi-R3L-srv>
 <73322ba9-e436-68db-7863-afd31607d969@ce.jp.nec.com>
 <20190328064343.GA1877@MiWiFi-R3L-srv>
 <20190328074337.GA9470@jeru.linux.bs1.fc.nec.co.jp>
 <20190328155256.GP22720@zn.tnic>
 <20190401000837.GA5170@jeru.linux.bs1.fc.nec.co.jp>
 <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190402120319.GA7605@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.167.225.56]
X-yoursite-MailScanner-ID: DF29B4CD7FD5.A002E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: fanc.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 08:03:19PM +0800, Dave Young wrote:
>On 04/01/19 at 12:08am, Junichi Nomura wrote:
>> Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
>> boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
>> in the early parsing code tries to search RSDP from EFI table but
>> that will crash because the table address is virtual when the kernel
>> was booted by kexec.
>> 
>> In the case of kexec, physical address of EFI tables is provided
>> via efi_setup_data in boot_params, which is set up by kexec(1).
>> 
>> Factor out the table parsing code and use different pointers depending
>> on whether the kernel is booted by kexec or not.
>> 
>> Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
>> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Dave Young <dyoung@redhat.com>
[...]
>
>I failed to kexec reboot on my laptop, kernel panics too quick,  I'm not sure this is
>caused by your patch though.
>
>Actually there are something probably i915 changes break kexec,  the
>above test is with "nomodeset" which should work.
>
>Let me do more testing and update here tomorrow.
>

Hi Dave,

Last day I was testing the normal kexec, today I have tested the kdump
issue. Since the kdump has set "nokaslr" to cmdline, so I drop from
KDUMP_COMMANDLINE_APPEND
And it booted OK, so the PATCH works in both normal kexec and kdump.

[root@localhost ~]# echo 1 > /proc/sys/kernel/sysrq
[root@localhost ~]# echo c > /proc/sysrq-trigger
[   67.776136] sysrq: Trigger a crash
[   67.777412] Kernel panic - not syncing: sysrq triggered crash
[   67.779429] CPU: 1 PID: 1652 Comm: bash Kdump: loaded Not tainted 5.1.0-rc3+ #4
[   67.780755] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
[   67.782062] Call Trace:
[   67.782490]  dump_stack+0x5c/0x80
[   67.783049]  panic+0x101/0x2a7
[   67.783560]  ? printk+0x58/0x6f
[   67.784091]  sysrq_handle_crash+0x11/0x11
[   67.784762]  __handle_sysrq.cold.7+0x45/0xf2
[   67.785467]  write_sysrq_trigger+0x2b/0x30
[   67.786087]  proc_reg_write+0x39/0x60
[   67.786597]  vfs_write+0xa5/0x1a0
[   67.787061]  ksys_write+0x4f/0xb0
[   67.787492]  do_syscall_64+0x5b/0x160
[   67.788010]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   67.788740] RIP: 0033:0x7f66266fbed8
[   67.789239] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 45 78 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[   67.791325] RSP: 002b:00007ffecdaf6138 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   67.792084] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f66266fbed8
[   67.792820] RDX: 0000000000000002 RSI: 000055dcc8d29880 RDI: 0000000000000001
[   67.793515] RBP: 000055dcc8d29880 R08: 000000000000000a R09: 00007ffecdaf5cc0
[   67.794276] R10: 000000000000000a R11: 0000000000000246 R12: 00007f66267cf780
[   67.795017] R13: 0000000000000002 R14: 00007f66267ca740 R15: 0000000000000002
early console in extract_kernel
input_data: 0x00000000376033b1
input_len: 0x00000000008412d4
output: 0x0000000036000000
output_len: 0x0000000001e15844
kernel_total_size: 0x0000000001e2c000
trampoline_32bit: 0x000000000009d000
booted via startup_64()


Physical KASLR disabled: no suitable memory region!

Virtual KASLR using RDRAND RDTSC...

Decompressing Linux... Parsing ELF... Performing relocations... done.
Booting the kernel.
[...]
         Starting Kdump Vmcore Save Service...
kdump: dump target is /dev/mapper/fedora-root
kdump: saving to /sysroot//var/crash/127.0.0.1-2019-04-03-01:28:01/
[    3.551609] EXT4-fs (dm-0): re-mounted. Opts: (null)
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
Copying data                                      : [100.0 %] |           eta: 0s
kdump: saving vmcore complete

Thanks,
Chao Fan

>Thanks
>Dave
>
>
>


