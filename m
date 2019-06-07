Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6409C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBB7208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbfFGTcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:32:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729081AbfFGTcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:32:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8E5322388B;
        Fri,  7 Jun 2019 19:32:39 +0000 (UTC)
Received: from treble (ovpn-112-76.rdu2.redhat.com [10.10.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0D5C51C37;
        Fri,  7 Jun 2019 19:32:20 +0000 (UTC)
Date:   Fri, 7 Jun 2019 15:32:15 -0400
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 05/15] x86_32: Provide consistent pt_regs
Message-ID: <20190607193215.qw5xo2cdajhihk2x@treble>
References: <20190605130753.327195108@infradead.org>
 <20190605131944.829537410@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190605131944.829537410@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 07 Jun 2019 19:32:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 03:07:58PM +0200, Peter Zijlstra wrote:
> Currently pt_regs on x86_32 has an oddity in that kernel regs
> (!user_mode(regs)) are short two entries (esp/ss). This means that any
> code trying to use them (typically: regs->sp) needs to jump through
> some unfortunate hoops.
> 
> Change the entry code to fix this up and create a full pt_regs frame.
> 
> This then simplifies various trampolines in ftrace and kprobes, the
> stack unwinder, ptrace, kdump and kgdb.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> ---
>  arch/x86/entry/entry_32.S         |  105 ++++++++++++++++++++++++++++++++++----
>  arch/x86/include/asm/kexec.h      |   17 ------
>  arch/x86/include/asm/ptrace.h     |   17 ------
>  arch/x86/include/asm/stacktrace.h |    2 
>  arch/x86/kernel/crash.c           |    8 --
>  arch/x86/kernel/ftrace_32.S       |   77 +++++++++++++++------------
>  arch/x86/kernel/kgdb.c            |    8 --
>  arch/x86/kernel/kprobes/common.h  |    4 -
>  arch/x86/kernel/kprobes/core.c    |   29 ++++------
>  arch/x86/kernel/kprobes/opt.c     |   20 ++++---
>  arch/x86/kernel/process_32.c      |   16 +----
>  arch/x86/kernel/ptrace.c          |   29 ----------
>  arch/x86/kernel/time.c            |    3 -
>  arch/x86/kernel/unwind_frame.c    |   32 +----------
>  arch/x86/kernel/unwind_orc.c      |    2 
>  15 files changed, 178 insertions(+), 191 deletions(-)

I recall writing some of this code (some of the kernel_stack_pointer
removal stuff) so please give me a shout-out ;-)

Otherwise:

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
