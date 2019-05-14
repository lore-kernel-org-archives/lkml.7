Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF8C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A7720873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rbhoLPTD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfENWqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:46:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38269 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfENWqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:46:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so287675pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 15:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SB/GaKUPZ9drIILKtfO141NqoI9UYS/XADh4R9X0GN8=;
        b=rbhoLPTDosnfXVYvhUia77mlOfX6WMwhmLfj6XzcWyIJTjPmzHi/avLOHKstrb0dtF
         ckwrB2CelU+kS5urLSixvlsHBZfsygzddMrSvq+bpW3Z9rJXly92YepoIrt0acZGGGPc
         hL4qxLvVlXzu08OsDwz3b1WDgm+ZvWxcy06DE+I+xSyzrXdwY675mP8sCr4UZFap1Oo9
         /xK9pN1p6ZLGc1jUjnINb4CyXkHLoi9vC5viVuYqndygFUUscdfF0a75aJVm0Q2qXxvR
         pl8wFdcfK66G/BlMq8KMFNZ/U/6RT0JZyhgyKfVtlLS50B46MZdvyYONHZQujdgPBOsN
         RJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SB/GaKUPZ9drIILKtfO141NqoI9UYS/XADh4R9X0GN8=;
        b=D+g0ex1lCXwXEBZMQZtEH6x/O3SZRDgtKU6qPzqFpfJEWHrzKK8VzjSBAoM4Cs2FF/
         IHT6ZctmSFLdGZVRv+ynKuFR+diL9tlt5BKhqb53PxsVkmPbO4QMCV5z0umfDYGXseNb
         JOYu2D76Kpvp4vGxhwUqUz++GErWIGbdP4lJopBdOb3C99s0UQybtwAoAKE1/IXW/n4n
         u6ZJdD5jHJcctjhJzUSJ8BmO1Pz95r2W4+AbNhdLv2/W1dXyq6UnJObdxLSThXuiBodL
         Cj/vhugyWXE93HI6RVAdBqKLf1njInVBV4Lh+z8DyTO9X29CPhGUgHPBVB2iDTS+k80g
         ag1A==
X-Gm-Message-State: APjAAAVZYqqlYRikPFbLMGEZFEmmkHbNoWjdXWm4EpV8273KqRgInSmf
        aqrFD2tGWvWZbCeH2Pk5Ecr0Vtr3N1RRJMRst609Eg==
X-Google-Smtp-Source: APXvYqxHAUMyM5v7d4gVftLvNhzAZuJAWiQJ/8g/8Kha/jDtvYekW4ICYKoKEhK3RpCEdj5oXiWKIedno4VZm0D3ZpM=
X-Received: by 2002:a63:441c:: with SMTP id r28mr40571374pga.255.1557874012465;
 Tue, 14 May 2019 15:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190514224047.28505-1-natechancellor@gmail.com>
In-Reply-To: <20190514224047.28505-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 May 2019 15:46:40 -0700
Message-ID: <CAKwvOdk1Zr+YJc8Q5YNi+48K_ib9qJ1WPww8QWir=EWhqBaNvw@mail.gmail.com>
Subject: Re: [PATCH] objtool: Allow AR to be overridden with HOSTAR
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.On Tue, May 14, 2019 at 3:41 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Currently, this Makefile hardcodes GNU ar, meaning that if it is not
> available, there is no way to supply a different one and the build will
> fail.
>
> $ make AR=llvm-ar CC=clang LD=ld.lld HOSTAR=llvm-ar HOSTCC=clang \
>        HOSTLD=ld.lld HOSTLDFLAGS=-fuse-ld=lld defconfig modules_prepare
> ...
>   AR       /out/tools/objtool/libsubcmd.a
> /bin/sh: 1: ar: not found
> ...
>
> Follow the logic of HOST{CC,LD} and allow the user to specify a
> different ar tool via HOSTAR (which is used elsewhere in other
> tools/ Makefiles).
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/481
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  tools/objtool/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 53f8be0f4a1f..88158239622b 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -7,11 +7,12 @@ ARCH := x86
>  endif
>
>  # always use the host compiler
> +HOSTAR ?= ar
>  HOSTCC ?= gcc
>  HOSTLD ?= ld
> +AR      = $(HOSTAR)
>  CC      = $(HOSTCC)
>  LD      = $(HOSTLD)
> -AR      = ar

+ Kbuild
Seems to match what's going on in tools/perf/Makefile.perf and
tools/build/Makefile. Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
