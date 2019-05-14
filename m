Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECD8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAF52085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfENIsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:48:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbfENIsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:48:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF36530820EA;
        Tue, 14 May 2019 08:48:49 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 02079608AC;
        Tue, 14 May 2019 08:48:45 +0000 (UTC)
Date:   Tue, 14 May 2019 16:48:41 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, j-nomura@ce.jp.nec.com,
        kasong@redhat.com, fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Message-ID: <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
References: <20190424092944.30481-1-bhe@redhat.com>
 <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic>
 <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic>
 <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic>
 <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 14 May 2019 08:48:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/14/19 at 11:22am, Dave Young wrote:
> On 05/13/19 at 04:06pm, Baoquan He wrote:
> > Hi Dave,
> > 
> > On 05/13/19 at 09:50am, Borislav Petkov wrote:
> > > On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> > > > This is a critical bug which breaks memory hotplug,
> > > 
> > > Please concentrate and stop the blabla:
> > > 
> > > 36f0c423552d ("x86/boot: Disable RSDP parsing temporarily")
> > > 
> > > already explains what the deal is. This code was *purposefully* disabled
> > > because we ran out of time and it broke a couple of machines. Don't make
> > 
> > I remember your machine is the one on whihc the issue is reported. Could
> > you also test it and confirm if these all things found ealier are
> > cleared out?
> > 
> 
> I did some tests on the laptop,  thing is:
> 1. apply the 3 patches (two you posted + Boris's revert commit 52b922c3d49c)
>    on latest Linus master branch, everything works fine.
> 
> 2. build and test the tip/next-merge-window branch, kernel hangs early
> without output, (both 1st boot and kexec boot)

Update about 2.  It should be not early rsdp related, I got the boot log
Since can not reproduce with Linus master branch it may have been fixed.

[    0.685374][    T1] rcu: Hierarchical SRCU implementation.
[    0.686414][    T1] general protection fault: 0000 [#1] SMP PTI
[    0.687328][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.0-rc6+ #877
[    0.687328][    T1] Hardware name: LENOVO 4236NUC/4236NUC, BIOS 83ET82WW (1.52 ) 06/04/2018
[    0.687328][    T1] RIP: 0010:reserve_ds_buffers+0x34e/0x450
[    0.687328][    T1] Code: e8 77 49 1a 00 4c 8b 54 24 18 48 85 c0 4c 8b 4c 24 10 48 89 44 24 20 0f 84 68 fe ff ff 4a 8b 0c cd 20 88 07 a7 48 8d 54 24 20 <48> 89 04 11 e9 e5 fd ff ff 85 db 0f 85 67 fe ff ff 45 85 ed 75 24
[    0.687328][    T1] RSP: 0000:ffffa52100c8bd90 EFLAGS: 00010286
[    0.687328][    T1] RAX: ffff8c6bd5d03000 RBX: 0000000000000000 RCX: ffff8c6bd6000000
[    0.687328][    T1] RDX: ffffa52100c8bdb0 RSI: ffffffffa620e209 RDI: ffff8c6bd5d04000
[    0.687328][    T1] RBP: ffff8c6bd60103a0 R08: ffff8c6bd4da0000 R09: 0000000000000000
[    0.687328][    T1] R10: ffff8c6bd4e20000 R11: ffffc8e248538800 R12: 00000000000103a0
[    0.687328][    T1] R13: 0000000000010000 R14: fffffe0000013000 R15: 0000000000000000
[    0.687328][    T1] FS:  0000000000000000(0000) GS:ffff8c6bd6000000(0000) knlGS:0000000000000000
[    0.687328][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.687328][    T1] CR2: ffff8c6bde5ff000 CR3: 000000015700e001 CR4: 00000000000606f0
[    0.687328][    T1] Call Trace:
[    0.687328][    T1]  ? hardlockup_detector_event_create+0x50/0x50
[    0.687328][    T1]  x86_reserve_hardware+0x173/0x180
[    0.687328][    T1]  x86_pmu_event_init+0x39/0x220
[    0.687328][    T1]  ? hardlockup_detector_event_create+0x50/0x50
[    0.687328][    T1]  perf_try_init_event+0x42/0xd0
[    0.687328][    T1]  perf_event_alloc+0x46a/0x8b0
[    0.687328][    T1]  perf_event_create_kernel_counter+0x21/0x130
[    0.687328][    T1]  hardlockup_detector_event_create+0x39/0x50
[    0.687328][    T1]  hardlockup_detector_perf_init+0xc/0x40
[    0.687328][    T1]  lockup_detector_init+0x3a/0x71
[    0.687328][    T1]  kernel_init_freeable+0xbc/0x231
[    0.687328][    T1]  ? rest_init+0x9f/0x9f
[    0.687328][    T1]  kernel_init+0xa/0x101
[    0.687328][    T1]  ret_from_fork+0x35/0x40
[    0.687328][    T1] Modules linked in:
[    0.687331][    T1] ---[ end trace 71ee47f6125e74a4 ]---
[    0.688331][    T1] RIP: 0010:reserve_ds_buffers+0x34e/0x450
[    0.689330][    T1] Code: e8 77 49 1a 00 4c 8b 54 24 18 48 85 c0 4c 8b 4c 24 10 48 89 44 24 20 0f 84 68 fe ff ff 4a 8b 0c cd 20 88 07 a7 48 8d 54 24 20 <48> 89 04 11 e9 e5 fd ff ff 85 db 0f 85 67 fe ff ff 45 85 ed 75 24
[    0.690330][    T1] RSP: 0000:ffffa52100c8bd90 EFLAGS: 00010286
[    0.691330][    T1] RAX: ffff8c6bd5d03000 RBX: 0000000000000000 RCX: ffff8c6bd6000000
[    0.692330][    T1] RDX: ffffa52100c8bdb0 RSI: ffffffffa620e209 RDI: ffff8c6bd5d04000
[    0.693330][    T1] RBP: ffff8c6bd60103a0 R08: ffff8c6bd4da0000 R09: 0000000000000000
[    0.694330][    T1] R10: ffff8c6bd4e20000 R11: ffffc8e248538800 R12: 00000000000103a0
[    0.695330][    T1] R13: 0000000000010000 R14: fffffe0000013000 R15: 0000000000000000
[    0.696330][    T1] FS:  0000000000000000(0000) GS:ffff8c6bd6000000(0000) knlGS:0000000000000000
[    0.697330][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.698330][    T1] CR2: ffff8c6bde5ff000 CR3: 000000015700e001 CR4: 00000000000606f0
[    0.699334][    T1] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.700328][    T1] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Thanks
Dave
