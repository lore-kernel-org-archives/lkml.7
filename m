Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E6CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA2B21835
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="e+okOhtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504225AbfJRFF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:05:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55093 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391511AbfJRFFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:05:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so4696427wmp.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 22:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w0COLG3bzK0o6jYLfbxydoFv6NkgXFj1ig3oopc83YI=;
        b=e+okOhtzP6+13ZVb52oUedSHNdXUvAj+AaZgTFlk49vnQCzXFWXRCp9LgLioHHfXd8
         P0+MALJgEg5o7L5bPbaStznc4116PcXBbQ4NkJPUE9uzUlYWAoX3j0Zd3SxFoaEwRDlY
         /2/myoHstRdz1soYjTJxepkrx+jWOHP8oQbO6rxJWdSA/hgTHt6qQEQRbZr9o4iHGci2
         RYqKDsnIRRBm+lSwMsEDA8DLEcdoDIUTzVuQTGQI8+aFconpNYREGVcZqXfgOXPLdMuV
         /lnMuNyyTT4C4UK/2V6PLZ57g0/mS5ZC6y9K9caJ5eyIc7+HuQdgcWfupFikyGTHtclB
         +L6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w0COLG3bzK0o6jYLfbxydoFv6NkgXFj1ig3oopc83YI=;
        b=MDCTtiUMUXUzKaX8eEDIPSeEzWs5VbHgi2w6DrZEAv/LUxWwm6Ct6WLgOnFNBe7UG4
         nyTawtbfPOGeEWLUAWyT0FB+fA0t//GFCC6I+GN1Ggc0kulBVFX38Vwk38p/B8nYwvfp
         QCRN41dre/s6m0iagnwSvDA9G9qW8LCl1O1vJjcpqYUZV57VYYUt9SIMczA0KOwZoZQG
         tr2lDorURienPFHAwtiRjlqo2l5pwsF48knR9nj11IY+JvB0V1baGKGDt9YdmXNtWJT1
         Qcrg3FqEVIvhMpltAwIKYDYoGI/RvdFWBNQc/g5IwkdksWVsa+9IAWA86XisnbKRLnov
         RPLw==
X-Gm-Message-State: APjAAAUk9TWbzyy48jNcBZPCa/1FosTFFgoKSja4EMqUTgwnX8599VIW
        /AwmDYSHLAejrZzM8bp3vv3V1yRnBvgZehzzh+A5BzeL
X-Google-Smtp-Source: APXvYqyaR6UdSsHoyTJfsRK0dDrdvlBOrSURqeguij/ZiiwiHZQ6f3cnRfyt6TgwuU56l7HPTB9yMUbOtPbu8y2CrzQ=
X-Received: by 2002:a7b:c775:: with SMTP id x21mr5632921wmk.52.1571368385118;
 Thu, 17 Oct 2019 20:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191018004929.3445-1-paul.walmsley@sifive.com>
In-Reply-To: <20191018004929.3445-1-paul.walmsley@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 18 Oct 2019 08:42:54 +0530
Message-ID: <CAAhSdy2nX2LwEEAZuMtW_ByGTkHO6KaUEvVxRnba_ENEjmFayQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] riscv: resolve most warnings from sparse
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:19 AM Paul Walmsley <paul.walmsley@sifive.com> wrote:
>
> Resolve most warnings from the 'sparse' static analysis tool for the
> arch/riscv codebase.  This makes life easier for us as maintainers,
> and makes it easier for developers to use static analysis tools on
> their own changes.
>
> This patch series incorporates some changes based on feedback from
> Christoph Hellwig <hch@lst.de>.
>
> Applies on the current riscv fixes branch that is based on v5.4-rc3.

This series certainly conflict's with Christoph's NOMMU series so
please rebase it on NOMMU series.

Regards,
Anup

>
>
> - Paul
>
>
> Paul Walmsley (8):
>   riscv: add prototypes for assembly language functions from entry.S
>   riscv: add prototypes for assembly language functions from head.S
>   riscv: init: merge split string literals in preprocessor directive
>   riscv: ensure RISC-V C model definitions are passed to static
>     analyzers
>   riscv: add missing prototypes
>   riscv: mark some code and data as file-static
>   riscv: add missing header file includes
>   riscv: fp: add missing __user pointer annotations
>
> Kernel object size difference:
>    text    data     bss     dec     hex filename
> 6664206 2136568  312608 9113382  8b0f26 vmlinux.orig
> 6664186 2136552  312608 9113346  8b0f02 vmlinux.patched
>
>  arch/riscv/Makefile                 |  2 ++
>  arch/riscv/include/asm/irq.h        |  6 ++++++
>  arch/riscv/include/asm/pgtable.h    |  2 ++
>  arch/riscv/include/asm/processor.h  |  4 ++++
>  arch/riscv/include/asm/ptrace.h     |  4 ++++
>  arch/riscv/include/asm/smp.h        |  2 ++
>  arch/riscv/include/asm/switch_to.h  |  1 +
>  arch/riscv/kernel/cpufeature.c      |  1 +
>  arch/riscv/kernel/entry.h           | 29 +++++++++++++++++++++++++++++
>  arch/riscv/kernel/head.h            | 21 +++++++++++++++++++++
>  arch/riscv/kernel/module-sections.c |  1 +
>  arch/riscv/kernel/process.c         |  2 ++
>  arch/riscv/kernel/reset.c           |  1 +
>  arch/riscv/kernel/setup.c           |  2 ++
>  arch/riscv/kernel/signal.c          |  6 ++++--
>  arch/riscv/kernel/smp.c             |  2 ++
>  arch/riscv/kernel/smpboot.c         |  3 +++
>  arch/riscv/kernel/stacktrace.c      |  6 ++++--
>  arch/riscv/kernel/syscall_table.c   |  1 +
>  arch/riscv/kernel/time.c            |  1 +
>  arch/riscv/kernel/traps.c           |  2 ++
>  arch/riscv/kernel/vdso.c            |  3 ++-
>  arch/riscv/mm/context.c             |  1 +
>  arch/riscv/mm/fault.c               |  2 ++
>  arch/riscv/mm/init.c                | 17 ++++++++++-------
>  arch/riscv/mm/sifive_l2_cache.c     |  2 +-
>  26 files changed, 111 insertions(+), 13 deletions(-)
>  create mode 100644 arch/riscv/kernel/entry.h
>  create mode 100644 arch/riscv/kernel/head.h
>
> --
> 2.23.0
>
