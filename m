Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CECCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA2462064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEpdi/vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634399AbfJRRI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:08:29 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46587 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393426AbfJRRI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:08:29 -0400
Received: by mail-vs1-f66.google.com with SMTP id z14so4476842vsz.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icZdr5RXUlfIVPQUZ5ag+GwSMhqiqaO3j83adcgUQWY=;
        b=GEpdi/vgYB3Dbp/h96wQEbZdgTLwWntVY74quNjgbeeg+hzsMk/zZrigXjhZJrnpFb
         1sCxD/BkPu3n7ILO/vPRn92A4D4Pr6zGfOnoOhHoLbcienF2os3HqnY38YjnZQJ6CPhG
         2cEVlEkOD94zB1mmdsNc/rgKAweeHHSgQwOR9VQJUeRc6eDJnhZALabYW62do/0UnUKN
         RPD8sUmEbIHcS6c0uuy1U053bUE0xElIjmjrspvbBm1j/HBDqlS+YM/Eb3VkslwJ1EmK
         DxiIUIGOP9sE/R5mKuzwIB5v1VMKO+wkGaN/oK/qSJiYn43BeozwBBvtWYrtPX2GM7z4
         dH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icZdr5RXUlfIVPQUZ5ag+GwSMhqiqaO3j83adcgUQWY=;
        b=FOj7Rb1cNWKXqxjw519wZRRwzm8TWVobJl7cr0lBM6Ds7ZqJmZRluhd4Wue9MsGcJ2
         QkMh8uCo1irPw785E+EQ1ExlALmsrBzrTBzz6CUc1JnQIxfR0zHqLHNOfk8W1FlO0VbE
         5JjS/tGR1s+opTqsbDdImn8Z93pvDSvnupzmmUPxIHowd+uJ+nLfJNO5vEVcDzxY9atP
         FdBDbss0zIwcQb947WtYHBIHgnUdeUZGi23cFjs/LJPr6UI+N92o3LsIPVtcgheXaOel
         e7CsB2yMKDepqJuvpY2lLQMc2L1oxJLIcjP0Xs5cjoIH0+3YD+lMtedVB/GC4c69OStP
         IemQ==
X-Gm-Message-State: APjAAAVSm1tTNdCL/n/zfty8imPf200xmMupmbQn7cxB0nmT4d5u8ITw
        E1753NBn4OICfB2H1yyCzl/EHMU2JGwy1L9Ldd/mJg==
X-Google-Smtp-Source: APXvYqyzzIiNyDr2Id6Kr8DVoqWVgixdTZAxPTLo1g0mx6+HWc+w18Nu6n4FjKGbHpDO9wjpt2GMM+GyVFTzkMX0z78=
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr6015143vsp.104.1571418507964;
 Fri, 18 Oct 2019 10:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-10-samitolvanen@google.com> <20191018130127.23746ff2@gandalf.local.home>
In-Reply-To: <20191018130127.23746ff2@gandalf.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 18 Oct 2019 10:08:16 -0700
Message-ID: <CABCJKufdDxJ_q-8Sj3+4rPuhAB3bdo_EN=DybZF5eenwZB4v3g@mail.gmail.com>
Subject: Re: [PATCH 09/18] trace: disable function graph tracing with SCS
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:01 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> NAK, Put this in the arch code.

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 41a9b4257b72..d68339987604 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -149,7 +149,7 @@ config ARM64
>         select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_FUNCTION_TRACER
>         select HAVE_FUNCTION_ERROR_INJECTION
> -       select HAVE_FUNCTION_GRAPH_TRACER
> +       select HAVE_FUNCTION_GRAPH_TRACER if ROP_PROTECTION_NONE
>         select HAVE_GCC_PLUGINS
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS
>         select HAVE_IRQ_TIME_ACCOUNTING

Thanks, Steven. I'll fix this and kretprobes in v2.

Sami
