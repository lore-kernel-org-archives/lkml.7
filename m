Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203E3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB14B206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732818AbfJVXVf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfJVXVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:21:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93AE206C2;
        Tue, 22 Oct 2019 23:21:33 +0000 (UTC)
Date:   Tue, 22 Oct 2019 19:21:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022192132.22cc15b5@gandalf.local.home>
In-Reply-To: <7364B113-DD65-423D-BED3-FF90C4DF8334@amacapital.net>
References: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
        <7364B113-DD65-423D-BED3-FF90C4DF8334@amacapital.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 15:45:26 -0700
Andy Lutomirski <luto@amacapital.net> wrote:

> >> On Oct 22, 2019, at 2:58 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >> 
> >> ﻿On Tue, Oct 22, 2019 at 05:04:30PM -0400, Steven Rostedt wrote:
> >> I gave a solution for this. And that is to add another flag to allow
> >> for just the minimum to change the ip. And we can even add another flag
> >> to allow for changing the stack if needed (to emulate a call with the
> >> same parameters).  
> > 
> > your solution is to reduce the overhead.
> > my solution is to remove it competely. See the difference?
> >   
> >> By doing this work, live kernel patching will also benefit. Because it
> >> is also dealing with the unnecessary overhead of saving regs.
> >> And we could possibly even have kprobes benefit from this if a kprobe
> >> doesn't need full regs.  
> > 
> > Neither of two statements are true. The per-function generated trampoline
> > I'm talking about is bpf specific. For a function with two arguments it's just:
> > push rbp 
> > mov rbp, rsp
> > push rdi
> > push rsi
> > lea  rdi,[rbp-0x10]
> > call jited_bpf_prog
> > pop rsi
> > pop rdi
> > leave
> > ret  
> 
> Why are you saving rsi?  You said upthread that you’re saving the
> args, but rsi is already available in rsi.

The above is for two parameters, and is being called before the
function with those two parameters. The jited_bpf_prog will be called
with those two parameters as well, but it may also clobber them. Then
we need to restore those two parameters before calling the original
function.

> 
> Just how custom is this bpf program?  It seems to clobber no regs
> (except args), and it doesn’t return anything. Is it entirely
> specific to the probed function?  If so, why not just call it
> directly?

It's injecting the jited_bpf_prog to be called when the probed function
is called, with the same parameters as the probed function.

my_probed_function
  call trampoline


trampoline
  save parameters
  call jited_bpf_prog (with same parameters)
  restore paremeters
  ret

Jumps back to the my_probed_function, where my_probed_function is
clueless it was just interrupted.

No need to save any clobbered registers but the parameters, as the
jited_bpf_prog needs to save any registers that it clobbers just like
the my_probed_function saves its.

-- Steve
