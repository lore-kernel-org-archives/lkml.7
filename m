Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236B4C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90E721EF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbfHGRIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:08:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbfHGRIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:08:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F3C0344;
        Wed,  7 Aug 2019 10:08:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01E8F3F575;
        Wed,  7 Aug 2019 10:08:19 -0700 (PDT)
Date:   Wed, 7 Aug 2019 18:08:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Jiping Ma <jiping.ma2@windriver.com>, mingo@redhat.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] tracing/arm: Fix the stack tracer when LR is saved
 after local storage
Message-ID: <20190807170814.GA45351@lakrids.cambridge.arm.com>
References: <20190807163401.570339297@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807163401.570339297@goodmis.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, Aug 07, 2019 at 12:34:01PM -0400, Steven Rostedt wrote:
> As arm64 saves the link register after a function's local variables are
> stored, it causes the max stack tracer to be off by one in its output
> of which function has the bloated stack frame.

For reference, it's a bit more complex than that. :/

Our procedure call standard (the AAPCS) says that the frame record may
be placed anywhere within a stackframe, so we don't have a guarantee as
to where the saved lr will fall w.r.t local variables.

Today, GCC happens to create the stack frame by creating the stack
record, so the LR is saved at a lower addresss than the local variables.

However, I am aware that there are reasons why a compiler may choose to
place the frame record at a different locations, e.g. using pointer
authentication to provide an implicit stack canary, so this could change
in future, or potentially differ across functions.

Maybe that's a bridge we'll have to cross in future.

Thanks,
Mark.

> 
> The first patch fixes this by creating a ARCH_RET_ADDR_BEFORE_LOCAL_VARS
> define that an achitecture (arm64) may set in asm/ftrace.h, and this
> will cause the stack tracer to make the shift.
> 
> As it has been proven that the stack tracer isn't the most trivial
> algorithm to understand by staring at the code, the second patch adds
> comments to the code to explain the algorithm with and without the
> ARCH_RET_ADDR_BEFORE_LOCAL_VARS.
> 
> Hmm, should this be sent to stable (and for inclusion now?)
> 
> -- Steve
> 
> Steven Rostedt (VMware) (2):
>       tracing/arm64: Have max stack tracer handle the case of return address after data
>       tracing: Document the stack trace algorithm in the comments
> 
> ----
>  arch/arm64/include/asm/ftrace.h |   1 +
>  kernel/trace/trace_stack.c      | 112 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 113 insertions(+)
