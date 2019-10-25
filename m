Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E70CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEB021D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfJYBnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfJYBnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:43:03 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF3721D7F;
        Fri, 25 Oct 2019 01:43:01 +0000 (UTC)
Date:   Thu, 24 Oct 2019 21:42:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 16/17] arm64: disable SCS for hypervisor code
Message-ID: <20191024214259.1b37535c@gandalf.local.home>
In-Reply-To: <CAK7LNATPpL-B0APPXFcWPCR6ZTSrXv-v_ZkdFqjKJ4pwUpcWug@mail.gmail.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
        <20191024225132.13410-1-samitolvanen@google.com>
        <20191024225132.13410-17-samitolvanen@google.com>
        <CAK7LNATPpL-B0APPXFcWPCR6ZTSrXv-v_ZkdFqjKJ4pwUpcWug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019 10:29:47 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> On Fri, Oct 25, 2019 at 7:52 AM <samitolvanen@google.com> wrote:
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  arch/arm64/kvm/hyp/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
> > index ea710f674cb6..8289ea086e5e 100644
> > --- a/arch/arm64/kvm/hyp/Makefile
> > +++ b/arch/arm64/kvm/hyp/Makefile
> > @@ -28,3 +28,6 @@ GCOV_PROFILE  := n
> >  KASAN_SANITIZE := n
> >  UBSAN_SANITIZE := n
> >  KCOV_INSTRUMENT        := n
> > +
> > +ORIG_CFLAGS := $(KBUILD_CFLAGS)
> > +KBUILD_CFLAGS = $(subst $(CC_FLAGS_SCS),,$(ORIG_CFLAGS))  
> 
> 
> $(subst ... ) is not the correct use here.
> 
> It works like sed,   s/$(CC_CFLAGS_SCS)//
> instead of matching by word.
> 
> 
> 
> 
> KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> 
> is more correct, and simpler.

I guess that would work too. Not sure why I never used it. I see mips
used it for their -pg flags.

-- Steve
