Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206ABC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9ADE208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwxI83h4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403840AbfGRWmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:42:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43275 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403799AbfGRWmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:42:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so13260962pfg.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00kYiEcn7qPCTEzf4dTojM9k+H1/GBBAqJzqVj6grzg=;
        b=cwxI83h4/5aXiHG2hsIHeDh8G6M5TUDncwQ9RddxgNo0ZBhF1wtQ7hseRkN5KhxF0D
         UtPMJMKYwwC9u7I6PcOv/Y1AJxgdP+0AQyNZ4NyCa3OqD8S8Kq3QQHSlFatnhXlWMugu
         nnm0SA3DLxmw2+7un1d1ZqE4oECLB7qLOFe3vmMvgOmZYvHjTmnNn09O8+ooWU8t0/iJ
         uy29bf/1PAQyhI+9sCY3JQ3zUb3VBefRjQaMeewQ3sRFmRcBKWQla3No7EBH8km7uT8E
         Rzww68C3X/xlKSm2dfCqi2A43VS/uGsq2Og4nXuueNXLGBUinTcgFkdDBgzxGsLRpZx5
         dVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00kYiEcn7qPCTEzf4dTojM9k+H1/GBBAqJzqVj6grzg=;
        b=k/9nGjBbkWo0lnIAphLDj1kY2Kl+ZgSdUhbcoJo2KQ2IfWOoLnznOEc38bS1NRzzby
         s7XZ34xH4Xo8XQdES68qLFqk30KKlt7cD3ARIuQzOjP5WrwUieGjltC47B8m1WcFPZwm
         cv+PahT7npDgEMsoAVwUztmW6MaRwSbG11pHThHepfTMwhBKFtU5rRd9mKG7pCEHHeBz
         oZzzFLAXxFnCFkN+oLC8CeceQnXPKy1zaQOtRch+g6cjJEtYOGYOzeslc/iwCuker5ZN
         kBuGVa6lCvnkPexKD/jonaJHKDRfsmVb1NvdqjraQXHTJavdufbrb/JHsXoE6l2AXdSJ
         rtmA==
X-Gm-Message-State: APjAAAWb18zJkSNko/lWVxCj1pvHAdc0jdWQGKNOlJoC/TX/1yHcP6tF
        LLlQS/5/R2dlBHWFg91bQM5eN3+l2/QDns4NI1wjsg==
X-Google-Smtp-Source: APXvYqz+5/5TBg8Cr+fkxt3xGE8SEjGBCVnavZzb1IFFTznvGypAiTvXa1C1nmdzRoqOozxUlnr5j8sO5PiNHXEdr1A=
X-Received: by 2002:a63:60a:: with SMTP id 10mr19387292pgg.381.1563489754090;
 Thu, 18 Jul 2019 15:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 15:42:23 -0700
Message-ID: <CAKwvOdkYKweg5A6jwomPUjjkRWq5=oVMVM=Wcg=ho+crOnr3Ew@mail.gmail.com>
Subject: Re: x86 - clang / objtool status
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 1:40 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> after picking up Josh's objtool updates I gave clang a test ride again.

Thanks for testing and the reports; these are valuable and we
appreciate the help debugging them.

> 2) debian distro config

Is this checked into the tree, or where can I find it?

>
>  objtool warnings:
>
>   drivers/gpu/drm/amd/amdgpu/atom.o: warning: objtool: atom_op_move() falls through to next function atom_op_and()
>   drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes() falls through to next function apply_tx_lanes()
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x86: redundant UACCESS disable
>   drivers/gpu/drm/radeon/evergreen_cs.o: warning: objtool: evergreen_cs_parse() falls through to next function evergreen_dma_cs_parse()

fall through warnings look new to me, but Linaro's KernelCI is
currently screaming with tons of reports of -Wfallthrough throughout
the kernel.  I assume they're related?

> 3) allmodconfig:
>
>  objtool warnings:
>
>   arch/x86/kernel/signal.o: warning: objtool: x32_setup_rt_frame()+0x255: call to memset() with UACCESS enabled
>   arch/x86/kernel/signal.o: warning: objtool: __setup_rt_frame()+0x254: call to memset() with UACCESS enabled
>   arch/x86/ia32/ia32_signal.o: warning: objtool: ia32_setup_rt_frame()+0x247: call to memset() with UACCESS enabled
>
>   mm/kasan/common.o: warning: objtool: kasan_report()+0x52: call to __stack_chk_fail() with UACCESS enabled
>   drivers/ata/sata_dwc_460ex.o: warning: objtool: sata_dwc_bmdma_start_by_tag()+0x3a0: can't find switch jump table
>
>   lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch()+0x88: call to memset() with UACCESS enabled
>   lib/ubsan.o: warning: objtool: ubsan_type_mismatch_common()+0x610: call to __stack_chk_fail() with UACCESS enabled
>   lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1()+0x88: call to memset() with UACCESS enabled
>   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x56: redundant UACCESS disable

Do you still have these object files laying around? Josh asked for
them in a new thread (from the previous thread), not sure if it's ok
to attach object files to emails to LKML? (html email is not allowed,
are binary attachments?)
-- 
Thanks,
~Nick Desaulniers
