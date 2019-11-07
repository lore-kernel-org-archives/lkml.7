Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFD2C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93B621D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKwEOayk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbfKGKvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:51:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54624 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKGKvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:51:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id z26so1937996wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OvMY+y9t+JrwQeXlyarqTJXF9VkquzjWewr7iQbYsdg=;
        b=HKwEOaykRl1GaA5HUx+9TcTEGGb7oNvHt2Y9owJSyCUoyem7fwAkvwQBHkQI2FPvWP
         uD0rulX0IgiMsrRSKmb0gtmwI0JV854FA+6gSUC796H6UFIZXFzBZJ2xOUivRHTVQ7hz
         7wCtkr90dGCFRE9MIxHYuABRTVM2CaXJ2g8zZntLAHf9IB+LEKPFIzPuvH4ZT93oEQRw
         CkmsEypotk24LHmyt9u5PQ+ufkPLAAuWaKVGxSQQlNXe6maf3XOUhitNWnifjM/Y/KdZ
         9bZxWAB3xnwJN98FAhenJ2RmIObgbkD+CCxooE1AqOAT7pNw5Zsa/8pH6e9bXw4Thfeb
         Hl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvMY+y9t+JrwQeXlyarqTJXF9VkquzjWewr7iQbYsdg=;
        b=X2lkEKKj/uQAe6Lcg4xcBi17ca1A6OyN3EpLvOY+GCzm8q/oW86WHit/EB27cceslz
         eAMs81rcctfHvYXAkoXMxZJnieBXgTdiEK/i1PyoAqvJODKZpI7nWgXxy9l9Ph34i+6C
         rPk0FVZd6d/G3kuBehlmMGksEamHxLlmwBolvr6qtVw/pwGB6+G0kiH1N5iKPICLMwJh
         ikmGnYESQUL6wruyXdVFSu7a9LQWk8cCK3UiXZCo8iD06+3YxDj7YkKln0FYjVWObhpG
         zlAugtEpGYUxIpJ4tYr+KzC9xA+D8p3r0MxGhoqgViFLOdJMRsAJ4MQR9RJyMCToltTE
         gp8g==
X-Gm-Message-State: APjAAAUJSxm4iZTFBWjDdrb5YPXX/FOC6Tek1gd0ye5CzVTMYB7iD/RM
        0/PkVj5KL50fHOCoB0UjYCD7bRgtioFGK9IYirlo5Q==
X-Google-Smtp-Source: APXvYqxZvEiiT90pDsnYPJdaxTdcxJka6vY+KKCUJ0OKpqIG88pZzG10bA4lVqLf/rqLW8X5UhbBGNpzEr6t7euuMFw=
X-Received: by 2002:a1c:b1c3:: with SMTP id a186mr2297717wmf.10.1573123909498;
 Thu, 07 Nov 2019 02:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com> <20191105235608.107702-12-samitolvanen@google.com>
 <CANiq72mZC-G_R_RJjapZS+NvkQcrjdiri0NyHUgesFzUpe-MDg@mail.gmail.com>
In-Reply-To: <CANiq72mZC-G_R_RJjapZS+NvkQcrjdiri0NyHUgesFzUpe-MDg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 7 Nov 2019 11:51:38 +0100
Message-ID: <CAKv+Gu9DD12BPV_jNv9Hjw4oSiZvtdiVVjB-B8WLXCoPL4CA9Q@mail.gmail.com>
Subject: Re: [PATCH v5 11/14] arm64: efi: restore x18 if it was corrupted
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Nov 2019 at 05:46, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Nov 6, 2019 at 12:56 AM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > If we detect a corrupted x18 and SCS is enabled, restore the register
> > before jumping back to instrumented code. This is safe, because the
> > wrapper is called with preemption disabled and a separate shadow stack
> > is used for interrupt handling.
>
> In case you do v6: I think putting the explanation about why this is
> safe in the existing comment would be best given it is justifying a
> subtlety of the code rather than the change itself. Ard?
>

Agreed, but only if you have to respin for other reasons.
