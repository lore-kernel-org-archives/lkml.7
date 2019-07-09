Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3152C73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB0020656
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGIW16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:27:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46416 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:27:58 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkyaS-0007i2-D9; Wed, 10 Jul 2019 00:27:49 +0200
Date:   Wed, 10 Jul 2019 00:27:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
In-Reply-To: <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
References: <20190708162756.GA69120@gmail.com> <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com> <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com> <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
 <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019, Linus Torvalds wrote:

> On Tue, Jul 9, 2019 at 2:45 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > and I suspect it's the sensitive bit pinning. But I'll delve all the way.
> 
> Confirmed. Bisection says
> 
> 873d50d58f67ef15d2777b5e7f7a5268bb1fbae2 is the first bad commit
> commit 873d50d58f67ef15d2777b5e7f7a5268bb1fbae2
> Author: Kees Cook <keescook@chromium.org>
> Date:   Mon Jun 17 21:55:02 2019 -0700
> 
>     x86/asm: Pin sensitive CR4 bits
> 
> this is on a bog-standard Intel setup with F30, both desktop and
> laptop (i9-9900k and i7-8565u respectively).
> 
> I haven't confirmed yet whether reverting just that one commit is
> required, or if I need to revert the cr0 one too.
> 
> I also don't have any logs, because the boot never gets far enough. I
> assume that there was a problem bringing up a non-boot CPU, and the
> eventual hang ends up being due to that.

Hrm. I just build the tip of your tree and bootet it. It hangs at:

[    4.788678] ACPI: 4 ACPI AML tables successfully acquired and loaded
[    4.793860] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    4.821476] ACPI: Dynamic OEM Table Load:

That's way after the secondary CPUs have been brought up. tip/master boots
without problems with the same config. Let me try x86/asm alone and also a
revert of the CR4/CR0 stuff.

And while writing this the softlockup detector muttered:

[  245.849408] INFO: task swapper/0:1 blocked for more than 120 seconds.
[  245.853406]       Not tainted 5.2.0+ #69
[  245.857318] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  245.865405] swapper/0       D    0     1      0 0x80004000
[  245.869405] Call Trace:
[  245.871859]  ? __schedule+0x2bb/0x690
[  245.877410]  ? acpi_ps_complete_op+0x259/0x279
[  245.881406]  schedule+0x29/0x90
[  245.884540]  schedule_timeout+0x20d/0x310
[  245.889409]  ? acpi_os_release_object+0xa/0x10
[  245.893406]  ? acpi_ps_delete_parse_tree+0x2d/0x59
[  245.897405]  __down_timeout+0x9b/0x100
[  245.901150]  down_timeout+0x43/0x50
[  245.905407]  acpi_os_wait_semaphore+0x48/0x60
[  245.909408]  acpi_ut_acquire_mutex+0x45/0x89
[  245.913406]  ? acpi_ns_init_one_package+0x44/0x44
[  245.917406]  acpi_walk_namespace+0x62/0xc2
[  245.921406]  acpi_ns_initialize_objects+0x40/0x7b
[  245.925407]  acpi_ex_load_table_op+0x157/0x1b9
[  245.933406]  acpi_ex_opcode_6A_0T_1R+0x158/0x1c2
[  245.937406]  acpi_ds_exec_end_op+0xca/0x401
[  245.941406]  acpi_ps_parse_loop+0x492/0x5c6
[  245.945406]  acpi_ps_parse_aml+0x91/0x2b8
[  245.949405]  acpi_ps_execute_method+0x15d/0x191
[  245.953406]  acpi_ns_evaluate+0x1bf/0x24c
[  245.957406]  acpi_evaluate_object+0x137/0x240
[  245.961408]  ? kmem_cache_alloc_trace+0x15b/0x1c0
[  245.965406]  acpi_processor_set_pdc+0x135/0x180
[  245.969408]  early_init_pdc+0xb3/0xd0
[  245.973064]  acpi_ns_walk_namespace+0xda/0x1aa
[  245.977407]  ? set_no_mwait+0x23/0x23
[  245.981062]  ? set_no_mwait+0x23/0x23
[  245.985406]  acpi_walk_namespace+0x9a/0xc2
[  245.989406]  ? acpi_sleep_proc_init+0x24/0x24
[  245.993407]  ? do_early_param+0x8e/0x8e
[  245.997235]  acpi_early_processor_set_pdc+0x31/0x49
[  246.001406]  acpi_init+0x17c/0x321


Thanks,

	tglx


