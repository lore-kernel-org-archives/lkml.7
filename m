Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C8C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8782071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKNS3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:29:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:41030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbfKNS3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:29:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E9FB206F0;
        Thu, 14 Nov 2019 18:29:44 +0000 (UTC)
Date:   Thu, 14 Nov 2019 13:29:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 03/10] ftrace: Add register_ftrace_direct()
Message-ID: <20191114132942.2adc7aa2@gandalf.local.home>
In-Reply-To: <20191109073310.6a7a16f2@gandalf.local.home>
References: <20191108212834.594904349@goodmis.org>
        <20191108213450.032003836@goodmis.org>
        <20191109022907.6zzo6orhxpt5n2sv@ast-mbp.dhcp.thefacebook.com>
        <20191109073310.6a7a16f2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Nov 2019 07:33:10 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 8 Nov 2019 18:29:09 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > Is there a way to do a replacement of direct call?  
> 
> I'm curious to what the use case would be. The direct call added would
> still need to be a trampoline, as the parameters need to be saved
> before calling any other code, and then restored before going back to
> the traced function. Couldn't you do a text poke on that trampoline to
> change what gets called?
> 
> > If I use unregister(old)+register(new) some events will be missed.  
> 
> > If I use register(new)+unregister(old) for short period of time both new and  
> 
> Actually, as we only allow a single direct call to be added at any time,
> the register(new) would fail if there was already an old at the
> location.
> 
> > old will be triggering on all cpus which will likely confuse bpf tracing.
> > Something like modify_ftrace_direct() should solve it. It's still racy. In a
> > sense that some cpus will be executing old while other cpus will be executing
> > new, but per-cpu there will be no double accounting. How difficult would be
> > to add such feature?  
> 
> All this said, it would actually be pretty trivial to implement this,
> as when another ftrace_ops is attached to the direct call location, it
> falls back to the direct helper. To implement a modify_ftrace_direct(),
> all that would be needed to do is to:
> 
> 1) Attached a ftrace_ops stub to the same function that has the direct
> caller, that will cause ftrace to got to the loop routine, and the
> direct helper would then define what gets called by what what
> registered in the direct_functions array.
> 
> 2) Change what gets called in the direct_functions array, and at that
> moment, the helper function would be using that. May require syncing
> CPUs to get all CPUs seeing the same thing.
> 
> 3) Remove the ftrace_ops stub, which would put back the direct caller
> in the fentry location, but this time with the new function.
>

Alexei,

Do you still need such a feature?

Note, I just pushed my tree to my for-next tree, and also have a
ftrace/direct branch that ends with this patch set that is the basis of
the rest of the work of my code. Feel free to build against that
branch if you need to have something built on the net tree.

-- Steve
