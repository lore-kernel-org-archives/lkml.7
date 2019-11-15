Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8585EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F15206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 20:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sz3oYsEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKOUTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 15:19:36 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39404 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfKOUTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 15:19:36 -0500
Received: by mail-vs1-f67.google.com with SMTP id x21so7154624vsp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 12:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGaDR9v43Zv6SHpEarxzzn1nbL46+U2IHPBI4tRr2qU=;
        b=sz3oYsEy6H86AvsBzq8AbZKdjQSN7okat4NCYezwXYe4Nn3roLSKspibusFC5eHUf/
         XOZxYpYgje1RauUONtlip6AndrCc1FzEjmqFuEXf/69rqOVa2UBWi0fKU+Kei4F8RfQX
         +7+vOdylQ6Vj7DNMXqMEOg93IKnt/XFB5vW7yWtdoQvsrjLwYpphuYBP9e1+Qbw3HkGs
         UbQW5JMFNZJhDACwQBzv7KE+82hTDuxWS8H3YU+Y4iLbH+MU9i1tI1p103NI8UckIlSi
         o8zaOjuCB9CXHD9+Ooztaj1GSDDxopXYagZX0MrPMJY7b/8XydSkeYdBXQfkOH969mBK
         m3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGaDR9v43Zv6SHpEarxzzn1nbL46+U2IHPBI4tRr2qU=;
        b=ANRsxChNLsmRJ0o0YzrudOuBOdrvvdIufV31VU4wdcrqfWkgt7ztf7cpq1QAsX91rk
         6IUwbcNcwso+Ac8qbFhtRJ5RsJu9YowPOwxe7DylA4HBXLZKkil0nFbLWIF/OwHIV4QI
         QKMykl49bDi3LU2kPRK6q0ojcQEQYxqGRG5VgKHxCuSV8NPBR9uJ7E1Uhb6oDhFdZTqm
         XedA/ZHPxKDKuMddKMvsrnu8xrzrGrPzvOAPaLshinkq1hhkAxVW5TIoRDddKJveLnxH
         dXukMjWZ7F61KToFvxE28wIXhf3gDDxM2rgqV7QWhNF0jzS7nEXqNffBRagCC+BkA0En
         yjAQ==
X-Gm-Message-State: APjAAAWLEEbd4iGxi7Rcc/UCufKD27kr050x4uRVWP5XQxNBHGbx6pH7
        TtlskrzQ10TCWc0fTDBQ5UTGjwtu5zBZCNX/B0EMgA==
X-Google-Smtp-Source: APXvYqyJJAtOC9yDRTQtthbybCklKzAJjxRAZgrd64ZfvgQMG7E3ZVIDa8qPXRTRklTlBbwY1FtJCZyMYntSX38nxGA=
X-Received: by 2002:a67:db10:: with SMTP id z16mr6607389vsj.5.1573849174709;
 Fri, 15 Nov 2019 12:19:34 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com> <20191105235608.107702-15-samitolvanen@google.com>
 <20191115152047.GI41572@lakrids.cambridge.arm.com>
In-Reply-To: <20191115152047.GI41572@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 15 Nov 2019 12:19:20 -0800
Message-ID: <CABCJKudm28QaKRxPHWgKuEfRvm=EvuUEmcAVOnNkbxBCJcYX5A@mail.gmail.com>
Subject: Re: [PATCH v5 14/14] arm64: implement Shadow Call Stack
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

On Fri, Nov 15, 2019 at 7:20 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Nov 05, 2019 at 03:56:08PM -0800, Sami Tolvanen wrote:
> > This change implements shadow stack switching, initial SCS set-up,
> > and interrupt shadow stacks for arm64.
>
> Each CPU also has an overflow stack, and two SDEI stacks, which should
> presumably be given their own SCS. SDEI is effectively a software-NMI,
> so it should almost certainly have the same treatement as IRQ.

Makes sense. I'll take a look at adding shadow stacks for the SDEI handler.

> Can we please fold this comment into the one above, and have:
>
>         /*
>          * The callee-saved regs (x19-x29) should be preserved between
>          * irq_stack_entry and irq_stack_exit.
>          */
>         .macro irq_stack_exit
>         mov     sp, x19
> #ifdef CONFIG_SHADOW_CALL_STACK
>         mov     x18, x20
> #endif
>         .endm

Sure, I'll change this in the next version.

Sami
