Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366B3CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DB320684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbfJVPbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:31:03 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55422 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1732202AbfJVPbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:31:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA786176B;
        Tue, 22 Oct 2019 08:30:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFBAE3F71A;
        Tue, 22 Oct 2019 08:30:37 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:30:35 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, ard.biesheuvel@linaro.org,
        catalin.marinas@arm.com, deller@gmx.de, duwe@suse.de,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, mingo@redhat.com, peterz@infradead.org,
        svens@stackframe.org, takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCH 1/8] ftrace: add ftrace_init_nop()
Message-ID: <20191022153035.GB52920@lakrids.cambridge.arm.com>
References: <20191021163426.9408-1-mark.rutland@arm.com>
 <20191021163426.9408-2-mark.rutland@arm.com>
 <20191021140756.613a1bac@gandalf.local.home>
 <20191022112811.GA11583@lakrids.cambridge.arm.com>
 <20191022085428.75cfaad6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022085428.75cfaad6@gandalf.local.home>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 08:54:28AM -0400, Steven Rostedt wrote:
> On Tue, 22 Oct 2019 12:28:11 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> > > To make the name even better, let's just rename it to:
> > > 
> > >  ftrace_nop_initialization()
> > > 
> > > I think that may be the best description for it.  
> > 
> > Perhaps ftrace_nop_initialize(), so that it's not a noun?
> > 
> > I've made it ftrace_nop_initialization() in my branch for now.
> 
> I'm fine with ftrace_nop_initialize().

It's settled, then. :)

[...]

> > | /**
> > |  * ftrace_init_nop - initialize a nop call site
> > |  * @mod: module structure if called by module load initialization
> > |  * @rec: the mcount call site record
> 
> Perhaps say "mcount/fentry"

This is the exact wording that ftrace_make_nop and ftrace_modify_call
have. For consistency, I think those should all match.

I can add " (e.g. mcount/fentry)" to all of those if you'd like?

... or leave them all as-is?

> > |  *
> > |  * This is a very sensitive operation and great care needs
> > |  * to be taken by the arch.  The operation should carefully
> > |  * read the location, check to see if what is read is indeed
> > |  * what we expect it to be, and then on success of the compare,
> > |  * it should write to the location.
> > |  *
> > |  * The code segment at @rec->ip should be as initialized by the
> 
> "should be as" is a bit confusing. What about?
> 
>  "The code segment at @rec->ip should contain the contents created by
>   the compiler".

Works for me.

Mark.
