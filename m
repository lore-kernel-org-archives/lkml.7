Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE20C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAF22064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ROop3CtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbfHOXER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:04:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44311 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729807AbfHOXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:04:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so1943783pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0paVUeRwkAoF6xRtck4YRzJFED8y2mJAR0FlFh8+FQ=;
        b=ROop3CtRsN1mpl3TlpwQuxZlYKsNcJlSl5Q0Z5CcVlEZmUVr/KJJzbpPoUtQmYiwrq
         6KJz1RYdzH2WeQjOHjapJC1s4YA2ITXtSIOVp+8riytN/H4DNksBCuL6UW1nXwc+I3UP
         /8Z7zmvc5Krp5G/CudBeMzMnWYDRYOWv113+8jy0bbIGRKLZTkHUGKtjpifEcZN9qKvE
         8cv9G7dSI7EYir+8q6gNM6Q9h4QBT114ulES49ubrOJMXzDIsXuKKDfsk3meWB7KfQa6
         loEjbeLOArWhBFOtJRS4Fa1ha0j9kBjtNYRt5+SM1blcM9aKm8QpKcHWx+OVm/bRRjUT
         SITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0paVUeRwkAoF6xRtck4YRzJFED8y2mJAR0FlFh8+FQ=;
        b=ZjdnK4J3PT1/bU1jn7q6AGv6b8fQdDiyBvqu/UyANsVevTczcaZjQ0XcJzOj0VBNJc
         orsfY37rjeIve8MTdDuy+YtThmVLzrW3Fb0mDEPqAk9ZPcTuDl+7/ucCsXw1NbDoNcy/
         bfCdoG3QGFDc/tGZQPI1xV5c23K2DmqCPuw4ef+1X54dYe+ifdOU7X1iTcM3ZLGACXbB
         XN0dM5o7JpVxNbJyRwkekt8Yeu1lDLp2xh41Vaw/iC6mwkogiLAUKcnRrxvY/bISUHGR
         NxpPdccoDxYUoBzsjG99XooR44y2frU1nVdV9PAlUUWvj8IxePy2EAI1Gu8XgXBLz1nv
         lNFw==
X-Gm-Message-State: APjAAAWL4AlwzPtp6tE/uCPCdP2a4fr46x58OuZWqVKqG4HjUCBlF4uD
        72gkoPnCK7nS3BpihZP8V7Z+L0PVYDWfAw6YeAJSrg==
X-Google-Smtp-Source: APXvYqxuQbVR4kKUXSrMUV3M2v/hOwCD7rK0veETUEER9twh5HLxnDFR6DSHVh6KLD1k8+doMTCclhImcMpzJcxCLzU=
X-Received: by 2002:a65:690b:: with SMTP id s11mr1686210pgq.10.1565910255496;
 Thu, 15 Aug 2019 16:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdk+NQCKZ4EXAukaKYK4R9CDaNWVY_aDxXaeQrLfo_Z=nw@mail.gmail.com>
 <20190815225844.145726-1-nhuck@google.com>
In-Reply-To: <20190815225844.145726-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Aug 2019 16:04:04 -0700
Message-ID: <CAKwvOdmu_=CM-8LOfi556t=ZPi+p2WVYcZ6Sk+ru+EfzPCb-JA@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: Require W=1 for -Wimplicit-fallthrough with clang
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Joe Perches <joe@perches.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 3:59 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang is updating to support -Wimplicit-fallthrough on C
> https://reviews.llvm.org/D64838. Since clang does not
> support the comment version of fallthrough annotations
> this update causes an additional 50k warnings. Most
> of these warnings (>49k) are duplicates from header files.
>
> This patch is intended to be reverted after the warnings
> have been cleaned up.
>
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> Changes v1->v2
> * Move code to preexisting ifdef
>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index a74ce2e3c33e..95973a1ee999 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -70,5 +70,6 @@ KBUILD_CFLAGS += -Wno-initializer-overrides
>  KBUILD_CFLAGS += -Wno-format
>  KBUILD_CFLAGS += -Wno-sign-compare
>  KBUILD_CFLAGS += -Wno-format-zero-length
> +KBUILD_CFLAGS += $(call cc-option,-Wno-implicit-fallthrough)

Clang seems to support -Wno-implicit-fallthrough since 3.2.  You can
remove the cc-option, since you'll need a newer clang than that to
build the kernel.
-- 
Thanks,
~Nick Desaulniers
