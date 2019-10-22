Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8E7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50DC2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbfJVQuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:50:12 -0400
Received: from [217.140.110.172] ([217.140.110.172]:57528 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfJVQuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:50:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4F914AE;
        Tue, 22 Oct 2019 09:49:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEF0D3F71A;
        Tue, 22 Oct 2019 09:49:43 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:49:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20191022164936.GA1451@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com>
 <20191022162826.GC699@lakrids.cambridge.arm.com>
 <201910220929.ADF807CC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201910220929.ADF807CC@keescook>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:30:53AM -0700, Kees Cook wrote:
> On Tue, Oct 22, 2019 at 05:28:27PM +0100, Mark Rutland wrote:
> > On Fri, Oct 18, 2019 at 09:10:21AM -0700, Sami Tolvanen wrote:
> > > +ifdef CONFIG_SHADOW_CALL_STACK
> > > +KBUILD_CFLAGS	+= -fsanitize=shadow-call-stack
> > > +DISABLE_SCS	:= -fno-sanitize=shadow-call-stack
> > > +export DISABLE_SCS
> > > +endif
> > 
> > I think it would be preferable to follow the example of CC_FLAGS_FTRACE
> > so that this can be filtered out, e.g.
> > 
> > ifdef CONFIG_SHADOW_CALL_STACK
> > CFLAGS_SCS := -fsanitize=shadow-call-stack
>   ^^^ was this meant to be CC_FLAGS_SCS here
> 
> > KBUILD_CFLAGS += $(CFLAGS_SCS)
>                      ^^^ and here?

Whoops; yes in both cases...

> > export CC_FLAGS_SCS
> > endif
> > 
> > ... with removal being:
> > 
> > CFLAGS_REMOVE := $(CC_FLAGS_SCS)
> > 
> > ... or:
> > 
> > CFLAGS_REMOVE_obj.o := $(CC_FLAGS_SCS)
> > 
> > That way you only need to define the flags once, so the enable and
> > disable falgs remain in sync by construction.
            ^^^^^ "flags" here, too.

Mark.
