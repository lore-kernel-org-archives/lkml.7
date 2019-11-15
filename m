Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2623FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F234F20730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DPVoi3lq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfKOSel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:34:41 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46320 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfKOSek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:34:40 -0500
Received: by mail-vs1-f68.google.com with SMTP id m6so6931356vsn.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/RQj5FqYPBFFb/BHpJq3oq0/JIX3F5mcr3Ic1KDLoA=;
        b=DPVoi3lqXCZqeWh9romeMaws5hqXk7f+VlyR9XfhSR/9BdSIhcYmEux7SQ5St6jgAv
         Qy7JHhLn5W/E49pgWgOuvApN0oQk7kKUVdvzqM0GYzY6xGnHrcu3/C3H75y46ixSvuca
         LjPAO51k95incrTQsuJOy8ZRL6zlZ92V+cSt7WAY8zd/QGfPmISheb/46Q0qXikywE7H
         4Xh/pOiL99Mk+H/Q9TdrDS1OLq9XHIwJxh3HXyW7oVjDzKgHZwFJFMojZFKSuD9lUD8s
         TsrwyDeDC5tuRiLuIUH3CjrVYpkyH7ytqD6EnefisDfsVDoa6xNUGa6ZrfAwBeh0RQqM
         vZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/RQj5FqYPBFFb/BHpJq3oq0/JIX3F5mcr3Ic1KDLoA=;
        b=dpjIMXImc0HQtWl1gSvlMRaA/jUTq1f7LpZv1AV1iWOCQh/TNqEbFPgMRjRh14LbIh
         /twRYy7g3KMi+LMTIY95+NqJGfiIxmx4bOFqo/XB3j4IOZ0s5jX2Mp2+COSbe7tQIjPL
         S1Ke8MZdjoN54vGjzIbv8a8N9uxUrTkRl8+ZnquxeIJ5EYrYGcBjG1sHCH2S6nLl4FUR
         ZFJQOC3mZva2XUqOkRfoJ4SyswE/DFpZrYIY3K71ddtmziZZOEk6UZq6B5kY2eazt93b
         dnox+XE9R2sfF9Z4dBhqIBOE3+vkY0hFoSxypLwzW4MZf2Jd6dxPNPfeCgmVZI3rfO6Y
         N0kQ==
X-Gm-Message-State: APjAAAVWLAFy/FfnpPemzcnKE2AZQWDJQg/9LyRCzxnhIkr4wE8V8DeW
        zWuxR/ikWFDzLO6ZBVrXZn9LJJLTBxTDTMJYLk3rHw==
X-Google-Smtp-Source: APXvYqy9ZihhNwSz15zAc2n9wuqx0KKCFEmVQyQmPiar9gQiv4PEvu699gEh+PcCmRyXpyUO7fCyzGA8P+JoII/zuY4=
X-Received: by 2002:a67:e951:: with SMTP id p17mr5243152vso.112.1573842878866;
 Fri, 15 Nov 2019 10:34:38 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191105235608.107702-1-samitolvanen@google.com> <20191105235608.107702-6-samitolvanen@google.com>
 <20191115153705.GJ41572@lakrids.cambridge.arm.com>
In-Reply-To: <20191115153705.GJ41572@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 15 Nov 2019 10:34:25 -0800
Message-ID: <CABCJKucsJxXJ6tBYSify-2FS-P1rC=vEKTo+HdhN2e0K9fcBow@mail.gmail.com>
Subject: Re: [PATCH v5 05/14] add support for Clang's Shadow Call Stack (SCS)
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

On Fri, Nov 15, 2019 at 7:37 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > +config SHADOW_CALL_STACK_VMAP
> > +     bool
> > +     depends on SHADOW_CALL_STACK
> > +     help
> > +       Use virtually mapped shadow call stacks. Selecting this option
> > +       provides better stack exhaustion protection, but increases per-thread
> > +       memory consumption as a full page is allocated for each shadow stack.
>
> The bool needs some display text to make it selectable.
>
> This should probably be below SHADOW_CALL_STACK so that when it shows up
> in menuconfig it's where you'd expect it to be.
>
> I locally hacked that in, but when building defconfig +
> SHADOW_CALL_STACK + SHADOW_CALL_STACK_VMAP, the build explodes as below:

Ugh, thanks for pointing this out. I'll fix this in v6.

Sami
