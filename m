Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE517C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4920896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732992AbfFMPIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:08:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53130 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbfFMPH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 11:07:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3666D30872C8;
        Thu, 13 Jun 2019 15:07:58 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 944D061B7E;
        Thu, 13 Jun 2019 15:07:47 +0000 (UTC)
Date:   Thu, 13 Jun 2019 23:07:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc:     lijiang <lijiang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190613150744.GR26148@MiWiFi-R3L-srv>
References: <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv>
 <20190612151033.GJ32652@zn.tnic>
 <3dfa5985-008a-20d8-5171-cfe96807c303@amd.com>
 <20190612180724.GP32652@zn.tnic>
 <d89ef4ef-b85a-ea94-acdf-2eed5666ed78@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d89ef4ef-b85a-ea94-acdf-2eed5666ed78@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Jun 2019 15:07:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/19 at 07:10pm, Lendacky, Thomas wrote:
> On 6/12/19 1:07 PM, Borislav Petkov wrote:
> > On Wed, Jun 12, 2019 at 04:52:22PM +0000, Lendacky, Thomas wrote:
> >> I think the discussion ended up being that debuginfo wasn't being stripped
> >> from the kernel and initrd (mainly the initrd).  What are the sizes of
> >> the kernel and initrd that you are loading for kdump via kexec?
> >>
> >> From previous post:
> >>   kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+
> > 
> > You mean those sizes?
> > 
> > $ ls -lh /boot/vmlinuz-5.2.0-rc3+ /boot/initrd.img-5.2.0-rc3+
> > -rw-r--r-- 1 root root 7.8M Jun 10 12:53 /boot/initrd.img-5.2.0-rc3+
> > -rw-r--r-- 1 root root 6.7M Jun 10 12:53 /boot/vmlinuz-5.2.0-rc3+
> > 
> > That should fit easily in 256M :)
> 
> Certainly seems like they should. I know there are other things that are
> loaded, but that should be plenty of room. I wonder if Baoquan or Lianbo
> could track where things are being loaded to see if everything is being
> calculated and placed properly.

Today I did some investigations on speedway and another customer's
machine with sme support. 

In kdump kernel boot log, we can see that it prints the memory usage as
below from mem_init_print_info() of mem_init(). There it free all
memblock memory into buddy. We can see kernel used (144828K reserved)
before this, about 144M. This is for sure, and I got the same value form
memblock=debug kernel parameter adding.

[    2.109408] Kernel command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.2.0-rc4+ ro mem_encrypt=on resume=/dev/mapper/rhel_amd--speedway--05-swap console=ttyS0,115200 earlyprintk=serial,0x6000,115200 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never nr_cpus=1 debug nokaslr disable_cpu_apicid=0 elfcorehdr=1899892K
[    2.155433] Memory: 65572K/262128K available (12292K kernel code, 2047K rwdata, 3840K rodata, 2344K init, 6360K bss, 144828K reserved, 0K cma-reserved)

The free memory in buddy is 65572K, about 65M. This confuses me. I added
below code to print the free memory, it's about 64M. It seems not
changed. I need read code and check further.

[    5.775595] bhe: free:0x10304
[    5.778612] Mem-Info:
[    5.780923] active_anon:1818 inactive_anon:12837 isolated_anon:0
[    5.780923]  active_file:0 inactive_file:0 isolated_file:0
[    5.780923]  unevictable:0 dirty:0 writeback:0 unstable:0
[    5.780923]  slab_reclaimable:1995 slab_unreclaimable:3347
[    5.780923]  mapped:0 shmem:14662 pagetables:1 bounce:0
[    5.780923]  free:16577 free_pcp:3 free_cma:0

--- a/init/main.c
+++ b/init/main.c
@@ -1168,6 +1168,8 @@ static noinline void __init kernel_init_freeable(void)
 
        do_basic_setup();
 
+       pr_info("bhe: free:0x%lx\n", nr_free_pages() << (PAGE_SHIFT - 10));
+       show_mem(0, NULL);

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Above is about code debugging and analysis. From testing results, there
are things impacting the memory usage of kdump kernel. 

1)We need strip DEBUG INFO from kernel modules, otherwise it will bloat
the initrd and its space.

2)And some machines will consume more memory than other, because they own
more pci devices or different devices and drivers. Before init process
run, we will detect and init them, these will eat memory.

With my testing, the speedway machine which has 128 cpus obvisouly consume
more memory than one HP machine. On the HP machine, even 160M
crashkernel memory with DEBUG INFO stripped, kdump kernel can work well.
While 160M crashkernel doesn't satisfy speedway machine, it needs 256M.

3)Some extra kernel parameters may impact memory usage. E.g in Boris's
test, 'log_buf_len=16M' and 'debug' are added, this will cost extra
memory.

kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+ --command-line="maxcpus=1 root=/dev/sda5 ro debug ignore_loglevel
log_buf_len=16M no_console_suspend net.ifnames=0 systemd.log_target=null mem_encrypt=on kvm_amd.sev=1 nr_cpus=1 irqpoll reset_devices vga=normal
LANG=en_US.UTF-8 earlyprintk=serial cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug
transparent_hugepage=never disable_cpu_apicid=0"

Anyway, I will continue investigating, see if I can get exact
information from kernel printing or debugging.

Thanks
Baoquan
