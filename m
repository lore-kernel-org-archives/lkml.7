Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C3C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBD220873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Axjj5t9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfDKFtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:49:01 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:23467 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfDKFtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:49:01 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x3B5mcbw029917
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 14:48:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x3B5mcbw029917
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554961719;
        bh=uQTSX/3waKUJHoKtE6OAnsIQqz5N3oazBYIFncLxLFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Axjj5t9vQafp4nVIN+cxOxJ0wPkvFD8Rg4GfTVhIuDmd8AL51jymVY1OL3GL3JGBm
         Ukz/ozBSDADnC5C3iD+9xhq76bMNiP0Gl85essCEK7b3x/orrD1R+pltT3RUoumg7w
         4PU96OC8cl1m98+cIS708Jy2FAmUai4ufJYcPrX0tOyR0M98oAuCikc/wKQJt2MIL1
         ZaWhRlg/O/kESSsJyccaImwd6K3fMtZI6lo1JyLd/mqmni7yIk1frHmDYX22IEtlBz
         zloTWFzQcjSHevPq9GGT56oQFdK4LjJUUojywrTrDI3VUl0FS2mu2bDJedHAYKvlAC
         Dlopz2Zf3mtwg==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id h127so1100044vkd.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 22:48:39 -0700 (PDT)
X-Gm-Message-State: APjAAAUbYsDJEcg21z8SIxYhRWHxvpMM+QD9Xq/Y7nGVzviZ0f2UjdcT
        nhve4i6gDHoUaVpvgaXMHJ1XKtQKgz/z7/J9/Ag=
X-Google-Smtp-Source: APXvYqxqfCFRJUjt+5sOp0XMUMQ3C/nUxwL3A4U93CBfNbgWzWCZtKtmlypZtv/hkdnW1tm2E/uruytmHlm7u9DdlSw=
X-Received: by 2002:a1f:793:: with SMTP id 141mr14138184vkh.31.1554961717997;
 Wed, 10 Apr 2019 22:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190411005634.8495-1-okaya@kernel.org> <CAK7LNAS=G7-nXr=pT2EYExGNkCcOcd2NH1haaBMt+JsyhX2Z8Q@mail.gmail.com>
 <c8babeca-2d24-4265-0477-0634d87efa70@kernel.org>
In-Reply-To: <c8babeca-2d24-4265-0477-0634d87efa70@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Apr 2019 14:48:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARB54R5OfADaxzO=Mu8LucCd7wPVS4Yys8cfCKUpYc6Cg@mail.gmail.com>
Message-ID: <CAK7LNARB54R5OfADaxzO=Mu8LucCd7wPVS4Yys8cfCKUpYc6Cg@mail.gmail.com>
Subject: Re: [PATCH v3] init: Do not select DEBUG_KERNEL by default
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Changbin Du <changbin.du@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 2:44 PM Sinan Kaya <Okaya@kernel.org> wrote:
>
> On 4/11/2019 1:31 AM, Masahiro Yamada wrote:
> >> t looks like CONFIG_KALLSYMS_ALL is the only feature that
> >> requires CONFIG_DEBUG_KERNEL.
> > Which part of KALLSYMS_ALL code requires CONFIG_DEBUG_KERNEL?
> >
>
> I was going by what Kconfig tells me
>
> Symbol: KALLSYMS_ALL [=n]
>   Depends on: DEBUG_KERNEL [=n] && KALLSYMS [=y]

Lots of features have 'depends on DEBUG_KERNEL'.
What is special about KALLSYMS_ALL here?


