Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D78CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A5621925
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/hXJF8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503348AbfJXQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:32:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55853 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389313AbfJXQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:32:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id g24so3550031wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rU3z16VWtzBIk+svSwi6S4IWlLlcuR6vtu8ErKDXMGM=;
        b=j/hXJF8MSfMcFr+8ICSDqKdkq+j9Yy67mheFRR0ZNWRAGX9lYMS508yglTK/wFKUE9
         DYc+e6ecoTFRt9djQnLzSy8TC4KVONxfEbo1IQYHQMlQxKflhv8P8ZKClmbBVR+N7glr
         eN6uNcMLf7ng+ZefcjCADWfDa4FD8YO9hi8Q4LOzeXKxLwHo2IObx/A98R3ti9u/98s2
         fmwnQSLo/en94re6UBYGiC2HYRNvE+gRFg04970IrrIkRLEK1glUslSV4N03VNYRxPAP
         Zzgsjgr58i2VB2Q7k6Pzs/3LiO2Y+S1/s/jtqqHjzTtwedCpc4os9eLdIE0KMUeUrdJE
         RXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rU3z16VWtzBIk+svSwi6S4IWlLlcuR6vtu8ErKDXMGM=;
        b=FtIHNg8/AP1j7vTG2TyDqiGSPlwusWp+8sH3DGngW7HWH9JB466qpc8Tyop3OvejCX
         K2dPXPUs98Nhk4OS5Rnpn1bDd3YfIMPv0j1NR8mFaWs7ffTvxsN+kttSWJLRGmy/axWC
         Xc4YtxvW93ZxPJsggHSJAT8HnziBj7RsfT3+mROsyc+HsQG1rpCdOtdYuvuS+LnqfKK5
         BAhfW4jYb8rstBtytcT+F4LLQe0ju+APa441M2rOyOtAnDLjOdRrIxvyPMWc6LK2udGK
         o952S12IHW56ps3M37IRAYWHD0vTgAWHK6glDBheeteqq/Vsinw25v5l2DHnJoF5YjHh
         JO2w==
X-Gm-Message-State: APjAAAUH6aBE56s6NLHmpMxEoG1YNZWrEjmX3fneI3Rry4X051OIK0of
        xkK6yWdYfCAbavC3Px1IBbk9eyG6dNTteVRaFXBBOA==
X-Google-Smtp-Source: APXvYqx0OMPmXC4g7/6lRtvSZZdX1OSNshPAGnEVfbvjUnA3a71Kg021LSrWoZFQHpYWKwELZvB5L2ZCcxPFoWd7Gxs=
X-Received: by 2002:a1c:64d6:: with SMTP id y205mr5334697wmb.136.1571934752887;
 Thu, 24 Oct 2019 09:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191021163426.9408-1-mark.rutland@arm.com>
In-Reply-To: <20191021163426.9408-1-mark.rutland@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 24 Oct 2019 18:32:21 +0200
Message-ID: <CAKv+Gu_ceWFQMNUABvOU5Gd_d3EgpfODkzan_riU1YY8rSRZaQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Helge Deller <deller@gmx.de>, Torsten Duwe <duwe@suse.de>,
        James Morse <james.morse@arm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, jthierry@redhat.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, svens@stackframe.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019 at 18:34, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi,
>
> This series is a reworked version of Torsten's v8 FTRACE_WITH_REGS
> series [1]. I've tried to rework the existing code in preparatory
> patches so that the patchable-function-entry bits slot in with fewer
> surprises. This version is based on v5.4-rc3, and can be found in my
> arm64/ftrace-with-regs branch [2].
>
> I've added an (optional) ftrace_init_nop(), which the core code uses to
> initialize callsites. This allows us to avoid a synthetic MCOUNT_ADDR
> symbol, and more cleanly separates the one-time initialization of the
> callsite from dynamic NOP<->CALL modification. Architectures which don't
> implement this get the existing ftrace_make_nop() with MCOUNT_ADDR.
>
> I've moved the module PLT initialization to module load time, which
> simplifies runtime callsite modification. This also means that we don't
> transitently mark the module text RW, and will allow for the removal of
> module_disable_ro().
>
> Since the last posting, parisc gained ftrace support using
> patchable-function-entry. I've made the handling of module callsite
> locations common in kernel/module.c with a new FTRACE_CALLSITE_SECTION
> definition, and removed the newly redundant bits from arch/parisc.
>
> Thanks,
> Mark.
>
> [1] https://lore.kernel.org/r/20190208150826.44EBC68DD2@newverein.lst.de
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/ftrace-with-regs
>
> Mark Rutland (7):
>   ftrace: add ftrace_init_nop()
>   module/ftrace: handle patchable-function-entry
>   arm64: module: rework special section handling
>   arm64: module/ftrace: intialize PLT at load time
>   arm64: insn: add encoder for MOV (register)
>   arm64: asm-offsets: add S_FP
>   arm64: ftrace: minimize ifdeffery
>
> Torsten Duwe (1):
>   arm64: implement ftrace with regs
>

For the series,

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

>  arch/arm64/Kconfig               |   2 +
>  arch/arm64/Makefile              |   5 ++
>  arch/arm64/include/asm/ftrace.h  |  23 +++++++
>  arch/arm64/include/asm/insn.h    |   3 +
>  arch/arm64/include/asm/module.h  |   2 +-
>  arch/arm64/kernel/asm-offsets.c  |   1 +
>  arch/arm64/kernel/entry-ftrace.S | 140 +++++++++++++++++++++++++++++++++++++--
>  arch/arm64/kernel/ftrace.c       | 123 ++++++++++++++++++++--------------
>  arch/arm64/kernel/insn.c         |  13 ++++
>  arch/arm64/kernel/module-plts.c  |   3 +-
>  arch/arm64/kernel/module.c       |  57 +++++++++++++---
>  arch/parisc/Makefile             |   1 -
>  arch/parisc/kernel/module.c      |  10 ++-
>  arch/parisc/kernel/module.lds    |   7 --
>  include/linux/ftrace.h           |   5 ++
>  kernel/module.c                  |   2 +-
>  kernel/trace/ftrace.c            |  13 +++-
>  17 files changed, 330 insertions(+), 80 deletions(-)
>  delete mode 100644 arch/parisc/kernel/module.lds
>
> --
> 2.11.0
>
