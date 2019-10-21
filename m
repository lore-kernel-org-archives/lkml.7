Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9884CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEAA205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BXwbjyQH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfJUQHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:07:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40633 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:07:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id 15so2735020pgt.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JE8U2Fghv6YjjweCRTqDn5FZUlMFhhM8tZP7QTcsL4M=;
        b=BXwbjyQHcxJWNiy0iXKopawMWLVVLer31/iixLJkLYJrr0DN6W/g3Yxd8AhYLMw4GY
         yaOOYp6clpQlM8wBCeAsr7WNscSUW0a/CNbCltgSRmtM67DKbQ4DtyJUrsqntno1wI5y
         6L8iL7u4BsmyrJM63Dgery3dZ3UK4EZQgDH+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JE8U2Fghv6YjjweCRTqDn5FZUlMFhhM8tZP7QTcsL4M=;
        b=d7STCR3oFyt/srHkOA27vp/aAOwoQcpmp3m1z1z7VYlFCRnV73FgMKty4yHcvVF0M0
         TW8GlJIRGLY+jAqn58QpKZT5T7rG/XrKo2vsSiVc1mggDWGOo1cHEO37v0Z75pctT7li
         IS6ULs3JOYaFL4hovgtBp0SlgfMEiprWZGqlhfbv8vCyvq+FGLlaNH0lMNzDBtQOnNAO
         YGyPpoUMFJVfhTBwrNXApw+Rgr4TRCJ7EopidCHq+2RgDDUA3D3IcI6Ip5dqLzsz4TLX
         8ttI8XFvXXqgEdl5uIV2BbtoK/ZykRmh0H+JvM0rY8GaRvmbyjSTrA85L6VAdHqUtb4K
         6I9Q==
X-Gm-Message-State: APjAAAWQRmCcf4L237VKjnTlMNup0hwZ6dewDfwKe7ntz5uXEf+ZHyGH
        bEJv/buhDQol3hJCPjXIHQkNsQ==
X-Google-Smtp-Source: APXvYqwJTcp7CnYya1sildKDZQhELifTwgg5siNr/xx7tKpVABk+cPNBC7anzYKvXWswmQ1TD7x5Qg==
X-Received: by 2002:aa7:96a9:: with SMTP id g9mr23757769pfk.147.1571674020135;
        Mon, 21 Oct 2019 09:07:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x139sm18509941pgx.92.2019.10.21.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:06:59 -0700 (PDT)
Date:   Mon, 21 Oct 2019 09:06:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 16/18] arm64: kprobes: fix kprobes without
 CONFIG_KRETPROBES
Message-ID: <201910210905.7494C5C@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-17-samitolvanen@google.com>
 <CAKv+Gu-88USO+fbjBgj35B4fUQ7A_t9nHO_swyN=T1q1G2wViA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-88USO+fbjBgj35B4fUQ7A_t9nHO_swyN=T1q1G2wViA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 08:21:48AM +0200, Ard Biesheuvel wrote:
> On Fri, 18 Oct 2019 at 18:11, Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > This allows CONFIG_KRETPROBES to be disabled without disabling
> > kprobes entirely.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> Can we make kretprobes work with the shadow call stack instead?

I've been viewing that as "next steps". This series is the first step:
actually gaining the feature and clearly indicating where future
improvements can live.

-- 
Kees Cook
