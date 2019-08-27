Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB5BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4D020674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Smo7xVDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbfH0LFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:05:30 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:47760 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfH0LFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:05:30 -0400
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x7RB5Jn0026909
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 20:05:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x7RB5Jn0026909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566903920;
        bh=dWxuqD4YJcRMD9twhfib+BopSFdJKxF8FxvMFpBbUHc=;
        h=From:Date:Subject:To:Cc:From;
        b=Smo7xVDM1saSAc9FhwvktzLiJpBycJ+sjNW1E5H88MtL6GaRaUW3b2mZzyz9yNp3o
         ON5wteDwVWexvg3jkSIdjcjt7KXVoqLeu07mCJrbhZbQ/Fapo2w1P7OsGinbQvBLrM
         FcY/alQrWHC8V9s7qhZr+WEohEuzyjCHNJSw8vcNgmWK8H4xgoJvdF+kYX6hzcrZEI
         PftcTuJqmgMqiFKTy+8du0t/VFew1CMrHkrv3Or9jXK308QkD6AFTMmK72RAIru1Z+
         BVhRtlDlChWkOSWsiR1Am0tK7rWlw6rF0zLbiQ962A5IRUxsiHooYuBqGzwQ1C7jIM
         annZ+aZsorbvw==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id t136so4665647vkt.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 04:05:20 -0700 (PDT)
X-Gm-Message-State: APjAAAUYbgUFea6EtJuh1EAs3RxELNCJ76c6Y+3NNHHbFUi+HdKUcVp7
        bYZjEPxJKIGnhUNMz8sY1P5frKCsFA/QCwhIMMU=
X-Google-Smtp-Source: APXvYqyledIhqfWe+gAo4mMvwSREWvj02FyonTP3pC7GC3fqLFZMC32WbLnqBuyPj2Xf3LXKNxpFogQPsn8yCWi5NfU=
X-Received: by 2002:a1f:7c0e:: with SMTP id x14mr10777661vkc.0.1566903918828;
 Tue, 27 Aug 2019 04:05:18 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Aug 2019 20:04:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNATg7O0ZQQ4fe2maNqf0ascHU8b2Mfnqkrxzpzj8D_X7pQ@mail.gmail.com>
Message-ID: <CAK7LNATg7O0ZQQ4fe2maNqf0ascHU8b2Mfnqkrxzpzj8D_X7pQ@mail.gmail.com>
Subject: powerpc asm-prototypes.h seems odd
To:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Lots of powerpc files include <asm/asm-prototypes.h>,
and powerpc is the only architecture that does this.

<asm/asm-prototypes.h> exists to support modversion for asm.
So, it is supposed to be parsed by genksysms, not to be
included from other files.  Right?


$  git grep  asm/asm-prototypes.h
arch/arm64/include/asm/asm-prototypes.h: * ... kbuild will
automatically pick these up from <asm/asm-prototypes.h> and
arch/powerpc/kernel/early_32.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/irq.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/machine_kexec_64.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/process.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/prom_init.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/ptrace.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/security.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/setup_32.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/signal_32.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/signal_64.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/smp.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/syscalls.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/tau_6xx.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/time.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/trace/ftrace.c:#include <asm/asm-prototypes.h>
arch/powerpc/kernel/traps.c:#include <asm/asm-prototypes.h>
arch/powerpc/kvm/book3s_emulate.c:#include <asm/asm-prototypes.h>
arch/powerpc/kvm/book3s_hv.c:#include <asm/asm-prototypes.h>
arch/powerpc/kvm/book3s_hv_builtin.c:#include <asm/asm-prototypes.h>
arch/powerpc/kvm/book3s_hv_rm_xive.c:#include <asm/asm-prototypes.h>
arch/powerpc/kvm/book3s_pr.c:#include <asm/asm-prototypes.h>
arch/powerpc/lib/vmx-helper.c:#include <asm/asm-prototypes.h>
arch/powerpc/mm/book3s64/hash_utils.c:#include <asm/asm-prototypes.h>
arch/powerpc/mm/book3s64/slb.c:#include <asm/asm-prototypes.h>
arch/powerpc/platforms/powernv/idle.c:#include <asm/asm-prototypes.h>
arch/powerpc/platforms/powernv/opal-call.c:#include <asm/asm-prototypes.h>
arch/powerpc/platforms/powernv/opal-tracepoints.c:#include
<asm/asm-prototypes.h>
arch/powerpc/platforms/pseries/lpar.c:#include <asm/asm-prototypes.h>
scripts/Makefile.build:# .S file exports must have their C prototypes
defined in asm/asm-prototypes.h
scripts/Makefile.build:     echo "\#include <asm/asm-prototypes.h>" ;
                            \
scripts/Makefile.build:ASM_PROTOTYPES := $(wildcard
$(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)



-- 
Best Regards
Masahiro Yamada
