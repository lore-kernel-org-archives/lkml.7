Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805F4C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357622054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbAiodWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfE1Nj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:39:29 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45558 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfE1Nj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:39:28 -0400
Received: by mail-yw1-f68.google.com with SMTP id w18so7888144ywa.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=npWVNyU4XzqpgEVyzrHSmAkNy3a3CDHa2XgNfiKTVdM=;
        b=RbAiodWpFzdn8X/tL+1PI80d0C/oVFXz+yhjHIddUX423GPLp3Bx//+lk9swNi2k+/
         rD0ShwNVwJaeSPTzIW0Ofjy3yq3USWfQXQ9v+VQLsqqoAmOQxFoCRDKBD5vSJpEOXsiY
         2HUaXo5KvZHXbMoUBGXlk8v3qW+Opk+/DkurxnRl1EnVSTCfBn+BmRc0s9tjlOgLZAcr
         zs7JKm1ysmJKjuppodqvTTCMEnusOltdLttIHsvANIJEhXLo8MJAWgmEDqnK76RgnVw+
         GkyMbe73BXmaSG5r8NVPj/uQg3X9UeJJb0ptx0fwylbFkPWxvglccb0VF1ink0sIw0M5
         6mcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=npWVNyU4XzqpgEVyzrHSmAkNy3a3CDHa2XgNfiKTVdM=;
        b=tB4dWcM7snUhQkSa3uf0kyx8QnDxSK/B0SFBUeS4VMcdY0UYE1oesv5j3pVMeuJVY9
         ZByf3A7kr8QCYYKb4l3GMeUwZhGE0oo/lwsQTdFjvBcDgV2GZh+si3pomjiEWSuTASx+
         9gB2ZfH0A8NM7hH565q5NVz+GmlWadDfhH08Ys1FsFl3tlOm/0VqghmoGhllE45ahDDh
         GQLsAL4zzpf3gMHgjXYqiyHrJ+C87NHSmFifD7AIcE9W7qnvJTOeteqM06DhiYIbc+hC
         d4FYX3KRvTiotmvNsNCV3SsGDnXPoIoJeNzyxbJS2zJiXZiZhwJd9fOTA45z6bjce6Ba
         lwlg==
X-Gm-Message-State: APjAAAVM9vCSyyEfYHGnwpsVdnQDaUCDI5uz3b3esGkfAMf9hGekgDUA
        VmzmXKywzGM7F3AcETdfKSofkOFws/qnB2fnFiQXAiapZ5VskA==
X-Google-Smtp-Source: APXvYqwYqv19eD6Fwoa0grN6EiGM7V6a/NInz2SowiJU3/o3NH25scKs11v9cDnG6CkRzNBZQwEsy+0DIB6ve63tBMw=
X-Received: by 2002:a81:374a:: with SMTP id e71mr57790580ywa.405.1559050766863;
 Tue, 28 May 2019 06:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <155851393823.15728.9489409117921369593.stgit@devnote2>
 <155851395498.15728.830529496248543583.stgit@devnote2> <CADYN=9KHQPQTgy==TYZ5iD_zViPbHq4hgOUwuX69aQWV6vZOQg@mail.gmail.com>
 <20190528083629.3c100256@gandalf.local.home>
In-Reply-To: <20190528083629.3c100256@gandalf.local.home>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 28 May 2019 15:39:15 +0200
Message-ID: <CADYN=9L2Lz9xgsP7jn3UNMOtAYtg6fAb1hbv=OJ_Xi4dA0Z5NQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tracing/kprobe: Add kprobe_event= boot parameter
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019 at 14:36, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 28 May 2019 14:23:43 +0200
> Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > On Wed, 22 May 2019 at 10:32, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >
> > > Add kprobe_event= boot parameter to define kprobe events
> > > at boot time.
> > > The definition syntax is similar to tracefs/kprobe_events
> > > interface, but use ',' and ';' instead of ' ' and '\n'
> > > respectively. e.g.
> > >
> > >   kprobe_event=p,vfs_read,$arg1,$arg2
> > >
> > > This puts a probe on vfs_read with argument1 and 2, and
> > > enable the new event.
> > >
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > I built an arm64 kernel from todays linux-next tag next-20190528 and
> > ran in to this issue when I booted it up in qemu:
> >
>
> This is partial output from the crash. There should be more output
> before this that says what happened to cause the crash.

Oh I'm sorry.

Here is the full output

