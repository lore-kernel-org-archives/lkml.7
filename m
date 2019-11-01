Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23099CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB07821734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVdZ7udl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfKAQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:33:07 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38479 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKAQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:33:06 -0400
Received: by mail-vs1-f68.google.com with SMTP id b184so3189140vsc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5WHWvyJ9Hz5kosmku4ReDEqbYSNCjtYvPAtQ8gov0w=;
        b=mVdZ7udliBm1Ah/0SRYlDf6bwEJ6TL7x3JmnofXlcyZOXqi5Q9VBuiMbpvt9qFtviY
         O1dg12Mx/ZqNCdmPnMehixCUQwwDXQwkP8easpaC7ETmB8M+bGzkf5mtTCIfXJepYgXQ
         UpEXv0+Y/8IRh6Bt9tXSt5I5dm6Naa/8+P0Gfr7zVhf9zJ0enNNpTxkLjpUS3Y3FM1TQ
         K14mAw/P1HzmMF2Q3lOwbI6KFmRqbDNTH4h5du1QpSKj0tUoB4V/KntCBftt2t3ivGyo
         CvnopvuGe8ctEsWcfBzhSVdFtD8ECLxaPGft365BahwUkKRXVOufpCDz3m9fqW+WiVMo
         c2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5WHWvyJ9Hz5kosmku4ReDEqbYSNCjtYvPAtQ8gov0w=;
        b=DfbvkqYAJ0XOhC44NSKL7Bh/O14HLFF+Hx6OA1GWllkrS/9HurfboFEpzv63MYnqD3
         eTWamZOcWVfwCvCQ9hx0G3JPkHMcA/Yn1ZNocCYv8SDmh338Ejafs6NEGxuxlz1WBzFi
         i2x6m5d3kzKb5k5U36NkPcX3vCzBLI41k7YqBlyAHc8qt4Arg1sYj2eDkdH47OKUSl7w
         guZxpw5nn85NboHImXCj3Xat4xaUwxv5z9SNeGg6QjWYFKdtV8dRXyG43Rw8AmiAXvsJ
         tO+gXZcOvv05tzTV4QIZBeyO3DAA7OJYy2Qu4ROBbUh7wB14Pt2p5JvaXWz5WfkL/0jQ
         EyLw==
X-Gm-Message-State: APjAAAUaVtOalGdgRgeE8TFytEv80jB9lM+E+T0zoVjy6QPq4CiqBcz4
        6Bwo6W/Oqb5VDd3Lmk1ExtTjNpZ3M0FYjAmkO8uqVg==
X-Google-Smtp-Source: APXvYqyUC2VNoK3kn3nz3vybeugE+sMvvcm2WU0gwrr3Eljqv0y0V3sHBklXl+ihwCVizGZj+lsXZashNS/ogzG8fqQ=
X-Received: by 2002:a05:6102:36a:: with SMTP id f10mr1696654vsa.44.1572625985166;
 Fri, 01 Nov 2019 09:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com> <20191031164637.48901-8-samitolvanen@google.com>
 <201910312054.3064999E@keescook>
In-Reply-To: <201910312054.3064999E@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 1 Nov 2019 09:32:54 -0700
Message-ID: <CABCJKueAf3f-rHw8AXJKKi=kfnh+nBMpJP2Vb2DVqLUWZVmFqQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] scs: add support for stack usage debugging
To:     Kees Cook <keescook@chromium.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

On Thu, Oct 31, 2019 at 8:55 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 31, 2019 at 09:46:27AM -0700, samitolvanen@google.com wrote:
> > Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks.
>
> Did I miss it, or is there no Kconfig section for this? I just realized
> I can't find it. I was going to say "this commit log should explain
> why/when this option is used", but then figured it might be explained in
> the Kconfig ... but I couldn't find it. ;)

It's in lib/Kconfig.debug. But yes, I will add a commit message in v4.

Sami
