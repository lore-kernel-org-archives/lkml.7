Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA234C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CF9206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 22:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7B8lQY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfILWqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 18:46:03 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44229 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfILWqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 18:46:03 -0400
Received: by mail-pl1-f182.google.com with SMTP id k1so12389918pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 15:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7OdZ21QdmXaiQoeot7FRn3EJRksBwa1NFZNghyXnJU=;
        b=d7B8lQY5JczgUzTW77ME1txH6r+t3jAk3OoDCHnDdoIKJNFuC9AYI21hEWzTicf9CQ
         viWthnk+yb21BeAxn6CyOu/KR617DrQAUpYNGHBrsnLwbXRS9Q/lAz4Kwn2D7GFUJXHe
         WyWywKjkBkYSOt9AwCE7lWYZ7caAYklsvji5Kb+e6J4AsBAcykAKxDCRLoyW3kCE2VVq
         waw5jV/CcEZJBBW9sTrKJdbkYmh0b/Q/2RzcSOjPOJhIB5AtlKXKEubRdW+Qqq4zCaRc
         YvH7EoMPxRY4PPouvQv3g2V1xxZkvjpAm0Uob3oMVHOkSZSXjhAO7746rDZ/sEkJ/W+S
         XTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7OdZ21QdmXaiQoeot7FRn3EJRksBwa1NFZNghyXnJU=;
        b=Z7zR4XnWIyBHL+AUABy/T8dNgg6Ejq5vyheCPlxGPGEmWsQCxppCGtG4Khri4em9Rb
         VAQnqUfAJSVnH0z/m/2Dis9DLS6bjncSMqR1bgmyoQJKrPhiZAUtJEp/LqQMsvRPHqcq
         IbOb5l/+Hqku4vTebYnYSx2HFnzDhQtGbP3Vzudg4rGKWAw+VvbsSTt5oQU68dxyHRm9
         HKbj43nbfrFAfRRr8Fpb1vVIlC1cs/bK0nUJNQv2yrVE36UH5JanGQRw3f+Ve7nxhoPg
         OVLVQa+Lcj34My17q5esziHBQrD+5eRMwY47+FHNR15MCOk96KhY58oW1QY2wp7vOKX+
         cp/w==
X-Gm-Message-State: APjAAAUSkmLbg9IDsj1vSJUhsFFOQ/4RkY9LZuWHC7+hh/r0SSPGuc3r
        shbS6vzvIdxEi+SbQwzHcUWCOLHzhg1WqWl6GGPJDw==
X-Google-Smtp-Source: APXvYqyScKcNr6RUHYonFGLjTcEM/wLCjO4DlqOdfyGmz+oskX65iNMLrc+YHKTuXgG/7IWuyB7oM2Z8MUDCOs5+DpY=
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr24029479plz.119.1568328362027;
 Thu, 12 Sep 2019 15:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <7ef58eb00bc46b4ea3fe49a8c45cd2ff06292247.camel@perches.com>
