Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7CC206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfHYTc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:32:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728685AbfHYTc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:32:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96ED3AFE4;
        Sun, 25 Aug 2019 19:32:25 +0000 (UTC)
Date:   Sun, 25 Aug 2019 21:32:18 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190825193218.GD20639@zn.tnic>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic>
 <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic>
 <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 11:38:50AM -0700, Linus Torvalds wrote:
> On Sun, Aug 25, 2019 at 11:29 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > My lazy, sticky Sunday brain could come up only with this:
> 
> Looks reasonable, except I think this only runs at boot, right?
> 
> I _think_ the boot CPU is magical during suspend/resume, and doesn't
> do the full CPU bringup.
> 
> Although I guess this would still report it for the other CPU's? I
> didn't check if this gets done during CPU bringup of secondary CPU's.

So after adding a dump_stack() at the beginning of this function (yap,
I'm lazy) I see during boot:

[    0.230044] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc5+ #9
[    0.230759] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[    0.231690] Call Trace:
[    0.232097]  dump_stack+0x46/0x60
[    0.232496]  x86_init_rdrand+0xf/0xa1
[    0.232496]  identify_cpu+0x352/0x540
[    0.232496]  identify_boot_cpu+0xc/0x8f
[    0.232496]  check_bugs+0x28/0x8e4
[    0.232496]  ? __get_locked_pte+0x13e/0x1f0
[    0.232496]  start_kernel+0x4ae/0x4ca

and also on all the remaining 15 CPUs of the guest. Then, suspending to
RAM and resuming right afterwards says:

[   51.620230] Disabling non-boot CPUs ...
[   51.622745] smpboot: CPU 1 is now offline
[   51.627264] smpboot: CPU 2 is now offline
[   51.630581] smpboot: CPU 3 is now offline
[   51.634533] smpboot: CPU 4 is now offline
[   51.638715] smpboot: CPU 5 is now offline
[   51.642590] smpboot: CPU 6 is now offline
[   51.645890] smpboot: CPU 7 is now offline
[   51.649076] smpboot: CPU 8 is now offline
[   51.652362] smpboot: CPU 9 is now offline
[   51.655647] smpboot: CPU 10 is now offline
[   51.659061] smpboot: CPU 11 is now offline
[   51.662772] smpboot: CPU 12 is now offline
[   51.665863] smpboot: CPU 13 is now offline
[   51.667980] smpboot: CPU 14 is now offline
[   51.671644] smpboot: CPU 15 is now offline
[   51.675640] ACPI: Low-level resume complete
[   51.675640] PM: Restoring platform NVS memory
[   51.675640] Enabling non-boot CPUs ...
[   51.728674] x86: Booting SMP configuration:
[   51.729015] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   51.625362] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.3.0-rc5+ #9
[   51.625362] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[   51.625362] Call Trace:
[   51.625362]  dump_stack+0x46/0x60
[   51.625362]  x86_init_rdrand+0xf/0xa1
[   51.625362]  identify_cpu+0x352/0x540
[   51.625362]  identify_secondary_cpu+0x13/0x80
[   51.625362]  smp_store_cpu_info+0x45/0x50
[   51.625362]  start_secondary+0x4f/0x180
[   51.625362]  secondary_startup_64+0xa4/0xb0
[   51.740833] CPU1 is up
...

and the remaining 14(!). Yes, this doesn't run on the BSP during resume.
I think the better thing to do would be to stick this in a CPUHP
notifier...

Btw:

Subject: Undelivered Mail Returned to Sender

...

<puwen@hygon.cn>: Host or domain name not found. Name service error for
    name=spam01.hygon.cn type=AAAA: Host found but no data record of requested
    type

hygon.cn domain doesn't even resolve from here. Oh boy.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 247165, AG München