./drivers/gpio/Kconfig:52: depends on DEBUG_KERNEL
./drivers/pci/Kconfig:69: depends on DEBUG_KERNEL
./drivers/usb/gadget/Kconfig:51: depends on DEBUG_KERNEL
./drivers/base/Kconfig:119: depends on DEBUG_KERNEL
./drivers/base/Kconfig:130: depends on DEBUG_KERNEL
./drivers/base/Kconfig:142: depends on DEBUG_KERNEL
./drivers/spi/Kconfig:29: depends on DEBUG_KERNEL
./drivers/pinctrl/Kconfig:29: depends on DEBUG_KERNEL
./drivers/gpu/drm/Kconfig:55: depends on DEBUG_KERNEL
./kernel/rcu/Kconfig.debug:16: depends on DEBUG_KERNEL
./kernel/rcu/Kconfig.debug:33: depends on DEBUG_KERNEL
./kernel/rcu/Kconfig.debug:61: depends on DEBUG_KERNEL
./kernel/rcu/Kconfig.debug:73: depends on DEBUG_KERNEL
./net/dccp/Kconfig:30: depends on DEBUG_KERNEL=y
./crypto/Kconfig:173: depends on DEBUG_KERNEL && !CRYPTO_MANAGER_DISABLE_TESTS
./init/Kconfig:951: depends on DEBUG_KERNEL
./init/Kconfig:1476: depends on DEBUG_KERNEL && KALLSYMS
./mm/Kconfig.debug:12: depends on DEBUG_KERNEL
./mm/Kconfig.debug:44: depends on DEBUG_KERNEL && STACKTRACE_SUPPORT
./mm/Kconfig.debug:99: depends on DEBUG_KERNEL
./mm/Kconfig:494: depends on DEBUG_KERNEL && CMA
./lib/Kconfig.kgdb:8: depends on DEBUG_KERNEL
./lib/Kconfig.debug:80: depends on DEBUG_KERNEL && PRINTK &&
GENERIC_CALIBRATE_DELAY
./lib/Kconfig.debug:172: depends on DEBUG_KERNEL && !COMPILE_TEST
./lib/Kconfig.debug:264:        depends on DEBUG_KERNEL
./lib/Kconfig.debug:363: depends on DEBUG_KERNEL && (M68K || UML ||
SUPERH) || ARCH_WANT_FRAME_POINTERS
./lib/Kconfig.debug:387: depends on DEBUG_KERNEL
./lib/Kconfig.debug:447: depends on DEBUG_KERNEL
./lib/Kconfig.debug:508: depends on DEBUG_KERNEL && SLAB
./lib/Kconfig.debug:549: depends on DEBUG_KERNEL && HAVE_DEBUG_KMEMLEAK
./lib/Kconfig.debug:614: depends on DEBUG_KERNEL && !IA64
./lib/Kconfig.debug:623: depends on DEBUG_KERNEL
./lib/Kconfig.debug:661: depends on DEBUG_KERNEL && ARCH_HAS_DEBUG_VIRTUAL
./lib/Kconfig.debug:670: depends on DEBUG_KERNEL && !MMU
./lib/Kconfig.debug:712: depends on DEBUG_KERNEL
./lib/Kconfig.debug:723: depends on DEBUG_KERNEL && HIGHMEM
./lib/Kconfig.debug:733: depends on DEBUG_KERNEL && HAVE_DEBUG_STACKOVERFLOW
./lib/Kconfig.debug:802: depends on DEBUG_KERNEL
./lib/Kconfig.debug:816: depends on DEBUG_KERNEL && !S390
./lib/Kconfig.debug:868: depends on DEBUG_KERNEL && !S390
./lib/Kconfig.debug:902: depends on DEBUG_KERNEL
./lib/Kconfig.debug:956: depends on DEBUG_KERNEL
./lib/Kconfig.debug:997: depends on DEBUG_KERNEL && PROC_FS
./lib/Kconfig.debug:1010: depends on DEBUG_KERNEL && PROC_FS
./lib/Kconfig.debug:1023: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1048: depends on DEBUG_KERNEL && PREEMPT &&
TRACE_IRQFLAGS_SUPPORT
./lib/Kconfig.debug:1065: depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
./lib/Kconfig.debug:1111: depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
./lib/Kconfig.debug:1133: depends on DEBUG_KERNEL && RT_MUTEXES
./lib/Kconfig.debug:1140: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1150: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1157: depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
./lib/Kconfig.debug:1174: depends on DEBUG_KERNEL && RWSEM_SPIN_ON_OWNER
./lib/Kconfig.debug:1181: depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
./lib/Kconfig.debug:1196: depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
./lib/Kconfig.debug:1207: depends on DEBUG_KERNEL && LOCKDEP
./lib/Kconfig.debug:1216: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1226: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1237: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1308: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1346: depends on DEBUG_KERNEL || BUG_ON_DATA_CORRUPTION
./lib/Kconfig.debug:1355: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1365: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1375: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1385: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1402: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1417: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1444: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1457: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1536: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1615: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1680: depends on DEBUG_KERNEL || m
./lib/Kconfig.debug:1690: depends on DEBUG_KERNEL || m
./lib/Kconfig.debug:1699: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1710: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1724: depends on DEBUG_KERNEL
./lib/Kconfig.debug:1731: depends on DEBUG_KERNEL
./arch/xtensa/Kconfig.debug:5: depends on DEBUG_KERNEL && MMU
./arch/x86/Kconfig.debug:70: depends on DEBUG_KERNEL
./arch/x86/Kconfig.debug:129: depends on DEBUG_KERNEL
./arch/x86/Kconfig.debug:174: depends on DEBUG_KERNEL && KPROBES
./arch/x86/Kconfig.debug:258: depends on DEBUG_KERNEL
./arch/x86/Kconfig.debug:265: depends on DEBUG_KERNEL
./arch/x86/Kconfig.debug:285: depends on DEBUG_KERNEL
./arch/x86/Kconfig.debug:295: depends on DEBUG_KERNEL && X86_LOCAL_APIC
./arch/x86/Kconfig.debug:319: depends on DEBUG_KERNEL
./arch/ia64/Kconfig.debug:23: depends on DEBUG_KERNEL
./arch/ia64/Kconfig.debug:33: depends on DEBUG_KERNEL
./arch/ia64/Kconfig.debug:42: depends on DEBUG_KERNEL
./arch/ia64/Kconfig.debug:51: depends on DEBUG_KERNEL
./arch/s390/Kconfig.debug:8: depends on DEBUG_KERNEL
./arch/powerpc/Kconfig.debug:57: depends on DEBUG_KERNEL
./arch/powerpc/Kconfig.debug:70: depends on DEBUG_KERNEL &&
JUMP_LABEL_FEATURE_CHECKS
./arch/powerpc/Kconfig.debug:79: depends on DEBUG_KERNEL
./arch/powerpc/Kconfig.debug:83: depends on DEBUG_KERNEL
./arch/powerpc/Kconfig.debug:90: depends on DEBUG_KERNEL
./arch/powerpc/Kconfig.debug:127: depends on DEBUG_KERNEL && PPC32
./arch/powerpc/Kconfig.debug:355:        depends on DEBUG_KERNEL && DEBUG_FS
./arch/powerpc/Kconfig.debug:366:        depends on DEBUG_KERNEL &&
PPC_BOOK3S_64
./arch/arm/Kconfig.debug:8: depends on DEBUG_KERNEL
./arch/arm/Kconfig.debug:105: depends on DEBUG_KERNEL
./arch/arm64/Kconfig.debug:7: depends on DEBUG_KERNEL
./arch/unicore32/Kconfig.debug:17: depends on DEBUG_KERNEL
./arch/mips/Kconfig.debug:90: depends on DEBUG_KERNEL && SYS_SUPPORTS_ZBOOT
./arch/sh/Kconfig.debug:22: depends on DEBUG_KERNEL && SUPERH32
./arch/sh/Kconfig.debug:31: depends on DEBUG_KERNEL && (MMU || BROKEN)
&& !PAGE_SIZE_64KB
./arch/sh/Kconfig.debug:41: depends on DEBUG_KERNEL && SUPERH32 && BROKEN
./arch/sh/Kconfig.debug:49: depends on DEBUG_KERNEL && SUPERH32
./arch/sh/Kconfig.debug:70: depends on DEBUG_KERNEL



-- 
Best Regards
Masahiro Yamada
