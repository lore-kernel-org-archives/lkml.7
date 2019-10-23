Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E084CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2650205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EwGPq/cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407919AbfJWWg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:36:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38374 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405969AbfJWWg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:36:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id c13so2602739pfp.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZjdRCAqHwopvUhYs+mVO9ncWRfdiV1bxqckqLPody4c=;
        b=EwGPq/csRkQ+jf3nLutkbcUaezilkG787Ds4iu0E5FMWUZXackpLHgi5LhYR33rtQp
         0QN8hrfPdZkLUgZa3mF3QH6Hyp9LX+xj5RxuAcodMyCmyxXJgdSe3VWbIn3ZIJdEtAtV
         ANIEpIrdLrCl883AMuPXlPttlvwUlo6jGHM2VceqBM+4pwUad6AZKy3dKl/UQ9EXmojJ
         oVpUb/cqRJbeN8i6W51ISaID02QJtJ6e8WoRg7xGOvXelrXzetaebDwZ3fKSkoD2Q75U
         941sEhdhDbrjh+2Leai9Dtj06SE4X7nJ3wOCxjAsDa7Bnhfa3Ru0Vzbq9qeYqb03Q3RY
         3hUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjdRCAqHwopvUhYs+mVO9ncWRfdiV1bxqckqLPody4c=;
        b=pYPlrgTdgY1/VcS0O+/AAx9RTOQ6QP8DWZmMqcbEJD7xK8p2q7GKMu+shmaFaGyi00
         dJELOL22ofL/WG/2aGlCpkUgnllrODS2n7rNE+dA0cT/0UUwsWWLcKY9qYXsgBeXehqd
         3Oy7HxFQ0dYDBdIZHK8yiATEAynkAfyT6QWBPSQwNUXpQRMc4xwZdzqKGnwl8imWXYs+
         J1rfVqkg34/uNyo3Xrg3rqxLdAKf//w92z8vj3SMvvysXj6ZBICwfCySC7NU/LFFCxG/
         YcXdHzK3V31SMAUFDXbFQQfZPxo2K9lJ0vD1OEHpQkUa7jZ8CS+L7DG/yf4xUHpADbMn
         GZsQ==
X-Gm-Message-State: APjAAAV9Y5rB78W6dbmjMG8YoEMQnab0IoPNAYzz0JKoDCtSAROmuFRK
        Spr7XiDhFpavRPw6x22NvFUJQwRT
X-Google-Smtp-Source: APXvYqz7l2zv0nWR4DqI5mcXUZGjncMOckmZrZrTF6Y27c7orUbMtdE54A+4vtaIw2cOwCa7PZRPRQ==
X-Received: by 2002:a63:a54a:: with SMTP id r10mr12641723pgu.277.1571870217735;
        Wed, 23 Oct 2019 15:36:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::bd2d])
        by smtp.gmail.com with ESMTPSA id i22sm3443387pfa.82.2019.10.23.15.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 15:36:56 -0700 (PDT)
Date:   Wed, 23 Oct 2019 15:36:54 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] x86/ftrace: Use text_poke()
Message-ID: <20191023223652.aemv225jvx5yhocc@ast-mbp.dhcp.thefacebook.com>
References: <20191022071956.07e21543@gandalf.local.home>
 <20191022094455.6a0a1a27@gandalf.local.home>
 <20191022175052.frjzlnjjfwwfov64@ast-mbp.dhcp.thefacebook.com>
 <20191022141021.2c4496c2@gandalf.local.home>
 <20191022204620.jp535nfvfubjngzd@ast-mbp.dhcp.thefacebook.com>
 <20191022170430.6af3b360@gandalf.local.home>
 <20191022215841.2qsmhd6vxi4mwade@ast-mbp.dhcp.thefacebook.com>
 <20191023122307.756b4978@gandalf.local.home>
 <20191023193442.35lhhrqnyn3bfwpq@ast-mbp.dhcp.thefacebook.com>
 <20191023160852.0606bc68@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023160852.0606bc68@gandalf.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 04:08:52PM -0400, Steven Rostedt wrote:
> > 
> > It seems to me that it's a bit of overkill to add new config knob
> > for every ftrace feature.
> > HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS (that arch defined) would
> > be enough to check and return error in register_ftrace_direct()
> > right?
> 
> IIRC, we started doing this because it allows the dependencies to be
> defined in the kernel/trace directory. That is, if
> CONFIG_DYNAMIC_FATRCE_WITH_DIRECT_CALLS is set, then we know that
> direct calls *and* DYNAMIC_FTRACE is enabled. It cuts down on some of
> the more complex #if or the arch needing to do
> 
>  select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS if DYNAMIC_FTRACE
> 
> It may be overkill, but it does keep the pain in one place.

Ok.
could you please add
static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
{
        return -ENOTSUPP;
}
when appropriate configs are not enabled?
The current approach of:
#define register_ftrace_function(ops) ({ 0; })
doesn't look right, since users are being mislead that it's a success.

> > > +struct ftrace_ops direct_ops = {
> > > +	.func		= call_direct_funcs,
> > > +	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
> > > +#if 1
> > > +					| FTRACE_OPS_FL_DIRECT
> > > +#endif
> > > +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY
> > > +					| FTRACE_OPS_FL_SAVE_REGS
> > > +#endif  
> > 
> > With FL_DIRECT the CONFIG_DYNAMIC_FTRACE_WITH_IPMODIFY_ONLY won't be needed, right ?
> > At least not for bpf use case.
> > Do you see livepatching using it or switching to FL_DIRECT too?
> 
> Correct. I talked with Josh on IRC and we are looking into removing the
> pushf/popf from the ftrace_regs_caller to see if that helps in the
> performance for live patching. I'm also currently working on making
> this patch not on top of the IP modify one, so the IP modify doesn't
> need to be applied.
> 
> This also cleans up the asm code a bit more (getting rid of the macro).

awesome.

> > 
> > I have one more question/request.
> > Looks like ftrace can be turned off with sysctl.
> > Which means that a person or a script can accidently turn it off
> > and all existing kprobe+bpf stuff that is ftrace based will
> > be silently switched off.
> 
> See http://lkml.kernel.org/r/20191016113316.13415-1-mbenes@suse.cz
> 
> I can (and should) add the PERMANENT flag to the direct_ops.
> 
> Note, the PERMANENT patches will be added before this one.

Ahh. Perfect. That works.
I was wondering whether livepatching should care...
clearly they are :)

> > Fast forward a year and imagine few host critical bpf progs
> > are running in production and relying on FL_DIRECT.
> > Now somebody decided to test new ftrace feature and
> > it hit one of FTRACE_WARN_ON().
> > That will shutdown the whole ftrace and bpf progs
> > will stop executing. I'd like to avoid that.
> > May be I misread the code?
> 
> It basically freezes it. Current registered ftrace_ops will not be
> touched. But nothing can be removed or added.

got it. that makes sense.

> 
> OK, I'll work to get this patch in for the next merge window.

As soon as you do first round of cleanups please ping me with the link
to your latest branch. I'll start building on top in the mean time.
Thanks!

