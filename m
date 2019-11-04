Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B4FCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5EC214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQqOCU6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfKDVfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:35:41 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36748 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbfKDVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:35:41 -0500
Received: by mail-vs1-f66.google.com with SMTP id q21so12018739vsg.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+iM6UF9mA8yEqKM2m+szbX2ng9KhnEZYRb5X/ojWJG0=;
        b=WQqOCU6qrDuZG8nuHgiV+CHsG7gWSoR72oOp+M0wKsltRJK+cGqjt2t0ZxI2LM6V8C
         1RQXAzRnu6jhZem6MHYFf5TI8O0Eb0LMsQH/RUeNBQLsild5ptqHR2+8pjmiMbj3JxhX
         gRUGg1RmBpVc1Q1nhoC4mIIl7umwH3N3gETvGBsHefq3zid8veGm9BMAaqqXtchvboU3
         oe82rt/ua0dQOwqs4AcW0tswAhd4f8FEmYPR+Wai5JGF1id5ch5hL+dBrDB6AtOUJFPg
         GiGCKXyOExBSa2rtb1uirhcrkQbT6A5dkDAwpPptAzVGzCMyH1PZXR7LWJ4+2g7vZ1c1
         epJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+iM6UF9mA8yEqKM2m+szbX2ng9KhnEZYRb5X/ojWJG0=;
        b=dAYCsqZ0tu4FU3BfSTWDQbLFfZXeR5wOoRhEmQFs2PN3wLzRkfDi3UZD8KxfihE4+p
         Gs6vNYss+Q0fsCE2g32WQ+AzARsUQMtwq/R0pa5ozXzY66im4YWaXGlbjNwyckxL19f/
         dcarseMaXPaZAJzNA2qHKw1Os2gUDxLSGrcqDvGSNAmh0xHUBhofXgPapXU8/uOkd1xM
         nd6rSKLWpbZgmNyrppQMCqueYq2hQvjFcyDkcFIKjuyeQxicEVkLgfDfj93Uqq0pbF1M
         QCr+12ngkPeAZIOlPlM0XfJ+eZ6nJkvtJi6uOBG/pDcOFDEDOoW4ELqj89DbtcxEVQUD
         h4nw==
X-Gm-Message-State: APjAAAX/Sx2/eDnbsACU543ZHyMMPYOa3qJjklVBmkToEOcLrCWPwK56
        Xpjgi5geudBEIAly/jIhLxLiv4v4I29GdWESZn3INg==
X-Google-Smtp-Source: APXvYqw2qurgJaO5Z50222coqPPYraifWu1WpUrqJjCs3EdmK1uhIyv2tT4xgK/tp1HQy+BY+QUyECFV9cgzh+9tP6o=
X-Received: by 2002:a05:6102:36a:: with SMTP id f10mr9282538vsa.44.1572903339925;
 Mon, 04 Nov 2019 13:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-8-samitolvanen@google.com>
 <20191104124017.GD45140@lakrids.cambridge.arm.com>
In-Reply-To: <20191104124017.GD45140@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Nov 2019 13:35:28 -0800
Message-ID: <CABCJKueoJs7hS7VrVoz6CY_oAjTGcV-W61v9GAdwg+zk0W5ErA@mail.gmail.com>
Subject: Re: [PATCH v4 07/17] scs: add support for stack usage debugging
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 4:40 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > +#ifdef CONFIG_DEBUG_STACK_USAGE
> > +static inline unsigned long scs_used(struct task_struct *tsk)
> > +{
> > +     unsigned long *p = __scs_base(tsk);
> > +     unsigned long *end = scs_magic(tsk);
> > +     uintptr_t s = (uintptr_t)p;
>
> As previously, please use unsigned long for consistency.

Ack.

> > +     while (p < end && *p)
> > +             p++;
>
> I think this is the only place where we legtimately access the shadow
> call stack directly.

There's also scs_corrupted, which checks that the end magic is intact.

> When using SCS and KASAN, are the
> compiler-generated accesses to the SCS instrumented?
>
> If not, it might make sense to make this:
>
>         while (p < end && READ_ONCE_NOCKECK(*p))
>
> ... and poison the allocation from KASAN's PoV, so that we can find
> unintentional accesses more easily.

Sure, that makes sense. I can poison the allocation for the
non-vmalloc case, I'll just need to refactor scs_set_magic to happen
before the poisoning.

Sami
