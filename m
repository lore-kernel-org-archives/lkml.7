Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8134C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF382089F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568414697;
	bh=bWZPxrt6IaaOuhvGc1TsKZ3K3W1GA+M45bFsqFkrb4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qoggboRG6r4tFX0MUuOv3ME63kcziSdNOEh8O17AILvlTEA0PpVAOXPUpQVnNOGnw
	 8crZytqoKmjr/4PXl6LBEIkOsH4xxF8B/UB2CBtrYCvzJ0zfqfZO1GcCnlsbXnHBrN
	 +IAxwfVhmLzWhOnXg4+Tu+SKrtSeTdY9Fg9Fl6Xw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404171AbfIMWo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404064AbfIMWo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:44:56 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99426214DA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568414695;
        bh=bWZPxrt6IaaOuhvGc1TsKZ3K3W1GA+M45bFsqFkrb4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=duGcWIJvIIMwGksCcU72FbAD4OyFBruon3QiMed4bxNQzrhPU9F7dP4oNgnY0xOJc
         zxGjXCO0K/HdG3yGo50xJC0LA7bA0rKp2KNW5vVdxSWRhxEKYKWdpNwxZn6iC0eWWX
         OcMcQfLyshVIXQ9JxC/wqUMAF1ezC3ReWA8vlkDk=
Received: by mail-wm1-f44.google.com with SMTP id q18so4234994wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 15:44:55 -0700 (PDT)
X-Gm-Message-State: APjAAAUI8+InkFj/MUX2ojy8HN34JlyPFzWqtHLlF4gxLT5+pu/7kHtD
        TdSXmCWB7B4x4bN0wLb+9BoV8O184d/rx4wG+Q6e9g==
X-Google-Smtp-Source: APXvYqwkegKp0ej1lnam+9xtbNehUYoQQBSTiRFvdSDlbKSTMjeabzl4jAYn+RcuX5Wda01d1rgNL7O75DGWyOKvE1c=
X-Received: by 2002:a05:600c:549:: with SMTP id k9mr868236wmc.79.1568414694066;
 Fri, 13 Sep 2019 15:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190913210018.125266-1-samitolvanen@google.com> <20190913210018.125266-3-samitolvanen@google.com>
In-Reply-To: <20190913210018.125266-3-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Sep 2019 15:44:42 -0700
X-Gmail-Original-Message-ID: <CALCETrXve9j=fwaH1rNptKB8OPv_wM4QSPoGa2u9qvHFNE8u7A@mail.gmail.com>
Message-ID: <CALCETrXve9j=fwaH1rNptKB8OPv_wM4QSPoGa2u9qvHFNE8u7A@mail.gmail.com>
Subject: Re: [PATCH 2/4] x86: use the correct function type for sys32_(rt_)sigreturn
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 2:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Use the correct function type to avoid tripping Control-Flow
> Integrity (CFI) checking.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/ia32/ia32_signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
> index 1cee10091b9f..878d8998ce6d 100644
> --- a/arch/x86/ia32/ia32_signal.c
> +++ b/arch/x86/ia32/ia32_signal.c
> @@ -118,7 +118,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
>         return err;
>  }
>
> -asmlinkage long sys32_sigreturn(void)
> +asmlinkage long sys32_sigreturn(const struct pt_regs *__unused)
>  {
>         struct pt_regs *regs = current_pt_regs();
>         struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
> @@ -144,7 +144,7 @@ asmlinkage long sys32_sigreturn(void)
>         return 0;
>  }
>
> -asmlinkage long sys32_rt_sigreturn(void)
> +asmlinkage long sys32_rt_sigreturn(const struct pt_regs *__unused)
>  {
>         struct pt_regs *regs = current_pt_regs();
>         struct rt_sigframe_ia32 __user *frame;

Shouldn't these be COMPAT_SYSCALL_DEFINE0?

I think you should pick this patch up and add it to your series:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/syscalls&id=07daeef08d26728c120ecbe57a55cb5714810b84

with the obvious type fixup, of course.  And then write a little patch
to use COMPAT_SYSCALL_DEFINE0 for rt_sigreturn and sigreturn.


> --
> 2.23.0.237.gc6a4ce50a0-goog
>
