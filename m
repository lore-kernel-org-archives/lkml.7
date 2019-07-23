Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D00C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB6C20449
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 08:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mwx4bZpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbfGWIN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 04:13:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35010 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfGWIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 04:13:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so41091070qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2jzbejzQYrJlXytmyqSz1KqJGFktOF/25aPi43rrOlw=;
        b=Mwx4bZpcyp/DMMeRIYe82tU5xdCOk4EE9uqUTl2NomYYIIzzSh9eu1AVO0bSqxtlgm
         ZVjXCI0qUmH9XMVYx5bcnB28tpmOYoq9PAVRdX9dawuBp1t1eU+AWZq47+jvWcZTSyyW
         rw9GM/FGLd87GqL8gbn42To+SI7Rr/YR0ZcG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2jzbejzQYrJlXytmyqSz1KqJGFktOF/25aPi43rrOlw=;
        b=l09up9Du6pISPye3pjLoQvDwEmI7k1FDcmz6+5Or2HppEpY9D2DRBoK5PTUL/5Q7L6
         WtCdWAG6t+rB9vgKI9HQOzokJ/UR4HAVJDRURzNfa212xWzHyd4qVbLS3qapfIdVk3z2
         bIqu4AjS9bJXBGRsBBW6MLs8kla+71W6hdTAxcBwJRvd0g1hkn6N0BKAL3h/D7NNXgQE
         dwH2CBSyfUDlC0vmDxQODyRaFerUYS0puUk7lFdoV0ldLpyK059FOQ1WUdE/CMLlj5CN
         li42cJJdfCOGK9lYq4SN3JhPKdBILGRB07SAKPmbcASHnj09Z3Qq/OGKA1vMEX+RtGt/
         I4Vg==
X-Gm-Message-State: APjAAAViLIFpjblPPdqGWeWlyE3LFNw+Auib9AcPEoMOXl+6NzjofnK4
        jNERM4nhVxJvvjl4LH0dlwpDUnpB2gjJU7guMQekPg==
X-Google-Smtp-Source: APXvYqy007TgTEPieO77hNY32deYvDept57aZL4cbZs4Vqq1K+oJ72uDX9YCBX4RprUX4iONrn+rCz6Cr0RsqE7+Xd4=
X-Received: by 2002:a0c:d0b6:: with SMTP id z51mr53930428qvg.3.1563869637380;
 Tue, 23 Jul 2019 01:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190723072605.103456-1-drinkcat@chromium.org> <CACT4Y+bi5KkZ8igSeYVxjwtr8t0Vjz55gzWfAu_c8VMAqw0zPA@mail.gmail.com>
In-Reply-To: <CACT4Y+bi5KkZ8igSeYVxjwtr8t0Vjz55gzWfAu_c8VMAqw0zPA@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 23 Jul 2019 16:13:46 +0800
Message-ID: <CANMq1KB8ECeRqNhSWyUf3amAkF7qvAmS3aU6rGNnZ=kUV3LC5Q@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: Increase maximum early log entries to 1000000
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 3:46 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Jul 23, 2019 at 9:26 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > When KASan is enabled, a lot of memory is allocated early on,
> > and kmemleak complains (this is on a 4GB RAM system):
> > kmemleak: Early log buffer exceeded (129846), please increase
> >   DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> >
> > Let's increase the upper limit to 1M entry. That would take up
> > 160MB of RAM at init (each early_log entry is 160 bytes), but
> > the memory would later be freed (early_log is __initdata).
>
> Interesting. Is it on an arm64 system?

Yes arm64. And this is chromiumos-4.19 tree. I didn't try to track
down where these allocations come from...