[    0.000000][    T0] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000][    T0] Linux version
5.2.0-rc2-next-20190528-00019-g9a6008710716 (anders@compilator) (gcc
version 8.3.0 (Debian 8.3.0-2)) #8 SMP PREEMPT Tue May 28 11:47:57
CEST 2019
[    0.000000][    T0] Machine model: linux,dummy-virt
[    0.000000][    T0] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000][    T0] printk: bootconsole [pl11] enabled
[    0.000000][    T0] efi: Getting EFI parameters from FDT:
[    0.000000][    T0] efi: UEFI not found.
[    0.000000][    T0] cma: Reserved 32 MiB at 0x00000000be000000
[    0.000000][    T0] kmemleak: Kernel memory leak detector disabled
[    0.000000][    T0] NUMA: No NUMA configuration found
[    0.000000][    T0] NUMA: Faking a node at [mem
0x0000000040000000-0x00000000bfffffff]
[    0.000000][    T0] NUMA: NODE_DATA [mem 0xbdbfd480-0xbdbfefff]
[    0.000000][    T0] Zone ranges:
[    0.000000][    T0]   DMA32    [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000][    T0]   Normal   empty
[    0.000000][    T0] Movable zone start for each node
[    0.000000][    T0] Early memory node ranges
[    0.000000][    T0]   node   0: [mem 0x0000000040000000-0x00000000bfffffff]
[    0.000000][    T0] Initmem setup node 0 [mem
0x0000000040000000-0x00000000bfffffff]
[    0.000000][    T0] kasan: KernelAddressSanitizer initialized
[    0.000000][    T0] psci: probing for conduit method from DT.
[    0.000000][    T0] psci: PSCIv1.0 detected in firmware.
[    0.000000][    T0] psci: Using standard PSCI v0.2 function IDs
[    0.000000][    T0] psci: Trusted OS migration not required
[    0.000000][    T0] psci: SMC Calling Convention v1.1
[    0.000000][    T0] percpu: Embedded 505 pages/cpu s2030744 r8192
d29544 u2068480
[    0.000000][    T0] Detected VIPT I-cache on CPU0
[    0.000000][    T0] CPU features: detected: ARM erratum 845719
[    0.000000][    T0] CPU features: GIC system register CPU interface
present but disabled by higher exception level
[    0.000000][    T0] node[0] zonelist: 0:DMA32
[    0.000000][    T0] Built 1 zonelists, mobility grouping on.  Total
pages: 516096
[    0.000000][    T0] Policy zone: DMA32
[    0.000000][    T0] Kernel command line: root=/dev/root
rootfstype=9p rootflags=trans=virtio console=ttyAMA0,38400n8
earlycon=pl011,0x9000000 initcall_debug softlockup_panic=0
security=none
[    0.000000][    T0] Memory: 942464K/2097152K available (33532K
kernel code, 24756K rwdata, 16956K rodata, 6144K init, 22215K bss,
420912K reserved, 32768K cma-reserved)
[    0.000000][    T0] random: get_random_u64 called from
kmem_cache_open+0x2c/0x580 with crng_init=0
[    0.000000][    T0] random: get_random_u64 called from
cache_random_seq_create+0x6c/0x1a8 with crng_init=0
[    0.000000][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0,
CPUs=1, Nodes=1
[    0.000000][    T0] random: get_random_u64 called from
kmem_cache_open+0x2c/0x580 with crng_init=0
[    0.000000][    T0] ODEBUG: selftest passed
[    0.000000][    T0] Running RCU self tests
[    0.000000][    T0] rcu: Preemptible hierarchical RCU implementation.
[    0.000000][    T0] rcu:     RCU event tracing is enabled.
[    0.000000][    T0] rcu:     RCU dyntick-idle grace-period
acceleration is enabled.
[    0.000000][    T0] rcu:     RCU lockdep checking is enabled.
[    0.000000][    T0] rcu:     RCU restricting CPUs from NR_CPUS=256
to nr_cpu_ids=1.
[    0.000000][    T0] rcu:     RCU priority boosting: priority 1 delay 500 ms.
[    0.000000][    T0] rcu:     RCU callback double-/use-after-free
debug enabled.
[    0.000000][    T0] rcu:     RCU debug extended QS entry/exit.
[    0.000000][    T0]  Tasks RCU enabled.
[    0.000000][    T0] rcu: RCU calculated value of
scheduler-enlistment delay is 25 jiffies.
[    0.000000][    T0] rcu: Adjusting geometry for rcu_fanout_leaf=16,
nr_cpu_ids=1
[    0.000000][    T0] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000][    T0] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
[    0.000000][    T0] arch_timer: cp15 timer(s) running at 100.00MHz (virt).
[    0.000000][    T0] clocksource: arch_sys_counter: mask:
0xffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315
ns
[    0.000041][    T0] sched_clock: 56 bits at 100MHz, resolution
10ns, wraps every 4398046511100ns
[    0.007303][    T0] Console: colour dummy device 80x25
[    0.012458][    T0] Lock dependency validator: Copyright (c) 2006
Red Hat, Inc., Ingo Molnar
[    0.016254][    T0] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.018260][    T0] ... MAX_LOCK_DEPTH:          48
[    0.020472][    T0] ... MAX_LOCKDEP_KEYS:        8191
[    0.022584][    T0] ... CLASSHASH_SIZE:          4096
[    0.024891][    T0] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.027089][    T0] ... MAX_LOCKDEP_CHAINS:      65536
[    0.029532][    T0] ... CHAINHASH_SIZE:          32768
[    0.031812][    T0]  memory used by lock dependency info: 6747 kB
[    0.034789][    T0]  per task-struct memory footprint: 2688 bytes
[    0.037446][    T0] ------------------------
[    0.039583][    T0] | Locking API testsuite:
[    0.041539][    T0]
----------------------------------------------------------------------------
[    0.045659][    T0]                                  | spin |wlock
|rlock |mutex | wsem | rsem |
[    0.049470][    T0]
--------------------------------------------------------------------------
[    0.053770][    T0]                      A-A deadlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.175649][    T0]                  A-B-B-A deadlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.304904][    T0]              A-B-B-C-C-A deadlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.441305][    T0]              A-B-C-A-B-C deadlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.577838][    T0]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.721811][    T0]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    0.866090][    T0]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.009999][    T0]                     double unlock:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.131550][    T0]                   initialize held:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |
[    1.250065][    T0]
--------------------------------------------------------------------------
[    1.254034][    T0]               recursive read-lock:
|  ok  |             |  ok  |
[    1.292322][    T0]            recursive read-lock #2:
|  ok  |             |  ok  |
[    1.329570][    T0]             mixed read-write-lock:
|  ok  |             |  ok  |
[    1.366837][    T0]             mixed write-read-lock:
|  ok  |             |  ok  |
[    1.404193][    T0]   mixed read-lock/lock-write ABBA:
|FAILED|             |  ok  |
[    1.440046][    T0]    mixed read-lock/lock-read ABBA:
|  ok  |             |  ok  |
[    1.479427][    T0]  mixed write-lock/lock-write ABBA:
|  ok  |             |  ok  |
[    1.518841][    T0]
--------------------------------------------------------------------------
[    1.526367][    T0]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    1.579733][    T0]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[    1.633140][    T0]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    1.686438][    T0]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[    1.739858][    T0]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[    1.793336][    T0]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[    1.846724][    T0]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    1.900131][    T0]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[    1.953611][    T0]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    2.007020][    T0]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[    2.060514][    T0]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    2.117068][    T0]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[    2.173630][    T0]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    2.230160][    T0]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[    2.286732][    T0]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    2.343298][    T0]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[    2.399899][    T0]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    2.456366][    T0]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[    2.512893][    T0]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    2.567341][    T0]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[    2.621874][    T0]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    2.678319][    T0]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[    2.734909][    T0]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    2.793422][    T0]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[    2.850039][    T0]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    2.906635][    T0]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[    2.963319][    T0]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    3.019876][    T0]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[    3.076494][    T0]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    3.133040][    T0]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[    3.189646][    T0]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    3.246206][    T0]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[    3.302881][    T0]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    3.359434][    T0]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[    3.416138][    T0]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    3.472719][    T0]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[    3.529397][    T0]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    3.585922][    T0]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[    3.642564][    T0]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    3.699083][    T0]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[    3.755762][    T0]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    3.812295][    T0]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[    3.868913][    T0]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    3.925502][    T0]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[    3.982216][    T0]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    4.038836][    T0]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[    4.095484][    T0]       hard-irq read-recursion/123:  ok  |
[    4.115858][    T0]       soft-irq read-recursion/123:  ok  |
[    4.136275][    T0]       hard-irq read-recursion/132:  ok  |
[    4.156655][    T0]       soft-irq read-recursion/132:  ok  |
[    4.177108][    T0]       hard-irq read-recursion/213:  ok  |
[    4.197524][    T0]       soft-irq read-recursion/213:  ok  |
[    4.217951][    T0]       hard-irq read-recursion/231:  ok  |
[    4.238361][    T0]       soft-irq read-recursion/231:  ok  |
[    4.258769][    T0]       hard-irq read-recursion/312:  ok  |
[    4.279146][    T0]       soft-irq read-recursion/312:  ok  |
[    4.299601][    T0]       hard-irq read-recursion/321:  ok  |
[    4.320000][    T0]       soft-irq read-recursion/321:  ok  |
[    4.340415][    T0]
--------------------------------------------------------------------------
[    4.344302][    T0]   | Wound/wait tests |
[    4.346060][    T0]   ---------------------
[    4.347804][    T0]                   ww api failures:  ok  |  ok  |  ok  |
[    4.403866][    T0]                ww contexts mixing:  ok  |  ok  |
[    4.441325][    T0]              finishing ww context:  ok  |  ok
|  ok  |  ok  |
[    4.513923][    T0]                locking mismatches:  ok  |  ok  |  ok  |
[    4.569425][    T0]                  EDEADLK handling:  ok  |  ok
|  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
[    4.756084][    T0]            spinlock nest unlocked:  ok  |
[    4.775442][    T0]   -----------------------------------------------------
[    4.778554][    T0]                                  |block | try  |context|
[    4.781423][    T0]   -----------------------------------------------------
[    4.784561][    T0]                           context:  ok  |  ok  |  ok  |
[    4.841364][    T0]                               try:  ok  |  ok  |  ok  |
[    4.895896][    T0]                             block:  ok  |  ok  |  ok  |
[    4.950507][    T0]                          spinlock:  ok  |  ok  |  ok  |
[    5.008309][    T0] -------------------------------------------------------
[    5.011499][    T0] Good, all 261 testcases passed! |
[    5.013625][    T0] ---------------------------------
[    5.016475][    T0] _warn_unseeded_randomness: 17 callbacks suppressed
[    5.016589][    T0] random: get_random_u64 called from
kmem_cache_open+0x2c/0x580 with crng_init=0
[    5.023654][    T0] random: get_random_u64 called from
cache_random_seq_create+0x6c/0x1a8 with crng_init=0
[    5.028321][    T0] random: get_random_u64 called from
kmem_cache_open+0x2c/0x580 with crng_init=0
[    5.033170][    T0] Calibrating delay loop (skipped), value
calculated using timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    5.038026][    T0] pid_max: default: 32768 minimum: 301
[    5.048372][    T0] LSM: Security Framework initializing
[    5.051427][    T0] Yama: becoming mindful.
[    5.054542][    T0] LoadPin: ready to pin (currently enforcing)
[    5.091650][    T0] Dentry cache hash table entries: 262144 (order:
9, 2097152 bytes)
[    5.109677][    T0] Inode-cache hash table entries: 131072 (order:
8, 1048576 bytes)
[    5.115043][    T0] Mount-cache hash table entries: 4096 (order: 3,
32768 bytes)
[    5.119102][    T0] Mountpoint-cache hash table entries: 4096
(order: 3, 32768 bytes)
[    5.145756][    T0] *** VALIDATE proc ***
[    5.161518][    T0] *** VALIDATE cgroup1 ***
[    5.163416][    T0] *** VALIDATE cgroup2 ***
[    5.216366][    T1] ASID allocator initialised with 32768 entries
[    5.233346][    T1] rcu: Hierarchical SRCU implementation.
[    5.355951][    T1] EFI services will not be available.
[    5.390252][    T1] smp: Bringing up secondary CPUs ...
[    5.392549][    T1] smp: Brought up 1 node, 1 CPU
[    5.395021][    T1] SMP: Total of 1 processors activated.
[    5.397323][    T1] CPU features: detected: 32-bit EL0 Support
[    5.400043][    T1] CPU features: detected: CRC32 instructions
[    5.453529][    T1] CPU features: emulated: Privileged Access Never
(PAN) using TTBR0_EL1 switching
[    5.457701][    T1] CPU: All CPU(s) started at EL1
[    5.459924][   T13] alternatives: patching kernel code
[    7.488419][   T17] node 0 initialised, 175252 pages in 4ms
[    7.498797][   T17] pgdatinit0 (17) used greatest stack depth:
29312 bytes left
[    7.622979][    T1] devtmpfs: initialized
[    7.875584][    T1] Registered cp15_barrier emulation handler
[    7.878291][    T1] Registered setend emulation handler
[    7.885484][    T1] workqueue: round-robin CPU selection forced,
expect performance impact
[    7.921303][   T21] kworker/u2:0 (21) used greatest stack depth:
26864 bytes left
[    8.098703][    T1] DMA-API: preallocated 65536 debug entries
[    8.101639][    T1] DMA-API: debugging enabled by kernel config
[    8.104431][    T1] clocksource: jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    8.110343][    T1] futex hash table entries: 256 (order: 3, 32768 bytes)
[    8.315582][    T1] _warn_unseeded_randomness: 73 callbacks suppressed
[    8.315680][    T1] random: get_random_u64 called from
kmem_cache_open+0x2c/0x580 with crng_init=0
[    8.322746][    T1] random: get_random_u64 called from
cache_random_seq_create+0x6c/0x1a8 with crng_init=0
[    8.328032][    T1] random: get_random_u64 called from
kmem_cache_open+0x2c/0x580 with crng_init=0
[    8.342773][    T1] prandom: seed boundary self test passed
[    8.362169][    T1] prandom: 100 self tests passed
[    8.370915][    T1] pinctrl core: initialized pinctrl subsystem
[    8.429194][   T26] kworker/u2:1 (26) used greatest stack depth:
26320 bytes left
[    8.495363][   T32] kworker/u2:1 (32) used greatest stack depth:
26272 bytes left
[    8.743241][    T1]
[    8.750192][    T1]
*************************************************************
[    8.760037][    T1] **     NOTICE NOTICE NOTICE NOTICE NOTICE
NOTICE NOTICE    **
[    8.764666][    T1] **
           **
