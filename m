Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29111C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08722184E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MCEkpfzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCUBWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:22:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46152 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbfCUBWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:22:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id z26so3893098lja.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQak0Tx1h8ZzNvJhxHCJfkfqfqQkp5tZm5k1rkzGAWo=;
        b=MCEkpfzGAVkV8OUWwvDfADJaHEJrKphKNk9ZBHdDkhAUp7Xi+D/fivnaUTpvnchwYj
         J2EHm4s1wlqI4ZcZiv+Js1gSi7emoP5i5oV+4iZXmIE6Qq/JWZibrzfpA0Rp90SC5BUn
         W5zfcnA3uCN/DoLkvQtKQVKubObxSOEcEhAXIrNLr81lzhyUiNHPb6wSNGfccRmX4EMy
         /H5QiSC0lmtG8aFUY+Ruz0y/ovCpRP+EuPkxhvyYHuVHYUt3qyNZ89c0ETPAPCjXUllU
         UGH5e61Ppbup0MOniwkWehzvHSNj+AwTjl0HV9bfHQFFKp60o9DqLyRIjute8/M29s41
         Wklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQak0Tx1h8ZzNvJhxHCJfkfqfqQkp5tZm5k1rkzGAWo=;
        b=cj0QyE3/DGCZ/gjfZT8GZYRWjinORa0EfKGjofP/Su6mf10IAM3kCy2ier6U1MlqCs
         yq5Auqufbu93BCYsRPjaITD51S9291YNRJEUPppq4MC438rOAjAQZpi2C0ZNqaMc9sY+
         GTFkSn8Nc5BZdE+uiJGH6BeRECiYuP/nj4RLGZv0/4sUDBCC9Vjx3YmR2xDrYdlcYi57
         NGKtGUg0dBTpIbjUMZTkhyRgL3vj/71na2mBKXuZWsIiq5HZmSRy8t3ed95giMP4NaT4
         W/H6ibEaY+Ew8GTF+LWUYc/amt8q045RDLb7Bt7688V9dTHaVHVh4wET0KTxSWGL8NUN
         K10A==
X-Gm-Message-State: APjAAAX5dmEn8f4mou3vjXjexeOF2dl53glsz7dH7xaRrpLjThHOWJhE
        HH1ayRyiXemYYZZ2Ne9+RFTW+nUp3NWBxUcitRcT
X-Google-Smtp-Source: APXvYqz9Z69ggdD7Zm5pwgIrjh6J08nEG+oOiUcxma3ymHttjivN/PjyGvMdyp2UOzbYS7NuNo7HvewRoASj71uxYPo=
X-Received: by 2002:a2e:500d:: with SMTP id e13mr481912ljb.169.1553131366528;
 Wed, 20 Mar 2019 18:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190317233018.GN16301@altlinux.org>
In-Reply-To: <20190317233018.GN16301@altlinux.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 20 Mar 2019 21:22:35 -0400
Message-ID: <CAHC9VhQWKT8Mr=_pcmiccpChMB9oufUHO-4Agzmot7M=6ShNnw@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] syscall_get_arch: add "struct task_struct *" argument
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kees Cook <keescook@chromium.org>,
        Mark Salter <msalter@redhat.com>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> This argument is required to extend the generic ptrace API with
> PTRACE_GET_SYSCALL_INFO request: syscall_get_arch() is going
> to be called from ptrace_request() along with syscall_get_nr(),
> syscall_get_arguments(), syscall_get_error(), and
> syscall_get_return_value() functions with a tracee as their argument.
>
> The primary intent is that the triple (audit_arch, syscall_nr, arg1..arg6)
> should describe what system call is being called and what its arguments
> are.
>
> Reverts: 5e937a9ae913 ("syscall_get_arch: remove useless function arguments")
> Reverts: 1002d94d3076 ("syscall.h: fix doc text for syscall_get_arch()")
> Reviewed-by: Andy Lutomirski <luto@kernel.org> # for x86
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Acked-by: Kees Cook <keescook@chromium.org> # seccomp parts
> Acked-by: Mark Salter <msalter@redhat.com> # for the c6x bit
> Cc: Elvira Khabirova <lineprinter@altlinux.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-c6x-dev@linux-c6x.org
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: linux-hexagon@vger.kernel.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: nios2-dev@lists.rocketboards.org
> Cc: openrisc@lists.librecores.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-xtensa@linux-xtensa.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-audit@redhat.com
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>
> Notes:
>     v2: unchanged
>
>  arch/alpha/include/asm/syscall.h      |  2 +-
>  arch/arc/include/asm/syscall.h        |  2 +-
>  arch/arm/include/asm/syscall.h        |  2 +-
>  arch/arm64/include/asm/syscall.h      |  4 ++--
>  arch/c6x/include/asm/syscall.h        |  2 +-
>  arch/csky/include/asm/syscall.h       |  2 +-
>  arch/h8300/include/asm/syscall.h      |  2 +-
>  arch/hexagon/include/asm/syscall.h    |  2 +-
>  arch/ia64/include/asm/syscall.h       |  2 +-
>  arch/m68k/include/asm/syscall.h       |  2 +-
>  arch/microblaze/include/asm/syscall.h |  2 +-
>  arch/mips/include/asm/syscall.h       |  6 +++---
>  arch/mips/kernel/ptrace.c             |  2 +-
>  arch/nds32/include/asm/syscall.h      |  2 +-
>  arch/nios2/include/asm/syscall.h      |  2 +-
>  arch/openrisc/include/asm/syscall.h   |  2 +-
>  arch/parisc/include/asm/syscall.h     |  4 ++--
>  arch/powerpc/include/asm/syscall.h    | 10 ++++++++--
>  arch/riscv/include/asm/syscall.h      |  2 +-
>  arch/s390/include/asm/syscall.h       |  4 ++--
>  arch/sh/include/asm/syscall_32.h      |  2 +-
>  arch/sh/include/asm/syscall_64.h      |  2 +-
>  arch/sparc/include/asm/syscall.h      |  5 +++--
>  arch/unicore32/include/asm/syscall.h  |  2 +-
>  arch/x86/include/asm/syscall.h        |  8 +++++---
>  arch/x86/um/asm/syscall.h             |  2 +-
>  arch/xtensa/include/asm/syscall.h     |  2 +-
>  include/asm-generic/syscall.h         |  5 +++--
>  kernel/auditsc.c                      |  4 ++--
>  kernel/seccomp.c                      |  4 ++--
>  30 files changed, 52 insertions(+), 42 deletions(-)

Merged into audit/next, thanks everyone.

-- 
paul moore
www.paul-moore.com
