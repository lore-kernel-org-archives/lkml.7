Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B77CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E092F20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cCDDMZX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbfJVQa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:30:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45101 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388862AbfJVQa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:30:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id b4so2046281pfr.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9VocBe87yk1uP4ALav5qYjXAzabfv0t7mZSWKaL+grs=;
        b=cCDDMZX0Jb2x10Ffc7B0hkZ/5rVJCIBvVRh+a3P1Z1H4X1pBo5MR6tNWJt0xVPzO24
         HshZq9Bj75NQmwJiHJTlcyjhNcexCdiCBasoYdcaHpoLfCkaieILhHGw5KUeR9u/QAKh
         9357+QmmIdmNEZVpouxbQBX8ie718Utq8dSVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9VocBe87yk1uP4ALav5qYjXAzabfv0t7mZSWKaL+grs=;
        b=bxL2dgVDUK0cnX+WMfcEB8awyg2OcW7lSgds6PiRnzijnNUL0AHCHI5VoxTnAQX4kG
         bH5ofOa17d+zdQcv+SNtUsVlO1oIGgu0jarivPIN0MC5k4vWYAg1DwV1q0zBIaBiwzCs
         8IfBHKQRHDRzAuxScPItXGm9pcqQhUkD1kTIvYsjTRKJ95ASX5JkS9l9n7eW+RvEKw2U
         dOfnz8qUuTOJAR/68p8jC+LbbHzoAoKcdTaxGMcjwAStBoAml5DX5sX3esKoA9W1vbHs
         efhHgbTZlbS1eZTH7nKDQnvMn0EnWIzu330TQjgie7pkAFGnKCtXI5PuGnWYQcZLrjIT
         D3EQ==
X-Gm-Message-State: APjAAAXKEJiKvcvOYp8o3Sz7vqTJwgxNAVoqOUsMroKkomR3gpUWWPWT
        e/zrFuAgpBIW49MDnmMOud7cWg==
X-Google-Smtp-Source: APXvYqwQTN+ovisoniBa1n9E3Frz5MHhvSc1BSk0yKuMv/BUOTRh21Gh2G29DkEAvhwb3Gv+V36/7A==
X-Received: by 2002:aa7:95b9:: with SMTP id a25mr5109950pfk.181.1571761855535;
        Tue, 22 Oct 2019 09:30:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z4sm17711787pjt.17.2019.10.22.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 09:30:54 -0700 (PDT)
Date:   Tue, 22 Oct 2019 09:30:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <201910220929.ADF807CC@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com>
 <20191022162826.GC699@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022162826.GC699@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:28:27PM +0100, Mark Rutland wrote:
> On Fri, Oct 18, 2019 at 09:10:21AM -0700, Sami Tolvanen wrote:
> > This change adds generic support for Clang's Shadow Call Stack, which
> > uses a shadow stack to protect return addresses from being overwritten
> > by an attacker. Details are available here:
> > 
> >   https://clang.llvm.org/docs/ShadowCallStack.html
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  Makefile                       |   6 ++
> >  arch/Kconfig                   |  39 ++++++++
> >  include/linux/compiler-clang.h |   2 +
> >  include/linux/compiler_types.h |   4 +
> >  include/linux/scs.h            |  88 ++++++++++++++++++
> >  init/init_task.c               |   6 ++
> >  init/main.c                    |   3 +
> >  kernel/Makefile                |   1 +
> >  kernel/fork.c                  |   9 ++
> >  kernel/sched/core.c            |   2 +
> >  kernel/sched/sched.h           |   1 +
> >  kernel/scs.c                   | 162 +++++++++++++++++++++++++++++++++
> >  12 files changed, 323 insertions(+)
> >  create mode 100644 include/linux/scs.h
> >  create mode 100644 kernel/scs.c
> > 
> > diff --git a/Makefile b/Makefile
> > index ffd7a912fc46..e401fa500f62 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -846,6 +846,12 @@ ifdef CONFIG_LIVEPATCH
> >  KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
> >  endif
> >  
> > +ifdef CONFIG_SHADOW_CALL_STACK
> > +KBUILD_CFLAGS	+= -fsanitize=shadow-call-stack
> > +DISABLE_SCS	:= -fno-sanitize=shadow-call-stack
> > +export DISABLE_SCS
> > +endif
> 
> I think it would be preferable to follow the example of CC_FLAGS_FTRACE
> so that this can be filtered out, e.g.
> 
> ifdef CONFIG_SHADOW_CALL_STACK
> CFLAGS_SCS := -fsanitize=shadow-call-stack
  ^^^ was this meant to be CC_FLAGS_SCS here

> KBUILD_CFLAGS += $(CFLAGS_SCS)
                     ^^^ and here?

> export CC_FLAGS_SCS
> endif
> 
> ... with removal being:
> 
> CFLAGS_REMOVE := $(CC_FLAGS_SCS)
> 
> ... or:
> 
> CFLAGS_REMOVE_obj.o := $(CC_FLAGS_SCS)
> 
> That way you only need to define the flags once, so the enable and
> disable falgs remain in sync by construction.
> 
> [...]

-- 
Kees Cook
