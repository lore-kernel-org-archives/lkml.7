Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD02C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0826B21473
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 03:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfFHDy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 23:54:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbfFHDy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 23:54:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 735952E95AF;
        Sat,  8 Jun 2019 03:54:57 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AE8510013D9;
        Sat,  8 Jun 2019 03:54:54 +0000 (UTC)
Date:   Sat, 8 Jun 2019 11:54:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     lijiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, Thomas.Lendacky@amd.com
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190608035451.GB26148@MiWiFi-R3L-srv>
References: <20190423013007.17838-1-lijiang@redhat.com>
 <12847a03-3226-0b29-97b5-04d404410147@redhat.com>
 <20190607174211.GN20269@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607174211.GN20269@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Sat, 08 Jun 2019 03:54:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/19 at 07:42pm, Borislav Petkov wrote:
> On Tue, May 28, 2019 at 03:30:21PM +0800, lijiang wrote:
> > Hi, Boris and Thomas
> > 
> > Could you give me any suggestions about this patch series? Other reviewers?
> 
> So I'm testing this on a box with SME enabled but after loading the
> crash kernel, it freezes instead of rebooting. My cmdline is:
> 
>  kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+ --command-line="maxcpus=1 root=/dev/sda5 ro debug ignore_loglevel log_buf_len=16M no_console_suspend net.ifnames=0 systemd.log_target=null mem_encrypt=on kvm_amd.sev=1 nr_cpus=1 irqpoll reset_devices vga=normal LANG=en_US.UTF-8 earlyprintk=serial cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"
> 
> and the reserved range is:
> 
> [    0.000000] Reserving 256MB of memory at 3392MB for crashkernel (System RAM: 16271MB)

Is it a UEFI box? If it's uefi machine, it should relate to below issue.
Because kexec always fails to randomly choose a new position for kernel.

The current kexec code fills boot_params->efi_info->efi_loader_signature,
but doesn't contruct efi_memmap table. The kexec/kdump kernel will always
fail to find available slot for KASLR in process_efi_entries.


> 
> I'm wondering if it is related to
> 
> https://lkml.kernel.org/r/20190604134952.GC26891@MiWiFi-R3L-srv
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
