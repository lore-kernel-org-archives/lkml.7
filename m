Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA351CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04072084C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733297AbfJVWRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:17:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfJVWRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:17:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB0920700;
        Tue, 22 Oct 2019 22:17:41 +0000 (UTC)
Date:   Tue, 22 Oct 2019 18:17:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191022181740.5a2893a6@gandalf.local.home>
In-Reply-To: <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
References: <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
        <20191021231630.49805757@oasis.local.home>
        <20191021231904.4b968dc1@oasis.local.home>
        <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
        <20191022071956.07e21543@gandalf.local.home>
        <20191022094455.6a0a1a27@gandalf.local.home>
        <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
        <20191022141021.2c4496c2@gandalf.local.home>
        <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
        <20191022170430.6af3b360@gandalf.local.home>
        <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 14:58:43 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Tue, Oct 22, 2019 at 05:04:30PM -0400, Steven Rostedt wrote:
> > 
> > I gave a solution for this. And that is to add another flag to allow
> > for just the minimum to change the ip. And we can even add another flag
> > to allow for changing the stack if needed (to emulate a call with the
> > same parameters).  
> 
> your solution is to reduce the overhead.
> my solution is to remove it competely. See the difference?

You're just trimming it down. I'm curious to what overhead you save by
not saving all parameter registers, and doing a case by case basis?

> 
> > By doing this work, live kernel patching will also benefit. Because it
> > is also dealing with the unnecessary overhead of saving regs.
> > 
> > And we could possibly even have kprobes benefit from this if a kprobe
> > doesn't need full regs.  
> 
> Neither of two statements are true. The per-function generated trampoline
> I'm talking about is bpf specific. For a function with two arguments it's just:
> push rbp 
> mov rbp, rsp
> push rdi
> push rsi
> lea  rdi,[rbp-0x10]
> call jited_bpf_prog

What exactly does the jited_bpf_prog do? Does it modify context?
or is it for monitoring only.

Do only GPL BPF programs get this access?

> pop rsi
> pop rdi
> leave
> ret
> 
> fentry's nop is replaced with call to the above.
> That's it.
> kprobe and live patching has no use out of it.
> 
> > But you said that you can't have this and trace the functions at the
> > same time. Which also means you can't do live kernel patching on these
> > functions either.  
> 
> I don't think it's a real use case, but to avoid further arguing
> I'll add one nop to the front of generated bpf trampoline so that
> ftrace and livepatch can use it.

And how does this nop get accounted for? It needs to update the ftrace
dyn_ftrace array that stores all the function locations.

-- Steve