[    8.769961][    T1] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN
THIS KERNEL  **
[    8.774188][    T1] **
           **
[    8.777236][    T1] ** This means that this kernel is built to
expose internal **
[    8.782049][    T1] ** IOMMU data structures, which may compromise
security on **
[    8.786179][    T1] ** your system.
           **
[    8.789225][    T1] **
           **
[    8.793520][    T1] ** If you see this message and you are not
debugging the   **
[    8.796556][    T1] ** kernel, report this immediately to your
vendor!         **
[    8.801025][    T1] **
           **
[    8.804360][    T1] **     NOTICE NOTICE NOTICE NOTICE NOTICE
NOTICE NOTICE    **
[    8.807379][    T1]
*************************************************************
[    8.880289][    T1] DMI not present or invalid.
[    8.945156][    T1] NET: Registered protocol family 16
[    8.965688][    T1] audit: initializing netlink subsys (disabled)
[    8.977767][   T57] audit: type=2000 audit(2.960:1):
state=initialized audit_enabled=0 res=1
[    9.020354][    T1] Kprobe smoke test: started
[    9.064132][    T1] Internal error: aarch64 BRK: f2000004 [#1] PREEMPT SMP
[    9.067084][    T1] Modules linked in:
[    9.068772][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.2.0-rc2-next-20190528-00019-g9a6008710716 #8
[    9.072893][    T1] Hardware name: linux,dummy-virt (DT)
[    9.075143][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
[    9.077528][    T1] pc : kprobe_target+0x0/0x30
[    9.079479][    T1] lr : init_test_probes+0x134/0x540
[    9.081611][    T1] sp : ffff80003f51fbe0
[    9.083331][    T1] x29: ffff80003f51fbe0 x28: ffff200013c17820
[    9.085906][    T1] x27: ffff200015d3ab40 x26: ffff2000122bb120
[    9.088491][    T1] x25: 0000000000000000 x24: ffff200013c08ae0
[    9.091068][    T1] x23: ffff200015d39000 x22: ffff200013a15ac8
[    9.093667][    T1] x21: 1ffff00007ea3f86 x20: ffff200015d39420
[    9.096214][    T1] x19: ffff2000122bad20 x18: 0000000000001400
[    9.098831][    T1] x17: 0000000000000000 x16: ffff80003f510040
[    9.101410][    T1] x15: 0000000000001480 x14: 1ffff00007ea3ea2
[    9.103963][    T1] x13: 00000000f1f1f1f1 x12: ffff040002782e0d
[    9.106549][    T1] x11: 1fffe40002782e0c x10: ffff040002782e0c
[    9.109120][    T1] x9 : 1fffe40002782e0c x8 : dfff200000000000
[    9.111676][    T1] x7 : ffff040002782e0d x6 : ffff200013c17067
[    9.114234][    T1] x5 : ffff80003f510040 x4 : 0000000000000000
[    9.116843][    T1] x3 : ffff200010427508 x2 : 0000000000000000
[    9.119409][    T1] x1 : ffff200010426e10 x0 : 0000000000a6326b
[    9.121980][    T1] Call trace:
[    9.123380][    T1]  kprobe_target+0x0/0x30
[    9.125205][    T1]  init_kprobes+0x2b8/0x300
[    9.127074][    T1]  do_one_initcall+0x4c0/0xa68
[    9.129076][    T1]  kernel_init_freeable+0x3c4/0x4e4
[    9.131234][    T1]  kernel_init+0x14/0x1fc
[    9.133032][    T1]  ret_from_fork+0x10/0x18
[    9.134908][    T1] Code: a9446bf9 f9402bfb a8d87bfd d65f03c0 (d4200080)
[    9.137845][    T1] ---[ end trace 49243ee03446b072 ]---
[    9.140114][    T1] Kernel panic - not syncing: Fatal exception
[    9.142684][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---


Cheers,
Anders

>
> -- Steve
>
>
> > [    9.068772][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > 5.2.0-rc2-next-20190528-00019-g9a6008710716 #8
> > [    9.072893][    T1] Hardware name: linux,dummy-virt (DT)
> > [    9.075143][    T1] pstate: 80400005 (Nzcv daif +PAN -UAO)
> > [    9.077528][    T1] pc : kprobe_target+0x0/0x30
> > [    9.079479][    T1] lr : init_test_probes+0x134/0x540
> > [    9.081611][    T1] sp : ffff80003f51fbe0
> > [    9.083331][    T1] x29: ffff80003f51fbe0 x28: ffff200013c17820
> > [    9.085906][    T1] x27: ffff200015d3ab40 x26: ffff2000122bb120
> > [    9.088491][    T1] x25: 0000000000000000 x24: ffff200013c08ae0
> > [    9.091068][    T1] x23: ffff200015d39000 x22: ffff200013a15ac8
> > [    9.093667][    T1] x21: 1ffff00007ea3f86 x20: ffff200015d39420
> > [    9.096214][    T1] x19: ffff2000122bad20 x18: 0000000000001400
> > [    9.098831][    T1] x17: 0000000000000000 x16: ffff80003f510040
> > [    9.101410][    T1] x15: 0000000000001480 x14: 1ffff00007ea3ea2
> > [    9.103963][    T1] x13: 00000000f1f1f1f1 x12: ffff040002782e0d
> > [    9.106549][    T1] x11: 1fffe40002782e0c x10: ffff040002782e0c
> > [    9.109120][    T1] x9 : 1fffe40002782e0c x8 : dfff200000000000
> > [    9.111676][    T1] x7 : ffff040002782e0d x6 : ffff200013c17067
> > [    9.114234][    T1] x5 : ffff80003f510040 x4 : 0000000000000000
> > [    9.116843][    T1] x3 : ffff200010427508 x2 : 0000000000000000
> > [    9.119409][    T1] x1 : ffff200010426e10 x0 : 0000000000a6326b
> > [    9.121980][    T1] Call trace:
> > [    9.123380][    T1]  kprobe_target+0x0/0x30
> > [    9.125205][    T1]  init_kprobes+0x2b8/0x300
> > [    9.127074][    T1]  do_one_initcall+0x4c0/0xa68
> > [    9.129076][    T1]  kernel_init_freeable+0x3c4/0x4e4
> > [    9.131234][    T1]  kernel_init+0x14/0x1fc
> > [    9.133032][    T1]  ret_from_fork+0x10/0x18
> > [    9.134908][    T1] Code: a9446bf9 f9402bfb a8d87bfd d65f03c0 (d4200080)
> > [    9.137845][    T1] ---[ end trace 49243ee03446b072 ]---
> > [    9.140114][    T1] Kernel panic - not syncing: Fatal exception
> > [    9.142684][    T1] ---[ end Kernel panic - not syncing: Fatal exception ]---
> >
> > I bisected down to this commit as the one that introduces this issue.
> > I'm unsure why this causes the call trace though, any ideas?
> >
> > Cheers,
> > Anders
>
