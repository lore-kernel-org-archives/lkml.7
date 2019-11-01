Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C5DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445FE2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FdSEwR9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfKATCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:02:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44811 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfKATCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:02:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id e10so7017642pgd.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2fG4DzCLulQ+v7huA1kdMQ2RtRpH3xT6PP3dcQOR3YM=;
        b=FdSEwR9X5l9Wqc+/eshiHPMlZ+qbVGkM0VrADZRZNoPKl47i8lf6Ah2ogK43O9mLBz
         C38lxuGZvsa0tFqnuBBHY2YWJOfGOTokdGNGz6+UQ9XWtZ1Qp16zcUsqtprBYXlv+ny5
         fD8DNC5oZHJ6AV27OHsxTC/ul2AuGnuvtGGk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2fG4DzCLulQ+v7huA1kdMQ2RtRpH3xT6PP3dcQOR3YM=;
        b=e18B8sB6gjCrvPVWieI0Bzq5PcqgZduZh753BFDf9y7N2QtDgffmJXEVUlkGyxk7lb
         +40k6sI1Emof9gmLZ12qWEAyOY4Waz/Hfx+6cjTN1kpcwVYMgMRY07IVeiOheUW/5Uee
         2gzA3cspEjgBiSrK2uC4myywe1JJWIFlZhPeMjipcfKH1Wo2GUSR/UqD1eX26cLlr8g8
         beERjotpaTwT9TyXz4uP80GAisEqdoV7kdb/ivh2MpBGC0dz+ke6rRKoRuHi5tMV0zWU
         JCpJoCGvHNBaHZQ/JHAS7P/YdNTRnGLUx4jFGovpJPBIbFw2cIk5+gf3Mq1QyfxY8z4M
         kEHA==
X-Gm-Message-State: APjAAAUQbHLMPYVghGrTXSJUajKimPLKbulk+VJYwV2fNuxlcUxEB8KH
        /4cp+2f6ho+B66D5NcY36S/8hw==
X-Google-Smtp-Source: APXvYqzEjD8mlyAQagoCql+H8OD47PXOJ5YDq8BZhhrYFD67Vj1PkcdsuEn3Dl9QXx9NFWLOxoUDbw==
X-Received: by 2002:a65:5a06:: with SMTP id y6mr15317180pgs.9.1572634935932;
        Fri, 01 Nov 2019 12:02:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w10sm7985756pjq.3.2019.11.01.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 12:02:14 -0700 (PDT)
Date:   Fri, 1 Nov 2019 12:02:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
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
Subject: Re: [PATCH v3 07/17] scs: add support for stack usage debugging
Message-ID: <201911011201.A070D143D@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191031164637.48901-1-samitolvanen@google.com>
 <20191031164637.48901-8-samitolvanen@google.com>
 <201910312054.3064999E@keescook>
 <CABCJKueAf3f-rHw8AXJKKi=kfnh+nBMpJP2Vb2DVqLUWZVmFqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKueAf3f-rHw8AXJKKi=kfnh+nBMpJP2Vb2DVqLUWZVmFqQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:32:54AM -0700, Sami Tolvanen wrote:
> On Thu, Oct 31, 2019 at 8:55 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Oct 31, 2019 at 09:46:27AM -0700, samitolvanen@google.com wrote:
> > > Implements CONFIG_DEBUG_STACK_USAGE for shadow stacks.
> >
> > Did I miss it, or is there no Kconfig section for this? I just realized
> > I can't find it. I was going to say "this commit log should explain
> > why/when this option is used", but then figured it might be explained in
> > the Kconfig ... but I couldn't find it. ;)
> 
> It's in lib/Kconfig.debug. But yes, I will add a commit message in v4.

Oh duh -- it's an existing option. Cool; I'm all good. :)

-- 
Kees Cook
