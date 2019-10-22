Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F10FCA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1D3214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce8qhSkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfJVEFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:05:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43850 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJVEFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:05:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id l24so4180897pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7H7oS9uZ4RqE+ev8IbwpC4ifmzWH95PpY6hOwogB3YE=;
        b=Ce8qhSkGY+lO0utzyex5YJ5uY4CRmwdq7hZwdB6R2BxVrAeF30SbajJmDCSeNW9AJb
         QZ5hx8Wty8kE79XEgJF8vC3s0YKH4KQWupEFFWdiYsNzIJYmyeGg2TzgNE02YN/Ns4OE
         Qpl8z2NIBQPMXw81r4tI+g8WeBKBTu8cjFDM/K2hw9Hce4FPZec9wL9xUjlDDStvcES8
         UKKWSiLHXaFuCFrSR8tTW86eTmCGYOlyi75PxmahS1T8CkntabayK9fVWkLuB6Gfv7H/
         mmLBfn43zvHdZB9+lQMHpwaoCWMEqZlpl+aItrSBl11bsHC9Zhfiu2g9FhRYAE4PVEUQ
         63lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7H7oS9uZ4RqE+ev8IbwpC4ifmzWH95PpY6hOwogB3YE=;
        b=OoxkqgK5OMgGlm6qcQpeETI2W63qFRDhGlv+fBeiZ4LzRF640DFa5vemSnwSJt+2zr
         Wm3uQuzTc8X3JMxyW31P3hNhQ0FddB96LwKYxXMuD0RQHLUGEfJuZ0rlVMH31RWnSjyJ
         rcAepZIRNowsA1VJLMfIbWbXm1LEFcbgdFSa9YcIjwi6fJayCf27XJqQtfsyvBrB9AU3
         hkHOuOal026vOShrQAqCNE0exya4T1IeHy7oAgh8rLsRAHevJPJAF1f2ZHKcx8OddPRD
         HxkywaS34xUjE426epUKCuuuJfrat4Xr/X5LUSGVNaKD7MtasflLQJ9CPX+IuQNxtGAL
         TWgw==
X-Gm-Message-State: APjAAAViPnSxM/RNRj3S5wmTny8wCzfbCCOslt2biIWMbVNtysNX22jC
        mF/AARwC6TWNcsk3Y1fxUV2v3qDg
X-Google-Smtp-Source: APXvYqyCTaMk3XZZpM1ZzEqC8udJzV3Obiz5OgWqU+9f/2dg5BbAC/Qnu0KwxI9nAFGsMiA72wwleQ==
X-Received: by 2002:a63:cb4f:: with SMTP id m15mr1472240pgi.325.1571717136164;
        Mon, 21 Oct 2019 21:05:36 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::5ac])
        by smtp.gmail.com with ESMTPSA id d5sm21511541pfa.180.2019.10.21.21.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 21:05:35 -0700 (PDT)
Date:   Mon, 21 Oct 2019 21:05:33 -0700
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
Message-ID: <20191022040532.fvpxcs74i4mn4rc6@ast-mbp.dhcp.thefacebook.com>
References: <aaffb32f-6ca9-f9e3-9b1a-627125c563ed@redhat.com>
 <20191002182106.GC4643@worktop.programming.kicks-ass.net>
 <20191003181045.7fb1a5b3@gandalf.local.home>
 <20191004112237.GA19463@hirez.programming.kicks-ass.net>
 <20191004094228.5a5774fe@gandalf.local.home>
 <CAADnVQJ0cWYPY-+FhZoqUZ8p1k1FiDsO5jhXiQdcCPmd1UeCyQ@mail.gmail.com>
 <20191021204310.3c26f730@oasis.local.home>
 <CAADnVQLn+Fh-UgSRD9SZCT7WYOez5De04iCZucYbA9mYxPm2AQ@mail.gmail.com>
 <20191021231630.49805757@oasis.local.home>
 <20191021231904.4b968dc1@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021231904.4b968dc1@oasis.local.home>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 11:19:04PM -0400, Steven Rostedt wrote:
> On Mon, 21 Oct 2019 23:16:30 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > what bugs you're seeing?
> > > The IPI frequency that was mentioned in this thread or something else?
> > > I'm hacking ftrace+bpf stuff in the same spot and would like to
> > > base my work on the latest and greatest.  
> 
> I'm also going to be touching some of this code too, as I'm waiting for
> Peter's code to settle down. What are you touching? I'm going to be
> working on making the dyn_ftrace records smaller, and this is going to
> change the way the iterations work on modifying the code.

I'm not touching dyn_ftrace.
Actually calling my stuff ftrace+bpf is probably not correct either.
I'm reusing code patching of nop into call that ftrace does. That's it.
Turned out I cannot use 99% of ftrace facilities.
ftrace_caller, ftrace_call, ftrace_ops_list_func and the whole ftrace api
with ip, parent_ip and pt_regs cannot be used for this part of the work.
bpf prog needs to access raw function arguments. To achieve that I'm
generating code on the fly. Just like bpf jits do.
As soon as I have something reviewable I'll share it.
That's the stuff I mentioned to you at KR.
First nop of a function will be replaced with a call into bpf.
Very similar to what existing kprobe+bpf does, but faster and safer.
Second part of calling real ftrace from bpf is on todo list.

