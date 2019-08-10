Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0593C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8470B2085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 17:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfHJRbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 13:31:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58304 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfHJRbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 13:31:55 -0400
Received: from p200300ddd71876237e7a91fffec98e25.dip0.t-ipconnect.de ([2003:dd:d718:7623:7e7a:91ff:fec9:8e25])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hwVDb-00076N-2q; Sat, 10 Aug 2019 19:31:51 +0200
Date:   Sat, 10 Aug 2019 19:31:45 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Linux 5.2.7] powertop --auto-tune: BUG: kernel NULL pointer
 dereference, address: 0000000000000000
In-Reply-To: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
Message-ID: <alpine.DEB.2.21.1908101910280.7324@nanos.tec.linutronix.de>
References: <4b54ff1e-f18b-3c58-7caa-945a0775c24c@molgen.mpg.de>
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

Paul,

On Sat, 10 Aug 2019, Paul Menzel wrote:
> 
> I have no idea, who to report this to, so I please refer me to the correct
> list.

I have no idea yet either :)

> With Linux 5.2.7 from Debian Sid/unstable and PowerTOP 2.10, executing
> 
>     sudo powertop --auto-tune
> 
> causes a NULL pointer dereference, and the graphical session crashes due to an
> effect on the i915 driver. It worked in the past with the 4.19 series from
> Debian.
> 
> Here is the trace, and please find all Linux kernel logs attached.
> 
> > [ 2027.170589] BUG: kernel NULL pointer dereference, address:
> > 0000000000000000
> > [ 2027.170600] #PF: supervisor instruction fetch in kernel mode
> > [ 2027.170604] #PF: error_code(0x0010) - not-present page
> > [ 2027.170609] PGD 0 P4D 0 [ 2027.170619] Oops: 0010 [#1] SMP PTI
...
> > [ 2027.170730]  do_dentry_open+0x13a/0x370

If you have compiled with debug info, please decode the line:

  linux/scripts/faddr2line vmlinux do_dentry_open+0x13a/0x370

That gives us the fops pointer which is NULL.

> > [ 2027.170745]  path_openat+0x2c6/0x1480
> > [ 2027.170757]  ? terminate_walk+0xe6/0x100
> > [ 2027.170767]  ? path_lookupat.isra.48+0xa3/0x220
> > [ 2027.170779]  ? reuse_swap_page+0x105/0x320
> > [ 2027.170791]  do_filp_open+0x93/0x100
> > [ 2027.170804]  ? __check_object_size+0x15d/0x189
> > [ 2027.170816]  do_sys_open+0x184/0x220
> > [ 2027.170828]  do_syscall_64+0x53/0x130
> > [ 2027.170837]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

That's an open crashing. We just don't know which file. Is the machine
completely hosed after that or is it just the graphics stuff dying?

If it's not completely dead then instead of running it from your graphical
desktop you could switch to a VGA terminal Alt+Ctrl+F1 (or whatever
function key your distro maps to) after boot and run powertop with strace
from there:

  strace -f -o xxx.log powertop

With a bit of luck xxx.log should contain the information about the file it
tries to open.

Alternatively if you have a serial console you can enable the
sys_enter_open* tracepoints:

# echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_open
# echo 1 >/sys/kernel/debug/tracing/events/syscalls/sys_enter_openat

Either add 'ftrace_dump_on_oops' to the kernel command line or enable it
from the shell:

# echo 1 > /proc/sys/kernel/ftrace_dump_on_oops

Then run powertop. After the crash it will take some time to spill out the
trace buffer over serial, but it will pinpoint the offending file.

Once we know which file it is, we also know who needs to stare at it :)

Thanks,

	tglx
