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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F812084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 07:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3fsfdQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDBH4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 03:56:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33485 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfDBH4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 03:56:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so10778095edg.0;
        Tue, 02 Apr 2019 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0GMyW5OYCM8A52qbttSxDbDzNtgcJTEWcZk4yeDJu9E=;
        b=P3fsfdQpDEpL47Ztdr6nlnBi8ZOQxaYu+rXksovdhgG/GkQT1nOXzkoPUsiyonWYHd
         YnQ3mkHoAoX0eZSja0mj+pGev2QGtFh6MMTag4wGqiBzYndsRA6/TwJ3hVuXqOFoVGKr
         VSFaf563Zs3PdLNj25wRutqwKUtbiOg6SKIOGTCPc/mmtQB116JeFECTy9V+8XBba9nt
         yq6yatszIXRJ3N1vk4W4kmiOQGO68BeE9zc9HGoCVmR0B5PsUP7ixLfjS5ndJkS2RMXc
         1P48YBbtqWBhY1xmpGX2siwxHhK+aVBsXgU13tE37L6PTLfHE0SZV+MsY0cJRBgcYcPS
         hPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0GMyW5OYCM8A52qbttSxDbDzNtgcJTEWcZk4yeDJu9E=;
        b=qq7KmfI6ZdepWJ+YGCLwEUBqYBjzR0rjKeaywuG9OSKfPCRYCh+DMImZdabo2j1kOk
         9u+0hmzRKVTg+xhHHuZXrEqw7Amfcnj5Io2rb2u2JpeQUzOkuomjKdGtSdCEcgmBFw07
         7Z+6HZ3JwhkH2LFeE05/bNTw/O+mL0LvNreEmoBAx9S3ji7dgoSV2X8Yc4KkHzOgm3TU
         Xc4ZY6oF75udmMAcJwbrMZ+ksWf2ndHu28uXuANq4FCYog/pVdxK+jdh5O6n8RQkpZZZ
         rl8qz5k3zTL2zPuee3Ddp3mS0kV6h0umeOcXFzo7wYMfs756hoeHvZIeh9Z69PdjWZyq
         jL4g==
X-Gm-Message-State: APjAAAVeKSoP4wzcx7u7VyfDkFiPwxqwnGfp5QmDVdtDJNa5Fm2x6A6r
        4IvN5A8B7MtJ3OaEwq1HWyM=
X-Google-Smtp-Source: APXvYqz0uDFZ6LlsCJv9GHezgU+HyNoqOfXZA6bGsJkBc0MIo+XxrqC5BGSvKqAJK53FnKYwbfTesA==
X-Received: by 2002:a50:8835:: with SMTP id b50mr46327862edb.262.1554191766219;
        Tue, 02 Apr 2019 00:56:06 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id p16sm2327241ejb.13.2019.04.02.00.56.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Apr 2019 00:56:05 -0700 (PDT)
Date:   Tue, 2 Apr 2019 00:56:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Makefile: lld: tell clang to use lld
Message-ID: <20190402075603.GA5308@archlinux-ryzen>
References: <CAK7LNAQw7nPwykOEV5i+yWjkxzgf1gPa5ewFhDxbbn8XXjwFUA@mail.gmail.com>
 <20190402070858.49597-1-ndesaulniers@google.com>
 <CA+icZUUgvw7G0rrrhLL0KGXgeuPAxnSAQCopqWrqAAXvjSK=Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUUgvw7G0rrrhLL0KGXgeuPAxnSAQCopqWrqAAXvjSK=Yw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 09:52:13AM +0200, Sedat Dilek wrote:
> On Tue, Apr 2, 2019 at 9:09 AM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > This is needed because clang doesn't select which linker to use based on
> > $LD but rather -fuse-ld={bfd,gold,lld,<absolute path to linker>}.  This
> > is problematic especially for cc-ldoption, which checks for linker flag
> > support via invoking the compiler, rather than the linker.
> >
> > Select the linker via absolute path from $PATH via `which`. This allows
> > you to build with:
> >
> > $ make LD=ld.lld
> > $ make LD=ld.lld-8
> > $ make LD=/path/to/ld.lld
> >
> > Add -Qunused-arguments to KBUILD_CPPFLAGS when using LLD, as otherwise
> > Clang likes to complain about -fuse-lld= being unused when compiling but
> > not linking (-c) such as when cc-option is used.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/342
> > Link: https://github.com/ClangBuiltLinux/linux/issues/366
> > Link: https://github.com/ClangBuiltLinux/linux/issues/357
> > Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
> > Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Thanks for bringing this up again, Nick.
> 
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com> (see [1]).
> 
> I suggest to do a separate patch on the move of  "KBUILD_CPPFLAGS +=
> -Qunused-arguments".

I think it makes sense to do it all in one patch as it doesn't make much
sense to do the move without this change. Nick already sent a v4 doing
this.

Cheers,
Nathan

> ( Patch was attached in [2],[3]. )
> 
> As pointed by Nathan this needs the removal in the original code-block.
> 
> Other than that:
> 
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> 
> [1] https://github.com/ClangBuiltLinux/linux/issues/366#issuecomment-466836735
> [2] https://github.com/ClangBuiltLinux/linux/issues/366#issuecomment-467118373
> [3] https://github.com/ClangBuiltLinux/linux/files/2901865/kbuild-clang-lld-Move-Qunused-arguments-CPPFLAGS-patch.txt
> 
> > ---
> > Changes V2->V3:
> > * Use absolute path based on `which $LD` as per Masahiro.
> > * Add -Qunused-arguments.
> > * Drop tested-by/reviewed-by tags, since this patched has changed enough
> >   to warrant re-testing/re-review, IMO.
> > * Add more info to the commit message.
> > Changes V1->V2:
> > * add reviewed and tested by tags.
> > * move this addition up 2 statments so that it's properly added to
> >   KBUILD_*FLAGS as per Nathan.
> >
> >  Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 026fbc450906..895c076b6305 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -514,6 +514,10 @@ ifneq ($(GCC_TOOLCHAIN),)
> >  CLANG_FLAGS    += --gcc-toolchain=$(GCC_TOOLCHAIN)
> >  endif
> >  CLANG_FLAGS    += -no-integrated-as
> > +ifneq ($(shell $(LD) --version 2>&1 | head -n 1 | grep LLD),)
> > +CLANG_FLAGS    += -fuse-ld=$(shell which $(LD))
> > +KBUILD_CPPFLAGS += -Qunused-arguments
> > +endif
> >  KBUILD_CFLAGS  += $(CLANG_FLAGS)
> >  KBUILD_AFLAGS  += $(CLANG_FLAGS)
> >  export CLANG_FLAGS
> > --
> > 2.21.0.392.gf8f6787159e-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To post to this group, send email to clang-built-linux@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190402070858.49597-1-ndesaulniers%40google.com.
> > For more options, visit https://groups.google.com/d/optout.
