Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0701C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15A21850
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfGCNum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:50:42 -0400
Received: from foss.arm.com ([217.140.110.172]:48496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfGCNum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:50:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 789612B;
        Wed,  3 Jul 2019 06:50:41 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 739C93F718;
        Wed,  3 Jul 2019 06:50:40 -0700 (PDT)
Date:   Wed, 3 Jul 2019 14:50:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 12/16] kprobes: Initialize kprobes at
 postcore_initcall
Message-ID: <20190703135037.GC48312@arrakis.emea.arm.com>
References: <20190526191828.466305460@goodmis.org>
 <20190526191848.266163206@goodmis.org>
 <20190702165008.GC34718@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702165008.GC34718@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 05:50:09PM +0100, Mark Rutland wrote:
> On Sun, May 26, 2019 at 03:18:40PM -0400, Steven Rostedt wrote:
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Initialize kprobes at postcore_initcall level instead of module_init
> > since kprobes is not a module, and it depends on only subsystems
> > initialized in core_initcall.
> > This will allow ftrace kprobe event to add new events when it is
> > initializing because ftrace kprobe event is initialized at
> > later initcall level.
> > 
> > Link: http://lkml.kernel.org/r/155851394736.15728.13626739508905120098.stgit@devnote2
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  kernel/kprobes.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index b1ea30a5540e..54aaaad00a47 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2289,6 +2289,7 @@ static int __init init_kprobes(void)
> >  		init_test_probes();
> >  	return err;
> >  }
> > +postcore_initcall(init_kprobes);
> 
> As a heads-up, this is causing boot-time failures on arm64.
> 
> On arm64 kprobes depends on the BRK handler we register in
> debug_traps_init(), which is an arch_initcall.
> 
> As of this change, init_krprobes() calls init_test_probes() before
> that's registered, so we end up hitting a BRK before we can handle it.

Thanks Mark for identifying this.

So we either revert the above commit in -next or queue the one below
together with the rest of the kprobes changes (I can queue it via the
arm64 for-next/core assuming that the above commit id remains stable):

--------------8<------------------------------------
From de4f4d30bab3d77d6643a6fa9ba1deff73dac7f2 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 3 Jul 2019 14:44:23 +0100
Subject: [PATCH] arm64: Initialise the debug traps earlier

Commit b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
makes init_kprobes() a postcore_initcall while the arm64 handling of the
BRK instruction is initialised at arch_initcall level. Make the arm64
debug_traps_init() a core_initcall.

Fixes: b5f8b32c93b2 ("kprobes: Initialize kprobes at postcore_initcall")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index f8719bd30850..81770105cd8e 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -382,7 +382,7 @@ static int __init debug_traps_init(void)
 			      TRAP_BRKPT, "ptrace BRK handler");
 	return 0;
 }
-arch_initcall(debug_traps_init);
+core_initcall(debug_traps_init);
 
 /* Re-enable single step for syscall restarting. */
 void user_rewind_single_step(struct task_struct *task)
