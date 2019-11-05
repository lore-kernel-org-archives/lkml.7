Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A458C5DF63
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E979F21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 19:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKETy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 14:54:57 -0500
Received: from foss.arm.com ([217.140.110.172]:58000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbfKETy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 14:54:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E02A7B9;
        Tue,  5 Nov 2019 11:54:56 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4523FBA1;
        Tue,  5 Nov 2019 01:15:53 -0800 (PST)
Date:   Tue, 5 Nov 2019 09:15:51 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 11/17] arm64: disable function graph tracing with SCS
Message-ID: <20191105091301.GB4743@lakrids.cambridge.arm.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com>
 <20191101221150.116536-12-samitolvanen@google.com>
 <20191104171132.GB2024@lakrids.cambridge.arm.com>
 <CABCJKufDnLjP9vA-wSW0gSY05Cbr=NOpJ-WCh-bdj2ZNq7VNXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufDnLjP9vA-wSW0gSY05Cbr=NOpJ-WCh-bdj2ZNq7VNXw@mail.gmail.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 03:44:39PM -0800, Sami Tolvanen wrote:
> On Mon, Nov 4, 2019 at 9:11 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > Can you please elaborate on _how_ this is incompatible in the commit
> > message?
> >
> > For example, it's not clear to me if you mean that's functionally
> > incompatible, or if you're trying to remove return-altering gadgets.
> >
> > If there's a functional incompatibility, please spell that out a bit
> > more clearly. Likewise if this is about minimizing the set of places
> > that can mess with control-flow outside of usual function conventions.
> 
> Sure, I'll add a better description in v5. In this case, the return
> address is modified in the kernel stack, which means the changes are
> ignored with SCS.

Ok, that makes sense to me. I'd suggest something like:

| The graph tracer hooks returns by modifying frame records on the
| (regular) stack, but with SCS the return address is taken from the
| shadow stack, and the value in the frame record has no effect. As we
| don't currently have a mechanism to determine the corresponding slot
| on the shadow stack (and to pass this through the ftrace
| infrastructure), for now let's disable the graph tracer when SCS is
| enabled.

... as I suspect with some rework of the trampoline and common ftrace
code we'd be able to correctly manipulate the shadow stack for this.
Similarly, if clang gained -fpatchable-funciton-etnry, we'd get that for
free.

Thanks,
Mark.