Slightly redacted dmesg until the error message:
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] Linux version 4.19.59 (drinkcat@X) (Chromium OS
9.0_pre361749_p20190714-r2 clang version 9.0.0
(/var/cache/chromeos-cache/distfiles/host/egit-src/llvm-project
c11de5eada2decd0a495ea02676b6f4838cd54fb) (based on LLVM 9.0.0svn)) #7
SMP PREEMPT Tue Jul 23 16:00:50 CST 2019
[    0.000000] Machine model: XYZ
[    0.000000] Malformed early option 'console'
[    0.000000] Reserved memory: created DMA memory pool at
0x0000000050000000, size 41 MiB
[    0.000000] OF: reserved mem: initialized node scp_mem_region,
compatible id shared-dma-pool
[    0.000000] On node 0 totalpages: 1031920
[    0.000000]   DMA32 zone: 12288 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 769776 pages, LIFO batch:63
[    0.000000]   Normal zone: 4096 pages used for memmap
[    0.000000]   Normal zone: 262144 pages, LIFO batch:63
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] kasan: KernelAddressSanitizer initialized
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] random: get_random_bytes called from
start_kernel+0x8c/0x384 with crng_init=0
[    0.000000] percpu: Embedded 32 pages/cpu s92904 r8192 d29976 u131072
[    0.000000] pcpu-alloc: s92904 r8192 d29976 u131072 alloc=32*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Speculative Store Bypass Disable mitigation not required
[    0.000000] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1015536
[    0.000000] Kernel command line: cros_secure cros_secure console=
loglevel=7 init=/sbin/init cros_secure
root=PARTUUID=45e54c6a-06a8-374c-a934-a07e23b37225/PARTNROFF=1
rootwait rw dm_verity.error_behavior=3 dm_verity.max_bios=-1
dm_verity.dev_wait=0 dm="1 vroot none ro 1,0 4710400 verity
payload=ROOT_DEV hashtree=HASH_DEV hashstart=4710400 alg=sha256
root_hexdigest=443fe95947f3b3f3cb54a10a53a4c7bb600ea1dd26d002066821236efa2419f4
salt=ba17ba7736672036f119b0c925aa43e10ae1a960591a5b8bc85b21c166a49132"
noinitrd cros_debug vt.global_cursor_default=0
kern_guid=45e54c6a-06a8-374c-a934-a07e23b37225
[    0.000000] device-mapper: init: will configure 1 devices
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] software IO TLB: mapped [mem 0xfbdff000-0xffdff000] (64MB)
[    0.000000] Memory: 3439892K/4127680K available (9726K kernel code,
1106K rwdata, 3064K rodata, 4096K init, 8893K bss, 687788K reserved,
0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
[    0.000000] ftrace: allocating 34965 entries in 137 pages
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000]  Tasks RCU enabled.
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: no VLPI support, no direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000000c100000
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-0[0] {
/cpus/cpu@0[0] /cpus/cpu@1[1] /cpus/cpu@2[2] /cpus/cpu@3[3] }
[    0.000000] GICv3: GIC: PPI partition interrupt-partition-1[1] {
/cpus/cpu@100[4] /cpus/cpu@101[5] /cpus/cpu@102[6] /cpus/cpu@103[7] }
[    0.000000] arch_timer: cp15 timer(s) running at 13.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x2ff89eacb, max_idle_ns: 440795202429 ns
[    0.000003] sched_clock: 56 bits at 13MHz, resolution 76ns, wraps
every 4398046511101ns
[    0.000441] kmemleak: Early log buffer exceeded (131217), please
increase DEBUG_KMEMLEAK_EARLY_LOG_SIZE

> On syzbot we use 16000 and it's
> enough for a very beefy config:
>
> https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-leak.config
>
> If it's freed later, I would increase the default as well.

Sure I can do that as part of a v2, at least to 16K, maybe more if we
have no reason to believe there is another issue with my
configuration.

> 400 never
> worked for me and I've seen people being confused and wasn't able to
> use kmemleak, e.g.:
>
> https://groups.google.com/forum/#!searchin/syzkaller/CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE|sort:date/syzkaller/Rzf2ZRC9Qxw/tLog4DHXAgAJ
>
> https://groups.google.com/forum/#!searchin/syzkaller/CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE|sort:date/syzkaller/5HxmTuQ7U4A/XM8s2o2CCAAJ
>
>
>
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >  lib/Kconfig.debug | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index f567875b87657de..1a197b8125768b9 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -595,7 +595,7 @@ config DEBUG_KMEMLEAK
> >  config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
> >         int "Maximum kmemleak early log entries"
> >         depends on DEBUG_KMEMLEAK
> > -       range 200 40000
> > +       range 200 1000000
> >         default 400
> >         help
> >           Kmemleak must track all the memory allocations to avoid
> > --
> > 2.22.0.657.g960e92d24f-goog
> >
