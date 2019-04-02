Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84363C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3C620830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVTc/8d1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfDBH1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:27:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39065 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfDBH1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:27:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id p20so10674421eds.6;
        Tue, 02 Apr 2019 00:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cA/b/nkb9WBsfSOKUo8nbbc8KTipOuDl/05pH+iF1oo=;
        b=jVTc/8d17VTNrLO2Dk86ssaQym/gPPCsnIA+MCcDcchkvg6H9zVNNY1EVKrwC+BtmC
         xRGImDgvjco8T0olMXsQGxBnr4vqL54aL+UcjagndBaoxJG3kDozCL8TStm7fbQkZvr4
         zEZKBOeKOmdV1EgR5Fn+GR5trc3NRp1N/JyKB2hOmWqd0pBSt6laws5qHOBTU1QNxvyB
         Zv2pE0HF7SvhCfxF5d+OdLF6nZzJxsXzfbI+I8MVfb0cco+xNJAEyQ6YioQQqD9UPNOQ
         x9704Q1eribYncIUNFkOSFIZ9xxIdVYUvnh8e3lCNwAeqCv9ejC6IJM+MmKBpM0Wzg6u
         YUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cA/b/nkb9WBsfSOKUo8nbbc8KTipOuDl/05pH+iF1oo=;
        b=PrpG8jJOb4b0SOp1K8JX4u357wKjbDTAAIHhPdI5MzggnAjYW2NcFhMkDS/fiMqNDr
         o2TkuKOc9vCr+8nw87lr28ipYoRReugK1t23jXWmC+3SGN79FkMd618yT1lTUWsiV6M8
         2qgyD2YRmXnS77/BjDsExtFfAPcKOjnYUmuxDhQTxTLPNZrIUv6NDfHCY41qQw1GMaJ7
         7EdOnr4QAz7zqFw4BHoX7EtKF2yd2p+GTU4TeAFw6LE1KgTKQ40qLUTrT1/T4XsmyxoK
         mcas+6kGEbNfAfD6svD+7oLGWstJiaquF/o5NmlZMHP7fUA9gzNSj0ggGWv9tFArw8Sq
         m0fA==
X-Gm-Message-State: APjAAAU2w3dSqn8rpXkR6D/en8kyd9AYImGJbXjlLXE2/2YWuKdr9RFO
        Isl5bczrXUjVxTjzGB7gmPY=
X-Google-Smtp-Source: APXvYqwcW17r6fDydot9+EbPSSdp4AwJXkferdClP8DKrtzE4YzVPSN9JBudDci3PUWvqz3kbIZrlg==
X-Received: by 2002:a17:906:3db1:: with SMTP id y17mr11907370ejh.90.1554190049433;
        Tue, 02 Apr 2019 00:27:29 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id j3sm2298229ejv.22.2019.04.02.00.27.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 00:27:28 -0700 (PDT)
Date:   Tue, 2 Apr 2019 00:27:26 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     yamada.masahiro@socionext.com, keescook@chromium.org,
        clang-built-linux@googlegroups.com,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Makefile: lld: tell clang to use lld
Message-ID: <20190402072726.GA16650@archlinux-ryzen>
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
 <20190402070858.49597-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402070858.49597-1-ndesaulniers@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 12:08:58AM -0700, Nick Desaulniers wrote:
> This is needed because clang doesn't select which linker to use based on
> $LD but rather -fuse-ld={bfd,gold,lld,<absolute path to linker>}.  This
> is problematic especially for cc-ldoption, which checks for linker flag
> support via invoking the compiler, rather than the linker.
> 
> Select the linker via absolute path from $PATH via `which`. This allows
> you to build with:
> 
> $ make LD=ld.lld
> $ make LD=ld.lld-8
> $ make LD=/path/to/ld.lld
> 
> Add -Qunused-arguments to KBUILD_CPPFLAGS when using LLD, as otherwise
> Clang likes to complain about -fuse-lld= being unused when compiling but
> not linking (-c) such as when cc-option is used.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/342
> Link: https://github.com/ClangBuiltLinux/linux/issues/366
> Link: https://github.com/ClangBuiltLinux/linux/issues/357
> Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V2->V3:
> * Use absolute path based on `which $LD` as per Masahiro.
> * Add -Qunused-arguments.
> * Drop tested-by/reviewed-by tags, since this patched has changed enough
>   to warrant re-testing/re-review, IMO.
> * Add more info to the commit message.
> Changes V1->V2:
> * add reviewed and tested by tags.
> * move this addition up 2 statments so that it's properly added to
>   KBUILD_*FLAGS as per Nathan.
> 
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 026fbc450906..895c076b6305 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -514,6 +514,10 @@ ifneq ($(GCC_TOOLCHAIN),)
>  CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
>  endif
>  CLANG_FLAGS	+= -no-integrated-as
> +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> +CLANG_FLAGS	+= -fuse-ld=$(shell which $(LD))
> +KBUILD_CPPFLAGS += -Qunused-arguments

We should remove the -Qunused-arguments call in the second clang block
at the same time. With that change:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> +endif
>  KBUILD_CFLAGS	+= $(CLANG_FLAGS)
>  KBUILD_AFLAGS	+= $(CLANG_FLAGS)
>  export CLANG_FLAGS
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
