Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B673C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0A220835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 18:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCYP50pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfD3SWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:22:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35282 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3SWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 14:22:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id t21so7478098pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gh+NJvTsghWDsJJd+KP5aQAqiQ/BIEZcAYj6W4VprQI=;
        b=RCYP50pmtnK2vIKT9YIdEJ1LQlSTEIZA674chw7eV/BFW7oEN9ceMrVTyHwyyYdIVL
         eBiRdidlLXaqDm+3BDlBGDTJUwmtIMSeYzNbniW9CkMal12siiQrId6hSc1qpXiLbNt3
         zjNUwiXMBBa8dt+enbzp/1zREVJ0iknI2ZHICzpOj4DSN2zZroYveJ9mGsiZbVkWAedo
         75RPjhD1i6p5D86+My+jQygzq85/wpamrIQVGuKRKfF63IY5bqEGhBegKCoRBHqqkUga
         Fn/q7tyEMWu3i2Hq5TTz2ic/ow0PVmrkimF6m0HemT4V2u45+qL/J03rxicCN+Bt6hhY
         lmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh+NJvTsghWDsJJd+KP5aQAqiQ/BIEZcAYj6W4VprQI=;
        b=Q3YURsLr70z2zC+T7AgX+0Xl1TPuEkkUYcaLwFTD7iWIzn16SXnvGilQhA9iqz0Y3/
         4I9Ut5kGHsCyGUIbzp6tAEDHnZwjNJtyJlrmEHPcj0J42bJZxPDc54S9SociplPJTWB6
         6UnjzyRuu0IIwwqDNuiBNahUw+vI8xgRCFZupklhNYo3HzemjOEX9lJyz4U2s3x0fzuJ
         O5VoNOtz0DyWJKeq4zyLzlmho7LIfQM6GriExSqnASFUx9p3KaPhfZ9ob919eSaSkR8t
         p3qYmNireMNY/gWJ2NdkdNWDOJEqJGbZXVSeNSlVKHOgvOXl6u7NljrngGd2ShhWpCxk
         jUOw==
X-Gm-Message-State: APjAAAVpIN1X32tVw76O9CVLCN9nQB9zHtHxJDWVZFQu5FBY858z1eRt
        Csdb40eqa0qZHRpZZAK+eqhTZQ8JNvAyLGoRk63xSg==
X-Google-Smtp-Source: APXvYqwYJ6eM52XsMZDC7jBMvQu3AJAj2ucSapdyiDxTsHaIu2jVgdxiKCAoV5btcg3+Zu5s9FTQLHarko4Yg47qjG0=
X-Received: by 2002:a63:4558:: with SMTP id u24mr65263866pgk.225.1556648566822;
 Tue, 30 Apr 2019 11:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190426130015.GA12483@archlinux-i9> <20190426190603.5982-1-linux@rasmusvillemoes.dk>
 <CAKwvOd=Qzs8gAenS6-GkiSmrwxwJA7wChJ6FUE5+=LPAj4XSfQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=Qzs8gAenS6-GkiSmrwxwJA7wChJ6FUE5+=LPAj4XSfQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 30 Apr 2019 11:22:35 -0700
Message-ID: <CAKwvOdkg=Xo_C_hQrnHt-t-RfcDrBYsrBZUwsKjfXSPhkynOHQ@mail.gmail.com>
Subject: Re: [PATCH 11/10] arm64: unbreak DYNAMIC_DEBUG=y build with clang
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Baron <jbaron@akamai.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>, Dan Rue <dan.rue@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:32 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Apr 26, 2019 at 12:06 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> >
> > Current versions of clang does not like the %c modifier in inline
> > assembly for targets other than x86, so any DYNAMIC_DEBUG=y build
> > fails on arm64. A fix is likely to land in 9.0 (see
> > https://github.com/ClangBuiltLinux/linux/issues/456), but unbreak the
> > build for older versions.
> >
> > Fixes: arm64: select DYNAMIC_DEBUG_RELATIVE_POINTERS
> > Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> > Andrew, please apply and/or fold into 9/10.
> >
> >  arch/arm64/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index d0871d523d5d..315992e33b17 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -83,7 +83,7 @@ config ARM64
> >         select CRC32
> >         select DCACHE_WORD_ACCESS
> >         select DMA_DIRECT_REMAP
> > -       select DYNAMIC_DEBUG_RELATIVE_POINTERS
> > +       select DYNAMIC_DEBUG_RELATIVE_POINTERS if CC_IS_GCC || CLANG_VERSION >= 90000
>
> I just landed the fix for this in Clang, I think around the time you
> sent the patch.  Should ship in Clang 9.  Thanks for unbreaking our
> build.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

+ Dan
who's looking for this to get picked up to unbreak KernelCI arm64+clang builds
https://staging.kernelci.org/build/id/5cc6e080cf3a0f9d66257f6d/
-- 
Thanks,
~Nick Desaulniers
