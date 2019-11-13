Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766D02245D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 15:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfKMPKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 10:10:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:42064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727743AbfKMPKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 10:10:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59C90B2DB;
        Wed, 13 Nov 2019 15:10:37 +0000 (UTC)
Date:   Wed, 13 Nov 2019 16:10:36 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 00/10] ftrace: Add register_ftrace_direct()
In-Reply-To: <20191108212834.594904349@goodmis.org>
Message-ID: <alpine.LSU.2.21.1911131604170.18679@pobox.suse.cz>
References: <20191108212834.594904349@goodmis.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Nov 2019, Steven Rostedt wrote:

> 
> Alexei mentioned that he would like a way to access the ftrace fentry
> code to jump directly to a custom eBPF trampoline instead of using
> ftrace regs caller, as he said it would be faster.
> 
> I proposed a new register_ftrace_direct() function that would allow
> this to happen and still work with the ftrace infrastructure. I posted
> a proof of concept patch here:
> 
>  https://lore.kernel.org/r/20191023122307.756b4978@gandalf.local.home
> 
> This patch series is a more complete version, and the start of the
> actual implementation. I haven't run it through my full test suite but
> it passes my smoke tests and some other custom tests I built.
> 
> I also realized that I need to make the sample modules depend on X86_64
> as it has inlined assembly in it that requires that dependency.
> 
> This is based on 5.4-rc6 plus the permanent patches that prevent
> a ftrace_ops from being disabled by /proc/sys/kernel/ftrace_enabled
> 
> Below is the tree that contains this code.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
> ftrace/direct
> 
> Head SHA1: 9492654d091cb90a487ca669c58f802fa99bcd6f
> 
> Enjoy,
> 
> -- Steve

So I tried to run the selftests and ran into the same timeout issue we had 
with live patching :/

See http://lkml.kernel.org/r/20191025115041.23186-1-mbenes@suse.cz for a possible solution.

Miroslav