In-Reply-To: <7ef58eb00bc46b4ea3fe49a8c45cd2ff06292247.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Sep 2019 15:45:50 -0700
Message-ID: <CAKwvOdn6bMGZFAwH8iS5xD+Ce7oV8U6Fgi_SrFpCjo2-1hEUrw@mail.gmail.com>
Subject: Re: [rfc patch script] treewide conversion of __section(foo) to section("foo");
To:     Joe Perches <joe@perches.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 8, 2019 at 9:21 PM Joe Perches <joe@perches.com> wrote:
<snip>
> So running the script:
>
> $ perl section.pl
>
> produces a commit
> ---
> From 04e52f34fd4ee7008ea5bf0d8896bf8d1fdf9f3f Mon Sep 17 00:00:00 2001
> Message-Id: <04e52f34fd4ee7008ea5bf0d8896bf8d1fdf9f3f.1568001863.git.joe@perches.com>
> From: Joe Perches <joe@perches.com>
> Date: Sun, 8 Sep 2019 20:53:41 -0700
> Subject: [PATCH] treewide: Convert macro and uses of __section(foo) to
>  __section("foo")
>
> Use a more generic form for __section that requires quotes to avoid
> complications with clang and gcc differences.
>
> Remove the quote operator # from compiler_attributes.h __section macro.
>
> Convert all unquoted __section(foo) uses to quoted __section("foo").
> Also convert __attribute__((section("foo"))) uses to __section("foo")
> even if the __attribute__ has multiple list entry forms.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/arc/include/asm/linkage.h                    |  8 +++---
>  arch/arc/include/asm/mach_desc.h                  |  2 +-
>  arch/arc/plat-hsdk/platform.c                     |  2 +-
>  arch/arm/include/asm/cache.h                      |  2 +-
>  arch/arm/include/asm/cpuidle.h                    |  2 +-
>  arch/arm/include/asm/idmap.h                      |  2 +-
>  arch/arm/include/asm/kvm_hyp.h                    |  2 +-
>  arch/arm/include/asm/mach/arch.h                  |  4 +--
>  arch/arm/include/asm/setup.h                      |  2 +-
>  arch/arm/include/asm/smp.h                        |  2 +-
>  arch/arm/include/asm/tcm.h                        |  8 +++---
>  arch/arm/kernel/cpuidle.c                         |  2 +-
>  arch/arm/kernel/devtree.c                         |  2 +-
>  arch/arm64/include/asm/cache.h                    |  2 +-
>  arch/arm64/include/asm/exception.h                |  2 +-
>  arch/arm64/include/asm/kvm_hyp.h                  |  2 +-
>  arch/arm64/kernel/efi.c                           |  2 +-
>  arch/arm64/kernel/smp_spin_table.c                |  2 +-
>  arch/ia64/include/asm/cache.h                     |  2 +-
>  arch/microblaze/kernel/setup.c                    |  2 +-
>  arch/mips/include/asm/cache.h                     |  2 +-
>  arch/mips/include/asm/mach-pmcs-msp71xx/msp_pci.h |  4 +--
>  arch/mips/include/asm/machine.h                   |  2 +-
>  arch/mips/include/asm/mips_machine.h              |  2 +-
>  arch/mips/kernel/setup.c                          |  2 +-
>  arch/mips/mm/init.c                               |  2 +-
>  arch/parisc/include/asm/cache.h                   |  2 +-
>  arch/parisc/include/asm/ldcw.h                    |  2 +-
>  arch/parisc/kernel/ftrace.c                       |  2 +-
>  arch/parisc/mm/init.c                             |  6 ++--
>  arch/powerpc/boot/main.c                          |  2 +-
>  arch/powerpc/boot/ps3.c                           |  2 +-
>  arch/powerpc/include/asm/cache.h                  |  2 +-
>  arch/powerpc/include/asm/machdep.h                |  2 +-
>  arch/powerpc/kernel/btext.c                       |  2 +-
>  arch/powerpc/kernel/prom_init.c                   |  2 +-
>  arch/powerpc/kvm/book3s_64_vio_hv.c               |  2 +-
>  arch/s390/boot/compressed/decompressor.c          |  2 +-
>  arch/s390/boot/ipl_parm.c                         |  4 +--
>  arch/s390/boot/startup.c                          |  2 +-
>  arch/s390/include/asm/cache.h                     |  2 +-
>  arch/s390/include/asm/sections.h                  |  4 +--
>  arch/s390/kernel/setup.c                          |  2 +-
>  arch/s390/mm/init.c                               |  2 +-
>  arch/sh/boards/of-generic.c                       |  2 +-
>  arch/sh/include/asm/cache.h                       |  2 +-
>  arch/sh/include/asm/machvec.h                     |  2 +-
>  arch/sh/include/asm/smp.h                         |  2 +-
>  arch/sparc/include/asm/cache.h                    |  2 +-
>  arch/sparc/kernel/btext.c                         |  2 +-
>  arch/um/include/shared/init.h                     | 22 +++++++--------
>  arch/um/kernel/skas/clone.c                       |  2 +-
>  arch/um/kernel/um_arch.c                          |  2 +-
>  arch/x86/boot/compressed/pgtable_64.c             |  2 +-
>  arch/x86/boot/tty.c                               |  8 +++---
>  arch/x86/boot/video.h                             |  2 +-
>  arch/x86/include/asm/apic.h                       |  4 +--
>  arch/x86/include/asm/cache.h                      |  2 +-
>  arch/x86/include/asm/intel-mid.h                  |  2 +-
>  arch/x86/include/asm/iommu_table.h                |  2 +-
>  arch/x86/include/asm/irqflags.h                   |  2 +-
>  arch/x86/include/asm/mem_encrypt.h                |  2 +-
>  arch/x86/include/asm/setup.h                      |  2 +-
>  arch/x86/kernel/cpu/cpu.h                         |  2 +-
>  arch/x86/kernel/head64.c                          |  2 +-
>  arch/x86/mm/mem_encrypt.c                         |  4 +--
>  arch/x86/mm/mem_encrypt_identity.c                |  2 +-
>  arch/x86/platform/pvh/enlighten.c                 |  4 +--
>  arch/x86/purgatory/purgatory.c                    | 10 +++----
>  arch/x86/um/stub_segv.c                           |  2 +-
>  arch/x86/xen/enlighten.c                          |  2 +-
>  arch/x86/xen/enlighten_pvh.c                      |  2 +-
>  arch/xtensa/kernel/setup.c                        |  2 +-
>  drivers/clk/clk.c                                 |  2 +-
>  drivers/clocksource/timer-probe.c                 |  2 +-
>  drivers/firmware/efi/libstub/efi-stub-helper.c    |  6 ++--
>  drivers/irqchip/irqchip.c                         |  2 +-
>  drivers/of/of_reserved_mem.c                      |  2 +-
>  drivers/s390/char/sclp_early_core.c               |  4 +--
>  drivers/thermal/thermal_core.h                    |  2 +-
>  include/asm-generic/bug.h                         |  6 ++--
>  include/asm-generic/error-injection.h             |  2 +-
>  include/asm-generic/kprobes.h                     |  4 +--
>  include/linux/acpi.h                              |  2 +-
>  include/linux/cache.h                             |  4 +--
>  include/linux/compiler.h                          |  8 +++---
>  include/linux/compiler_attributes.h               | 12 +-------
>  include/linux/cpu.h                               |  2 +-
>  include/linux/dynamic_debug.h                     |  2 +-
>  include/linux/export.h                            |  4 +--
>  include/linux/firmware.h                          |  2 +-
>  include/linux/frame.h                             |  2 +-
>  include/linux/init.h                              | 34 +++++++++++------------
>  include/linux/init_task.h                         |  4 +--
>  include/linux/interrupt.h                         |  4 +--
>  include/linux/kernel.h                            |  6 ++--
>  include/linux/linkage.h                           |  4 +--
>  include/linux/lsm_hooks.h                         |  4 +--
>  include/linux/module.h                            |  2 +-
>  include/linux/moduleparam.h                       |  4 +--
>  include/linux/mtd/xip.h                           |  2 +-
>  include/linux/of.h                                |  2 +-
>  include/linux/percpu-defs.h                       |  2 +-
>  include/linux/printk.h                            |  4 +--
>  include/linux/rcupdate.h                          |  2 +-
>  include/linux/sched/debug.h                       |  2 +-
>  include/linux/serial_core.h                       |  2 +-
>  include/linux/spinlock.h                          |  2 +-
>  include/linux/srcutree.h                          |  2 +-
>  include/linux/syscalls.h                          |  6 ++--
>  include/linux/trace_events.h                      |  2 +-
>  include/linux/tracepoint.h                        |  8 +++---
>  include/trace/bpf_probe.h                         |  2 +-
>  include/trace/trace_events.h                      | 10 +++----
>  kernel/kallsyms.c                                 |  4 +--
>  kernel/trace/trace_export.c                       |  2 +-

Diff stats look good based on what I could find myself with grep.  I
also manually eyeballed each hunk (#eyestrain).  When you send, please
include my:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
This patchset shows the need to follow up with conversions for some of
the other attributes like __used, __aligned, and __weak.
Good job handling some of the trickier cases.
One case I'm not sure is perfect (or if it even matters TBH) is when
there's a trailing backslash for a macro definition that continues
onto the next line, if those are all still tabbed out correctly.  But
the meat of this change is what's important and looks correct to.  If
you want to email me just the patch file (so I don't have to
copy+pasta from an email), I'd be happy to apply it and compile+boot
test a few more arch's than x86.

>  116 files changed, 193 insertions(+), 203 deletions(-)
-- 
Thanks,
~Nick Desaulniers
