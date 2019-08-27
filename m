Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5EDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C11206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="f+5hfHZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfH0OE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:04:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35930 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfH0OE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:04:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id f19so11842212plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 07:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=t9xctO/WP/vM2N5V7/AvRgZTobzXsqkZj3kzkKzY+c8=;
        b=f+5hfHZV3TLUfwm18/n69YUcml42uyWVJgGc8yRGKvJ6GLp8HQG9luHFUXoEWzxjW0
         O+XZZG7YHbCih0Dy6sejyDN6Z6kupVnFkKcRAermqU4rEN0pwLnKx+WS9sM/p6T7fmmU
         L6JE3W2OMSlkM5Q39iwan4bJ/4NGnt+ah1qkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t9xctO/WP/vM2N5V7/AvRgZTobzXsqkZj3kzkKzY+c8=;
        b=lRMls6vpdC5Q5F6jGDyyxylVwHLh5JNMnQIrqjeEHpuJ1RCIihwpQgRC+22NRt3H9O
         SB1wp3p2Wb6twrgKqlhI4yr9I/wv5cbn3c2nlMuRE+qS2+5dqUGjurtGKIfy3e2jBJ6n
         BL+lPPypqxsb4n7cbl9trLM1TcXzcyr3AcwKNSQiym1uOfnw/S7/Cutla5ilOpsFJ4OR
         pZ/m+F3Tsp4AsvLJ1RciPdhH3mwZaxhRJ0XuprTbUl7bNL0lnsaBali83WzjYmkKLzTP
         apzZndegdo97SRWYi/k1D7DFVb5NTjGVptkRVBUCPvekgCOIf7poDy7RHCuf0u61a3Hn
         HQEQ==
X-Gm-Message-State: APjAAAWYfK5Wn9KLEXehHxeDxFZ7rg/aNdB/ge3sPPDyslReIrmGEWIE
        YtZifN6N1Y1mgfJeamfVVaf0ww==
X-Google-Smtp-Source: APXvYqyj0rYfewcCj6c1ycF9gMEuwWvzV9FIgo+OumVuJdxKjZsukAJMiIcCF0D+WMeg/csHRIWD2A==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr24484244plm.306.1566914697754;
        Tue, 27 Aug 2019 07:04:57 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id r61sm2282367pjb.7.2019.08.27.07.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 07:04:56 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: powerpc asm-prototypes.h seems odd
In-Reply-To: <CAK7LNATg7O0ZQQ4fe2maNqf0ascHU8b2Mfnqkrxzpzj8D_X7pQ@mail.gmail.com>
References: <CAK7LNATg7O0ZQQ4fe2maNqf0ascHU8b2Mfnqkrxzpzj8D_X7pQ@mail.gmail.com>
Date:   Wed, 28 Aug 2019 00:04:38 +1000
Message-ID: <871rx64scp.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Hi.
>
> Lots of powerpc files include <asm/asm-prototypes.h>,
> and powerpc is the only architecture that does this.
>
> <asm/asm-prototypes.h> exists to support modversion for asm.
> So, it is supposed to be parsed by genksysms, not to be
> included from other files.  Right?

It exists to support sparse, squashing a bunch of sparse warnings.

From the commit where I introduced it:

commit 42f5b4cacd783faf05e3ff8bf85e8be31f3dfa9d
Author: Daniel Axtens <dja@axtens.net>
Date:   Wed May 18 11:16:50 2016 +1000

    powerpc: Introduce asm-prototypes.h
    
    Sparse picked up a number of functions that are implemented in C and
    then only referred to in asm code.
    
    This introduces asm-prototypes.h, which provides a place for
    prototypes of these functions.
    
    This silences some sparse warnings.
    
    Signed-off-by: Daniel Axtens <dja@axtens.net>
    [mpe: Add include guards, clean up copyright & GPL text]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Regards,
Daniel

>
>
> $  git grep  asm/asm-prototypes.h
> arch/arm64/include/asm/asm-prototypes.h: * ... kbuild will
> automatically pick these up from <asm/asm-prototypes.h> and
> arch/powerpc/kernel/early_32.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/irq.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/machine_kexec_64.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/process.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/prom_init.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/ptrace.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/security.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/setup_32.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/signal_32.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/signal_64.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/smp.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/syscalls.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/tau_6xx.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/time.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/trace/ftrace.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kernel/traps.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kvm/book3s_emulate.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kvm/book3s_hv.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kvm/book3s_hv_builtin.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kvm/book3s_hv_rm_xive.c:#include <asm/asm-prototypes.h>
> arch/powerpc/kvm/book3s_pr.c:#include <asm/asm-prototypes.h>
> arch/powerpc/lib/vmx-helper.c:#include <asm/asm-prototypes.h>
> arch/powerpc/mm/book3s64/hash_utils.c:#include <asm/asm-prototypes.h>
> arch/powerpc/mm/book3s64/slb.c:#include <asm/asm-prototypes.h>
> arch/powerpc/platforms/powernv/idle.c:#include <asm/asm-prototypes.h>
> arch/powerpc/platforms/powernv/opal-call.c:#include <asm/asm-prototypes.h>
> arch/powerpc/platforms/powernv/opal-tracepoints.c:#include
> <asm/asm-prototypes.h>
> arch/powerpc/platforms/pseries/lpar.c:#include <asm/asm-prototypes.h>
> scripts/Makefile.build:# .S file exports must have their C prototypes
> defined in asm/asm-prototypes.h
> scripts/Makefile.build:     echo "\#include <asm/asm-prototypes.h>" ;
>                             \
> scripts/Makefile.build:ASM_PROTOTYPES := $(wildcard
> $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)
>
>
>
> -- 
> Best Regards
> Masahiro Yamada
