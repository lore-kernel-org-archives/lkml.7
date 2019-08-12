Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E82CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A92B2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAP0kqf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfHLV5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:57:39 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:42913 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfHLV5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:57:39 -0400
Received: by mail-pl1-f173.google.com with SMTP id ay6so48449655plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKVPSiv3Nnc1bJ+Orobrf91FytlMVmCtFO3DISjriR8=;
        b=KAP0kqf7LGZjCS4T+BVf2dAxU13OgXC14RRjAaVnn7yH/C4czgnUS6tZscf3cL8ZyX
         XhEOQNe2/W3KNkBPz7P91r6UjFQJL+4niChimsYkngJaKALSykFHBPukNwNDA/JNVXWR
         HteceawbJ4HI2QrIQdN7hjLTafm81aDabxOwhFNeqcf93ZwVvh4SqMmymL4gpkd8BrGW
         8D1AWVv8xu3yIMSz1ahgUe4gRokZM+tmuVToP6rGhystYyI1iac/pAyh/8REi1M4GTBk
         lCRvy+a8pi21ruXi24QsPxLCrOnKRQ9cn/3JjeCksQjLTeVF00PqjI4TK0DhYTHvacDC
         cytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKVPSiv3Nnc1bJ+Orobrf91FytlMVmCtFO3DISjriR8=;
        b=lVPFCWQqUpe5zjRD9a3gWSidSW1766b6SSYUikw/k/8+UHjzVGZGI9pWNhmPF62+Mz
         IXbkILKkFQ1jlwTwfHqUh8B7HkxzXecCBlH8ZnI8wc0/QIFLdt7pvAVLwf4wZtK+qyiT
         /A1/m9dLXZ2TucF4k9M40BD8dH0gDtp7aPMZiPlPh2r6IEZPSieApOSilELEO4eCzROW
         qgYTTuPJN3LK22LAA+Nstng7uG2KtIoUd55M3ZEmDndmt4gb6o+QntseAfmOrF8Dok35
         G4V6ypKAZLX1bNbni0HMTCbOhy0/cg7DMzlVHisV7BlHAuVVV4NwrMmuF7d30rbSw4de
         x9uA==
X-Gm-Message-State: APjAAAXVAvSKbL1qusa9bLnlqY2xSMfXGMWoW1KDo9pxTVUFKr6U5lcA
        igECwYguphKtxKpyHCIqHd8M13/Zq939OO/jaXzAQw==
X-Google-Smtp-Source: APXvYqzUHVKkObxXnEjsDJOVwzsB5+NNPFpbrcDe96GY0r4g6He80uVToB1oNPerTz4L0ERdIFDE6SpBCO9mjLO7gcw=
X-Received: by 2002:a17:902:3363:: with SMTP id a90mr33160394plc.119.1565647057895;
 Mon, 12 Aug 2019 14:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com> <20190812215052.71840-17-ndesaulniers@google.com>
In-Reply-To: <20190812215052.71840-17-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Aug 2019 14:57:26 -0700
Message-ID: <CAKwvOdmrxK-WBqRwG7PtF4QH1_VySwzOLyGJOFHF9QsUiW-dCQ@mail.gmail.com>
Subject: Fwd: [PATCH 00/16] treewide: prefer __section from compiler_attributes.h
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, Aug 12, 2019 at 2:53 PM
Subject: [PATCH 00/16] treewide: prefer __section from compiler_attributes.h
To: <akpm@linux-foundation.org>
Cc: <sedat.dilek@gmail.com>, <jpoimboe@redhat.com>, <yhs@fb.com>,
<miguel.ojeda.sandonis@gmail.com>,
<clang-built-linux@googlegroups.com>, Nick Desaulniers
<ndesaulniers@google.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song
Liu <songliubraving@fb.com>, <netdev@vger.kernel.org>,
<bpf@vger.kernel.org>


GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This fixes an Oops observed in distro's that use systemd and not
net.core.bpf_jit_enable=1, when their kernels are compiled with Clang.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
https://bugs.llvm.org/show_bug.cgi?id=42950
https://marc.info/?l=linux-netdev&m=156412960619946&w=2

Nick Desaulniers (16):
  s390/boot: fix section name escaping
  arc: prefer __section from compiler_attributes.h
  parisc: prefer __section from compiler_attributes.h
  um: prefer __section from compiler_attributes.h
  sh: prefer __section from compiler_attributes.h
  ia64: prefer __section from compiler_attributes.h
  arm: prefer __section from compiler_attributes.h
  mips: prefer __section from compiler_attributes.h
  sparc: prefer __section from compiler_attributes.h
  powerpc: prefer __section and __printf from compiler_attributes.h
  x86: prefer __section from compiler_attributes.h
  arm64: prefer __section from compiler_attributes.h
  include/asm-generic: prefer __section from compiler_attributes.h
  include/linux: prefer __section from compiler_attributes.h
  include/linux/compiler.h: remove unused KENTRY macro
  compiler_attributes.h: add note about __section

 arch/arc/include/asm/linkage.h        |  8 +++----
 arch/arc/include/asm/mach_desc.h      |  3 +--
 arch/arm/include/asm/cache.h          |  2 +-
 arch/arm/include/asm/mach/arch.h      |  4 ++--
 arch/arm/include/asm/setup.h          |  2 +-
 arch/arm64/include/asm/cache.h        |  2 +-
 arch/arm64/kernel/smp_spin_table.c    |  2 +-
 arch/ia64/include/asm/cache.h         |  2 +-
 arch/mips/include/asm/cache.h         |  2 +-
 arch/parisc/include/asm/cache.h       |  2 +-
 arch/parisc/include/asm/ldcw.h        |  2 +-
 arch/powerpc/boot/main.c              |  3 +--
 arch/powerpc/boot/ps3.c               |  6 ++----
 arch/powerpc/include/asm/cache.h      |  2 +-
 arch/powerpc/kernel/btext.c           |  2 +-
 arch/s390/boot/startup.c              |  2 +-
 arch/sh/include/asm/cache.h           |  2 +-
 arch/sparc/include/asm/cache.h        |  2 +-
 arch/sparc/kernel/btext.c             |  2 +-
 arch/um/kernel/um_arch.c              |  6 +++---
 arch/x86/include/asm/cache.h          |  2 +-
 arch/x86/include/asm/intel-mid.h      |  2 +-
 arch/x86/include/asm/iommu_table.h    |  5 ++---
 arch/x86/include/asm/irqflags.h       |  2 +-
 arch/x86/include/asm/mem_encrypt.h    |  2 +-
 arch/x86/kernel/cpu/cpu.h             |  3 +--
 include/asm-generic/error-injection.h |  2 +-
 include/asm-generic/kprobes.h         |  5 ++---
 include/linux/cache.h                 |  6 +++---
 include/linux/compiler.h              | 31 ++++-----------------------
 include/linux/compiler_attributes.h   | 10 +++++++++
 include/linux/cpu.h                   |  2 +-
 include/linux/export.h                |  2 +-
 include/linux/init_task.h             |  4 ++--
 include/linux/interrupt.h             |  5 ++---
 include/linux/sched/debug.h           |  2 +-
 include/linux/srcutree.h              |  2 +-
 37 files changed, 62 insertions(+), 83 deletions(-)

--
2.23.0.rc1.153.gdeed80330f-goog



-- 
Thanks,
~Nick Desaulniers
